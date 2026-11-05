Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905436;
	b=FskNxaq65PMcdZqQ11cAKqYb29oS8+u3cw/c5x4m7xn2IldHJnjmFzTC3turep9dF6NW
	 iw0r0Adt+MEGi32pEMwyY3pHqKozJG2idJVFREpwu3PRJa9MznISnY61mbpcAMIu+/oUc
	 V9eoIfc10JfdSZiudotwO1NZQxggaHlWVhqKTI82Y7RVw67qCyjfLUsZPlnbPFlt1e/op
	 OtG5kfUlNjTNK94w2ruyENrAP7U62wd/RkHX/s8aCI3huNsKl1n6J7TM4mVI1OHpbRZgF
	 0jUA7OKtl7228mXq0xUyRWq1P5F/1wAKWDEFcORMFMy4UKlFCUqO+R2mpkL123vj8hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V+49rBPCNtSFpfoiSqzc2Wh7KRJb8gI+vWvzz1i3ne0=;
	b=X0KUdQCSImnIy4Z51yBfGzFUEh8gmVzucy4LFGjG5r7L38uCFxIMcWc5qfT3y4NFM1k+
	 JlIVCWJSPuRWjENz9+1KGFHh8jfbxRD/2DomY5J2eyHxlBxSsZlePXJv4MlG37rHJe/rw
	 SiPwnYmkHiEa8Kz9GhC4iz89IVtyx9Rpy+VQYQXIrFerSFXo+09MvmxomNk4DC0vRh8Gp
	 hbvbMdOqw/8dx2x05kMKe0dzMsCAUaKy9rqMyRtbNSxZwEhTwnoDzF3jZh9wAKxhp1U+V
	 dUaYaQwnTFH6JaVArsXYO6rHgKTfHav1b8TfVJjdzymyeLrc45V794A9LBSCiaY+uZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ9BEwft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA530606A326
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ9BEwft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555AD1F00919;
	Thu,  5 Nov 2026 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905435;
	bh=V+49rBPCNtSFpfoiSqzc2Wh7KRJb8gI+vWvzz1i3ne0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aQ9BEwftqhqhfnmEDIZrylCLUt7KaD6kvOBkCE16T5UM4QVbFui5dSetn+9qOH0DS
	 SvhQXlbPu0tG79a9sEpwnwrc9+vwimeucUF2A+5oOosx1PiQ6v++vwjWRZ68QMJruh
	 jiZVloAzBbaSmPLgntosd0SX2sdtob+0jk4whDKYWZJ6sxBku5InDVqZ0/hIkLf96N
	 rjKVg/E2WgWunchQo9NReh4e6jO8AuZKEFeWAToPJNEgUGpXttTJtjfZssOKqijpqW
	 fuNR0YVzbF6kQlDZFreAPXWdrfZ53rvQn05ghvpcd/aTTQ9ZExcggfNbt/ufBI7HIv
	 XTrDn+2MLNXBg==
Message-ID: <sashiko-outbox-199807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 01/19] cxl: Clarify decoder interleave limit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-2-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:03:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Explain that 16 is
> the largest interleave a decoder can express, without changing the limit.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hla=
ptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D1

