Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999826;
	b=L5HQa8CnkC1lXtFsOiCdVMCbt+I7ywp4pJOMuS5jEF3l8nj/gR3gFIxXfudrItNv5Vk9
	 HH7couyVMnE2RpyGD32S6RtdcTAVDAbvdzsOaEFzfrIUwZvmsW0/mymuzJft3TRhxda+m
	 /ueIpwu5SzEO/ODdHIcRfO89nezWYQSdWSoxmo2a51W9wIJQO/ssxv0GEDyrILy5qnGvj
	 7uuIBtE81FjJYnwnCJaD/qf2Q7HGGCe5Q5swK0j9+wTp/7jlPkl1rW3OfDYLYYOMyqQS5
	 sS3dkj3nMf14zKupD2kxWMtKgzYJ9/8Ft/D07XO6wcVw5osSA8PWA3lvgIjcdhY3ASg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999826;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tjFz43rFC8U0aFOPruWEDpiLN6S+/GyMs5V5vbHk7sE=;
	b=1xr3Kk9vWI36E0Wsg3oL/prgdc/6oTY2PmRMNHQRxLSDZZ3JlkkSVDQNFKGf8kEpYuE5
	 lUZh7qnXhlKNeDCNdHyVpIcwboweL5iTRCsZPMBZlSS0Q/lvAX/zzPOL0enJhKMpm6oNg
	 zuzBenEhCHLkyIGnogX4kt3u7Db6Xf45YFF1w4rvzXTILQb9gsoOgQ1Hf6/6Ih9gJ9Dzr
	 b/eozadlYIRy6jWfGndeHCHHiR0Y1HnFJ3Kn9wtXlLz49kKQ8wN0T+4C70bemjlmQGjA0
	 GSq9m3zHh+v6ilwTq/js9o4qbSj6reWsAv+m2K5i4dM/SX9crh55tGwkrNXvFOu8XFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOQMPTfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F646606A325
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOQMPTfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAEB1F000C4;
	Wed, 18 Nov 2026 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999825;
	bh=tjFz43rFC8U0aFOPruWEDpiLN6S+/GyMs5V5vbHk7sE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DOQMPTfCpYRXrfBUkLhpkGelUEOAMsl/iC1U9+z2gcfAzhwc/q+9Hq2vpeRbFdEFI
	 CEKa8NMf/NYLB/sOnVD06Ygam4DEL+li1jRm/0BEzkmXsHVc7rLCYMJFSNTXKKcZX1
	 AmXfndoczX9YKt4ddXxXDe1wgzZlhan9ItRqc6fcviz6h3q1h1ooXlxcrn10P9F+r0
	 Ajj+3lA8bi1sYqTwtrOuTlU0Fx/zm8fXubqe5zq0iRR9Y5IQ8O3MUMAtBI+dovTrzW
	 ulpuIcMBnhIs86/ZFqvl+zBdDOu8J6Yl10cSA7ldyW1k0LO5qSVIYyN1NXUwKmsl1d
	 DsrYgPlj4RSBA==
Message-ID: <sashiko-outbox-220788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] PCI/DPC: Reinstate support for AER-incapable
 ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <58d8a99cc6c2ecba6dadc450ecb4501d47816732.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
 <58d8a99cc6c2ecba6dadc450ecb4501d47816732.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:03:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
>=20
> Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
> ownership") seemingly inadvertently constrained DPC to AER-supporting
> Downstream Ports by inserting a call to pcie_aer_is_native() in
> dpc_probe(), which implicitly checks for presence of an AER capability.
>=20
> Drop the call.  It is superfluous because it duplicates the conditions
> applied by the PCIe port service driver when it decides whether to
> instantiate a DPC port service (see get_port_device_capability()).
> If the conditions are not met, no port service is instantiated and
> dpc_probe() isn't executed.
>=20
> The only difference between the conditions in dpc_probe() and the ones in
> get_port_device_capability() is the check for the AER capability, so by
> removing the checks from dpc_probe(), DPC is supported on AER-incapable
> Downstream Ports again.
>=20
> Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER=
 ownership")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794997749.gi=
t.lukas@wunner.de?part=3D2

