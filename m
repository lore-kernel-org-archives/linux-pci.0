Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1F44E05B;
	Mon, 19 Oct 2026 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411311; cv=none; b=eEHsU/c8d30oS2N+YoaBcAL6hkeNegVXiafzHkx8JYF5veJKwkBzjHGEVRdVW891pOvjZeqPPelb5ZHUbbUL4+/Y9XLy/tbvrrLsWx6dka7VZZ0pGuMAzrup4EHC/aWFsyVb5jyNzrGYtK7fifA7OfALnTCzTqcPxSg7POUgg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411311; c=relaxed/simple;
	bh=JZLWL4f9y/6jv7F0Z8/fJe97Y7HOZcxGPE2Fl3kg3mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/FH576dXCu+6Tltc3yOmqgXglPZzhDrnbgWs+f3vYMDAE37lA0NnUgHYFw60PTK8rlqfmrQatDNMdTQKHK5UXq8bTS0rKJQU3OVqPRkSWe5ulTvGtxXvx0UlfysIZnzZiSvQDxlGncx24wFrql/PSF4SK9dh88BsMUa7+XRHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 25FCB200011;
	Mon, 19 Oct 2026 14:01:42 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C5AD200007;
	Mon, 19 Oct 2026 14:01:42 +0200 (CEST)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B4878202B7;
	Mon, 19 Oct 2026 14:01:41 +0200 (CEST)
Date: Mon, 19 Oct 2026 14:01:41 +0200
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Frank Li <Frank.li@oss.nxp.com>
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
	Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [PATCH RFC v3 03/12] dt-bindings: PCI: nxp,s32g-pcie: Fix SerDes
 PHY phandle in example
Message-ID: <atYGpZpI1ecM10kI@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-3-9d68868c1e89@oss.nxp.com>
 <as0qORxP0Roh9ktO@SMW015318>
 <as5CIYxKJTra4hqM@lsv051416.swis.nl-cdc01.nxp.com>
 <as-MdloKd-7oJsUU@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-MdloKd-7oJsUU@SMW015318>
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Oct 14, 2026 at 09:06:46AM -0500, Frank Li wrote:
> On Tue, Oct 13, 2026 at 04:37:21PM +0200, Jan Petrous wrote:
> > On Mon, Oct 12, 2026 at 01:43:05PM -0500, Frank Li wrote:
> > > On Sat, Sep 19, 2026 at 08:54:31AM +0200, Jan Petrous via B4 Relay wrote:
> > > > [You don't often get email from devnull+jan.petrous.oss.nxp.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > > >
> > > > The example references the SerDes PHY as
> > > >
> > > >   phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > > >
> > > > i.e. the SerDes node itself with three PHY cells. That does not match
> > > > the SerDes binding: the per-lane child node is the generic PHY
> > > > provider and carries '#phy-cells = <0>', while the SerDes node itself
> > > > has no '#phy-cells' at all.
> > > >
> > > > Point the example at the PCIe lane child instead, which is also what
> > > > the S32G3 board device trees use. The dt-bindings/phy/phy.h include is
> > > > dropped along with the now-unused PHY_TYPE_PCIE constant.
> > > >
> > > > The schema itself is unchanged; 'phys: maxItems: 1' already describes
> > > > the corrected form.
> > > >
> > > > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > > > index 66a050028278..29323e50bd8b 100644
> > > > --- a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > > > @@ -82,7 +82,6 @@ unevaluatedProperties: false
> > > >  examples:
> > > >    - |
> > > >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > -    #include <dt-bindings/phy/phy.h>
> > > >
> > > >      bus {
> > > >          #address-cells = <2>;
> > > > @@ -124,7 +123,7 @@ examples:
> > > >                  ranges;
> > > >
> > > >                  device_type = "pci";
> > > > -                phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > > > +                phys = <&serdes0_pcie0>;
> > >
> > > I don't think it fix somethings. The "serdes0" just a label, point to
> > > provider, which is not neccsary that "#phy-cells" is 0.
> > >
> > > Examples just show need how many phys and don't care about phy provider's
> > > arguments
> > >
> >
> > The example validates either way, agreed. The three cells are the
> > '#phy-cells = <3>' of the downstream nxp,s32cc-serdes binding, which
> > was never posted upstream; patch 1 is the only SerDes binding for S32G
> > and has no three-cell provider. I would rather have the example match
> > it.
> >
> > The form depends on the outcome of your patch 1 comment, so I will
> > keep this patch in sync with that. If you prefer the phys line
> > untouched, I can drop it and keep only the ranges fix v4 adds here.
> 
> This patch is not important. suggest drop it.
>

Dropped. The PCIe nodes in the DTS patch carry the 64-bit ranges on
their own, so nothing else depends on it.

BR.
/Jan

