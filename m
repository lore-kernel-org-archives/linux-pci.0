Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69303C1D75
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415636; cv=none; b=tDUvMVu5gSO07P/lh06/SvauFFOxZGNsEu0AZ+IvZS+dDtVzuVbPE0Lq6DpMk7d1UkEqVeUPlAzopE5OPTzLJym5e+yGkvyDcvB4xjtH6J11BRiUPdzDiSIWNs62DuWdU3K6ZnNhEqAYaTEne+gJn8++XqlBOwcX9nZWoqIlwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415636; c=relaxed/simple;
	bh=Qlu2kSPeQ9fQnX7dfvoM0kmKFMfGiV5UUteJMfTnJLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5iJtQnGpJLYoLu+ubDr31NQhJjBYQDCgnaIYqQzLz6qpodncIyR/tm+PoBKj1qyVWTJaLXFC0Plh6dITUEK03/CTH0/whHm7SGYaC7ZPT+8UoRJdFRrTboS8WQJlcnB+xoiOpkb8DljMLo2MjYEQpUFmTMNv+7sbwT2wVtIF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0lxdCMA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0lxdCMA"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-398b3d66515so2532052a91.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 23:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788415634; x=1789020434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gBUuqGg91aYvqgQOgpAhdv5iVIgNNaz0N9DNOLXqnd8=;
        b=o0lxdCMAsm3DZyC1qyrOKk46oLlc6GiOQg7hcy8lo+85FUFXW3d55nnRYo5cJbFE9m
         OhxGQf9w4cBsru2sNe8/YFebakDo0XJhXrQBtoXey2ya0LGkOd7IgGfVp15N0D+hXhyF
         EWmu0yCLXp5RL6VaFm1TGIc3GD2bLkqpYhWLot8s1Qnp6CTqHMW0xbnISuWq4Oc/ZPQr
         dwHWbLhBBSFz8S9L5mGl65DRsr3btN+2keub6LQLkKqt6qiObBxgoC6UEVrUQyTmBT/3
         knFJMmIlDtB1Uo7Tq9zyVu4zLaaIhC9Elijhwi6xKxYCZhTok/hwzdLV/nbup7EYASEK
         30ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788415634; x=1789020434;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBUuqGg91aYvqgQOgpAhdv5iVIgNNaz0N9DNOLXqnd8=;
        b=feuNz7SIBuRUozLd4RXldR8DKLcI9Sg2EMvJSLSGffPQG3Kqu6tAgvnFtOAAJdp8JP
         AlA4454tbfbDOtDF21IZVgb41p9t/RuoTOLItStVoHpRD0hlb7WO0j2TJU9Dup523WRp
         5iM1hQUQMRo7+IGJEibrZs3na71nTn5QglKhbe9MhX0OgBrzhCtKGH99fg6R2SNFSC3j
         FZUkuMq8ntsgcPo0o7wslWApBQoUijmaLpCzOnzlteo+QgRopVSiqamswXs/1EQzF/wo
         uU0xem77qxj1AGJBREEGFVwhib6usH/vQQhV6J493xLTnu/1E6m6Ax1pcP55+LKJBA2L
         k1tg==
X-Forwarded-Encrypted: i=1; AKwUvBwJHrT+pFtA3JDYG3X/KZhqTnZaDlMglL5xh/oF1Ly/l7yawXJv9hqYJTpyYl0zbrOvVbzRaOYIa78=@vger.kernel.org
X-Gm-Message-State: AFuF++mI6Hdy1iq/Us7hNfTnu+EEwc9NmcXxLn9m0lq29XJTd7igOkYn
	Wkd0gB+5BAsgeH4Czc3TUmXOMaN7NOusn/Hjtzs+BiqmW1KsDa1ypLvr5gq5YeSI
