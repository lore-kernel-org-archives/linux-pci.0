Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116578;
	b=F4c5EMyFmAti6DH3syqhkKV+wYB9JrIp9l6ozbAYuVcdB74vLl6deMUN6MPxEMdIhECF
	 EK/YACoqgVYQs0/GsbWs0cDx4vb4sxuNB8SnXz44f2CWmrPi8Gw10Iw3+ZEWcaa1TmhcY
	 2kEtWwd1/zL1Lg9hX9KQ5RUViUk5en0cHqNaYaNwt/FwQJtvhVjPeix7lTrgnZB6D4exe
	 3olAS29xjdVyQgLjVKpyc6SKAtWOyp+4F7OpdHfH9r29JYHaB7QXQEEi3CJhV0OchkeKL
	 +B/YXILtJ7xMCtFvDCetK0m4Dw/OI4WbFhLsxFHFvlTGK97kClG4jo5+P3SJTYNPSDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116578;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t7efuZee0MkpqR/RuKB37vnF4al1UlWTsKB9VjtefYc=;
	b=cESfbBWSyGLuxDbbE+VxrJ8e8jzhQnDz6NWCeTUD7QlzdKXgnnHLhFJXJrhAE5frjee3
	 tyvGKMNnjfA8D6Sweq113+8IPHg9E/P8N+UBJuoXE0oPsmFATC3H57OMG0dHzF4tuYMwx
	 JlccV/JGbQGzFc9mqdZiWHjFxSdsR/ZxxPC02YZzrcVpi3WmnUvJBGQTHNQsPIFZ6hA+I
	 NMbKMokOBp+yZK02J8uWF30lv2epRnlEls4HZh4YyMYCE//1fQQlTy65Mz5Rd4q9S4oam
	 Mwvz3kDZvY+2w9co/eKLU24hSlqTLJYMNIiGiDDrn0PiKyycvWqSwor6+lVE9oYdB5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="im/F7Vqk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45B60A5BC5;
	Thu, 19 Nov 2026 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=im/F7Vqk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7252D1F000C5;
	Thu, 19 Nov 2026 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116578;
	bh=t7efuZee0MkpqR/RuKB37vnF4al1UlWTsKB9VjtefYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=im/F7VqkHwTvvCaX+qkniVN+bEg6zn9b/hQgzG0COn79jAs2Y2MwezM/Qd29LFHN9
	 QmhCMIA4osbhQOsC58lIR/Q/tizddrP7M9yvCiavWOFCR7Y3/0MHCzYHft56P5Ek9+
	 oJaJa5LRrB8OS3JKRngpa/sFBNLA5AlzcrjmZk24GSoX3pjhTUEBffCJ6FJGsU5e6Y
	 +0MrGC4j+vrHomY+oNz90m0Y8ONHUYLbxm6d+AuWA/6aLMm/ZX57JBkQ0B8gSFIth0
	 GMDd8jUz+B9+tYkaE+8GNEsOGuRPammaQzH7vY47qnlWmnP/0WvhgCo5/Um2lHu6X/
	 1/JhnuV16HCVw==
Message-ID: <sashiko-outbox-223906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/31] driver core: Expose device trust authorization
 interfaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-20-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-20-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:38 +0000
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
> An initrd must be able to authorize a blocked device after attestation and
> distinguish that permission from a successful driver binding. Existing bus
> authorization interfaces also need a way to grant access without bypassing
> the common policy.
>=20
> Expose policy and active trust through sysfs, with shared authorization
> rules for bus callers. Authorizing a blocked device fixes the choice for
> its lifetime, so a failed probe cannot reopen the decision. Require boot
> opt-in for the new writable interface to preserve legacy attachment
> assumptions.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D20

