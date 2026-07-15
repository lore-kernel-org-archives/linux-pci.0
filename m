Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94937B003;
	Wed, 15 Jul 2026 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095808; cv=none; b=QC6qFzkOSowkAnyUNSuwFiA0bv9B34iSluYRGA/4Z8y/9sGSmNLt4PFLLFQSGST2V/G1APD+0+Gpj2nEsUd0KhHMn6E/g8bHOnwa++bj+yDCtYWStH698j1uZm08mzltD8VMmDPE3qbVRC5YHSw5ZDBZ3g+5iaLSIkSTHfWMvug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095808; c=relaxed/simple;
	bh=i69pTQwbPyHRaFdVoZKDZrlYymaUNi6Hc7VaMhtRQQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeetxLRGySMTJsXQb0w+CiiMI//lknH5kheYWt1v6aam7Nv92p9+biVT8h7iGECb8pCIxJTbjXdtli1QqdhDjSWeidIhlNo2bzi5nypC7VvT4ah0lvaeGrTUyKXantL5GqO1MuKitDR/WQiX7D36QjCj0VNnWDsG2680mE73nJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbIUfzDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbIUfzDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC631F000E9;
	Wed, 15 Jul 2026 06:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784095806;
	bh=BXuL9Bx18R87pmFMxogMJm6G2DpvtxgkFyGun3VuelU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nbIUfzDfQ2pah5WIVihrIqvunZ+4KeymhXUhq+5c8qaJwrarHvGRFasvtMfvRSOB+
	 MOy0S0mOZI8Tn3W1GUbOFqAF1XCU2L6AQOgbw5mVUHLoo1fpVDYYAwuqkjLWyWubqc
	 PnXH6KGOzzC9NzPw3tZTIOqfbWbLMmHSYCREaOydx6Q43jb4Z5RE+oj+GWtpgPfYsN
	 y8LgzPA8UGdJUTZaaikoWruR2fALtq32Xw+P1zFsxvXWW+QADOSqPGuneZ4JplWEpC
	 +QWxuBzAtfJV6vY5nUZALFyGFEQHpujDTE/jZHMGSLcitmKp+8PAfpJ5fGxqK5JpVL
	 8YMTtSltIlXGQ==
Date: Wed, 15 Jul 2026 08:09:59 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>, Henry Chen <chenx97@aosc.io>, 
	Han Gao <gaohan@iscas.ac.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2] pci: loongson: Avoid L0s on LS7A1000 PCIe x8
 [0014:7a29] Root Ports rev2
Message-ID: <fcyxb25p276wypwmuwczmj47iwgwywrmvybfuo2zusswb6g4yq@qsj2rllfe7rp>
References: <20260623173648.222922-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623173648.222922-1-xry111@xry111.site>

On Wed, Jun 24, 2026 at 01:36:48AM +0800, Xi Ruoyao wrote:
> Commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms") has broke booting of a Loongson 3B4000 + 7A1000
> server with an Intel 750 Series SSD.  We also found a Loongson 3A5000
> board using the same 7A1000 bridge chip exhibiting the same issue with
> pcie_aspm=force and pcie_aspm.policy=powersave (ASPM is not enabled by
> default on the 3A5000 board because it's based on ACPI and the _OSC
> method has not been implemented in its DSDT/SSDT yet).
> 
> This seems only affecting the 7A1000 chips shipping the revision 2 of
> the PCIe x8 Root Port: on other two boards with a (persumably older)
> LS7A1000 bridge chip utilizing the revision 1 of the root port, the
> issue does not reproduce.
> 

Can you share some error logs? In the comment below you mentioned "read
timeout", what does it correspond to?

Adding error logs in the patch description will help others experiencing the
same issue to find this patch.

- Mani

> Cc: Mingcong Bai <jeffbai@aosc.io>
> Cc: Henry Chen <chenx97@aosc.io>
> Cc: Han Gao <gaohan@iscas.ac.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
> 
> Changes from v1: rename the quirk function into a style similar to other
> quirk functions in the same file.
> 
>  drivers/pci/controller/pci-loongson.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index a4250d7af1bf..235b44859b53 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -212,6 +212,19 @@ static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
>  
> +/*
> + * Some devices, for example Intel 750 Series SSD, experiences data loss
> + * (read timeout) on LS7A1000 PCIe x8 Root Port when ASPM L0s is enabled.
> + * This seems only affecting the revision 2.
> + */
> +static void loongson_port2_aspm_quirk(struct pci_dev *pdev)
> +{
> +	if (pdev->revision == 2)
> +		pcie_aspm_remove_cap(pdev, PCI_EXP_LNKCAP_ASPM_L0S);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT2,
> +			 loongson_port2_aspm_quirk);
> +
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
>  	struct pci_config_window *cfg;
> -- 
> 2.54.0
> 

-- 
மணிவண்ணன் சதாசிவம்
