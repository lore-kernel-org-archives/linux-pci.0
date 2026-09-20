Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9746E005;
	Sun, 20 Sep 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924061; cv=none; b=ioQYfqSNKCB9SJ2tmaUXr1jgT+NMalrmreWxWdVRjjacExqpld3O/5PzNbzzJtyuUjykPu/y0JPpL5uud11eFq7ECKRl6VSrcx+Q7EIJA9dr7QYpShe6J6LlvdCMpLWPw/NZ/lBLGLgzmzrgQcCj1l+7zXMuBuOPwnx3dfCTgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924061; c=relaxed/simple;
	bh=++7cKn5dPLEoCOGhGWoB/T8i+KYlJXPfpJyNEaynf8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6pXj6xHJUcMeoz3fNeHN0LDQo+dHy7EWitRleDhQa79rbAmWoQaEvwyVCETQOxi9Wlz6W+5QwbS3L2Dyxa0tLpWzbXxbr2Y5I5pEUxrKTNSktj/n2dYgZy46UdjppeHnbwEwuSKZPVc+wFnW82qg6nT9D3XkhmREVtpozk1E+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LswdCCLG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LswdCCLG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SRR6GWm8VvaCpKgQykY2MiSoqyYUd1GFMV1rrWkJ4JI=; b=LswdCCLGZ/fMTQ3fP37RE0xKmP
	tWLPS26CI1aHU7OSJLo4czeq1buGrq1SP4843QH/8q7GydxdJRJ5FarpIzBqSKJ98gU2TQc0oQwGy
	FY+BYRxWt7Lee6y7s9AFMUxX5aVGPlNmmDATqZIjBxpHEmBB2Dit1Azv1/G9/Qn+g4cQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8L0d-006BGL-FN; Sun, 20 Sep 2026 19:07:23 +0200
Date: Sun, 20 Sep 2026 19:07:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jan.petrous@oss.nxp.com
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bogdan Hamciuc <bogdan.hamciuc@nxp.com>,
	Ionut Vicovan <ionut.vicovan@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	imx@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>,
	Bogdan Roman <bogdan-gabriel.roman@nxp.com>
Subject: Re: [PATCH RFC v3 05/12] net: pcs: Add NXP S32G XPCS driver
Message-ID: <c2c4dbc4-e6b4-47a0-9852-d116c6d21f89@lunn.ch>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-5-9d68868c1e89@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919-s32g_serdes-v3-5-9d68868c1e89@oss.nxp.com>

> +#define SR_MII_CTRL				0x1f0000

This is 0x1f0000 + MII_BMCR

> +#define   SS13					BIT(13)

#define BMCR_SPEED100           0x2000  /* Select 100Mbps              */

> +#define   AN_ENABLE				BIT(12)

#define BMCR_ANENABLE           0x1000  /* Enable auto negotiation     */

> +#define   RESTART_AN				BIT(9)

#define BMCR_ANRESTART          0x0200  /* Auto negotiation restart    */

> +#define   DUPLEX_MODE				BIT(8)

#define BMCR_FULLDPLX           0x0100  /* Full duplex                 */

> +#define   SS6					BIT(6)

#define BMCR_SPEED1000          0x0040  /* MSB of Speed (1000)         */

> +#define SR_MII_STS				0x1f0001

This is 0x1f0000 + MII_BMSR

> +#define   LINK_STS				BIT(2)

#define BMSR_LSTATUS            0x0004  /* Link status                 */

Please go through all these register definitions and throw out all the
ones which follow 801.3 and use the values from include/uapi/linux/mii.h

    Andrew

---
pw-bot: cr
