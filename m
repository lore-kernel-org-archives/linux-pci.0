Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE23E63BA;
	Wed, 18 Mar 2026 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851425; cv=none; b=Iw1E/WqIfg8lHFNXyJogppIo7X4fuI218GTbnkZrDCFSx8sJQ3vs042SDshIbh4aHsj9lgvaAki26OoOcSKJQYikvYq77oc1cC+6xATpFOdUY4FQw57izQ2QifAq5qrmX98bL/7VAuLe9UO2tZpA6+vGOjWm8qZ2yT2J+/OTSQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851425; c=relaxed/simple;
	bh=Kld7FrNSexDYwQ639jLZC0kecCstzFYOrYGdC/9ZouQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kmqdw3MG4KdQQMpvgMaaV7CpuJbQcWMk5rcIsmyeAoDZYJt7t1BZyii8xSQGJ9eth/xrCkJpS5D8x0zrxI+DttO0VR3pbst7fCUA+CTnNBmxY1oauKo68KNbPBbxZTgXmQhgViW5RGbi4Pg4Xbp/vl4yDQFk/wGnopVSlFoIfXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrMBVM/R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrMBVM/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AC3C19421;
	Wed, 18 Mar 2026 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851425;
	bh=Kld7FrNSexDYwQ639jLZC0kecCstzFYOrYGdC/9ZouQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hrMBVM/RDU3t7FRgnY2Y0tehVIJIC79uqP5ivKmP8QUX/V59dMHKBwn5quiXjGfaT
	 ZYR8jsYuTBhb112ey530G6UkPj8xL3I/2bgqRrBLHDr/fO4s5RbpmDlmfWG/x+K8qx
	 ZCKIxP74swwym6Wu1G025TaigUOh6q78Behv8/l2HD4eosLWGLjje0B/lz8I1HtYun
	 +ynUpdphrcXBezVbFz0avTqDx6f6povKkoPvOPLjcWmBvuqexIgdVxx6FCQJBdB97U
	 T3OnD/Y7kw6LXXu8WW2WDU/L51aD87SQ+t64JkDDrSRH9q26qx/nf4WNjthxAEG5/r
	 a8RKgBUqDLFsw==
Date: Wed, 18 Mar 2026 11:30:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/5] PCI: rzg3s-host: Use shared reset controls for power
 domain resets
Message-ID: <20260318163023.GA45848@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318124450.163471-4-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Wed, Mar 18, 2026 at 12:44:48PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Use shared reset controls for PCIe power resets to prepare for RZ/V2H(P)
> support, where multiple PCIe channels share the same reset line.

What is a "PCIe channel"?  Please use PCIe spec terminology if
possible.

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index bfc210e696ed..c61e011f8302 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1276,9 +1276,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
>  	for (i = 0; i < data->num_cfg_resets; i++)
>  		host->cfg_resets[i].id = data->cfg_resets[i];
>  
> -	ret = devm_reset_control_bulk_get_exclusive(host->dev,
> -						    data->num_power_resets,
> -						    host->power_resets);
> +	ret = devm_reset_control_bulk_get_shared(host->dev,
> +						 data->num_power_resets,
> +						 host->power_resets);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.53.0
> 
