Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179135E1D8;
	Fri, 10 Jul 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704136; cv=none; b=P1pLWHorBccB1jcITCn6KrEAuHEs2SbG/bZezobfBTmmOO1OnQOD+6xJj3jfdsgfeA2+SmFhtEBZY1DHsa9FVyxwVLstlDE7HBV9J8sejVgqkUV5GWv38/1zgRUPJiOtfnuUrCR8He6amCigh384dMDazafjKjPtNBnQmBsOPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704136; c=relaxed/simple;
	bh=lrlFXK9wQgkeckYdeG5oJhdPd0lU1wwNTbFCgPh0hgk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h1Tf+XEdpUCNoP6zbpCFa51UeTTEYJw/oD+Y0LXfCojK4O2poyqTFofg4y7SQkFHcaAglDXCXfehIsEW+ZtyOwozAGL/WdnyPAS5UDKavwCrrrdUM28oP/+M8IyF0wjdDzrlYOUkXAD3evz+XDrmAMt2M3Tx0eM85fqMlHry4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2ap2bLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2ap2bLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CB91F000E9;
	Fri, 10 Jul 2026 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783704134;
	bh=Z0Pv9tzr/FZMi7xTOe2Z3MlV+9ZplrxaF/7cIABnMMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=W2ap2bLG/mpmp2S/bn7ALpmbTExjyTRUT185oOSQwC1UVX6NFX1iWnJpeMxPtYZHt
	 OLgADLexPerUUcmg+e4+Ciii/WX/dyA3AyGk3Fw1IAS4Z0YU+B4lZAuZ9spwp6cDSS
	 B3viFJCI/tAvb/baddUfPDBKXkYQ51O8+GRv+o3UznHlDCLuskFK+xdPsQWVNl7sH1
	 Eg551RfuBGLMakPczJvtiz99mUpi480R2PAkDXm+JPrg0LXc3jKW8dsSN51g7fjols
	 Tp28aZze4zb9g4g6lIqpG1IbgWdy9F2DDPMX8gfbKQWZKgLjXdmF+1vXWHKyseCVsY
	 ulZJRi4jqXNqQ==
Date: Fri, 10 Jul 2026 12:22:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Braden Zhang <braden_zhang@lecomputing.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brett Zhou <brett_zhou@lecomputing.com>
Subject: Re: [PATCH v2 v2] arm64/pcie/pmu: Add pci id for LECARC pcie pmu
Message-ID: <20260710172212.GA964796@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-pcie-pmu-v2-1-a3d73d4d9051@lecomputing.com>

On Fri, Jul 10, 2026 at 06:24:08PM +0800, Braden Zhang wrote:
> From: Brett Zhou <brett_zhou@lecomputing.com>
> 
> This patch adds support for the PCIe PMU found
> on LECARC SoCs, which utilize the DesignWare PCIe Controller IP
> 
> Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
> ---
> Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>

Bad S-o-B chain ("---" shouldn't be in the middle because things after
"---" get dropped).

Since PCI_VENDOR_ID_LECARC is only used in one place, please put the
#define in include/linux/pcie-dwc.h for now, per comment at the top of
pci_ids.h.

Is this all that's needed to enable the PMU on LECARC PCIe
controllers?  I see that the SoC uses DesignWare PCIe IP; is there
already a native DWC driver that can operate this controller?

Update the subject line and commit log to follow the style of previous
pcie-dwc.h changes.

> ---
> Changes in v2:
> - Format: repalce space with tab to separate the macro name and the value.
> - Link to v1: https://patch.msgid.link/20260710-pcie-pmu-v1-1-1519e580313f@lecomputing.com
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Jingoo Han <jingoohan1@gmail.com>
> To: Manivannan Sadhasivam <mani@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/pci_ids.h  | 1 +
>  include/linux/pcie-dwc.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1c9d40e09107..eb0020f9d366 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -173,6 +173,7 @@
>  #define PCI_VENDOR_ID_DYNALINK		0x0675
>  #define PCI_DEVICE_ID_DYNALINK_IS64PH	0x1702
>  
> +#define PCI_VENDOR_ID_LECARC		0x0720
>  #define PCI_VENDOR_ID_UBIQUITI		0x0777
>  
>  #define PCI_VENDOR_ID_BERKOM			0x0871
> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> index 8ff778e7aec0..1a31fe4db228 100644
> --- a/include/linux/pcie-dwc.h
> +++ b/include/linux/pcie-dwc.h
> @@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>  	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_LECARC,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>  	{}
>  };
>  
> 
> ---
> base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> change-id: 20260710-pcie-pmu-5ef78c56c3b6
> 
> Best regards,
> --  
> Braden Zhang <braden_zhang@lecomputing.com>
> 
