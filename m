Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7526F293;
	Wed, 25 Feb 2026 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025913; cv=none; b=GlW5MeYfSNKdkZN50yLiJXtN9tCpz5CslCoPgOrGfPzrFayPEKQG7+AiMII7Zc4FvmoIc3DaKLStV8xUsVFwxTEUEklkiC/VH3mk1BltOqHnDr5PciGXodsEtPgwCwgYNdMFAlM3wXQ8QV9mHy8LDtk6EM+hELXYZ5HtGkDLcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025913; c=relaxed/simple;
	bh=mAJmjo+WQ/SOXuG5lH3nrurqWJdwbMc7DVrXQkrzHxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbbzir+bMfmlr3xudjZVSHsOR/HnsYjJ1yFAcNB3Uwz4MABR2bfH9NTDcetbRVLFZkOpdSEcBQt8uURGPkimjlHZIncw65G+8IuC/f3kwcJxR856/ri6wrCxNT3SwGNZ9MN6VR+dx/epN3JU9a/glJto2Wqg0t43eughXXPH+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txZoV1Y3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txZoV1Y3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDCCC116D0;
	Wed, 25 Feb 2026 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025912;
	bh=mAJmjo+WQ/SOXuG5lH3nrurqWJdwbMc7DVrXQkrzHxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txZoV1Y3dtStZsn0jFEESEMRE0e9n40zHXs2eDyL+aEe3v0J4kZH5JZY4/BwDZrPt
	 YCr/U29ofvF2l41r1S3ULn95YgOu/14MdV8VsTNQUn147LOKhKA0H+mGYQETV5du0q
	 HIQASwuvoTbmSG2xXDie5cNiXSLR4opcEmIBSNwlNpMaYj98DtjbNP1Fyp+pMAcyj9
	 b9eaoW2RC6rd2LLcfQs5O29mqyqzP+rmCo0eZOjLs9v8D6C7OcLNtpuP9hN7O7Ys6i
	 FhIRZeQy+BT4M5QLia7tUEsjtqdt+Xbw+Ey13rjfzhpAom5nc8AI4p2JDQQWHRzxKA
	 AYQZezb5wqRng==
Date: Wed, 25 Feb 2026 18:55:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] PCI: mediatek-gen3: add power control support
Message-ID: <knddbvl6qti4pyaphudrmhbx7jm245tsmpa37snk4frtphcuz2@am6aatvc6hbr>
References: <20260225072225.3345307-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225072225.3345307-1-wenst@chromium.org>

On Wed, Feb 25, 2026 at 03:22:17PM +0800, Chen-Yu Tsai wrote:
> Hi folks,
> 
> This series adds power control support to the MediaTek PCIe gen3
> controller driver. This allows proper modeling of WiFi and NVMe
> adapters in the device tree and control over their power supplies.
> 
> Patch 1 through 4 are cleanups and minor improvements to the driver.
> 
> Patch 5 adds power control support using the new pwrctrl API to the
> PCIe controller driver.
> 
> Patch 6 adds the WiFi and BT power supplies for the MT8195 Cherry design.
> This is actually a M.2 E-key slot, but support for that is still WIP [1].
> And even with it merged, support for the USB side still needs to be
> figured out.
> 
> We can either merge this as is for now, and do another conversion later,
> or just keep this one out. However this is still an improvement over
> the current device tree, in which the power for the slot is always on
> using a pinctrl setting.
> 
> Patch 7 adds the M.2 M-key NVMe slot found on MT8195 Dojo Chromebooks.
> This change actually makes use of the M.2 pwrseq driver.
> 

Thanks a lot for doing this! I'll also try to get the Key E support for v7.1.

For the whole series,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> 
> Please have a look.
> 
> 
> Thanks
> ChenYu
> 
> [1] https://lore.kernel.org/linux-pci/20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com/
> 
> Chen-Yu Tsai (7):
>   PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with
>     dev_err_probe()
>   PCI: mediatek-gen3: Add error path for probe and resume driver
>     callbacks
>   PCI: mediatek-gen3: Split out device power helpers
>   PCI: mediatek-gen3: Disable device if further setup fails
>   PCI: mediatek-gen3: Integrate new pwrctrl API
>   arm64: dts: mediatek: mt8195-cherry: add WiFi PCIe and BT USB power
>     supplies
>   arm64: dts: mediatek: mt8195-cherry-dojo: Describe M.2 M-key NVMe slot
> 
>  .../dts/mediatek/mt8195-cherry-dojo-r1.dts    |  38 ++++
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      |  47 +++--
>  drivers/pci/controller/pcie-mediatek-gen3.c   | 185 +++++++++++-------
>  3 files changed, 183 insertions(+), 87 deletions(-)
> 
> -- 
> 2.53.0.414.gf7e9f6c205-goog
> 

-- 
மணிவண்ணன் சதாசிவம்
