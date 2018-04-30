Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 30 Apr 2018 16:49:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vidya Sagar <vidyas@nvidia.com>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug? pcie_aspm=off cause less power consumption as default
Message-ID: <20180430214954.GH95643@bhelgaas-glaptop.roam.corp.google.com>
References: <20180422171647.7v65zrlwhya5mq7v@pali>
 <20180427195313.GH8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180430212321.hwvdhwk2hhjbd7nw@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180430212321.hwvdhwk2hhjbd7nw@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2018 at 11:23:21PM +0200, Pali Rohár wrote:
> On Friday 27 April 2018 14:53:13 Bjorn Helgaas wrote:
> > Can you apply the following patch and try just the "force powersave" situation?
> 
> Hi! You forgot to attach that patch.

Oops, I sure did!  I must have been subconsciously dreading analyzing the
resulting data :)  Here's the patch:


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c687c817b47d..d5fef9b0a541 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -155,10 +155,13 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 	struct pci_bus *linkbus = link->pdev->subordinate;
 	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
 
-	list_for_each_entry(child, &linkbus->devices, bus_list)
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_CLKREQ_EN,
 						   val);
+		pci_info(child, "set PCI_EXP_LNKCTL %#06x %s\n", val,
+			 __func__);
+	}
 	link->clkpm_enabled = !!enable;
 }
 
@@ -184,12 +187,16 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* All functions should have the same cap and state, take the worst */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
+		pci_info(child, "rd  PCI_EXP_LNKCAP %#010x %s\n", reg32,
+			 __func__);
 		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
 			capable = 0;
 			enabled = 0;
 			break;
 		}
 		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
+		pci_info(child, "rd  PCI_EXP_LNKCTL %#06x %s\n", reg16,
+			 __func__);
 		if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
 			enabled = 0;
 	}
@@ -229,12 +236,16 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Port might be already in common clock mode */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	pci_info(parent, "rd  PCI_EXP_LNKCTL %#06x %s\n", reg16,
+		 __func__);
 	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
 		bool consistent = true;
 
 		list_for_each_entry(child, &linkbus->devices, bus_list) {
 			pcie_capability_read_word(child, PCI_EXP_LNKCTL,
 						  &reg16);
+			pci_info(child, "rd  PCI_EXP_LNKCTL %#06x %s loop 1\n", reg16,
+				 __func__);
 			if (!(reg16 & PCI_EXP_LNKCTL_CCC)) {
 				consistent = false;
 				break;
@@ -248,26 +259,36 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 	/* Configure downstream component, all functions */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
+		pci_info(child, "rd  PCI_EXP_LNKCTL %#06x %s loop 2\n", reg16,
+			 __func__);
 		child_reg[PCI_FUNC(child->devfn)] = reg16;
 		if (same_clock)
 			reg16 |= PCI_EXP_LNKCTL_CCC;
 		else
 			reg16 &= ~PCI_EXP_LNKCTL_CCC;
 		pcie_capability_write_word(child, PCI_EXP_LNKCTL, reg16);
+		pci_info(child, "wr  PCI_EXP_LNKCTL %#06x %s loop 2\n", reg16,
+			 __func__);
 	}
 
 	/* Configure upstream component */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	pci_info(parent, "rd  PCI_EXP_LNKCTL %#06x %s\n", reg16,
+		 __func__);
 	parent_reg = reg16;
 	if (same_clock)
 		reg16 |= PCI_EXP_LNKCTL_CCC;
 	else
 		reg16 &= ~PCI_EXP_LNKCTL_CCC;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pci_info(parent, "wr  PCI_EXP_LNKCTL %#06x %s\n", reg16,
+		 __func__);
 
 	/* Retrain link */
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pci_info(parent, "wr  PCI_EXP_LNKCTL %#06x %s retrain\n", reg16,
+		 __func__);
 
 	/* Wait for link training end. Break out after waiting for timeout */
 	start_jiffies = jiffies;
@@ -284,10 +305,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Training failed. Restore common clock configurations */
 	pci_err(parent, "ASPM: Could not configure common clock\n");
-	list_for_each_entry(child, &linkbus->devices, bus_list)
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
 					   child_reg[PCI_FUNC(child->devfn)]);
+		pci_info(child, "wr  PCI_EXP_LNKCTL %#06x %s restore\n",
+			 child_reg[PCI_FUNC(child->devfn)], __func__);
+	}
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+	pci_info(parent, "wr  PCI_EXP_LNKCTL %#06x %s restore\n", parent_reg,
+		 __func__);
 }
 
 /* Convert L0s latency encoding to ns */
@@ -383,10 +409,14 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 	u32 reg32;
 
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &reg32);
+	pci_info(pdev, "rd  PCI_EXP_LNKCAP %#010x %s\n", reg32,
+		 __func__);
 	info->support = (reg32 & PCI_EXP_LNKCAP_ASPMS) >> 10;
 	info->latency_encoding_l0s = (reg32 & PCI_EXP_LNKCAP_L0SEL) >> 12;
 	info->latency_encoding_l1  = (reg32 & PCI_EXP_LNKCAP_L1EL) >> 15;
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
+	pci_info(pdev, "rd  PCI_EXP_LNKCTL %#06x %s\n", reg16,
+		 __func__);
 	info->enabled = reg16 & PCI_EXP_LNKCTL_ASPMC;
 
 	/* Read L1 PM substate capabilities */
@@ -690,8 +720,12 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	if (enable_req & (ASPM_STATE_L1_1 | ASPM_STATE_L1_2)) {
 		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_ASPM_L1, 0);
+		pci_info(child, "clr PCI_EXP_LNKCTL %#06x %s\n",
+			 PCI_EXP_LNKCTL_ASPM_L1, __func__);
 		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_ASPM_L1, 0);
+		pci_info(parent, "clr PCI_EXP_LNKCTL %#06x %s\n",
+			 PCI_EXP_LNKCTL_ASPM_L1, __func__);
 	}
 
 	if (enable_req & ASPM_STATE_L1_2_MASK) {
@@ -739,6 +773,8 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
 					   PCI_EXP_LNKCTL_ASPMC, val);
+	pci_info(pdev, "set PCI_EXP_LNKCTL %#06x %s\n",
+		 val, __func__);
 }
 
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
