Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8757F750;
	Wed, 23 Sep 2026 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194780; cv=none; b=rXQ3Cb+Y++lWpP123nEW6ijFo+DGCpqGWSPjNcT26YMV2PVeRGZmKYC0DtCGCu7ZECHaj7ZOPr76u3t7U545IIVp+X57s34j2JImpFSmuMZTs0zlDdR1Ilp7qhKgB3SXztPJ1quDQYvKCAUAzKVFXouhejvWOCr3NGMhDww45qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194780; c=relaxed/simple;
	bh=kbaAVsswovOLEpJu+OJl0wA2plSv8SGCnpu7N1ohCwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BdmpKHishyk+Eqf5AUp+cqOsuziy6QxhBb3DLWSyhncVRAFFIozllUHd0hzdevmv3GhPeBB93K1w9yhfq37CDibHhjrcGVPxBLlasdplHdqAr73ZtYFbN9iE4AetlUKs0TWC/yunT33+Ag8JPViT8ezGXmjdhHcAeu4S54dY6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc96QiH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc96QiH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2226C1F000FF;
	Wed, 23 Sep 2026 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194771;
	bh=kbaAVsswovOLEpJu+OJl0wA2plSv8SGCnpu7N1ohCwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oc96QiH4SmfPULUGYmmEgCBm/dfziGabKY32OZcp1amFIdHVpiVHO9SVbck8LaoiS
	 qK85ZNM9eG/VglT0+5AH4EZE3qNMgU+61WP2Qf0NP67oLYbdbou3cEsfQdISJZx105
	 bJ70UjleFFJyybRpOwKRgCD7CDo5UxDQMmNqD8epVHdcPfyv/QTu5nuNS3GhnQvfCU
	 qJ7TFgWo1oiE9ThQYP6diJC0OOzJa9olJapQXl5hIG3ZH4T/2vgXSjwhZTB7iosOvd
	 EtMEC86/dVgOBFxrWzta2Fjt4m3BUW7Vukf1fh3Y7siDgsWgZptvCvIXUvaucNaqE8
	 tjy8+QkobcWwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/17] iommu: Convert gdev->blocked from bool to enum
 blocked_reason
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <2ddf8915a71e171104b537afcc93b3aa3d9dc45d.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <2ddf8915a71e171104b537afcc93b3aa3d9dc45d.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:19:30 +0000
Message-Id: <20260923201931.2226C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The gdev->blocked flag tracks whether a device is individually being held
> in the group->blocking_domain while group->domain is retained. Up to now,
> a PCI reset in flight is the only producer, so a bool suffices.
>=20
> Subsequent changes will add more reasons to keep a device blocked, e.g. a
> failed-reset case that must not auto-unblock, or a driver-side quarantine
> for a hardware fault. These reasons are cleared by different events, which
> a single bool cannot encode.
>=20
> Convert the "bool blocked" into "enum blocked_reason blocked", provisioned
> with two initial values: BLOCKED_NONE and BLOCKED_RESETTING, covering the
> existing use cases. All readers keep the "if (gdev->blocked)" form, since
> BLOCKED_NONE =3D=3D 0.
>=20
> This is a pure type change with no behavior change. Follow-on changes will
> add new enum values along with their producers.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D3

