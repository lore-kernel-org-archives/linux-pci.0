Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354101;
	b=Yw1WM8Y5R8nuXN68AWGGHpk8+SSVVaXSi0k4GwTXhGSKb93Xg1HE0IMXinuSARS0s4sl
	 K23r3hWb5mWL+y3mXebuAS0uMNAZcqneweh4itAYu2reS3l97h/+aV9aMgrLjs29tAawh
	 N0AjZ1vuXlJldA9Bin2IMD9yIofG8C7abTBIJJHfHuGaPX5P+4eOc1zPc+LyYWMmj0Kzg
	 4JKfwRn1rwxwRAVSmO/rIgKYsN09QFzcIeMCxByqKGt0uF+qaS7l/XYi4iuQVKfWM3QNf
	 Z0U5LZKl8UofUYUjPylBVDGCJS4Lxd6OF5oVUP4NBrQtZlG/90y3zW7jYiB5/6QQIYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=m/I3u2DIcuWXKQ1Qo8rwF6DEUqXpIQH/9/2v0i4WFaw=;
	b=nKHPgQxeHl/P0lDw381yAFDzqTLgVBFSnJmH98HXxVEZ99eBr3CU5y9afWH2ZIe4Xpgb
	 jwuHAF9EGW4bGCRJa9tyFevOxtyemnU5CqY6FBQbryEOiiKcMBcotJf37BuAEnBGzwp6S
	 P0G1BpePyhI8uxK3kgq+FrweHtgtzSjg6qR1woiw3jDzzWmCe9tXxaCbSHr4/Qo+FF2nS
	 BvBelzuHFv9qqiSxnhPWaafXgDwWG1Kj2hy7mB1DMvBzmnmy/kl0RSIoup2L3zPvC5Jmq
	 USeMmQ31+gO3CDIw/T9pOwVF0WVPAj7Rfq5Ufjn/mLgOjXKP6hclSfmJ/9kKLLUfaAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G31UKzFt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F7606A320;
	Tue, 10 Nov 2026 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G31UKzFt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6165C1F0093C;
	Tue, 10 Nov 2026 23:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354101;
	bh=m/I3u2DIcuWXKQ1Qo8rwF6DEUqXpIQH/9/2v0i4WFaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G31UKzFtI/faUuneUGXzHgUw1C7od2JUH+tqw/0q4HOplmgemS2fyuwH3RUv5WgpR
	 59tPNWKH7j7zrD2mpHu+Hlp1k/r5q0/+7eamwyoC3QKUAmrAJEckQ8tFT91Zhst9R6
	 96LGFfzbWOfZ+2ZQEEXkKEjWmZUYDEL+TS2p02nm+6tLK892S6LKCJnU9QFsGxnhSr
	 n6B6oJ+B6BTWuBppDyEhUvyGTKU7mBj3uhg9YGaDP05t3aYflVQ8WZcVhJdZHBcS/i
	 smF5X6ZNBcrN676lC9VznuJ8XKqnnujfiRr9lIqzQIqd+a4rl88fPg6Qp8BYhFEnjX
	 QKg7vNSKwCVYA==
From: Thomas Gleixner <tglx@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, maz@kernel.org,
 lrizzo@google.com, hch@lst.de, changfengnan@bytedance.com,
 namjain@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, Vidya Sagar
 <vidyas@nvidia.com>
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
In-Reply-To: <avHxSog2_rsJKGUy@kbusch-mbp>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com> <87wlqpwukt.ffs@fw13>
 <au-DcqwAz2wmmOne@kbusch-mbp> <87o6c0wbo4.ffs@fw13>
 <avHxSog2_rsJKGUy@kbusch-mbp>
Date: Wed, 11 Nov 2026 00:41:37 +0100
Message-ID: <87o6bwtfta.ffs@fw13>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 09 2026 at 09:14, Keith Busch wrote:

> On Sat, Nov 07, 2026 at 10:53:47PM +0100, Thomas Gleixner wrote:
>> On Sat, Nov 07 2026 at 13:00, Keith Busch wrote:
>> > This is done on purpose: pci_msix_write_vector_ctrl() already has the
>> > same offline check, so nothing actually gets written, same as before.
>> >
>> > And regardless of whether it's offline or not, we have to set the
>> > PCI_MSIX_ENTRY_CTRL_MASKBIT in the cached msxi_ctrl. That's common to
>> > both paths, so it lives in the noflush helper to avoid duplicating it.
>> 
>> Indeed, but that's an unreadable mess TBH.
>
> No disagreement there! I was just going for a minimal diff, but we can
> refactor a bit on the way. I'll take a stab at it.

Yes, please. The minimal diff approch is what creates the most problems
down the road.

> I also don't really get the rationale for putting the check in
> write_vector. The commit message says the checks are to avoid having to
> deal with errors, but posted writes don't produce errors, so not sure
> what it's actually guarding against.

To me the explaination made sense and there were no objections within
month from any of the people involved. I'm not a DPC (or whatever is
involved) expert. I just work here.

I've Cc'ed the author of the patch for you as that might be a better way
to answer your question, no?

Thanks,

        tglx

