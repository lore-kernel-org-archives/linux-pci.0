Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837363;
	b=5n+92hHAW01aMHVtDePCs9DtOKhjwB3SjtwvxCQ+jepgDFSrgwtw/qw/QVE2y31io0dU
	 J8qKZmx+gBgGZJvFFaqM5URdFbSlrg0KQeqqEdx5Mfktpbi6ns2g3ypYeUgFDrPaNh7To
	 uy4/uFMLeJA9CGkhsdFzr15Of5xbXG6LlLmVEw9fskX0PsBA5mlpc6YgqrdT4BpY3F7D5
	 WMWzWrgMl6iV1oKFZubJaqyQHMFzkfo+Th+MpXY7AtuG1fuItkcCdnW+6aGCjiNAD3gzW
	 krRcVIaOzjYP8RQ3pU9eX7SYJttSt1MQFSmbXbt1c8XYfooODogAIvYn49qvMrzmmwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837363;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NKXzOfToa87zMXfMlEIzFY3Ksu9fdXYOSMLur3xYKW4=;
	b=tY8IElpm/PD1Vkl1rElVLG8pSTFcqcC9HyZwB8bcyOtjd3J/C7oXMZD87FLiPfbL//3g
	 vGdLoPDHJMNOhX22fWeiPFesCaud7YcTohHLdwBGzEzZmum7BvXWXD5ytBetFJGUy/20y
	 t4HAX6jgkBh07KK01uim6FZF2ccrzVd38THFdbvRLBRc94V0AHFn1CRXKcPMpF506SthA
	 Gb7ApfjNTqMJ1FX9JovqAgb2yRgs/v6OXo90FN0SNg5J6W5sEBISyX3YGS2ZtQDoTX4NP
	 syE1qgOTWoVifKvoGU7Iuh55PKqPX51RqvYn6kJzq5h4V05QnMMLGeSHTmaWDKGG7Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2r3ilxl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C19606A336;
	Thu,  5 Nov 2026 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2r3ilxl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755481F000C1;
	Thu,  5 Nov 2026 00:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837362;
	bh=NKXzOfToa87zMXfMlEIzFY3Ksu9fdXYOSMLur3xYKW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=I2r3ilxlzKe858yvvM/0L3TsobO3AlHQ9pkeByAwg1L+qCV8xlbpwF/PhiQIJM+9W
	 5+YtsOCGmFyBsBBDfTfO0hMOl6BrAu7GxN0ZJzpwFt3z4/yyTBR77GtYA4FT4pHWNc
	 c01Vwr8mDwkKgE/+XMkXJ/65yIHnUAEFrEs8bD0+44x23jMc2esPIwy5WTD0AC2wF/
	 0o5DWU69dlJv5rj3B9q5ox5RaIw8bDXdCBXV31E67zBxcRXkkNKz+1mxGZyIwSIva6
	 YDI/be4R587oGqSmte1nUGzAb8iceYEZ0BwxlEwd/XiOI8RNVGKe9yKijSGwMkmwPB
	 ORgtLKVJcCYRw==
Date: Wed, 4 Nov 2026 18:09:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, joro@8bytes.org,
	Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/5] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Message-ID: <20261105000921.GA1478400@bhelgaas>
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
In-Reply-To: <6c09d2f78d4bb9db7f49fa14a6550f5176721121.1793729707.git.nicolinc@nvidia.com>

On Tue, Nov 03, 2026 at 10:33:43AM -0800, Nicolin Chen wrote:
> cxl_reset_bus_function() reports "supported" to a probe after checking only
> that the upstream bridge carries a CXL port DVSEC. The underlying bus reset
> can still be unavailable, e.g. on a bus shared with other devices, so both
> the reset_methods[] array and the reset_method sysfs node end up listing a
> "cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.
> 
> Probe the underlying pci_dev_reset_slot_function() and then, if it is not
> applicable, pci_parent_bus_reset(). These are the same two checks that the
> actual reset runs, so a shared-bus CXL device no longer advertises a method
> that can never succeed.
> 
> Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
> check rejects every CXL port with a masked SBR, while the do-reset path in
> this function unmasks the SBR before resetting. Such a port would wrongly
> probe as unsupported.
> 
> Move the port control register read above the probe branch as well, so that
> probe runs the same checks. That read asserts no reset, and a failure means
> the device cannot be reset this way, which is a probe-time answer.
> 
> Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
> probe is always false at that point.
> 
> Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 38b680e7c3d60..e9b06b360850e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5075,13 +5075,21 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (!dvsec)
>  		return -ENOTTY;
>  
> -	if (probe)
> -		return 0;
> -
>  	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
>  	if (rc)
>  		return -ENOTTY;
>  
> +	/*
> +	 * Do not probe via pci_reset_bus_function(), which would reject a
> +	 * masked SBR that the do-reset path below unmasks before resetting.
> +	 */
> +	if (probe) {
> +		rc = pci_dev_reset_slot_function(dev, PCI_RESET_PROBE);
> +		if (rc != -ENOTTY)
> +			return rc;
> +		return pci_parent_bus_reset(dev, PCI_RESET_PROBE);
> +	}
> +
>  	rc = pci_dev_reset_iommu_prepare(dev);
>  	if (rc) {
>  		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> @@ -5096,7 +5104,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  				      val);
>  	}
>  
> -	rc = pci_reset_bus_function(dev, probe);
> +	rc = pci_reset_bus_function(dev, PCI_RESET_DO_RESET);
>  
>  	if (reg != val)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> -- 
> 2.43.0
> 
