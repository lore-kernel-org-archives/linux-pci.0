Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116566;
	b=lJNncNTxzSOJ+gf8pqG2QdJhD+llSfk7oBjuYbaFw64A89ZoRr/rIjs0JFSrwHsIt0So
	 QCpEs/PV7Ee4hTu+WTCCtl+4J+/LO17wyHFQOSPGx8Fg5XQSgb+qf0S4H3/0NtSEF4koe
	 FMoDfqZL+AHUIvxJVlxgn7CVvSz8QvD34NkBqN8h6ZDcEZqKm+5tTZ0EIWNdCGHr2Waif
	 IDZqRAWNdk20kr4og7sUtziRnecGvvzT2WZCtSRJQldNq15Db99tB026bn9cgYBwFd/PE
	 Qcw3h2S4qWT5clp1dep2riNPm1+VJ7K6MY0KwgIAZAnwhlEKB1G9U00O7mbC6BQzu0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vqXah0PyOQZVPbhmpx12XBIdpMzQZASfn9p5oRA501M=;
	b=w+sjZRMoLzeZtiJfuXNpVAkMIJYHwumPkzEttc3iI9C+3HF8+zXUVGkDHadGposCVnYK
	 p1n+7wFDzrGSJGlGn4c4/AhuAM/WqGKfoxj/blXQJ4yIcF6muJcxL8XgtEO3ndRc68H5Y
	 3Jbma/wvI8/jzaeD6Jy+bnShLMO80iPv/2WTuJq7CSZTUK0Z5QP2s3YhO2sVe2RdmrxI/
	 wgniax9A8xY0DaBIgTHiExfhFVB+g66PikfMrZuR1sO8yPaD29BePLa9Fs3YZxVdi81x/
	 Ol1OavBvsrkf1wKT35BZi2UiRv9May7jLBYhmCRWGqVPGxIuQ0AO1/Pv7qMZPwF/kNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRqfFPHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D2606A33A;
	Thu, 19 Nov 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRqfFPHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796501F000C4;
	Thu, 19 Nov 2026 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116566;
	bh=vqXah0PyOQZVPbhmpx12XBIdpMzQZASfn9p5oRA501M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jRqfFPHMuz+dELdDta2OL8kpnFPgCegWgnVsEI/YUgg/0hamBcnHDuzHTNNJW08L/
	 +9BrS1zAoiZc1FhMwWlceDSyLknq9Qapf5mtPYPUO507KSESrN4TcfWDuTfdira1Lx
	 FZecr2RzLsmLReDQuBrS13t5zl2wlTR9gV4xft9nHRplMb9bAqf0I5xvS9WbgfePan
	 EzpnIZah2geMNtLZgnUfEa1QFTe2knnWpUmPOtiRilwBi8UEDU+WGJEfk5zmhJC3aU
	 cMF/JTFTKvoavnSR0IfOTrjnECCuGM/wGxONkaD8caR9Tcec/RTwqFNzbYX9sf3o3f
	 PUxiwbU8lob1A==
Message-ID: <sashiko-outbox-223893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/31] USB: Reject claims after interface
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-7-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-7-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:25 +0000
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
> After device_add() fails, the interface remains in the active
> configuration, so usbfs can still claim it. Configuration removal skips
> unregistered interfaces and never calls the claimant's disconnect
> callback.
>=20
> A driver can claim an interface before USB core registers it. If
> registration fails, reject further claims because USB core will not retry
> registration of that object. Changing the device configuration creates
> new interface objects.
>=20
> Fixes: 86d30741e480 ("[PATCH] USB: Usbcore: Don't try to delete unregiste=
red interfaces")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D7

