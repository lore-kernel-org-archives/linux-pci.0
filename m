Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482738C2DE;
	Thu, 23 Apr 2026 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963826; cv=none; b=j1yeA2dRUg7ccjVBuKBg7+S+Ib3QTrK8ZBYt+FIDIKO9aAX+plTtFeR9KxIt4tYF1l4s7IO97ONVjpZQzUwDREOv7zM9tIKYDI0d6y/QDxJblwQwPpU64GB+6+Vb1ItK5hyxMAHnuuwYW8PU2/SL8K9KC9PGiaPOoWxyhK9rWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963826; c=relaxed/simple;
	bh=JQVWx7RaIDbESE9oPeqlS8yppidlsNm3EhrW2QSV4FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyzUT2tnNdkP1Q2OwFWMJZzYjXtwVYMuo4nGkglUPWdGrqrppcYWqhii5o/OJmVrrt5DahzZuGkH3+Y5VJlBSXk+H19fdMB3LKZTTlCzGoZIiB+stXRsfC58dejcduopdBPyCmI3BPwTVicybH7owVzjDbgKMz9YUS/ConigYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U01BanXf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U01BanXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776963824; x=1808499824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JQVWx7RaIDbESE9oPeqlS8yppidlsNm3EhrW2QSV4FU=;
  b=U01BanXf80hkdzWZ1KTty5SW5ZXTa3wO8hhQyi7fUWi0KwtQv3koEi6x
   JSjdOvGs5Y4PU3J0nvrU9CYodlugUMgYonuKZH8nakDtUE+WqNxKqwx49
   0SajcwCIWGyiJUAcAyJ3dIB6RZUUH5LsmhFymunjvysH1WLewHZBgrjK4
   54IAhcsNYfwXClGzzxMSPMFRMOuIX3bkGFRtuhK1qx26imFwULvMeavXB
   sez59r0NIAElJeW2xlc1dZRyHN3OfhcK5NXrH1cFecTGqeqWWzDC7/clW
   Cvkza17u0AgCVhS/Z0Ty/1OsXjrr/SXp4J9Vr4Gjj0VlBIkbPADX2d0+E
   w==;
X-CSE-ConnectionGUID: IjFzSO80R+q2FyNvMBObLA==
X-CSE-MsgGUID: pTH1RkVrQICG9SAah2gUgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88634137"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="88634137"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:03:43 -0700
X-CSE-ConnectionGUID: ithzOzeGTPu1MKhvwWn4pQ==
X-CSE-MsgGUID: yNROL9LKSGe+PXzQHmaUTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="256216467"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 23 Apr 2026 10:03:39 -0700
Date: Fri, 24 Apr 2026 00:41:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Message-ID: <aepLsi/cHnw3Cfgs@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
 <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>

On Thu, Apr 23, 2026 at 12:59:55AM +0000, Huang, Kai wrote:
> On Sat, 2026-03-28 at 00:01 +0800, Xu Yilun wrote:
> > +static int tdx_ext_mem_add(struct tdx_page_array *ext_mem)
> > +{
> > +	struct tdx_module_args args = {
> > +		.rcx = hpa_list_info_assign_raw(ext_mem),
> > +	};
> > +	u64 r;
> > +
> > +	tdx_clflush_page_array(ext_mem);
> > +
> > +	do {
> > +		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
> > +		cond_resched();
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> 
> 
> Ditto here.  I don't think we should introduce any more cond_resched().

Good to me.

> 
> Btw, I think technically we can reuse the seamcall_ir_resched() you introduced
> later, albeit in which a local '_args' is used as a copy of the original 'args',
> but that has no harm for the case where we can just use the 'args' to loop.

No we can't. TDH_EXT_MEM_ADD is designed to use output parameter RCX
to override/update input parameter RCX, so the caller doesn't have to
do manual parameter update on retry call. Using seamcall_ir_resched()
makes each retry use the original RCX, not the updated one.

> 
> I am wondering whether we can just use that here, or we just get rid of that
> helper (then open retry by the callers of these SEAMCALL wrappers), since there
> will be more cases where we need to manually set 'resume=1' in the SEAMCALL
> input 'args' when retrying TDX_INTERRUPTED_RESUMABLE.

I'd like to know why some SEAMCALLs needs resume flag but others don't.
If there is chance we don't introduce too much variants for the same thing,
that's most friendly to OS. And "no resume flag" is my best preference.

For now, I can see only one SEAMCALL with resume flag in mainline,
tdh_phymem_cache_wb(). I'd rather we treat it as an exception and no
resume flag any more if possible.

Then we don't have to make all following efforts, they are complex...

> 
> Unless you have good idea to unify them all?
> 
> E.g., we have something like below in our internal KVM code, using macros to do
> 'resume=1' and retry as the caller wishes.  But my understanding is Dave
> probably won't like macros.  :-)
> 
> (you may see broken indent/text due to text wrapper and sorry for that.) 
> 
> /*
>  * ...
>  *
>  * The retry_func and update_args allow the SEAMCALL to be retried in a loop if
>  * it can still return other error code when there's no race from both KVM and 
>  * vCPUs and can be "retried" until it succeeds.                               
>  */
> #define tdh_do_no_vcpus_retry(tdh_func, kvm, retry_func, update_args, args...)\
> ({                                                                            \
>         struct kvm_tdx *__kvm_tdx = to_kvm_tdx(kvm);                          \
>         u64 __err;                                                            \
>                                                                               \
>         lockdep_assert_held_write(&kvm->mmu_lock);                            \
>                                                                               \
>         __err = retry_func(tdh_func, update_args, args);                      \
>         if (unlikely(tdx_operand_busy(__err))) {                              \
>                 WRITE_ONCE(__kvm_tdx->wait_for_sept_zap, true);               \
>                 kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);   \
>                                                                               \
>                 __err = retry_func(tdh_func, update_args, args);              \
>                                                                               \
>                 WRITE_ONCE(__kvm_tdx->wait_for_sept_zap, false);              \
>         }                                                                     \
>         __err;                                                                \
> })                                                                             
> 
> #define tdh_intr_retry(tdh_func, update_args, args...)                        \
> ({                                                                            \
>         u64 ____err;                                                          \
>                                                                               \
>         do {                                                                  \
>                 ____err = tdh_func(args);                                     \
>                                                                               \
>                 if ((____err & TDX_SEAMCALL_STATUS_MASK) !=		      \
> 				TDX_INTERRUPTED_RESUMABLE)                   
> \	                       
>                         break;                                                \
>                                                                               \
>                 update_args;                                                  \
>         } while (1);                                                          \
>         ____err;                                                              \
> })
> 
> #define tdh_no_retry(tdh_func, update_args, args...)    tdh_func(args)
> 
> #define tdh_do_no_vcpus(tdh_func, kvm, args...) \
>         tdh_do_no_vcpus_retry(tdh_func, kvm, tdh_no_retry, ;, args)
> 
> #define tdh_do_no_vcpus_intr_retry(tdh_func, kvm, update_args, args...) \
>         tdh_do_no_vcpus_retry(tdh_func, kvm, tdh_intr_retry, update_args, args)
