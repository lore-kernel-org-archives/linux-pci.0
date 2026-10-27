Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079522;
	b=1w97zgiD4/5J3VwrD43Gcc+bduEwfF2tgpmHCK6X3rESR1APG+MB57LH3WiSHaWWYsGh
	 gtPgS/H7di7mX4ZJlDh4ReGZlwvdqKrrqaQWqJYKPXwjk1kaAw2LfURl2xKJgu9piI4HG
	 sYUbdDhk62GEgjSVXXVHaZ7T5UK6Eqs/VF+Y1n33gCedT7RL+8lZzXS8k7e7TlAwb8VsK
	 TlsjlsH+xze6Jt9APubd5yfyxFW+JGlYLlzigCYlYQO4k/xWzGeMsGRUZx7PjqbPNlwOo
	 vm5kaEuT4wICbr0d9Xz5QhuMeEJ7f0vSDB2/g9vs0c7cOvnlnlciQleVqTmkEGit8pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079522;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tmjmuwB+rNzdpy4ROAI16rqJ2Zyoz4mHekrM1CBw+Uc=;
	b=cWykEEjJL8PvJv+3+mvqroK/w/uTFFI1j/L//4wQrhXPP+m6MqB9CPHW8GKMYfDezDHJ
	 zsjKan0hNpOM7s1Qrd0UzBrEIp0A81EDl1vMdZy89wngltfxyNlpOAF45d9RFmXROHk06
	 Wngoy+MRcb9fL1XM/1ZJvFhYGrPK99FmsRZXJVyxqTqYK0ATDnqP1i/Qj46yzTIL7wsUk
	 wXcvCVUnJXmoCo09pA8SSQBkx37Qam8CZA3I6W6+gymrmXWZeB+ijaDm2THzM2YdleMjc
	 DxF+xe6D1Wh9Jytk1NNMY9pptgXNtXMl2/5C4gPZEKRDUHAxMG2wGhNO/bnc6i0yimg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDu01gSC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF35606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDu01gSC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04E11F01825;
	Tue, 27 Oct 2026 05:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079522;
	bh=tmjmuwB+rNzdpy4ROAI16rqJ2Zyoz4mHekrM1CBw+Uc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HDu01gSCykRP5MFM+d1g564A4zod469vLeqBVvQYG3qL7tV/hFHr/6gsG0g1XeDvl
	 IfsbnFwlkB1yAkKzJN/xjLFAmJSVuoBqgvanhyxy2zS/C1IeuwZUwL4T9KaAndySrY
	 ksGYfjjfTUJUHzJT6U38vjpM53sUVnSgQSWBqgf603DV1XNhvjZCdt+Ofko+xdNxwM
	 LQGzXUJm1chkHbmBIIfwf8ETGNtqj7PF6PD+qc8ypldnDuYeXleh2AwgQ50tGq9tPB
	 /eS1cOUKr2iBbNa+5iqDVkKZNHKKt2EcXalc7ALrPoz+ZQGCnEzI+a+txb01aCrIfn
	 H9kbK2otNtGdg==
Message-ID: <sashiko-outbox-186131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/23] lib: rspdm: Support SPDM certificate
 validation
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-23-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-23-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:38:41 +0000
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
> Support validating the SPDM certificate chain. This only performs basic
> sanity checks on the chain before we continue on. This does not ensure
> that the root CA is trusted, we leave that for userspace to check and
> enforce. Instead we just make sure that the chain is correct, uses
> supported signatures and that it isn't blacklisted in the kernel.
>=20
> We then store the first leaf certificate for use later.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D22

