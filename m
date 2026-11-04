Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810601;
	b=f+txwEPzCX5p4BufUd3AUoy1pfFyUX/gPiPDKaHhhOPBRpNyQvRTXISv1krwBEiCU77m
	 W7fhwGrszrHgCQl0cyTxtt0VlSTlzEDb26fMn7eG2S7sHAm8sNBskiM8hjNtbtXAwFhAU
	 8rdoczP8nhHfOfdXD/OdHdo4CWj9fv09UgT9oqouteTz3W4MHr5+Fj3U+f/DkNRlBIM7N
	 Rscu8g7Hhll9l/wXX6A5v/IJQvye+eQw8pKQm4CbXcXl6Unr12y3NpC9nGput0D/hSK0L
	 cMeeT3QePC3VR++gHcW0IihncItZgb6YYKLPdIlr7HZf21tUj5GASke5Vkc7rW8GLOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810601;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H0kbCFROkXIQYfcmIahhW8UlpypY0RLxvl+ZLmdJTC4=;
	b=5DlSTjqF5D+7ZE0tmxNBjeWoFO18/mOx75yqijrP/I6UH/WPvvCyIrFPOKeyBcFMw46d
	 /aX/whiEeLVDop6VcUpW/MI8F8oyT8FbelwjJEDHmOSE+ziXYV+Iv8awJQaJyH/ZJp4Wn
	 cU7t2amwU8prF14WKMeSvvdxdGTzvupPprshONBZcdgErj21SsxNS7h8S/Arm4Z2wQ7ZN
	 gZPCMN95EY4LeCy2nPXExsB8piNRKEK24x4uqBz2gP2KYTnej0BHkJNCVLagZG2BzgVTr
	 YHYYKNCjhKhJTAw4AbXeXvA/mfa2HIKGsnEUvDS3hZIEpNDCQECiRnosr/Vj10WRI4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NneMFlou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D9606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NneMFlou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D89A1F000C1;
	Wed,  4 Nov 2026 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810600;
	bh=H0kbCFROkXIQYfcmIahhW8UlpypY0RLxvl+ZLmdJTC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NneMFlouV3qml03y5PtUDb5/UOOW48SKJTl13hMzfuARAHX1aQyg3NC7D/og/XpqW
	 NsnxTjZqgJ+I8unanEbNy19j6/4OJbLZwiiIVKSlNcFSJIQbjaz6YvGPwOUtIDOmLu
	 rYd16VtH4Cd6YehITbqcXtsNYJ85us29WmpjuYQagJdfwxs2DIk4CQRSuu20YKsv0h
	 b2W1nM3L216By7J2dd4EjfMfqn6CTjV9PTorxHISUvc5Z59vWOURTLs0QG/4HBnHpo
	 i4WU1ZnjOUZgMEoe2/gep5neJQ1omLfMYrkJMtqPp2Jse5/s1xw/FPmQAOqVW/UxDk
	 An3zWCTdmuJyQ==
Message-ID: <sashiko-outbox-197653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/15] iommufd/device: Hold a KVM file reference for
 the device lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-7-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-7-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:43:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The KVM file stored in an iommufd_device currently relies on the
> reference held by VFIO while the device is open. Normally, unbind waits
> for outstanding device references before VFIO drops its KVM reference.
> However, REMOVE_WAIT only waits for 60 seconds. If that timeout expires,
> the device object remains in the iommufd xarray.
>=20
> For example, an IOMMU_GET_HW_INFO ioctl can hold a device reference while
> blocked on a userspace buffer fault:
>=20
>   iommufd_fops_ioctl()
>     iommufd_get_hw_info()
>       iommufd_get_device()
>         iommufd_get_object()
>           iommufd_lock_obj()       /* takes users and wait_cnt refs */
>       copy_to_user() / clear_user() /* may block before putting refs */
> [ ... ]
> check in the destructor so that bind failure cleanup is covered too.
> Document the ownership in the bind API and device structure.
>=20
> Fixes: d8bb80c8f0e5 ("iommufd/device: Associate KVM file pointer with iom=
mufd_device")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D6

