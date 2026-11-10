Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285699;
	b=HIao8JLw2+rDTEnhGmw8UKlDHFOvH7lhbWs4a7NzmTPSjrVZFXZ3ZkVxdiz5JShBcJeQ
	 lOmz/WXiKdaawdZ28JnGtuV3Qh1Bjlhk/rlfeuAbZAawN9pe1RifqBVwdoHT9jjmq+cfw
	 fuLyhugkER+s9MqRxoryVrgtGp4aKjRbXUUXfO7AvffOS11CsLX48FQ+e05V0s9vGuW49
	 W/1HU6oKCOyabcAZYKrioPzW+NzDSQygqZoL2QuTG5zjUEf55ebobMFGLREIPWzpYOMhw
	 wq+rFY0UrIvM788opENrkUdJtQfYfSRto/w7s5cbTfSzPChcHA0u84l8ewfqOtn1pvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uNcfrERsA40ehxzkckG/z1fzFWu23ZTcmewvM9PhxnQ=;
	b=isQtzjZiuXxKxmiJQJEFB4g5Y9H/6UrFs0lyOrSb5hO+SXjcrHKg7xJzro7cGLMolD5Q
	 diQ7/gEwyhRveX0TuOn3/6sdEgVQobpSbWzbTJk2SEkPmaDg7V78BL0BaZtushm+fBXxq
	 tnhxcSxcm+Pzw65Q+pjSDOE8xyObV/PBSQufwm0JD+NxaEjlKfBvuEUfMRuCWTT1ykGmH
	 KNMWbnGNO3o/lQovgHzrM2YZFjARC56BV+0QeULAwXiROWmuTbzCZ1UZHOGvRjkShtgif
	 Iu+wvGzfraDe+V5zkolaLeSB52SfwmJdimILGTPwxqrlwkC/NYldOsbhSu7wYWXH53w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLKrA6h5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C7606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLKrA6h5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573341F0089F;
	Tue, 10 Nov 2026 04:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285699;
	bh=uNcfrERsA40ehxzkckG/z1fzFWu23ZTcmewvM9PhxnQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TLKrA6h5BYzXl+kMTsIHvhbVLxnHQPXuj9ZBdIXlPMUiZnnUFbQTvK/vUoLf+dqAj
	 JIFvF93vuhtakIsdTTvg5iQy/oubf81ADeSH5nhiTuEsbyufp1fvgxS0NRYW2kHRHJ
	 xiasmyTr3I+LKvYLW+YU1Rltg8dgFRwXo+F7wlnwwGAKyiTAMmoBQYESXZpTXni1BZ
	 M8O0gBpsjUM0kf5kO+IKE2adwo49aVE1osKUZCNX53Ce2aEHuQPj5VYOem6JbH2+ut
	 CvIec+RqgLND9fNKp5gfaTmFQciMo8oL42JCJCK+ZQpH30GHHkchujfN0t3D3Ksq1w
	 BUhlY+CS95rbA==
Message-ID: <sashiko-outbox-206228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/25] keys: Guard asymmetric-type.h behind
 CONFIG_KEYS
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-22-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-22-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:41:38 +0000
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
> The header keys/asymmetric-type.h includes linux/key-type.h,
> which is where `struct key_type` is defined.
>=20
> linux/key-type.h has a `#ifdef CONFIG_KEYS` guard around the entire file,
> yet keys/asymmetric-type.h doesn't. So if CONFIG_KEYS is not defined
> including keys/asymmetric-type.h will cause build failures as
> `struct key_type` isn't defined.
>=20
> Guard keys/asymmetric-type.h with a `#ifdef CONFIG_KEYS` to fix the
> failures seen when including keys/asymmetric-type.h in the Rust bindgen.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D21

