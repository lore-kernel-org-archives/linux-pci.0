Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B143D9DB9;
	Sun, 11 Oct 2026 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698612; cv=none; b=iv0gZAWVzGuJcj22dI839vLY+5LQ2rEZFKKdT8NGStsWbfNy6Su73t1U5xrlb9EcnFq0w9kWfliYMHR6ROzIHBAB5zfpHQ3Fk7cKEoda09Kj6xrZLq2VNgtiHpWz0cFotXqqO8brwsF0wd8+TWgJMKPEwoUYqO9qo5iQM8gCbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698612; c=relaxed/simple;
	bh=bJmutYSfU12J9m42/ZAR2XzxhB6aUUDLS/p13FCHDDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgT9NjZsNJ7DHKn0NM2O/IKDAbhYvhp2GRprjmn/j9OAY+U86kFJqacB0irfiyRX/2KyxlM3d6twpzOJxWX64liwW/8rErlbhafurEm6LIpfADxglbiq83S0cTR8T11P1JmYB/QXZg944daODLH5PQLfmdLcGu/knGMJFk165Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D45D01A00B4;
	Sun, 11 Oct 2026 08:03:27 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B25C61A0031;
	Sun, 11 Oct 2026 08:03:27 +0200 (CEST)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 29BEC20301;
	Sun, 11 Oct 2026 08:03:27 +0200 (CEST)
Date: Sun, 11 Oct 2026 08:03:27 +0200
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC v3 04/12] net: pcs: add NXP SerDes XPCS shared core
Message-ID: <assmr2PH8064/pJn@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-4-9d68868c1e89@oss.nxp.com>
 <07c5ed86-755a-4094-b45a-6316d10f4515@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c5ed86-755a-4094-b45a-6316d10f4515@lunn.ch>
X-Virus-Scanned: ClamAV using ClamSMTP

On Sun, Sep 20, 2026 at 08:39:26PM +0200, Andrew Lunn wrote:
> On Sat, Sep 19, 2026 at 08:54:32AM +0200, Jan Petrous via B4 Relay wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> > 
> > The SerDes subsystems found on NXP S32G and i.MX SoCs integrate a
> > Synopsys DesignWare Ethernet XPCS and an Ethernet PHY (PMA) with an
> > identical register layout. Only the register transport differs: indirect
> > memory mapped access on S32G, Clause 45 MDIO on i.MX.
> > 
> > Add a transport agnostic phylink PCS core which operates on regmaps
> > provided by the platform glue.
> 
> What is not transport agnostic with the current code.
> 
> Think carefully about that, before you answer.
> 

Ok, got it, pcs-xpcs only reaches the hardware through mdiodev_c45_*(), so
whatever sits behind the mii_bus is the transport. pcs-xpcs-plat already
puts the DW indirect MMIO viewport behind one, sja1105 and txgbe put
their own register access behind one, and on i.MX the XPCS is on plain
Clause 45 MDIO in the first place. The claim in the commit message was
wrong, and with it the justification for a second core.

For the next version I will drop this patch and move S32G onto
pcs-xpcs. The SerDes PHY driver registers a mii_bus per XPCS instance
over the existing indirect accessor and creates the PCS with
xpcs_create_pcs_mdiodev(). The S32G PMA sequence becomes a
dw_xpcs_compat .pma_config keyed on an S32G PMA ID, the same way the
SJA1110 and TXGBE ones are.

That leaves two things S32G needs from pcs-xpcs, neither of which is
about the transport:

 - skipping the generic soft reset. The vendor reset
   (VR_MII_DIG_CTRL1.VR_RST) is part of an ordered bring-up of both
   XPCS instances, which the SerDes PHY driver owns because the PMA is
   shared with the PCIe lane. The PMA ID check that already clears
   need_reset for TXGBE and FBNIC would cover it.

 - no EEE. S32G3 does not implement VR_MII_EEE_MCTRL0/1, so
   pcs_enable_eee/pcs_disable_eee must not touch them.

Both will be separate small patches against pcs-xpcs so they can be
judged on their own.

Thanks,
Jan
