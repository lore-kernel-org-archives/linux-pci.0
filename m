Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546719;
	b=yhSHigPD0M6NbEppAB2MeTeA5kkdfCd3pTjSnExN0YWErUxowaN0hfuYqeEpZt1yn+uZ
	 B6dkVptu5xfKOqNbcI7/OHLpn1+H5b733y9/CfqfOtzI4a3tf0lQxSOYp1vyQclxUvmuw
	 BEJ9w1LN4y3o5vjdNGygoo9IoBDDHRRR1KBl5QptCB6bCYaAWgW5pbDRE5C199JnYWDm0
	 CvVDbiSJ4B/YStFwxEDMCXmCtU0N6QlaoB1sXCd/Bei4GdHryx32X9xbOrYBQ+udNc+Eo
	 ZD3U7js+ffWJ9EW49yx3aN0JvOyU0TmHR3s/xekm84MlGToWcD0Hmzwo2oSTv72B+MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rKVd0WB9GKER5oLiGhqXKhoz1U/fSQCfKOepi4KUjiM=;
	b=RaWcbb9Sih+h8TsYPWwnrmA/0LamXsUtp6vPYb+uaCaEuXh/A78iASQiZBh2I8DKX+lV
	 SFXiJtdWOKq5+BK+4NF+bJQwfZqCG1Jo1w6YoY9GawmDtePE2NxjWEUktn6eRAb8iaLj2
	 13uPkNc/m3DTo53lNP8wbcr1FluH05jaZ/nnq6uTe6ZcSnQqXLt3Ow7QHovKhOHWNT3gp
	 cNXpTToidnVw2kZ9WjQWIc6vuhXbQ/Gw/aKRESEcVk9R1YfimQ6+kQuIy/Wp0hchAzyzV
	 hoAI42Nx/8SBlf/q5/8LafI0tfIEwa7e9qEtRASO0wb7KnjgLpBNz4p+Z2aoS11+XMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bDP7tg7r;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F136606A68F
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 18:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F136606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bDP7tg7r
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4b52fcb410dso1272527f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 10:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795546716; x=1796151516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rKVd0WB9GKER5oLiGhqXKhoz1U/fSQCfKOepi4KUjiM=;
        b=bDP7tg7rXIWgB+hAPfjr5hkfXqq3/feAOEYjiTHuNZrQlhTtTN46nfDNyfwQbJPZFF
         9dIgjYOemEri6j3ST+69bdA6wEwAor2eTWvN7U35JZAsxdhhRIUlxX9rIE9vYUa4xshh
         me3UKBz9ojnotyqPz1jk4D5mb5c58YTf5H6Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546716; x=1796151516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKVd0WB9GKER5oLiGhqXKhoz1U/fSQCfKOepi4KUjiM=;
        b=Uvg9BrIkvKn6qN9s3D4xXsMLKviZayq4OIHbFTMr+l7AbzgU0o/0Ii16o8E4zo3kXE
         zOOpVm4Ujjk6hk2mdzHkTnHRI0PrhvKgvh8V5BiGbBvW0WE+0BQZnojFZN1U8hQSXxmH
         /MH9h68Y7tfSqYOXOSH8x4GN/XGwo2s/lMBN3UPyHHfngHAK2vCOmZsm+phEggZO3MjS
         EwSLLpiccQ/O+Cybykui9jiqjHkBiaIdiCuCUX8qWfdHRwABO36I3EH1m9L3C9Rhpawh
         xsYws7nXhIcOii6mXGWdOb+jLrVFWAXpOgjSFU8e44D9oOwXUMLvhR5Ph9Qb5A/Kayey
         zTAA==
X-Forwarded-Encrypted: i=1; AL+hErHxJvtixA0KOwimdFntDF8aAqhqtmz1fzfS6HsPjzMzQoOLhUoce9lIZcGAprt6SxQtTle0nzqrk9I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xI0sYT2QiQS/ljw/3tGUoKh2QlbfwoAc3KBTTRLfOsmybej5S
	atkaa86ZKH6F9kDpzWs7MZyozgD2APJpZ3Mdug3FZVEPl9R2p9aZJxqgjfBZxMIpag==
X-Gm-Gg: AZFdTZeaqj8ZC8bLp+EBTBz5Z6LIe00Ac2XisvWwbd9xYy1Wb3MZI/ClVgfm5YYcpbk
	M1aCGNLM2ZHLrd1i8b4iUboQqFmwfc4skS5WmOLM03D5heVW9NKHytzoNEOp3IPL31c/b0c9u3d
	bpjuzzhkLclurd0qPKC8tOsPcbW4tOn+e2xDPry6waLM+hertkeWKbnzdOqmCHflBtKHTn6wUX9
	RrrCCFX9N8JGTppBmmMjt3fiYHeLizyLtTjsDGAcNeqaLfoddyr3CTe64cVJvhFmjm7h7fAJ9Ak
	XdJNkiihv6wPA5OU+GyX2zWSdXiTJcnvC4uWDH4Zg8idHwJtYnZYIGOo/uoBEKr2hunVlm79OCF
	AgG3tUZZDJHhRtizRP197Ge2rRgzql/wUOBY5Epaa9URb8bEmpOTKesOBfQSWw/afp5FBzxc76E
	me1QvCyz1cHAwrxmLRbro+TGwu+JmUYmbpV2yNVkvrGUFgUYXX5g+PMwyCJXXPZxpz6nKaf+xnu
	j/4xcwAboH5xUWiWWNEc/NFESc7Z+qEaD3vbNV1eAENOe1ixKzlgus1rw/EXUnf7Rr3gS6bL/I7
	T/2VrP70xis1/4n7gUrF02ZPiL3KEfOI68LAfGWKtsAQJc/XEm6612DcVR9Dcxsb
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4bb8881b8e4mr321879025e9.17.1795546716413;
        Tue, 24 Nov 2026 10:58:36 -0800 (PST)
