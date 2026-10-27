Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142535;
	b=u9jDMqpLXOSZ6p6v5Tcvx85jWHSU6fUJ8tU/5s0hIxyZ1dYNys7XXIoSAarOPYKfutG6
	 /dMwd29m6OK5rlxhRQv5Totoqhq2kj7lIrrKncjxYZFfT98h2+mJpQqELhziSqSUb24+2
	 /34feqBIzwuP/YUF1KCB79Vv+tItxVPsGgs6QlKNISRdEWK760E0rT46OV/LgPTG6W7af
	 Q2WoqeOkriU/9pW26I+1lhnHo5xBEdxuIcIz+yBfGrb+fvT1JwTRL7Zndm9sWKf8+7Y64
	 +Kt038+3uguh3wpSZeEcd+rao+f4S7yFYWiU7o5vCMJP+u5eNES25+aUB2Yjs+b+Tqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142535;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aQb5htKFxg4E+4TBkuanxs31RzNQQ7X0ztbhOrfh/rE=;
	b=VzSuJJKZk2i5QQoLo7p4mkxi93Y/VX+q4Xiren53Krik2a0NOwKHg+m59e5N/FDzR+Gk
	 7ZxTr42bYgxtKLK+/ITc3gn0NHrfHLalnTkQpxRhqo5YrTgIfB6MmI9EdkIDIekco8T+/
	 /nZpMD5HPuKjoAaDXszDF6KZOjsrkzVX/xxIuTWDzjdmCZ2OMYukHRMpvMhrNXgMtNpCF
	 Eii1TE0r5X70up+v5IuqZdNUSmee1LyAH/gypYOMDiPwV0RcXhCYODpLQmO51IYsDO9VW
	 iKT4H1+shF/VKvceUNELS+s4ZqZ8DXIn8PooW4/f9AAGwJl2ezSj3HMlStjHPWK22Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHVmbbwo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8A606A325;
	Tue, 27 Oct 2026 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHVmbbwo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D2E1F01825;
	Tue, 27 Oct 2026 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142534;
	bh=aQb5htKFxg4E+4TBkuanxs31RzNQQ7X0ztbhOrfh/rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hHVmbbwoMKSkOY0rRq1d2HufCM5WeD/1uYP+phQKuTcdGuqGJWuLPE9djElkYmrzR
	 eB114X2bV7MnZIeWbnzTDLPD3FYLd0VLWJVhS/ctQK2BocYs+TcwJdfTNLiVGeBUia
	 Vju0ymU01IqZOGruYdH1lqijSMZH/iDBjvcdgJF6gOP/ZODQLwCvR7GuCDuWdSQ4l7
	 4WRXACS+Ztgi4gI9xYOiPNJWYrB0SCrVhg6z/MquSUlyC2lxK292YcC94wDbQjldhB
	 9a5mzjHTYWMlURbOmXtXdyeQB0QmuzFUAGINp4lUo3fI8bUKWt2xKBXFA6B/uLm3ev
	 3wdRE2yfuvo/g==
Date: Tue, 27 Oct 2026 18:08:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Prarit Bhargava <prarit@redhat.com>,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2] PCI/AER: Make aer_mask_override effective for
 injected errors
Message-ID: <20261027230853.GA519764@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-fix-aer-mask-override-v1-1-49a0d7aeaea0@google.com>

