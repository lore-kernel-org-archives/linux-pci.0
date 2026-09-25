Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DF46EC81;
	Fri, 25 Sep 2026 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337051; cv=none; b=DLf0O12AONFcCaUKmGL6tRdCE5LYyTYpYfPxULz0LK8QQ+d59/12v4kXoE7FiuT1d2eMiPb8w0twlO09hFz1WQQMJn0SQTYvjCMXQjypL9vJHaF+3FyBCgkuj1NcTKHSO4iTTuXoWdtDQrJrtf2/TLIL+iw5uw8HfQwnFcn+ftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337051; c=relaxed/simple;
	bh=z2Wap3K0Q52PmQpc97MH9k3JAF9EqpSZhaz+lqoCJqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgL2QDfbNjjVHzqdyH4bDtYEhPZ+xbgo1syDj8yDVs+mHO/VPSfqGDU8qhYgjBSV5lqie6dDHB31Y5zT+pgf6rMXGBmTGMMvxsuAuE1s2Kd4KJ6ij8fWmzGH9tFFK65MkcWv2+f17yogdtwfqGiHn9cK6VjciWlkAtLn14o7Fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLGIHa+T; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLGIHa+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790337050; x=1821873050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2Wap3K0Q52PmQpc97MH9k3JAF9EqpSZhaz+lqoCJqs=;
  b=gLGIHa+TqBxkp5VZ5JXsgZ0BTLbeoggpwTsPimIiXqMThkdbe2ZsDws1
   yddSJgxBkvPVfJPDzNNAsxHWCN4YwZGbe2dhSx8EJJStu7Vv1j0c3foIo
   lfQsBuCgL/3cnt2SjwHEzxVNTng6FURWasmCbrt2wOpfyDrwt8Yyx55ob
   NlSEGhbYcjHaKlcgVqX8UNzyidlovVk5JfL4XeRKodKykQT+6CV9vN+7b
   N9AeYv3xqZmx1cJJo/K5WQOSJFz5jbwcoaQOvVglshZLyym9eSvlK4yQf
   YXa5JJKjUbJXswpoEbZ05Xkm0fb9bkOFEOYD0cQaa86oOlcHJX7Y575vP
   w==;
X-CSE-ConnectionGUID: l7+5XfRYRaKIqy3AzzeSzQ==
X-CSE-MsgGUID: QuJ7z3e7Triw/kpIhnoN3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93616619"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="93616619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 04:50:48 -0700
X-CSE-ConnectionGUID: iCDQrgdDQkGIhQP3Y9CuHw==
X-CSE-MsgGUID: 3UhgR6O3SfOksYsYNMj7Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="312239380"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 25 Sep 2026 04:50:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8925599; Fri, 25 Sep 2026 13:50:41 +0200 (CEST)
Date: Fri, 25 Sep 2026 13:50:41 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Freeman Z <SHD-ISAC@outlook.com>
Cc: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"westeri@kernel.org" <westeri@kernel.org>,
	"andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>,
	"Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
	"Martinez, Juan" <Juan.Martinez@amd.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Message-ID: <20260925115041.GX106095@black.igk.intel.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925052727.GV106095@black.igk.intel.com>
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>

Hi,

On Fri, Sep 25, 2026 at 11:31:55AM +0000, Freeman Z wrote:
> Hi Mika, Alex and Mario,
> 
> I tested v7.3-rc4 with the following Ubuntu SAUCE patch from
> Chia-Lin Kao (AceLan) at Canonical:
> 
>     thunderbolt: Fix PCIe device enumeration with delayed rescan
> 
> Ubuntu SRU posting:
>     https://lists.ubuntu.com/archives/kernel-team/2026-April/166926.html
> 
> Launchpad:
>     https://bugs.launchpad.net/bugs/2139572
> 
> The Ubuntu posting says this was cherry-picked from the corresponding
> upstream submission:
> 
>     https://lore.kernel.org/lkml/20260121060857.237777-1-acelan.kao@canonical.com/T/#u
> 
> The patch schedules a delayed pci_rescan_bus() 300 ms after the
> Thunderbolt PCIe tunnel has been activated, to recover devices that
> pciehp did not enumerate.

Oh I remember that. It's a horrible hack that is never going to applied.

Based on this we now know why it "works" in Ubuntu. Thanks for finding it.

I think the real issue is that the PME is not propagated as it should,
either missing wake or something else but that's what the AMD folks can
hopefully help us to figure out.
