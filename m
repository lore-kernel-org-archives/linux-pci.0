Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494633;
	b=rIdNtqXC4OH6LzHYm6CBWQ8hxClbcfu7AhTiaNc21bSqi+BTm7WK5QZtpHFLJod9DVQQ
	 zr9KVtQhUbcE4f6DxWyOsmeNfWYIC2AVvn2z3MbyP1Nj1e8imdTJuBCdSLtULOopFQbxB
	 DleOCJHwtbKiq7oYTSENNGgSLEbBpXtJ3uWp1U0j1mng9l0aGg4AtY9Nq8iwhkk50nyd4
	 cpSMSDv2eehNfNsnf1QQ7UuwMTuZJZJlLQwZ4Z+kLsLWTpzWuICADC3E2muXQqSEhWSD9
	 Fm6g5voZuTmmYhxH6an/twz7jRg/6WM2S+bzjjZ23eI/tGsaDzyphROPQEXYQ0761YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494633;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZV8REPkDiEgMvtC3oPumXcPlQwyXqO0ur30pVFMZ1Xo=;
	b=CUqqqPphbgBqAlooUPSCD3iEfr6Qf4MR+MYZuu32VU210yEt+8wlJA8CBL7Q6CHBTPwf
	 XQFwUFPQHL63N7SSJaNzpc0yvaK2cFN84FqD3IP71QxJOPDFysF1gkIEJKXX5rJ8ZNuH1
	 CFJ3lIlBc/wD4Cm1iHb/FhtxEwoImJ/F+En5/gsUGXn3qnYQeFr1DgJCow+4JaEwOhkOc
	 2YCDZNz+rsiGF96gG1U87Mi7RHvK1jpaFeWw7lTmHy3nJrjFtsyHQx1i7GZ9bVAuoKamb
	 5tWsWsYCrZ1eLL5szNnFj/7RJKSkk+/eTNU7rNT3xcfYCln0W4ne/LbyuUS9gNXqZdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCJirrti;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BF606A323
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCJirrti
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBE91F00A05;
	Thu, 12 Nov 2026 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494633;
	bh=ZV8REPkDiEgMvtC3oPumXcPlQwyXqO0ur30pVFMZ1Xo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kCJirrti35Z4pezKl5wRa8FB0Sro7IVuTQNsen+7wTe5GRMhnHCRAfZJFwKknTvJp
	 +1okYPvhblDHQXnxzur/I18BIJnizXfq34I9zopvxB4011Hu/RTJLj+aJb0w9xmpcL
	 4rD+BUl5ggFoDMRK448EgPiPdnM/J3fFVPYU7sA2A9C2Y6Fhc6/f/iFuFAaRUpoSUY
	 AM6uf3Ty90oBkPQY5D2M5Ksd0EFlfXmKyvi/Iiz/ZtcaKz+F1Q+Ew07EdCxquufPz1
	 T2ExALPJcWIK4dAJjRuIQuarlXNRRJlqV4VRjeSxx6l9NYEo/HAuT/vpVAqmeldvWF
	 pEkbdhFUxwl9A==
Message-ID: <sashiko-outbox-211371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 19/20] vfio/pci: Add
 VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-20-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-20-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:43:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Userspace needs a way to enable host recovery and find out whether it is
> still running, succeeded, reset the device or failed.
>=20
> Add a device feature that registers a recovery eventfd and reports
> status flags and a sequence number. SET with eventfd -1 disables
> recovery. GET is available while hardware access is blocked. The
> sequence number lets userspace detect recovery that finished before it
> read the notification.
>=20
> Reject SET if access is blocked, recovery has failed or a recorded host
> recovery is still running. This also applies if userspace had not
> enabled recovery when the event started, so a late subscription cannot
> report part of an older event as a new one. Updating the eventfd resets
> status for the current open. The existing error eventfd is unchanged.
>=20
> Add the recovery eventfd and signal it when recovery starts, completes
> or fails. Release it during close. Signal under access_lock so SET cannot
> replace the eventfd and reset status before notification.
>=20
> Userspace must probe each device and restore guest state after a reset.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D19

