Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74143F0B9;
	Thu,  8 Oct 2026 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791500308; cv=none; b=RG72O1GhOXPArDjr45pzjaKzEO7pvFkZ08pVc73usHa47S9AN7bg/qo5zx0nW9ZH/5rsRT8Fg4Hk9iC8V8jA6OPl+qYW0tcbGmagTi2fCTgzyx0Bx4c95WhhWDNcy4GpPgnZ2UM+mypagXkWEKF6JUr0Lkkv6ioinxRKdo0GDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791500308; c=relaxed/simple;
	bh=6ledDbc1icilumrn67YZWHjzbO7jiGjL9Pj7pGrbcPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BfpmGH1+2vOA736JpfikYdhssYoYwWHpQ4DwPrWvweYCbhKrKOtOQ8JK1/w1UHkZKHxtaWpCJjwiqbORj+Io1a6dHNY8vEUNs4aJwh4nj4to3O0W4KkwBMGTqvAjrrdI1yQfqGonb6DgjyjUZrD2Qvaxq5MJBDyFVutbVX2OJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FruiToyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FruiToyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F651F000FF;
	Thu,  8 Oct 2026 22:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791500307;
	bh=6qFEzIPBySpVPhDEQgfALvqJAxbUkX21t+O7OuW7n9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FruiToyYmvanYv5jz0I4XZ7bEgfjpl2JMb/0viK6RMrm3xNjzBG1c4z5aO8SIr0lq
	 8tkFJNjZN1cOj6+kEgDiRIQ9PRtGnHKAeZi9FH095RYZEQlRmsxrVpWUPSSMOS2cFg
	 yezNTJoOc8wUwRPuBnU9q3idXT9l+Z9e4wgRnz7oiE/R5RZk4IWdCC14dMIX/Y+SpF
	 f8tna4qUxgMwO6qh8iGu38wUos4/pVz5SV8VKIcS730gP8tMWtTfTCCocd2ot/NB/i
	 yDmqP7NyZ2mm6yBZLncMhNjWgh5uS7q/Pxf3o+DK9zIVy/sszTpPX5Fn8gkYmwyowZ
	 Riqb3pKU1Y1YA==
Date: Thu, 8 Oct 2026 17:58:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Farhan Ali <alifm@linux.ibm.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/PM: Do not save the config space of an
 inaccessible device
Message-ID: <20261008225825.GA936610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930141914.6678-3-fbeltranmillalen@gmail.com>

[+cc Lukas, Farhan, Andreas, Mika, Yehezkel]

On Wed, Sep 30, 2026 at 11:19:13AM -0300, Francisco Beltrán Millalén wrote:
> pci_save_state() reads the standard header into dev->saved_config_space
> and marks it valid without checking that the device answered.  If the
> device is not accessible, every read returns all ones, the previous
> snapshot is overwritten, and pci_restore_state() writes the all-ones
> values back once the device answers again.  On a bridge that sets every
> writable bit of the Bridge Control register, Secondary Bus Reset
> included, and sets the primary, secondary and subordinate bus numbers
> to 0xff, which cuts off everything below it.
> 
> On a MacBookPro14,3 this happens to the upstream bridge of a
> Thunderbolt controller that drops off the bus while the system is
> suspending: after resume the bridge answers again, but with bus numbers
> ff/ff/ff and Secondary Bus Reset asserted, and the xHCI controllers
> behind it are removed.

Apparently this is a reproducible issue on MacBookPro14,3.  That makes
me a little hesitant because we're not actually dealing with the fact
that the Thunderbolt controller isn't responsive during suspend.

It seems worthwhile to me to skip pci_save_state() if the device isn't
accessible, but I don't think it's a real solution to whatever is
going on with Thunderbolt, and I don't think we should mention it here
as though it is.

