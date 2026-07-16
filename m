Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3C438468;
	Thu, 16 Jul 2026 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222941; cv=none; b=YWOg7oF9OwHLWfUERJRowwBIJcpIjTPUOO+bKhyvvhGiCXx3YHoOAa0pimzV3Vqj9XmjZrj3zvosHqBvkZnq6BGvtBqDzuabKiv9OMZM5HiLKQPWJhQ4mTGFl5b2ikRJNgIG5EUNDEHP5RibDbxN/BthPSdlZJWk0E1XNJP0uqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222941; c=relaxed/simple;
	bh=I/TzkBfeAxM+lITwY/O8nsMP46+tzv3HAYIn803AHK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V6jHCukqKZ0qQw4sERw77BVIsXNUeLCUrkGn1Al73tjCmIe9+CqSZ2U6h9LskJ/4Xw0J1aotj6JYs/AUCEcYslvb1th0NRBryguY5++yD4pNIqZ0sXN+MhIRFnsN7SuDHbjfJLXCICP2fXa/2xPnO8Buvmw6pp7hpRqQ0BtWDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEitLXbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEitLXbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F411F000E9;
	Thu, 16 Jul 2026 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784222939;
	bh=DfTFlvTuJ9NehD+xuHhlkvJ5W5X3RAJvY9aSf5a6Rik=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=aEitLXbMPF+ZDmNzgzoeO2ISIaNS2tPrWwnLNqK8ednlZh1BFUnWStIW8u4B0nKBj
	 5DudZuSLRPdkENxkGz99NrkGQp/tgvpXWlOqP4HT2p0dHQr9xABISKJdOrfKWjgPN3
	 lh2/GE38DWMY7oVEtIknNPklQTVqmZf2DFvoqjwY2yJbqtKPNJEz6oWV8KWY8Z/LDP
	 5d0vO7bLRd7pGsSlzxHtcig3H+Bk5PxNnfYtudQR1J1Z4pj3LQ2qv03vf14m6d95lJ
	 rC53fTeCKYe5utGbr6GKS76/cdxmGjUKSIU814FPBcsVINFDSYVaZz2KPyBArCglEh
	 +dAxPGR80lyvg==
Date: Thu, 16 Jul 2026 12:28:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
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
Message-ID: <20260716172858.GA111215@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb92c269-efa2-4f39-bd47-4d1ee36169ee@leemhuis.info>

On Thu, Jul 16, 2026 at 07:16:31PM +0200, Thorsten Leemhuis wrote:
> On 7/16/26 18:40, Bjorn Helgaas wrote:
> > On Thu, Jul 16, 2026 at 02:15:42AM +0000, Hongxing Zhu (OSS) wrote:
> >>> On Mon, Jun 29, 2026 at 11:34:32AM -0300, Leonardo Costa wrote:
> >>>> We are seeing a regression on Apalis iMX6 where the kernel
> >>>> doesn't boot in the newest v7.2-rc1 (it was working before, in
> >>>> v7.1). The device tree being used is the imx6q-apalis-eval.dtb.
> >>>> The kernel configuration
> >>>> used is the one shown below:
> >> ...
> > 
> >>> Can somebody confirm that reverting 610fa91d9863 fixes this
> >>> regression, or at least that 610fa91d9863^ works and 610fa91d9863
> >>> fails?
> >>
> >> Sorry for this severe regression. I have posted a fix that has been
> >> tested on my i.MX6Q SabreSD board:
> >>
> >> https://lore.kernel.org/imx/20260708035928.580236-2-hongxing.zhu@oss.nxp.com/
> > 
> > My question was whether somebody had actually bisected to 610fa91d9863
> > ("PCI: imx6: Assert PERST# before enabling regulators").  I don't see
> > anything specific on the mailing list, so I don't know how
> > 610fa91d9863 got blamed for the regression.
> 
> That was me and might have been a stupid idea. I normally wouldn't have
> added this, but a earlier message from Hongxing Zhu sounded a pretty
> convincingly like something along the lines of  "this is the problem I
> already have a fix for there" -- and then I took the commit-id from there.

Ah, ok, that explains it, thanks!  Hopefully we can get some clear
connection in the patch that eventually gets merged.
