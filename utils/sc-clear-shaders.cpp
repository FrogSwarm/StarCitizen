#include <windows.h>

void DeleteDirectory(const wchar_t* path) {
    SHFILEOPSTRUCT fileOp;
    ZeroMemory(&fileOp, sizeof(fileOp));
    fileOp.wFunc = FO_DELETE;
    fileOp.pFrom = path;
    fileOp.fFlags = FOF_SILENT | FOF_NOCONFIRMATION | FOF_NOERRORUI | FOF_NORECURSION;

    int result = SHFileOperation(&fileOp);

    if (result == 0) {
        wprintf(L"Star Citizen Shaders directory deleted.\n");
    } else {
        wprintf(L"Error deleting %ls. Code : %d\n", path, result);
    }
}

int main() {
    wchar_t directoryPath[MAX_PATH];
    if (ExpandEnvironmentStringsW(L"%LOCALAPPDATA%\\StarCitizen", directoryPath, MAX_PATH) != 0) {
        DeleteDirectory(directoryPath);
    } else {
        wprintf(L"Error expanding environment variable.\n");
    }

    return 0;
}
