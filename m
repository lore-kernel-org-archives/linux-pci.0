Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44D427A10
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012251; cv=none; b=iXAWXMeiwQNhcfPcV2Sf+MwrpepjE4m/1tmlUuZuTCtm9+81KdM7aLw37EuyScGU9paPIFzVTBns7oR4hrJEk/SP8Q5c8BznDC19Y2QA5FWtW6aNqiFtGpPIRuUWt66WQ+zBV4FOZPQOtrpBdHMFqnmj6egBXgnwQ9Wx8lFtPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012251; c=relaxed/simple;
	bh=Hpb1ozd8QjPiCCy9gyCjbtEHPtCOmqM0onONYCaGfr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bCM5vhO0w7VfDC1uUT6cQEob4aNUX6rO2FZ6LN0AOYiqLvu76GMi5qxl94LmFuR8Imc1qKYWFtwazVsji6CFY6YoLa5Cni+kos2MsNIGk+c2FFlJz1RAGRpUI59puKSg7XyWpkDYqks9yhMNLWd3pbhZZpUJI30k1p8y23GTfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THdSvAj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THdSvAj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD6D1F000C4;
	Wed, 14 Oct 2026 21:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792012249;
	bh=YzOf4as3xcc/aJg449jLYSJvevuNpDDTzET/P5gVLqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=THdSvAj2ug728bKHtN8XjBGKhIVEFgsQwZejw9fKomGwgkJ+Co8zcl0N5HkgWeJb3
	 59useXHf5IBZgN3p+/J+Cq69M9ToMeDUuzHdpIRf/6fYu56YzWFvkjzwXp2IG10iGc
	 Qfzk2ol2AhCeO5LOiCPtLIFe2tMHz1mPlBwY32vkSi4p/CoVD8GpiWG4btScqI2Vud
	 a8qeRCjg5WbB35dTTxK6szaTXTINxAYsXRAmXFWdkb3UGDD4HvBDW6xR7qte8I3ViH
	 KtjWfvj7aPzzDdRBuRAnC+zjGWjHNUQQPsqy79qRw3k5j8fG/Jh6eMg6caFWhBmQTn
	 TnHdugnLkNHmg==
From: Thomas Gleixner <tglx@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, changfengnan@bytedance.com,
 linux-pci@vger.kernel.org, namjain@linux.microsoft.com, Keith Busch
 <kbusch@kernel.org>, Luigi Rizzo <lrizzo@google.com>
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
In-Reply-To: <20261014173106.GA1643226@bhelgaas>
References: <20261014173106.GA1643226@bhelgaas>
Date: Wed, 14 Oct 2026 23:10:45 +0200
Message-ID: <878q40f0oa.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 14 2026 at 12:31, Bjorn Helgaas wrote:
>> Skip the read-back that flushes the MSI-x mask write. Parent domains
>> that mask on behalf of PCI/MSI continue using their own irq_mask().
>> 
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>
> I assume Thomas will review/ack the pci/msi/ parts.

Yes. I actually suggested that "nowait" mechanism to Keith at LPC.

Though I hate the name of that callback because irq_mask() does not
really wait. It guarantees that the mask store has reached the device
which means that after that point no further interrupts will be sent by
the device (assuming sane hardware). That means it's a synchronous
operation which involves flushing the store, so maybe irq_mask_noflush()
or irq_mask_async() might be more accurate and descriptive.

> Cc'd Luigi since I know he's interested in interrupt moderation in
> general.

Correct. I'm curious whether the interrupt frequency based moderation
mechanism Luigi is proposing does solve the NVME issues as well or can
be combined with some device specific hint mechanism.

That said, Luigi's approach should benefit from the "nowait" mechanism
as well.

Luigi?

Thanks,

        tglx