On Mon, Oct 12, 2026 at 01:53:36PM -0700, Priyank Rathod wrote:
> The aer_mask_override module parameter of aer_inject is meant to allow
> injecting errors that the device masks in PCI_ERR_COR_MASK or
> PCI_ERR_UNCOR_MASK.  It does not work for Correctable or Non-Fatal
> errors, nor for Fatal errors on Root Ports and Downstream Ports,
> because the modified masks are restored before the AER driver reads
> them.
> 
> aer_inject() writes the modified masks to hardware and restores them
> from cor_mask_orig/uncor_mask_orig right after inject_lock is released,
> before irq_inject_interrupt() is even called.  The injected error is
> consumed asynchronously by the threaded handler aer_isr(), whose
> helpers is_error_source(), aer_get_device_error_info() and
> aer_get_anfe_status() read the Mask registers.  Those reads go through
> the emulated config space, but find_pci_config_dword() does not
> intercept PCI_ERR_COR_MASK/PCI_ERR_UNCOR_MASK, so they return the
> already restored hardware value.  aer_get_device_error_info() then
> sees !(info->status & ~info->mask) and drops the injected error,
> leaving the emulated status bit pending.  With aer_mask_override=1 the
> write to /dev/aer_inject succeeds and the Root Port logs "Correctable
> Error message received", but the error is neither decoded nor counted
> in the aer_dev_* sysfs attributes and, for a Non-Fatal error, no
> recovery takes place.
> 
> Only Fatal errors on other device types, e.g., Endpoints or Upstream
> Ports, "worked": for those aer_get_device_error_info() doesn't read the
> device's AER registers at all, so recovery is triggered without the
> injected bits ever being decoded.
> 
> The mask modification itself is wrong, too.  aer_inject() uses the
> logical-not instead of the bitwise-not operator when clearing the
> injected bits:
> 
>   cor_mask &= !(einj->cor_status);
>   uncor_mask &= !(einj->uncor_status);
> 
> "!x" evaluates to 0 or 1, so a non-zero injected status zeroes the
> whole Mask register while a zero injected status clears bits 31:1 and
> preserves only bit 0.  Both registers are rewritten on every injection,
> so e.g., a Correctable-only injection zeroes PCI_ERR_COR_MASK and
> clears bits 31:1 of PCI_ERR_UNCOR_MASK, transiently unmasking every
> error of the device, including those masked by default such as
> Advisory Non-Fatal Error and Uncorrectable Internal Error.
> 
> Writing the hardware Mask registers was never necessary: aer_inject
> doesn't make the device detect an error; it emulates the Error Status
> and Header Log registers and triggers the Root Port's (or RCEC's) AER
> interrupt.  The hardware masks only decide whether the device reports
> an error it detected itself, i.e., sends an ERR_* Message and logs the
> header (PCIe r7.0, sec 6.2.3.2.2); the only consumer of the masks in
> the injected flow is the AER driver, reading them through the emulated
> config space.
> 
> So emulate the override there instead: while injected error bits are
> pending in the emulated Status registers, reads of PCI_ERR_COR_MASK and
> PCI_ERR_UNCOR_MASK report those bits as unmasked.  aer_inject no longer
> modifies the hardware Mask registers, which also removes the window in
> which all errors were unmasked and the possibility of two concurrent
> injections restoring each other's modified value.  Also describe the
> parameter with MODULE_PARM_DESC().
> 
> The emulation ends when the injected status is cleared (RW1C), e.g.,
> by the AER driver once a Correctable error has been handled or
> Non-Fatal recovery has succeeded, or by pci_restore_state() from a
> driver's slot_reset().  Otherwise, e.g., for a Fatal error on a Root
> Port or any Uncorrectable error after a failed recovery, the injected
> status stays pending until pci_restore_state() clears it, the device
> is re-enumerated or aer_inject is unloaded.
> 
> Like the emulated Status registers, the emulated mask value is returned
> to every dword config read done through the PCI core, including
> pci_save_state(), and nothing would keep it from being written back: a
> pci_save_state() issued while an injected error is pending, e.g., by
> pci_reset_function() or pci_try_reset_function() (sysfs "reset", VFIO)
> or by a system or runtime suspend, records the Mask register with the
> bit clear; pci_restore_state() then clears the injected status and
> writes the saved value to the device, leaving the error unmasked in
> hardware for good, even after aer_inject is unloaded.  So also record
> in struct aer_error which hardware Mask bits were hidden from a reader
> and set them again in every dword write to the Mask registers.  Only
> bits that were actually masked when a reader saw them as unmasked are
> recorded, so all other bits stay writable and aer_inject itself still
> never writes the hardware Mask registers.  Byte and word accesses are
> not emulated, like for the Status registers.
> 
> Like the rest of struct aer_error, the record lives until aer_inject is
> unloaded.  Once the injected error has been cleared, the recorded bits
> read as masked again, but until the unload no dword write can unmask
> them in hardware, not even a legitimate one such as a 32-bit setpci
> access, pci_aer_init() after a rescan or pci_aer_unmask_internal_errors()
> for CXL devices.  That seems acceptable for a test module and is the
> conservative failure mode compared to leaving an error unmasked for
> good.  The protection also lasts only as long as aer_inject is loaded:
> a state saved while the error was pending (e.g., by VFIO at open or for
> a device in runtime suspend) and restored after the unload still writes
> the emulated value.
> 
> Tested in a QEMU q35 VM (pcie-root-port + e1000e) by masking BadTLP in
> PCI_ERR_COR_MASK and injecting it with aer_mask_override=1.  Before:
> only "Correctable Error message received", nothing decoded,
> aer_dev_correctable unchanged, emulated status left pending.  After:
> "[ 6] BadTLP" is decoded, the sysfs counter is incremented, the
> emulated status is cleared and PCI_ERR_COR_MASK is unchanged.  A masked
> Unsupported Request (UR) injected the same way is now decoded and
> recovery is triggered; it fails in the VM because the Root Port doesn't
> report Data Link Layer Link Active within 100 ms of the Secondary Bus
> Reset, so pcie_do_recovery() gives up and leaves the injected status
> pending.  Resetting the device through sysfs in that state leaves UR
> masked in PCI_ERR_UNCOR_MASK after aer_inject has been unloaded; with
> the read-side emulation alone it ended up unmasked.

