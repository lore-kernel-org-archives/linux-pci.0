Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F07B351C09
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547470; cv=none; b=Mmpn5UG3KlIO3b7CHpRuwNKEjGIeN04Pwxc6LofxTzMWmWB+QLAHYNVg+LUK9F4bACQGKGbvlxphbd+JMUoL5u806qDYmBrP4qkCACTscokI8c1uCoGxslzD6Weca2aXql29tx8jvVAviIusdCvWnb2RnpjidiesgkSaNlH6pfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547470; c=relaxed/simple;
	bh=3+NC6CHo0X3VCquVypVEb5EG0yaES8GRmsBCzrVMpAg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f0Maxi8qC57W7lBTaiKcJZwpsa2BCsYtBoyIZhmk8hhVz0qF/vbt+qHfCC3heAVSAFceuY9ksLhPDKqU8fSIsMYykUX+/Kj3rmaGx7SODvjHI+HCCWbfse/ukP0IZTgS14yWJ6iu7XxxM7zHvAK/kQ1IS8ctQO4PX/b66iyU4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJijVzZy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJijVzZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775547470; x=1807083470;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3+NC6CHo0X3VCquVypVEb5EG0yaES8GRmsBCzrVMpAg=;
  b=MJijVzZyAyns4oZghUvOtru4IdcK6ZcC21ssTjH5kD/TWiuLdhXC4Luh
   Ef5fmeWbJzxGLv2Yuz3XQtptIIpjimU8ACqr66dhvagTV90pFcfVGj0cy
   6JxXt6QvL+wT8w94uUq0RVNnZcmL7w64ABs7cbGoIKZz0i4OKE4T2y36p
   xUMfKwG3l9LpR6HNljyvrEgmXX7ixaGX8FY6Nh1X0RsuU6c0h7QzP86gb
   KtbRfC1IeDvweW/KKDPhAU6SJAqFgEWzDl2i7qxqOX8YRGLsCVU5SHyMT
   lTe2lcpzgVwztu5DiJd/4N6sisAs5cVufRIka/4IWguF3nG6mSTCNtgE8
   w==;
X-CSE-ConnectionGUID: fJg2ZnbWQpKvI7r0AERSkA==
X-CSE-MsgGUID: 6bblC/hVTwCmwb6IRHxBOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="94084676"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="94084676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 00:37:49 -0700
X-CSE-ConnectionGUID: 5MXTMH3lRPGQxOzLvdyH3w==
X-CSE-MsgGUID: q0DUHcL8RoWvrEiN06coiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="228004275"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 00:37:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Apr 2026 10:37:43 +0300 (EEST)
To: =?ISO-8859-15?Q?Jonas_H=F6glund?= <firefly@firefly.nu>
cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    regressions@lists.linux.dev
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since
 new bridge window alignment calculation code
In-Reply-To: <d50a8eb1-3a16-47c7-bfea-0a3def606c6f@app.fastmail.com>
Message-ID: <db715a3b-80c7-31ed-bf31-fb55ad7c538c@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com> <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info> <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com> <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
 <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com> <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com> <d50a8eb1-3a16-47c7-bfea-0a3def606c6f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-34575375-1775547463=:983"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-34575375-1775547463=:983
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 2 Apr 2026, Jonas H=C3=B6glund wrote:

> On Thu, 2 Apr 2026, at 16:51, Jonas H=C3=B6glund wrote:
> > Here are dmesg logs (with the appropriate dyndbg cmdline flag) for both
> > cases, in case it's useful:
> >
> > https://up.firefly.nu/pub/amdgpu-egpu-crash-7.0.0-rc6.dmesg.txt
> > https://up.firefly.nu/pub/amdgpu-egpu-good-pci-resource.dmesg.txt
>=20
> Actually, now that I look closer at the good-case dmesg (just after
> sending the email, typical), I guess I'm not sure how happy the driver
> and dock really are.  Well, I'll let you weigh in since you're more
> intimately familiar with the subsystem and expected debug messages.

Hi,

Even the "good" case does fail to enlarge the eGPU resource because some=20
of the upstream bridge window are pinned by other resources.

It is a problem that has come up multiple times over the past few years=20
but it's also a problem that is not very easy to solve (but I'm working on=
=20
it). The sizing needs to be corrected earlier than that point (before the=
=20
other resources pin those bridge windows), at the time we discover that=20
BAR resize fails, it's already way too late to correct things.


--=20
 i.

--8323328-34575375-1775547463=:983--
