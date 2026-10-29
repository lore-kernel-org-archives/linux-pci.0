Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304238;
	b=h7D5n0UB0NvTW1HFjLE0oAyJSBfa3+p91DKNB+AY6kGxERd7FIoPu2MklTWOoMXOssos
	 aqa5phOoWjSSm8uEarX/pfJ9fWBjJuX8FetiyNOxRP3vOaaKd1Tcl5+nw/hUex17ZkepH
	 K66FjdWaaX0CTWuyRzXbUri0P4TNvfSgeNWP44voxAptZ4ux74b5bhb+z7KftDTq92Xxl
	 eCP6yvOwZVyhEQF/U4hsZM8NhoVk1XHnkSP+x9DA6RGTbW1EwKjRw8qEdi9Q5CC8FMcw5
	 xxYg9Z2MHE3ykniEt5pPoPEvTV3leqV7j7lEuN4OlIepHai2y0gfG2ZbpR0rsrdgpxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304238;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=svQ//MkleCja8o2UtEuQypXT3U7OJpy1dAm+XY+RS90=;
	b=fuhwb4T5uyipZyj5i/c1w6zWnO9SZ8kKwYps4JeeKbCIySUyJOkmvYrP1mWbSb1JdKEv
	 aGz8dLvFtKqM6NdlYyHJjbftseXkaFljD8EwW7rj9ivT1bl5Yuf97fBKR9P5qroi+qvdT
	 MCJ88LHJ/RsUEVCk2tnbPe5PKN7gJChedu2Ni/touMQOhGYLUGbPs6pMQ9O15gFakijlp
	 CqEJnctxn1Ci3aySy/0MKuzD2bN2ebufFYy2sr/uaQPZEvhzRA9LC0sZSFmLj1B0yRAnH
	 CmuSRgERmiH5ZuPxYNGOps99xfJFjnxNUe57qMohDMrH9MDOiH5RIZqs0RaJyX/CaUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YX/bHxIk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74E606A31C;
	Thu, 29 Oct 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YX/bHxIk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C3D1F01816;
	Thu, 29 Oct 2026 20:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304237;
	bh=svQ//MkleCja8o2UtEuQypXT3U7OJpy1dAm+XY+RS90=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YX/bHxIk3fByQtVUfBMqS0ZZM7hdGgNArakJcinXP0ITTx80zX3rHU8tb04J05E6X
	 bL0m7B/Nii+D+xUxrA9KIBUwE56R66MrAVwhQ6VNRxEPgfF2XgTnwR+i2j1QFucISg
	 r0DOEb9tXckqXqQemfbCkpGD2F2XWrpBWghp19fExt6PZDAR/9t8vtTZxnRLGWjCrw
	 GE/fF/TTnE7Gu70Wk9Qggz9YR484xo/0yo5rAKMAqqOVAcE6cNGpRADg9GB7xEtU6z
	 Y5kZ48hIDCX/iR5okF9qW8WwBGuZj7lOq/YHmXCLWfuXjI8WE/rwPyBr54N+jlqNkq
	 nhEUCmPkLwRtw==
Date: Thu, 29 Oct 2026 15:03:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: wuqianhai@loongson.cn, Huacai Chen <chenhuacai@loongson.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>
Cc: tzimmermann@suse.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chao Li <lichao@loongson.cn>,
	Dongyan Qian <qiandongyan@loongson.cn>
Subject: Re: [PATCH] PCI/VGA: Fix boot device detection after framebuffer
 relocation
Message-ID: <20261029200356.GA655242@bhelgaas>
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
In-Reply-To: <20261029033914.978276-1-wuqianhai@loongson.cn>

[+ Loongson folks]

On Thu, Oct 29, 2026 at 11:39:14AM +0800, wuqianhai@loongson.cn wrote:
> Hi Bjorn,
> 
> Thanks for the detailed analysis.
> 
> You're right that screen_info_fixup_lfb()/screen_info_apply_fixups()
> stores a PCI bus address in screen_info_lfb_res_start and compares it
> with the CPU address in pdev->resource[].start, which is broken on
> systems where bus and CPU addresses differ.
> 
> On LoongArch, though, bus and CPU addresses are identical: with modern
> firmware, acpi_prepare_root_resources() takes the PCIH path and leaves
> the window offset at 0 (see commit 49f33840dcc9).  

This is a tangent from the framebuffer question, but what in the world
is 49f33840dcc9 ("LoongArch: Use per-root-bridge PCIH flag to skip mem
resource fixup") doing?  I see that if "PCIH" is non-zero, it skips
some mem resource "fixup" that was added by 57fc7323a8e7 ("LoongArch:
Add PCI controller support").

But I don't understand why that fixup is there in the first place.
Evidently it takes the upper 24 bits of the MCFG address and ORs it
into window addresses from host bridge _CRS?  That sounds nuts.  It
sounds like the ACPI _CRS is just broken.

The struct resource_entry.offset is the offset between PCI bus
addresses and CPU addresses, so entry->offset being non-zero implies
they are NOT identical, at least on non-PCIH platforms.  And if you
have to hack up the offset from the MCFG address, it sounds like the
_CRS entries are missing the _TRA that is supposed to provide the
offset.
