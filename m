Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348043;
	b=FNGoiT571f1Yj7KM5QDKr92fcnTCIDgN+151JjqHuuA6jNgpRnP/zVm35EHx0nFmJuGF
	 4V4lyp7Ard61LiBXktV5qviRE7McluZyIuahd1+Ig6ntSey39XY25CsgS/FplCqAqKPXS
	 W446zpWEFk588MQ3hAy3G3J4zVyfEir23qQSO/alFD8Ts6LDQSQJRKkqhf4enx1lsTu9Y
	 cieL9frozm66w9OpQ3FjP4DqO8pCMSMy/HuI7tl+mh6/xCKYvH+SA/NhUNcjMlcFJ54rD
	 71n0hyI+o2AR/Nk/YslW8NeoNyjlgEBnUQkYiiUnyORy1N52OwigFfRoImCJrp8C9eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=21haNWMrm70DxZ6ZRXebSeH0xH1vmPtcsqQoYc13WFU=;
	b=4ItAgizar/KuBPMc2pz6wSmVoDx/oHXldLYfm1YCu+dMv/QVxl6TzV4++UQcqS8x0vpA
	 uzPvU0ZrcioLDCiptluGQvlSfEZxNWRl4OsGpsEBhveHnVjzipVoudzpWamYmi0CltePh
	 O5Y+htlMqTgqsAHztgVPjz9m5ypCWEys/8D762W0IK3kcTDwKx7Ucz4RLlnM2l5HQ+GZ8
	 zNnITsHlvCVSnU1k8BTck2tw1/OiqlmD5ZhMGif4VoSLi37HdqUqZB2w4ufQGN2JSzS69
	 nTvHvrKqR35nGQiQketCdf4aGSYamW949bN59UuGdntzFtAWlFXarPTLMvOE6bUV5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvbDKF0J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F78606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvbDKF0J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A8B1F008A1;
	Tue, 10 Nov 2026 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348042;
	bh=21haNWMrm70DxZ6ZRXebSeH0xH1vmPtcsqQoYc13WFU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UvbDKF0J+HVaiBTIiDYkbzZC/q2YT/lXnhyoXru4kDlB1ASWUxc7CWcl3lQtqowXK
	 5EADTiRvXyOSxBIDIIqKdy00taKroA77KOPgcacBQwaCur2Vj/qpuXz1yhHUeX+VXY
	 Af0fzm81QkSsLMBZeRqg3CawQX1ycUys4/s0RmkoSPfw3QB+yGgBt2YX0FpL6jlqwg
	 m8v4Nv03Wos+xN/f11QQVEHp+vi4yxs/29bkSTN8JehnVv3Y/Jte/F4v1vOxX6uM+q
	 DnDsAiHjLgF8RIZLZqAJhHl5Kcn88IFs0tW9lOye6G+8ODc+sG+BwZ3baalhj6RuAD
	 nouiA1iNaRWHQ==
Message-ID: <sashiko-outbox-207801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] PCI/AER: Hide the "aer" sysfs directory on devices
 without AER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261110215614.3931232-5-yazen.ghannam@amd.com>
References: <20261110215614.3931232-1-yazen.ghannam@amd.com>
 <20261110215614.3931232-5-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:00:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> aer_attr_group is a named group, so sysfs creates an "aer" directory for
> every PCI device. aer_attrs_are_visible() hides the attributes when the
> device has no aer_info.
>=20
> But this doesn't apply to the entire "aer" group. So devices without AER
> end up having an empty "aer" directory.
>=20
> Switch to DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() which can use a single
> check for all the AER attributes.
>=20
> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smt=
p.kernel.org/
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110215614.3931=
232-1-yazen.ghannam@amd.com?part=3D4

