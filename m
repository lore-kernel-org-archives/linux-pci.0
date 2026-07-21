Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20423F7A8C;
	Tue, 21 Jul 2026 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615791; cv=none; b=juPsP8QnXu25DLvZu08H3QBUeHfmgBpqpysawYHgUAlfeUnPoZjoE5Auk7GPWXWo6FqGPo00ngzKY8U7CRWsVygLRcDLyr4hKBbFGXIyYO6AQFGI0st1GQKhfjHdOvljg9PgpGH4+f/hNHRFTlxIlgRqLJtNFLnL34Xc308qxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615791; c=relaxed/simple;
	bh=mlRKkuZZgjYcu6mD/lL3A3cu4son5zMeu6AizUl9gm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edJJDj+Hnsc0pZg0pUr6Ugg6KJNkPBfRoxJNwsSvEH7ClLwnBP4mJ94xy/vhRdnjWb+EpeIkbuU01Diykhcmaas+uCnh38fX370q71+Sex+zNzWWZ6k6X4dfoB7Dn4CbaxQjFNO2D5rZXEY7/fjdi2EZQYzrVjfb4n/qAev0j6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvhc5Li0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvhc5Li0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25EA1F000E9;
	Tue, 21 Jul 2026 06:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784615790;
	bh=RNkw+kUWMuWUytOjX918yZ5H5yPyNAI0DYcYnFaRgD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jvhc5Li0dRAjgyQA/ffcFzFknV7O662dy2lVj1y2WpYYtfNSiEx4Yn+WvxojR2sGc
	 tRbxw1Z0E7nhVO4MxhaAWb3Up7c2ivfvLdDyEDa1TdEgRGT+XCVJlKyuijDLH1VjiF
	 FbQKbB6FIIhUPceH8FiWgHpkNwCl9xeYsgWzI/3S6lnfLp1ArjnkZzlCZZcJNI+htM
	 iM0GdqZ+Sow5giapNDw0hXRiaJ5gQF15O1pTBPCs3zRxV3cIqgt7qbINFppAW/I+Oy
	 zAz8jK+U1NxOJydlSyVsELJH0gwlsHgVzHnpbLlr0Wu4TemudEWH5OocCCcukjnis9
	 Gl/StrlmHPS5A==
Date: Tue, 21 Jul 2026 08:36:23 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Braden Zhang <braden_zhang@lecomputing.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Brett Zhou <brett_zhou@lecomputing.com>, Lumin Liu <lumin_liu@lecomputing.com>, 
	Notics Zhang <Notics_zhang@lecomputing.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 v4] PCI: dwc: Add PCI ID for LECARC PCIe pmu
Message-ID: <va5ueoyw7igqh3bx3fnlhrylzecstkzcf3jvb4kylio45dvpjf@ydfnnczmej5i>
References: <20260721-pcie-pmu-v4-1-850a4e695b19@lecomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-pcie-pmu-v4-1-850a4e695b19@lecomputing.com>

On Tue, Jul 21, 2026 at 02:21:13PM +0800, Braden Zhang wrote:
> From: Brett Zhou <brett_zhou@lecomputing.com>
> 
> This patch adds support for the PCIe PMU found
> on LECARC SoCs.
> 
> LECARC platforms use the standard DesignWare PCIe Controller,
> and the existing DWC driver already handles the enumeration
> and basic functionality through the generic PCIe core.
> This patch only adds the PCI vendor ID to the vendor-specific
> capability (VSEC) list, which enables the standard DWC
> RAS/DES feature detection.
> 
> Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
> Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>

I don't know what's wrong here, but this message id
(20260721-pcie-pmu-v4-1-850a4e695b19@lecomputing.com) is not found in lore. So
can't apply with b4.

- Mani

> ---
> Changes in v4:
> - Doc: Update description for the DWC RAS/DES feature detection.
> - Link to v3: https://patch.msgid.link/20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com
> 
> Changes in v3:
> - Update: move definition to pcie-dwc.h a
> - Format: Update the subject line to follow the style of previous pcie-dwc.h changes.
> - Link to v2: https://patch.msgid.link/20260710-pcie-pmu-v2-1-a3d73d4d9051@lecomputing.com
> 
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
>  include/linux/pcie-dwc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> index 8ff778e7aec0..0df5fa81b561 100644
> --- a/include/linux/pcie-dwc.h
> +++ b/include/linux/pcie-dwc.h
> @@ -11,6 +11,8 @@
>  
>  #include <linux/pci_ids.h>
>  
> +#define PCI_VENDOR_ID_LECARC           0x0720
> +
>  struct dwc_pcie_vsec_id {
>  	u16 vendor_id;
>  	u16 vsec_id;
> @@ -32,6 +34,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
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

-- 
மணிவண்ணன் சதாசிவம்
