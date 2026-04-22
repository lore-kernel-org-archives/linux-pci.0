Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149992E2F1F;
	Wed, 22 Apr 2026 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839225; cv=none; b=bk9UzsxrVq6BjRFjYdiRsrAZZFX4d+Wvtc8UiYbD29frvF22lZFbH9eUdiDt4TwTEPj/1GkhElsp61ajTLGy96BJcIMM9Heu5AV1g3I8Q63ic0oe7o5K/7w9cmjdE+xEVpg/o7fxd5t2AIPq57iw6uFO/2BYyqHCQUi7xeq4yeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839225; c=relaxed/simple;
	bh=7jQY9erwvArmaWEdBcTRWeFAGYsPE3qyNp0qs4i8cRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4rPQyGLyhoy3bCbjTmCWycMqlhPDunn0t9PpSGlbfikPhTuP+BF/NcGbBH3n4MEs2omfEPRQxre9kdJOXiDpwn+T486mpHYxKcqOt/iKh4En7ucUwVjfMkjXrBsexDRUHvAEeusoW6fwr3JM93kBWhedm7mnc1d8/PQmI8mzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBvzOwGG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBvzOwGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776839224; x=1808375224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7jQY9erwvArmaWEdBcTRWeFAGYsPE3qyNp0qs4i8cRA=;
  b=FBvzOwGGRBkzFceSCLsPYrvl7f+cuHgdP35msJFVUf84R3KZinDp5Z/3
   iGxNQE7oWuTiEZZqZksZWggAIxVV53jzhtnikwTQTO0OyUtjCIgP3xSbX
   cNPQGiGMnFDrO/GmzMyepB2fG8UiWrXsLeObHRcZGlt8VSr27KFCGs08f
   pFTiXAYcaJ/sT6hI81sKNkpUgVludTGSlL6GIHWOQiDMDskTEquQfGsUl
   +glNw+zyedyw1JR9QfYUgsOYNlnCZxzAwTlTw3q70SSMi8QDJOf66/fSY
   3bXGugkpEZ3QcFlfFY8RGbkfLt+W3eVgZi8DDAgTDqsdlLF7FX2x4KT+K
   Q==;
X-CSE-ConnectionGUID: UJGZcaK9TeSInf/mFzMEUg==
X-CSE-MsgGUID: 2Lf/MoAhSTKfj9aYpQqiCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77489230"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77489230"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:27:04 -0700
X-CSE-ConnectionGUID: Zhln8ECdTDe0BhMBbPjKWg==
X-CSE-MsgGUID: 0/gXbuUcToyGytsMFpzsXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237252073"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 21 Apr 2026 23:27:00 -0700
Date: Wed, 22 Apr 2026 14:04:47 +0800
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
Subject: Re: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on
 TDX_INTERRUPTED_RESUMABLE
Message-ID: <aehk/2DEizc1eG+e@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-21-yilun.xu@linux.intel.com>
 <BN9PR11MB52767E6C22CDF7DAD9D5FF1E8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767E6C22CDF7DAD9D5FF1E8C582@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Apr 09, 2026 at 07:21:48AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Saturday, March 28, 2026 12:01 AM
> > 
> > +static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func, u64
> > fn,
> > +						struct tdx_module_args *args)
> > +{
> 
> 'ir' sounds redundant with the trailing 'resched'?

Mm.. I want to 'ir' to reflect the loop-retry is dedicated for
INTERRUPTED_RESUMABLE in TDX context. When you say not big deal, I
assume I can keep the naming?

> 
> not big deal, just a bit confusing when seeing it in IOMMU side where
> 'ir' also refers to 'interrupt remapping' and is frequently used in 
> irq_remapping.c... :)
