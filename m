Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238233;
	b=GCDFR3VVAioBLhMgrA7QeEPHp95Umt/Lpm/M7aSBJKJ+X7rUK0cfqJIP1Ftbp5zm9s21
	 lrtKbPpcgix0AxM6Xb2yRLT4no7Lq+aBnNL/J1znc6dYaaZp3ZPDODV4WuiDbd/EUA6av
	 spbmHBiQqBWZmUOPSrzHcBOwJkaQ1m7zOarNIcsgICfsdEaDiXc4N2v420cz1/xabmHXP
	 7F1riBL42ahhuMJPDE6YInqSkSCdW2VHgNqe57FFaF0TdiW1OltJj8Y96gYYjtAdtG4ld
	 iOIZ7voHj7k1qECNjQCdkIb5dErma11lU8YoyTNCPiBOGWrQODjOnT+cNsGr1kqTKDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238233;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cU6fWzxqIAG0/8IcsnMUwJlUEJ1D7idJVfe++rlbV94=;
	b=ykl8MmFjpA9W3HzbBZRF4p9IXGgOAYsR7I9U+RzyWs1oPWOM+f6A8DmsDWghBFojqNbn
	 rNaPNjQ4GKkZwHYtZ/uq62xZ22goL5u7BEZdAq9vV6GINsjIrQRUf2zMRNwZPTIhWgluK
	 r3XbJpmiZTYWnXPRGW/K2xPXwX6UEmkXd0j1UQ5DrNrv4uuWef63NL37dlOQiZC4Obf/m
	 1Vwz1ijRk8y6N7/ZPP8WVJpv6XujTecpFyICAeYFdraGNmIJlwreXARAKjN6siwT6Tk/H
	 9GaSgq9pz56XveMHXi8jDvyEdFM4n3uoKmAN2KhdbWXmR9y3tIRrSa+PIKWniYmQJLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GR6fS/Rz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA3606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GR6fS/Rz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDEF1F01825;
	Thu, 29 Oct 2026 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793238232;
	bh=cU6fWzxqIAG0/8IcsnMUwJlUEJ1D7idJVfe++rlbV94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GR6fS/Rz1w2PfmTEMwEXcGblSFR8EbsHPmNCifYWUzn025RWpicBdQnvz0Or8q8Zu
	 5sPpP9bew6a+uGz9qTwJ1Qe8Z25GK6Rzcf7AtwJKHEtSaOqFCKWONEw0MWO5Q4nZdO
	 c2Gnu4l0G6CjV9U23cUOv819ziHVyF5e+LI7mo4+IgtADs7oSV2Jh5qZdCZkFXiHc5
	 SW93Mwik4ejk/x0LlOqocKym73jOZbL6jyQThBP4jwdpkm4nuC3DxIy5kSvz/ICLQo
	 bLj+1dvn89m39qHeI7ICWkbpN/I33HPhIoL50yRjjl8A2RJ+3SQSL4xtL+1nEKngK1
	 qeMcWK7UFzk4Q==
Message-ID: <sashiko-outbox-188607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] Documentation: Update after split of
 <linux/mod_devicetable.h>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <006464b404e9836e64c22689a8cdb4c34f43c87e.1793221199.git.kmehltretter@gmail.com>
References: <cover.1793221199.git.kmehltretter@gmail.com>
 <006464b404e9836e64c22689a8cdb4c34f43c87e.1793221199.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 01:43:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Documentation: basics.rst omits kernel-doc for arm_smccc.h
--

commit 1e9cc1a9a128cf0749229f0053d8a9b4210d892b
Author: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>

Documentation: Update after split of <linux/mod_devicetable.h>

This patch updates documentation references after struct definitions in
include/linux/mod_devicetable.h were split into bus-specific headers under
include/linux/device-id/.

> diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-a=
pi/basics.rst
> index 3b182cfdf1350..84f701b84e4fc 100644
> --- a/Documentation/driver-api/basics.rst
> +++ b/Documentation/driver-api/basics.rst
> @@ -10,9 +10,36 @@ Driver Entry and Exit points
>  Driver device table
>  -------------------
> =20
> -.. kernel-doc:: include/linux/mod_devicetable.h
> +.. kernel-doc:: include/linux/device-id/amba.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/cdx.h
> +   :internal:

[Severity: Low]
Should include/linux/device-id/arm_smccc.h also be included here in the
Driver device table section of Documentation/driver-api/basics.rst?

The commit message notes that basics.rst lists all headers that have
kernel-doc annotations and are not described elsewhere (with acpi.h left
out). However, include/linux/device-id/arm_smccc.h (which is included by
include/linux/mod_devicetable.h) defines struct arm_smccc_device_id with a
kernel-doc comment:

/**
 * struct arm_smccc_device_id - Arm SMCCC bus device identifier
 * @func_id: SMCCC function identifier
 */
struct arm_smccc_device_id {
	__u32 func_id;
};

Since arm_smccc.h is not referenced elsewhere under Documentation/ and is
skipped between amba.h and cdx.h, struct arm_smccc_device_id is omitted when
generating the documentation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793221199.gi=
t.kmehltretter@gmail.com?part=3D1
