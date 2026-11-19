Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083243;
	b=lI4PTfiDND3uYjHn/wYJfZN9QE9pRUt3Wy16K2/2qfbfg9DnotKs9ILc2dWoQnvGLu1J
	 7+y9GadLurh1YdK0R7E7zphSxG205ywmlDNzVVKhA9WhDe3CU92pg5Kr4OpWNIrkSlzoz
	 npqbsVBNazDzPi/mlD+j7XwhskaN1k7YQ/mq9paIiQOehqvbNP1b3SYgtIZFZdZRaqPHh
	 UY8icEd5furE7QzOVKor3vCask5w4nClzPcsxSCE4wdwTlrOKqVHT9k2d+2CkZI6DjMVU
	 XXDHYIOViDVWfTTP6hCc3vslfC4ca6WZXlnRHvjSTk9EWZiX29peYvfu+dw43QOKnxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YppUFCBduvzQLsptwdHs58Tjt4wr98dbaczTJDd3eJk=;
	b=311fThYokV27Y7eoxA2ZbgWQWcL/QLPJFZJqzIv5MYAnWS+mD55D45VZPjzKJl1hLQR9
	 38frxPa0VZnsrgRdILqoYur4fAS4LDcVdes6ToXR3CnHOg5vmyjSY6sZX/oATfrrTiBlW
	 Xwi/v30r3gLUG360of1q535hhx26l8TcnjsUEoifUj9zz7p6Unutgawq0Uh+yeRltEfBf
	 nCIeuET2BmyyMo6xtekSJFuzCbtMr1RQ4HY3iwThMCO0pvF3VOZ+VZ+C3ZLoVpOMmCnKw
	 qFSr9kbnu53i7JqskRmbtoEzxEceE0DfjHpDCqmagHive0PVM9WPLkLsrbwv1MCVtzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1h48O5L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3567606A334
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1h48O5L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719751F000CF;
	Thu, 19 Nov 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083243;
	bh=YppUFCBduvzQLsptwdHs58Tjt4wr98dbaczTJDd3eJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F1h48O5L4/EcQDnpNCOUOlIgVP4XAfDkSyJzkozuNn2wNQEm6kBm4y0qx2meIgiz7
	 dYtrm43odt457VvG9p8kGii/6UZnHqASG4hYt+qTBVxHTDhD8JqlevKkjgCuP3ouPl
	 sMVdI8tIetKWDG4OZ98hJgIsTDFfn3RIPc5YQHzK4IQH3eUZHicXAvq6VKUPH/8FNk
	 KgdLLTgkFDAo+AL44dxeK64C+rCex1oHcIVvm8/7gBcnH/RryePmEOxsUHEzPQ2NOk
	 2GbIu+00ssCKTtnkk6AS3wjk+oKQCZNQK8+wQq7KkesQF72fckE714xly30C2/QHhw
	 P/N+tZulliqrg==
Message-ID: <sashiko-outbox-222928@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 2/4] PCI: Don't run IOMMU reset hooks when only
 probing reset methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119100628.1948990-3-vidyas@nvidia.com>
References: <20261119100628.1948990-1-vidyas@nvidia.com>
 <20261119100628.1948990-3-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:14:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_reset_bus_function() and __pci_dev_specific_reset() call
> pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done() even when
> "probe" is set and no reset follows.  The other reset methods that use
> these hooks, pcie_flr(), pci_af_flr(), pci_pm_reset() and
> pci_dev_acpi_reset(), only call them when actually resetting.
>=20
> Reset methods are probed at enumeration, before the IOMMU is set up, but
> also whenever "reset_method" is written in sysfs.  For an ATS-capable
> device behind an IOMMU, each such probe of "bus" or of a device-specific
> reset attaches the blocking domain and then re-attaches the device's
> domains.  That blocks any DMA in the window and, on arm-smmu-v3, sends
> ATC invalidations, even while a driver is bound and using the device.
>=20
> Return before the IOMMU hooks when probing, as the other reset methods
> do.
>=20
> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a de=
vice")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119100628.1948=
990-2-vidyas@nvidia.com?part=3D2

