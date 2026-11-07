Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088431;
	b=su75sv2s/r6vFcT4pbwF2eB7gQhm1ptJ+1F/kcBuCWIjaqqm4TwOhQxmYSxE/9/BdQRo
	 XfjIQluh79b9K6L6JCSSxpk8hK3JRQ3dEng3jN0PDkqDTYbTlrdpxeh8kcjawOgNU4dvB
	 fteU1owv67UOi2F49nWqEzE10AkpVaczzDEI6rM6GuRR4hwdSDSv6fbVSIrkNCYWWcZFj
	 3/mn4KCrCyJqwlD4Ej9NPeQMbQ/YiJG0Lg/EpylkeDFDK5XAvqn2ypEQBM/QoWOQVdlO/
	 V6CoD2s0OfGYXOsarzVLtYX94CZfVVOUzXJVBnh62+2EiR/WxeQD5aY0iMUyg0VBnPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=EWlYFnlFkKqc+rHHPIN+VOy/+q1zUN/a2wsNKFALdxk=;
	b=WzUiHyafCClbrnVgaJgNQ8i+hVav0tRLri08wxG9DDrkzTERJ3uR+rAaRCE1N547Dm63
	 PR9JmErboDLhnNVv1twhz4m+jFN07eLdTxEwwtW7DWNEsO8Zp8aGHANNr8w5UlsfSds7E
	 MxId7q5RZciqRiZ47+kafxWvRkMCKTo0X7hyzUwFU7OFkUKfuW2NBxtAE9y0M+qMbFdGX
	 PBqbR3UP90U1NBcCLsq5qDKS6c1Otit5htsulqQGtiimvuUibmFBNuHhj/Uu20FKaWuqt
	 x7zwOaaRzuKJvu0J6hp3rKAGm5i1YTHnD3lw0+TON9PsHuU63WPzu0FE1HGdBtCrAUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSw5Xwu5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34870606A326;
	Sat,  7 Nov 2026 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSw5Xwu5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044241F0089F;
	Sat,  7 Nov 2026 21:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088430;
	bh=EWlYFnlFkKqc+rHHPIN+VOy/+q1zUN/a2wsNKFALdxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hSw5Xwu59lAOUUswo1gzzESTvlg/XUg4O/ufTVW63SK9b0/IbYVkoohTPCOM8Y4sD
	 rmINjpCIFox5xazFAzn0qv3Nsk33ab3ItOc8mOSt90HM188VDGtBq9oEuKT5iglTKY
	 o9p3KE+cC1o48cnW9LcQ1007YCOHr2CAWJlRB3J2i3qvP2YkDVyFYKbJKGG3i39e+P
	 pwD31J9NW/pA/jOZhlGSZBegOeFHXJeJ88qXfzZc7bEfnJndayxMmXD/YiDIv9PTbT
	 JjnlcJ0mcH0E+O1asgjhPgzso+AE7BvLjadhaoAoncKenDEinIfsCp91WRkhYarIOw
	 7aZsF/87/nt6w==
From: Thomas Gleixner <tglx@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, maz@kernel.org,
 lrizzo@google.com, hch@lst.de, changfengnan@bytedance.com,
 namjain@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
In-Reply-To: <au-DcqwAz2wmmOne@kbusch-mbp>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com> <87wlqpwukt.ffs@fw13>
 <au-DcqwAz2wmmOne@kbusch-mbp>
Date: Sat, 07 Nov 2026 22:53:47 +0100
Message-ID: <87o6c0wbo4.ffs@fw13>
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

On Sat, Nov 07 2026 at 13:00, Keith Busch wrote:
> On Fri, Nov 06, 2026 at 09:53:06PM +0100, Thomas Gleixner wrote:
>> On Fri, Nov 06 2026 at 09:34, Keith Busch wrote:
>> > -static inline void pci_msix_mask(struct msi_desc *desc)
>> > +/* Posted write only: the device may still send an interrupt after return */
>> > +static inline void pci_msix_mask_noflush(struct msi_desc *desc)
>> >  {
>> >  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
>> > +	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
>> > +}
>> > +
>> > +static inline void pci_msix_mask(struct msi_desc *desc)
>> > +{
>> > +	pci_msix_mask_noflush(desc);
>> 
>> That's before the offline check now, which looks more than wrong.
>
> This is done on purpose: pci_msix_write_vector_ctrl() already has the
> same offline check, so nothing actually gets written, same as before.
>
> And regardless of whether it's offline or not, we have to set the
> PCI_MSIX_ENTRY_CTRL_MASKBIT in the cached msxi_ctrl. That's common to
> both paths, so it lives in the noflush helper to avoid duplicating it.

Indeed, but that's an unreadable mess TBH.

Can we please change that to have two functions here?

    pci_msix_write_vector_ctrl()
plus    
    pci_msix_write_vector_ctrl_and_flush()

and fixup the related call sites?

Thanks,

        tglx
