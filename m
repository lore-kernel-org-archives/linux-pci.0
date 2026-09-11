Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E7443E40;
	Fri, 11 Sep 2026 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110684; cv=none; b=Hm+L4OtklAgIOq7pwtH0aVAiOh0Lpg+30WbL0WCUddw3SOKOPE747dKYwpcB9Y9NeK/PleYtnqiJYq891YtSjef8Chmb/Fagf8keNbzW3NoTJpsOA9w9NQElRhuXD/tuymHI2rSM7jqal9hwqzsoBBFEPsN4q9dygpHDr2IjqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110684; c=relaxed/simple;
	bh=wdzASsR+4EF5B7sXMKYUX5Smb3F4cCR0nAhbLAirETE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi4IW1wq3I9e74z9adkMixhaw0l3OZO+W3Ri/RZBH5OopJR200MvheAupY9y/i+QmxN3JRQUqnq0Xhdulnme+LRaRE/Q/JI88mTItUs2HIkdNWmJ5ii5dBtSB3z7NE9Vxba5qUwDwB0+FyQNhGcl4hEu8f/yN5sxjJBjXp5nk2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCPumZYc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCPumZYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77C81F000FF;
	Fri, 11 Sep 2026 07:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789110670;
	bh=q4nrNz0ZFCmTorJZ+dgC4drweJpQ4lcQMZKnzFL8PkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GCPumZYcQeyvB2cdaiPQIOED+LpUQElz6Y00+7Nlc+/YoWUmPf1UyAU649GusCm3Q
	 z6uVM8tRa43CNmosaIeZ9aOWtpUTMoPYZiST6wopZs+IPqS9GAyT9yeV9/6XNjrsmI
	 fSA8raT6Sga7xSeLaeGDroKLwub88uH9V8a50sfrj+pfimzedcTcs2yCI07w1vWtp7
	 XiVgUDoW4HW6KJ0wBNugdXg4HEeFh8zk5eM20w+TwkE6OtP4YZw0/xIjeE68mC0ZL0
	 pV2aJvYFNaqu8ESENjWUxoOrBdVOaPug4kjTXkFKlaSES5nzJH1OIdlowX2+EgHqri
	 Tl4uOEnuDJP+A==
Date: Fri, 11 Sep 2026 09:11:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Document RZ/G3L SoC
Message-ID: <20260911-khaki-coyote-of-acceptance-afddda@quoll>
References: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
 <20260903133320.144245-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903133320.144245-2-biju.das.jz@bp.renesas.com>

On Thu, Sep 03, 2026 at 02:33:10PM +0100, Biju Das wrote:
> Extend the existing device tree bindings for Renesas RZ/G3S PCIe
> controller to include support for the RZ/G3L (renesas,r9a08g046-pcie)
> PCIe controller. The RZ/G3L PCIe controller is similar to RZ/G3S but has
> some key differences:
>      - Has 3 clocks compared to 2 on other SoCs.
>      - Has a different set of reset signals
> 
> Add device tree bindings for renesas,r9a08g046-pcie compatible IPs.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

