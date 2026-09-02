Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24441D11A
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341422; cv=none; b=YXP+pgoZvdaxXvVnb2M5leZfjBTYGkt1T4gm2OFrO6KkuQr9+G8OpkhZ/xuy0hbuy3TTnR3WHLR8DWsBfykwt0NWxbNOe7AqEFN+YSyvy5wEp55rMKb5//w03r4FsVBzJOCTVh6KJT/fBksyeAS0d7DzL3AlGm2vhqFpxPjufpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341422; c=relaxed/simple;
	bh=l4CcqLeTw2RJTTXu+564kHsC9lTF6y/VbYYD37/sXHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOiDvAXzydgomUVU0mL6tfZD77qRaqfz2gO/nH5i4QoYFoefDWo88fvxSg9xB0AvG84x4r4mLN/z9zx/ykaJ+eQThG/0A2NRq3NpIlp7aK/2AguB0W8pvLkA6Bnqjsp+5QNLRdyRF2Ie9X0oIlh7ghovUWZT8ojnrXKALoV17Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgWyBXoO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgWyBXoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788341420; x=1819877420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l4CcqLeTw2RJTTXu+564kHsC9lTF6y/VbYYD37/sXHg=;
  b=dgWyBXoOPfoj93LSs+c1ig75ESd8kpAFKIlD2/ira6kV5K4wOAqL1pQW
   Eb7U7nXeUt+4YppCQPb/8bVOlkVQJH6ZTLpj5pW+f7Dwty8uhptvm5U18
   5oud4QN9xHI3EYzy4MJJ641IutsBVYk3zLjbKQqhx8Gr0BfoHGrmOCtUA
   NXNdC7MQPPipC8HpIwcnU24VwsjL9jiIEYVr/A7F6Wo7FB5v95vfNQkqQ
   OEjv3BMeSx9nhb04pQBRbiSgtSoTktmvao8BYAexMSKkYBIprWKxUuPXe
   4ZU6lhnFJeoRaOqt0nDEe8ppGlzXCo8nGeMYVm0qW7z+M40wzpwpmW3lZ
   g==;
X-CSE-ConnectionGUID: 9JJ4u/zIQTGYVaSxHRJfOQ==
X-CSE-MsgGUID: VhjYdx7bTnyKjFUCjHAUlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106313856"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106313856"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 02:30:20 -0700
X-CSE-ConnectionGUID: DWk/CSPsR7ixET9NbbTVEg==
X-CSE-MsgGUID: 1RzLDjxvRqqFxl0dAUs7dw==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa003.fm.intel.com with ESMTP; 02 Sep 2026 02:30:13 -0700
Date: Wed, 2 Sep 2026 17:30:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, ankita@nvidia.com,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev, Aaron Tomlin <atomlin@atomlin.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <apfspMWk6axWhx1w@yilunxu-OptiPlex-7050>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>

On Wed, Sep 02, 2026 at 12:20:51PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 2/9/26 12:12, Xu Yilun wrote:
> > On Tue, Aug 04, 2026 at 09:55:33PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:
> > > 
> > > > Glad to see you all here to make progress! Intel can also help on this.
> > > > Can we have a meeting to discuss on these topics? As Alexey mentioned,
> > > > previously we had a bi-weekly call, perhaps use that for our first
> > > > meeting? Or what time works best for everyone?
> > > 
> > > I prefer we defer such community discussions till September, that
> > > seems appropriate given some dates I've seen.
> > 
> > Hi Ankit & Jason,
> > 
> > Do we have a plan to schedule a meeting to discuss next steps?
> > 
> > If so, we can figure out a specific time on the Discord channel.
> > https://discord.gg/KKqC438c
> 
> 
> So I've been trying to find a time slot. Say, keep it on Thursdays (USA) (kinda short notice), bi-weekly, we can do:
> 
> Scenario A:
> Seattle (PDT, UTC-7)		07:00 – 08:00	Day 1
> Atlantic Time (ADT, UTC-3)	11:00 – 12:00	Day 1
> Berlin (CEST, UTC+2)		16:00 – 17:00	Day 1
> India (IST, UTC+5:30)		19:30 – 20:30	Day 1
> China (CST, UTC+8)		22:00 – 23:00	Day 1
> Sydney (AEST, UTC+10)		00:00 – 01:00	Day 2 (I can do it once in 2 weeks)
> 
> Scenario B:
> Seattle (PDT, UTC-7)		18:00 – 19:00	Day 1
> Atlantic Time (ADT, UTC-3)	22:00 – 23:00	Day 1
> Berlin (CEST, UTC+2)		03:00 – 04:00	Day 2
> India (IST, UTC+5:30)		06:30 – 07:30	Day 2
> China (CST, UTC+8)		09:00 – 10:00	Day 2
> Sydney (AEST, UTC+10)		11:00 – 12:00	Day 2
> 
> Scenario C (which is the current schedule):
> Seattle (PDT, UTC-7)		20:00 – 21:00	Thursday, Sep 3
> Atlantic Time Zone (ADT, UTC-3)	00:00 – 01:00	Friday, Sep 4
> Berlin (CEST, UTC+2)		05:00 – 06:00	Day 2
> India (IST, UTC+5:30)		08:30 – 09:30	Friday, Sep 4
> China (CST, UTC+8)		11:00 – 12:00	Friday, Sep 4
> Sydney (AEST, UTC+10)		13:00 – 14:00	Friday, Sep 4
> 
> The link is:
> https://zoom-lfx.platform.linuxfoundation.org/meeting/93219227394?password=80705486-101a-4e19-8f11-0baaf92104be
> 
> but if we want to change the time - who do we contact? Or set up a new call (again, how)?
> 
> Please, comment. I find these calls pretty productive syncups. So far we were not having Europe in these calls.

I'm from china. I'd say every listed option is perfect to me. Thanks.
> 
