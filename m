Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116567;
	b=Jn1yV/qmNcvSzxBWxhH8+BKSOFf8Ck33b7u0k468e2p7Xtw1imedQXuSCNT58VtRoLM5
	 rQqjR0E4iGk+kNxY5V8J05XXPwM7zlWALBqOS/OYJet47NcpoKS2XdmDOIy+GkMCFkonM
	 5YALXZwhXqYXUCBKc0v+TT2dw2X+RnS9NcUqLE77RxNE0uC8rT9MqYAZlAOce9bH7w2ob
	 R0XvlFnOG0s0/SJQ32V4qIE7MhoZqPtbPW2peZkDQIpQaxqZ664zx3l8CSW+DWEJlsafj
	 2tH9BG1o3I3gF7J0YqP5LhwDWVo/nb6yzelQgo2whOq2HTfa/AtVZb8kBD4VH9w5M5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116567;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f47K/WvqAPFaygsEd+lfkmHozKynMeYDhQvEitWjp/Q=;
	b=EmyEC/mX54zh7ckyM0X92nqqgSI1zbHHysRAPY3rBBeZ4+MT8zhNsXJKaq1WYCTnHu6I
	 lsIR2hxzyjQ86mUaqLp2ReK1OSMt7XEfHtutkH90NaRgSdN+0WAuLxsxquzCIWT+oGUBY
	 P4KEwkDKIbllt5395JfYrxRau6VYV8RDYiDnGafE8gkS3N3I+yuQoiuSz8FYiH9oHW+xF
	 ImGVxqe+HI7KHjwabJwzqtnFGG4e/p0bVRS68A283uVuoTr3XXqVxg0iScSAgCCsrNfGC
	 P49VWT5e9ZX8gsyyOFt0F7oS3EQAJ27WtVYTm87RAw0OjwZ0SIujoO+ztUquWm/VLXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFzyd40A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC0606A339;
	Thu, 19 Nov 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFzyd40A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B5D1F000C4;
	Thu, 19 Nov 2026 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116567;
	bh=f47K/WvqAPFaygsEd+lfkmHozKynMeYDhQvEitWjp/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFzyd40AVcWi3Ob6iXJzTa1UNCxHbeQWa6tPBakHR94uU5EUbf0Sq+xWXfThEAS4Z
	 vD4El78R802iXKsj5Sx/j/SiMw74MEZnddEq7gZX4RrXSGGBs/cnVd/tYKpf12mIXF
	 OOlyKWL/P64cw5fQEOpBcuuKnBSbPpb3Ll/nLb6Y6Sgt2RpJSdShp68Q3OV9X0eRZc
	 aD78DfyzIdcycNt522+8i3oYloEumCY5A+KVKAyy0GUAuZTatFxXGXt0ucr0lqCfQI
	 ajXLtPX+NGHLi0L42ckTHRpbopkrXGmnAxVXrtxon6u5w1lvrXJASrDB4J0C+FyNDU
	 EbFpDXyISyD/A==
Message-ID: <sashiko-outbox-223894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/31] ALSA: usb-audio: Release interface claims when
 probe fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-8-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-8-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> If the first control-interface probe fails after claiming streaming or
> MIDI interfaces, freeing the card leaves those claims behind. Module
> unload can then race with registration of the claimed interfaces and
> leave dangling driver pointers.
>=20
> Release auxiliary claims when discarding a newly created card. Preserve
> them when a failed secondary probe leaves an existing card in use.
>=20
> Fixes: 9ad3d6ccf5ee ("[PATCH] USB: Remove USB private semaphore")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D8