> Commit e18d1abc3bff ("PCI: Avoid saving config space state if
> inaccessible") added pci_dev_config_accessible() and checks it before a
> reset.  Check it in pci_save_state() itself, so that system suspend,
> where the state is saved by pci_pm_suspend_noirq() or by a driver's
> suspend_noirq callback, is covered as well.  pci_dev_config_accessible()
> reads the Command and Status registers rather than the Vendor and Device
> IDs, which always read as all ones on SR-IOV VFs.
> 
> Check again after reading, as the device may become inaccessible in the
> meantime, and only then replace the previous snapshot of the header and
> set state_saved.  The capabilities are saved straight into their own
> buffers and are not covered by the second check, and both checks are
> racy, as pci_dev_config_accessible() notes.
> 
> If the device is not accessible, return -EIO and leave state_saved as it
> was.
> 
> Assisted-by: LLM
> Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
> ---
> v2:
> - Use pci_dev_config_accessible() instead of reading the Vendor ID,
>   which always reads as all ones on SR-IOV VFs: v1 refused to save the
>   state of every VF.  In the v1 thread I said I would use
>   pci_device_is_present(), but for a VF that checks the PF and cannot
>   tell whether the VF itself answers.
> - Do the second check after saving the capabilities, and set
>   state_saved only if both checks pass.
> - The bus numbers are set to 0xff, not cleared.
> 
>  drivers/pci/pci.c |   53 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be..94de99d31 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1776,31 +1776,52 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
>   * pci_save_state - save the PCI configuration space of a device before
>   *		    suspending
>   * @dev: PCI device that we're dealing with
> + *
> + * If the config space of @dev is not accessible, nothing is saved and the
> + * previous snapshot of the standard header is kept, as writing back the
> + * all-ones values read from such a device would corrupt it once it is
> + * accessible again.
> + *
> + * Return: 0 on success, -EIO if @dev is not accessible, or another
> + * negative errno if a capability could not be saved.
>   */
>  int pci_save_state(struct pci_dev *dev)
>  {
> -	int i;
> +	u32 config[16];
> +	int i, ret;
> +
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return -EIO;

Maybe we should remove the check in pci_dev_save_and_disable() and
make it check the return value of pci_save_state()?  I don't think
checking twice adds anything.

>  	/* XXX: 100% dword access ok here? */
>  	for (i = 0; i < 16; i++) {
> -		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> -		pci_dbg(dev, "save config %#04x: %#010x\n",
> -			i * 4, dev->saved_config_space[i]);
> +		pci_read_config_dword(dev, i * 4, &config[i]);
> +		pci_dbg(dev, "save config %#04x: %#010x\n", i * 4, config[i]);
>  	}
> -	dev->state_saved = true;
>  
> -	i = pci_save_pcie_state(dev);
> -	if (i != 0)
> -		return i;
> +	ret = pci_save_pcie_state(dev);
> +	if (!ret)
> +		ret = pci_save_pcix_state(dev);
> +	if (!ret) {
> +		pci_save_dpc_state(dev);
> +		pci_save_aer_state(dev);
> +		pci_save_ptm_state(dev);
> +		pci_save_tph_state(dev);
> +		ret = pci_save_vc_state(dev);
> +	}
> +
> +	/*
> +	 * The device may have become inaccessible while it was being read.
> +	 * Keep the previous header snapshot in that case.  The capabilities
> +	 * are saved directly into their buffers, so they are not protected.
> +	 */
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return -EIO;

I bet we get 99% of the usefulness here by just adding the first
accessibility check above.

This second check only helps if the device becomes inaccessible during
the tiny window while we're saving its state, and I'm not sure that
the extra complexity here and being able to restore a valid config
header with junk in the capabilities is really a benefit.

> -	i = pci_save_pcix_state(dev);
> -	if (i != 0)
> -		return i;
> +	memcpy(dev->saved_config_space, config, sizeof(config));
> +	dev->state_saved = true;
>  
> -	pci_save_dpc_state(dev);
> -	pci_save_aer_state(dev);
> -	pci_save_ptm_state(dev);
> -	pci_save_tph_state(dev);
> -	return pci_save_vc_state(dev);
> +	return ret;
>  }
>  EXPORT_SYMBOL(pci_save_state);
>  
