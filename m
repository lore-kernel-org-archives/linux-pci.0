Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596933AFCFF;
	Wed, 29 Jul 2026 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337972; cv=none; b=NG3xfTrmim5Izb0YmqPpbly6LCwFLmvSysOaFUOVp0LDIFBdnp9kfDNLJwg/ks+DZDWCfht+234uAXhFac9+yNdaTScLN5tJ9g9EkZehFNLV8O36hH872DTRbDoi0g6rSfEBsIAoccN/4DdPjM/bpKMPYez20ECedsS2Dcc94b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337972; c=relaxed/simple;
	bh=CRZm3ihcVCgrbw7shCZXWO18676qjzJCD3HwwriYGoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcbNivafCS0XEll6pdNQCofKBoyRP7da4kFBFLxVh9SneBS8eatGTk8BTirjUREiril6oWKMY4Da29X+Kwq62WYwIQhdV8IRG2E7VxZnwtLrTSOUQ8Mytw0t0GzJg4THPqtLsN8vhuHHWOJqYBsgpamlpIGUFET15S7kgUZ1848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyNaF7k4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyNaF7k4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BE91F000E9;
	Wed, 29 Jul 2026 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337971;
	bh=HZSb0EJLr4AFXbXjw8odDJR8NY8wtHsvk1Ts7AdPyeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MyNaF7k40reVrMqiBFdkhkL7ihZqO26dir9BQuFBfsu2FtiAhfGh4mdvjPPb/8prj
	 TXxbfS06JcnYN4D1pRVeujIzZkFOBXr4c2DtEZpkke9KFWjas9Fq5QaQg0MYQiuUf/
	 iSFfRawF9+DTeNaKLBaAOJSawnlg874m9YFX6pqnkGD8TetjGsf+j/vwU9r7oDpSP2
	 gbjl/+9bhGtdjWxe5rcAdgJPpPEAeJOjD5C7hJH0S6ByWcK5+lA6UJrts6DFrF0gJc
	 G0Yq3ntT8BORz1v2VlAeCdB953NPgQJh+ssvv3gLPf2D9qX3ynZsQy67D3dOip0Pm8
	 egyZqUrdkk/FQ==
Date: Wed, 29 Jul 2026 17:12:44 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Allow D3 for native Hotplug capable Root Ports on
 DT platforms
Message-ID: <vu7lzyq4jlyqcvxg5djwhmudxt57b4ittlquzug7ps3oa5nfon@6bfismvnliu2>
References: <20260729071514.859778-1-manivannan.sadhasivam@oss.qualcomm.com>
 <amoQ3SNpnLr3zb37@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amoQ3SNpnLr3zb37@wunner.de>

On Wed, Jul 29, 2026 at 04:40:29PM +0200, Lukas Wunner wrote:
> On Wed, Jul 29, 2026 at 09:15:14AM +0200, Manivannan Sadhasivam wrote:
> > Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"),
> > prevented native Hotplug capable Root Ports from entering D3 citing issues
> > on old Intel SkyLake Xeon-SP platform.
> > 
> > But there is no reason to restrict D3 for native Hotplug capable Root
> > Ports on DT platforms. We recently enabled D3 on non-Hotplug capable
> > Root Ports on non-x86 platforms (specifically for DT platforms) in commit
> > a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
> > do the same for native Hotplug capable Root Ports as well.
> > 
> > To honor the above platform_pci_bridge_d3() check, allow passing this check
> > only for DT platforms, unlike a5fb3ff63287, which used !CONFIG_X86 check.
> 
> platform_pci_bridge_d3() acts as a "whitelist check":  If it returns true,
> the port is allowed to go to D3hot/D3cold.  If it returns false, the
> subsequent checks in pci_bridge_d3_possible() are free to decide the
> port's fate as far as D3hot/D3cold allowance is concerned.
> 
> Thus, I don't think you need to worry about "honoring" a "false" return
> value of platform_pci_bridge_d3().  (If I understand your commit message
> correctly.)
> 

Okay, thanks for clarifying. I was worried about ACPI based ARM64/RISC-V
platforms and was trying to be conservative.

> > +++ b/drivers/pci/pci.c
> > @@ -3020,11 +3020,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >  			return true;
> >  
> >  		/*
> > -		 * Hotplug ports handled natively by the OS were not validated
> > -		 * by vendors for runtime D3 at least until 2018 because there
> > -		 * was no OS support.
> > +		 * Do not allow D3 for native Hotplug ports on non-DT platforms
> > +		 * as they were not validated by vendors for runtime D3 at least
> > +		 * until 2018 because there was no OS support.
> >  		 */
> > -		if (bridge->is_pciehp)
> > +		if (bridge->is_pciehp && !of_have_populated_dt())
> >  			return false;
> 
> And so I'm wondering whether:
> 
> +		if (IS_ENABLED(CONFIG_X86) && bridge->is_pciehp)
>  			return false;
> 
> would be more appropriate and more consistent with the subsequent check in
> pci_bridge_d3_possible() that also uses IS_ENABLED(CONFIG_X86).  Basically
> this would mean that we only special-case legacy x86 hardware, but assume
> that anything else supports D3hot/D3cold for native hotplug bridges just
> fine.  In particular, arm64 systems using ACPI.
> 

Okay sure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
