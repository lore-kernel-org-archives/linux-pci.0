Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A653C9454;
	Mon,  6 Jul 2026 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329425; cv=none; b=VZcVrk1MEwgPRfDs38eg/F/LaI4cd/eezc2nCrncLxyoXVQ2fCIz+UPVzKntrC5hWbDd39EemyYI7JS6ObDMWgcpazYN6qyABaTsaYHBwOGhQFMRn8y3YfBu8blY/yKd7Kq+jMzcyC2YD6MNHcbEcrEXQx4byymC7BfC0z4HIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329425; c=relaxed/simple;
	bh=r8IHjgajWWCYQeCDyqlBFZQ+jiagfASXseQII/EtCXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue0tHeX+TVdZcoxKFc01J8hexyQCjGSdpkGLZENI9bgu715JRbyAkwRkRKSAVm44CwrfGSz2EbWiw0xqiTOVtcXOmLfMv5ZE9G+2pxN+Q908nxEETTLIrh+kw5OF+cxUpN6phqJH+O60CfFV2OAThZwrnjX5/+CAG6X+Pdfd83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6RHYSv4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6RHYSv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783329421; x=1814865421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r8IHjgajWWCYQeCDyqlBFZQ+jiagfASXseQII/EtCXs=;
  b=i6RHYSv4EV725yzAjlTFRsp/BZvhoXSPHG1Bcv1AoEWUUCUg/KOhGyHW
   pLEvtFxK/ffd2Ximp1YN8wGAGTk46sWAHT+QsG9XHozQFwMtczZi4WFPV
   B1wrrh2LPt07IVQqYTx6Hg0wiPYpGC7GvfFFfLaQ583/zXW8cz2udp2Lt
   v/UQYUfwzFsO6QA1rjrRoAO48sMZgwtDPYdGiKEXHsWhXIi4IJ03KDGJ7
   YCDIloEZgqUXkqwkgm651zOOQXtBAQvlByMdt1UU/6NNPhp8GxnJozlDY
   dbhiORksxFlty/2dnRlxck5O/rx/ZZp+YGBSV7r2KpG4dap8jJQjivN39
   A==;
X-CSE-ConnectionGUID: z2YkQrMGSECksD78A6ajKg==
X-CSE-MsgGUID: AwOF1jPSSyuSsy3DefrXgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87874114"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87874114"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:16:56 -0700
X-CSE-ConnectionGUID: Rrj/AClhTViGonEcemZGMw==
X-CSE-MsgGUID: fmG3KLkoSNS9rV8fv5x97w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="283757779"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 06 Jul 2026 02:16:52 -0700
Date: Mon, 6 Jul 2026 17:16:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, x86@kernel.org, chao.gao@intel.com,
	dave.jiang@intel.com, baolu.lu@linux.intel.com, yilun.xu@intel.com,
	zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on
 TDX_INTERRUPTED_RESUMABLE
Message-ID: <aktyg51hj0SeSG50@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-21-yilun.xu@linux.intel.com>
 <CAEvNRgGgTkOPWELeg5U3pjjw9NZOBQ5zswWy=MRxOXsUXXuFhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgGgTkOPWELeg5U3pjjw9NZOBQ5zswWy=MRxOXsUXXuFhQ@mail.gmail.com>

> > +static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func, u64 fn,
> > +						struct tdx_module_args *args)
> > +{
> > +	struct tdx_module_args _args;
> > +	u64 r;
> > +
> > +	while (1) {
> > +		_args = *(args);
> 
> Is this copying meant to ensure that every retry has the same input
> args? Perhaps a comment should be added so it's obvious that every retry
> will have the same input, and outputs from each retry are dropped.

Yes, that's the intent.

But now I've found this is not a good convention for INTERRUPTED_RESUMABLE.
If outputs are necessary why we drop them, if outputs are not useful why
we output them to overwrite inputs. The fact is that TDX module only
outputs all 0's to zero out the inputs, that makes no sense.

So we now switch to another existing convention - if there is valid
output, use the output to update the input for next loop, or keep the input
unchanged. This way we only need to:

	do {
		r = seamcall(TDH_XX_XX, &args);
	} while (r == TDX_INTERRUPTED_RESUMABLE);

	if (r != TDX_SUCCESS)
		return -EFAULT;

https://lore.kernel.org/kvm/20260618081355.3253581-6-yilun.xu@linux.intel.com/
https://lore.kernel.org/kvm/20260618081355.3253581-5-yilun.xu@linux.intel.com/

> 
> > +		r = sc_retry(sc_func, fn, &_args);
> > +		if (r != TDX_INTERRUPTED_RESUMABLE)
> > +			break;
> > +
> > +		cond_resched();
> > +	}
> > +
> > +	*args = _args;
> > +
> > +	return r;
> > +}
