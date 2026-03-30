Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D33C13FB;
	Mon, 30 Mar 2026 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867623; cv=none; b=l1TfxaaxZzoXzrPjdl0RtmXH5TOvza9TFlcfO7QshR/9gn7cIdds5Td7eA0MF6P6YGRRZrKIb/2bQP7pv2j395ViOEIvO1Zwdil9plZlecCgGloQuuSORb2UncK7d1cpgNob8sxzr1eN4jTHcjumYugyirvrat6iWtbI6sWT3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867623; c=relaxed/simple;
	bh=JTmWijjJqe8MuLp6ucrTKNqj9bocCIOLRm/Wv8fhfIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3zfmtYuTYH9tlt2Ovur8HOs93Ew5QiQyXpdMu5A7nJm1m3fu0FiwerZHDi5j6gayPxsNirXn7/6b9CmRlR9QUQ0v1p+U4POtjFIllxMvDa36WSupWHF76hcYKiCKWezycqLQm8Vuu+0zsNkyuJE7pWxYFAPMYYpD9/1mbsIpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvWsTYfi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvWsTYfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774867622; x=1806403622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JTmWijjJqe8MuLp6ucrTKNqj9bocCIOLRm/Wv8fhfIg=;
  b=lvWsTYfieVKVS+sNkqxKHjJVAc5uDeNgMh92K2RsHbT1cbB4UQgATQqU
   NLPQhN1Oj2gvOQkH+fJOzeWrW8wxT55pZqzI20CibWDii2JBraEqokmrK
   k7/ZjfpfDaIS0bwuFnFXQyVoMPOPRqlt8KoqmBqKVNwC7wqacNGuTI9bW
   tbgmzHYI27KOiWbkwjhmgjtKF6THxwEFXtTRhQYX8AoLYNXYqFP14tk8b
   SJA1fOZDNYetOFZfd/Hs1+PIWLV4nnfBB0CVuglTmjwGkN/lgrAAdwPg+
   /2tkx7Y25+g/qeKCJBB3TLltY3LmENT1S7T3jlJxxLPMrujwTpH82DTbB
   g==;
X-CSE-ConnectionGUID: JSo/1k+SQAqyfxfVNvvs4w==
X-CSE-MsgGUID: 2GrT1BIhTM27pwi0AWXP8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75968242"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75968242"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:47:02 -0700
X-CSE-ConnectionGUID: qQE/yCadTj2iWhNU8MQADg==
X-CSE-MsgGUID: TuxXC+usRCKcPWY2UwC09w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="223153707"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 30 Mar 2026 03:46:58 -0700
Date: Mon, 30 Mar 2026 18:25:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Message-ID: <acpPsPivfllpWfv1@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
 <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>

> On Sat, 2026-03-28 at 00:01 +0800, Xu Yilun wrote:
> > Add struct tdx_page_array definition for new TDX Module object
> > types - HPA_ARRAY_T and HPA_LIST_INFO. 
> 
> This is unfortunate. I see you agree in the comments.

Yes, basically they are defining the same concept, behave mostly the same
but some differences...

> 
> > 
> > They are used as input/output
> > parameters in newly defined SEAMCALLs. Also define some helpers to
> > allocate, setup and free tdx_page_array.
> > 
> > HPA_ARRAY_T and HPA_LIST_INFO are similar in most aspects. They both
> > represent a list of pages for TDX Module accessing. There are several
> > use cases for these 2 structures:
> > 
> >  - As SEAMCALL inputs. They are claimed by TDX Module as control pages.
> >    Control pages are private pages for TDX Module to hold its internal
> >    control structures or private data. TDR, TDCS, TDVPR... are existing
> >    control pages, just not added via tdx_page_array.
> >  - As SEAMCALL outputs. They were TDX Module control pages and now are
> >    released.
> >  - As SEAMCALL inputs. They are just temporary buffers for exchanging
> >    data blobs in one SEAMCALL. TDX Module will not hold them for long
> >    time.
> 
> This is kind of verbose for what it seems to be trying to say. It's just that

I assume if you feel the explanation of "what is control page" is off
track. I added it cause the term firstly appears in x86 (only in KVM
TDX previously), and people ask the definition:

https://lore.kernel.org/all/cfcfb160-fcd2-4a75-9639-5f7f0894d14b@intel.com/

> these types can be input or output params. The TDX module could hold on to the
> pages for a long time, or just transiently.

Mm.. I'm trying to ramp up on the kernel API level flow:

For control pages, it would be hold by TDX Module long time, so host
inputs the page array, later TDX Module outputs the page array back.
Host need to verify the outputs.

For shared pages, TDX Module's accessing is transient in one SEAMCALL,
so only as input, TDX Module never needs to output the array.

I think the verboseness makes the following pseudo code easier to
understand.

> For that latter part I think you are
> trying to say sometimes they need flushing and sometimes they don't?

Yeah.
control pages => long term => host verifies and releases => flush on release
shared pages => transient => no verify and releases => no flush

Maybe I should mention the flushing is already covered by releasing
kAPI.
> 
> > 
> > The 2 structures both need a 'root page' which contains a list of HPAs.
> > They collapse the HPA of the root page and the number of valid HPAs
> > into a 64 bit raw value for SEAMCALL parameters. The root page is
> > always a medium for passing data pages, TDX Module never keeps the
> > root page.
> > 
> > A main difference is HPA_ARRAY_T requires singleton mode when
> > containing just 1 functional page (page0). In this mode the root page is
> > not needed and the HPA field of the raw value directly points to the
> > page0. But in this patch, root page is always allocated for user
> > friendly kAPIs.
> 
> "singleton mode"? What is it? If it's the case of not needing populate loop, it

It is the SEAMCALL level detail for HPA_ARRAY_T. It is literally as
explained above - the HPA field should be filled by page0, not root page.

> probably deserves more explanation. I'm not sure, but the populate loop seems to
> drive a lot of the struct design?

The caller is not aware of singleton mode. Actually, I'm trying to make
the tdx_page_array independent of HPA_ARRAY_T or HPA_LIST_INFO details
when allocating/populating, root page is still populated even not needed
for singleton mode. The differences only happen when collaping the struct
into u64 SEAMCALL parameters.

> 
> > 
> > Another small difference is HPA_LIST_INFO contains a 'first entry' field
> > which could be filled by TDX Module. This simplifies host by providing
> > the same structure when re-invoke the interrupted SEAMCALL. No need for
> > host to touch this field.
> 
> Not clear what this is talking about. But I'm starting to wonder if we should be
> so bold to claim that the differences between the types really simplify the
> host. 

I'm talking about another SEAMCALL level detail. Sometimes TDX Module
got interrupted in the middle of page array processing, it needs an
anchor to resuming from where it stops, TDX Module record the anchor
in the 'first entry'.

By illustrating these SEAMCALL level differences, I want to explain
they don't impact the general SW flow and kAPI cares about them
internally.

Yes in POC code we do write dedicated code for each type, but it ends up
with plenty of similar logics on caller side about root page
manipulation. By now, the differences are not much, but I think we
should not write copies for every type, we should stop new types.

Please allow me to stop here, will continue later...

Thanks. 
