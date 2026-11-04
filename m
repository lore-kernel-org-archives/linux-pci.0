Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812798;
	b=Y/Xp+3xVsxeFBKmN3bfLRbye4kk1C28u8xLaFNosNyBYPHK2SAh2rzxyXFVvo3Zgpj/a
	 AJnq8TOP772xQjdht+nMMJX5E1D55mWY5YdUkSiySSlWqejwis2weU3Ch/SfYwBFng2yU
	 qgMLB8G9p/24MopuLS9g++6sUtsT4VWtAzaaIv/3cT7Tvd76AtNrT6AzLamx1hGH0CxrL
	 CpIIlAuhXk9wBH1n4X/0Kdbtb4RtZVHymxub8dNJEz/lJvdPEAVCtsOGKrp0CNU2yAz8q
	 rGandLQcUCdjCNFCTuxQmED9+td3tKcjoUEngee//CyFrxqp+CI0WmHpgH31oMu6Llg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VOKY2UB6wb1Zk5b8zHOmeLGKcXN/7GVQdcqCNAdb0pk=;
	b=os+jZRzc6TgDyCjSN3MewnPFqnklNEuepzIug4kd6Uq51z+3EzZ9Laue28XcKUI0n058
	 NGbfDHiMkMOfJBFhde+TOuG7NCC3DNYcbqZJE+qAkO0O2dIJSQQIS7Vf98dI245aE4HSp
	 rHL6gUkLp1XmdCX3joiqb4uYHNK/d01+LJ+tE5wbjfOg3IrOXkb+9rqHOM24tcLTmfDvV
	 LbvkzN3kpPeTJagvlk47YsBDI8ZA9M4zJs+vUuy/9hoRZBcsoqsCzWHm/Scj0KWJj/O5w
	 plyRdzJnsbrdr5mgupQFPZ1GUj4SkE8anG8QBzB9YxfCoASzlF+01EWBO/mDg8ac2gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K86C4bb8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0739606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K86C4bb8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA551F000C1;
	Wed,  4 Nov 2026 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812797;
	bh=VOKY2UB6wb1Zk5b8zHOmeLGKcXN/7GVQdcqCNAdb0pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K86C4bb8AFcHC1VmH19n45YHjms/jvBKEL1jrC+TSq8GcYMZswLZXCaHErGthJ/GQ
	 1jgXWmpWPm4uGk5lRsaLg/JekSxC8vOLlfQDF15zt/0RVVbHa2SRVU54UwOv1A4csi
	 0KjyRXLapmmIHq1UkQyY51SJbMiefgqrR0St+l6TnGJuK5dDxTr1Vr+x7RC0iC9iFC
	 UDOaIZ3VDiWGbha9sV17u1dGCv4OSexth1HoeKahJiX+qeHiTFoi9MOl8N0FdUVElF
	 D/4LEozl4GGXZ6K0Lsl4EY6Rd5DjhR7Bil+v8JBdJuG/F7RIaHAZZptKhk/GDs8kgz
	 R9obzi6OzSD5Q==
Message-ID: <sashiko-outbox-197752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-13-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-13-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 17:19:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> In confidential-computing configurations, a vIOMMU may be implemented by
> a TEE Security Manager rather than by the physical IOMMU driver. Such an
> implementation also needs the TSM identity when creating and validating
> vdevices.
>=20
> Allow VIOMMU_ALLOC to first query the TSM associated with the target PCI
> device for vIOMMU operations. Fall back to the physical IOMMU driver
> when the TSM does not provide operations for the requested vIOMMU type.
>=20
> Resolve the PCI TSM association under pci_tsm_rwsem, pin the module
> providing the operations, and take a TSM device reference. Store the TSM
> device in the vIOMMU and release both references on allocation failure,
> fallback to the physical IOMMU driver, or vIOMMU destruction. Keep the
> module pinned until after dropping the device reference, since the final
> put may release the TSM device.
> [ ... ]
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: iommu@lists.linux.dev
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D12

