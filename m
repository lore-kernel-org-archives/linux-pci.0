Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285164;
	b=4o6T96g/rYYyE13Yk+LJ1A+8KKgH4zalJQBepDuCYVXQIxpZAENrauuKSFj+7hAIhoQJ
	 8hNGsMDmwRw8CPeyjfobLDjwyEcrJJ2OCAMDa6dBjvnU/byWa/YT7HisWAyuwUkRFoiTt
	 n6lYVD2KPfEesgVWOb+VxOF93exlF+szt6g2zNRdriyMLgfMe+MLS9GYJFcRN7gFLHu8E
	 dSObyCvajzaPuJ7tir+oG3084AJmUQbe+0H6zB4w9JrF9AJNSF7/MU33Zi9uu+hN7VWSL
	 aAb1KHTv1YzNGHmSid2M/j+1tv0qjUFDpbA6KvR4vop6CiK1FZrxQp2IQRKmNTRd6Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DF6VPU9Pgd3OqmLZnbL7e6i9yxurQ/Ok/Kl+9nGeV0o=;
	b=KBVgKQgk5jbcnrOFMmbhs8lVprBmNnuogNUFqLvWFAMBtORRJNyM987n051asO+wPx9+
	 cOOqwz81rtIGBeXCWvKvIBG+K1NHwtNSJHWlwif+etwR+Wa+HjT3rgM7fqjbD06Az96uj
	 O3S7zTe4Gl8naNb1NLJLFcTFYreuLW3NHBlx7nF7GCAysGhsqQHcvVu7UiLG+1ySIdKoU
	 vEvvMjAdqg3Wad8kSGtPTPWhUhEe+2lPcoY5KC9XCWIcIz8ss9WturwniQ/a1pyHp1Gv1
	 oDbyXC5adaz6K8ewWAGezTvxk38eo5AyhaZ3mj2KqfttbWcKuhNVbEu5Ugmj+gkcpXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmGPLtTa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D619606A325
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmGPLtTa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114BD1F0089F;
	Tue, 10 Nov 2026 04:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285164;
	bh=DF6VPU9Pgd3OqmLZnbL7e6i9yxurQ/Ok/Kl+9nGeV0o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bmGPLtTaDVb6cfQI9q4ObThjMFdbxJVWLmahYyMFXT3CC3Kxbeg5tFtA5Zz8kK6hZ
	 oLu4DkRap2jr/wdubXjtsW9W7HkCNe0JnHnQNBwLinaHVnvQKcbJfrPXWgdpfYrgrm
	 Pep0yrwT9IVcY5eErqUnfSxcHK94Tfxqmh/kv4QiZrDcc+r51kxoeEkb2A+CrQxDl6
	 nXk/CSCPmMl6oGZ+cOGBWsLS0SEedYPhsInQvoalxVXSpt/QJofGWWxD3JO5RL8Mb7
	 KXlPBN98vFtDlXidkIBiBW65dWXSLYPDie895Flw+VcmT814Wg781apqKLdLXB7rjl
	 jjiStnaAtzK9g==
Message-ID: <sashiko-outbox-206210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/25] lib: rspdm: Support SPDM get_version
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-15-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-15-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:32:42 +0000
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
> Support the GET_VERSION SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D14

