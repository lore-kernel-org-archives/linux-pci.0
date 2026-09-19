Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A92F7EE6;
	Sat, 19 Sep 2026 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789831920; cv=none; b=JjYGf/5khyfnj/WRrrDgeuZj2EW+zEn2GFqzRtq2g3V7QCWZO8FxaQLmGSAzQOADpFQzif81EDEn6Z6brxWCQ7BYvwC1WHXqogpxL25rfVVNL0pgWDo1Nexsb+y3xvFDIYj3TIU+cerMvkvXc70aQcHMWjEKunK0pEmZIbpIG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789831920; c=relaxed/simple;
	bh=5KxudPVa4cR0Y7rPa1E43SFheiO5TVcpVsdV54OWgtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHhPnSpUiuX2DMrVWwENqiSwmCXxdy4avz250b74z+hhMiegHtm2JCLP7Hf1Fjf87b6xagzrpocydmuIMY8AEDI2Xxu9sFuw16MKtDhEcwBT77wTJ1DxCwrPUfvHP4XuGoaowSrvr2ueFY144Jw1vI+68iZ/IbQchNvmC4mro9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SZQR45nJ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SZQR45nJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0338AC5145F;
	Sat, 19 Sep 2026 15:32:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 815D2606CA;
	Sat, 19 Sep 2026 15:31:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BF4410328325;
	Sat, 19 Sep 2026 17:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789831914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Fpl/mSTm+p04Puo8jE7IFv4cZMSLW9gDZpQr4h8v3CQ=;
	b=SZQR45nJhfHTdtdgkGAo8QT0jA3mhBNwoBPhRmiLJHvcu9zx7miKtDeAhpC4ybxTT3/zjN
	uZJ0CPnAif5itKeKuk/pOzqSFcq6r7qTrW5sk52cOUYojs5hYcGSZvBy4HO5xkwwNb0hCC
	/A0z9NYeU1OZ3zESRCrKPmGcwfSBgnSoIQqzIIEI4ljwYCN18tWJnBzHfsf3OIf9xIopfh
	hfZ3jJZ/FBXrwrMZefoCV+jF7QgMqKMwaFN2OkkEYjnfsPPepZOdYpat15I9D2rQNlyLH8
	mujB3qTseJ5IsDx4HkdQcC2sv213xZrSfkz9MZSL4M+UqI1UnUvHia+XmWnggQ==
Message-ID: <6aabb56e-406f-4d13-9fd8-54822202039f@bootlin.com>
Date: Sat, 19 Sep 2026 17:31:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/12] net: pcs: add NXP SerDes XPCS shared core
To: jan.petrous@oss.nxp.com,
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Bogdan Hamciuc
 <bogdan.hamciuc@nxp.com>, Ionut Vicovan <ionut.vicovan@nxp.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Clark Wang <xiaoning.wang@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Coia Prant <coiaprant@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 imx@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-4-9d68868c1e89@oss.nxp.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260919-s32g_serdes-v3-4-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jan,

On 9/19/26 08:54, Jan Petrous via B4 Relay wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> The SerDes subsystems found on NXP S32G and i.MX SoCs integrate a
> Synopsys DesignWare Ethernet XPCS and an Ethernet PHY (PMA) with an
> identical register layout. Only the register transport differs: indirect
> memory mapped access on S32G, Clause 45 MDIO on i.MX.
> 
> Add a transport agnostic phylink PCS core which operates on regmaps
> provided by the platform glue. It implements the phylink PCS operations,
> the Clause 37 SGMII / 2500BASE-X / USXGMII / 10GBASE-R configuration and
> link state handling, soft reset and polling helpers, and the common
> feature sets. The platform specific register sequences, compatibility
> tables and quirks are supplied through a per revision descriptor by the
> platform drivers selecting this core.
> 
> The register sequences and the feature lists are derived from the
> Synopsys pcs-xpcs driver, so its copyright is retained. A separate driver
> is needed because struct dw_xpcs is built around an mdio_device and owns
> the transport, the reset and the identification of a standalone PCS,
> while here the PMA can be shared with a PCIe controller, the bring-up is
> sequenced across both XPCS instances by the SerDes PHY driver, and the
> transport is not always MDIO.

Is there a way to avoid code duplication by wrapping the accesses into
a mii_bus ?

This is what the Rockchip submission does : 

https://lore.kernel.org/r/20260919125119.2107089-8-coiaprant@gmail.com

Maxime

