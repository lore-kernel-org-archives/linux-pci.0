Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BA3783AF;
	Tue,  1 Sep 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256398; cv=none; b=lsKdv2YHqMwezkxvsWZ61mptUI85xHesO0EZJX77ojkHtIobphoFZekMtadVjB1CRGVqwzCXBl6Ujh8mfcjxoG5H6eiec7SmCCdxt3tVHXQ/GxCWcLNR67GldhB+O1itUWGwCdoyNFLB6QHQNFufqorkymDxF9XMTG8dhh6/iSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256398; c=relaxed/simple;
	bh=c9XMcH59apMWuMmIpOSlBxOfhHXdytxRrrYl7kqNLtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jR5/yPgVBB9TBwVMW6oMCs7RanxZWTA+f79vTQJTlGHSAf6mxkkj3/yCykl48FqIuLQtDEjhR92VFx/DGDMRXXk26Cp6A3uqMLb1ZkBUoSsMTPv8KLdv82mIRKInpj+5vI1RmLvubZqFCbMHJungdpb7YKHwo5bt5lVXgFb/83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIR5KYgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIR5KYgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2441F000E9;
	Tue,  1 Sep 2026 09:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256397;
	bh=c9XMcH59apMWuMmIpOSlBxOfhHXdytxRrrYl7kqNLtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IIR5KYgXNoh3e/Ys/0XPFqxojZJZwkKLpA4afht/BZOIKeOI2OaZcCqPz+hjWYBUJ
	 UsWDO3jTEFbcSzw2rszEwuSKoR0ScLeOmJUWiuLToZvYsBbfgWuKwmRAg1b7r8D2eH
	 gDL5OXsZackBbMgqh3F5gkJf6PWEgg6gk6wtN48I4dhO2uY3UG23AQeRSLilFmL7wl
	 WHVy65AHoL586aiqQizs+RhzGG70LVGLLSSgwXFwUZkfmqNg2ApZ+nw5I5SBRQ919/
	 mvdeGy+OCQdEeMaw239B4P4Fc6MtsK0Bvlk/St/pO6jz0mEO9azuKqnaUsb48PjlLB
	 QtUVi2Q4nRrSA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 16/19] vfio/pci: Quiesce INTx during PCI recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-17-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-17-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:53:16 +0000
Message-Id: <20260901095316.DA2441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Mask INTx when recovery blocks device access. A PCI 2.3 device shares its
> line, so leaving a level interrupt asserted and returning IRQ_NONE would
> storm until note_interrupt() disables the line for every device on it.
> Mask through pci_check_and_mask_intx() and return IRQ_HANDLED instead. A
> device without per-function masking has the line to itself and is quiesced
> through genirq.
>=20
> That is a different job from the masking recovery does for itself, so
> vfio_pci_intx_mask_for_recovery() gains a @quiesce argument to tell them
> apart. The handler knows an interrupt has fired but not whether this
> device is the one asserting the shared line, which is what
> pci_check_and_mask_intx() reports, and a false return means the interrupt
> belongs to another device. It is also the user who unmasks afterwards,
> having been sent the eventfd, so the handler does not record the mask as
> one recovery owes.
> [ ... ]
> for an interrupt which cannot arrive, since it only unmasks again after
> receiving one.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D16

