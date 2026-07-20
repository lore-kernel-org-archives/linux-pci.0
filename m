Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8493B7B99
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540317; cv=none; b=j/RBZ/+Wn7Tc5NIAXO9t3MnNy33qUrvr0V1t2XDT8YPsO9NLxFz+S79MLqxJByWG2QBSpcTtn8C9EOfUXC/Ulokg8RfYtk25ubj+nv3rG2tQ2eTQYfkqwQ3fepSsGnpDHhQplEhMc4cIw5Jucif+TaQKzsqdcOwM3ftqJJWrYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540317; c=relaxed/simple;
	bh=v38iQbgsNt7hDFHMMkKsfiz8SsfUHUu7tFnOq62fOB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbNODoxnfRYOnfvWFfeRgnNnXxqsqeSBak3REFRceg7lNlEmxqNQqPpADJkfgf+1ahKcAUTw4/N7p2bicsgRHsdzvD15CauMG60T+nP1c0esaRMIn9aY7xHwLB/gnp6TkzMSyf7scnrWFrD/sEY5beov+5NgfdwpW0kqvKpeueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=FzYq3Awa; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="FzYq3Awa"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 1E4F01FA7B;
	Mon, 20 Jul 2026 11:38:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784540313;
	bh=21QhDt52brqt4bzEgkFI24rtnM5CeN4Skc2OnscvgoM=; h=From:To:Subject;
	b=FzYq3Awa6o7RMbxbEYxeo1qUcQWIW/VYtRyWfKpoAwJ+tN3B0PhyU+EVgDzdcJP3o
	 IEO4STYbtu8L26NXI0rvblTgi+DyLsWmrWghq4OH+jeZRqZBM0Ww1ky/ryTpUOuPqG
	 CyRLSPf6oMTH23MSSE6i8FuU2dcy3sdkJVScSQFaNYw3pYci4KzTH1NEskmEeYJ/H3
	 M9oeKUNZrDQSfhLy9rvVyx9U70N60uQdIos162MQ6y6XR2ev7Kk7PLfXkPBF92UEwx
	 zoxFa9Kzn7Vtb6fKM5Piccmad7WqSNeKn7pqL4RUc6iJFq/y597yMCTAlySmWhODi4
	 UkdtxHHv7zmQg==
Date: Mon, 20 Jul 2026 11:38:31 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Frank Li <frank.li@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: Re: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
Message-ID: <20260720093831.GC52182@francesco-nb>
References: <20260720052742.GA6753@francesco-nb>
 <GV2PR04MB1201926DADEFA97128E7C8CA68CC32@GV2PR04MB12019.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB1201926DADEFA97128E7C8CA68CC32@GV2PR04MB12019.eurprd04.prod.outlook.com>

On Mon, Jul 20, 2026 at 09:16:27AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Monday, July 20, 2026 1:28 PM
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>; linux-
> > pci@vger.kernel.org; imx@lists.linux.dev
> > Cc: l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > mani@kernel.org; robh@kernel.org; bhelgaas@google.com;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; linux-
> > pci@vger.kernel.org
> > Subject: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
> > 
> > Hello,
> > our CI spotted this error on resume. It is not systematic, and it is possible that this
> > is not a new issue from 7.2.
> > 
> > Does it rings any bell?
> > 
> > [  745.849237] imx8qm-hsio-phy 5f180000.phy: HSIO_PM_REQ_CORE_RST is set
> > [  745.855800] phy phy-5f180000.phy.1: phy poweron failed --> -110
> Based on the log, the PHY initialization is failing during resume.  I'll set
> up a platform on my end to see if I can reproduce this issue consistently.

Thanks for the support, appreciated.

> BTW, is this occurring on the i.MX8QM MEK board?
The issue is on apalis-imx8 (you can find the DT in the usual place in
the linux kernel tree).

> What's the frequency of occurrence in CI (failure rate)?
The last batch was 3 failure in 10 executions, so 30%.

Francesco


