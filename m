Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71F2E7635;
	Fri, 14 Aug 2026 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691008; cv=none; b=nJ9rBYDqsncCG2IqNgnAJieR69ZV7jUfl8EnOmakacT25PyNnqplwqAgb8qW+uWNFVe/PH23e25WiZ5a7Wnro3m/umxTXzeBF3HZrkaoytdbmsu6ZVP+vEB21yFPiluNSUf7d8u/GRxba+mzPvwquks9yC5pkTSmG2HJWuuOR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691008; c=relaxed/simple;
	bh=Yh4DoZwpFiLDdoghU9b+dKN1YbRjRORkIsZZHBicjsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqwBH0PrJ7vtJXJgPISN79+dRgNqctf8HY2kZTMl8eQu/uVFgeHgdgw/cNcj8vjRKntJ/tvu2JN8t0Ocey3aL5+IrFDVEsl/bGh7CUT9/FgwodCVFZbxcIhtpXZZ1LAVM6YvIVKTV2ufQCPeME7X2X8Uz0MF9dtCoCfY9eD4RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLfB+Puq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLfB+Puq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41981F000E9;
	Fri, 14 Aug 2026 07:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691007;
	bh=ZYXo8w/rTP00+xZ3MtiFfLpKjmkuklxmwlv86j+0s8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fLfB+PuqnQIrWXVAS628RzMA8bCYU8Cmcfwu2g2se98RGm9BVXLqHKl/FyV79LLhk
	 WIEqA2svANPK8myhgiWRJjrie0YGALChEkQoPKWLHqFHklN99MOAFsFF5Xw7iBUTrv
	 GkbRD9lp4nMLRNtD6Q1rxY7PtpCW1d77/OxizMuIvg+VBVaoNoLMDypIl97pzrltmg
	 LuKUmM6BUkG31jgPMqGajNuyzOGgC8f99fh+ne59hthOuoiUK4XuaDpv1lAAes2zri
	 zAzxOyYrHMoGzcsVkOtgKCHSxhycsmoz0H8SR135DLLTkPHkayVJhe9GQMDFCVMtmZ
	 xpYc6y/6QlwHA==
Date: Fri, 14 Aug 2026 09:03:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, bhelgaas@google.com, 
	daniel@riscstar.com, mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: tc9564: introduce base PCI driver
Message-ID: <20260814-rainbow-alchemical-gaur-9fd8de@quoll>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813222943.1655453-3-elder@riscstar.com>

On Thu, Aug 13, 2026 at 05:29:42PM -0500, Alex Elder wrote:
> +static struct pci_driver tc9564_function_driver = {
> +	.name		= DRIVER_NAME,
> +	.id_table	= tc9564_function_id_table,
> +	.probe		= tc9564_function_probe,
> +	.remove		= tc9564_function_remove,
> +	.driver		= {
> +		.name		= DRIVER_NAME,
> +		.owner		= THIS_MODULE,

You just copied some old driver. Why do you need this?

> +	},
> +};
> +module_pci_driver(tc9564_function_driver);
> +
> +MODULE_DESCRIPTION("Toshiba TC9564 PCIe Embedded Function Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6501c949c5b76..b484f1b1d0e71 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6388,6 +6388,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
>  
>  /*
>   * Devices known to require a longer delay before first config space access
> -- 
> 2.53.0
> 
