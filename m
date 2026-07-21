Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5523318EC7
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593561; cv=none; b=eveymEkLdDhbIxEWfyYmQ4BbQwsbHCXv+zbxvTIcKd7t1bh9HiPWbr1/s093ZDzXmN0RqgBzck+ji5NcQ6oNQ3uP6TxFeAEQiXeczEhKaHU58IKiTJHlFjDnTG+yEjVOTYQAZNHcUIjhzkBDAj0xIIW1Jtti9ClqzEQrnVBTW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593561; c=relaxed/simple;
	bh=CYgDBxPuC4qNR3XqiMuwPaYin0WeDtqHmpltDaqdng8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXrJxaXgoIMy7JVcYYblbFSIslfJU5/P6xqUVKc/XRaWXMmwnF1ZEZ4XHfpE+BGa1ha2hdz9F5bGPtV5gHqlCOOLMuSR8OGw46jy+TeeE+GZejDsscZ6vmDhpTvNHFkmZI3BgCnGfSTMb5vrLetvStMheySEXAS+Sghj56Y6HbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XJV/E/7u; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XJV/E/7u"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ce98cb8165so46055895ad.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784593559; x=1785198359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g1X0juR/1GVeoaU+GRv2SCzxSp9V5eSXjGqtRs69cqg=;
        b=XJV/E/7unVbmruqw+bBZgKLmcgksLyxMGhJs+nBzPEFKsX7rYyAqokD8OYpVRuNOCV
         TeYsALa1l9jwiWNQp9aKKne0nsWhyYSm3hdu/YH1wTqgqtfCT6/jwZsQxUYUGclFyRg+
         yyAD/z8jTQEzQkIQR/7guUvp1ftOq9fufCuek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784593559; x=1785198359;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1X0juR/1GVeoaU+GRv2SCzxSp9V5eSXjGqtRs69cqg=;
        b=BrnGLJ3J1q6z7L/v9M1hlWRv2GrCwTdhM+f4Hm/3J0umj3zbc58Uh+VxOcsTEbNuuL
         NuhXVVJ7iHvdGwYH42RT7/uHt7qS3uhEdTbOOqw2FjLZ1Z/czkxazWSjGL73MKAebtO7
         7B+PP8OIsNQhJBZ5A1aZ3J23Xp57+5DZRM4EfOs4hfll7DteZXL0Gri16Vdf0CmsaxIG
         nhqw6FeZ+sZSN2ohEw6WU3gCVRLPt6WuiEwQWzZnnorzdPhW+n5hGwIi2UVPtMgXoerH
         CyPisIWUF/mBcv1WhdYH+gD6IIOvThAHbFGLkHn+hhRhH6Pj4nv5uGB8BgrdBAjrtOAX
         O09g==
X-Forwarded-Encrypted: i=1; AHgh+RoZ9A7EI/pDWYG7+T1jvMOYGe/gC3NLYiisaJWtgz4FszV5n6iJjVNpQkVgjq4ORdPTRhdKen4UiTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4EbYdUzJKspQexVt6xPOetOepD7hLwzJRtq2+dqHgYdXTAyS
	R7+FtG/5RbXjCfRq0BluDghNDakf1SG14KyflcCGsA9ZJ0XJDa1w0oW62fTQAoAFdQ==
X-Gm-Gg: AR+sD13v7I6sLfLMacsisDwWBdFgRAml3qCnN+1wF+LV2H/u/AwwVDvJ0cxNBVsFhgJ
	nTJSbe/R6+f+rgqWA7pnU3N3S8sUMTaLixEdF2mAWd4AGg9byh6QFBhD76CHgj6Hg3vu9KyM0Uh
	A4c6/xGHqdVx4Ula2qYdhha6Myf1AV8lL/pKTE5CAf0+/A4HtTfqFTk5eyueGnQC3GKgBG5EEeq
	lsxoJsn0n8P/i0yPe2MsxGsoYOfhdpmU/ViOH0PP/SZ/z8u7oBnkAXo7+B1V12XrePztnNc3aNB
	YRGq32Tp016I2Q96wa3ThGvMOQLP6CZyo9YfKcZVVKECgHyR267ZRLRQpLdiI8xPixjsKd6uVUi
	JXRl+JX4oNYtwqfwZNbYG5svskFUVbzOnLXCqkvZyr1/e4x9Sxbv1dvmbMioEWAyncwQhKGONJ2
	o6+thYArfDylD3icXO2ef8BZdmOy6eRI/Ia6CE7ykj
