Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150144;
	b=ujSI9AfCRPWQopLfhYart7+tc0vWxmPoQndgBoqKJBDe1xZNu5SWXNiZ84EbhfKk4Xy7
	 1EcsBQLIzgGR1dRQUAmiQmew2Kd7RrN9JAS5S3x7ZNLNoCv8zk1bfW9M8nwx/tb7fZ6o7
	 c4ZmpXR3vPqf59waYAl1lWaaaJ6LCZBSX5uzpLC0yZgmnuaB6dF9zQq82UXoBZIEJag9Q
	 MvyfgX6HZtM4wOulmmK1r51HRplfkc7iZ/EondwFk8GJ3XXUHx78LzWnIc7LDqixJ1t1K
	 Ny/FbGra/8DHMagDmWORr+IY8G5FLKuyaOSryMXU1CcRuBMxSZ273R6/lfCmKw2q76A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150144;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xjtdU2uUnJwxlO9x+uPgGac4rtNrLfazd766UYBm5kw=;
	b=GX+O6mXOt4UntqBCSHQ1NcDTVXW3KYUc5+bFqo1OaGbI9UefL4rVxMQl2IUkWMphsZpU
	 c+TKmC7+IwE57TgbHqs7CXAzDiCUiG7aO1SSrg07yNNeBadIegMScDaFGn4tCypdHC78Z
	 CVzeWjz728beCv5+Ke9ZU6yi+GG0t90Zufb04YgsrZGDkV3LvF9PvSqIfUVgX3MGHodhS
	 pxy6kSY9BKh5UeEO99AdCylPqGicSrjGXaObHNd2i/fAjpdjuDVwwyuNkmnD5VYByHTY1
	 eAij/3R+8F+EHwjxyehUfN+xeLCkoLMyQQfwVYYkC4gv/2EHr641hdyvZ5ksb41h2Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KKah/PfX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4A60A2610
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKah/PfX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF5E1F000C6;
	Fri, 20 Nov 2026 04:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150143;
	bh=xjtdU2uUnJwxlO9x+uPgGac4rtNrLfazd766UYBm5kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKah/PfXjk5c0cI5pq2YidcxJpjDkwWibApMT8nYb+KrnVMwFZJCraqV2Ol3+2gDQ
	 yecLugKKJ5VnrizAaOJ/4o3Ai9AlQQBaMmicZzSs8aMp44nhK4KixXls2b4vatG5YC
	 QGs5yXEo4PDRW8733AuJqGtYc/LmI9el/KzFS3ZtIZOA5yA+riZ1dLCXHkbJ24cRXV
	 UVsjzIHJ5AAWE7cVVECW+CXyBkZYIM0OTPx4DhWYKIPXcj8c8aWhrgF85+WQaky7e4
	 2NmhxXQ02fa2/+obyi4MSwyTljuQBV/zOzptwLy2E5oKfNm946qod88pBd+WsvcUxx
	 DTZ0D3IK6O4QA==
Message-ID: <sashiko-outbox-224472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] gpu: nova-core: gsp: fix resume_gsp_rm()'s error
 messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-6-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-6-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:49:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> resume_gsp_rm()'s error messages have two problems:
>=20
> * Both messages open with "Sequencer:", which assumes that the function
>   knows which code is calling it, and that that will never change. This
>   kind of tight coupling is almost never desirable in well-structured
>   code.
>=20
> * One message prints the SEC2 mailbox value in decimal. That needlessly
>   complicates looking up the error code, given that Open RM documents
>   those values in hex.
>=20
> Remove the sequencer's name from both messages and name the GSP-RM
> resume instead, and print the SEC2 mailbox value in hexadecimal.
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D5

