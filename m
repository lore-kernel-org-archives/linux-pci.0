Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A83E49EB
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399707; cv=none; b=RKRfXLmuS/V3cWPJc6Zx4bvxzl4JnBIXQNKxkWYA6nzjXQIcDWkP8qaFKVMtm/szI1S8wroFMRl2fmm286ie0233jZOQwdQAr4vzfxDvEWRHYMLwb5IU/RlO16k8LFCCSsjcKV+0kPtB4h9cKMLfhPz4ydsSdhcygUK85F/DOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399707; c=relaxed/simple;
	bh=iuaFfe63aS3uJZzko6mO4XSaIIQhX6aWt2G0+hR+G4c=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=abEwvNwkIB2jl/tgW/NvcdrcaMygaFEpIT6664MRJ1ORlgzE+rw8W2+Zb1/D1pXO3Q6C5SJYHtPiRjIZFSRxVRL+Jzny9yGchlOH//EwSeokL8k2O/MS01IgTwxjOUAXFICpm9NWiAqWgGP37bJ0KUun0QFfRHPRuH/8CoNKzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQyFqB66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQyFqB66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CA41F000C4;
	Mon, 19 Oct 2026 08:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399706;
	bh=iuaFfe63aS3uJZzko6mO4XSaIIQhX6aWt2G0+hR+G4c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RQyFqB66hiypIbno6uetitKyyyO34x+XiuXeLfKWYqMO9rCyIb7rvWxSHPFhQUwRW
	 ncgjqpXNGfK6iGaE6nQKaQWi4OFBuNrfBCHhEBOqCRn3cmVXX8H9nK+Zk9t7q6XVjO
	 WHmL9RoecAWhrcYSuvkJFoCzayG3M4dhan7DM7Exlcr0X3Fq2+ShSTC8SBQrFifVJU
	 XFeO1eeu9/7xH8wl86wWjOL4sy8XeFQL/zDwvQp/DZmEdiyLbe0MP/B9BPg30P+5xB
	 0wdmy8Bpro7J3xKTilayvg7GlX0+VF/Fjq4Yfsq0QvvaaByVE3+2WuU9bAVoT2aeWv
	 QJgBwbVQc/hpw==
Message-ID: <sashiko-outbox-176840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/13] PCI/IOV: Allow bus reset_method for PF with
 VFs enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-9-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-9-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:48:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_parent_bus_reset() accepts a device for secondary bus reset only when
> no other devices are present on that bus.
>=20
> While that makes sense in most cases, it is too strict for SR-IOV. When
> a PF has VFs enabled, those VFs are enumerated on the same bus. That
> causes this check to reject the PF, even though its VFs are in the same
> reset domain and should not block a PF bus reset.
>=20
> Ignore PF-owned VFs in this check, so the bus reset method remains
> available for PFs with VFs enabled.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D8

