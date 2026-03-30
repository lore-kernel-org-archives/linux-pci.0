Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39C39E180;
	Mon, 30 Mar 2026 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859309; cv=none; b=QQPKIVey5uDGBdW5l7S/uV6IG9YrC6947FD1CFVU+weW0TQvgme+/ae0/X1gt0o99643JlxA9cFJlHqe02gg3dnGygNO59MeVYQgqZtN91ma+7TYt7MaiMT8n/B+6XZr7zvQu1UuBv/N/PV4jMao2eSEjEbciIr5lt2EHpO9uyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859309; c=relaxed/simple;
	bh=l2bHC8LwINvO+IZl5D/cdzklvOqQJAZ3NWR5QW2XcC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntI+p6c+P1x7iMVXgJgzQPTFXlIc/Wa9kE4OIhiIYwcf09ju/UAGsHVRcs9oCq2UPNIRoht8xOUtKEtI8V1jv6q+xP2rq+F+3INasycRentfFYWcd501Nitd9rhwZQ7P6MGWyfp5Gq0uCVBqfKkd85SFqiVU4j28dlcjGo3QmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dB0lIU49; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dB0lIU49"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774859307; x=1806395307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l2bHC8LwINvO+IZl5D/cdzklvOqQJAZ3NWR5QW2XcC0=;
  b=dB0lIU49IOupKZrMiJtajUwWXhEYxVof0L3MRfThsUv+XnW6HxRMnKrw
   bHBXLvUJg1jbsoT3sDM+F9GI5OfW6E7vzrw9T3X47lnEVZKXpm2N6L5/Y
   lE2gMQRKDohAVW/ovVSZ9l77wbVm82W3ym9lFv5ZKAAT5FQOCwuF7BWeh
   s/r/fiAbnoWtE85nO5nqTR6lJAIX6R5FDOrFqE5wyIoLdPdriylscg+ML
   Cx5NMYrnNHDjzLEyYZ5XRRyMRe3hfCQg+MVPZ5kGHkaAj3UrJuM2wLJiy
   I+WK4eavpLQXkoyYjChICXyZGJ9bZr4/9C0TctHCrCD1XomOQLw61gJ0C
   g==;
X-CSE-ConnectionGUID: pnEy1YcyQqawQG4dy2wsjg==
X-CSE-MsgGUID: kUve1cxhRdixBCb+CJLdfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75023584"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75023584"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 01:28:27 -0700
X-CSE-ConnectionGUID: Yjis9Aw/T8CvuiGSt6vczQ==
X-CSE-MsgGUID: G0CulPKMSymqjBYrprB7sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="227603436"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 30 Mar 2026 01:28:24 -0700
Date: Mon, 30 Mar 2026 16:07:18 +0800
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
Subject: Re: [PATCH v2 02/31] x86/virt/tdx: Move bit definitions of
 TDX_FEATURES0 to public header
Message-ID: <acovNqeS5c74pVgL@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-3-yilun.xu@linux.intel.com>
 <4228c004ebd59f9737fb39c6c9815bf6e7711acc.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228c004ebd59f9737fb39c6c9815bf6e7711acc.camel@intel.com>

On Fri, Mar 27, 2026 at 11:45:39PM +0000, Edgecombe, Rick P wrote:
> On Sat, 2026-03-28 at 00:01 +0800, Xu Yilun wrote:
> > Move bit definitions of TDX_FEATURES0 to TDX core public header.
> 
> Patch seems reasonable, but not sure about the "public header" language. Maybe
> more widely accessibly header? Or a better name?
> 

Yes, I try to make it more explicit, is it better:

    x86/virt/tdx: Move TDX_FEATURES0 bit defines to arch x86 header

    Move TDX_FEATURES0 bit definitions to arch x86 header.

    ...
