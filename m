Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809673;
	b=PWZEExbhxG3/cuoeU8VMWo304aGS/J8lvxhuYpjOB41iPOK3NMRFLxNpstQVG+hTnQ2B
	 v0zooe62QSo+McFox2XA6B004xzGlYC+nCVfDvL4UZ7n/t+IgQqhXBZRo2SwG5lmMsaqs
	 iG9ZV58EAxRDV3zVFgGE/RPkoGEYjUeWjwUmD3TjvfpctnqiSrDWm5MFnqxpoxVkSOhbk
	 zpl+4jZ6iCIELlDdWgQTdBrJbnCg3M6Z9Lsltes7mqpP33kRMMamJ9YCB7w8wWowEgaot
	 Hdf2AS0Bk9PlEQ+u75jHDC1npjzcVzmSAW6HQRpZdW0rqGOFR51HVBpKBA47MI6fVHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UY6poEH0of/MXySZPTBhh4O939+A/VZJUemckZmGsLI=;
	b=hoh78zwDNuGamW8wJ2nSNHYzPW6h+s2jSAJ1ET0h90hPvbFu7TkKf7UOYB8KXXtOEb2i
	 CEODXwFh6Pg9EC88jrl35fIo+tLLIdF2G+EPgstlDMUJE5CZRsv9vvxMwSnt1d2FxMRxT
	 2Jmfw+pecqWGddTp9Zs5+0oV+M3QTK9HTlP01IAUwc0BA/VeX/8z2ajRjrMFfplJINJue
	 pJvVEP8taOOj3urM6KTlHCcIqdW6MxEcxFC+0/JtSQDAe0DMF7xWXm3pVZbChm9cOPEX4
	 G39iaLuYFLOk/jljghRGwX+qt/HsLJE8xa+YPa9UvT9Qn8iKoxR2H5Aq2D9GxK/Jteg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/pwodN2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2744606A32C
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/pwodN2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546F91F000C1;
	Wed,  4 Nov 2026 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809672;
	bh=UY6poEH0of/MXySZPTBhh4O939+A/VZJUemckZmGsLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/pwodN2RxIVqnAAhfu+/MdznlpVvXc7ZpeYo2s1I3y+HiZTEJGGwn8eE5WCnPijN
	 N+SkjPP43SIWzDdjKk5H8KHyvSAJ27SrOzu8vyb3n7KBj17rr/U8TGXCb3liqmu+nC
	 T8EOm+0j79JUoBBzJc7Eb3Git6z7gsK7AR0RM+AuWtFH2NnTIEqc2ZL65jtuu36YxK
	 tjY8di8J69IgEDUOFirasn/w2xwUg4XnchrnFpABYCJ6uxlGHx3wBoNVF50z2cehVO
	 8RdY2QzVP5r1GJggheQD3ISH6pvKtuvFx2w2cTjrZ0EAoDNI9/Qp38P91eBuhFJfTT
	 2YANwELPisQDw==
Message-ID: <sashiko-outbox-197606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/15] virt: coco: tsm: Remove the device from lookup
 before PCI teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-3-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:27:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI connect looks up a TSM by ID under pci_tsm_rwsem. Previously,
> tsm_unregister() released that lock after tearing down PCI state while
> the TSM was still in the class lookup. A racing connect could then
> attach a new PCI context that the teardown would never see.
>=20
> Remove the device from the class lookup first, then take the PCI write
> lock to drain in-flight operations and destroy their contexts. Drop the
> device reference only after PCI teardown completes.
>=20
> Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encrypt=
ion")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D2

