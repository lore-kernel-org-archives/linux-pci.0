Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760940;
	b=x7RQuMPgErA8U99DpjlA9sapTBtZVP3/Wcxl4m3svzGdDqxVZfSprY0cVLeq9igS9tkr
	 9laG6X99jpXRn3jpMIN8BRZ+9tuJNHgE7ZIPXKCjo73vkVmyBAAFcBP02jIY1Wmof7QfD
	 NLEmjGxmE3tiKPoJPlWwuuBX0UbTNyJp9psrJ1MAl0KVd348NF/nbLqw/lSQln3mKXSx0
	 oS6P2Ki8o797Rjf58WjEmb1FCcUB7jcTp1c73M8spJjUF//G6JMZ6pKvYMJdpK0sTxgt9
	 +NHdqcDQCx+KgXB44JiHYdEra7lPtIyMbnAhzZ8VdYhhNooD8OEvW6qGFAia2eO1zsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BHp9dd081IBykAgu1YPX1q8f0dQWTJVrMpkwU6piDNw=;
	b=zmsUMfBPT1PzrfPvDBkp1wScYJmkInJ4vE559MwfAG5Ul56FNmDpJO9m9hVi+qqlWTs/
	 0uuhDH5Vzzeri5jFR/dz6IlnA9HZkPoNJLUYohK9YGRywQwwoCERHp0xIUXwh22yUf2az
	 Iwc3u/QOibxrg1Q8btW3ljiVEnYLWO6h7gV/WQPyf08aYkHGu5ZlWIwePGQzmvNE5Y1F9
	 l0yOpzbIaMdRXnE53th7X1Wjuj3Z1XXiDc4CGDmLMFBviAWao8nNXjWoYrUQZ2bYopd10
	 5QIO/2ajPea5D1NYjjzqXJCG3njk7gU0G865aY3oBCmuqUMIfu9qfNzs6YUuA3TIzfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in2Wdcva;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C4606A32D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in2Wdcva
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A421F00919;
	Wed,  4 Nov 2026 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760939;
	bh=BHp9dd081IBykAgu1YPX1q8f0dQWTJVrMpkwU6piDNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=in2WdcvaMOazuNhqwmd68hMrAMVVQd/TI/G0XPiNX1Ly6HyPNzjORJjJiaSpqEuyr
	 S3ck5b6AEKdWiMKd+hBYJXWwkcSWHoYA7XH2wOvmjhNrLaGE116doLgTzEaDBkWqWE
	 zAzuNtPc6s/44aVtcQinBsnWe7EE8ZPPZXkevaFoMCknBrg76mCh27S/orYDOd8zm6
	 nDa9t6oOIpeU/RFNzh+BgeLrXerdSgxV0b2gi2PopfL1gqQnfoeAMaurMNSuR+QNV2
	 2hGMCJSqWV57BwEK62AOh4EdChQ5dU4eh92itj/r10asGmYxZO9lArfec6Wg5c36Os
	 7obTnNfjMXAOA==
Message-ID: <sashiko-outbox-196546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/25] PCI: Add SNIA SDXI accelerator sub-class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-1-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-1-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:55:39 +0000
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
> Make the class code for SNIA Smart Data Accelerator Interface (SDXI)
> functions available to both C and Rust code.
>=20
> See PCI Code and ID Assignment spec r1.14, sec 1.19.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D1

