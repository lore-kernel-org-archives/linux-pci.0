Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B423876AC;
	Wed, 21 Jan 2026 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981347; cv=none; b=ctfHdSdKYPnoSkYyZlK1n/8q5anGw53ybawsG5Us0v1s5THcRFjr4LmOrgbMQHXubSWWuy3UU87S4r+TSBXKoj+/dbbNn0qs0EjD/piLYYCv3a6ceTlBC4hAlLZGnLxIUPEh5LScGCSOwWy6wAX/qeGxZr54+DXls6svWTC7Fl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981347; c=relaxed/simple;
	bh=bte/XQ4DIY+20st0PFZ4A741YBlWScrZ0zOdXWQH50k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZVZD2gtiXiVpf1kqIDq49epamDR4PkE2C0W+p6qxqNy/15cqVARVLZ1jmWUmdefe5x5GDDw1fB2s6irUYtFL3stXW47+UrSC8JL0Gwv+PBT9Zn9jiqvz2mPwPnoaPFkcd5QuEjqLEYmyA7I/9LabzKa3XK3BfTWPLRClmC/nUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIeP31Ij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIeP31Ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F050C116D0;
	Wed, 21 Jan 2026 07:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768981346;
	bh=bte/XQ4DIY+20st0PFZ4A741YBlWScrZ0zOdXWQH50k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIeP31Ij9uGOS5j+Mc24fKtxEPHM9BKYkUtJA3mDe9250G0Mggh8qOGv9UNGLhbXR
	 DX2XtYCw6ieRnjBon31V4xrq8AbjCcU0BUMcvpcltj2GcNEt/ThHJzwLfqb50iA/bE
	 ARXyylEX3on9ijQFThfDwjaXPBFD8pW2rcKTOPqnkK+kGMEm5p91ZrHf2slT3YPwgN
	 Gy+HFFBJaIxQtIW97cD6S5o6AdkyBmz+txMIgaWElD2p6vLRBHIej5bUA5uMiNDE2h
	 EQoeHS2gHI2ULewogq9xdLMfjQyowOi3oR1u5j6h3y4CA3I468HJbkFMgs6SAllEPT
	 LCTHAofRoIkQw==
Date: Wed, 21 Jan 2026 13:12:16 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, Frank Li <frank.li@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Message-ID: <dbnnvvpki6oaqaribiuycpshk7qmisl42x3iti24aqzzrw2rfr@afoer4ku4do4>
References: <20260109152750.GA544801@bhelgaas>
 <20260120220441.GA1170239@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120220441.GA1170239@bhelgaas>

On Tue, Jan 20, 2026 at 04:04:41PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 09, 2026 at 09:27:50AM -0600, Bjorn Helgaas wrote:
> > ...
> 
> > The current commit log for this patch is this:
> > 
> >   Some SoCs like i.MX95 require enabling REFCLK after resuming from suspend
> >   in their post_init callback. So invoke the callback at the end of
> >   dw_pcie_resume_noirq() if available.
> > 
> > When .post_init() is called, the link is already up and PCIe devices
> > have already been enumerated.  I think REFCLK is required for the link
> > to come up, so it doesn't sound right to me that .post_init() would be
> > *enabling* REFCLK.
> 
> This never got resolved.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-imx6&id=199c18221622
> says imx_pcie_host_post_init() enables REFCLK by applying the
> IMX_PCIE_FLAG_8GT_ECN_ERR051586 workaround.
> 
> I don't think that commit log is correct.  Can you please supply some
> correct text for that commit?
> 

Sorry, I messed it up. This callback is not supposed to enable REFCLK, but just
clear CLKREQ# override to allow the endpoint to drive it low when required.

I've just updated the commit text in the controller/dwc-imx6 branch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
