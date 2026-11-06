Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964347;
	b=5c1vJuYwlz1jbyVrmFPFgwUMl3xVLGRA9H6AbsViGJwzX7XzYpfYZ9aqGeEeay0vRGSB
	 k7UHhwohdyr4iW2Z4WMSHRBvIaa7ZnWmp28KFOylT7ugG2FT3poFNVDnORkgz3rB2Hd7T
	 riaE2DKvH3HPwZC0+14n7TnvWVVbMS4vdy2m2wEzvWMv7lbyJN4s2SxNmgPAjeX295YyI
	 4DKaWVwUPJjKwqY7Vqb9cuEKVcw6O8Tbuk0UcXf4LSC0DTt01lpl5igo62qLpy/IRPzIn
	 8h0jxqtphH6xJZxoP6SRLbq2I1lyx2Ry9Lky+eXByrTf1nJD3IMvPtDEaNjVvQB63xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6I3oWd7Vs9tGjUSu+DjFoza7Vwb9qXfBxOGGa6hllIU=;
	b=KSRFjHoXHW6Gl/ON/6Frja2Y7oImhVuZDU4Q/gJedojMoYlKh1g7FKC4aueTvHcMpBFf
	 4Uj7pShGj+yrQ1wgSu++VF+hEIiBbiSfHRkIB2BFZ0WjVxUq190EBOYXZKTuXhFxCeLbD
	 B8wQM/ISUAgvJfcDp6B4opPR5mci3VJ/u5tC33eOPUv5NvUlnf+ybecKk5VBV9buKWzTp
	 776affGgxiAvzHqyaYEgPFmU3aBxZGOqBtglbQ1FNVIPRs9JULb0UG2HVXOHrqEvGv9Bg
	 nFIP2bm9eMpBjg/wyyqVYCfqS74XljAvWBHNrK7/HxRAeq2uGGtZpTwl+AEx63t1FJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kifx7AzB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F3606A330
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kifx7AzB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C771F008A1;
	Fri,  6 Nov 2026 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964347;
	bh=6I3oWd7Vs9tGjUSu+DjFoza7Vwb9qXfBxOGGa6hllIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kifx7AzBLjMPilOVC/kdMQGmsKHRtp13BMoHzdHMoz+0Bt+bgbJ5r2BZ1s96M/hQX
	 JBVLD/rksLvhhLjt+aM20UPFkwxlMS6BUxEdO6us6r4/k9KnE5UmaxLt6IThuuU4vj
	 cjridi8NHYhINubWlgfQo+idnXPlhzNoEktpIcE1ejhx/DTvMmdHFXUeQd8ljoq8UO
	 5XVVbMAbtqVELCJZN7X4bZOf9zevZPywlt9wlkqzFlF6GVLLElzK+hHzsyEWzuACej
	 i8+cIbMD5J1YqUaNqSDDsWbeg1Of/fThWrSlYoVP8KKKEiZIW+ocat7iqjO4HbUjol
	 PuVWp2vIb4S4Q==
Message-ID: <sashiko-outbox-201310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/MSI: Skip MSI-X restoration when
 configuration is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106111829.55823-2-icheng@nvidia.com>
References: <20261106111829.55823-1-icheng@nvidia.com>
 <20261106111829.55823-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:25:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI state restoration runs even when a reset fails. If the device's
> configuration space remains inaccessible, MSI-X restoration can issue
> table MMIO accesses that trigger additional errors, including DPC
> containment.
>=20
> Check the existing PCI Command register read and skip MSI-X restoration
> if it fails or returns all ones. Preserve the existing handling of a
> valid Command register with Memory Space Enable clear, which temporarily
> enables memory decoding while restoring the MSI-X table.
>=20
> Limit the change to MSI-X restoration. Leave other PCI state
> restoration, driver reset callbacks, and reset return values unchanged.
>=20
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106111829.5582=
3-1-icheng@nvidia.com?part=3D1

