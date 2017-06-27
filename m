Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753592AbdF0VAf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 17:00:35 -0400
Date: Tue, 27 Jun 2017 16:00:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 3/7] x86/pci/ce4100: Properly lock accessor functions
Message-ID: <20170627210033.GD764@bhelgaas-glaptop.roam.corp.google.com>
References: <20170316215002.726697858@linutronix.de>
 <20170316215057.126873574@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316215057.126873574@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Thu, Mar 16, 2017 at 10:50:05PM +0100, Thomas Gleixner wrote:
> x86 wants to get rid of the global pci_lock protecting the config space
> accessors so ECAM mode can operate completely lockless, but the CE4100 pci
> code relies on that to protect the simulation registers.

s/pci/PCI/

> Restructure the code so it uses the x86 specific pci_config_lock to
> serialize the inner workings of the CE4100 PCI magic. That allows to remove
> the global locking via pci_lock later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/pci/ce4100.c |   87 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 39 deletions(-)
> 
> --- a/arch/x86/pci/ce4100.c
> +++ b/arch/x86/pci/ce4100.c
> @@ -65,6 +65,9 @@ struct sim_reg_op {
>  { PCI_DEVFN(device, func), offset, init_op, read_op, write_op,\
>  	{0, SIZE_TO_MASK(size)} },
>  
> +/*
> + * All read/write functions are called with pci_config_lock held.
> + */
>  static void reg_init(struct sim_dev_reg *reg)
>  {
>  	pci_direct_conf1.read(0, 1, reg->dev_func, reg->reg, 4,
> @@ -73,21 +76,13 @@ static void reg_init(struct sim_dev_reg
>  
>  static void reg_read(struct sim_dev_reg *reg, u32 *value)
>  {
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&pci_config_lock, flags);
>  	*value = reg->sim_reg.value;
> -	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>  }
>  
>  static void reg_write(struct sim_dev_reg *reg, u32 value)
>  {
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&pci_config_lock, flags);
>  	reg->sim_reg.value = (value & reg->sim_reg.mask) |
>  		(reg->sim_reg.value & ~reg->sim_reg.mask);
> -	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>  }
>  
>  static void sata_reg_init(struct sim_dev_reg *reg)
> @@ -117,12 +112,8 @@ static void sata_revid_read(struct sim_d
>  
>  static void reg_noirq_read(struct sim_dev_reg *reg, u32 *value)
>  {
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&pci_config_lock, flags);
>  	/* force interrupt pin value to 0 */
>  	*value = reg->sim_reg.value & 0xfff00ff;
> -	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>  }
>  
>  static struct sim_dev_reg bus1_fixups[] = {
> @@ -265,24 +256,33 @@ int bridge_read(unsigned int devfn, int
>  	return retval;
>  }
>  
> -static int ce4100_conf_read(unsigned int seg, unsigned int bus,
> -			    unsigned int devfn, int reg, int len, u32 *value)
> +static int ce4100_bus1_read(unsigned int devfn, int reg, int len, u32 *value)
>  {
> +	unsigned long flags;
>  	int i;
>  
> -	WARN_ON(seg);
> -	if (bus == 1) {
> -		for (i = 0; i < ARRAY_SIZE(bus1_fixups); i++) {
> -			if (bus1_fixups[i].dev_func == devfn &&
> -			    bus1_fixups[i].reg == (reg & ~3) &&
> -			    bus1_fixups[i].read) {
> -				bus1_fixups[i].read(&(bus1_fixups[i]),
> -						    value);
> -				extract_bytes(value, reg, len);
> -				return 0;
> -			}
> +	for (i = 0; i < ARRAY_SIZE(bus1_fixups); i++) {
> +		if (bus1_fixups[i].dev_func == devfn &&
> +		    bus1_fixups[i].reg == (reg & ~3) &&
> +		    bus1_fixups[i].read) {
> +
> +			raw_spin_lock_irqsave(&pci_config_lock, flags);
> +			bus1_fixups[i].read(&(bus1_fixups[i]), value);
> +			raw_spin_unlock_irqrestore(&pci_config_lock, flags);
> +			extract_bytes(value, reg, len);
> +			return 0;
>  		}
>  	}
> +	return -1;
> +}
> +
> +static int ce4100_conf_read(unsigned int seg, unsigned int bus,
> +			    unsigned int devfn, int reg, int len, u32 *value)
> +{
> +	WARN_ON(seg);
> +
> +	if (bus == 1 && !ce4100_bus1_read(devfn, reg, len, value))
> +		return 0;
>  
>  	if (bus == 0 && (PCI_DEVFN(1, 0) == devfn) &&
>  	    !bridge_read(devfn, reg, len, value))
> @@ -291,23 +291,32 @@ static int ce4100_conf_read(unsigned int
>  	return pci_direct_conf1.read(seg, bus, devfn, reg, len, value);
>  }
>  
> -static int ce4100_conf_write(unsigned int seg, unsigned int bus,
> -			     unsigned int devfn, int reg, int len, u32 value)
> +static int ce4100_bus1_write(unsigned int devfn, int reg, int len, u32 value)
>  {
> +	unsigned long flags;
>  	int i;
>  
> -	WARN_ON(seg);
> -	if (bus == 1) {
> -		for (i = 0; i < ARRAY_SIZE(bus1_fixups); i++) {
> -			if (bus1_fixups[i].dev_func == devfn &&
> -			    bus1_fixups[i].reg == (reg & ~3) &&
> -			    bus1_fixups[i].write) {
> -				bus1_fixups[i].write(&(bus1_fixups[i]),
> -						     value);
> -				return 0;
> -			}
> +	for (i = 0; i < ARRAY_SIZE(bus1_fixups); i++) {
> +		if (bus1_fixups[i].dev_func == devfn &&
> +		    bus1_fixups[i].reg == (reg & ~3) &&
> +		    bus1_fixups[i].write) {
> +
> +			raw_spin_lock_irqsave(&pci_config_lock, flags);
> +			bus1_fixups[i].write(&(bus1_fixups[i]), value);
> +			raw_spin_unlock_irqrestore(&pci_config_lock, flags);
> +			return 0;
>  		}
>  	}
> +	return -1;
> +}
> +
> +static int ce4100_conf_write(unsigned int seg, unsigned int bus,
> +			     unsigned int devfn, int reg, int len, u32 value)
> +{
> +	WARN_ON(seg);
> +
> +	if (bus == 1 && !ce4100_bus1_write(devfn, reg, len, value))
> +		return 0;
>  
>  	/* Discard writes to A/V bridge BAR. */
>  	if (bus == 0 && PCI_DEVFN(1, 0) == devfn &&
> @@ -318,8 +327,8 @@ static int ce4100_conf_write(unsigned in
>  }
>  
>  static const struct pci_raw_ops ce4100_pci_conf = {
> -	.read =	ce4100_conf_read,
> -	.write = ce4100_conf_write,
> +	.read	= ce4100_conf_read,
> +	.write	= ce4100_conf_write,
>  };
>  
>  int __init ce4100_pci_init(void)
> 
> 
