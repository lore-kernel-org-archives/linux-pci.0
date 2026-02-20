Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB82BDC32;
	Fri, 20 Feb 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602483; cv=none; b=bxW5AVR+T2cnhn6Tr/RM/bL1y4qP1zesceuoqjIirMHqIP8v44IBAlaOV2eBohdQXgylfFoIOcIhRmp/T28VYQnwmWcwQiKZfVmYPcWMEECCRY3ssMBGCEz95yuDgcjmk6gvplbgks0hKg+yesDE6fK0zrZhE3s13SvfBbeNhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602483; c=relaxed/simple;
	bh=fh9bim7ssVqLim9HHorn9RpIpWGtbAsT8DW1WSQnYJE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jsOURCoLJhZTJocMpFSg+f37d7An0Y41O4iiQs0kgF4QAbs9qLaJUsJ7fJYKrJ7GsIf/4yErfPGHFV1NZNsBIl9sV8FCHnBdS72q+gwHGhK8A9Kaaf09tpHlnD14mDSh8mAXsVivAYvYRwax9pVqn7p5EyTvvcM7AW99UWmjYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKHpbVty; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKHpbVty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771602482; x=1803138482;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fh9bim7ssVqLim9HHorn9RpIpWGtbAsT8DW1WSQnYJE=;
  b=oKHpbVtyO0pTtjW/w5BLtaDBzpH1qKHXrDwtQMO1t//BBD5Sp2Viv9zf
   ouFf2rAumhAV5Wxu6WUh62bAa6Ql4ghU8GkAgWLPKx4s/C3pM/c5JOg1o
   XsNyTPQ8m89CdS6Bs/EUh51HTaxNv/2Fb0ja2rBbkjCyAqppgqHdoAKM+
   kpLOeHknnk5+XJ+Qx0kkpEmpE37+xlyTIHeXp3xWnVfyxuXsm4duZPeug
   5ueSzZZTenJ3sfNYUK+/QlMc9EjRV14tY6ZD0qFXGNGYlZF8qfEAxEXBX
   v3qRNCeZCKy0DfQUeTVwCAsSU9xgyMABBCrf4saBdng+XkIHmUCDi4CVU
   g==;
X-CSE-ConnectionGUID: tjNvBSg2Q92kQ4Soo1ZU6Q==
X-CSE-MsgGUID: 2P989wzLQhCV7HkKwzL+iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="90278478"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="90278478"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 07:48:01 -0800
X-CSE-ConnectionGUID: tpVEgg2jQfK8U3fAJqCSnQ==
X-CSE-MsgGUID: ABC1ovJ1Tv2qGvBc/BU3zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214732577"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 07:47:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Feb 2026 17:47:55 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Steve Oswald <stevepeter.oswald@gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: Prevent shrinking bridge window from its
 required size
In-Reply-To: <20260220150120.GA3525869@bhelgaas>
Message-ID: <9cc4a973-257f-7dd4-0519-e8f5bf3e411b@linux.intel.com>
References: <20260220150120.GA3525869@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1018775426-1771602475=:974"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1018775426-1771602475=:974
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 20 Feb 2026, Bjorn Helgaas wrote:

> On Fri, Feb 20, 2026 at 01:32:43PM +0200, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 19 Feb 2026, Bjorn Helgaas wrote:
> > ...
>=20
> > > These both date back to v5.10 (Dec 2020), but Steve's report below is
> > > only from Aug 2025, so I'm sort of assuming this is v7.1 material?
> >=20
> > It's an old problem yes and impacts limited set of configurations
> > (a device with big BARs attached to TB).
> >=20
> > v7.1 is okay for me, this could cause some not immediately obvious prob=
lem=20
> > in some other case so it gives more time for us to hear about them=20
> > (hopefully).
> >=20
> > > If we want it for v7.0, I'm going to need a CliffsNotes summary of th=
e
> > > commit log to justify it :)
> >=20
> > Even if it's not going to be needed in this cases, what's "CliffsNotes=
=20
> > summary" ??
>=20
> Slang for a short summary :)  I.e., a sentence or two to motivate a
> pull request.  Big BARs attached via Thunderbolt sounds like an
> important piece; e.g., maybe this helps fix Thunderbolt docks with
> GPUs in them?

At least some of them (the reported case exactly that, IIRC).

--=20
 i.

--8323328-1018775426-1771602475=:974--
