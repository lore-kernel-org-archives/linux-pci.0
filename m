Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF93403EA;
	Mon, 13 Jul 2026 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919673; cv=none; b=fRkwkLN1MdGsM6DpYmQM9etisfwZWxZGyVQaoNPAzsYJa0tg09ER4Uy2YIDGLWsMZHy4q/iPqSnIoveu0d7fnjkRZ2TyF1og7NIAspQJCyXXGXW801WGa5yMjpiA2WdXrKZZMU7pk7Gd0XVfyJ22xikkYVSiZg8neL/w+fZm1sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919673; c=relaxed/simple;
	bh=xISxuLHfFA2I76o7F2/uv4F6oYQOyCZQGpSF7wIqw6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKDi/i7kxLQY1XPU6jBVXpDiJHTQsmkdmVLzvBWzccmKtHao4FYA58/FQPz4Rr8934WMp47WCQG9QZh/WVqiKd21IcnwT7PzSJhNVwiKJEb5WXiPHWkmdlH4ZJTEHOQ22GwqD47H9K9c/v6n7icxIwI4qyf8F6kzNw25VH2Bo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4LCfveb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4LCfveb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2441F000E9;
	Mon, 13 Jul 2026 05:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783919672;
	bh=LGe4cC+fxlcufIbt/7+xQJgGjNUjrERef3oGajm6MVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e4LCfvebssK8ZgBgu/gO+HH1/V/ZXSbJvNQLe9QMl7bblLai6GNPDrhaVMRdmn4/T
	 09XXDUkFTN/N1mZY/qk3ndX1ox5pmXJUqNLwvAP+c0+EcbUFqlVTZVxjY2IPXXOM7R
	 l9g1G+VH037R6w9jyCZapQ0VzMetm3M0viRaSL6EmMUNbMT0m++shZTHqCrwDxADeU
	 yObHNLLg71Q4Z1dm17+1t46mycZSB6jA3bVp6pmR3XCn/yjNbUevG9Q9BPW/DHWuj1
	 RQeczbp12jqbLFNrKwFvX5GoTZ4PsA0DBtk/8p89Lzv0EhcrflA0f7M/p63w2bAaSp
	 jXP7Yq2TjVg8w==
Date: Mon, 13 Jul 2026 07:14:25 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Braden Zhang <braden_zhang@lecomputing.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brett Zhou <brett_zhou@lecomputing.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 v3] PCI: dwc: Add pci id for LECARC pcie pmu
Message-ID: <aik4muvixggxmphxjlpsr4kbfw3sxuh5pj5u7g3olhlg65shfp@kaqahgep3kdu>
References: <20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com>

On Mon, Jul 13, 2026 at 10:10:13AM +0800, Braden Zhang wrote:
> From: Brett Zhou <brett_zhou@lecomputing.com>
> 
> This patch adds support for the PCIe PMU found
> on LECARC SoCs, which utilize the DesignWare PCIe Controller IP
> 

LECARC looks like a ACPI based platform. I'm wondering how you are able to make
use of this patch without adding the ACPI ID support to enumerate the DWC
driver.

- Mani

> Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
> Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>
> ---
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
