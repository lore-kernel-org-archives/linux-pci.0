Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811383;
	b=1mZi3Yxq9tN1G+/R9poZKOsqYZHHj35NUycHnGfWQ4WTM/TOebg4cxbZ4NSwzJVJAx05
	 H+108M66NeknFLduPg/clldzy+85csAJm/idafG8fVQsWuD0iHHfYWoN+0TswWgYT4BuC
	 qhvCTstgjvetfd+wdh3YzU1/IR1DvMtA/PdF/GGr5shZe0VieChqFRaNtRGfma/shEqxI
	 EYfbzv+NMP5ixHg66J2bVjUjtuJpgdqqrrp7n68eODrjCXMFs4QODZyup23sPbVdMitW1
	 ceCfRozNsw/QqdaU0POPcHcH8qaUOy/eBnYFk0vqFe29z+3+N62TCCdUVeOB6W+hoBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G6b+881RRgVTlRgyUD6Zem6u4cGEm20qG8mXos+inEM=;
	b=PjBkT52TzqYa4TFQlDObFcOoF1Ho0nQpyL2ImLVC6YoAZNOceFR4V120H0GtZKhknfQ/
	 16eviNXKDIP8PFoscmmIhjBC31b7O7kErUZ1tcnunj4bYyFfp0VfkZ/1p5E2D1Owz0I2A
	 Uf61W5a1r45922bkJtaV5WulhxOTgd/yn3QVEzFRaMw/ou95CLKug+EdAzZq0Igf7M9kY
	 U9orB7WL9Hjf0Mk5u54CrxTCF3aA7M9oRkKcQpfamL7bmeNp8MlLECEufKUryq6FF1Lfd
	 yq+B8G0PUqiKnAMDOLteWGO9Sxiyb/P6Hmywb6eU8EWiW/WeVyg8OkcCIrSDWAUojag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrrE7YOi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5F606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrrE7YOi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1135E1F00919;
	Wed,  4 Nov 2026 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811383;
	bh=G6b+881RRgVTlRgyUD6Zem6u4cGEm20qG8mXos+inEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrrE7YOibJ5VEcRRfxn7CKEnp37ziObvOIVMwZKFZVdr2kIlB8soYI4sOJbpXbuyK
	 3YCNkvw/fEDcqMC2HMon3wgmpY1axllt3uHhwXmiLujKYhlQ5db6AYbwd8jr9y+jAF
	 F3WZcGIe1hWrMnKHOOABr3Z/FWO5v9N1pd0FSjYFEv3E8faXmqfRryz6/QozuT7il0
	 ayGa6pVXO1to/I8GSczEZX4sS3BkzAhN47vcMADE/2MlgeqZJR+8j6HBY2PdSssZDD
	 nwUNhNxeqvThONSv0hiX/Yx832iYwr1Pt+qqIfPysaUsGFmDYHDu/jldvlE7VzAh2I
	 kgvN+QNvRFUfw==
Message-ID: <sashiko-outbox-197702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/15] PCI/TSM: Remove the legacy guest request
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-10-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-10-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:56:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Guest TSM requests can now be dispatched through the IOMMUFD
> IOMMU_VDEVICE_OP ioctl. Remove the PCI-device-based guest request entry
> point, its scope enum and the corresponding PCI/TSM driver callback.
>=20
>=20
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D9

