Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286145;
	b=L85wGGLqG2ZamIZJSCyOUIxrNmxmNEPiLz2puchm8g7jGD7G/f1p132nAuSDspT+dSua
	 9F2ffMrc74oTSHzaCMBw/xrnTspC4PNFHqP//eHRdXjMZpR6VBy2EtgKf20j2yyg8AmqZ
	 N2zdxikdEtuAT3ileoPZUrD5GVuJkMSmFLqzR5p/ZFhMZCeX0zpUYaZ3Zai7roO81eQQP
	 jMQP4w+gOnQrv8n68rqrJXjXU5Jw1wyJBz5QPUzKhlSLqkAlCuO+axet06kNILViUB7Rr
	 f5kehYxEH5Vmf8spRHvxXRgOJfOR9Z+wE6HZtRxUzpjpL89XkVXynvFsYU1dhKN+gtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286145;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lbFgSavLbI+eHAU96/mv2j7F2/NvD7PM6m+Hu7Cvq+o=;
	b=AjjP2uPH4Xn5fizgx1lku0oLCwyhjK9/ybtcmKiWcl1Yqaqtd70432OymH1Ufcm2ujwI
	 nji0ytYdrKPbtKhosmlbJ3CYPnex08o7XC8pECD62BzzfmkuPkuoUHALni6m7C+XKqnl4
	 eK8alX0fFH3rBlVfDJY6d6K7dZ6JvOe5JSYnzLzF6RDKEP/HyYDq0G24L0Vtr13xDINPf
	 ool3LaHAaVdYSXllwYfY8t3HbgYi6cDWdjgMXIKO77FxcpbSPa62OZ+/IiE/84x9zpjMD
	 Sevl9v6fH8gyFLK34J3mY3Z4wmI7pD8wCckdbqwhUpJaVMmpupJbtrgVSNYsQ5z+N8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drL+Ie+l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900B606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drL+Ie+l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342311F0089F;
	Tue, 10 Nov 2026 04:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286144;
	bh=lbFgSavLbI+eHAU96/mv2j7F2/NvD7PM6m+Hu7Cvq+o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=drL+Ie+lTloTiWHvJaCKzDKSgDuWLTQfUPGVL4eDCE2SxgZwfjvyd9NhpnOUGgqK/
	 cU0wujTuwKtZH01UImicBqv/EJ0VBGs5/wmSM6lnPa58Bf5xQMdoFGdb4kLMMM64mZ
	 gFLNCtqV87yFzduep64ddX5PaNO+jKOEH3x84H/vcWSQTvwY62XQMQ3t3E1P4TzuDo
	 vo6GbQYpuc+MoxZzyY79jBJsaf6ImUaX523xmMgA2LwBKfTyw0dEw4dD40DREL2B6/
	 Jl4Cm9QCtbclvs0Ini6W32wJjGivyhb2qMRMyiEw1cjJb+Ubi7LyY8E8wH2AxELGl/
	 i3/bGVuuUAtVQ==
Message-ID: <sashiko-outbox-206241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/25] lib: rspdm: Support SPDM challenge
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-25-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-25-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:49:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Support the CHALLENGE SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D24