X-Gm-Gg: AYBFou14iuCfIh8w5PNFpjqqZkSFAyYXDfnhK9ogJqqtu7MIqUxMgvXtDbJDVFYFYjn
	WrwCl74hkLe9V0tHzlRTkMNxKH+9mOyUDD5qhPDtkuhzHhR0niIZSFTLm5ykDeyf3tfvtVIx9GF
	Zj072oQ5wNsTh1pFocBlwpGlRhabgngTZ6JJLQycs1BoDNgaAdPEDig8vaO/lcxPjHhZAivFUCL
	qd8yuLSjaXjp9/aSnnN8aPGsh3wKsxPndyy00d7EgaF0UL3INrdN0FewH35ch117fb9YNsa894Q
	jAYmlVRYr9qDf/V7KZrxFeFZMLljTxBgj4toFG52+R/mtIII5GdEn46rA5fdXolqc2OMy0hcjFf
	LglRZQ9Co646j2FkdZ+OwN1QWi6eQ8zI9C9OPPSMrBZV+TYigk9XToDZPrJ8RCQ+nf5nk9vhMc7
	9bDfMk4SIhhFNkxGZZIbdmd0dJsOCZya6Q6nYD6DLBzFESp3VmhJ72c3EdxgvaBKq50rRAqF60b
	kQ1beY=
X-Received: by 2002:a17:90b:4b0f:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-39aee15920cmr13300583a91.13.1788415633539;
        Wed, 02 Sep 2026 23:07:13 -0700 (PDT)
Received: from kernel ([45.251.35.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325367238fsm3671440eec.2.2026.09.02.23.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:07:12 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:37:06 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Alex Williamson <alex@shazbot.org>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <apkOikPtaTVYnJ1W@kernel>
References: <20260817092448.4395-1-raizudeen.kerneldev@gmail.com>
 <20260902115117.34a30084@shazbot.org>
 <apjoiNcvvJLv2grA@kernel>
 <20260902222156.393e2457@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902222156.393e2457@shazbot.org>

On Wed, Sep 02, 2026 at 10:21:56PM -0600, Alex Williamson wrote:
> On Thu, 3 Sep 2026 08:54:56 +0530
> Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:
> 
> > On Wed, Sep 02, 2026 at 11:51:17AM -0600, Alex Williamson wrote:
> > > On Mon, 17 Aug 2026 14:54:47 +0530
> > > Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:
> > >   
> > > > In nvme_disable_and_flr(), the PCI bar is mapped using
> > > > NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> > > > 
> > > > However, the function later reads the controller status from
> > > > NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> > > > boundary and it can cause a page fault or kernel panic on architectures
> > > > that enforce strict MMIO boundaries.  
> > > 
> > > What are those architectures?  The bug and fix look correct, but the
> > > risk seems overstated.  Thanks,
> > > 
> > > Alex
> > >   
> > Hi Alex,
> > 
> > Arm64, risc-v do panic on out-of-bounds mmio. But you are right that the
> > risk is overstated, since most standard servers return all ones instead
> > of crashing.
> 
> Are you building with some sort of sanity or debug checking enabled?
> 
> While we're clearly violating the API accessing beyond the requested
> length, it's my understanding that we're generally working with
> PAGE_SIZE mappings at the MMU, so unless we're crossing a page, the
> access should work regardless.  Even for the cited archs.
> 
> The -1 return is typically related to how the platform handles
> master-abort when accessing unimplemented or disabled MMIO space.  This
> out-of-bounds access shouldn't be triggering that, it's still within
> the enabled BAR range of the device.
> 
> Anyway, I'd be curious to see the backtrace and whether there's a
> config option to enable such sanity checking.  Thanks,
> 
> Alex
>
No, I am not runnning with any debug enabled, So I don't have a
bactrace. You are completely right about the PAGE_SIZE mappings. I agree
that I was mistaken about the panic. 

Also, I already sent a v2 that drops that speculation and just focuses
on the undefined behavior of the out-of-bounds read.

Thanks, 
Mohamad Raizudeen
> > > > Fix this by increasing the mapping size to include NVME_REG_CSTS.
> > > > 
> > > > Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> > > > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > > > ---
> > > >  drivers/pci/quirks.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index b09f27f7846f..ed03892cc960 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
> > > >  	if (probe)
> > > >  		return 0;
> > > >  
> > > > -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> > > > +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
> > > >  	if (!bar)
> > > >  		return -ENOTTY;
> > > >    
> > >   
> 
