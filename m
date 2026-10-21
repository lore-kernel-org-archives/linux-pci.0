Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587393;
	b=aWYqIH4GDlGtFNWq96uiz0YdbuIKG4iKktBBonYf1qwXx265ApUdqhCWb5z6QmcQTIei
	 5FkkKEFf7VjDyZ1/DO8nisdVsb9k1CT5pCMp0XGSfAZW9M7lOx3CRNpoyDVi4ywxy1Jxf
	 pKtPxJWOHymYj6NR1h30A7hHzLXB7A5yiiymHzkly3euN/Sr5f1EcrVVl8zrPKKbfotTy
	 u+jJvHQiOT8TUnH5wq2UEp36f30v29W4gLhy4vG5LdDy0huJTkyknAg8vghucI74m3JzM
	 1l/5iEEglKzf0b0BCnB6DYdKQKrNJtPZQDBf1xS2H/fyPvZcG7Lz+mVlTyaAXunGVaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iESQb9BB17hp1LdRSYj7/17LVqoSdC4bamiIMSM2k8U=;
	b=otTWdq8QKr4gNMrDFzLzzrOhEambXPgczxRZ/+6jbsuGyeGgTS6LRW+0MMHVN7R/0PA9
	 A05FL8Bnx84OpUvVclKJmuFH00Va2RbIeAlTMCv1TqR8WXDw2I9mEfCGaDG/0UkpzGnqw
	 lpMu3waQNpFcur+ZvqDIDw0FTMNbxAfXOCbvGj4ywSk40l6NzZ7NIDZULCgCMBFdfp+LZ
	 PrCANyYsHIRtgoLQNd+AY/d75CEOesNtMdDoa9CMJ0al6ANwqsu/2gHPaG2pVCcIJduRr
	 2Mu7tF49F/NFn3OouvofQ8mKxtYP4NtHXJxpQa8P6Iev3rZTCQt/j/t7+am38qcAvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQASANMn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B0606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQASANMn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA891F000C4;
	Wed, 21 Oct 2026 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792587392;
	bh=iESQb9BB17hp1LdRSYj7/17LVqoSdC4bamiIMSM2k8U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PQASANMnsLTfzmgU5WClvFPHyG3BlHtwRkZjzdDGkyQBEKp5Xg84ZI1yjtu8W7Cvf
	 ML44T+hI2k5eCJYuoniaRJdCiQYJxFyuZuGfU6+ajI2EQZ389Qf4mB6JQgnSJl8IK+
	 ZRKtNyit8t2HwB3IRiewVq57GGd5RSzuxQQCtuYHg3BYZxgDok+cicuhXy5BZ4e5KK
	 4PjKPEB1n7zxKQjw3dgNSPFrSDQIcBLw4WaICpxUCYK5cEzQ7c5akbHAWDEIvOo0ha
	 X7lGP4hmRvTTM/xXVBTAWcqbUYqi4xpAqJkKvG4rCYw/KO93QkBab+Pto22Kg2pDaZ
	 4CExt3DG3+doA==
Message-ID: <sashiko-outbox-180281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] resource: Mark free space assigned
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021124956.4250-2-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
 <20261021124956.4250-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:56:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Free space ranges are (part of) assigned ranges. Since new resources
> have IORESOURCE_UNSET, the flag gets copied also to full_avail.flags,
> which hampers printing them with %pR.
>=20
> Clear IORESOURCE_UNSET for the free space indicator resource.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021124956.4250=
-1-ilpo.jarvinen@linux.intel.com?part=3D1

