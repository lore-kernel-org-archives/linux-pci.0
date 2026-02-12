Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A213CA5A
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933044; cv=none; b=FOw3SWSyjotPgwheJ+GRpSayWyttIsHAXppovpsmAgIzGhh2uqPd0zQBNN1UC1aeSQB17haBDdZaQvSKN6Cf2pkbK0idLddlmg1tZ09Lt2uOJ6qqoMD8VKEAndDCpBvqyMl8UFNtDfV4YjxRO93ZdoyIY8pgp8Dkz1EXhzrYb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933044; c=relaxed/simple;
	bh=XTQOOHRPBEI6Ofe5I5By7hHpmDvsLrBCMwne+0fmilQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGiEJuyNdr1VseM6S38tLYC/HrHd7rTL8JqHNdgr5fcWUOJqa2qVu8QrcfqUUhnFfjiefNfXXZZ9kkebgsZZOvrIXSPL5+pUZmaUZUEpFJ4pLvejXr7zAbdLp+kxjDvUEM92y9MQp1phWxud8UINYq9n0iOlA2tq/hjgWU6jn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB/6zQIx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB/6zQIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C35C4CEF7;
	Thu, 12 Feb 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770933044;
	bh=XTQOOHRPBEI6Ofe5I5By7hHpmDvsLrBCMwne+0fmilQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qB/6zQIxKbO6F2wfd7Cjg5uab2KxgcHZ7C2sChDhWAInHbZQvdTb5vJQi3xxwzqFt
	 A6WsA+mMEoQwel/iUP8Bccl0MW0kbRRXtPzDA4OYhYwTHVOp9zdYpvEs1kuQHEz9g3
	 hd98MjFhT0j2anyqYFpdIq0Ab/bwyhFl8AwzDbKkmCzvP9C7N6f0wLF8Blt0F7vz1k
	 +ZR3Kis66UbEQnCa4QYfG+ylw4zrm5cJZceswB+XbdAg6fvpnehzfcMbe96seShhYd
	 56vH+sd5HiQ3QHD5J6nZohEVhKX9+aDC/iPfs/3OD9SqQgEqX5npih62g8tdMQwiEm
	 jeoRjSXzEdPKg==
Date: Thu, 12 Feb 2026 14:50:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Danielle Costantino <dcostantino@meta.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
Message-ID: <aY5LMJOzM3P8FYBD@kbusch-mbp>
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
 <aY5HzFYjhLmOQhs6@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY5HzFYjhLmOQhs6@wunner.de>

On Thu, Feb 12, 2026 at 10:36:12PM +0100, Lukas Wunner wrote:
> On Thu, Feb 12, 2026 at 11:18:17AM -0800, Danielle Costantino wrote:
> > Clear PCI_EXP_DPC_STATUS_INTERRUPT alongside PCI_EXP_DPC_STATUS_TRIGGER
> > in dpc_reset_link().  Both bits are RW1C in the DPC Status register per
> > PCIe r6.1, sec 7.9.14.5, so writing them together is safe.  The native
> > path is unaffected because dpc_irq() has already cleared the Interrupt
> > Status bit before dpc_reset_link() runs.
> 
> Hm, doesn't this create a risk that in the native case, an interrupt may
> be lost (i.e. cleared without acting on it) if it occurs between clearing
> the bit in dpc_irq() and clearing it in dpc_reset_link()?
> 
> Maybe I'm missing something and this isn't a problem, but in that case
> an explanation in the commit message would be good *why* it's not a
> problem.

The Trigger Status remains set, so the containment is latched for entire
processing. You can't get a 2nd containment event while the port is
already in containment. It's just important to clear the interrupt
status bit in the top-half mainly for level-triggered interrupts. I
think it would be harmless if the OS deferred the clearing to the
bottom-half when using edge triggered interrupts, though.
