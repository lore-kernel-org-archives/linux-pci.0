Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977809;
	b=qcsrEQd/Hhw0Ths0v1TOT91CoFyBEMMxdJNLZ8AgakNmJpuohLx5SmuoDAFrm3hnkWJ0
	 0emeQIi5/v+Ee/05Y1FhL4rj3ca0X7iHMtNTkCm4nIUynBdoq9jr77de+xEkyaOCjCVw9
	 157/n4tMyZUy7ziLYDSl70Yu+jvsi+CVerc1ewmplqoouhVBJ81zraPVreyOl1cVI/lwK
	 9w533P5g4cAispQXUEOcsoh6JW+HxE9ZG3VMy/1JTeeWHmRGntR8IAbfTGBsovrxNS3QJ
	 bzXYU6zBC1hbrCumRzaFILLkvTFZ3G7+0OlWTuSJnmPac0fliPJ0xd8W5zupHzA/y0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+UYsR6JOxgnWEjHSjz9AzzVeDvaylcpV9GTRsMOdosI=;
	b=SZ2vRPDhfTJ8PuxcK3lDULIwJM/qhSBcn6LYlogKDIo7Z/NxfVyEvuSC42L9EJRV0yEV
	 4TuyHoA9mYAflZ0GnrWcJnvNz+0TFOTt6oUOFrqmgOwOPwaGgd6Gv/nWNeLJmN3hGvNYj
	 ltjvhvDUV1MfLoNXn6mTSRgdvdZGQSuyYDtODLKpa/Yjy++GrpKpAi7mMWWtzd9blW8E9
	 WAX7o5yGwIERdVcA8gTAX8bj0A+q1AeQBfHT7/vauhEc8jx4YjUwx0wS6MUe4Jfy16Kqz
	 NeUVQCIwItn5FTYmvTcZH8KBLhVXbtL6IXKwS74OFT45kDzr0+yLSl1JKs1ONqtZVcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3d14xAO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D4606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3d14xAO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801921F0089F;
	Fri,  6 Nov 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977808;
	bh=+UYsR6JOxgnWEjHSjz9AzzVeDvaylcpV9GTRsMOdosI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=P3d14xAOGCC/7psmyklZRek03pHDTQF0I7opWb5i82SCLw94vXGnFk9StSc4GXuyr
	 KyrS4Dm/H2kMDKTzUDrWnzjDL8RBnUN70x/OnZUE1BSxj/0K6/jFAMVrCobDndfhDv
	 /5c4gsAor5MTl5VQFsq8d4FaRiRzcFHD1io9IsFNlaaAUrDJokxwI+NP3/X63ox5nD
	 xVQDfAYifuLyYECsznbEkXZKJm5BhLLttMnySnTZ9/N2NJpcIpYzSdPDts6wYEQ2TE
	 XLU/0Wo/yUMz6FB+WpB6mH434JWIhHO90y3oh4km2zFXu2IXWhKf7lB1qrQHLRWXJO
	 8hPaFUC7vZ2XA==
Message-ID: <sashiko-outbox-201648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/14] PCI: Move size/align calculation fully into
 __pbus_size_mem()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-13-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:10:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move entire size and alignment calculation into __pbus_size_mem()
> further simplifying the caller side code.
>=20
> Also fold calculate_memsize() into __pbus_size_mem() as it has become
> too simple to justify a separate function.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D12

