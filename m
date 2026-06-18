Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AA3E92B6
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779465; cv=none; b=mzkss6u7MC9QcFMroYMHH+oMAJjOdbKzc95n8xjAVcqG68K2cft9PXe6YZn2jOljs/Zux0AXh3ipCOUgKSXGyL7pxxGLjT/RpwvyImO47rs7J/2IWbP0yE+TRNFFFgfdXhS1LfcWKdf77L9ogpsLN8SIjQhWaJ8JzxmQVd1YJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779465; c=relaxed/simple;
	bh=z1L+NXEaJwhBydsHrUq9XiOqhao7x4szWnTpR2dx4Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R273V2z/ytF0I6PZvcGY/uUzC5lnF7efVVfHVNN7Uw8uGOKV4SkmSsE8f3gOemgpH88JseLSx25GR/GWueQL5Ckp2aZ4z4Zd4u6bunEZa4KNJKCDfCiqaNXQ4q2Gs24Scw1x4gGcHvIPXC+g6tBBHTbGCbmHSj0XFFH4wE4A+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk7SSUD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk7SSUD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A501F000E9;
	Thu, 18 Jun 2026 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781779463;
	bh=lUkPShCZq8NweEIfJF6hR2D4BkBv32nBgPip+yYhy7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uk7SSUD1+l3nWmAEljDf7urUFur47zzN9jeQ0QLHa8LH2qCo1I8mMKSW7q6AVqbY1
	 SALsFP9as3/c/N9HJxD0SeLyWKge0bbLMBK4d4kFSJIqEVAtJTvlpRoFcM3KfgzyMP
	 Pdg8WLhUXAfQjXXZ7mzRYUlTfuvUQKJjMoBCrVCaeIDNru8Jn3f1iYP4orQ4DQqkmB
	 Drt2IvMiK4aumhcoPeH/2aZsJb+VM9qIzPHi+b33wpN8hP/Pj41nyYvWvZuAJoQe39
	 QW5eNnkK9gjHgKtk5db+73Guo1NCEvA/vDd8/XBW7xzU+K3GQAEWDaJsop6cmJklGZ
	 N6yNLb/k5lxjg==
Date: Thu, 18 Jun 2026 12:44:17 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, Mitran Karthikeyan <kmitran@axiado.com>
Subject: Re: [PATCH] MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL PCIE
 entry
Message-ID: <i5c7whfa7cgo4vdx6msika3shhqst3mcqp3x5cqeue4ihi4ktx@vbxxkhxokbug>
References: <20260618080811.26337-1-manivannan.sadhasivam@oss.qualcomm.com>
 <ajO1Cqy13B2xCEfO@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajO1Cqy13B2xCEfO@wunner.de>

On Thu, Jun 18, 2026 at 11:06:18AM +0200, Lukas Wunner wrote:
> On Thu, Jun 18, 2026 at 10:08:11AM +0200, Manivannan Sadhasivam wrote:
> > Karthikeyan's Mobiveil email address is now bouncing and there is no sign
> > of him [1] willing to carry out maintainership duties for this driver. So
> > drop him from the MAINTAINERS entry for MOBIVEIL PCIE.
> 
> Thanks for doing this.
> 
> > +++ b/MAINTAINERS
> > @@ -20438,7 +20438,6 @@ F:	include/linux/switchtec.h
> >  F:	include/uapi/linux/switchtec_ioctl.h
> >  
> >  PCI DRIVER FOR MOBIVEIL PCIE IP
> > -M:	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> >  M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Supported
> 
> Maybe also update .mailmap to point the bouncing address
> to kmitran@axiado.com ?

I thought about it but wasn't sure if that is a good idea or not. We didn't
receive any reply from Karthikeyan so far. So adding mailmap entry means, he
will be contacted for his previous contributions that he didn't wish to receive.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
