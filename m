Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F213BD629
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719277; cv=none; b=HS+EsGpBzWtel9JdQ3n1HDJT1j9RUPSQQToZVfFzmB++d5ztdAyzcCAMsrK/I+QARgKPyWAI6k8dMqolpEIODdFj8U+NTGxjxNVKufa4vh5I+vHAglO+IziUrVFRt/Me0tZ6cCztBzzwl6or2qr1He4ptv5H5SeBSZGsNqcQbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719277; c=relaxed/simple;
	bh=VYchGGTWia9iXsabDfYNB1AFcSJVbp8JNuSeTtgEI4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVklO7dlRaxXxE02p1yVfW/v9K72YbZFUA7FYdDClqvw6Z/kw55PSOPMP0HBf2NQHBTlqjkep/Sl4C6Y2ziN2q8HanvNKQdaTmq2kaZw2UL4r4Qo22gQ0uGT7S43faGg3zZPTuW8ZdjvzlPMr+YMBPimQ6lkOJRqNs7b9VGphfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD6mysH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD6mysH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA631F000E9;
	Fri, 10 Jul 2026 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719275;
	bh=VYchGGTWia9iXsabDfYNB1AFcSJVbp8JNuSeTtgEI4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dD6mysH6H0GIK5kQ0G1dQAAkungBr/Yr67L4559CE06/RKEviyRA7dyeRC1ePonXn
	 koAQEIU6s+NHrC95CU2wS0q5nMecAVeA22BI+LUe55VD1iSYYH8TR79TmQ+gXNUtDz
	 3pwTFttZ93MkwktHjm7POBaAMgLbcTKiDR190ikH8o3ihq9M3s/UoNqouiVdrRnieR
	 IQWLyYUW3nZ/qozRhCei/XJ5csTy/5McINdGSTkWniJsu09S6e9cotoiFPaMhH5nxe
	 Bd89MXthQXMvMc8JTzFO7+xpwx4S+n8tDye0TnlWuBzy6uo4qZpf8kqDKD2TR1ARB3
	 XVFhaBcmAefBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-9-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:34:35 +0000
Message-Id: <20260710213435.BAA631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Inherit Access Control Services (ACS) flags on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>=20
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change across
> a Live Update for preserved devices, as changing ACS configurations can
> split or merge IOMMU groups.
>=20
> Cache the inherited ACS controls established by the previous kernel in
> struct pci_dev so that ACS controls do not change after a reset
> (pci_restore_state() calls pci_enable_acs()).
>=20
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D8

