Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422A285CB6;
	Wed, 10 Jun 2026 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105116; cv=none; b=hvyWbQ2lIJQLFIcQt71M/JyaBNmLnZjHJaiywDva4jbMdpzM7YkAjKbO0rTJfZZQafcUlQLAdgyQ5iIf9D9ox7SFYovzQQ60mrid5+X2NLdlDBnbW5x7LEsi3rkL1fRaOj93FA53Tm45o1xqZ8uNZMz2oF8VF1vEpUBDfhni5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105116; c=relaxed/simple;
	bh=4s7TLpAJNxl6jBFy02k4n6QhuqOi5yP9Qqdrhp2aSvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezzCGtQ3eCyitNYi8V4IvhWTpgQLXg1x5Yu/dRiw0C6aj1nvlLhH1HzgDwnBKuFcPH4PfenGth7HQJPXpJMzNSRY3GK4xcbmyeZBZk97pfR7L1GMfSD4TdM0HtvyPr46sfmulegCd1X4qQqRyuugs+AA9I0vMKZq88WlXtVIHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IasknAdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IasknAdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8781F00893;
	Wed, 10 Jun 2026 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105114;
	bh=UoDQj9C+O53bida9VWp4KyKOTlqF1LiwyZOTItdETEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IasknAdEKSV6icPTxZPXcVV6n70++HIMKNm2VKKl7nFsd4sZELlTYtCEg40os5Vqi
	 mdVkS5qrAQqk6hp7aN3WsyGHZqyj6nv9MVAGsMH7XZ1TgLxJgM97/XpPtGH/PGMrbW
	 romLs2MWDPBzkMoynXxjUemRYB2Whxk08dcdMh6dNVBmoB0HlXixpG4LyTQSfpMmAF
	 0ZP8vZvaCiRKTgeMnSBGC8WmEXXPyKkepuaSWdTqLI1RoREm2xfi2f7FTSCkUpO52+
	 GV8G+qhihGtJzGBP2mP+hfVBnAb1OzAlHmp/Wspm/FDCXKadAUUoK9woGEUOjwgPy7
	 TdKQH9yO3X8/w==
Date: Wed, 10 Jun 2026 17:25:04 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>, 
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update
 device trees
Message-ID: <r5xhffvpvk7zeedt4lgqj3k4l7gwbctrpljbtjethqyuxbhtyn@nqrvatynn3cu>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
 <GV2PR04MB120194C8BDA9B49C79DCE72168C0E2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <VI0PR04MB12114B321EB4DFD68B7030F76920E2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB12114B321EB4DFD68B7030F76920E2@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Thu, May 21, 2026 at 04:40:35AM +0000, Sherry Sun wrote:
> 
> > > -----Original Message-----
> > > From: Sherry Sun (OSS) <sherry.sun@oss.nxp.com>
> > > Sent: Wednesday, May 20, 2026 4:49 PM
> > > To: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li
> > > <frank.li@nxp.com>; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > festevam@gmail.com; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > > mani@kernel.org; bhelgaas@google.com; Hongxing Zhu
> > > <hongxing.zhu@nxp.com>; l.stach@pengutronix.de
> > > Cc: imx@lists.linux.dev; linux-pci@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Sherry Sun <sherry.sun@nxp.com>
> > > Subject: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update
> > > device trees
> > >
> > > From: Sherry Sun <sherry.sun@nxp.com>
> > >
> > > This series integrates the PCI pwrctrl framework into the pci-imx6
> > > driver and updates i.MX EVK board device trees to support it.
> > >
> > > Patches 2-8 update device trees for i.MX EVK boards which maintained
> > > by NXP to move power supply properties from the PCIe controller node
> > > to the Root Port child node, which is required for pwrctrl framework.
> > > Affected boards:
> > > - i.MX6Q/DL SABRESD
> > > - i.MX6SX SDB
> > > - i.MX8MM EVK
> > > - i.MX8MP EVK
> > > - i.MX8MQ EVK
> > > - i.MX8DXL/QM/QXP EVK
> > > - i.MX95 15x15/19x19 EVK
> > >
> > > The driver maintains legacy regulator handling for device trees that
> > > haven't been updated yet. Both old and new device tree structures are
> > supported.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > Hi Sherry:
> > Since the vpcie3v3aux is used to power up the WAKE#, it is always on in this
> > pwrctrl framework whatever the system is in suspend or not, right?
> > 
> 
> Hi Richard,
> Currently the new pwrctrl framework doesn't support vpcie3v3aux, it handles all
> regulators with of_regulator_bulk_get_all() and regulator_bulk_enable/disable().
> The vpcie3v3aux now only works with pci-imx6 driver.
> 

PWRCTRL_GENERIC driver can handle both vpcie3v3 and vpcie3v3aux, but not
POWER_SEQUENCING_PCIE_M2 driver, as there is no 3.3Vaux defined in M.2 spec.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
