Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D72253EB
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833376; cv=none; b=tbSrJ3lwmgdl2DZO0Lh9EBtghqh1BbIrq/5pyHY9W74b/YmWkXmMD3P7ugPqDB+Ub10TGwQwsdpE4kPeilaQAwKLhnaBU5AG5qvkESJCYwpwkNvT47/efvpW2amvGZfqIItzXAKdlQN3byuFkMKMwxAqekynLya6Bp5SWgGx7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833376; c=relaxed/simple;
	bh=Yz4u9saRvvy6ltv8t6kWu/YaLZqxlZy2y2s7K6XIf4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hGXwRvG05vpoqgP4rrE52uSqoWk+4yKyKdExG8Tkz12oNEppJYlXQjBY+Uwyz+BLkzYBm4Osf+/SxKKbjoEstvRQho+uYio2aiPRdjSivX9q1pw0R/O7MZHJ5XnPllnuCndNcS4aVFdX2r4l+Zt7JPOAhmrEqDxXlRMydzdDl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf+RbgNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf+RbgNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BEE1F0089B;
	Mon, 12 Oct 2026 19:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791833374;
	bh=tJD0BNC1Sr9Vs8uU5NQSpCC1ZsLiLLq5pAW1YUb4gOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=nf+RbgNEBYgMyYU6nkdddrkIr+CDH1y0/pQqlRyIAIsldfoQbl4M4DnevJi6h/JDW
	 odP/J+tQbZmOVpjYvb+AaWpK19bqxCnKC9Xq68Nm973D1mTFR2clhQp685wY3H6VKU
	 DNmjBbw2e6hjJH0oz0tKI9HrBFpBV+2wd2m1eSOROhNO1ApT6j+wYzQRbHbVktGOaw
	 V9R8mcYlLBrD/Ig4h/Hf2okr+OceMky+sDgo2a7GyVp/8L6KT4QcnyPV15u4aB8RFB
	 3feVivdhXaWke1+7XUQRZP4NLbSqWa63behKWusZvYsTTc2GzoTnjiZkER1jdx9uPN
	 E9n1sqFl4iQqA==
Date: Mon, 12 Oct 2026 14:29:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aditya Garg <aditya.garg@linux.dev>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Lukas Wunner <lukas@wunner.de>,
	Jason Perlow <jperlow@gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip unmasking Advisory Non-Fatal
 Errors on T2 SEP
Message-ID: <20261012192933.GA1358008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010172301.12764-1-aditya.garg@linux.dev>

On Sat, Oct 10, 2026 at 10:53:01PM +0530, Aditya Garg wrote:
> Jason reported that since commit eddba19b8b5f ("PCI/AER: Support Advisory
> Non-Fatal Errors"), the Macs with Apple T2 Security Chip were powering
> off a few seconds after every boot. He also found the PCI Device
> 106b:1802, which corresponds to the Apple T2 Secure Enclave Processor was
> misbehaving and the most likely reason is that the device is ANFE
> incompatible due to Apple's custom hardware.
> 
> Since its highly unlikely that Apple will release a firmware update to
> support ANFE, introduce a quirk as suggested by Lukas to blacklist the T2
> SEP from ANFE.
> 
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Reported-by: Jason Perlow <jperlow@gmail.com>
> Tested-by: Jason Perlow <jperlow@gmail.com>
> Closes: https://lore.kernel.org/linux-pci/CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com/
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>

Applied to pci/for-linus for v7.3, thank you!

I aligned the "!dev->no_aer_anfe" test as Lukas suggested and took a
stab at the "misbehaving" comment:

  Jason reported that since commit eddba19b8b5f ("PCI/AER: Support Advisory
  Non-Fatal Errors"), the Macs with Apple T2 Security Chip were powering off
  a few seconds after every boot. He also found that the power-off only
  happens when Advisory Non-Fatal Errors are unmasked on the PCI Device
  106b:1802, the Apple T2 Secure Enclave Processor.

I'll be happy to revise this if we can make it clearer or more
specific.

> ---
>  drivers/pci/pcie/aer.c  |  3 ++-
>  drivers/pci/quirks.c    | 12 ++++++++++++
>  include/linux/pci.h     |  1 +
>  include/linux/pci_ids.h |  1 +
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 922a726a5..cab195f7c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -428,7 +428,8 @@ void pci_aer_init(struct pci_dev *dev)
>  	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
>  	 * 7.8.4.6).
>  	 */
> -	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
> +	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER &&
> +		!dev->no_aer_anfe)
>  		pci_clear_and_set_config_dword(dev,
>  					       dev->aer_cap + PCI_ERR_COR_MASK,
>  					       PCI_ERR_COR_ADV_NFAT, 0);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda..acca89532 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6422,4 +6422,16 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
> +
> +/*
> + * Unmasking Advisory Non-Fatal Errors on Apple T2 Secure Enclave
> + * processor leads to the Mac shutting down spontaneously. Avoid
> + * doing that.
> + */
> +static void quirk_no_aer_anfe(struct pci_dev *dev)
> +{
> +	dev->no_aer_anfe = 1;
> +}
> +
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_T2_SEP, quirk_no_aer_anfe);
>  #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107..83ffa5058 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -514,6 +514,7 @@ struct pci_dev {
>  	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
>  	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
>  	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
> +	unsigned int	no_aer_anfe:1;		/* Don't unmask Advisory Non-Fatal Errors */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 63774ae2b..103024f74 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1007,6 +1007,7 @@
>  #define PCI_DEVICE_ID_APPLE_IPID2_FW	0x006a
>  #define PCI_DEVICE_ID_APPLE_IPID2_GMAC	0x006b
>  #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
> +#define PCI_DEVICE_ID_APPLE_T2_SEP	0x1802
>  
>  #define PCI_VENDOR_ID_YAMAHA		0x1073
>  #define PCI_DEVICE_ID_YAMAHA_724	0x0004
> -- 
> 2.55.0
> 
