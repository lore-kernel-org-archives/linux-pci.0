Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E1330649;
	Fri, 24 Apr 2026 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001372; cv=none; b=AJJZsGM3w6JLlWmK8jLGVH6JddCKcjIFzCCDhBUVgLLPEXuE3zPEGtSIQADo3KHpC93sMl1xPD+1pbJysOBc6Gh9uP49A3hnECDIBztUREnJkTJZV0D70PhqAhK79psLHrX12skNN37ncrl8NzMYfg5qBkPko1/7jLuT5hQC8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001372; c=relaxed/simple;
	bh=HpuCmuXgKFNVfa7fOFxx43mjPTaa9XZF3Zi7xcXvleQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSeBkf10g28rfvKkg8VqFhBq1BCiwgnMFMdZZdwgyzZCi6Dof1bA7/MPR4k48TzxAZ5uxM2vbvwAC7q3us+JN4NaeSU78oZIq2fCdmdyBUmiwlz1Co/MBAt393oV0mjsb84/tTixnalaZAhGglgkYNXaha4MSv56CFsTDK/dDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgMB3oCs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgMB3oCs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777001368; x=1808537368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HpuCmuXgKFNVfa7fOFxx43mjPTaa9XZF3Zi7xcXvleQ=;
  b=mgMB3oCsn42ezmmg+NOVZdn0ggKJCDGyW5UFCPZlyVrB+RKnsR9S2Jar
   CXjV3IkkzML7aVwZ6Ni5V+2DpWmoObqNocIJJ0rDUb8Gs7UWVMmiGB4he
   ExAG72ya7ehp/Si4E+iYTzgxqHgxSQbsOXTIWBBY+7rfP8GnDdcwXzr1z
   CFmkd7nna6oh0VnNyZFrG1zTfX0Dhf1CloERmo77C17SV2/vtZ4NoqW8y
   H107Sc2HM5cxVc2lIZD5Z9OSqnnNU4UbvYwkvo4zej4Ig6sOkKKwoh/IE
   0T3wXJWpTr4eFxq1MyXsBjbzqNNaoKITO4lWxphGyVZCS0drd3dKT9G+J
   A==;
X-CSE-ConnectionGUID: vEVhGfbSSVm2+JMciT/zTw==
X-CSE-MsgGUID: s/ang/2BT6umXqaN0NTljg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77863808"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77863808"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 20:29:25 -0700
X-CSE-ConnectionGUID: vDHIQFPoStCYEu2xLwv0iA==
X-CSE-MsgGUID: q3RfJiJbSLGV792cxC3xeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232745293"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 23 Apr 2026 20:29:21 -0700
Date: Fri, 24 Apr 2026 11:07:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Message-ID: <aereVy8zVb2be2hh@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
 <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
 <3b0bc0dea544b10bd2fb0304a96d2671f263829b.camel@intel.com>
 <48171f4ab772da546beccec3c7a95fe442524b42.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48171f4ab772da546beccec3c7a95fe442524b42.camel@intel.com>

On Thu, Apr 23, 2026 at 10:29:31PM +0000, Huang, Kai wrote:
> On Thu, 2026-04-23 at 17:05 +0000, Edgecombe, Rick P wrote:
> > On Thu, 2026-04-23 at 00:59 +0000, Huang, Kai wrote:
> > > Ditto here.  I don't think we should introduce any more cond_resched().
> > > 
> > > Btw, I think technically we can reuse the seamcall_ir_resched() you introduced
> > > later, albeit in which a local '_args' is used as a copy of the original 'args',
> > > but that has no harm for the case where we can just use the 'args' to loop.
> > > 
> > > I am wondering whether we can just use that here, or we just get rid of that
> > > helper (then open retry by the callers of these SEAMCALL wrappers), since there
> > > will be more cases where we need to manually set 'resume=1' in the SEAMCALL
> > > input 'args' when retrying TDX_INTERRUPTED_RESUMABLE.
> > 
> > I kind of like the latter option to open code more of this stuff. The stacks of
> > seamcall wrapper macros is already too much. 
> 
> Agreed.
> 
> And SEAMCALL *users* can actually come up with their own version of wrapper(s)
> to do the retry.  E.g., currently seamcall_ir_resched() is only used for IOMMU
> SEAMCALLs, and we can put this wrapper in the IOMMU code or coco/tdx-host.

After we have introduced TDX Module Extension, irq preemptable
EXT-SEAMCALLs become a common concept. It is irq preemptable so that the
secure world remembers and resumes the context, no need for host to
remind via resume lag.

Today there are 3 EXT-SEAMCALLs, TDH_SPDM_CONNECT/DISCONNECT/MNG,
irq preemption handling is a general requirement for them, and I think
it is still true for any further EXT-SEAMCALLs.

So I think a general helper for EXT-SEAMCALLs makes sense.

TDH.IOMMU.SETUP, however, is another case. It is not a EXT-SEAMCALL but
happened to follow the same irq-retry handling process. To avoid code
duplication we have:

 /*
  * seamcall_ret_ir_exec() aliases seamcall_ret_ir_resched() for
  * documentation purposes. It documents the TDX Module extension
  * seamcalls that are long running / hard-irq preemptible flows that
  * generate events. The calls using seamcall_ret_ir_resched() are long
  * running flows, that periodically yield.
  */
 #define seamcall_ret_ir_exec seamcall_ret_ir_resched

TDH.IOMMU.SETUP uses seamcall_ret_ir_resched(), and EXT-SEAMCALLs use
seamcall_ret_ir_exec().

How do you think?
