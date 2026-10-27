Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079502;
	b=gf5vxSFxVlQ/wDcbQ0WCO5oOSqjaJpb5ilm+oZFuzQJpMPPHCqYfLqn3wYLJiIHXfj8p
	 7B3HkS6QCUi1wTz2r4ABjvdaxC1eHCwOaxWBJfIhDSSBJ9fZ9u+ixO6dfc0mnoyYArsOf
	 pkc+FR9/Wzj5m6ipGv8Ict6iio75d+1WjXRNbBI8NVz+zWnUwI8j0eo0EwNWY1Y3ha7/1
	 J9XrNT2nPiQ4eRIPiu9raB4N9wiPB1Ae8YCMHFFK1ZaPZqMFdyC0MZKOtKxP0M7KI2clh
	 wc/3X049VCsa0sKk6rWzpei8YI6fWsyt7yE2lFK+VbZqO0q7FezrM812CTw2E6zFM6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079502;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OMn0e6mLxSvWOJRxaD3ZZKXCZlyKr0rVV6iZd4my0d0=;
	b=zNPzoy6ecOy8M0+woyuHM82+1XsIcynF6oIRW9eaSplNQgZGSkkyy41v/ua0tyiB2l0P
	 WVgmNbQcVHSjl+Ibaxf0+06r4B4Zi44lshTm0FnxAomV97BWw1EqzR+Np+yNNORC4q2eA
	 74Yepyase0+084gs0GGZKKu9tPL9/3U1EJkLwz4ob5zsI7T2AMFRXMqRr3dorQegtb5gC
	 hLg3m4k2vggU7LdjZ+HLOf5sIa3X+NCKU9UPlDWUHYQff8Ec9l0m/zKM2iquIG01v6w59
	 4W7FYOW2kIKt6YoHmww1VWV1eSWZBpCHqLenlt/Uz4bSY2f0hezRDITbp6OkV2OpmvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mT7n+Ekz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D22606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mT7n+Ekz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B031F01825;
	Tue, 27 Oct 2026 05:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079501;
	bh=OMn0e6mLxSvWOJRxaD3ZZKXCZlyKr0rVV6iZd4my0d0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mT7n+Ekz0TwKArBYsFpyNIoGyVma8J53L/FbCVeXwVe4S6sTGqr/Rp689pibSgubl
	 wxUtYiIZu6VVu8cpgaZsgh4OR1p0+D9e1ELRyjgulsie4+Mviges2M3Py6ERWJjTrx
	 JQLcfP7/6XZvWRHXlNEN8/FoocjqutwovIdt5KHDzuuH3mBEG3+1Iiqt/L7jbzSwcx
	 DyAiggMrHTym7Y0dL6WwzdSipU4vYS4hAPYXMItYPCD8CpBhmPY0tnXCwAm8rFDLLs
	 1OTyv7BGVEcnS96jQ0Hn0y/MU98DxoGJCdf9APsGlFuLSL4CDhgbAD55d1GyiKsPec
	 uqEjCT17nRDJA==
Message-ID: <sashiko-outbox-186130@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/23] lib: rspdm: Support SPDM get_digests
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-19-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-19-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:38:20 +0000
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
> Support the GET_DIGESTS SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D18

