Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761312;
	b=LeJCXdqUlxekHqXmhimP04GFFRn183Q24oRWaK8hyBI3upTE67rN4ZhntFg62ZNdPAJz
	 cffpAHmlDmSaN5eT62f4z1ZviSb2kxf5Tq4q0n4GF6766+HMYS0c8uF1gcreEb5o8Kkkl
	 lbijdv7PExumRFBrT6j/2/ROaZBmBwx8Jp3/MQAl728qy9ZjYTU5ghqxn182wpm0xHQnV
	 jRnP3zW00jNB+4vBtPBJRo7PWqZOer23IHkniV1QiUoAXlm8770qfvOmNOw/uPWvzED4h
	 EK9Rscz+4Qvh9oYj8UL9CuwcT6Pt/xfJUyoPnQ3a+4k+Lp9nFPKmVBcuoFY0x5jpdOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fd7q5j3zglffdnLAesXLcETfRuk+G5S/iXN23bY7r0o=;
	b=qfHVOqOHGGSm/Vqu0+EKkYzG/f+89uOlJW/2E6DY+0x1Bro6KMNKrer8LDJP+BmyZFF2
	 3muwT7TXt+pqvUDO66P+POwvHd1harwlj1Uxt8nTVsLGOacX9dySxZeR/9CMmxBWNjn4v
	 YIThZgwo4oWMLMxAP0YbgF26uF1+wPA+f0QwYhPNmrs0Cs6YA6Muiz7Ye5/fm/FcfdSpL
	 Xnzvkhi5OeoRLZtAj0rl0Pvw24dUs3WaVged0VmpUyz0GCKBV4ayYK6KzbOhd190Yp0Yi
	 LjO9um6sdlEeu8swoMQkPixrogZV98HWyHQ47TkVdJ1boe3WXvGp5ChSPb4J57f8tiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIishLPS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB9D606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIishLPS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC711F000C1;
	Wed,  4 Nov 2026 03:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761311;
	bh=fd7q5j3zglffdnLAesXLcETfRuk+G5S/iXN23bY7r0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIishLPS4Gao3W4ivcmRUQxprT36s1xtFMVJbkR2XP9AdYLRjlDA0DMLJm1Dyx86I
	 hD/ZKj2tMqxyjYYOee5YQ4D/OVyIpw4bhq+tiDd0QiXTbjQN+w3Dc/WY9fne+XtydS
	 Lg2J+K2OwCUK6kr93UgZMJJMmu6yeKS23hHpXLa+t+7RB7qagJEmnlV9K7qB1bBxmc
	 BD75zfgdpcSIs6+kcM1OHJGyRTksu/gQOTiwiBLC21YxELzWPV2MlzHN8QrUF1bQrR
	 fCv2zNRSH+LKy+8CjsTOTREyLowJ8TD5ew2kQTBCZHCUBrb5r0DPACsYzpLYvylooV
	 bz7afn6IWbL/g==
Message-ID: <sashiko-outbox-196561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/25] dmaengine: sdxi: Encode context start, stop,
 update, and sync descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:01:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Add layouts and encoders for administrative context start, stop, update,
> and synchronization descriptors. Parameters select the context range,
> update level, and synchronization filter. Encoders set mandatory fields
> and produce little-endian descriptors with VL clear; callers attach
> completion storage and publish them.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D19

