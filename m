Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC59331EC0
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181997; cv=none; b=nUeYPOWxkynDWoe6esyIZABUN6deYj1EyELigeFCJnvGfAZwDWv6bbuNjl3r0Qrugb5QFUHjhvTFKj87AbpQQ7CEZ5xGidm0eIMR6OYVgk07WXi7AES302awXTCC/9/ojOB1i0u+0imsWHnw0JDfC94FcAum07QynH5X6rU4fpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181997; c=relaxed/simple;
	bh=SeSjisccA/fi7SGLP9KKtwFg04ZMDNpPS+A8feGN2yQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5foNBcYrmWLteafd9m6maMbKLq1MAa9ddbER2mTARqlr6u88bp9iFhehATkAcPOTvvvZgaVzsofrdaHEApE8hNR14dpakm+b5y2pKr8b43xoJEnQ62731+RtAKQ8KrwHKX/+juOAZXoPA7ZDU95uKifb5ZorCeVmg+TjLmOX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibN+DJIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibN+DJIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CBD1F000E9;
	Mon, 31 Aug 2026 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181996;
	bh=SeSjisccA/fi7SGLP9KKtwFg04ZMDNpPS+A8feGN2yQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ibN+DJIZm/zu4RQTP2j55AVI8uZjvJsLR4FVqvzh2bbA5zaVNzh+Kfdzc7+1mX5kG
	 NDzOl3MV4Wq89+7OR+ulR4X/DOkpcj/qa5AZXoPqyn4ZBYhWNIfDJsHMoNdLqShucC
	 xljkuQB+PBcw2tMPz5qNl5Eb2jKwbkIgNr+iGHhx+pVGMcZCAkaxXuJjYVxRnMrUUH
	 jbtFiYn46S1K9Youh4B9VhH1KDBK55B/cSTeArTCV2N8J17/B1dGmsdCMWeafzj9GZ
	 gCJYi8qyBxZCUKs0lWgJaB2Yj07HPCaKXgr+uCZRNgJJ51raSytvZrCbstGPLFdDgZ
	 pX94g8yfO0Hjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless v2 2/3] wifi: iwlwifi: pcie: deselect the
 product reset mode at probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831130332.323549-3-navonjohnlukose@gmail.com>
References: <20260831130332.323549-1-navonjohnlukose@gmail.com>
 <20260831130332.323549-3-navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:13:15 +0000
Message-Id: <20260831131316.20CBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The mode that iwl_trans_pcie_set_product_reset() selects lives in the
> platform's ACPI namespace, not in the device, and nothing deselects it on
> the product-reset path. iwl_trans_pcie_removal_wk() selects it, evaluates
> _RST via _PRR and removes the device; the rescan re-probes, and probe only
> reads the mode back for the log rather than clearing it, so it is still
> selected. (A later removal with a lesser mode does pass enable=3Dfalse, b=
ut
> that is the path that does not need it.) It is plain namespace state - on
> the platform I have it is a named integer written by the vendor DSM and
> read back by the reset method - so it survives S3 and s2idle. Neither the
> driver nor _RST clears it.
>=20
> That has a consequence. _RST branches on the mode variable, does not
> clear it, and iwl_trans_pcie_reset() takes the caller's word for which
> reset to run. So after any product reset the next escalation can do the
> wrong thing: iwl_trans_determine_restart_mode() asks for
> [ ... ]
> cleared.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 9673c35486d4 ("wifi: iwlwifi: implement product reset for TOP erro=
rs")
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831130332.3235=
49-1-navonjohnlukose@gmail.com?part=3D2

