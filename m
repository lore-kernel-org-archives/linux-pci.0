Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE754BE458
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271866; cv=none; b=MHVeFi9/jkx3gaNtP5qtaui1fXUPYxKwAY49Hgbntd+N36lEHrMqztD09IjLOVYWE3ZbjQPFNCeNKT0uP2+SoBWG9uLPp9xs8bDFGfR43f70QuZVT55kfAURQIhKaf5emysJ3OXLxwdB35hZu0US15DqyriiSH03pTHw90XlB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271866; c=relaxed/simple;
	bh=t5Vf0qXPGshIUDBAf8jmhvlqaV5lrWnjKOffhuOCU5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o+zFdmE1EnIkEQ4jLGCuDANVMezoAYsTepMIoVE0pG6lnPMZxZQrygO1+pgHbYb9aaVVJzK8dQHHGdtgwC60QLhP67KUsfu4bi+afDWVV7UsM6cn9/E+hk7KBIqLccMrJsfipGei7dhhnBVhpqegrPDcBEpvSETt1M+pWssNj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUgJ6XPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUgJ6XPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D3F1F000FF;
	Thu, 24 Sep 2026 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271864;
	bh=t5Vf0qXPGshIUDBAf8jmhvlqaV5lrWnjKOffhuOCU5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OUgJ6XPis1cbmGtWBq8KhiB4TiOAda3MhXmOGD5C4tPzlMgnYrWnTRQMcBfA+eiHd
	 5/rwmGrI313F5EAow9/s38aWPkdHNWtioJItqUVlItfvysPAI9FoGuiM3VCqU4wpGz
	 Pt9R86qOdjqq++3akR6L8uVy6dhUqQMVdihHyZknuvxWDjRfSb+0l/Nyl82Ux9oDLo
	 KlP53huS8IhclUq3ikK3b5x+1IvdBLCwamqhgSrYMCGlbBZAR2V5A/dAMj8WB9TN/3
	 lVApQJjKUVVL0rkoBkfbZ6X8FTBynvZh1ZMr2icDkQAL5HQKEzwjpV3D743DHTGdDv
	 Bz9JanMDYbpYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] PCI/DPC: Allocate the DPC save buffer during
 device setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-2-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:44:23 +0000
Message-Id: <20260924174424.04D3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Allocate the DPC capability's save buffer in pci_dpc_init() rather than
> in dpc_probe().
>=20
> dpc_probe() runs when the portdrv DPC service binds to a port, which is
> long after the device has been added, and does not happen at all if the
> service is not enabled. Until then pci_save_dpc_state() silently saves
> nothing, so a reset in that window loses the DPC Control register.
>=20
> Allocating during device setup makes buffer existence depend only on the
> capability being present, which is what the save and restore paths
> already assume. It also puts every capability save buffer in one phase
> of a device's life, which a later patch relies on.
>=20
> The size is a compile-time constant, so nothing about the allocation
> itself has to move with it.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D1

