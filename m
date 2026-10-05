Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F472414429;
	Mon,  5 Oct 2026 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242864; cv=none; b=tWoR7xAmjnlzmorMpMtCuwAKjys5GYDbesli5bVDA0w836y62tm1YvFchz8OmASxe5czcQP292lRnWKYpqlcBJcPWImL6YO/IVKWD0OKEx1l8K7EUngNvFNczbRex1csWY6vS0SCiCJLpVrmLMtgEhUJYbsAmaYQw86N5wlW1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242864; c=relaxed/simple;
	bh=aqd8VHRPmQFr5U5I96XinvyJq20NLchrRFnsZ7zEQTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LStPNeXEynd1xRjdclrJivryQS6h13u1jOHf6NoVgWQnoNlAIpEOd60VZ+zn69lGRKqfXfLG16Xl+we2bf4QnXsNe6DgNIgNiPRjC9Xz0kV1wes/QeUvolshE0kWzRSMfbM2r5TZ2iIBnk/D9KwitS+HdNJhE+00nqtEr1nxi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccLkwZLA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccLkwZLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1465D1F000FF;
	Mon,  5 Oct 2026 23:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791242863;
	bh=Hk4nSN1n4Iw0XZzBtZze8RtRb2pN/Wq0d66Aae2ZiSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ccLkwZLA+vTQJQtDHAKltez1/rs2YjIt2DogLykXHRJR1+ec7JqgCf+/nT/X5vRHE
	 s3uC9M/V0irEkuq+u6Zy1U8i1TfCnjP8WdmeDVBnTLvaIXPiPf2v8R1K0kdfOcQOth
	 X6EXMeQn/GSoDCIouuh2Rdx1MACjFGq8WA41nshZIBXlOUFqz/wdHoO+L5rGQ06ywr
	 c8L9mDwkIFkpdaQygCj5MXOvO0OJcwXOoBb26+HeYLlzovSV/fhlzeGf3YPV1bj1ZU
	 5n7gl2JT1lLIX+Bvha1vznbLwH5U4GuoUl+lEwZOxs8SiL4FPTaC5CbahZ1PGsZj8M
	 DLj31WvfBh0hA==
Date: Mon, 5 Oct 2026 18:27:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Stefan Roese <stefan.roese@mailbox.org>,
	Keith Busch <kbusch@kernel.org>, Sinan Kaya <okaya@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Fix struct pci_dev reference leak in
 aer_process_err_devices()
Message-ID: <20261005232742.GA645076@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-fix-aer-refcount-leak-v2-1-bdd1ff1c35a9@google.com>

On Fri, Sep 18, 2026 at 05:24:48PM +0000, Priyank Rathod wrote:
> When an AER error occurs, candidate error-source devices are added to
> e_info->dev[] by add_error_device(), which takes a reference with
> pci_dev_get().
> 
> A device can be recorded without any error status being present: the
> Requester ID fast path in is_error_source(),
> 
> 	if (e_info->id == pci_dev_id(dev))
> 		return true;
> 
> matches purely on the ID reported by the Root Port and returns true
> without reading the device's AER status registers.
> 
> In aer_process_err_devices(), handle_error_source() is called only if
> aer_get_device_error_info() returns non-zero, i.e. only if an unmasked
> error status bit is actually set. It returns 0 if the device has become
> inaccessible (status and mask both read as all ones, so
> status & ~mask == 0) or if no unmasked status bit is set.
> 
> Because handle_error_source() was responsible for calling pci_dev_put(),
> skipping it permanently leaks the reference taken in add_error_device().
> 
> Decouple reference lifetime from error handling by moving pci_dev_put()
> out of handle_error_source() and into the aer_process_err_devices() loop,
> so every recorded device is put exactly once.
> 
> handle_error_source() is static and aer_process_err_devices() is its only
> caller, so no other path is affected.
> 
> Fixes: 60271ab044a5 ("PCI/AER: Take reference on error devices")
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Applied to pci/aer for v7.4, thanks!

> ---
> Changes in v2:
> - Corrected Fixes tag from 1ab4a3c80508 to 60271ab044a5 ("PCI/AER: Take
>   reference on error devices"), which added both the pci_dev_get() in
>   add_error_device() and the conditionally-reached pci_dev_put() in
>   handle_error_source(). Thanks to Lukas Wunner for catching this.
> - Removed the speculative topology list from the commit message. As Lukas
>   pointed out, error reporting is not enabled on devices without an AER
>   capability (pcie_aer_is_native() bails on !dev->aer_cap), so the
>   dev->aer_cap == 0 reasoning was wrong and is gone.
> - Explained instead why a device with no error status can be present in
>   e_info->dev[]: the Requester ID fast path in is_error_source() matches
>   on e_info->id alone, without reading any AER status register.
> - Added a Fixes tag; the imbalance dates back to v4.20. I have not added
>   Cc: stable, since you indicated the path is an unlikely corner case -
>   happy to add it if you think it is warranted.
> - Cc: Keith Busch and Sinan Kaya, author and reviewer of 60271ab044a5.
> - Rebased onto v7.3-rc3+ (f259f446f519); applies cleanly to pci/next as well.
> - Link to v1: https://lore.kernel.org/r/20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com
> ---
>  drivers/pci/pcie/aer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..bc761410d56d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1340,7 +1340,6 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	cxl_rch_handle_error(dev, info);
>  	pci_aer_handle_error(dev, info);
> -	pci_dev_put(dev);
>  }
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -1518,6 +1517,7 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>  		if (aer_get_device_error_info(e_info, i))
>  			handle_error_source(e_info->dev[i], e_info);
> +		pci_dev_put(e_info->dev[i]);
>  	}
>  }
>  
> 
> ---
> base-commit: a077be4fde21ee6e751fa70eb641ef5d9bf2fc48
> change-id: 20260830-fix-aer-refcount-leak-6378f84d62ba
> 
> Best regards,
> -- 
> Priyank Rathod <rathodpriyank@google.com>
> 
