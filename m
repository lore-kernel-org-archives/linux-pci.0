Return-Path: <SRS0=5bYc=JH=flex--rajatja.bounces.google.com=3WDksWwcKB1sK3C3MC39HH9E7.5HFA7E933LD7KG7E.HK9@kernel.org>
Return-Path: <SRS0=5bYc=JH=flex--rajatja.bounces.google.com=3WDksWwcKB1sK3C3MC39HH9E7.5HFA7E933LD7KG7E.HK9@kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Jun 2018 16:48:26 -0700
In-Reply-To: <20180621234829.224566-1-rajatja@google.com>
Message-Id: <20180621234829.224566-2-rajatja@google.com>
References: <20180621234829.224566-1-rajatja@google.com>
Subject: [PATCH 1/4] PCI: Move pci_aer_init() and pci_no_aer() declarations to drivers/pci/pci.h
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com, helgaas@kernel.org
Cc: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Since these functions are unsed only internally, move them to the PCI
internal header file. Also, no one cares about return value of
pci_aer_init(), so make it void.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci.h      | 8 ++++++++
 drivers/pci/pcie/aer.c | 4 ++--
 include/linux/pci.h    | 4 ----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a07f3f..9a1af85aca77 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -452,4 +452,12 @@ static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_PCIEAER
+void pci_no_aer(void);
+void pci_aer_init(struct pci_dev *dev);
+#else
+static inline void pci_no_aer(void) { }
+static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..11482669b93b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -402,10 +402,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
-int pci_aer_init(struct pci_dev *dev)
+void pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-	return pci_cleanup_aer_error_status_regs(dev);
+	pci_cleanup_aer_error_status_regs(dev);
 }
 
 #define AER_AGENT_RECEIVER		0
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..b4ffea05c999 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1468,13 +1468,9 @@ static inline bool pcie_aspm_support_enabled(void) { return false; }
 #endif
 
 #ifdef CONFIG_PCIEAER
-void pci_no_aer(void);
 bool pci_aer_available(void);
-int pci_aer_init(struct pci_dev *dev);
 #else
-static inline void pci_no_aer(void) { }
 static inline bool pci_aer_available(void) { return false; }
-static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
-- 
2.18.0.rc2.346.g013aa6912e-goog
