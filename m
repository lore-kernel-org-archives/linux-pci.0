Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107899;
	b=bp6ppvQPzkIU7FCmTU2YtGDLcSwqGhcwuJZkJmSY5N/Jib20G03M5QGJF2j/+RDghlre
	 GEMgtGuO01YSxWorLuMg8PeL0swNPIV161WOdM9GWTSCM+NSZy1J7IsFa1pRiNXoCxiR6
	 W379GaAbHCBdP7ciAQFum6AlCQher3tPg+QUtmQlDZ0B1k4C0i3gg9vZwQyU8x8O0bb89
	 J2NnK1VdTz3oshEtxILcJojlDzXZYQiFJr/+wCeBKXAwGXN4zWfnxEvdMOji/chMlgjH8
	 dCKfB+Mr4zWEMvVZNGgT07tUOcYrGbM+gVyU57Z4qN9kj3KJkAJrCQj6X2ZqD/rGTeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107899;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=21lkp+jZKw7xeBP7grXhzOYdHsqOzFcmQ94QuOezdv8=;
	b=dTSPqazoCEVv4TKIeNBgPruvXETKaKE04My7CNmTJysG1NgxaEqW6uhnZntM6hE0G9ng
	 t8vBQ854raF31/NCPA6/BQNW7bJF9LQea0mYwIXTA0xwZ5vdlrX4BdlhWfYejoZEV6UJU
	 f0QZz1azFGOeN7Zl0fFvk8essUGc+pzHgj+v2WHdgLGe5/ujnVMwnktJBoD2TH6D5xJSd
	 lmX1p6GgDaC3RnYHMgYJb05MYg8q5YXJjw8Q6vj0B1kjPhKYq+IKXzaYOV6ijuaZ9Y+ND
	 sj1HsFaUEGhUHebFEmS3zg8xQzC7kO9D6xBweF31Xi5VjFOeUvzPum/oVQoBZMnHA1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BLcDig1U;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619C606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 13:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4619C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BLcDig1U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793107899; x=1824643899;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YJJ7CQJRgoMn1xeWLRPQsvJHf+yAvrafWBYG1e7HcJM=;
  b=BLcDig1U+TEkupYM5/FO7xzspP4/TItNQNYRzt8QGY0Tj7GPIg2L0Duh
   V8uXvQjDwDk8cs74LHDJKH4IK0yobWmeHXZi7+AE0+KzcE1c0JZTx6VgE
   tfHu5DIaAkrgkfCvLxtSaPocTgM2SyvK6e7v+JtlZOOh93WRvnrgDx1TV
   m+Xj8xDzTM08/J1yfWX+PR1fCZGGotd7w8E0a/xxuq3342aFpg6/ATLhH
   lG4QJrN+69bJpQHBwK4z5tVWd2qS3+QYZznEFGxNhgCJKu8gvrcqE12kl
   ZkssSYA7IY1b0OucNu1I31xBRaeDTEfSu+AdXwkr6tY65EWhXeQLGU9cu
   A==;
X-CSE-ConnectionGUID: ZnwPDLxUSEy0uzWAt2cvCA==
X-CSE-MsgGUID: xBYeBEdzQQGBneBwIlO8Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1682131"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1682131"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:31:38 -0700
X-CSE-ConnectionGUID: +vX9jtRMRgOvU5msbQOaLA==
X-CSE-MsgGUID: Oxp2e5YwTQmDqgDRIjMSpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4626909"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:31:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 15:31:25 +0200 (EET)
To: Maciej Grochowski <Maciej.Grochowski@sony.com>
cc: Nikolas Joshua Britton <nbritton@exabit.io>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Mesih Kilinc <Mesih.Kilinc@sony.com>
Subject: Re: [PATCH v4 0/7] PCI: Resource placement algorithm fixe
In-Reply-To: <b20cffba-3515-b8a8-1b6f-6483facac5af@linux.intel.com>
Message-ID: <f1f8c0e9-75bd-bf0f-65cb-57fe3d5cb1cd@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com> <20261023224518.80653-1-Maciej.Grochowski@sony.com> <b20cffba-3515-b8a8-1b6f-6483facac5af@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2079055605-1793107885=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2079055605-1793107885=:1182
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Oct 2026, Ilpo J=E4rvinen wrote:

> On Fri, 23 Oct 2026, Maciej Grochowski wrote:
>=20
> > We will now also test v4 and report back. Could the changes since v2
> > affect this window-size result, or is this amount of padding expected
> > for this topology? Please let us know which logs or allocator traces
> > would be most useful to collect with the v4 test.
>=20
> I suggest you wait until I send the next version which addresses the=20
> problems sashiko located in v4. I've basically tested the update locally=
=20
> and should get to sending it today or tomorrow.

Hi,

I think I'll have to renege on that timeline.

I'm not entirely happy with how the gap calculation is currently done and=
=20
I'm planning on reworking the patch almost completely to be based on the=20
existing loop in pbus_size_mem() but I'll have to first move that loop=20
into own function (for which I have a patch in another series anyway so=20
the more itself is just about shuffling my existing patches).

It'll take a few days more.

--=20
 i.

--8323328-2079055605-1793107885=:1182--
