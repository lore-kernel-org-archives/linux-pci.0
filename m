Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012B399349;
	Fri, 24 Apr 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777028610; cv=none; b=XvbEdUqh0CpD8i/oa8NgEFAPptxLyMBAGFS+tya5juzwEUblS9jl5luNgwR357a4IMZvGgp2KO0kEMPrI//tFyqDlG2+MBBHcqQkgfbjTB+XPHcqSaMgJZF4gCqZn/x2tbXu3PbTzgUGrQvbqCFaZKxzdLNpOzSi1iTbj/BLqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777028610; c=relaxed/simple;
	bh=rJLV3fVgTLnezbgFSlQTOQiusLepMs4uvxOr7+FZuqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVBc2rWnZsHqOngTcoUJ79vkKWaJ+/YGrS3LwaGW8ryhDIC1SoKu6XfusFFhg1IdGvM01ThFpJlXqcaWAfqLN5pFth9ol9PCzAKlCzDq1YQf1+gq+ubdIuaoWkHCGr3M++bf4ElcSc75b0/r3jqzHOw0TbRyr1BrEs0HRIvBq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7dQkT6q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7dQkT6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777028609; x=1808564609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rJLV3fVgTLnezbgFSlQTOQiusLepMs4uvxOr7+FZuqk=;
  b=d7dQkT6qrGe8iXZT/fZOUR6ZlU0TMukX2oVWClSfJrBx7vyVJECsUpVz
   EE88XfKh86pIaD3RiwVevBLDG8IS+VM7nS6xY1etT4ccZxHdg66BS4tU+
   mLAhUQJbFbxodA7UAs0Noadlez+4hB7I9QJT0H4RpnaiQN2J2H90Qualk
   dXO8xq5Bm/mW8FZvG+wIAsWAhsTiU4Ofm0QdGh4nRvJ3C/A9Kq6oavHHM
   tX7VFrR8Ehc6vUB2WcksBzNGR0KDCnSJMOAPVgsCwUAni699+/W3AM0Tp
   /wlUNHt1bmt9XWRYZ66/W+4i2cf+4Dtwf7YXTUGrurjqFU6EKs7Aidjmx
   w==;
X-CSE-ConnectionGUID: K11h3gY1RSqEjljg8Wl5pQ==
X-CSE-MsgGUID: zdzoslqFTJmhVtcL7aiR8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="65539108"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="65539108"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:03:29 -0700
X-CSE-ConnectionGUID: z6D1ip/cR9iKaTYg3Vz7dw==
X-CSE-MsgGUID: pJbpNqkWRv+39a7ePtHCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="237981384"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 24 Apr 2026 04:03:25 -0700
Date: Fri, 24 Apr 2026 18:41:05 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Message-ID: <aetIwTS4V95qIGku@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
 <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
 <3b0bc0dea544b10bd2fb0304a96d2671f263829b.camel@intel.com>
 <48171f4ab772da546beccec3c7a95fe442524b42.camel@intel.com>
 <aereVy8zVb2be2hh@yilunxu-OptiPlex-7050>
 <668a903ba2dccff2d641ac15b74deacc95ef19a6.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <668a903ba2dccff2d641ac15b74deacc95ef19a6.camel@intel.com>

On Fri, Apr 24, 2026 at 08:09:16AM +0000, Huang, Kai wrote:
> On Fri, 2026-04-24 at 11:07 +0800, Xu Yilun wrote:
> > On Thu, Apr 23, 2026 at 10:29:31PM +0000, Huang, Kai wrote:
> > > On Thu, 2026-04-23 at 17:05 +0000, Edgecombe, Rick P wrote:
> > > > On Thu, 2026-04-23 at 00:59 +0000, Huang, Kai wrote:
> > > > > Ditto here.  I don't think we should introduce any more cond_resched().
> > > > > 
> > > > > Btw, I think technically we can reuse the seamcall_ir_resched() you introduced
> > > > > later, albeit in which a local '_args' is used as a copy of the original 'args',
> > > > > but that has no harm for the case where we can just use the 'args' to loop.
> > > > > 
> > > > > I am wondering whether we can just use that here, or we just get rid of that
> > > > > helper (then open retry by the callers of these SEAMCALL wrappers), since there
> > > > > will be more cases where we need to manually set 'resume=1' in the SEAMCALL
> > > > > input 'args' when retrying TDX_INTERRUPTED_RESUMABLE.
> > > > 
> > > > I kind of like the latter option to open code more of this stuff. The stacks of
> > > > seamcall wrapper macros is already too much. 
> > > 
> > > Agreed.
> > > 
> > > And SEAMCALL *users* can actually come up with their own version of wrapper(s)
> > > to do the retry.  E.g., currently seamcall_ir_resched() is only used for IOMMU
> > > SEAMCALLs, and we can put this wrapper in the IOMMU code or coco/tdx-host.
> > 
> > After we have introduced TDX Module Extension, irq preemptable
> > EXT-SEAMCALLs become a common concept. 
> > 
> 
> It has been a concept since before the EXT-SEAMCALLs actually.  For instance,

