Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293F277C88
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567820; cv=none; b=fvF0xaRs0jsG4laiBxSBPmIokb2fcsnKB8HCae/PMBvL7+6vP6uPReVgVTE78izgMctWjZgLKuLE4S4D6p/c6UcArEhlB4prXL1lpAT5R28RJmGl/3EsY8d8rWQgdDLMnCsqfRIT3vOIdObe5xPV+hoOfw6KQGHuRqV4/n8LIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567820; c=relaxed/simple;
	bh=TLOH6FoPMhoPNHTXSVX0qaZScq0bbP0nGuZmCIVGuYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jGB8Lch3S6THnmiVjnASAe4QY3j3SpUaWfAhpZO72AjuB07qitzOy8bCN1T/gIulZ8kptYD6mcWa+L+4K0sWu/XmSeWh7v8CPeliD3yhDqdvH+kRi7mSVmYaFBx9yubYCUvUfu0mxhXmpofUHfDuijD6JGjT24r0AxPwB01IWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU7lpMxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU7lpMxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35BA1F000FF;
	Mon, 28 Sep 2026 03:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790567819;
	bh=DkokIrgQ53/691FFBse1tcs/Df03l7GYeWCGHkLx8eE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OU7lpMxQFLguc5FROrECpzv9lMWTPYN7hq+nQdn5IHLWrKVDgiyroQgMLTMo51rGa
	 4ytIb14RuYdsNpUd0e0poOMSp12q+N9+Dre25HLcSzQBKlB939jg4QZy4eZJZgwls1
	 gZuU5wzl2Wml3rBC3/HRWRNk2JRI1a2LeBftOcL3Gc3AXbJOrb5n1kDUf/LbMwhxQz
	 R243JT8j5TyMHjmtbPPxjhU42Eq8Zw1pQV+RKUfrMS7WxCR6SwASKHVgI/6IP9244V
	 4GzV3AtsERt71M5K2jwLh+T3WM28X1XA89g+wlOnPFH/iAwkuUiIyBh3aXPmisRXSq
	 js9jCQAezgCDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/DOE: Fix double free of a duplicate feature's sysfs
 name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260928035035.252394-1-donggeunyoo.kernel@gmail.com>
References: <20260928035035.252394-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 03:56:58 +0000
Message-Id: <20260928035658.F35BA1F000FF@smtp.kernel.org>
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
> Leave the name to pci_doe_sysfs_feature_remove(), which already frees
> it for every entry.
>=20
> Fixes: 2311ab1820fe ("PCI/DOE: Expose DOE features via sysfs")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928035035.2523=
94-1-donggeunyoo.kernel@gmail.com?part=3D1

