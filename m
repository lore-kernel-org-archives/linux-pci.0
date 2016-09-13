Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58634 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753562AbcIMQZo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 12:25:44 -0400
Date: Tue, 13 Sep 2016 12:36:47 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/2] pciehp: Let user control LED status
Message-ID: <20160913163647.GA13741@localhost.localdomain>
References: <1473779140-4016-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473779140-4016-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 09:05:39AM -0600, Keith Busch wrote:
> +int pciehp_get_raw_attention_status(struct hotplug_slot *hotplug_slot,
> +								u8 *value)
> +{
> +	struct slot *slot = hotplug_slot->private;
> +	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
> +	u16 slot_ctrl;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> +	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;

Sorry, I generated this patch from a wrong branch. Won't compile, will
send the correct series. Apologies for the churn.
