Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463E1392C2A;
	Thu, 10 Sep 2026 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029043; cv=none; b=UsNmG/wPoESEvwJ7fX1/tH/sc2UW0CkcFJWATZoMSwkF1xgR1GrBrszQ96I+y/J5mBiYuCylbH/klvG4sdmumIEO1vNx6sxY6euE8d7zZbWBalWDkx69yeWGYI/oQfpv9yLGC9Rcad/lm91vato9KbHXiWeGOBpZlkaFmVtMKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029043; c=relaxed/simple;
	bh=nAekbWw3YDvVWN6atyge2/ucl7sq9AxPjpWj7Qvoahg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaawZupybu0OQEqEedjoKtnHVDRvg1sLPThl6IaXoS+V7X+5R2WoPownTs2s4WYnU13g6csFNZnkK12xvWAZIBfDRqtdRWEG7eb8pyRoICq3pXwOvHH7I1EFgT3ea5ryu3+alm4Ztlzl1Xsn+kdcaBuHlK5DhXaplAWOuf3Bn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcDib7oF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcDib7oF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4901F000FF;
	Thu, 10 Sep 2026 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789029041;
	bh=V2iRU5EWF25kDF/HWroa45GQAjAonv6s5ow4zWIf4eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AcDib7oF8ceHqvllUmoOGFBn4mpCBkDk+bGd16Kql/S4kSqvU85H8H2jkBe6cZhSP
	 iXIRH/PZPod1rOxOW0d91t3rpHv0eyecLrVzEir0zfnRwGR5M93h8Y1oKE5QN2wTvv
	 orQdOk7yO9z8bDwYjE0q2mb7EmsJoiHFULYvLszNlARKBxgIsK2J35fuFY93F5YEU2
	 qeitxPBraOfXSj3MlsAXVD3oMwn4iwKkE5Tn5SmoEMxPw1h3ax62dwGWDg2nA64td8
	 wo1KlftDtngDRgOm6akJqOr7ODw7L6W+lZmxx3hUXjiHP1juWtyU7lxJCZ12B+eLzT
	 f3dMbFUzTdJeQ==
Date: Thu, 10 Sep 2026 10:30:32 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Rudi Heitbaum <rudi@heitbaum.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when
 needed for i.MX8MQ
Message-ID: <gbvllf63gssdreregtdotpw7ihz2ea4g2uq52xlfuu2rqfwq6t@yyyta35h34ul>
References: <cover.1785669457.git.rudi@heitbaum.com>
 <563f057f26b1147a79392509b35dcb7f18113ba9.1785669457.git.rudi@heitbaum.com>
 <GV2PR04MB12019D0F84B4357DF2403B2C68CDC2@GV2PR04MB12019.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GV2PR04MB12019D0F84B4357DF2403B2C68CDC2@GV2PR04MB12019.eurprd04.prod.outlook.com>

On Wed, Aug 12, 2026 at 02:49:08AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Rudi Heitbaum <rudi@heitbaum.com>
> > Sent: Sunday, August 2, 2026 7:32 PM
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> > <l.stach@pengutronix.de>; Frank Li <frank.li@nxp.com>; Sascha Hauer
> > <s.hauer@pengutronix.de>
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczyński
> > <kwilczynski@kernel.org>; Manivannan Sadhasivam <mani@kernel.org>; Rob
> > Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Fabio Estevam <festevam@gmail.com>; linux-
> > pci@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev; linux-
> > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > rudi@heitbaum.com
> > Subject: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when
> > needed for i.MX8MQ
> > 
> > i.MX8MQ has two PCIe REF_CLK sources: an off-chip oscillator and the
> > internal PLL. The driver unconditionally selected the oscillator, which is what
> > the
> > 
> > 	/* TODO: This code assumes external oscillator is being used */
> > 
> > comment refers to. Boards wiring an oscillator to the pad describe it as the
> > "pcie_bus" clock, but nothing in the driver looks that clock up by name, so it
> > does not select anything.
> > 
> > Reuse the generic enable_ext_refclk flag, set when an "extref" clock is
> > supplied, to select between the two, as is already done for i.MX95 in commit
> > d8574ce57d76 ("PCI: imx6: Add external reference clock input mode
> > support").
> > 
> > Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> Sorry for the late reply.
> 
> The code changes look good to me.
> 
> However, I'm concerned about backward compatibility. This patch changes the
> default REF_CLK source from external oscillator to internal PLL when no
> "extref" clock is specified, which could break existing i.MX8MQ boards.
> 

This clocks is marked as 'optional' in the binding. So the driver should
continue to work with older DTs that don't specify this clock.

If this clock is truly required, then it should not be defined as optional in
the binding and the ABI break should be justified in both binding and driver
commit messages.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
