Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbeAaVTR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jan 2018 16:19:17 -0500
Subject: [PATCH] lspci: Make DevCtl, DevSta, and AER decoding more consistent
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Date: Wed, 31 Jan 2018 15:19:13 -0600
Message-ID: <20180131211913.66990.27599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Change DevCtl error reporting enables so they match the corresponding
DevSta bits:

-  DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
+  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-

PCIe r4.0, sec 6.2.2, classifies errors as Correctable or Uncorrectable.
Uncorrectable includes both Non-Fatal and Fatal errors.  Decode the DevSta
"Non-Fatal Error Detected" bit as "NonFatalErr", not "UncorrErr":

-  DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
+  DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-

Change the "Unsupported" and "UnsuppReq" labels in DevCtl and DevSta to
match the "UnsupReq" used in AER.

The Correctable error category doesn't include Non-Fatal errors, so change
the AER Correctable Error Status "Advisory Non-Fatal Error Status" from
"NonFatalErr" to "AdvNonFatalErr":

-  CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
+  CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-


Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c  |    4 ++--
 ls-ecaps.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index d4aebc8..158ac38 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -686,7 +686,7 @@ static void cap_express_dev(struct device *d, int where, int type)
   printf("\n");
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL);
-  printf("\t\tDevCtl:\tReport errors: Correctable%c Non-Fatal%c Fatal%c Unsupported%c\n",
+  printf("\t\tDevCtl:\tCorrErr%c NonFatalErr%c FatalErr%c UnsupReq%c\n",
 	FLAG(w, PCI_EXP_DEVCTL_CERE),
 	FLAG(w, PCI_EXP_DEVCTL_NFERE),
 	FLAG(w, PCI_EXP_DEVCTL_FERE),
@@ -707,7 +707,7 @@ static void cap_express_dev(struct device *d, int where, int type)
 	128 << ((w & PCI_EXP_DEVCTL_READRQ) >> 12));
 
   w = get_conf_word(d, where + PCI_EXP_DEVSTA);
-  printf("\t\tDevSta:\tCorrErr%c UncorrErr%c FatalErr%c UnsuppReq%c AuxPwr%c TransPend%c\n",
+  printf("\t\tDevSta:\tCorrErr%c NonFatalErr%c FatalErr%c UnsupReq%c AuxPwr%c TransPend%c\n",
 	FLAG(w, PCI_EXP_DEVSTA_CED),
 	FLAG(w, PCI_EXP_DEVSTA_NFED),
 	FLAG(w, PCI_EXP_DEVSTA_FED),
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 634db21..800a032 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -124,11 +124,11 @@ cap_aer(struct device *d, int where, int type)
 	FLAG(l, PCI_ERR_UNC_UNX_COMP), FLAG(l, PCI_ERR_UNC_RX_OVER), FLAG(l, PCI_ERR_UNC_MALF_TLP),
 	FLAG(l, PCI_ERR_UNC_ECRC), FLAG(l, PCI_ERR_UNC_UNSUP), FLAG(l, PCI_ERR_UNC_ACS_VIOL));
   l = get_conf_long(d, where + PCI_ERR_COR_STATUS);
-  printf("\t\tCESta:\tRxErr%c BadTLP%c BadDLLP%c Rollover%c Timeout%c NonFatalErr%c\n",
+  printf("\t\tCESta:\tRxErr%c BadTLP%c BadDLLP%c Rollover%c Timeout%c AdvNonFatalErr%c\n",
 	FLAG(l, PCI_ERR_COR_RCVR), FLAG(l, PCI_ERR_COR_BAD_TLP), FLAG(l, PCI_ERR_COR_BAD_DLLP),
 	FLAG(l, PCI_ERR_COR_REP_ROLL), FLAG(l, PCI_ERR_COR_REP_TIMER), FLAG(l, PCI_ERR_COR_REP_ANFE));
   l = get_conf_long(d, where + PCI_ERR_COR_MASK);
-  printf("\t\tCEMsk:\tRxErr%c BadTLP%c BadDLLP%c Rollover%c Timeout%c NonFatalErr%c\n",
+  printf("\t\tCEMsk:\tRxErr%c BadTLP%c BadDLLP%c Rollover%c Timeout%c AdvNonFatalErr%c\n",
 	FLAG(l, PCI_ERR_COR_RCVR), FLAG(l, PCI_ERR_COR_BAD_TLP), FLAG(l, PCI_ERR_COR_BAD_DLLP),
 	FLAG(l, PCI_ERR_COR_REP_ROLL), FLAG(l, PCI_ERR_COR_REP_TIMER), FLAG(l, PCI_ERR_COR_REP_ANFE));
   l = get_conf_long(d, where + PCI_ERR_CAP);
