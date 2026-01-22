Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593833F23CB;
	Thu, 22 Jan 2026 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075591; cv=none; b=rIcf44H6OQ8kxLki1QKHChLzqYUquHIaELuwwSJgN2WZITT+xPBpEzLX+i792QWhOkjmYeY20LVjwpRefgB4P/VDq/AcnurkQsm4dNx56i2fYl3GUAlKCQN83t2m9njkcg1lEyA+H4krsi0WeRJXnMy30QLSJG4Lu/qheCqnosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075591; c=relaxed/simple;
	bh=PeL3aWqI5qi+xFGChJE7V0mcmXL80+eoyqdi2OohyF0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSphyz2UWacIkcWUdZUbedlT7m1HhXMXc3pM64R9tgjH8RAU4Xg7m4dhIWognmYYmgHAnC3oFh+2Db7BMo2WQ6jEzq9qvjI9Hn34GuHYT7WIfum9uluI4ucKlDzmfWE748qBZFBuiE6yyKAKtV1tCFkJYFFLYxmJPaLlhdhR8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxbvm4FyfzJ46t6;
	Thu, 22 Jan 2026 17:52:36 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 207EB40573;
	Thu, 22 Jan 2026 17:53:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 09:53:03 +0000
Date: Thu, 22 Jan 2026 09:53:01 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <smadhavan@nvidia.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<ming.li@zohomail.com>, <rrichter@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <huaisheng.ye@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vaslot@nvidia.com>, <vsethi@nvidia.com>, <sdonthineni@nvidia.com>,
	<vidyas@nvidia.com>, <mochs@nvidia.com>, <jsequeira@nvidia.com>
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Message-ID: <20260122095301.00001ebd@huawei.com>
In-Reply-To: <20260121202755.kwbpzjxuevnah6so@offworld>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-8-smadhavan@nvidia.com>
	<20260121112005.00001e80@huawei.com>
	<20260121202755.kwbpzjxuevnah6so@offworld>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 12:27:55 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 21 Jan 2026, Jonathan Cameron wrote:
> 
> >On Tue, 20 Jan 2026 22:26:07 +0000
> >smadhavan@nvidia.com wrote:
> >  
> >> From: Srirangan Madhavan <smadhavan@nvidia.com>
> >>
> >> Flush host CPU caches for mapped HDM ranges after teardown and prepare
> >> sibling Type 2 functions on multi-function devices. The host cache
> >> maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+  
> >
> >That's not sufficient in general on arm64.  It might flush far enough
> >or there might be buffers beyond the point of coherence that are not
> >flushed.  
> 
> ... and quite slow for large regions without firmware assistance
> (CLEAN_INV_MEMREGION from PSCI 1.3).

Just for completeness in case anyone takes this comment out of context.

CLEAN_INV_MEMREGION was dropped after that spec when beyond alpha. See F.b release.
https://developer.arm.com/documentation/den0022/fb/?lang=en
Talk to you to your favorite Arm architecture person for why
(I'll just say it was a good reason).

Also there is no guarantee that firmware interface does it any faster.
Implementation defined and all that.

No one jumped on my proposal to write an ACPI AML wrapper spec
so for now only option is to write a specific driver if you have
a hardware agent that offloads these operations (like the hisi_hha does).




> 
> >Until there are clarifications from Arm we need something like the
> >agents in drivers/cache to do equivalent of wbinvd_on_all_cpus()
> >(be it on a PA range to making a tiny bit less horrible)
> >
> >Or we need an opt in list for platforms where a flush to PoC is enough.
> >
> >Needs to some sort of arch_ call as well, not hidden in the cxl driver.  
> 
> Reset should just be using cpu_cache_invalidate_memregion().
> 
> ... now, in addition to DCD, we have two users that are beyond the
> "just once at boot time" use case.

or Back-Invalidate to do this from the device side. If anyone has built that yet...
Beware physical address based prefetchers though as there be monsters.

Jonathan

> 
> Thanks,
> Davidlohr
> 

