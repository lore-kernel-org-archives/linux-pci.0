Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468203CAA49
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282421; cv=none; b=S+naKnLTJ8bAJGoBLgh+ZqlCQCH1ZMUQ0nD/aT0UYtOVgNb0ESeXbKrS/50vcmnJXvPBCQolfi/rfXwL9/efRat/ap30RcqCY1Wy7P8LohVNshn9b5JCUAGrX3ISuKNJZevqLV+7y4sXNf+lh6Dp8kKwAooq+OBmP6TPCU0I8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282421; c=relaxed/simple;
	bh=GA92GOwZ7V+IgG12EPMigCMwyd+EUnzF0aIKd7VsCAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qpC6E26LdLJq8pIeGCAp+UKiNAn1KAP82kTZ4mB2K69V0A1x3efzim4PiLD/QX5QAf4zItcHLAqe48s2qZJbqv+WCVJWIh364Z+x2Syh6CtDQCaRcLkocGL0UZqQNzUTC0LraT5KS9Xne6Xb3pO1jWKNCL0erGh9pi6SS7Ltq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GURfdB+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GURfdB+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE93F1F00A3A;
	Fri, 17 Jul 2026 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784282419;
	bh=GA92GOwZ7V+IgG12EPMigCMwyd+EUnzF0aIKd7VsCAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GURfdB+ykM9gqI7LWDoZk7Bwk/f41C/BwhiXuHdighVw0gX5R2irTWSSyJWwmRMC0
	 LQR28S/xojStBpKinBjYtrEhY/OIZWwjov7SFdAnOysrA1ZigOkoQRWyXfQNZxatoA
	 VoOjF89nG57KzOLKNQq27PJBcuW+8RO4KzaF36U1LOGzx/AySCRQkChplbIEqV5ySH
	 aljuXU5ZheXO+x4bljlkwLdy5UuSVnUHsOGF0n9VecFkD86LmdcDrQlLgyJst+c3to
	 OmYmAgYfwVurICp1w2BDQucOrZKFewU3wv1WVSOUK8h71ix/zKJpjssmbyxoQX3Ee5
	 vkexR9+4BHyuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Fix use-after-free in
 pci_p2pdma_add_resource() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: leixiang <leixiang@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260717095120.51111-1-leixiang@kylinos.cn>
References: <20260717095120.51111-1-leixiang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 10:00:19 +0000
Message-Id: <20260717100019.BE93F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In pci_p2pdma_add_resource(), a devm action is registered to call
> pci_p2pdma_unmap_mappings() with the 'p2p_pgmap' context. If the subseque=
nt
> call to gen_pool_add_owner() fails, the code jumps to the 'pages_free'
> error path.
>=20
> In this error path, 'p2p_pgmap' is explicitly freed via devm_kfree().
> However, the previously registered devm action is never removed. This
> leaves a dangling pointer in the device's devres list. When the device
> is unbound and devres is cleaning up resources, the unmap action will be
> called with the already-freed 'p2p_pgmap', resulting in a use-after-free
> bug.
>=20
> Fix this by properly calling devm_remove_action() in the error path before
> freeing 'p2p_pgmap'.
>=20
> Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through=
 sysfs")
> Assisted-by: Antigravity:Gemini [tools]
> Signed-off-by: leixiang <leixiang@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717095120.5111=
1-1-leixiang@kylinos.cn?part=3D1

