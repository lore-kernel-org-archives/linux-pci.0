Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240844;
	b=Y1VD/KJ5YFG/I3MOQnhGiL6xWCK+ptoUV3No+DKHl5vdP20RPG3olL7TO5/QSp3tP4US
	 1p7hochVTf6xKXLVXF5JsMUetwUxEKoEX+xnYkGq0mWm5DBM7hSMPGJ/3IXMNQhsZ8pOw
	 LbNQploi5DGP33xeD7IPFBpbk6/SurjfEMStCCTEmAEC8ImsJLpOnrqHyUw6YkJ8QIYWZ
	 YfSkQwFrsZAelj26EmU+zXl+BWBjog6nGqQU+u7wO98HcP/3RPXeeQe3LLKwC6k3/24NJ
	 Tzijw0twJuJ/9iZLw7d5728mAmijadjcdlsiH0DAllaBnDqtjNfoY7pmXx6CbcSxvPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240844;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RVDPfH3Ode68kwTp62yVfBJGx284cqqREueZ0mgCu50=;
	b=0I4eVE/HJ0htWsdmB11hrHh3xBWRkumPaLpIZMuhQkDdZ2xm/Hh2XJNN2+JoEiroU9vN
	 0Z0E+L65dKAl2jqFM/YkI1wNurYE2ouK0Mp1irl7+rzN3vYq4N+/N0mOH+H9sjfXGJ8jh
	 Ei1LlTcpVTMz57Eq0iiwDceRaIlRjplZEfk2Ss7tBBB6R3ultTi869ekhAXIAfqYHE+lh
	 eyZV84trLDN/nqRq/DwxHwit2VG4CkFhUpdD4f6GkkwnRjswF7uBtH8AGPoRYCHsNtRTp
	 +vYBg1sIys87CyWM/ka+JjCgXZoZRiP+bbstqE2w1xlWg5hFx/YgVff8jjoTHDR8MWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CU0HHyi6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8C606A321;
	Mon,  9 Nov 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CU0HHyi6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9746D1F0089F;
	Mon,  9 Nov 2026 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240844;
	bh=RVDPfH3Ode68kwTp62yVfBJGx284cqqREueZ0mgCu50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CU0HHyi6GMM0L8nyluZV31Up/1fO8WvY61hhbWIWblXQ6zr8pk/yOozZcSXF9s2Gw
	 1fauQG1x4ePXkriBbjDZLb/rqDVSXPBitEc9itwk+kW3/axxwoNaMCRSldfXqsJkYG
	 jBgxlgMEyAn95SLNLswBBHApMidahSZfI/7PaK4OiFmX+cm+zSVa0umITM5ika8OLI
	 QqZwnsjV8at35PqqbshP2ezYXC2FhiNk/Ho3iw4CQO27i4jpTTi6M/nSHjGebATqJy
	 Pg5cEEYhfhEPLK3/dc0C4O1i5oikUOhNadoofQsc4uBetL6GdsfBo3O/6CanwLLU0M
	 wA+Cmen/Ci4tw==
Date: Mon, 9 Nov 2026 09:14:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, maz@kernel.org,
	lrizzo@google.com, hch@lst.de, changfengnan@bytedance.com,
	namjain@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
Message-ID: <avHxSog2_rsJKGUy@kbusch-mbp>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com>
 <87wlqpwukt.ffs@fw13>
 <au-DcqwAz2wmmOne@kbusch-mbp>
 <87o6c0wbo4.ffs@fw13>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6c0wbo4.ffs@fw13>

On Sat, Nov 07, 2026 at 10:53:47PM +0100, Thomas Gleixner wrote:
> On Sat, Nov 07 2026 at 13:00, Keith Busch wrote:
> > This is done on purpose: pci_msix_write_vector_ctrl() already has the
> > same offline check, so nothing actually gets written, same as before.
> >
> > And regardless of whether it's offline or not, we have to set the
> > PCI_MSIX_ENTRY_CTRL_MASKBIT in the cached msxi_ctrl. That's common to
> > both paths, so it lives in the noflush helper to avoid duplicating it.
> 
> Indeed, but that's an unreadable mess TBH.

No disagreement there! I was just going for a minimal diff, but we can
refactor a bit on the way. I'll take a stab at it.

I also don't really get the rationale for putting the check in
write_vector. The commit message says the checks are to avoid having to
deal with errors, but posted writes don't produce errors, so not sure
what it's actually guarding against.

> Can we please change that to have two functions here?
> 
>     pci_msix_write_vector_ctrl()
> plus    
>     pci_msix_write_vector_ctrl_and_flush()
> 
> and fixup the related call sites?
