Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05F374E5A
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528353; cv=none; b=vFyzM7TJtf8eSMnBBpB4uRCL6nfxm5PYZv4RcgQeUjsa9PToF3xPkJtMETKC+B7V/d2oT07uDxK/Xm9kLdugBNfQzTUktQMVH5MSnwTrWLWBtWFObuBSoPHz5HzSIVYLy42t7tmHLVXZPi2IXC9T6geyr1WM5UEIkMq5eCxh/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528353; c=relaxed/simple;
	bh=WOMMSVqaXkHLG1NehqcpiBPQRKPpQEE5bRHkw0ZnPjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nqCw/Z6diEocnGNvR4r5dLqNI98ZPHuzssnmublsya+MQ5hf50/1vnfQDOJ9F3FFaWRahtShr6mSZnr6LS5wUz5dwhsLbvGK0L5BUkcglvuhjv/raCFGex+kVhzh8vDvGKH6nQl26Ws9yPOni+f4r7fJpAzaIefykMpOraVTo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loV9nIbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loV9nIbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CBD1F000FF;
	Sun, 27 Sep 2026 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790528352;
	bh=BAruOOGs0fwOMYJA/GafmPz2Y05vNQwrsrKixAXsoxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loV9nIbxHfeaWsecb6tfGCOaseAomIJXhL1GcFOusO/I10R6ocSLHapQ8TttlPf1R
	 MP8r22wbS60CmBR1sniOEV52qTXvnDQpNDFf5onvdGasvzo0BWOyCSTj9ITn52+WC1
	 2AGu/lufdAxoxpc4k436X9msoPeZiyWIgwDMqGcP/kf8pFiURSaQ0Fq7iJwG4A1M9c
	 g+BshuTH3fRkc9lIRecvuufdzVQqde/Ka4bgr0TAiMPbY/7OupX1QqVgaOSJ1F6CFv
	 U824Pk3pbqXx5/E14+9P8Yxu+nDGxQBZr0cO9fwkVIgdEkHm0DdWq4qAFm6CsFi6I4
	 ZiShFc/SvtBvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927165459.829900-4-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
 <20260927165459.829900-4-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 16:59:11 +0000
Message-Id: <20260927165912.23CBD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_dpc_recovered() awaits completion of DPC recovery and then tells
> whether DPC recovered successfully, using test_and_clear_bit() on
> PCI_DPC_RECOVERED. The answer is one-shot: only the first caller sees
> true.
>=20
> Split pci_dpc_recovered() into:
>=20
>  - pci_dpc_hp_sync_supported(), the check whether hotplug can
>    synchronize with DPC at all.
>  - dpc_wait_completed(), the wait for recovery with its 4 second
>    timeout;
>  - the final test_and_clear_bit().
>=20
> Add pci_dpc_wait_recovery(), which does the check and the wait but
> leaves PCI_DPC_RECOVERED alone. No functional change intended.
>=20
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927165459.8299=
00-1-abhinjoses@gmail.com?part=3D3

