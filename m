Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A374568550
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973023; cv=none; b=gMgFeArKbJnDOrP4477/bmS0hkzJ0GHJBfQ5oE/nC4st+gGswsvAkAWiHE0aVa2dmgh4gi6QFKfQ+JF8k1eP4sXiGxYstg8r7YRw7uJwDcpTx8OYVxvV3UmrxYU/xvgRqVs1NnEzomUU7H5ZA/XLLq+Z0E4DiyUwrTPpYmR1VuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973023; c=relaxed/simple;
	bh=o3O4Th+Wog8c0y6YXUpDS8G6RLAnIuXUbsxl79lo2Lk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eipVAM7AYKETbhNaMb+GOn0YkWLpHTkcJ7fBqGFRtLAJSp1528FzxglYNFe27cKdxyRHNZv85I3Kg7NNxaURRs0G0lH/Zn1vLe+r5KhltVRLYILDT+bEVR/SicWPW/gb84HjkiVcW/+KgVml94qEEfPETUHuaS0b9cZTFaOBpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCjm57dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCjm57dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D191F000FF;
	Wed,  9 Sep 2026 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973021;
	bh=o3O4Th+Wog8c0y6YXUpDS8G6RLAnIuXUbsxl79lo2Lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BCjm57dkhKa6l3I9C+IkZU0OmQltYbUS1YWm1vrH+afSg13Txc/mRO0gAgupN760n
	 EnHMxm1/j69QJSeoDVp7sJHQ60rj3p+dB+i033zSwgoWeN1dk+yHSldB/T1imLhpk6
	 pO06cua5xtsWta9RGpKtId8ymgU1iUJRfKxJf/5Pj+v4K4owfl1L47B2OdhK36nerS
	 VVvjpMFAruPfbdXHowbrdfRZFwHQI6M3oyLl/wgCJZQZShMCIXj/XzX1626B1Z6yu6
	 U2exw3ANTiCCuqNC6R2p80jE58ynODP2MgpGd/2jOIeZjEfTEAShZhdzTS5/yT5U8Q
	 TEkxWYZ1cYKcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4] PCI/MSI: Skip MSI/MSI-X programming while the
 channel is offline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260909164908.2562818-1-vidyas@nvidia.com>
References: <20260825172719.4153402-1-vidyas@nvidia.com>
 <20260909164908.2562818-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:57:01 +0000
Message-Id: <20260909165701.B5D191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The MSI-X Table lives in device MMIO space behind a BAR and the MSI Mask
> register in Configuration Space, so neither is reachable while the Link
> is down. While a Downstream Port has the Link contained by DPC it
> completes these accesses with Unsupported Request, and reads return all
> ones.
>=20
> If the upstream Root Port implements the RP Extensions for DPC, it
> additionally reports that UR completion as an RP PIO error and triggers a
> second containment event, this time at the Root Port, which contains
> every device below it. So a contained Link on one Downstream Port turns
> into a far wider outage that takes down unrelated devices.
>=20
> pci_free_irq_vectors() is called from driver error_detected() and
> prepare-for-reset callbacks, i.e. while the Link is contained and before
> the reset and the pci_restore_state() that follows it, and it masks every
> [ ... ]
>=20
> This does not attempt to make every Configuration Space access safe
> while the Link is contained.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909164908.2562=
818-1-vidyas@nvidia.com?part=3D1

