Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150363;
	b=aTK0BH6vduIROabt5f9KHpBcK7DYjEuj4FDg6A0yn1RStLILyCVHmeg0rlyMqP7xpYNg
	 iPXuTYYyEfRn5SuOZfvUtQhLJ2ESqZ3OjO4selLpwA4qEOGyxxxLEDfk+Yd+e/PoNh+oG
	 5LwjhnZLb2Q8p6CFDnq68hfxFAE8wkmaYcIiCm0VJc+XeRzhd873n1TeObTlmStduSD+4
	 67shm6HMoqHtJEkPs4vnNEUiGDoM00wFaPYt/Xef0+Y6GaL5NxQWT4tfk2pYSpHC5DWwK
	 T8hIUjiYwGRmEVunVVAjYnbhfUZ6Kk5OLKzJAQOBqEJwF14zbIdrOH2zImJejC8xWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150363;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ktg8roDGX5/n6Cso3yUbpOcxSA4s8Jf18u24HUu0Kd0=;
	b=KWZgZ2Dj29m0CwQw6z/o4v7bRpnFs7W5hxQnR9fHXMh6ZSNidiJ/HYqgWwYAUOu4bluj
	 CC4YQPs93O0AoulmhP+nwdoxWdmDluML8wBbOUoep71tWSpz1eoG/gq6KK9FakDpCOYQ1
	 u7+M2Ul1APCY5SE7GoFYA6lfmkNJgymEEal3Q62ZyIs/fn4n86YGLNt8NXkGtxQY2erpE
	 D6vMWCHAnozMqRW1qBXpifYppaQ/MXTjptYwD6UeQHL0DKX8gCXKQGWpapww3zV7RniC5
	 WXBofCmtjyAmt0GgzzTv3ytLcAXs1g+Ohlz9kLUMBM/4DRP+NL89kQkHdZ/PLqJSnzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZEMOzR7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F760A2601
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZEMOzR7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A81F000CF;
	Fri, 20 Nov 2026 04:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150363;
	bh=Ktg8roDGX5/n6Cso3yUbpOcxSA4s8Jf18u24HUu0Kd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZEMOzR7kVGFPW9ej+8ciIk/5hJwLiE0s/qTpCDbMqAKRHmAfb8g3LWx5F0I9cdr1
	 JWkpdu2yTpEvYvRsM+kYOm9QivClzTSvDVekoPgFykAmslhKyvJSNGWe8WSU+VDs+O
	 0xIgbs93A1ZjpXWWleHk7lemMFjyt7/LPJu2y0aQGkAR0Qzjal65Z9DFDIsRbzg1PU
	 ioVIn9UNOFeY7/gihUEDw4oHoye9QP7HHErBNDHR8aqAuLzBPGcnC6TCPqgiQGs7Rz
	 r5/MI5f5b98hCD7PJztT1pqKr6LVxNswiQW6jzMkOdjB2C0Z9Ohd6QDpAHaHK92kc2
	 q6IEx4r0/qkIw==
Message-ID: <sashiko-outbox-224478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] gpu: nova-core: gsp: add the r000 load-and-execute
 bootloader handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-9-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-9-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:52:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On Turing and GA100, the r000 GSP-RM requires an image to run on the
> falcon core during boot, through the generic falcon bootloader. GSP-RM
> is suspended while the image runs.
>=20
> The driver runs the image on behalf of GSP-RM, in the following steps:
>=20
> 1. GSP-RM raises a load-and-execute event, which carries a descriptor of
>    the image.
> 2. GSP-RM suspends the RISC-V core.
> 3. The driver waits until the RISC-V core is suspended.
> 4. The driver resets the GSP falcon, which selects the falcon core.
> 5. The driver loads the bootloader and the descriptor into the GSP
>    falcon.
> 6. The driver starts the bootloader, which loads the image and starts
>    it.
> 7. The driver waits for the falcon core to halt.
> 8. The driver resumes GSP-RM on the RISC-V core.
>=20
> Nova-core has no handler for the bootloader's load-and-execute event.
>=20
> Add the handler, which performs steps 3 through 8.
>=20
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D8