Can you start with a one- or two-sentence description of what's going
on here?  Evidently injecting some errors doesn't work as expected
today?  As long as the justification is compelling and the code is
readable, I don't think we need quite as much detail about every
little implementation detail.

> Fixes: 457d9d088b02 ("PCI: aer-inject: Override PCIe AER Mask Registers")
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---
>  drivers/pci/pcie/aer_inject.c | 73 +++++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 09bfc7194ef3..98289004e4c7 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -27,9 +27,16 @@
>  
>  #include "portdrv.h"
>  
> -/* Override the existing corrected and uncorrected error masks */
> +/*
> + * Allow injecting errors that are masked in PCI_ERR_COR_MASK or
> + * PCI_ERR_UNCOR_MASK.  aer_inject never writes the hardware Mask registers
> + * itself: aer_inj_read_config() emulates the override and
> + * aer_inj_write_config() keeps the emulated value from being written back.
> + */
>  static bool aer_mask_override;
>  module_param(aer_mask_override, bool, 0);
> +MODULE_PARM_DESC(aer_mask_override,
> +		 "Allow injecting errors that the device masks");
>  
>  struct aer_error_inj {
>  	u8 bus;
> @@ -59,6 +66,9 @@ struct aer_error {
>  	u32 header_log3;
>  	u32 root_status;
>  	u32 source_id;
> +	/* Hardware Mask bits hidden from readers by aer_inj_read_config() */
> +	u32 uncor_mask_hidden;
> +	u32 cor_mask_hidden;
>  };
>  
>  struct pci_bus_ops {
> @@ -218,7 +228,7 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
>  			       int where, int size, u32 *val)
>  {
>  	u32 *sim;
> -	struct aer_error *err;
> +	struct aer_error *err = NULL;
>  	unsigned long flags;
>  	int domain;
>  	int rv;
> @@ -241,6 +251,26 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
>  	}
>  out:
>  	rv = aer_inj_read(bus, devfn, where, size, val);

Add blank line here.

> +	/*
> +	 * Report the injected errors as unmasked while they are pending in
> +	 * the emulated Status registers, and remember which hardware Mask
> +	 * bits were hidden that way so that aer_inj_write_config() can keep
> +	 * a value derived from this read (e.g., by pci_save_state()) from
> +	 * clearing them.  *val is unspecified if the read failed and ~0 if
> +	 * the device is gone, so leave it alone then.
> +	 */
> +	if (!rv && !PCI_POSSIBLE_ERROR(*val) && aer_mask_override && err) {
> +		switch (where - err->pos_cap_err) {
> +		case PCI_ERR_UNCOR_MASK:
> +			err->uncor_mask_hidden |= *val & err->uncor_status;
> +			*val &= ~err->uncor_status;
> +			break;
> +		case PCI_ERR_COR_MASK:
> +			err->cor_mask_hidden |= *val & err->cor_status;
> +			*val &= ~err->cor_status;
> +			break;
> +		}
> +	}
>  	spin_unlock_irqrestore(&inject_lock, flags);
>  	return rv;
>  }
> @@ -249,7 +279,7 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
>  				int where, int size, u32 val)
>  {
>  	u32 *sim;
> -	struct aer_error *err;
> +	struct aer_error *err = NULL;
>  	unsigned long flags;
>  	int rw1cs;
>  	int domain;
> @@ -275,6 +305,22 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
>  		return 0;
>  	}
>  out:
> +	/*
> +	 * Set the hardware Mask bits hidden from readers again, so that a
> +	 * value derived from such a read (e.g., by pci_save_state()) can't
> +	 * clear them.  The record is never cleared, so until aer_inject is
> +	 * unloaded no dword write can unmask those bits.
> +	 */
> +	if (aer_mask_override && err) {
> +		switch (where - err->pos_cap_err) {
> +		case PCI_ERR_UNCOR_MASK:
> +			val |= err->uncor_mask_hidden;
> +			break;
> +		case PCI_ERR_COR_MASK:
> +			val |= err->cor_mask_hidden;
> +			break;
> +		}
> +	}
>  	rv = aer_inj_write(bus, devfn, where, size, val);
>  	spin_unlock_irqrestore(&inject_lock, flags);
>  	return rv;
> @@ -326,7 +372,7 @@ static int aer_inject(struct aer_error_inj *einj)
>  	unsigned long flags;
>  	unsigned int devfn = PCI_DEVFN(einj->dev, einj->fn);
>  	int pos_cap_err, rp_pos_cap_err;
> -	u32 sever, cor_mask, uncor_mask, cor_mask_orig = 0, uncor_mask_orig = 0;
> +	u32 sever, cor_mask, uncor_mask;
>  	int ret = 0;
>  
>  	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
> @@ -371,18 +417,6 @@ static int aer_inject(struct aer_error_inj *einj)
>  		goto out_put;
>  	}
>  
> -	if (aer_mask_override) {
> -		cor_mask_orig = cor_mask;
> -		cor_mask &= !(einj->cor_status);
> -		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
> -				       cor_mask);
> -
> -		uncor_mask_orig = uncor_mask;
> -		uncor_mask &= !(einj->uncor_status);
> -		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK,
> -				       uncor_mask);
> -	}
> -
>  	spin_lock_irqsave(&inject_lock, flags);
>  
>  	err = __find_aer_error_by_dev(dev);
> @@ -447,13 +481,6 @@ static int aer_inject(struct aer_error_inj *einj)
>  	}
>  	spin_unlock_irqrestore(&inject_lock, flags);
>  
> -	if (aer_mask_override) {
> -		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
> -				       cor_mask_orig);
> -		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK,
> -				       uncor_mask_orig);
> -	}
> -
>  	ret = pci_bus_set_aer_ops(dev->bus);
>  	if (ret)
>  		goto out_put;
> 
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 
