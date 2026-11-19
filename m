Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088505;
	b=EzQswnpeolNvAORHsdLoeLbM6ojHoTy486xeCvTTqAQiT58aqEvTa3QZSyiVejx5581M
	 +U/Xbj5o8MlWOo1rU4+dee3YCemvMm7R9gurfFS042qLMyVNnM/DHRgUpJKIGp6MeKyf5
	 oS0H0Z4R6QOKonJToplqN1pjXauQN0RZi5UqQ2ncsWdCXzVPzhQnZbFHSWTKAAj4GWAXh
	 mluTfr1bO67MqBPjE0qSiDPwlF9K9YTCJCVtE3f8jH7bmDxD+JOVYXWAZlLZQTzsgQvye
	 VUsehfZqFSe5SxTN9ujigR2Upw/fkwjA8dV6pFmTpq92GGQqrQaT26ohJp/Z7VluRfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088505;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=8eKoZw1mVmkJ3K7SZbFPxrA38iOqUD3IVk7ZFve3imk=;
	b=3r5sY+HEt3zfmv6NnH5FWK9pBgmp8+5wwPJ0xFLStzNkvZg1HT9xsy/QV8u2TAWkTHA9
	 Z4co8iONe6004oMR9JX3VywH9u4Y4N3Pk4ryUcaTfUTPcOFZw5lPVbGCe4D61dY7N5/Zm
	 4UwRT9/DuqqGR7S1GRAo1HbrHjaYCCWsmDhX/53NGNjbpcrEXU8RihCMMeXUub2gc/QLp
	 GUb9xmyx+m2Qg3+qfPv72sTmTM5CxDlJK1yMddN5FEvuE1fTPC6nzO0tj1UkV/kAjf7lX
	 m5NXCUkQ2CqWModUZrAAdXQ/tgdW+JtqvVmFYRbTLpky5taMd89GxrPoHlbMjxP1/Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cio76uFl;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75771606A338;
	Thu, 19 Nov 2026 11:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75771606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cio76uFl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795088504; x=1826624504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=64inJ+zvx5b91QZnT9piUE+RNJKiuW3jDRJB09tJ0jo=;
  b=Cio76uFlvijcqrl4qtmbAo+HAgzXPHD5Lny1nZ6yt+7zQKsaikvFP8t6
   uNICvpukOojAxJUR/U+MSbruVbTz4xD040zonzlJBFg0FRE3RFG/sV0EI
   /udxQBlCv6FuQ0zXb9gH6SNGijn4x/+2K1m/6OXCJ/1KXXsmwjm2AWrpE
   vy7JEuu7po9BKr2koVgAu5SAUhNmdEosFuEB+rXZj/lqTJSTdMSW+8AEo
   wtqZxsvABT62iB9Xab5mBSVK33bYn0055K5gFr3/IxXX0uDcx5rysjHif
   fPQVbLSxJdPjWb5tzwfUk29iMkY0EfgEyPdLTPG38L3E/VDMPPux3fnDm
   w==;
X-CSE-ConnectionGUID: m/l0Gut5TWeGHNNjxDZoNQ==
X-CSE-MsgGUID: koQSWfQrRwmpl3dI9Xg0Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3923948"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3923948"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:41:41 -0800
X-CSE-ConnectionGUID: 0fiNSSL5S2y9PcAMgQbpLA==
X-CSE-MsgGUID: ciXcDNloRhm1WigoUp5/gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10448565"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:41:38 -0800
Date: Thu, 19 Nov 2026 13:41:36 +0200
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"habilerturker@hotmail.com" <habilerturker@hotmail.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()
Message-ID: <av7gcEykk-Sp2V8n@ashevche-desk.local>
References: <av67u5GSVL0KWolF@ashevche-desk.local>
 <20261119112124.6442-1-habilerenturker@hotmail.com>
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
In-Reply-To: <20261119112124.6442-1-habilerenturker@hotmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 11:21:25AM +0000, Habil Eren Türker wrote:
> Thank you both for the feedback. I agree that helper functions are a much
> better approach than spreading (__force u16) casts throughout the code.
> 
> These are the main types of warnings (roughly 30 in total) in
> drivers/pci, run with `make C=2 drivers/pci/`:
> 
> - warning: restricted pci_power_t degrades to integer (~25 instances)
> - warning: incorrect type in assignment (different base types)
>    (~4 instances)
> - warning: invalid assignment: |= (~3 instances)
> 
> The four helpers pci_power_t_get(), pci_power_t_set(), pci_power_eq()
> and pci_power_gt() would cover all three groups.

For the completeness the _lt() also needed, with that we will cover all
<, >, <=, and >=.

-- 
With Best Regards,
Andy Shevchenko


