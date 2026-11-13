Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568835;
	b=LIeW4EGNBDdaNhuJOgjFuR9s8IOOpX/IKZCsupX95TmEIQO04NAFg53F+Jgp6MSled/+
	 fB5mcGG4mTAWtr3SOtEXgLVIWGBjaSSc3zWt2VhIY9HXgUi7xaNVOHQOD0pULwayN6bG1
	 5xblNdRMgpYUCBQfPnbe0VIxrxODp8dJ7bAcxZUGNXevEaDtEFqg2FA2rvVSv559aTMjS
	 RhwAZvEcjR2ZdJ2mCoaP8pJg6l94WjUjo8e088adVqJyGeRXDPHUNq4/LfaPfvPZ2l6+g
	 WhpgITS6+4tz8YtL7QTPAsnq8t782QQoHOAa9+Cfq5+Z5KnOhd8/HqFTb4Fd0UfFptw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X5SgeOlEUmHxvhFC/J2yLNYsUApO8BJ2VhrJLn9l3q4=;
	b=CFDnShEGERSey3trwaGRMaa1+rxIbnkeniqnRjSJctDtPtsDO+oOWJcJ2qT8AnhBwiHN
	 Va83Uq1wq304VFZIf8Zh3QboPs1lVp1sZ3+tdYumTKUgBpOKp8mazj63a0ic1lPnrEyBr
	 dZ4bnB2yp6Ub4SQ1L6l6qDxXMcHluaClyaipXdtrI2ITXk0riaeqPIee6rlGJZdw54AXS
	 lLbFPPdlDMwba9zOKdA/ERNGBKx8EImyop+NWRCo9iR1fUNxT6wpa3UjETDEGgGeB35Vw
	 iGMeYFEB8JmPB1OHzEZ0mDKAgcpL6IeTvmwMpW5bz8qOd2CTO6PHzzSZdzh/hlO1bfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2XgzvVH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72F606A33D
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2XgzvVH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27021F000C5;
	Fri, 13 Nov 2026 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568834;
	bh=X5SgeOlEUmHxvhFC/J2yLNYsUApO8BJ2VhrJLn9l3q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2XgzvVH5QLpLmtDGlprYSdFdi9K25GvVMzIcjiE+9EVeaamcNZDnJgN+1zjM8wiI
	 yw+jdz5EDRJLVOH6fnD2zfAdYFm4YZueb8oPC7IT+nAOIk+BKj7QJfE/REvvhfTRU3
	 rC+0Qt/M5usFy8j5TJ2/QHynFIhYT052o4td5I1FC/a9J0cJ0N6XAiS084jb2E+Adk
	 GljiO9Vqofyfoe2+lxSDU4BRRDCXSvWvqwTYokb3i+57noy/xrwGUWqjQPB9ECSK4C
	 dlLHxkuGsAkuKzPWHAoq15UNP331kzxgmjj4V5otl0CpavTB/9CT3XKihIK/R+AaxO
	 trJG5LCzsS2iQ==
Message-ID: <sashiko-outbox-212711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] ACPI: Unify acpi_device_id list terminators
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <b1353edf17242560d8670e6fe9b76de74a9be822.1794567577.git.ukleinek@kernel.org>
References: <cover.1794567577.git.ukleinek@kernel.org>
 <b1353edf17242560d8670e6fe9b76de74a9be822.1794567577.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Consistenly use an empty initializer with no trailing , for the list
> terminator. This doesn't introduce any changes to the compiled result of
> the modified drivers. Note that the first member of struct
> acpi_device_id is a char[] and not a pointer, so an explicit "" is
> eqivalent to the default initialisation.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794567577.gi=
t.ukleinek@kernel.org?part=3D1

