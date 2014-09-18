Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<tglx@linutronix.de>, <hpa@zytor.com>, <x86@kernel.org>,
	<bp@suse.de>, <dan.carpenter@oracle.com>,
	<dougthompson@xmission.com>, <bp@alien8.de>,
	<m.chehab@samsung.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Subject: [PATCH 3/4] edac: Add DDR3 LRDIMM support, entries in edac_mem_types[]
Date: Thu, 18 Sep 2014 14:56:58 -0500
Message-ID: <1411070218-10258-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

F15hM60h adds support for DDR4 and DDR3 LRDIMMS. Adding them here.

Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
---
 drivers/edac/edac_mc.c | 3 +++
 include/linux/edac.h   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 9f134823..71fd9fb 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -146,6 +146,9 @@ const char *edac_mem_types[] = {
 	"Rambus XDR",
 	"Unbuffered DDR3 RAM",
 	"Registered DDR3 RAM",
+	"Load-Reduce DDR3 RAM",
+	"Unbuffered DDR4 RAM",
+	"Registered DDR4 RAM",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index e1e68da..7a80100 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -194,6 +194,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_DDR3:		DDR3 RAM
  * @MEM_RDDR3:		Registered DDR3 RAM
  *			This is a variant of the DDR3 memories.
+ * @MEM_LRDDR3		Load-Reduce DDR3 memory
  * @MEM_DDR4:		DDR4 RAM
  * @MEM_RDDR4:		Registered DDR4 RAM
  *			This is a variant of the DDR4 memories.
@@ -216,6 +217,7 @@ enum mem_type {
 	MEM_XDR,
 	MEM_DDR3,
 	MEM_RDDR3,
+	MEM_LRDDR3,
 	MEM_DDR4,
 	MEM_RDDR4,
 };
-- 
2.0.2

