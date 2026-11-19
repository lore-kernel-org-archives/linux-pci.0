Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108277;
	b=gy6OIEGH0Svw4QzMUkmXMUU7aa4Eu/oDregmHEZXU0gJA/pzBrLWbDnv/pLpYxNI99dt
	 2/mFsCGnJNF4FNtgP+JrGzrsdSuvEDw/ZpzaFBQxy/88ftlGF3ECQb9w6A3ytMZEICGaz
	 YxD0zmyRkykM8TDurWClipiifAfU+pKZNYxKOcimocO+lM5Xt/TuLFOmEjNADOeVMr0jX
	 aJqWnmSgJiz8k4YZGQ9PjGPs1awlPXbPM0qj0nP8yjRkTAy5qIYBMY6MbSMwlb+ClRRRh
	 8luI/1ug301mhecKEFdJ3CA2MsViTE+0gUPKNSzA/0jpD0O1lJP52kJ653T/WWBOkUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108277;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=/rKwXD6aWhNW6EufF2OCjepPMrhZ5b/Et12fmNFPj+o=;
	b=ixNeB1SDwvT7qnvzDwIvh/kEsEUyTIPGwPoFHTKV9GaL4ir9mdSR6q6+LIrs/ngEOWpD
	 t0IKMrukkKCPrDKU0XIMRNDFjhFaAIpiYYqWnSbNYIwbBMwv8xeLxx2V3U3JT3VUU6YSD
	 ykt9oKwrhfNS9+QkFAHgXD+utl8KS3u0Xgnz3zetd+gQ+/XSjgz+KzBTB2EaIINN0yuqG
	 PVP8r6w7BjwAKIytV0MMg5qh3QQiTQg//fdCLw0JMOJcSMgdkOvkFaDrBHGXMV/et2unG
	 u/QinT9e7NsvaPhjxK33A5tmAI8kyIguwCKlU1Kh0S3zWFpIGi12Tm3XLOa08+PFE8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WFENZIn6;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAC606B424;
	Thu, 19 Nov 2026 17:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EAC606B424
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WFENZIn6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795108277; x=1826644277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jgNSQF13vG3fkTY2Dpik2Anx43OBPR7B4vpzRfIGRFg=;
  b=WFENZIn6keme2u8prFR7ir5fJ54tQ8TEoSYD2IhZnLA4kEqW0JAp5oNw
   rM2Ef/6LPYMeQbDfLR2lDEqPaFNBvYJjyVXC+Xc+RIGDur/7kNcmTSaAC
   omGkwB6aRKSqrREqRKDu13vPuEsTJqjoD/rjVamvLUsld12VFPDP4fs9k
   OAsPCZ6btell4RKmJr4d15IGBFlzW1phKdSEcYzMqvBmUHdNJl5tiPs45
   n0xqIflZvqAGC34FSJofteT96I0tEEquRts2AdjMxHGIwOJQNVUSkxzYY
   7SoNVEv4nz54u0FW+8kx0VsdeiE/WA6iO0Hzx9egZTzJGFAu8laVlPHrU
   w==;
X-CSE-ConnectionGUID: pANT+PpLQXyYm2luVEQ2Gg==
X-CSE-MsgGUID: 7n857REQTJytgjghTh1lsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3854134"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3854134"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:11:06 -0800
X-CSE-ConnectionGUID: oNGQMMANRWWm3yHifXK5qw==
X-CSE-MsgGUID: zL+CP+9YRVikchC1IOCSxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12323661"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:11:04 -0800
Date: Thu, 19 Nov 2026 19:11:01 +0200
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: Convert quirks.c to pci_power_t helpers
Message-ID: <av8tpQO7KYGUXQmN@ashevche-desk.local>
References: <cover.1795097970.git.habilerenturker@hotmail.com>
 <4ec395bd084e703fe6cacb31bf287a739cdab35b.1795097970.git.habilerenturker@hotmail.com>
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
In-Reply-To: <4ec395bd084e703fe6cacb31bf287a739cdab35b.1795097970.git.habilerenturker@hotmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 02:35:49PM +0000, Habil Eren Türker wrote:
> Use pci_power_t helper functions when accessing PCI power
> states in PCI quirks.

It's a single case, so you may put a oneline sparse warning here.


-- 
With Best Regards,
Andy Shevchenko


