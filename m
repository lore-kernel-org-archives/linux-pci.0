Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688598;
	b=GksYI0Rc3liHxYy7pHWQMiSOEbeW6hCt3G7/aNn61r3ck2ayiMEplyawT2h13XfIWqQe
	 DZ25vIMdCL6Mzc4pB9VRBRppDLZFUNZ8eAtfZPMdC0Vnl6I+OwVI6ovvTpykTv8VrMSnX
	 mCNb3xdwkTgHyEtu7Gnf/AcIj7tZzjtKkVmlrfj/QzvrMwuYtjotHvBCHAeqTieQRLH+o
	 2QPGAncDq1DGqpsTERRXnFS69A3zWEQ6HZNlxsHQMdQ1RWPRN5vYWftoz4IRAxzzissb8
	 VKHS/Unm2ZGOeNkJTBGS2j6D0GSI867I4opVdB3HWR6ziljtqwEBJ+gp08+clujBNjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dGNmVcSbAGZAGMbsNK9R8wpzYCAs/uCxM+5ErLwJfzM=;
	b=0cSM0E2WsFIufzGXvgtkGVXa1WsCxekXJ+N3mvgpg+9pwMT5Ic6/+jBKfHNsQtQaUhcq
	 zq/hxwB/l7dbQqTxGy9LuVveHijuzAnZEm1z9L9LzBxIPywcx4HmFQFuSE01Hyh9WgtRQ
	 2NXF11whYgvKh/GOLPzwFI7J6BRXMggRDcRPyrbjru/5Dsqa17SkLzz3+/+qzS1ts4CYu
	 pMUQqRBIp9vAkqQH0JDPDVRmvXEnvm9OHu/QrW1AfJA7k3FxcEYg1UO7m6YAx3Z0Zd541
	 NlXkhWU2ueHFhNH2+GjvH4/ZehOBVUxcAZ9IIhj5t2DJU/2zK61uZy6VNWnd2AUIinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbGHDmfD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080F606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbGHDmfD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F17E1F01825;
	Thu, 22 Oct 2026 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792688597;
	bh=dGNmVcSbAGZAGMbsNK9R8wpzYCAs/uCxM+5ErLwJfzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbGHDmfD2NuMaAqAeo85HfzOyIg5d36gnzDebzXyfWw/X9/MtpPUJZJzzvmdlMMs2
	 XDfDaV+ugizaSkRsyZRjjZEx61UASNvJ6Rr6F/dPOqMWPV6CH3O51To6O/d4mFovof
	 eRdkxQeY0tJaUAid5NVQ5RLoGVEksBZq9C+QCFNoZcfBHfWfLTsnnxYEHCfE2c7e7F
	 61l4ocGEvDEdsrUcLnhF6xVg24ozs6nfD0CiKOxZ5Nwxi9nuOkN1h+Cl54tUG0XJMe
	 qQe0OabkAWQxmdgNOiTxurH0uoyHwVVn1Dq8ChETK9SRuFA7B2tqw+9ij2Ptq9qnLd
	 h2nJO4jZDCSIw==
Message-ID: <sashiko-outbox-181843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add pci=noaer_recovery kernel boot option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022165842.1463451-2-yurypm@arista.com>
References: <20261022165842.1463451-1-yurypm@arista.com>
 <20261022165842.1463451-2-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:03:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On large modular systems with a complex PCIe topology, allow userspace to
> inspect uncorrectable AER errors before Linux attempts recovery.
>=20
> Add pci=3Dnoaer_recovery to retain AER logging while skipping recovery for
> uncorrectable errors. Check the option before dispatching either CXL RCH
> internal errors or ordinary PCIe errors so CXL driver error callbacks
> cannot bypass it. Also skip recovery for errors reported through GHES,
> while retaining error logging and releasing error buffers and device
> references.
>=20
> Correctable errors continue to be handled normally. Skipping recovery
> avoids its clearing of uncorrectable error status, but does not suppress
> Root Port interrupt acknowledgment or change firmware error handling.
> The option is AER-specific and does not disable DPC recovery.
>=20
> Signed-off-by: Yury Murashka <yurypm@arista.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022165842.1463=
451-1-yurypm@arista.com?part=3D1

