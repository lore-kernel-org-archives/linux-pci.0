Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] arm64: Do not expose PCI mmap through procfs
Date: Wed, 22 Mar 2017 13:25:31 +0000
Message-Id: <4281f8e01b9fc5628cbf4a5c77abd642801e23c7.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/pci/proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 2d9cfa4..a940f4b 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -17,6 +17,11 @@
 
 static int proc_initialized;	/* = 0 */
 
+#ifdef __aarch64__
+/* ARM64 wants to be special and not expose this through /proc like everyone else */
+#undef HAVE_PCI_MMAP
+#endif
+
 static loff_t proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
-- 
2.9.3
