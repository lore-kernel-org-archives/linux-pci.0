Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BB23B61B;
	Wed, 22 Apr 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861890; cv=none; b=K52DHju8GjYwWOE8pWGqK+w+jLPkITfl6sNzmgOBAjTX0Oc52158cUkIxnRUp20uhx1RIK2D6rwGsZqMDPA+5G4rQdA8o0wWRincdiJuOh9pz55r1D0qSntFkoGN3o0gHuWw+AEoztTpjE54cM4uGpUG2wPvThojatOhA9ySBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861890; c=relaxed/simple;
	bh=0/7lueA2Coq/fIj2w5spvOXbiQ/jGqxrY/KgNmSXYxA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eWafKydQPF224HhMacfyYHJGQ85yB0/tZPbh3gAeyxPgvoeulF1L5/BFCdUxD2+Vxfe1hV0FtThN1aUssJk9Xua4Hm8jNnLQ8FOObh+urKjUrHk+83wQG+0iykyC+YPY7N0JfqHsWvj4KBD+XiKVVIG9dC/cusUED6UOJeTsUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtewZ49R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtewZ49R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776861889; x=1808397889;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0/7lueA2Coq/fIj2w5spvOXbiQ/jGqxrY/KgNmSXYxA=;
  b=AtewZ49Ru8G0r3/8DnwjchHty5ZnT/GhIjLMTULgnvg/gCkhX+qofKL9
   oTlzU/vG2sEsXymYf7GwZzlRmWKFpHG9X9e9zbXDe1vO2EXmEAB1IRy2N
   UY/p8u54zhT5R1XDGoVg2YAvnkKYNLAJClQwkzcx4tGvQSwouagDIMETS
   B9dE6xm0wVkXRDFoMH4Z9cXtrbbNP8H0AeQVGLiJGkxzkct+5bjHQxK/i
   7ZZr/t4j4euaOKLtQttMttooqjtyhdThQcfn+4HsxgBcj6UZTUDZOwrBH
   24pmhX8soefn/rESijwEZI2m43rwK1C6gFTwefUlIE3PShyqnW0R970gk
   A==;
X-CSE-ConnectionGUID: Edpy5c4HT0u11CGxnTjSWw==
X-CSE-MsgGUID: 327jPyrjSZqAgpyTTqb0ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81422471"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81422471"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:44:48 -0700
X-CSE-ConnectionGUID: /zfhl7BvQB214qBw7GOgZA==
X-CSE-MsgGUID: 2VclRZT3Q3uzG8HNFid9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231449286"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:44:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 22 Apr 2026 15:44:40 +0300 (EEST)
To: Ankit Agrawal <ankita@nvidia.com>
cc: "alex@shazbot.org" <alex@shazbot.org>, 
    "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
    Yishai Hadas <yishaih@nvidia.com>, 
    Shameer Kolothum Thodi <skolothumtho@nvidia.com>, 
    "kevin.tian@intel.com" <kevin.tian@intel.com>, 
    "bhelgaas@google.com" <bhelgaas@google.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
In-Reply-To: <SA1PR12MB7199D0D2BAD762A5F2B2D78FB02C2@SA1PR12MB7199.namprd12.prod.outlook.com>
Message-ID: <f5f24e2f-c341-f948-e6d7-b3a3a54a07af@linux.intel.com>
References: <20260421140659.748577-1-ankita@nvidia.com> <5b2c6258-ade6-c35c-0edb-6da0ec96e987@linux.intel.com> <SA1PR12MB7199D0D2BAD762A5F2B2D78FB02C2@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1664857874-1776861576=:1863"
Content-ID: <d7564a2b-1248-bf08-3a0d-37fd4f304635@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1664857874-1776861576=:1863
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <08f9d8ad-43e0-5c29-8b6e-56a45f1b1936@linux.intel.com>

On Tue, 21 Apr 2026, Ankit Agrawal wrote:

> Thanks for the review Ilpo!
>=20
> >> + * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range =
1 Low
> >> + * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1=
=2E3.8.2:
> >> + * 000b =3D 1s, 001b =3D 4s, 010b =3D 16s, 011b =3D 64s, 100b =3D 256=
s,
> >> + * 101b-111b =3D reserved (clamped to 256s).
> >> + */
> >> +static inline unsigned long cxl_mem_active_timeout_ms(u8 timeout)
> >> +{
> >> +=A0=A0=A0=A0 return 1000UL << (2 * min_t(u8, timeout, 4));
> >
> > MSEC_PER_SEC
>=20
> Ack.

I didn't see this change in v5.

> > Also, don't forget to add include for units.h.
>=20
> Sorry why do we need to do this? The MSEC_PER_SEC is getting included thr=
ough
> jiffies.h.

Sorry, I mixed from what header it comes from and it doesn't exactly=20
comes from jiffies.h either. If C files rely on indirect includes=20
through other header, it makes painful to refactor headers.

--=20
 i.
--8323328-1664857874-1776861576=:1863--