Received: from google.com ([2a00:79e0:285b:8:af0c:c5f1:ee8a:b81f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm445870355e9.15.2026.11.24.10.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:58:35 -0800 (PST)
Date: Tue, 24 Nov 2026 19:58:31 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Torokhov <dtor@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, iommu@lists.linux.dev,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Joshua Peraza <jperaza@google.com>,
	Jesse Barnes <jsbarnes@google.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Tomasz Nowicki <tnowicki@google.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: Re: [PATCH v11 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Message-ID: <awXeV5Jo4WTjLc8c@google.com>
References: <20261123235845.564027-1-dmaluka@chromium.org>
 <20261123235845.564027-2-dmaluka@chromium.org>
 <sashiko-outbox-230247@kernel.org>
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
In-Reply-To: <sashiko-outbox-230247@kernel.org>

On Tue, Nov 24, 2026 at 12:15:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] PCI/ACPI: platform_optin_force_iommu() ignores DmaProperty
>   devices
> - [Medium] PCI: SR-IOV VFs do not inherit untrusted flag from
>   DmaProperty PF
> --
> 
> commit 534ec8c0dc4ebcebaa88d905d9760f867ca5b38f
> Author: Rajat Jain <rajatja@google.com>
> 
> PCI/ACPI: Support Microsoft's "DmaProperty"
> 
> This commit adds support for the Microsoft ACPI _DSD "DmaProperty" to mark
> PCI devices as untrusted when the property is set to 1.
> 
> Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 1150f2fbabf41..5971ffc2a375a 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1427,12 +1427,34 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
> >  		dev->external_facing = 1;
> >  }
> >  
> > +static int pci_dev_has_dma_property(struct pci_dev *dev)
> > +{
> > +	struct acpi_device *adev;
> > +	const union acpi_object *obj;
> > +
> > +	adev = ACPI_COMPANION(&dev->dev);
> > +	if (!adev)
> > +		return 0;
> > +
> > +	/*
> > +	 * Property used by Microsoft Windows to enforce IOMMU DMA
> > +	 * protection from any device, that the system may not fully trust;
> > +	 * we'll honour it the same way.
> > +	 */
> > +	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
> > +				   &obj) && obj->integer.value == 1)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> >  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >  {
> >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> >  
> >  	pci_acpi_optimize_delay(pci_dev, adev->handle);
> >  	pci_acpi_set_external_facing(pci_dev);
> > +	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
> 
> [Severity: Medium]
> Should platform_optin_force_iommu() also check for devices marked via
> DmaProperty?
> 
> In drivers/iommu/intel/iommu.c, platform_optin_force_iommu() only checks
> has_external_pci(), which tests pdev->external_facing:
> 
> drivers/iommu/intel/iommu.c:has_external_pci() {
> 	...
> 	for_each_pci_dev(pdev)
> 		if (pdev->external_facing) {
> 			pci_dev_put(pdev);
> 			return true;
> 		}
> 	return false;
> }
> 
> On systems with CONFIG_INTEL_IOMMU_DEFAULT_ON=n where firmware sets the
> DMAR platform opt-in flag and marks internal ports or devices with
> DmaProperty instead of ExternalFacingPort, has_external_pci() returns
> false.  platform_optin_force_iommu() then returns early without enabling
> DMAR_FORCE_ON, and intel_iommu_init() disables the IOMMU, leaving those
> devices without DMA remapping protection.

Makes sense to me. As I understand, prior to this patch,
platform_optin_force_iommu() was technically not buggy, since
pdev->untrusted was only set for devices downstream of external-facing
ports; whereas with this patch, internal (e.g. SoC-integrated) devices
may also be marked as untrusted i.e. requiring DMA protection, thus
platform_optin_force_iommu() should check pdev->untrusted along with
checking pdev->external_facing.

Baolu, do you agree?

> [Severity: Medium]
> Do SR-IOV Virtual Functions inherit pci_dev->untrusted when DmaProperty is
> placed directly on an endpoint Physical Function?
> 
> When VFs are created via pci_iov_add_virtfn() -> pci_iov_scan_device() ->
> pci_setup_device(), set_pcie_untrusted() checks pci_upstream_bridge(dev).
> Because pci_upstream_bridge() resolves pci_physfn(dev) first and returns
> the bridge upstream of the PF (or NULL on a root bus) rather than the PF
> itself, and VFs do not share the PF's ACPI companion, virtfn->untrusted
> remains 0.  IOMMU and DMA paths then treat the VFs of an untrusted PF as
> trusted.

Yeah, similarly agree. Looks like pci_iov_add_virtfn() is implicitly
relying on an assumption that pdev->untrusted is *only* true for PFs
downstream of external-facing ports, which happens to be the case
without this patch, but is no longer the case with this patch.

...Although, independently of this series, looks like
set_pcie_untrusted() is completely buggy on non-x86 since v6.13, since
it solely relies on arch_pci_dev_is_removable(). I've just reported that
at https://lore.kernel.org/all/awXXSfrhLHK7TNbp@google.com/
