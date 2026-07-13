Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17E34AB14;
	Mon, 13 Jul 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964289; cv=none; b=DvYC35/BLf9SlWh8HgqJ/ij1B5q5ymMmov5bA0ZPYGdB4rIKRLeRCz2PryMs+0dlaKxVH1HJExwhjHfJ46ssT9BCwRpVsXI+GhdAxbw0Ija9tRcQ6twJZqN3NzUHpgw3k7oujM4g+1Y98D6lbEkCdlqTYP9LHIFWdb79AvhMgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964289; c=relaxed/simple;
	bh=e4Le4a/XO49xoPKwxActZDiPyU9GFD3rMtmBS2/DEKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mbq/jFRxrwfxyI0RjzIUgi9EFELYH5khau4bQZeF1adwuX3aLclQ9Wh+NJW9hb7UZwVHpQjmwMKSCkLaAqVAQ6SFDs7fvO0Rjv3aOxjm0C52zV9Tr16TQq4anwRAi7pqopqyA7zyCLt31PAIIqkHktqxQwlbOYjDlcL7J6GEGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpRGkj5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpRGkj5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F051F000E9;
	Mon, 13 Jul 2026 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964287;
	bh=brS1a3wHLMmMrJ1mnZuaz2CJHzmk9TUzRE352e7h1gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BpRGkj5xUi2VeF4JSeRJfrI/tEacQtGkamRdib71RjV+BLRUp0m/GQVjDZU4lDgUM
	 8FtOjk3f08bVDA9n6ww4veFhoPTDRYcavJfvrl/2FbFOTq+HAhIYj+Ije77OmEc0tw
	 MFwLxMdYiGhdssYyzmIUtYIZncUkFJ2G689CNYXXprxujkHny+IUk1mxIysmhQrAB+
	 HUQw1oGn8wB/HJQsiZF2cm6zbIcS2wEZ3ZEW0wD9lwYwh+9oXx18599f4/GtAYrwl2
	 2d0ejVitQfDIXUdpW2SZ/OE6i5Fxgo8n2V6a/eloftQB4D567vu5X+B1mj9vmqNNUu
	 riG7OIo9WTrOQ==
Date: Mon, 13 Jul 2026 12:38:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Braden Zhang <braden_zhang@lecomputing.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brett Zhou <brett_zhou@lecomputing.com>
Subject: Re: [PATCH v3 v3] PCI: dwc: Add pci id for LECARC pcie pmu
Message-ID: <20260713173805.GA1223423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com>

On Mon, Jul 13, 2026 at 10:10:13AM +0800, Braden Zhang wrote:
> From: Brett Zhou <brett_zhou@lecomputing.com>
> 
> This patch adds support for the PCIe PMU found
> on LECARC SoCs, which utilize the DesignWare PCIe Controller IP
> 
> Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
> Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>

I gave you some comments but did not provide a "Reviewed-by" tag, so
including one here is not valid, see:

  https://lore.kernel.org/linux-pci/20260710172212.GA964796@bhelgaas/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v7.1#n539

Also relevant:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v7.1#n134

In this case, you could say something like:

  Add support for the PCIe PMU found on LECARC SoCs, which use the
  DesignWare PCIe Controller IP.

Wrap it to fill 75 columns.

In the subject line:

  s/pci/PCI/
  s/id/ID/
  s/pcie/PCIe/
  s/pmu/PMU/

since these are all initialisms, not ordinary English words.

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
