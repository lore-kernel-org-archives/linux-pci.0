Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CC3839B9;
	Thu,  3 Sep 2026 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788409326; cv=none; b=eK9yiUBLIYyy/IQ+2y5AuSq5N2FgUCf7Tin4eObeGT8PqBqjS92YNL5iV8c0a9aTPCuL3jD4jFn67z0YBPOKeAhjC+3RKtjdTsPWzSPkgc/Ce9riEA9kg3Lyod83XoXisOFBzEVkedP7C5Uc4Z4Mb6UKqAvJjXM//CevplEPcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788409326; c=relaxed/simple;
	bh=HFOJWxqeO4wfXtvDF+H7QzAI5pZBObE2aoT6cxb6ESc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGfq6gwkTZfgrfdg/rCSpt9cBEAhu31ONDZH8gsKSxq8rwA4uQSxBux0GZiJ5ou/8AVIFr5R16STmZX1ElxAgbjg/C9Im6ZnbQkYUvOorPlc8b/y1lprbOMv+z1vQFF6Nj4eE3ILnx0iYh0J2xH+CQBA8RnrWKFk04YyEGYc6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=EEEeg8UJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9V4n8CT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="EEEeg8UJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9V4n8CT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 006F5140005F;
	Thu,  3 Sep 2026 00:22:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 00:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788409319;
	 x=1788495719; bh=jYUpAVkDBHkFbLkMRCk6nXlRFqs01HYTvaEqyk/J83g=; b=
	EEEeg8UJb+5Xb+80bk1VUPkst76OT4G7p5Hp1/8g7CtpNiJIwuuPeIzEVMW7F5Ek
	v524DL14QTAt9sHNs1NpyhwANhz/4n9yd4Ou00Kj+aH4c86EalW9bAIM7eNWPnaN
	WDPXWa1GP2bgyiIH099z9ucyp0goYcbAZdyRxOinjbRJOTQ/GF2KLMVEIvDCNUYE
	yYleFL8FAj8qsqU0S/DD7SyMzK3rCWqn3iSihbY8LiHU0v8ugPzYKCQsWRPfsdcl
	GeSW3EpAX7fSNHFyug1Ek2DVfx7ICKFsFOpWWVNU/5pMYT/vhT2f5M2+KXyQNlXb
	BLGgFuFBoYLEpl/P/lHHPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788409319; x=
	1788495719; bh=jYUpAVkDBHkFbLkMRCk6nXlRFqs01HYTvaEqyk/J83g=; b=M
	9V4n8CTYWZTetrluFXQUBAeeKcJS5jRH8UgcnHIZsNx5tU2FBUQue6yX9bm7q9lp
	h4dwXlgzLTRyL4aF//z+V0P7dM+z0Wf2LGSln/7mHNAbaQm8aha/eERD4QP+KZ6b
	uiroQUIsFRZoDxwh4JzVRiyNHNSHpiv+2GHWj/O+W6f+o63/ED3UTHK5Yaml0hRm
	qm9FL5zZU4kFopZ37lT1EUMdEShmzmB6zzJbfTs/YWiSt7I6xnNNO+Nd2aItlARr
	gXOsJxhPxNW7d5h4f6lV6UgFYYcqGuR19sGAYFDLlpeU6+Q+sfFFWtA5azC3DBuR
	8rSDJgD3oWqncT+H0LDCQ==
X-ME-Sender: <xms:5_WYat75H6b6n0H0JIkEB5mELcC-Tl9TAJcjY_OGCgEk66d5NdoZCA>
    <xme:5_WYarlFcuE4zafPqkS6Y3ltDtvZ1pGcr9Oob1AD22hDaK6lgOyMpqu70uIZ2SGAN
    28zPN7pCAZRqFcL5ERLqJ3T0ezq0FaW3VYi_7_GOM4UYUzawa_HWA>
