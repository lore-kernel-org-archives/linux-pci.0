Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE68314A6F;
	Thu, 16 Jul 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220072; cv=none; b=HEKvn82acLIDiN1SGR0bdLfLzq1wzxWHXr3bDJCwSK+mfRRu7ZrY6/R8PRyyliDt8QMvHSMpgSKJaVZ49sFdfF+Jiw58/9gpRR42Xe0kD6JxQFLoPmyTTh4mdhnuajkoG1ao1fMp2Mj7ahI6FFK0ZJXJJXcgqGWq2kpYlyOp/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220072; c=relaxed/simple;
	bh=Qs2htlUW0dPVM84nKGOGKjeZztBuqvLtB5UPJmqhRJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vr7a+KQ7YQxEXnoYf62OyiNWeDciiqqarZ3glgM6mqM/MpRNOoX52oAgLMyVuaC4Lpa7kXGV3P6MEv8qTDZ1GlmQ4rM667xTCAAQl10bPlrJCh3eBlY1yvLM0ucI9/HzcV3O8tCDtRajHgZz1g/vhdT1d1sSWLXzrWJgEN3yu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT+Yp0fX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT+Yp0fX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EB71F000E9;
	Thu, 16 Jul 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220060;
	bh=88UMF+eU7HiAKdmWyHdi8ruaFAzo0R90LbSMbDbrqWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MT+Yp0fXYwTGnaSkIHjy79XOarEsKn3ydw7f9xPZP6R/37qfbxtN4MeTXYox9p9mm
	 K81jwZd8nnHX6DbVK8xWFQ06ybwVlgK7Wd01X+hLha4h6NV8o0Hu1NTwINky05Bvlx
	 Em7qhBhd4C6rfQqFHitDWmbAUonbKPS5161cyz1AENMb/2YDUL/VDxFd18Y4C1YhK7
	 TAqft2VkXHf0nivVmzHnA0MqF50dHqGpudxL2b83oEPFdHMPqdkMzvj+mP7Ml4h30n
	 sZMdqNnYIl/3f4PR1417cMt5bxFKYUTRuo1kYyj1B6YlEPoi/lpUzElPRW4w9G8tPw
	 zCTwHvxfQaGxw==
Date: Thu, 16 Jul 2026 11:40:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: Leonardo Costa <leoreis.costa@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"leonardo.costa@toradex.com" <leonardo.costa@toradex.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Sherry Sun <sherry.sun@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Message-ID: <20260716164058.GA16414@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>

On Thu, Jul 16, 2026 at 02:15:42AM +0000, Hongxing Zhu (OSS) wrote:
> > On Mon, Jun 29, 2026 at 11:34:32AM -0300, Leonardo Costa wrote:
> > > We are seeing a regression on Apalis iMX6 where the kernel
> > > doesn't boot in the newest v7.2-rc1 (it was working before, in
> > > v7.1). The device tree being used is the imx6q-apalis-eval.dtb.
> > > The kernel configuration
> > > used is the one shown below:
> ...

> > Can somebody confirm that reverting 610fa91d9863 fixes this
> > regression, or at least that 610fa91d9863^ works and 610fa91d9863
> > fails?
>
> Sorry for this severe regression. I have posted a fix that has been
> tested on my i.MX6Q SabreSD board:
> 
> https://lore.kernel.org/imx/20260708035928.580236-2-hongxing.zhu@oss.nxp.com/

My question was whether somebody had actually bisected to 610fa91d9863
("PCI: imx6: Assert PERST# before enabling regulators").  I don't see
anything specific on the mailing list, so I don't know how
610fa91d9863 got blamed for the regression.

https://linux-regtracking.leemhuis.info/regzbot/mainline/ lists this
as a regression caused by 610fa91d9863, which means we need (1) the
details to prove that 610fa91d9863 actually caused it and (2) a tested
revert or fix.
