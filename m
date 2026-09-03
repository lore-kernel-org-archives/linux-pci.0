Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719135F192
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405905; cv=none; b=uqapg6ZvWzsR+qox5/l2GwquqPdK0G8DE2+mgxLhcbsbCT3BTsL01YyNNTl4W5Iw6NNJweBqX5jPEOunbj01ItfJX8IN8FN/KsR4fV0rR1e3QYVtXyLjNG4giGoNkiVulR+1tVfqlj2plmnN9Ec6HB/JZXYVMN5bdq7kgmh9VMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405905; c=relaxed/simple;
	bh=M1pna9P8kBRQcfW6d5Nv4IAZit0duE+b1rxpMyx5P8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUUC+SyFeZDFjCKXhsFvIYUwGxkNE/PR5llBmlkJ0x1gEb0CZpJdf/ZS9QtTQSnQOcpy2QbUeJQpJj6+pgizXexg5rJAbMPiZ6KP3kaKs/sxISpD31ScaUumUsVVcrBhGUXsvcC2aifm4QJ09UV1Vjl1t/b5wdlQOEi+WmhkKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngUFAb7v; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngUFAb7v"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1770340a91.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 20:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788405903; x=1789010703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ocqW2AbRH/BUk9DjTZZYfR1XHut0Pc1pAr4ie873JH0=;
        b=ngUFAb7vAz/6crUADFwv+A8uOQo/TKkS7KyjFwc1/RqwYOmmpdx3vknNtOf7EdJf/A
         sWUjDG7lUUW/GMS7gUBwDgW1rAhrfh71P1CWmRR8uDuzj3bpgU8JatZXl4L/UBzpFIki
         LRCDdkvwK6suaTQiy23/zFWCRUdRrj6p7fUHHgG+LAJzCtf3/n6cpP2+UP/WVbU8XqTL
         uS/7yccOfMNx8ODojZ7UISF2wxX0nF4cyAVK8zNv7NTtosNY8mbW+9DNZKXnZskiQyem
         pIDvgJpRhXNB0uRPD2tB6JNzDUwyJVd0hNL8jxvb6oT5EDlKyrrieRfF9TqSR77FqEvV
         Bofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788405903; x=1789010703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ocqW2AbRH/BUk9DjTZZYfR1XHut0Pc1pAr4ie873JH0=;
        b=T5UkwVomj9dv3qF5lNIcOmmmLqSSCwiWGuFv6wO1Ul69+Z1s7aCHvAlmuT0vYpdhgY
         oO3Wg16fxv5Em+P99CeeBC5B4C1Cgla52bzh/dF77WX6ZBiF8yGkDLOBqhmx9sXrqQMW
         c0jr5jxZfXwrkodYDSEsNW9gE3O3RaWcpTNgfpbW3HU5yiC3qnAgswPFLYKFA/fjGaV3
         Kn1/4jn0Qpe8UhzfQmSzkEgD6hM5ml6F7Fs9/eNU1gV2WwIQZcajqTvwk9KojW5v9Z3j
         bhLdMmaqWUCDrCL7SFg4RB9rYre6cxw/1w13iMXG7UrXclf2LzBMZuJ/Wizl9f+ZGm5V
         ZKBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzafFcjamQnQuu3r1kHvlx909rWmT6WT2xRyvUD7wRMMexcIDhfnoURGj+//tJo0pTyiYYwbHFAe7s=@vger.kernel.org
X-Gm-Message-State: AFuF++nelx/XSlwE8XFyKUmtPgqovG97/uUx1D7QvaaTGvDJjBocb+Vl
	/GZN6Pml20Dp1ibphUj7cl0KXtyt8sw1WPG3Z52llqcgPXCW4RvoqMBJ7UVsUMQJ
X-Gm-Gg: AYBFou3L6RrfL4MDQNbr8aJgCsl9ZEh1WcSXE2naRevC9J5dmNZ1pvZ6YcX/mGuQ7Es
	4dA5LQAMFAJyVBftrUeBrfxNNodMokbeqV3JO8IhiHXUeGSPXSvH3kaObqBMIJEppZ3RW6MTT31
	ErOO2/9q2pS+u4iEgQ2nyKjGG3I4beB2G0gKts8PpKeEiLRHrRjTNui2tZYQn69sA92yPpjqs9l
	gCNvXsB5hbLa0cRSBe+iVFFljZ/RRagcVwIrbcGADQDlPX41fy1jvslAgU9anU2PCQx845F9Zbn
	JUO/zo4s7IL1WhLay8BjoaGHWcZG/ixwmxWgbzn8pnPmrm1mbhaYkM4NpUhDUxd9FDwwa+kvNXC
	GVOk44qNJebo94QW/LpcqqwRWpULRR4u9URhl20NHrBqggQVgGwx6zMeNXf4QVfsn9vn+KC1uHl
	8r6P76yzH4CXkGxIbRGnj4gUQ2rM7Dh3KUVpixwiv8osXFZjOF33sIv/cyvHKFPaIJNVASXVZDN
	Ufg8A8=
X-Received: by 2002:a17:90b:4a47:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-39aee080829mr13760803a91.12.1788405902939;
        Wed, 02 Sep 2026 20:25:02 -0700 (PDT)
Received: from kernel ([45.251.35.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-332d6575f28sm76601eec.15.2026.09.02.20.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 20:25:02 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:54:56 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Alex Williamson <alex@shazbot.org>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <apjoiNcvvJLv2grA@kernel>
References: <20260817092448.4395-1-raizudeen.kerneldev@gmail.com>
 <20260902115117.34a30084@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902115117.34a30084@shazbot.org>

On Wed, Sep 02, 2026 at 11:51:17AM -0600, Alex Williamson wrote:
> On Mon, 17 Aug 2026 14:54:47 +0530
> Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:
> 
> > In nvme_disable_and_flr(), the PCI bar is mapped using
> > NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> > 
> > However, the function later reads the controller status from
> > NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> > boundary and it can cause a page fault or kernel panic on architectures
> > that enforce strict MMIO boundaries.
> 
> What are those architectures?  The bug and fix look correct, but the
> risk seems overstated.  Thanks,
> 
> Alex
> 
Hi Alex,

Arm64, risc-v do panic on out-of-bounds mmio. But you are right that the
risk is overstated, since most standard servers return all ones instead
of crashing.

I will send a v2 shortly with a proper commit message focusing on the invalid
data.

Thanks,
Mohamad Raizudeen
> > Fix this by increasing the mapping size to include NVME_REG_CSTS.
> > 
> > Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > ---
> >  drivers/pci/quirks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b09f27f7846f..ed03892cc960 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
> >  	if (probe)
> >  		return 0;
> >  
> > -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> > +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
> >  	if (!bar)
> >  		return -ENOTTY;
> >  
> 
