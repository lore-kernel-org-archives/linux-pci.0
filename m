Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C42882D7;
	Tue, 30 Jun 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827817; cv=none; b=kD2gv98mWTjPmx6O6mT/VLmjwwmcAZGNTKG2TimDn3tDiYusJlkTpmPK+C7krSPcBybbli9aXBVGfoUjJFSG42fzt9Ryx8PnHjQ6UgKFW+E2lwJcBEUmZXSc2ur+6maZGSqUz0gjoV1xGcRHJb46tGaK60/SaOxlBfI8llrRh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827817; c=relaxed/simple;
	bh=8JoCxrKMklKuvRJyQBAFMhwx8pWF9D3tFjHvYs1ZVwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6TvtHgqWGBVdW4143FTqfstU+3CIQa3mMD6IFrSh/fEkNJz6/Bzmk2fQkEEtUulQTLxokdSfbQceYfSp7G/2S0JKOWyg6eBEDRHjeJm4F+/sXBJ+CNAjqn5WM8C3vl3bSXEs7CgaE0uqhg28h2wQmZJb68lzxCI6t/oT8GS6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOy32PpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOy32PpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D341F000E9;
	Tue, 30 Jun 2026 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827816;
	bh=VCVIHwjK4UqwI7KSpGYiL5BOkDS0j1bQeNpENVLWHa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOy32PpToUElrUII5Et6U7A8yTaghJGFbiM/2zkeg3aVNy1kPzegpJJqxKFdQ1n74
	 5ATG7ED0GDJ/QqZ4kCTgoBRoSpVj5Nlv/TiAcCulkyMWN6Bwp2Af7NFUqjWe5vCRAQ
	 zISeLSljja4K30bS3aLcyJS2988UftE7vNBA/CzrA1BUjQQkgI4HCIEBppT4E5gEcs
	 0ZR3gFth+2hWkG1sUDsNZzqwouupEkKLazhA6GHKfJIQ9XKh/uhpCaRaUDa6ZNoOoI
	 WBrJS1Py8NBvImIOhcuJZssTXXIwsH9qIxOMfurTalWoUaqCDRgSPihSL6zygv4ihM
	 aWecZ/Hm323+g==
Date: Tue, 30 Jun 2026 08:56:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: linux-arm-kernel@lists.infradead.org, kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
	mani@kernel.org, l.stach@pengutronix.de, kernel@pengutronix.de,
	krzk+dt@kernel.org, bhelgaas@google.com, frank.li@nxp.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>, lpieralisi@kernel.org,
	festevam@gmail.com, conor+dt@kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: imx6q-pcie: Add optional
 intr/aer/pme interrupts for i.MX95
Message-ID: <178282781473.2986139.17262303228131453675.robh@kernel.org>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
 <20260618092100.3669556-2-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618092100.3669556-2-hongxing.zhu@oss.nxp.com>


On Thu, 18 Jun 2026 17:20:58 +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> The i.MX95 PCIe controller introduces three additional dedicated hardware
> interrupt lines for specific events:
> - intr: general controller events
> - aer: Advanced Error Reporting events
> - pme: Power Management Events
> 
> These interrupts are optional on i.MX95. PCIe basic functionality
> (enumeration, configuration, and data transfer) works correctly without
> them, as the controller can operate using only the existing msi interrupt.
> 
> Earlier i.MX PCIe variants (imx6q, imx6sx, imx6qp, imx7d, imx8mm, imx8mp,
> imx8mq, imx8q) do not have these three dedicated interrupt lines.
> 
> Update the binding to allow up to 5 interrupts for i.MX95, while
> restricting earlier variants to a maximum of 2 interrupts using
> conditional constraints (if/then schema). This ensures the schema
> accurately reflects the hardware capabilities of each SoC variant.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

