Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925381;
	b=lw77rpX5DCx+8OrRGfMRrnrmf9MapET2LupW7DC071DX9qK+QZ9d1qvD8p6NOEzc2Y1d
	 HiQsK805ov/F5BJiKfc0ghAV0wn0v/6XhTlG0E2CXhqCO8njNwQWZaXpBFQeqtbg64uzx
	 EPPUFZ2qyRoSCk8CwvwwV0c0PmW8T3hb7faBzPeVsEA2BzonuK4MMSHzSsWmOvXudxhIb
	 tPamvtn9E4D/caT/CigU994O0espNCOw8ebexsi2aedRMQON1OqZubrvgF2x6z+Yz+uzj
	 Dp/yeqExulgUq9mISElcdWtOJWQotUqpt5bSm1dcAIp8KvsExJD4ZgOoInG7kfwvvfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cEProV1s+3SNUvRxc3GShXX/qImnGN8syobXQUC1bwM=;
	b=DilAEecs0utDcMjcIOLyFKiMd2l79FH/dikLKXp0ECC9cdE4hsD8dfMFc5aLNQBSCpXo
	 WgkCbA20QliHlF6KYFa0NvQ8jcMxQK5EFe9WvXOOMuYnpP5vaBPSyWSYmE0oToICVfKpD
	 0jlIdwe8YwqHzb7YUvYhTGu6CqTDKcqDZbs9HgK6s0l6bJWo5AEFSRL+UOHUOjVs+M+Sh
	 CZFfLw8wXmfBRNQFpo/BHL20P3GLKGfszXfORgkwUkaWOz5cBQPyV6rlY/e1PVvQM41Qx
	 1mj23awk669WN1aU0I+40wyWjTaJgVWzAjQdlqtZmzc0s5NfjY7rnLppW/XDrVmSDIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQbjaLPN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C1606A32C;
	Tue, 17 Nov 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQbjaLPN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E437A1F000C4;
	Tue, 17 Nov 2026 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794925381;
	bh=cEProV1s+3SNUvRxc3GShXX/qImnGN8syobXQUC1bwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQbjaLPN9zdfbQKqq0v8q0TuQUdjsV0Z1kYgwLI7JBLqKNWxGd0VQxiNPQjuoKeo5
	 C2doSE0QZ47mg+zJ7t5/ILFoqlbxEZYAjuVP6LZsAO25pfZD4Cvr66ZcUlrvxWrwBV
	 5aYTU9gi3fk5Qt66q/Iguj2WiZOSXXVZ6BsQm7sPokIZq0dTultT2TmD+6q3kuxJlN
	 m6Kf/GRVpwthnqNKUioktCjW6PxHo/62f7LZNiybdz8kXfSEN5XvJvSFWPpOBg1BJC
	 lz9kkckG0TpWmhi7pH+Bbcc4WNKoRFPqONahyLGgxcAJbyd3VXGisTyAvTNd5PlWMN
	 byu6ImsbN0nKw==
Message-ID: <sashiko-outbox-218955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 3/5] rust: implement `ForeignOwnable` for `Owned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261116-unique-ref-v22-3-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
 <20261116-unique-ref-v22-3-12029383206d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:23:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>=20
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-unique-ref=
-v22-0-12029383206d@kernel.org?part=3D3