X-ME-Received: <xmr:5_WYaiq6jKRQDzyJXmjxxeK7vVLRHq0KJ6HIpOdus2Y1-RaGymF02WUFeq7H2g>
X-ME-Proxy-Cause: dmFkZTE4cY/bF8MbAsLk46i0QkL781zbVjCKHq08bFy87bO2lQRnjMZ9IQ6yxk6AfccKZb
    +wL5xCrtQ1Kfxd0lcIRFMp7hm6J3JILJhEylTnKF3Xl9GSFUae14wewcTGb+4nYrk9spEv
    Xvx1ROY4LOWu4yjAjMBgEvszhAM8HAJXYgQ8M0CPIaNLtwtFC+5m1rer2IGWG5tQb8D9E0
    cMmKB28IsYMQyCPg4YY6KZCzJAWmumsCBSNFOUAQSPj9OOEkSzkcEQXqQDCu5xVbEjDNDl
    ecHQHrtVSbpHw2SgLoNPzEjnXfDh9/KOzhsOmHz3XQyIKQaE5Pr5teTLAyO4TUhVEQmWhH
    eIpR3beMuWXH4+b9vCJVi7nIWatOYFYzyaZ/6brUQSEOyt/33vsxsWDMwfpjGJvbl3tTAl
    7ZhyfI18RSSqH3TajKAhkwCztCi7H+FC0PzsaI4iJCmn8Q76AbQ8fiv1Ie1B6d+CCvRUaL
    rHhOndvLZBY1xVnoCJwUgCpT5deLG1iZZyb09L+3ze0h9X70n+pdOyIPCNcvpD/2192HXN
    qCr7ohi2Kxt5jlwNhklfxVxqQ80E3MrfNffjZqGHmWPxGH4rdITIjSqOaR5lDE90snpmag
    zUTlPQ0fjYVywAeUg3psVG2JrxC0HWvpnKnsffFvq8Wcr/9S6kYda7SAIg1w
X-ME-Proxy: <xmx:5_WYaqtfMtx6BOu-mXC6IfrF0R_471tu-D_eTHufe5IFbP7DbhcKAQ>
    <xmx:5_WYanG55PJTeDRheU7Rn9pnEu-F8KxssVKFjSsSFKFUeLQy-y-ivA>
    <xmx:5_WYajZ2k2peDByZuUH8a7w3XWCNgU2MwDb8K7n9b1sBha791y9yTw>
    <xmx:5_WYavWWUj73apujyVO9J5wHK0bOVrvZlMajLHenM71MgjUcApxKgw>
    <xmx:5_WYagfmQFx_Yp3F_A3AiK52f7v-jpL-QLcPHXjI08blNErfhJFP6Smw>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 00:21:58 -0400 (EDT)
Date: Wed, 2 Sep 2026 22:21:56 -0600
From: Alex Williamson <alex@shazbot.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <20260902222156.393e2457@shazbot.org>
In-Reply-To: <apjoiNcvvJLv2grA@kernel>
References: <20260817092448.4395-1-raizudeen.kerneldev@gmail.com>
	<20260902115117.34a30084@shazbot.org>
	<apjoiNcvvJLv2grA@kernel>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 08:54:56 +0530
Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

> On Wed, Sep 02, 2026 at 11:51:17AM -0600, Alex Williamson wrote:
> > On Mon, 17 Aug 2026 14:54:47 +0530
> > Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:
> >   
> > > In nvme_disable_and_flr(), the PCI bar is mapped using
> > > NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> > > 
> > > However, the function later reads the controller status from
> > > NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> > > boundary and it can cause a page fault or kernel panic on architectures
> > > that enforce strict MMIO boundaries.  
> > 
> > What are those architectures?  The bug and fix look correct, but the
> > risk seems overstated.  Thanks,
> > 
> > Alex
> >   
> Hi Alex,
> 
> Arm64, risc-v do panic on out-of-bounds mmio. But you are right that the
> risk is overstated, since most standard servers return all ones instead
> of crashing.

Are you building with some sort of sanity or debug checking enabled?

While we're clearly violating the API accessing beyond the requested
length, it's my understanding that we're generally working with
PAGE_SIZE mappings at the MMU, so unless we're crossing a page, the
access should work regardless.  Even for the cited archs.

The -1 return is typically related to how the platform handles
master-abort when accessing unimplemented or disabled MMIO space.  This
out-of-bounds access shouldn't be triggering that, it's still within
the enabled BAR range of the device.

Anyway, I'd be curious to see the backtrace and whether there's a
config option to enable such sanity checking.  Thanks,

Alex

> > > Fix this by increasing the mapping size to include NVME_REG_CSTS.
> > > 
> > > Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> > > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > > ---
> > >  drivers/pci/quirks.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index b09f27f7846f..ed03892cc960 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
> > >  	if (probe)
> > >  		return 0;
> > >  
> > > -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> > > +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
> > >  	if (!bar)
> > >  		return -ENOTTY;
> > >    
> >   

