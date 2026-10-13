Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283594FD791
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898087; cv=none; b=Hty0d38UWrnJ7pp2p2PDEb4/5otvZ428bUSp04WRfxZ+JPU9DvJj/iO3MD2AKVRpOsQjuiycqnmkaZOhm9AkfHG95zMkWo5ZRx4GzpuDkd/iYrMyarNg04j0uSwdPxKdgVbZS8pwcn8MDvZUiz1o52tOsRl/yiPpTN3sIUzhL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898087; c=relaxed/simple;
	bh=uph7vRYjjPvZlVlW86foSU3hVWfz3Iqs2d357E8+1Ic=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Vci7EQ2e1JHAneP4bUhmtm80aUKOdHmaGt14uK5Hj+t1VVDXmhKuO7nGz15VzuzMXk86C9g8f3JLskqqRZkXtPApOUDzhdrtj+W4/enSet8mFvzCUn5yXihyVIDmgGeHtmqzbTHcEn/S/YM136vkhq1CH2+jXhxa6HV94+jl3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAiiSKw2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAiiSKw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74FB1F000FF;
	Tue, 13 Oct 2026 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898085;
	bh=NIvuQWfCe0GX4OI6Qu/4f29jwlxzc3/lDiJdNGdo7Z0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BAiiSKw2SN30/n7zWbYeVViXtHuWee1+a0cgyD/So/haRdfPhuOBOtCbKRejnkMMD
	 xnT0EZmjJSSREXs65EIvfFfx9oKGtpkeqRKFbtSPfxblcZXmmGetN3yBu0mv0NUVgn
	 CPM7na078pJXk5ichuBleK6ukwbVV4c7cp7bLnSLIUtw7RvxUR0tejVB1gMZFH14Ut
	 8R9Ynh8Y0Stm2y7jBj3jPFQ3VYdZ+D+LiMpgxWlOUdfcc5oAnlOnDbCNvIc1l5CAtG
	 g8xvaw6U9d/zZmfaf6lHuIb7DeIUejPtKfYWKNqt7JA7EgcaQhULq7z0xoVyqUjndG
	 9xao1rtWHnVPA==
Message-ID: <sashiko-outbox-169814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] resource: Mark free space assigned
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261013130948.6231-2-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:28:05 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] resource: incomplete fix for %pR format on candidate resource
--

commit 094e97a90a5417acb103a184b0b1c36691f9e6c3
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

resource: Mark free space assigned

This commit clears the IORESOURCE_UNSET flag from the free space indicator
resource (full_avail). This prevents the flag from hampering the printing
of the resource with the %pR format specifier.

> diff --git a/kernel/resource.c b/kernel/resource.c
> index e60539a55541d..17e7fccd859cb 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -731,6 +731,7 @@ static int __find_resource_space(struct resource *roo=
t, struct resource *old,
>  	resource_alignf alignf =3D constraint->alignf;
> =20
>  	full_avail.start =3D root->start;
> +	full_avail.flags &=3D ~IORESOURCE_UNSET;

[Severity: Low]
Is this fix incomplete?

Later in __find_resource_space(), the candidate resource 'avail' inherits
flags from the unassigned resource 'new':

kernel/resource.c:__find_resource_space() {
    ...
		/* Check for overflow after ALIGN() */
		avail.start =3D ALIGN(full_avail.start, constraint->align);
		avail.end =3D full_avail.end;
		avail.flags =3D new->flags;
    ...
}

Because 'new->flags' still has IORESOURCE_UNSET set, 'avail' inherits it.
When 'avail' is passed to alignf callbacks (such as pcibios_align_resource
in arch/parisc/kernel/pci.c), any %pR debug prints of this candidate
resource will incorrectly format it as a size rather than revealing the
candidate address range.

Does IORESOURCE_UNSET need to be cleared for 'avail.flags' as well to
fully resolve this %pR formatting issue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130948.6231=
-1-ilpo.jarvinen@linux.intel.com?part=3D1
