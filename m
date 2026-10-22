Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688618;
	b=DScxw2ZzQaVw0LRNhJMJI3tf8c4N1vX3U3zAgzvZwZu6L1jzcEUzGbZCCrMk7H1t0BaU
	 d+9i1aqhffof/XFhPrVaAaVZtExF2JmUUWXlX6RZLxe34IX8fkXLqau78E0UCW9mL+rlH
	 J8Z22L4GJ31+8Makodi2fg3rJ+/bI7l9QYb9YxSVAUapwaevpoemqOk54PT5o2tLAIS/A
	 DWGB6TE78cSeo26/ViTRSqvQZG4JHS6poU0llC202xeSFKtpblG2la7QyoOutXvRbHh8T
	 r6YJk2evYwkgHzecnrEIk3BFZJP1xfU0c/EqfCnysFg0KuX/wYxAGPvNMNULRw14lTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JrKGO+G7y5FbmXtAJNTF6BY5mxEbr8zNjmTfX0pHq2A=;
	b=LH4pxDxPyx42wZTeB5D8Nz0TYnlsPK/f3avkPFGn3fhesWhxl4TYikXj8PHJdrc+pn2p
	 B10opR+gM35xYrq1CnB29W7j8mhCc9vF0DJDIUcWANWfLHAX3qpYUIJjpq12x2Jm/7kQI
	 pAYAHFJFzl6kAetln6dNGz0xgzPnoPy9iP7/Nuv/OIF4sgV4kih/N2epYh/qPeXo05tTP
	 ZzjQDkwG+llruGYROcd4OZ6CRDnXyGTTRUPCzd/0qaRcVKT3fwOb9lY7fhPSiVV0CFd+8
	 vWEn8ba+B0ZL+YbxFlWNNW/n5rXexEOKcKKmPHQ2XpUxnDHhD32dlxxzBRznPqQSg1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJ2Iyjt5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4ED606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJ2Iyjt5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EA41F01825;
	Thu, 22 Oct 2026 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792688618;
	bh=JrKGO+G7y5FbmXtAJNTF6BY5mxEbr8zNjmTfX0pHq2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJ2Iyjt5l3VRRrgJ5mq6kZNuMOTv2z7gSxpHJUmOqpeM+3nMFsLFtM/jd16eH2uj7
	 hxnOw1jtwjLM379CgP7WRmkB5H6xWFt9ZD2PWen33qNt11QG93TeFjJhds9tq0a60b
	 i86sKO7kzFC8v9kHNwkyICOqb1UF1USmf89rKXyr+6VZssidzEZj6pXV0gV9iOTReg
	 NJeU1FJklZJL1nDUcppky4VjEMll89sffY92VFJP/hTAUX21JCx20hGBnQ2dtOV6G5
	 3zncz94lyG8SADuW9OTj9K1L2ntZ2OuuGZH4AcAYdiyYSJA64WbVMcRlDmK5qRFbk0
	 FV1A8EFYdUtDw==
Message-ID: <sashiko-outbox-181844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: Add pci=nodpc kernel boot option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022165842.1463451-3-yurypm@arista.com>
References: <20261022165842.1463451-1-yurypm@arista.com>
 <20261022165842.1463451-3-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:03:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add pci=3Dnodpc to let Linux opt out of Downstream Port Containment (DPC)
> and Error Disconnect Recover (EDR) support on systems where userspace
> manages PCIe errors.
>=20
> Skip DPC initialization, state operations, hotplug recovery checks, and
> port service registration when disabled. Expose pci_dpc_available() so
> ACPI negotiation and PCIe port service discovery honor the same policy.
> Do not advertise EDR support or request DPC control through _OSC, and
> prevent native-port overrides from reintroducing DPC ownership.
>=20
> Skip EDR notifier installation before the DPC-enabling _DSM call. Merely
> skipping the native DPC driver would allow EDR to enable hardware DPC
> while the handler lacks the capability information needed to recover.
>=20
> The option disables Linux participation in DPC and EDR; it does not turn
> off firmware-owned DPC hardware. AER reporting and recovery remain
> independent and can be controlled with their own boot options.
>=20
> Signed-off-by: Yury Murashka <yurypm@arista.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022165842.1463=
451-1-yurypm@arista.com?part=3D2

