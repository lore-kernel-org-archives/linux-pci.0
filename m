Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813132;
	b=eV5TA092wAvP9LXZZvHm/HTjElgIFlK7FM0NQkhtCVdpsof8xUMmdbjueWhISxLt2kOt
	 vkD2roM2JfqSqZ0bj4mvJAjNVht4iNSGC1vJi7pluGK534kCbDxgSEjTXVcLJGhaXlhwJ
	 plCRxWO1Rbwqd6bA1ufMrPGFPeWD3t1NkXueT1Aeu/P+nTMj5+3Sbed2+TxAht98rqgj4
	 PTFEfnAa178dvJvaJlSpfNCTdhYq2Dy+xhZq6Wf97qYSZtHFS+uK45pLD49ynYupvpyh/
	 WSOAL7bGc+eADg5imH6huE997PREK+GuUDbCx3u6EQ4CpPvRe/NXN/yewyiTBuqXS3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813132;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eBPimX1ylcxp6OsWpjQD6PsGgDLC2TgV3+cej3N45ts=;
	b=aIsH4fz6bu3iGh1krHHYdb3a7ZK0UoDpD80gPvyKU2QjGSSVN7vUVOJHjRup+KAj4/Zg
	 kQNtYBDEV1vZMATZOoTZxakcsDUe4B91/sOv+yUq+Ga84zxbc6fkbtOObCB4WgTJzI6j1
	 cps4lkNRBkzW7w1869u1fQHe/3P4yky0CPp7LiCEkwZn1d7bUj2X+Q4TCZRuTTAliFBK1
	 tGmoiZY4PlFoSrSnlIRX9gfzQKe19f6DXLFf8wiHPB82vDdqDEugvNNo/r7upQTJlJ4Xc
	 WhotUGqxC9itBeQ4ZhnAMJI3+IAGQt2y/gPZCwxn7yQQKSKlRNMxNhwC70UGZqQP5zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzEhm+rK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0E606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzEhm+rK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D11D1F000C1;
	Wed,  4 Nov 2026 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813131;
	bh=eBPimX1ylcxp6OsWpjQD6PsGgDLC2TgV3+cej3N45ts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzEhm+rKo5gXPzmKTkKgmwyRio2e28ywV84PyuAdCxPE/zSCHvi6PEoFFoqeUeBPh
	 2G4zbEfqxg6MPFAzFq40rXL38R96r1DQ8wcrefzJJ4Z0CdPTdbYAURmWFytXrJZ7eg
	 E3W7rtjvb0eWLirhhSSqHRD3sd1YPt/vevF4DIH6SLhBykEsbmdEJx5kPxx+L6Hsad
	 3Vg3Px+CJgwPNqwTiBwq2FjFvimlxVM3dc6oQtYfmO1518VLeN9WiOhcWhqoHT/NUl
	 d/YcBHWw2XBp2RKkI7e2fcTJzopheT/+PHvaAo8btZWlAnq8Fa7aH73z6mDbIXMyvz
	 Gu/OJxTrzDHEw==
Message-ID: <sashiko-outbox-197762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-14-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 17:25:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VIOMMU_ALLOC currently requires a nesting parent HWPT_PAGING even when
> the selected vIOMMU implementation has no use for one. This would force
> implementations such as the following Arm Realm vIOMMU to create an
> unused parent.
>=20
> Add IOMMUFD_VIOMMU_NO_HWPT so an implementation can opt out. Require
> hwpt_id to be zero in that case and pass a NULL parent domain to its
> initialization callback. For implementations that require a HWPT, verify
> that the parent supports nesting and its domain belongs to the device's
> physical IOMMU driver before invoking viommu_init().
>=20
> Reject nested domain and hardware queue allocation for a vIOMMU without
> a parent, and document the two allocation modes in the UAPI.
>=20
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D13

