Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753011AbeDSUQn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Apr 2018 16:16:43 -0400
Subject: [PATCH 3/4] lspci: Print names of capabilities even if we can't
 decode the rest
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Date: Thu, 19 Apr 2018 15:16:40 -0500
Message-ID: <152416900089.71364.13804680545241038494.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

We don't have decoders for many new capabilities, so we currently print
just the capability ID, e.g.,

  Capabilities: [220 v1] Extended Capability ID 0x19

Print the names, even if we don't yet know how to decode the contents,
e.g.,

  Capabilities: [220 v1] Secondary PCI Express <?>

The capability IDs are taken from the PCI Code and ID Assignment spec,
r1.10.  The #defines are named to match those in Linux when possible.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h |   17 +++++++++++++++++
 ls-ecaps.c   |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 1f0e460..0a8a548 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -228,13 +228,30 @@
 #define PCI_EXT_CAP_ID_ARI	0x0e	/* Alternative Routing-ID Interpretation */
 #define PCI_EXT_CAP_ID_ATS	0x0f	/* Address Translation Service */
 #define PCI_EXT_CAP_ID_SRIOV	0x10	/* Single Root I/O Virtualization */
+#define PCI_EXT_CAP_ID_MRIOV	0x11	/* Multi-Root I/O Virtualization */
+#define PCI_EXT_CAP_ID_MCAST	0x12	/* Multicast */
 #define PCI_EXT_CAP_ID_PRI	0x13	/* Page Request Interface */
+#define PCI_EXT_CAP_ID_REBAR	0x15	/* Resizable BAR */
+#define PCI_EXT_CAP_ID_DPA	0x16	/* Dynamic Power Allocation */
 #define PCI_EXT_CAP_ID_TPH	0x17	/* Transaction processing hints */
 #define PCI_EXT_CAP_ID_LTR	0x18	/* Latency Tolerance Reporting */
+#define PCI_EXT_CAP_ID_SECPCI	0x19	/* Secondary PCI Express */
+#define PCI_EXT_CAP_ID_PMUX	0x1a	/* Protocol Multiplexing */
 #define PCI_EXT_CAP_ID_PASID	0x1b	/* Process Address Space ID */
+#define PCI_EXT_CAP_ID_LNR	0x1c	/* LN Requester */
 #define PCI_EXT_CAP_ID_DPC	0x1d	/* Downstream Port Containment */
 #define PCI_EXT_CAP_ID_L1PM	0x1e	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1f	/* Precision Time Measurement */
+#define PCI_EXT_CAP_ID_M_PCIE	0x20	/* PCIe over M-PHY */
+#define PCI_EXT_CAP_ID_FRS	0x21	/* FRS Queuing */
+#define PCI_EXT_CAP_ID_RTR	0x22	/* Readiness Time Reporting */
+#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
+#define PCI_EXT_CAP_ID_VF_REBAR	0x24	/* VF Resizable BAR */
+#define PCI_EXT_CAP_ID_DLNK	0x25	/* Data Link Feature */
+#define PCI_EXT_CAP_ID_16GT	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_LMR	0x27	/* Lane Margining at Receiver */
+#define PCI_EXT_CAP_ID_HIER_ID	0x28	/* Hierarchy ID */
+#define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 
 /*** Definitions of capabilities ***/
 
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 3f6a364..a6ae751 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -786,24 +786,72 @@ show_ext_caps(struct device *d, int type)
 	  case PCI_EXT_CAP_ID_SRIOV:
 	    cap_sriov(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_MRIOV:
+	    printf("Multi-Root I/O Virtualization <?>\n");
+	    break;
 	  case PCI_EXT_CAP_ID_PRI:
 	    cap_pri(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_REBAR:
+	    printf("Resizable BAR <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_DPA:
+	    printf("Dynamic Power Allocation <?>\n");
+	    break;
 	  case PCI_EXT_CAP_ID_TPH:
 	    cap_tph(d, where);
 	    break;
 	  case PCI_EXT_CAP_ID_LTR:
 	    cap_ltr(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_SECPCI:
+	    printf("Secondary PCI Express <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_PMUX:
+	    printf("Protocol Multiplexing <?>\n");
+	    break;
 	  case PCI_EXT_CAP_ID_PASID:
 	    cap_pasid(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_LNR:
+	    printf("LN Requester <?>\n");
+	    break;
 	  case PCI_EXT_CAP_ID_L1PM:
 	    cap_l1pm(d, where);
 	    break;
 	  case PCI_EXT_CAP_ID_PTM:
 	    cap_ptm(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_M_PCIE:
+	    printf("PCI Express over M_PHY <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_FRS:
+	    printf("FRS Queueing <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_RTR:
+	    printf("Readiness Time Reporting <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_DVSEC:
+	    printf("Designated Vendor-Specific <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_VF_REBAR:
+	    printf("VF Resizable BAR <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_DLNK:
+	    printf("Data Link Feature <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_16GT:
+	    printf("Physical Layer 16.0 GT/s <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_LMR:
+	    printf("Lane Margining at the Receiver <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_HIER_ID:
+	    printf("Hierarchy ID <?>\n");
+	    break;
+	  case PCI_EXT_CAP_ID_NPEM:
+	    printf("Native PCIe Enclosure Management <?>\n");
+	    break;
 	  default:
 	    printf("Extended Capability ID %#02x\n", id);
 	    break;
