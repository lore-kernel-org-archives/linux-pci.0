Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F237EFF8;
	Wed,  1 Apr 2026 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028357; cv=none; b=oFimjsHm0x48OmIzNVM6/F2Z33ZG/qg0n1tBMm8HnF1Djtj6P7mc9K8dCT8vjWBqmR4Ubaj9tUp9PWMGqj5c+Oz/ASxUlzEY+xt5kiRaWHT9y+aRVrJ07kywQHb7uO8+d2myxP2+WmTeY69b+e8Y5XtQt37mY9/wFMqZZjOA1BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028357; c=relaxed/simple;
	bh=FhwsZtMOZ+uGw5ieFFVhF8MAkcuS1b31cZzn2Qf87Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGF7kWapQAUAcsPEEPQ1eCXEc0Ygbjii0+qiaA3qFw0/H8e9ghO6A4Vc26mqlmgoomxUDOcGzVcTgcpaoXkfbfDan9ywv++C+YeQ6UbcwbybEp2BDOFY86/VF7ZYxNBBXJzBjifcRVA6PlvfgOOe2+nJ0ALcVycAZaydZoQhVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ib3BaTse; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ib3BaTse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775028356; x=1806564356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FhwsZtMOZ+uGw5ieFFVhF8MAkcuS1b31cZzn2Qf87Dk=;
  b=Ib3BaTsezVwogX0b3NtlWeJlL1nBYP7adSQTBnalh/IuzKfF+GonfdxZ
   pgJshCwcUqP1x4/Az5zMymgJkiW+l5TWm9ciPokmF2sdc4uqIb/C+Y8+m
   XH8fUk8GfpMkmpqCv5iIxGDgiqe8qM0FAH0UiWiga2VX5qK8km7hWa9NI
   vlCQwPXIUBRt6u/9Yvg90gx3jIQm5l24+1/UdjtoOWskaOsMRBJ5h2VWk
   WE5Crn6pwfExv3nChp2pD0+mRCuPc5/2jYIrCI7vIWvBTSS66IufIazRM
   gNOGXuYinUHbqsNZlefww7vjPFKvRiJFjMn31AX9JXd4/IPKXuFRsW0YR
   Q==;
X-CSE-ConnectionGUID: YSb+kV8OT1OVzXKob+wFzg==
X-CSE-MsgGUID: 9hjxdfi4QPW6cfAs+dZBgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="63608578"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="63608578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:25:55 -0700
X-CSE-ConnectionGUID: rIQoQuwmTJScUtTe40e3Vg==
X-CSE-MsgGUID: d68xut/KSTihRltqGFcalg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="226841778"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.127])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:25:49 -0700
Date: Wed, 1 Apr 2026 10:25:45 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Message-ID: <aczIea-JCb5umtch@tlindgre-MOBL1>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
 <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>
 <acpPsPivfllpWfv1@yilunxu-OptiPlex-7050>
 <23b92a154c859450d106de6c9badbe284e3aa19f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b92a154c859450d106de6c9badbe284e3aa19f.camel@intel.com>

On Mon, Mar 30, 2026 at 11:25:08PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-03-30 at 18:25 +0800, Xu Yilun wrote:
> > The caller is not aware of singleton mode. Actually, I'm trying to make
> > the tdx_page_array independent of HPA_ARRAY_T or HPA_LIST_INFO details
> > when allocating/populating, root page is still populated even not needed
> > for singleton mode. The differences only happen when collaping the struct
> > into u64 SEAMCALL parameters.
> 
> It seems tdx_page_array combines two concepts. An array of pages, and the method
> that the pages get handed to the TDX module. What if we broke apart these
> concepts?

We could add an enum for the LIST_INFO type to intialized the tdx_page_array?

Then the code using the tdx_page_array could initialize the root page based on
the LIST_INFO type for the SEAMCALL.

Regards,

Tony
