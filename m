Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E923A561;
	Mon, 27 Apr 2026 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260774; cv=none; b=ZYbR5nFVAncrko6hZgxb5vCL2KwBZM1cKUxR3UN3LNJikmUvhM+oeT4aXUjuHRVBv7UJn1lVvcxbMrHfSTb9xYpIzxf9vtdhoSM5RlTRgidi6sm5sAARCXSU/SHGSTWNLF8S1mkd6c940eVKasx/sVRicBI+mNgEhkTPgV7RYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260774; c=relaxed/simple;
	bh=424HvNddsDICO2hthptABkQmQxChYu0/EeJULWRIXNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djp+zP/+/9mdzjkdTZGOcwCCnvn0Bh6+aERXY0iSeblVlqRsFx2IhkuVieMJCP2vzcvLm3XZQpsdTAYhlC7Y57WL19+zAuNkvA/ABzBiGd4mpK2osCL9QMaJVhR2UW6HAk1WqqMU32Ko5N0luKmHnXAkqZdtcA9JZmBQJ19TIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR03Xixn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR03Xixn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777260772; x=1808796772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=424HvNddsDICO2hthptABkQmQxChYu0/EeJULWRIXNA=;
  b=AR03XixnhDX84M5qdxaP4vFfBVdHhm0bPF5sk56zPPPhDrbG4lnnRhqS
   +LHN/fokiJ9R8ooI/NVj0ZW/RyvEQHp4/JMUGBDFmewdUy248+/LafGMZ
   NU7oEoIgPQggMiahr/efJ+SG50phAXDsDVrPRxfRdgHqKSPBn9iU2z46O
   +kLkel+NlU1doLDl8X4Hkucz6L+omkkN9CeRdHqqJ53nHJRYVl0JFfN8Z
   NkWp8aZtufRjqH6ItAJ6PJwY+fvytIy6FcQnTwMq8y3fVaJsoszGkE7oR
   XTgVxZ+nPB1zkQd0Y/WVOMVVgVBjnMrIf4DraUCnLUIX3UzbVGHvRcXp8
   g==;
X-CSE-ConnectionGUID: CxI0FSjCTGmEydCAhA5+cQ==
X-CSE-MsgGUID: 2/zdNp/YR06BCD9iO/CSFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77301632"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="77301632"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 20:32:51 -0700
X-CSE-ConnectionGUID: NDmLYr/pQBGaE7Dnu5nedA==
X-CSE-MsgGUID: ofb5gXFLRPyGsuxQarzkyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="235292336"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2026 20:32:48 -0700
Date: Mon, 27 Apr 2026 11:10:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX
 Connect init
Message-ID: <ae7TnI4xGDEWY1Cd@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-24-yilun.xu@linux.intel.com>
 <BN9PR11MB527640A3D76B66DCE5FFA58C8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeiUartvxzsvq2Ye@yilunxu-OptiPlex-7050>
 <BN9PR11MB5276916B241153121738EB208C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276916B241153121738EB208C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Apr 24, 2026 at 06:54:54AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Wednesday, April 22, 2026 5:27 PM
> > 
> > On Thu, Apr 09, 2026 at 07:51:56AM +0000, Tian, Kevin wrote:
> > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > Sent: Saturday, March 28, 2026 12:01 AM
> > > >
> > > > Setup all trusted IOMMUs on TDX Connect initialization and clear all on
> > > > TDX Connect removal.
> > > >
> > > > Trusted IOMMU setup is the pre-condition for all following TDX Connect
> > > > operations such as SPDM/IDE setup. It is more of a platform
> > > > configuration than a standalone IOMMU configuration, so put the
> > > > implementation in tdx-host driver.
> > > >
> > >
> > > not sure what above tries to tell. why is it a platform configuration
> > > when you have seamcalls on each IOMMU?
> > 
> > This is to say the TDH.IOMMU.SETUP relates to PCIe SPDM/IDE, it is not
> > just about IOMMU. By identifying the
> > 
> >   for_each_iommu(iommu)
> > 	tdh.iommu.setup(iommu)
> > 
> > as a platform configuration, it justifies why we trigger this
> > configuration at tdx-host driver probe, rather than in some
> > IOMMU/IOMMUFD API.
> 
> iommu drivers also involve PCI, e.g. call pci_enable_ats(), etc.
> 
> so having relation to PCIe SPDM/IDE is not an argument of
> platform vs. IOMMU.

OK, I think I could delete the platform vs. IOMMU thing in commit log.

> 
> Actually I'm OK to put that logic in tdx-host. Just the explanation
> here doesn't make much sense...
> 
