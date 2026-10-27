Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118370;
	b=L+92YNegTevxph6FHydORWEyvTiII37hWIluhkng4woQhotw9jLQoT3hTFmcLOigMKH8
	 HkBova7Eqz67BG4rARZAN1ballfs7lonnMxgo81qsprDRIuFczKoOfAEuUL+F2z47nEJS
	 HzE86s7s7zJEYLGQ1TPqOZoYcYrv6A5dmC+B7MCOmD/8g6U0yd9aMa8rLIixUenq6QnQO
	 u+/qmHTZj03vU94pDq7NDR+t5sDIBYM4P+WlD/e049mdFxveqJec0a02AjvhwyP8zZRT/
	 QXtT7HrkD/Y4rRhJH9kDed2mMU9oFDzqNJOUGhxa/0YJb4vxRpauSyA7H+MMsvzs55Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TvcTBJ/xHuagtsRzoCQJQpIh/ypOybdxk1MlhT6FS1I=;
	b=ei2Vw6JguVW9rKMzuFk4exrrQtDlArYJQfF8p781qKjUbQx+PunJdqq8ZgnCkrRYxaIB
	 teSbyFWoQca6CVXym4lLZsusVZa/Zyl9tGPnUljYs7/NuqvDUCFS9SPjGI2i1tkhU6dwH
	 VAmMjNs26ibSs8vgA09Y0J6PmE3C10ikTMY6lKRzNaRM/s0U2WpiCMZf/TXE+bcpQcsyw
	 lanIpv2qhk4kCkz+4LsszuXjQm88gCL8Ep9RPL269tzLuRBPq2YNjQYCdh4ukn7xMwhoo
	 Njqm13BE+DOoRyX/nn5Qnyde6ODRjES+Ao/hVidp66weBOc6b2/wGuH2RtgO/b6/qFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjZl+U+e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC84606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjZl+U+e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFBA1F01825;
	Tue, 27 Oct 2026 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118370;
	bh=TvcTBJ/xHuagtsRzoCQJQpIh/ypOybdxk1MlhT6FS1I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BjZl+U+eCfJEtIwwaaab25NeO7NQQJf6COY33U3CCsJqLBAMpHvHx6Ywia9fiXbEm
	 Ft7AEF/iLxJdRlo29SGsulBXueH0KrC0V7maE9snJDz/pQzu+OE6vsSWtMzYcrL2Kg
	 BNUfnSEt8hTPAbiue18/2SP5x8NeKey4yNXKznnuJLSFm8tM36OT5RWAicJGGDVg8P
	 s0G1pZyfdEiE2FR3Vp7lbVBc09vE++KV5uzNSDSaTqiTN5JMdUSvZ8U5DatovMVJg7
	 qfQOZ/d0AUmo/Keq7LXNDgMoboxNwHxdKQ+W068pAYGRpmvet/oyMtIjIEVMYIlRpO
	 BVU13K1foUWMQ==
Message-ID: <sashiko-outbox-186909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] PCI/IOV: Introduce VF locking helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-4-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-4-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:26:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add pci_dev_lock_vfs() and pci_dev_unlock_vfs() helpers to lock and
> unlock all enabled VFs of a PF device.
>=20
> This provides a common way to serialize operations involving
> subordinate VFs.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D3

