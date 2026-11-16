Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822426;
	b=M/sfRNGmvgSz1EIk9ilQTfTkY7orphnvjbDKWR+m6dNmEO2FAdC1eP2ft+Ob5YLGPOm7
	 bcjdhGwD5WKiwEyxxw2jITA4atpYNTekNUEzKarKFu6RShRiLyndNzuwfXDYc1+vMkGOd
	 WHYQdNoUEsYCU/IZ7vVAiswa8ucy078YYd4fedJCMPIVeiRMicBuuwY7uSMUcvHRnu0aJ
	 U7n4r6PoR9b6Fdj1kHwSoRzP6UpVwNyYHaHQk6GzJZJZfOAaTpZfMrbpuiCkpiYnm9iCS
	 FFm8jg2VT5q47KHgK9uNta0N2/+d1jfZ8KUrwfBEvcVNf5KVX5wrAO5M2e+WRS5HqwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oo1D+MIaa73lW7QLuOAbYyt/hbdCV+tuQDGtoiF97O4=;
	b=pXxWusZqZ6bmBCMfVv+Pnl4YhoygKmqOuR6ZrMvnnBPuAfeAzblwkEW4pFH9ymZX+Eis
	 2jGdWeM1bWyWnd7ExcMQRMn68QlpU1u0DK467BP7o3zT9MPk/EewKa9dZglwtoVvRiMqW
	 pQa7sb51Dj5C+qOQoRi0rFFYvs+OGtymzt8gv6FbadHan6c6vSPkKLNO60Hcqr1JfvS99
	 sKalq4v20DfT4YK4cPMK62UNxY7hVJGl/tXjl2nNcORdIMVVh8G8RxfereUVabrR9s7Ip
	 gRfMQt0F6cdZncYHYdxHNLP3Z3c/P3ODtuFUF+q/cV6B74rgW368xvzXU/7cm0RJGPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTjFQs8t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B4606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTjFQs8t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922771F000C4;
	Mon, 16 Nov 2026 09:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822426;
	bh=oo1D+MIaa73lW7QLuOAbYyt/hbdCV+tuQDGtoiF97O4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTjFQs8tc4SrrZcRSwxsRbdTAAo6zYzycGTpUvqDH48nwKe4jPGjMT7+KSAa5WUH1
	 i0GdjWRYOZ6Klf8yqI91txpC3l3pP19PShcm3ZYC7FS2Pefgvtu79T5CgcukifAFWi
	 WfQBuNTUtocwkuLFGrG8lh8JMz4gXV8/nMYIDExGpeN/eJ6R0d2MLDE6xUJNY/8HtG
	 HDEvn1kYZ+xuaXJ80HntjSSbxyc/zdPRhsiNDYXbfczlmzVpr4e2EOI5DgssfooJNs
	 RLWpar7V6y9UqwHB8yzXimncu/I3Hv8Tq4+jYR0D+dYkfm8aW+mNc52K8lu4zF891X
	 oWpoSqPbPQrsw==
Message-ID: <sashiko-outbox-216636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 2/6] arm64: Allow synchronous abort fixups for
 guarded MMIO reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116-rfc-b4-v3-2-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
 <20261116-rfc-b4-v3-2-0bf052b68f2a@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:47:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Matt Thompson <matt@boondocker.io>
>=20
> An RK3399 PCI configuration read can raise a synchronous external data
> abort if it does not get a usable response. Allow an explicitly annotated
> MMIO load to return an error in this case.
>=20
> Match only a current-EL synchronous external abort on a read instruction
> with the new exception table type. Keep existing handling for other
> faults, including asynchronous SError and translation table walk aborts.
>=20
> Signed-off-by: Matt Thompson <matt@boondocker.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rfc-b4-v3-=
0-0bf052b68f2a@boondocker.io?part=3D2

