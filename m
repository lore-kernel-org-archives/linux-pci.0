Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbeIFStn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 14:49:43 -0400
Date: Thu, 6 Sep 2018 09:13:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: add support for Immediate Readiness
Message-ID: <20180906141355.GC214747@bhelgaas-glaptop.roam.corp.google.com>
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
 <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org>
 <874lgcufsu.fsf@linux.intel.com>
 <407fa9ef-dcbe-e803-f72e-cbea468592bf@kernel.org>
 <20180904181126.GG107892@bhelgaas-glaptop.roam.corp.google.com>
 <87y3cgbjyf.fsf@linux.intel.com>
 <20180905164909.GJ107892@bhelgaas-glaptop.roam.corp.google.com>
 <87tvn3w4bz.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87tvn3w4bz.fsf@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 06, 2018 at 09:02:56AM +0300, Felipe Balbi wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> >> >> I think the patch is touching the wrong places. pci_dev_wait() is there
> >> >> to wait for CRS response to finish following reset.
> >> >> 
> >> >> Typical sequences are:
> >> >> 1. Do some kind of reset in another routine
> >> >> 2. Wait reset specific wait time (1sec for secondary bus reset as an
> >> >> example and 100ms for d3-d0 transition)
> >> >> 3. call pci_dev_wait() after reset to see if device can accept config
> >> >> transactions.
> >> >> 
> >> >> Since this applies to all resets, I think you also need to get rid of
> >> >> waits following different reset types in step #2 and return immediately.
> >> >> I suggest you review callers of pci_dev_wait() and tap in there.
> >> >
> >> > I agree; I think we should be able to skip the delays in pcie_flr(),
> >> > pci_af_flr(), etc.
> >> 
> >> but that's why I put the code in pci_dev_wait(). Both pcie_flr() and
> >> pci_af_flr() call pci_dev_wait(); or are you saying that the msleep(100)
> >> call in pci_af_flr() can also be removed if (dev->imm_ready)?
> >
> > Yes.  The spec says (PCIe r4.0, sec 7.5.1.1.4):
> >
> >   When this bit is Set, for accesses to this Function, software is
> >   exempt from all requirements to delay configuration accesses
> >   following any type of reset, including but not limited to the timing
> >   requirements defined in Section 6.6.
> >
> > Sec 6.6 contains various references to waiting 100ms after different
> > types of resets, and I think those correspond to the msleep(100)
> > calls.  So I think we can skip those delays if the device supports
> > Immediate Readiness.
> >
> > pci_dev_wait() is connected with CRS.  There's some reason that
> > function doesn't actually looks for CRS responses, which I can't
> > remember right now.  But you can look it up in the changelogs.
> >
> > So I don't think we should put the Immediate Readiness check in
> > pci_dev_wait().
> 
> IOW, you want something like below? If that's the case, I can send
> another version shortly.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ff9619b5fa..61be196db92b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -999,7 +999,7 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>  		 * because have already delayed for the bridge.
>  		 */
>  		if (dev->runtime_d3cold) {
> -			if (dev->d3cold_delay)
> +			if (dev->d3cold_delay && !dev->imm_ready)
>  				msleep(dev->d3cold_delay);
>  			/*
>  			 * When powering on a bridge from D3cold, the
> @@ -2644,6 +2644,7 @@ EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>  void pci_pm_init(struct pci_dev *dev)
>  {
>  	int pm;
> +	u16 status;
>  	u16 pmc;
>  
>  	pm_runtime_forbid(&dev->dev);
> @@ -2706,6 +2707,9 @@ void pci_pm_init(struct pci_dev *dev)
>  		/* Disable the PME# generation functionality */
>  		pci_pme_active(dev, false);
>  	}
> +
> +	pci_read_config_word(dev, PCI_STATUS, &status);
> +	dev->imm_ready = status & PCI_STATUS_IMMEDIATE;

This needs something like

  if (status & PCI_STATUS_IMMEDIATE)
    dev->imm_ready = 1;

It's true that PCI_STATUS_IMMEDIATE is the least-significant bit,
but the code here shouldn't depend on that.

But otherwise this looks good.

>  }
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> @@ -4376,6 +4380,9 @@ int pcie_flr(struct pci_dev *dev)
>  
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>  
> +	if (dev->imm_ready)
> +		return 0;
> +
>  	/*
>  	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
>  	 * 100ms, but may silently discard requests while the FLR is in
> @@ -4417,6 +4424,9 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  
>  	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
>  
> +	if (dev->imm_ready)
> +		return 0;
> +
>  	/*
>  	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
>  	 * updated 27 July 2006; a device must complete an FLR within
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e72ca8dd6241..7eed464e844a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -325,6 +325,7 @@ struct pci_dev {
>  	pci_power_t	current_state;	/* Current operating state. In ACPI,
>  					   this is D0-D3, D0 being fully
>  					   functional, and D3 being off. */
> +	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>  	u8		pm_cap;		/* PM capability offset */
>  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>  					   can be generated */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ee556ccc93f4..b5cf51a06cae 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -52,6 +52,7 @@
>  #define  PCI_COMMAND_INTX_DISABLE 0x400 /* INTx Emulation Disable */
>  
>  #define PCI_STATUS		0x06	/* 16 bits */
> +#define  PCI_STATUS_IMMEDIATE	0x01	/* Immediate Readiness */
>  #define  PCI_STATUS_INTERRUPT	0x08	/* Interrupt status */
>  #define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
>  #define  PCI_STATUS_66MHZ	0x20	/* Support 66 MHz PCI 2.1 bus */
> 
> 
> -- 
> balbi
