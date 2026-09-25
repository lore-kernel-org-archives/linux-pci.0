Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BF4F4D05;
	Fri, 25 Sep 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369522; cv=none; b=bQFjG/r2ZbLji6LchB2NqDf8/H44TlT5OZZe+vzzzjeXGxeo/8w7cklQ3kkT3Pdm6x9zWxPjaOOMEgARajBAAa+gAXmDtCEnzqXJKmrWKf+PUXnDYtTz/JKjBLbpHv8abOzl4LsYb5zNU4feMCm5MXZemCwJpJElZ+wyMh/f6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369522; c=relaxed/simple;
	bh=w/iv0DkQo325bjasld4KmgGhim3dhrrQY3OeLEq+wTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=crRs7D1JzAcc9OSS/QIGqwCnxhL5pc/a+nguRnAwMTTJABxbAmCct3iDx5mcUoZug+dD067pPGC0XMxrnu0N39dj66wpaR3vBdPJ6h4BQZ96Om8N5jQD9ERar4FHbbtozcmU7uZEtYr17bhZCZLu+w8vl2aRQUCoiVs7VZiYApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AluOwxbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AluOwxbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46AC1F000FF;
	Fri, 25 Sep 2026 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369520;
	bh=DJila2NZUf4hBGFEHSK3cgK+/3a6LksrLFMyD5kuw7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=AluOwxbsstXMWqcNVtL91J6xXUZP8p+3abFvYYgYaU02TlGANAgOmRy/4llwkBgUg
	 H2BKFnEHRRAwPHPwXAMeY1oWsbpvThPV4zLePwrfDhgEcFqahjLy07eVDcd+FaSPNR
	 xem6Gw6JU/g4MlXmQVEgRv2egD7HU09w0Ov1xD1n39/f3Z8jVxbZT2cTSyt0d7fbu2
	 l1caXRq2gI6ep3SyH6lHx/OwOcaRgOmvaQzOxV4o0cSDMNwJhcGM7dmg5xfqm/MXxk
	 W+0tTDto8FdMK+BB/b5IblL+F72o2AlSypqJQqAkx20CZxgYrGJp7UakT7JCi1jw9e
	 Nq2eVJIUl+aPw==
Date: Fri, 25 Sep 2026 15:51:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar-gen4-pci-host: Fix reset-names
Message-ID: <20260925205158.GA2087943@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925203039.110653-1-marek.vasut+renesas@mailbox.org>

On Fri, Sep 25, 2026 at 10:29:51PM +0200, Marek Vasut wrote:
> Drop maxItems: from reset-names, since the entry already contains items: .
> Fixes the following warning detected by DT checker:
> "
> Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml: properties:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'const': 'core'}]} should not be valid under {'required': ['maxItems']}
>         hint: "maxItems" is not needed with an "items" list
>         from schema $id: http://devicetree.org/meta-schemas/items.yaml
> "
> 
> Fixes: 50b1333e0c7b ("dt-bindings: PCI: rcar-gen4-pci-host: Document Application/Local register reset")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I squashed both of these into the relevant commits on
pci/controller/dwc-rcar-gen4, thanks!

> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> index 30e244fda56b7..362c43a1a15d0 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -52,7 +52,6 @@ properties:
>  
>    reset-names:
>      minItems: 1
> -    maxItems: 2
>      items:
>        - const: pwr
>        - const: core
> -- 
> 2.53.0
> 
