Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187729;
	b=mv0HVw/mIeou5nGB2yl+YuUF1k/8sFIARLBmaN5N8mv/p+5H2EUsgzzKjrAHtt5E8zxp
	 yA4v8Arv7xAGCovAyKcNWJmL8uHN+kS59uF+zY2Kz1cj0M4HWfdx2eQq8XpvqHbOiMNwq
	 noFWjqTabbUVit1fkDUovxwgkXcJJN8652frwExQVwWERMmzFrL/uiFecOpXq3GCjpggU
	 nueXgZKxjIK+UNztKYp0P1lqYB0aIskDnkBCCyPSxboJgg/s03OIxPyvNRKg+CkDPv7e7
	 cg2FSQATlfShGbx/sucLgtEKEAUEDU2RQC4JhJhoRswz9XJ7MbDed9/17eZzb171c4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187729;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pNYtqbmIOkhLCUGC2t6hVZmq0s62cR06bb2LDnLWvOA=;
	b=rlrrOABbx0WGR5BdPuGymXNrxkCR6dM/nAXwQcUUdp0cLAZzdqQX927O0to20d7NTe0n
	 eTwDyqhOonNM4ZdpC3CWBAvtO3vzFvC2fOVqUTHny95C5gUGazegBNvQGUMfvAT3RpRzq
	 cM/+YZP/d6+5alvw8Qd9nz2zkSImdxajHWSjiaG/GMGP/rGZ2TTJx+7e2NrKqEE6jlzFl
	 GIJmSRKbNWxQJfSdONRSNHbUsjZPBqNSA6tFuLdjAm44jZkLWh6HjATIQZKVbjt78CI9q
	 jBK6mIthOQro0DdqnZ4PwwbOiqjfsVce1nWDY7LPCEH9pN0Vx9dtFHip4uAYWncz+EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1o1pJsN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD5606A326
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1o1pJsN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ACD1F031E0;
	Wed, 28 Oct 2026 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187729;
	bh=pNYtqbmIOkhLCUGC2t6hVZmq0s62cR06bb2LDnLWvOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1o1pJsN07PxW5cQ/7CCoUMwy7wlxqWNxo9Urc5kowXedPqa5y8cG96mfKduOS0eD
	 NX3nsqCVcTakwQbovPFFvqLgkN6U/2eF7p/5ubXbZC6TwucOYTqcKOOeWRebSoqt9G
	 34mZuVDViKSqo6Avd6BQyqm0WQ56slX+oRZiRtloFq4Nag1L9ySZt4dHp8ZMFAaZ+2
	 Jm/noD7P7wCahoYZDmgu9d345DTjAV8HTDFnCZ70PLxRhJF9eeX9Ot+9ZkmLO7/647
	 koV2V0S4YcoK9zk+XmcU1TnlVVJhyFALvSJ6oWshDPPy7f5c10GnfRBnKwrtrUxctN
	 ISuWlMDtHtPtQ==
Message-ID: <sashiko-outbox-187830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] PCI: mediatek: Fix integer truncation and handle
 oversized resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028113453.2599-1-sreekuttan2156239@gmail.com>
References: <kfnxuro5xf4mhokabg773zcyp7otcjxwpzcn3dlo6y3kpv4uv4@bne4qf3vcif5>
 <20261028113453.2599-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:42:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> resource_size() returns a resource_size_t, which can be 64-bit on
> 64-bit architectures or 32-bit systems with LPAE/PAE enabled.
> Passing this directly to fls(), which accepts an unsigned int,
> implicitly truncates the upper bits.
>=20
> Furthermore, AHB2PCIE_SIZE() uses a 5-bit mask GENMASK(4, 0). If
> the size order exceeds the range representable by this field,
> higher bits are discarded by the mask. This can leave the hardware
> translation window smaller than the OS resource, causing bus
> errors when accessing BARs in the unmapped upper region.
>=20
> Fix this by using fls64(size) to calculate the size order without
> truncating the resource size, and return -EINVAL if the size order
> exceeds the supported range.
>=20
> [ ... ]
>   sizes and prevent integer truncation.
>   [Subject: PCI: mediatek: Fix integer truncation in fls()
>   for resource size]
>=20
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028113453.2599=
-1-sreekuttan2156239@gmail.com?part=3D1

