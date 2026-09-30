Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179351AFEF
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785066; cv=none; b=al4qpNmbSCm+GY8hC4FMjhNgbgtNkN9ZbPxwW4Qw/LM5f3vXhAdMZ6VaMo4m5A3LZE947kraovV+KrYqZhxCQwbEHPPiv1Pgi04NnPSBqlkA0419aq/KmbKh8ZhBVa7uqk1kapeg6mCI9qttmVj3R5sJHw+rsrOnZEPqhoOamVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785066; c=relaxed/simple;
	bh=svuAfgJakUMSo+W6wcHr0x3XkdoSATz2gMyo6m+IrD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XnEx0WEknLRK08PxLPzem5i3lSIRXUDue8LMj+meMkdeAyPcRvRJnbeQQpWQMHzy2aq/jHGb7l0ey2Ta+o2PSQNdiVf/NbgYyTfupWW2EVZHgFXGLTU8/M/vCVyDT2M0Kg8jTUKhxXK27CFI8Y6CJvB0C22fpx17qPF9pgiif1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH2Ob8xU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH2Ob8xU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1271F00899;
	Wed, 30 Sep 2026 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790785063;
	bh=svuAfgJakUMSo+W6wcHr0x3XkdoSATz2gMyo6m+IrD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nH2Ob8xUb4gRtsnFUnoW511mSLR56pj8FMFDyaNhwynP9jdstPpicERpeHvcRwkKm
	 xgdxzXLe/IXLNXQvsl0DMw6Wsh8u8znKklscxBNZZHnBFTiG4hA7wljo9uWqvb4sLs
	 hcM3F0TeWBLpwTWr/ZFHzaM8Zy00MHj32ooABR1yoJCGSSKncP6oFtQBqSux1F5nMJ
	 3Ee5K9QSNkBsE5ZV+kbIwlLj1tXqvI29W7CjMNoEJpjsElZmtxo1Y3efOaGN3DbO9G
	 l2uQEPR6dMvmEFGsQ0D369DEswjjZbkTaZzee6CashFSAyhbrpr4zdbZ4GO9DV2Mj+
	 bHwV/Vcu4UY/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@flipper.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net>
References: <20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 16:17:42 +0000
Message-Id: <20260930161743.0F1271F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> PCI pwrctrl never did, leading to a memory leak.
>=20
> Add an explicit kfree() for the consumers array.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-pci-pwrctr=
l-kfree-v1-1-f09bbffd8da3@flipper.net?part=3D1

