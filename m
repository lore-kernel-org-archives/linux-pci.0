Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F221481A99;
	Wed, 30 Sep 2026 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764321; cv=none; b=CuiA7Kon9jxt9NZnS5esPZ/WtFmiFPuRkFR6Tv0AN2wVbDM8LUL7YstzOsOV7/rfdb92P56ECil9vy9sap0Yu6NSfJw2Ig9sqt93kOUBJ56QauDn5hhuEF3KvohYPCy1tmuBYn5s7BAMq70K60vRWfoc8nGqP3WdvzOq3E4P4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764321; c=relaxed/simple;
	bh=2obz0/IX8BuWtzm9sS06mzBVM/h+xSUmRaGfHRaNg3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBLoYzGuWjbfrDTq2juHQNWjbaO24IeqXuvxdNqAm/d9w/bZUdKnjnogcOVwIeDUl6R/gHEVpMdWCdb4PrdKURs4vejRkR69nXGhrBLoAJYheg8VlS5mSKsmklpz4+8cFGsegR2awS078nMT6T+sT0iB5F5YiuuCbjCPrb3OS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+flMNBn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+flMNBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7A01F000FF;
	Wed, 30 Sep 2026 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764319;
	bh=S3PovdLpO/18VNbUKxoRc1dSHVHjlx57/Nam5g9E32Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z+flMNBnphXFZDSKpzgrGzTPl4F2UMA4znEyeekKvulpa5dYxyHiJxa03yLLU6Ola
	 crxtdN5wWeorUXuZrCoRLq/+oRFTNWZyPDRGOrKH8/xQ/vX75RkLMjfpQ179PZ7IBG
	 IRqclFKGKLW7slEffyD6qfuK5lrp36ovmgJraUzvLmTsmEFqH14cSXIEA+wx4XLRts
	 GCos1hftRyj25sfsDChGag8RacBNnxk69n5wjKqrd5G7gCc8lVXQMDymdqyrijnxmY
	 CTVdDKbj9K2ZXc0V3B7n0v+4Dyzcw0+UYWONXjqSREzMwXxrdAda1bX6o5HePgdgnw
	 0HL3fdDiohZqg==
Date: Wed, 30 Sep 2026 12:31:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt
Message-ID: <20260930-perfect-aardvark-of-modernism-f2dbf9@quoll>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928165230.3397664-4-den@valinux.co.jp>

On Tue, Sep 29, 2026 at 01:52:18AM +0900, Koichiro Den wrote:
> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
> 
> Keep the fifth interrupt optional so existing device trees remain
> valid. Extend the example accordingly.
> 
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

