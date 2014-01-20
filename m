Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masanari Iida <standby24x7@gmail.com>
To: linux-kernel@vger.kernel.org, trivial@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: agordeev@redhat.com, Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH][trivial] pci: Fix make htmldocs failure caused by msi.c 
Date: Tue, 21 Jan 2014 00:42:55 +0900
Message-Id: <1390232575-4284-1-git-send-email-standby24x7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

An empty line in msi.c caused "make htmldocs" failure.
Warning(/home/iida/Repo/linux-next//drivers/pci/msi.c:962): bad line:
Remove the empty line fixed the issue.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>

---
 drivers/pci/msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a0fec6..a9d5176 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -959,7 +959,6 @@ EXPORT_SYMBOL(pci_disable_msi);
 /**
  * pci_msix_vec_count - return the number of device's MSI-X table entries
  * @dev: pointer to the pci_dev data structure of MSI-X device function
-
  * This function returns the number of device's MSI-X table entries and
  * therefore the number of MSI-X vectors device is capable of sending.
  * It returns a negative errno if the device is not capable of sending MSI-X
-- 
1.9.rc0

