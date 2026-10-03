Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C48412C05
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791023349; cv=none; b=Fg4dlno1w6N5EvIgpW3QBXCfXzuRFUXKiCIQrnokHlVmXuc9zYFybM6VSmCNwVfWH9czL60Bm4GPlL7CrUpz4JwcZ+URQGAjjyQtiTJ+BtuH78tXxSsE6ml5pMggHt+/RoiSEHlokAD8EvERap8uYByAvjmgSbUtYEUscL4I8wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791023349; c=relaxed/simple;
	bh=WiLmGxOLSepQk13UJQKxNn+VNBoiWk190X1bKwU9xik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ptKhYyRZZ81CIgsQg+xC1eKAGKQ1LSBy67+dkhvA06OktDL+RKylpHFFvHuFBmd8cY78ByhqR062P0yutaS/5fFJSyLdDbSocnPqtPWo2i6LNI1MT4HrGQcvV1D3MdsIf6NYQ2Zx7LjFc6ind2/t2eIszqFEc4CUYsjsG8lryV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbccoHA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbccoHA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFD51F0089B;
	Sat,  3 Oct 2026 10:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791023347;
	bh=BdrQkd9BRcPZy00Atre27aWNwchQoVIQGkp6IbVDJ58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbccoHA/bEPr3LYvDAmA/VKMYRqx61zDUNRY/yS6oht6djbebcD1KbKOhqUer8XNk
	 IKyh1tTRStHBHKSNxGhAGcu8bhv3zikq38WkMxWsjX/b5IY+4k3TtOgyPlYdueUh97
	 JcMYpNNj6M5lMqQ+8sCZExJYaJbgph27PGcdEAFFMR0UhdCxgQBWFG/AgkfxCWvQiA
	 8XBIPGeVR3Dd8SnXQ2rP0sp74kPTf4Nb2/uabEvpJhGjFzzWWYFjfiQ0eFus4wRKnb
	 l7ZZTHtLSW8RUsoXL0NL/WeeRaCCynKdk/pZwv/fRTKw+zKdKuJ3ra+BN+nRFzpM40
	 6PXkiNkKzwhQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/DOE: Fix double free of a duplicate feature's
 sysfs name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>
References: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 10:29:06 +0000
Message-Id: <20261003102907.7CFD51F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a DOE feature is reported twice, sysfs_add_file_to_group() fails
> with -EEXIST for the second copy and pci_doe_sysfs_feature_populate()
> frees that attribute's name, but leaves the pointer in place.
> pci_doe_sysfs_feature_remove() frees every name again when the device
> is removed, or when a later feature fails to register, so the name is
> freed twice:
>=20
>   BUG: KASAN: double-free in pci_doe_sysfs_feature_remove+0x117/0x1b0
>   Call Trace:
>    kfree+0x11a/0x420
>    pci_doe_sysfs_feature_remove+0x117/0x1b0
>    pci_doe_sysfs_teardown+0x90/0xf0
>    pci_remove_bus_device+0x128/0x2e0
>    pci_stop_and_remove_bus_device_locked+0x1d/0x30
>    remove_store+0xd2/0xf0
>=20
> Clear the pointer after freeing the name.
>=20
> Fixes: 2311ab1820fe ("PCI/DOE: Expose DOE features via sysfs")
> Cc: stable@vger.kernel.org
> Suggested-by: Alistair Francis <alistair@alistair23.me>
> Assisted-by: LLM
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003102221.5989=
4-1-donggeunyoo.kernel@gmail.com?part=3D1

