Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9C34C124
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448834; cv=none; b=h/PX/6yBZr+A/uQTwOe4HA7sreSdYyQCYSQTol0daE3ADe6Vi0KUNNjYt8zcKUhWPQ9PTXAx9ciBGYx4VyMk70fSLBEbUXz799Vea4ANdFPk4Mo0rRxnuEvp2JTMSsPEh/W6srskuq8uDWoXMeZObQnHEIbreWE/Od6RugTIRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448834; c=relaxed/simple;
	bh=JfsaIbKtWGC4UjOW4UraYtIvpUA6zy7lJFmDsTNpwTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WFJTTLm0tRF1/WCDpISS+/vb16JXomlpmDEU3XjRYej1giPYxbNumoEdNQgh+TReyops7NpR1hifCL+iOF5DJyLZewwlCRGw0zps70lwpGjmCz11EtyYyFFXsH6Dxq3BTT8skSKGASoYAUra3ZA3fe9S72HHklBWsDxEK7Kee+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq7JJG77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq7JJG77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D40C16AAE;
	Mon, 26 Jan 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769448833;
	bh=JfsaIbKtWGC4UjOW4UraYtIvpUA6zy7lJFmDsTNpwTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lq7JJG77yS6swmiyjTYVEzEGARyeWupw65CidnuLny9m4/mhCNfSDhv8YkEkoAVl6
	 SqQtUH6/6pdySDAhkGijOsZ58+xD1N9qNtxMFabmwVgYMD8RXHhOADYySg9Ukpw9uM
	 rajAhqbmy/RFwwZsGGKjsphRqARor7cio6zS6nBj7Ya7XWM/A/LpbaU54+4LeNoFBL
	 e5r+IlzKRyXFIvC6tWkKbxdJFmOQE3Z+zQRh+z7Rcvw3o3r8jKGhK5buc172jkli5S
	 5hPbpz4jlWVMX0HdUfzxDUr691X72f2Ux/NnjfMfZuHzWolSRzIG2TraLVmmaFfXL/
	 SxApdY7AN6Nnw==
Date: Mon, 26 Jan 2026 11:33:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: bugzilla-daemon@kernel.org,
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte+lkml@tnxip.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [Bug 220775] snd_ctxfi fails init since 6.18-rc1
Message-ID: <20260126173352.GA245281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0e34d7a-8919-f3f9-1136-23e6e9f7b203@linux.intel.com>

On Mon, Jan 26, 2026 at 02:03:52PM +0200, Ilpo Järvinen wrote:
> On Mon, 26 Jan 2026, bugzilla-daemon@kernel.org wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=220775
> > 
> > --- Comment #27 from Malte (malte+kbz@tnxip.de) ---
> > Did this patch make it into 6.19? I just tried -rc7 and the issue is still
> > there.
> 
> Unfortunately, it's still not applied:
> 
> https://patchwork.kernel.org/project/linux-pci/list/?series=1035150
> 
> (I also checked pci/resource branch and it doesn't appear there).
> 
> The fixes used to be in a separate series but I've so many dependencies 
> between my pending work I had to put them into that larger series (in 
> hopes that it would have all gotten applied in this cycle).
> 
> The regression fixes (this and some ppc (IIRC) regression) are in the 
> first 5 commits. I'm not sure if taking the entire series this late is 
> a good idea even if the rest of the series should be most no functional 
> changes in preparation to some work not yet submitted.

Sorry, I completely missed this.  It looks like we do have an extra
week this cycle, so two weeks until v6.19 final.  I put these on
pci/resource and hopefully we can make it for v6.20.

Bjorn
