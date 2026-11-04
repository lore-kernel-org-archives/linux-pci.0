Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810788;
	b=yoLfuAhXYBIDH04L++7wVVam0f4+RgFRD6LaPwyiCzTatQTe4WM3UpWK3gk9HMxdzmo9
	 vlDKG78Pq2+yRnBqpxj66h3KL5TFxrp/3bDcscmqxqJGDYhizI0FSMf3Jt72yoPgBG4Tj
	 gjACprNaqo5tt7NWWakHH9iOeZyhMagL545xBCGtuV5fZBmgKfEJdIyCHdw3Xvf/nvEVw
	 7stR2AZH4ga+VBmYwDzBqUDhZW3CRlxSWb3+ocZzoInsGgT4mfoy0fnlzB5VFZhZimnu3
	 UzG/fidLDzB8i0oME+oTAOk0S/OutO3EcJZFZG7mHstMh5RihsO6uOGcCq7KFu588RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810788;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tw1mBLE4E6YzDtOQpbGwaJQIk1ex3UPjZHYUymhDCIk=;
	b=22YersnTEupqLMpdRnnMCyqFSYY1g8sFOiKmH19I11vR9bv/cADRN5kZX/VhugN/CM56
	 bhIie0IGN+FC2B8w0n41akm36KNnKdGtJds07lWi41adbCSaj7rzZi4RerFi5lorG5Wam
	 ecj8t7vzotqLocEUxAIzNz2mHquH9Hago3of2z5we/f/FGkk5OLqe0QQMo8/ejkOQU7Fg
	 S42yA983nWkDotrY89ueDsvFywa2AD4K6ujvwpFnccCZl0qQUf/WXkGjUYu7uu018g8Yz
	 vR6HokfKL5OUkc+14IXpwTxhPYBqduGXjzMExCLoCtWJQEZkVAfHmvDtooJ3RoP5gcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMgR8NwP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEF6082BD1
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMgR8NwP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A2F1F00A18;
	Wed,  4 Nov 2026 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810787;
	bh=Tw1mBLE4E6YzDtOQpbGwaJQIk1ex3UPjZHYUymhDCIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMgR8NwPIsonBmUpmcS34qGIkaSyOo+FNrYdy3PelR8jGUZfBfF2++MnxKS/cpJGF
	 11W2AD2tZzjCP1bN0AuIAEVsquUH3BssH3rxcVdgZC2WN2GGRrk29AIB1+hyA74/La
	 LSTR+veYATeSoffSsddRXddAVUitAm2BFT9TNVf/CM1BaAsDZMLizRTTlPcmCtXbVW
	 993SjKDtp7fkjbFwTofVxEZIloD/Vs0GHSwNwvccSLgl8jtBllNL42atf7Xig2AH8J
	 t88KDX48RgsQc3DMiAaH85vukOiqOEdvYELexyvZvzLg9+Tn5uHdSY25C0Tq1Fgztl
	 GjiaaorddxtBQ==
Message-ID: <sashiko-outbox-197678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/15] iommufd/viommu: Keep a reference to the KVM
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-8-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-8-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:46:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> The TSM vDevice operations need access to the KVM associated with the
> device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
> vIOMMU is allocated, and take a file reference so it remains valid for the
> lifetime of the vIOMMU.
>=20
> Release the reference when the vIOMMU is destroyed.
>=20
> Reject vdevice allocation when the device's KVM association differs from
> the vIOMMU's, including when only one has a KVM association. Allow
> allocation when both associations are NULL.
>=20
> Based on an original patch by
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>=20
> [nicolinc: hold kvm's users_count]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D7