X-Received: by 2002:a17:902:e5cd:b0:2cf:7de1:4a00 with SMTP id d9443c01a7336-2cf7de14d09mr22857195ad.1.1784593559123;
        Mon, 20 Jul 2026 17:25:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:c6dc:f5fa:8751:3ac2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-31429fe1014sm40231058eec.7.2026.07.20.17.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 17:25:58 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:25:56 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <al68lFtbq_Q4RCL2@google.com>
References: <alnnTRldy-deNIFM@wunner.de>
 <20260720204419.GA426578@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720204419.GA426578@bhelgaas>

On Mon, Jul 20, 2026 at 03:44:19PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 17, 2026 at 10:26:53AM +0200, Lukas Wunner wrote:
> > On Thu, Jul 16, 2026 at 12:26:41PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> > > > The PCIe port driver fails to probe if it finds no child services,
> > > > presumably under the assumption that the driver is not useful in that
> > > > case. However, the driver *can* still be useful for power management
> > > > support -- namely, it still configures the port for runtime PM / D3,
> > > > which may be important for allowing a bridge to enter low power modes.
> > > > 
> > > > Thus, allow probe to succeed even if no IRQs and no child services are
> > > > available. This also mirrors existing behavior for ports that have no
> > > > PCIe capabilities, where we'd also probe successfully.
> > > > 
> > > > This change is a bit more important after commit f5cd8a929c82 ("PCI:
> > > > dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> > > > controller"), because it's common for some DWC-based systems to:
> > > > 
> > > > 1. have only have the "aer" and "pcie_pme" port services available and
> > > > 2. not define legacy INTx interrupts properly in their device tree.
> > > > 
> > > > After commit f5cd8a929c82, such systems may fail
> > > > pcie_init_service_irqs() and so exit with -ENODEV.
> > > > 
> > > > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > 
> > > Applied to pci/portdrv for v7.3, thank you!
> > 
> > Some thoughts on the version now applied to pci/portdrv:
> > 
> > * After this patch, the return value of pcie_device_init() is no longer
> >   evaluated, so that function should be changed to return void as part
> >   of this patch.

Yes, seems reasonable.

But then, possibly negated below.

> > * If no port services are initalized, e.g. because pcie_device_init()
> >   failed for all of them, the allocated IRQ vectors are not freed.
> >   They're hogged, which may be a problem on systems which only support
> >   very few IRQ vectors such as Sophgo SG2042:
> > 
> >   https://lore.kernel.org/r/0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn
> 
> Seems like a good idea to free IRQ vectors we don't use.  It *looks*
> like it should be safe to call pci_free_irq_vectors() here and then
> again in pcie_port_device_remove() if a port is removed, but Brian
> wasn't sure, and I didn't look any deeper than pci_disable_msix() and
> pci_disable_msi().

I think everything in pci_free_irq_vectors() is written such that it can
safely be called twice. I'll see if I can verify that better and submit
an update. I was just unsure at the moment of review, especially
considering you had other real double-cleanup bugs in your proposal.

> I guess if we did this we'd need to retain the pcie_device_init().

Ack.

> > * It might be clearer to call pci_clear_master() directly in the
> >   if-block which is amended to "goto out".  Then the "goto out"
> >   can be changed to a "return 0".  It seems "if (!capabilities)"
> >   cannot happen through any other code path, so it's unclear why
> >   the "out" label is necessary.
> 
> It does look nicer that way.

Hmm, yes. I may have rewritten it enough times that it was never clear
how many error paths we were going to have. As soon as you get more than
1 error path, it gets tricky to do this.

I'll revisit this one along with the previous suggestions.

> > * There's a duplicate "have" in the commit message ("have only have").
> 
> I fixed this on pci/portdrv.

Commit message looks good, thanks.

> What do you think, Brian?

I'll give the above a shot. I suppose that would work best as a v4
(pretending your pci/portdrv is only a reference, and not a patch-basis
target).

Brian