No, they look similar but different. EXT-SEAMCALLs are truly irq
preemptable and resumable to its context. Other SEAMCALLs just
periodically yield and don't have a generic way to save/resume their
context. Sometime you need to pass in resume flag on 2nd time, which
means the secure world forget where they were and can't really resume
all by itself.

What I mean is, EXT-SEAMCALLs should never need to play tricks on
input parameters. Just input what is originally inputted, the secure
world doesn't need hint to resume itself. So the int-retry process
should be common.

> TDX live migration using blocking export doesn't need any opt-in via module
> extension (only the non-blocking way needs), but the SEAMCALLs to export/import
> TD/vCPU/memory are all interruptible.
> 
> In fact, they had the "latency requirement" behind the INTERRUPT_RESUMABLE in
> mind at the very beginning.  It's just at that point all SEAMCALLs were not that
> heavy.
> 
> > It is irq preemptable so that the
> > secure world remembers and resumes the context, no need for host to
> > remind via resume lag.
> 
> The fact is the aforementioned live migration related export/import SEAMCALLs 
> (there are 8 at least, but maybe more) all requires the explicit setting of
> 'resume=1' (plus using the SEAMCALL output as input for retry).  I don't know

Yes, so they are not truly interrupt resumable and should be specially
treated.

> the story behind this, though.  There might be some tricky thing here for the
> module to remember and manage (e.g., migration has a concept of "migration
> stream", and the resume is per-stream).
> 
> > 
> > Today there are 3 EXT-SEAMCALLs, TDH_SPDM_CONNECT/DISCONNECT/MNG,
> > irq preemption handling is a general requirement for them, and I think
> > it is still true for any further EXT-SEAMCALLs.
> > 
> > So I think a general helper for EXT-SEAMCALLs makes sense.
> 
> Yes conceptually I agree, but not need to distinguish EXT-SEAMCALLs or not IMHO.
> 
> The problem is there isn't a common rule to follow.
> 
> E.g., let's say "the module can remember thus no resume flag is needed", how
> about the SEAMCALL inputs?  Can the "output" args be directly used as input for
> retry, or the original input should always be used?

Since EXT-SEAMCALLs don't depend on input tricks to resume, there could
be a common rule, now it is defined as "the original input should always
be used".

> 
> Not to mention there's existing SEAMCALLs which require explicitly setting
> 'resume=1'.
> 
> I believe we can use some smart hack to implement a common one to cover all
> cases above, but I am not sure whether it's worth to do (maybe we can have a try
> to see how does it look like, though, I think).
> 
> Given the SEAMCALLs for TDX Connect seem to follow one rule to retry, and live
> migration SEAMCALLs follow another rule, it seems for now the simplest way is to
> introduce the needed retry helper in the layer of SEAMCALL *user* (TDX Connect
> and migration).
> 
> > TDH.IOMMU.SETUP, however, is another case. It is not a EXT-SEAMCALL but
> > happened to follow the same irq-retry handling process. To avoid code
> > duplication we have:
> > 
> >  /*
> >   * seamcall_ret_ir_exec() aliases seamcall_ret_ir_resched() for
> >   * documentation purposes. It documents the TDX Module extension
> >   * seamcalls that are long running / hard-irq preemptible flows that
> >   * generate events. The calls using seamcall_ret_ir_resched() are long
> >   * running flows, that periodically yield.
> >   */
> >  #define seamcall_ret_ir_exec seamcall_ret_ir_resched
> > 
> > TDH.IOMMU.SETUP uses seamcall_ret_ir_resched(), and EXT-SEAMCALLs use
> > seamcall_ret_ir_exec().
> > 
> > How do you think?
> 
> Sorry I don't quite get.  What does "exec" postfix mean?

It is 'execution', means EXT-SEAMCALLs can resume their execution. But
since you have concern, maybe some better name?

> 
> From patch 25, they are all in TDX core, so I don't quite get why we need to
> distinguish EXT-SEAMCALLs vs normal ones.  IMHO it's an additional layer which

EXT-SEAMCALLs have generic way to resume, while others don't. So we need
a helper for EXT-SEAMCALLs. For other SEAMCALLs that happens to process
the same way, we are avoiding code duplication, but should clearly
distinguish the purpose so make another name as documentation.

But if any concern, we could delete the int-retry support for normal
SEAMCALLs, they are not generic as you said.

> doesn't actually help address any problem.
> 
> Btw, we should really get rid of the "resched()" postfix from the function name
> since cond_resched() is no longer needed and possibility of rescheduling is
> implied pretty much all places in the kernel code now (except some special code
> such as code in IRQ context).

Yes, thanks to remind me again.

