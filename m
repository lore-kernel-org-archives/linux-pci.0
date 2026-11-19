Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079106;
	b=StKtw4eCiMXI5CBsvuvnZ7TnuOGQaroAupoeCQrhMj45mxWYCdNDHBilUteCOKaJbiSl
	 fXMwZVUinaWIF55pna/tzoC7Fcz6wkkXQLXpplBOMh73ZeLkxckHFc2faLGg3USkFKcU7
	 tRTydFrP9KPuh+7Bqsi1SqHsBGGzsh+7QcT41FyTIktzyTHcG1kBfpOQeDEtkRDv0YoV4
	 +qd3TeWtpSV3Icyz+t86Kre5f4pAsBaYCs36LT7CE4eb5yxZKEAToxoWMVuskWWAMirGi
	 N057wxU5L8JQJbdD+yAACCCVZatwGhgW8bStnNxNlzNNgVPN6LBY6jiCWgk8sEHNDYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079106;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=d6kA/1xsJAWmvsFQBc9q8FWAGrD7HMA1X8iHy6g3vR4=;
	b=rnI8fbVuENutzYOg4nf8zlvX/S2m1+8pGyB1qiQAC36hKMmdiKUmLAaRDzD+fCnZBNPV
	 rpRfATTXH6Mqz4TbASlCoBg8J/u9gsLNaxp1fjWdWnK81FPyzxo7HuRgyWWNocloftB95
	 FkDmmGfst6PqJgRO55MRjdoj/S+lkWo5cSYYypnhwbKksYIbEPYYB6aN18YaYImW5wKOH
	 hoPs5FYgRE/A50Ama+JRZBS+fis3bRO5/JVyizn7MWgceq/uLcQiOBwW8BqSx6Qn5yGA/
	 tsF19NBJVf8Lmn616LN4MRKlR1s74mtYQbUwhzhhw0NEgBjfCDG7y/7JnbE61xqoeyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VqGidOOd;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6C60A2610;
	Thu, 19 Nov 2026 09:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C6C60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VqGidOOd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795079106; x=1826615106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FQL8eV4sRkL61iCN0vkwUyVt/9ZbkgRxf+TN5O34HLs=;
  b=VqGidOOdVKZTixg0fVdkuMR5tBmc0AJmZ98Z+58KcaVHSC0iBpbQ9QY6
   u8IbKBp9TR4sHIbcXYCMKEXr1OhRz9bwKVbJtHXraRtwQAwPJ/EELrSc1
   ppOND5o9xth9opCzO+refz2R2zcOelmQF2/cWUtu7pdjNv6ntlAi69Xoj
   JTTjffB6RhekNLLdKrAMSEMvB59J9wAh9T+VyOlTFjIYK3htQRnq+QyvR
   wyFXy86W30DvO9G/pxqPCxso9sV7mXiN1+HQPe6vvi2cVIt68mEqj/pUv
   m+yvO7vMmajlppw78RG/yW9fA+YgBbz2qE3bq1a/SaBw0I+l+7xiN+iIv
   w==;
X-CSE-ConnectionGUID: jKcU2wrJRXS9okr4wTcPjA==
X-CSE-MsgGUID: zj7LmG90QBaxQZBjueUD4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3946797"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3946797"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:05:05 -0800
X-CSE-ConnectionGUID: h2v3AucXRfqq5fed2bRS6w==
X-CSE-MsgGUID: 6mtu8x2AQ36gVprPng12qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="12334238"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:05:01 -0800
Date: Thu, 19 Nov 2026 11:04:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()
Message-ID: <av67u5GSVL0KWolF@ashevche-desk.local>
References: <20261118161559.63617-1-habilerenturker@hotmail.com>
 <20261118181408.GA625801@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118181408.GA625801@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 12:14:08PM -0600, Bjorn Helgaas wrote:
> [+cc Andy since he's fixed similar issues and may have better ideas]

Thanks! Yes, bitwise types in sparse are interesting thing, but since we want
to continue using them the easiest way out is to cast to pci_power_t.

> On Wed, Nov 18, 2026 at 04:16:03PM +0000, Habil Eren Türker wrote:
> > PCI_D0 is defined as pci_power_t, whereas pmcsr & PCI_PM_CTRL_STATE_MASK
> > evaluates to a u16 integer.
> > 
> > This causes Sparse (make C=1) to report:
> >         warning: restricted pci_power_t degrades to integer
> > 
> > Add (__force u16) casts on PCI_D0 to explicitly eliminate warnings.
> 
> We have a bunch of similar sparse warnings in drivers/pci, but I'm
> kind of hesitant to just throw in a cast at each one to avoid the
> warning.
> 
> About a third of the sparse warnings related to pci_power_t are
> similar to this, where we're extracting the power state using
> PCI_PM_CTRL_STATE_MASK and assigning to a pci_power_t variable or
> comparing for equality with PCI_D0.  I think we can fix these with an
> accessor something like this (better name ideas welcome):
> 
>   static inline pci_power_t pci_power_t_get(u32 csr)
>   {
>     return (pci_power_t __force) FIELD_GET(PCI_PM_CTRL_STATE_MASK, csr);
>   }
> 
> There are a few more we could fix with an analogous pci_power_t_set()
> or similar.  Most of the rest are arithmetic comparisons (>, <, >=,
> etc).

So, we basically need only two (the rest can be derived with negation.
_eq() [equal to] and _gt() [great than]. It may lead to have code in
a better shape from readability point of view.

-- 
With Best Regards,
Andy Shevchenko


