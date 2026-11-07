Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081653;
	b=jWtF+J0FfUqLFK0SJlo0z/jQr9mo9xQigBoOQMBRXZZo3wrkxiJJc8yKpo0K/3bWV8NH
	 DHjKzi8y+24+YQ4oYX9KeKDMSdveb2xkHXWPwT9da6RFjRNWbT7/4JFpqQncROmPftIq9
	 vmyGNd4bAZ9kBgxtKYZpVluJcHXLbt4LVjyPsGfDsPZjL0vb5P75tIWgYJJq1KxGJMAdR
	 d4BMMfCHgCnEHL/bsfGVduWCIdogrC+Jhqp9Am2bneCRBZLTbw8R/J159KbT7TwV2oAmJ
	 4P2F0h40iT2vLpfMDLMzI7hF1jLYHZYSkkOAgTA7yOAMZBcRjwu/rXgrrIDSiLYXVJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081653;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=D+WPfo+qbidntoQuZIdORED59/5TVu8lZ6NuximfsFo=;
	b=QzQaP8n5h/GfnA4GPmbRoMwLv28N/AlEerePy+OQAjqXP8P/fx5TeaqKI4o+lD7HV5g4
	 U/Co0dQMzvatN9169XK2zZ08iVqL/JNEzfhIhbF/DE2YDwlK+86IY89nG70Smt67SjfxZ
	 Uqy4zNB63y2c20/z8tmXp9NCk8x9g7loqLJXRvGzjFxronxylkWJdwau8pJD4aZO7YyxY
	 CuKEFQZCT45POAH2Z4d/+pZJ6oiR+O4rdIKhQIeqyx1uB8IK/bjzgOmJwDbpmnDAIT44U
	 aYJ9s54o7h1RjasXu7+hK1nFb8ICsEaIezq4RUFUqlAe+pZ04UMHLLVqhIX1ljQ/q+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZMTYZM/W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70EB606A32C;
	Sat,  7 Nov 2026 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMTYZM/W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093661F0089F;
	Sat,  7 Nov 2026 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081652;
	bh=D+WPfo+qbidntoQuZIdORED59/5TVu8lZ6NuximfsFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMTYZM/WiGXKAkuSlDGYEyhe7HivsVF65PfVuSKDaaymBqvobsjmMnxldaRkPAhCD
	 Y615a72iYrZPyIfl+0p6l2U5sGf48S5L0BvK9Av1FYnidsxDHkcf2mbwKMoC/7iTwh
	 yJupr+o4/6IlXdQllbSDW77abxnB6tk2Z5HjpxldS1pvHdl4yIx3889uj0ZWgom801
	 C1DVS/NHDVNBkNymqt3X57oyAJjX9viUQdWnqcHncB+kJy3rZI+bW/aviM//BtJRmH
	 XDT+nwCixxHeyVZjd5Ouw855cEyrr4DeDvBVb4Ph854WnN86THjn2SEqoPocKw4QSl
	 iha0oIDDftSLg==
Date: Sat, 7 Nov 2026 13:00:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, maz@kernel.org,
	lrizzo@google.com, hch@lst.de, changfengnan@bytedance.com,
	namjain@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
Message-ID: <au-DcqwAz2wmmOne@kbusch-mbp>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com>
 <87wlqpwukt.ffs@fw13>
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
In-Reply-To: <87wlqpwukt.ffs@fw13>

On Fri, Nov 06, 2026 at 09:53:06PM +0100, Thomas Gleixner wrote:
> On Fri, Nov 06 2026 at 09:34, Keith Busch wrote:
> > -static inline void pci_msix_mask(struct msi_desc *desc)
> > +/* Posted write only: the device may still send an interrupt after return */
> > +static inline void pci_msix_mask_noflush(struct msi_desc *desc)
> >  {
> >  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> > +	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> > +}
> > +
> > +static inline void pci_msix_mask(struct msi_desc *desc)
> > +{
> > +	pci_msix_mask_noflush(desc);
> 
> That's before the offline check now, which looks more than wrong.

This is done on purpose: pci_msix_write_vector_ctrl() already has the
same offline check, so nothing actually gets written, same as before.

And regardless of whether it's offline or not, we have to set the
PCI_MSIX_ENTRY_CTRL_MASKBIT in the cached msxi_ctrl. That's common to
both paths, so it lives in the noflush helper to avoid duplicating it.
