Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810403;
	b=dTcWgLiYUe5NZUfxdHqaK5WogAM6UIfgR6Ne3X2uoQtnohYNusy+VWwzSCzyZEtYDj9i
	 GVhWGjJ1TSQfJotQqvvgXmTE5NGROkMyOnaXcRQPCFZVmsZBXMUHGwQLAYhVN/vfVuUo2
	 Ri46mZeLi/OEDhTMy37rZX+eC6ZdceohjmwzLvUPGbokGnecTbJ0yT8dtSA0yAmz/W1GG
	 DDTGxDzebXcItUz3ODQlgxUkaCw16sJnUU2RcDsFp7RdcNyMrcvfS5AoOCPE30kVxiJgO
	 /XH85NYKFvQfZ/V7n9Uo5k4BN41jKub/AXCYouuMEZa+XjNQoR1uy5lq/1Ws9uaazTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JH9c0mp6JUGJlUvdfjxMXnRlR16ee9p8J1aZDJfBSfE=;
	b=4EIMEC1lUbQ7/W+0z0oS97jaGJ8BGW592IwKJxC7k0c9b0HLhn1DIlP+P5ORTrVEgeYK
	 NQ5/mOTqz6nrmTnaZDj80hxXYS7bOMZ/IQIYx0bEmsBAvI0nMfH6iTm0JujuxB5UIUaKQ
	 BoAx2ARnh/jPAGv5wpkPgy2g1ySb0rRcGp92xtl9R+rcK7g4p3dDde+1Ijsy8X1DN9sgF
	 Ft+7hkekyEZdmCoPMAFfGZPekvw4ys8yHWuuAAk2WCZMZAwT2UTrbzuiWgbrZZcZKZhaM
	 OL874ZvIUA2tnPtdBbJCqPB3/p1RcNzHOH7VPnR8mdvULzfxYV/IdvbKoIHKLOZ8hfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMKQxaoZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C6606A333
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMKQxaoZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAB91F00A02;
	Wed,  4 Nov 2026 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810402;
	bh=JH9c0mp6JUGJlUvdfjxMXnRlR16ee9p8J1aZDJfBSfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gMKQxaoZP9MCfmd66UhdzpeTfuNyzQptoOU2tWsASleClGwcmj6GC4JPabx7meRzh
	 5olyOoonNYDtehoWQOoPVHRNZG7G0h4pf00XlZD0OtTWHTV0Vk0bTdrM4/7AWrmSEg
	 qL9vdEbZbRrnt75P0EAt+nmHOmz7uRwJdx6GK2OcWOHXQayuVr7CC9rGNYKZpRK1rs
	 fry5D0b2NT8ERcyy4rPHepLHKOr7oba1KVI5H1KpbUEpJR8oXbzvOTgbfiGiQC4nl9
	 cNGQxXsDhugIw9GvcJJqZzDDcPexzLYsYYnlu1HS89T6nCCtRqrwjZL9jEiTwejtOy
	 0dn5qXKdLuZmQ==
Message-ID: <sashiko-outbox-197639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/15] iommufd/device: Associate KVM file pointer
 with iommufd_device
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-6-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:40:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>=20
> TSM vDevice support needs access to the KVM associated with a VFIO device
> after the device has been bound to iommufd.
>=20
> Extend iommufd_device_bind() to accept the device's KVM file and store it
> in the iommufd_device. The KVM file reference is owned by VFIO and is
> already held for the duration of the device open path.
>=20
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> [nicolinc: fix build error in iommufd_test_mock_domain()]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D5

