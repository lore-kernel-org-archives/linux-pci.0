Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D819475351
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013962; cv=none; b=Bc96r0uDwGy/wQNlbjTgW267dxA3vQs2wD1Mbt4uz8BAR3ShAA5mTcjRFHmz1lRGPyZdK/WTSZ3LVICjU1KvBGCphf3g0kkKtc6vcWtB/rxzcB7Atzg1Fkrph8g8fezZw7KNxadlk+d6XfR4gWonh6oWIICzxyJHwQ1TsWmskQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013962; c=relaxed/simple;
	bh=YZ3USTerO1KVZxlzLH4WWR1OpRpRgNIFQgLPolE8aXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekcIsG0JzlCr6iVHbt7fTuC+GKLOCFgnerImCBq8eoncQH6kRlwX/u3hL8+ja7NVBFfVB0w/B9nXNAnOuoO0A7LttuSHkE5E8DyBzE/l7jMV48dHW0PbXiOt/BnxXyXdYwPe/KeRPNJTiFVy8c45wcQFMJvG09nVdA+Y2+1Qo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRCHauSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRCHauSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD451F000C4;
	Wed, 14 Oct 2026 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792013960;
	bh=yfZ/FsY5Zh5zIE98xQp6NV9qIckj8O0+XPOxXg+eC7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HRCHauSgwJ/+0LsfAw1SACphQ9Kn9zODj961nCBEGV3/bMZDtKsi2rGRhU7tDMSC4
	 zXjZTwx6P3bv7dM2sLbW2w2Eu4X7AWVVRSN70mffrQhpCfaBRUhmzmrBnnq1UT3Ad+
	 sdFqv9lK/4YPubDzF1ZBrTc4iBwKBQVkEhtitkdWCDGeWsoygSExU1/8B8ATIw7fi2
	 OcjPxIKmVDBMwpeteOneHvhiUVdJcfLqy/A0HC+I0GH7C01JiQvD52c9C2IldfJ8DF
	 0gK1udx+3M2MAvlbMnvEQqvlFvz68IgsgdXakWqQqMasBApPcyiFKfRnEYjFQvAYVT
	 g1auJ3Fe/9Uow==
Date: Wed, 14 Oct 2026 15:39:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de,
	changfengnan@bytedance.com, linux-pci@vger.kernel.org,
	namjain@linux.microsoft.com, Luigi Rizzo <lrizzo@google.com>
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
Message-ID: <as_2hlWSsMciwCT1@kbusch-mbp>
References: <20261014173106.GA1643226@bhelgaas>
 <878q40f0oa.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q40f0oa.ffs@fw13>

On Wed, Oct 14, 2026 at 11:10:45PM +0200, Thomas Gleixner wrote:
> On Wed, Oct 14 2026 at 12:31, Bjorn Helgaas wrote:
> >> Skip the read-back that flushes the MSI-x mask write. Parent domains
> >> that mask on behalf of PCI/MSI continue using their own irq_mask().
> >> 
> >> Signed-off-by: Keith Busch <kbusch@kernel.org>
> >
> > I assume Thomas will review/ack the pci/msi/ parts.
> 
> Yes. I actually suggested that "nowait" mechanism to Keith at LPC.
> 
> Though I hate the name of that callback because irq_mask() does not
> really wait. It guarantees that the mask store has reached the device
> which means that after that point no further interrupts will be sent by
> the device (assuming sane hardware). That means it's a synchronous
> operation which involves flushing the store, so maybe irq_mask_noflush()
> or irq_mask_async() might be more accurate and descriptive.

Right thank you, I misremembered your suggested name. I am totally fine
with "noflush", and I've made that change in my local branch. I'll just
wait a bit for any other feedback before the next version.

> > Cc'd Luigi since I know he's interested in interrupt moderation in
> > general.
> 
> Correct. I'm curious whether the interrupt frequency based moderation
> mechanism Luigi is proposing does solve the NVME issues as well or can
> be combined with some device specific hint mechanism.
> 
> That said, Luigi's approach should benefit from the "nowait" mechanism
> as well.
> 
> Luigi?
> 
> Thanks,
> 
>         tglx
