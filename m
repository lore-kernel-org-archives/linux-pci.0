Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC033B19C4
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780195; cv=none; b=iSHGoeQ7++EdEp3tStGOR4rBAv6AE02k9oNeOsi1rJoVFTBvc01yvFMGrPvCY6Ebxpc8axZY2o9VXXWZsp0Sjf/bvM+6ezq+gT6/goTwLLrTIsVjCPkglXta6hjCh27bLuXPXHXNgk0wMWYmZ1o2C7ZveQhgXucPRV/9PqPLR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780195; c=relaxed/simple;
	bh=XpPGFk7CfAYdX+GkwUJ06scdHTyKtvC/6Picjpya0nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+Rgh8UwluXcxXoLSlq8A01nW7zDTxFrhxKZ4FQ7tDVvryvhervSw1+XZ2H16kXrFnYP5KC2eril13s0D/z/x8sM1Px+tJOCc0yiRA9RuHWuWwUnqZJXgcpH1LSqJ+h3QN4fPUuD4g5lUb2KfVojzuWEeQmbvBWRh2ewFHDsrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 7DA9537F;
	Thu, 18 Jun 2026 12:56:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6A4F560CBE59; Thu, 18 Jun 2026 12:56:30 +0200 (CEST)
Date: Thu, 18 Jun 2026 12:56:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	Mitran Karthikeyan <kmitran@axiado.com>
Subject: Re: [PATCH] MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL PCIE
 entry
Message-ID: <ajPO3lCupu_kyd0h@wunner.de>
References: <20260618080811.26337-1-manivannan.sadhasivam@oss.qualcomm.com>
 <ajO1Cqy13B2xCEfO@wunner.de>
 <i5c7whfa7cgo4vdx6msika3shhqst3mcqp3x5cqeue4ihi4ktx@vbxxkhxokbug>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i5c7whfa7cgo4vdx6msika3shhqst3mcqp3x5cqeue4ihi4ktx@vbxxkhxokbug>

On Thu, Jun 18, 2026 at 12:44:17PM +0200, Manivannan Sadhasivam wrote:
> On Thu, Jun 18, 2026 at 11:06:18AM +0200, Lukas Wunner wrote:
> > On Thu, Jun 18, 2026 at 10:08:11AM +0200, Manivannan Sadhasivam wrote:
> > > +++ b/MAINTAINERS
> > > @@ -20438,7 +20438,6 @@ F:	include/linux/switchtec.h
> > >  F:	include/uapi/linux/switchtec_ioctl.h
> > >  
> > >  PCI DRIVER FOR MOBIVEIL PCIE IP
> > > -M:	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> > >  M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >  L:	linux-pci@vger.kernel.org
> > >  S:	Supported
> > 
> > Maybe also update .mailmap to point the bouncing address
> > to kmitran@axiado.com ?
> 
> I thought about it but wasn't sure if that is a good idea or not. We didn't
> receive any reply from Karthikeyan so far. So adding mailmap entry means, he
> will be contacted for his previous contributions that he didn't wish to
> receive.

Right, but the alternative is bouncing messages whenever the old address
is cc'ed.  I don't now what the policy is for this.
