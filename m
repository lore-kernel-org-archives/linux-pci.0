Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108815;
	b=FIJGYoUg7I98ayyDVwV8sKPRMJ8VEDQ4JWm6fa7ZYfB7CITzefcvw06H8H2JqwZdNtO4
	 vsUKM3rwAtzbZ0/Ka4XAYF70ppy7Ew3k5aZMdjziPgTyct0bJJOZJprq2nTCVPswHJhn3
	 7Z3edJEwBd+g3EgRIJls2Yk8JaUDkzp7b42Zfs0rywRME6uBsXF9lin7IpwNNsVJC5Mk/
	 saYdYOavXulAUIbI2FVNqW/ZbMkJdWwHWY20/SdLNkMqbRfDLZMFPealfViH/WTtAQsl7
	 Os6N+qVtyuPT5LDaI9b72tI1vkwBLZcfAUMcNDFS3RGflqLeCWRszTGBf/XetdkBcCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108815;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=8Ge2WQzGQou5m5iXlFVrByEdadHDbLZbKB5sJnAHTIA=;
	b=chjz0xGddfXluKT8V8Fq8Sfd3H3dp7eMGZB1N8tSB5Tm365buaFzxKG3mPf46mjx/C0S
	 n/SNzzZsMOCuE86Y+aX4aFdPtcswZLTedpcQEYp/ARHRiwvfFcDEqiQe+WQwf0z4HPD4/
	 hEVeCRWSiJ6vct+gddjWmLQjnlVUhY/ETvM0NVDemu39puXhHfw+jI/DRTTMw13n3BmXX
	 HUNKkX+SCuDCTYHsWNTdfZH9TuXSLj3zsnl2R/SwE6MD33lJMCR62+iVpxWmSdS0SVbcY
	 kfmFYChCCZsqu4bPqBDIkgRUOM46/YzKA0FKarHF8iMGa8z+BMekm1xMAIviI98X+IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZvQMELaV;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F255606A320;
	Thu, 19 Nov 2026 17:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F255606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZvQMELaV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795108815; x=1826644815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c0J1T5ug2tsH8kUc1MFy5HFxfJvH6/YtVrq7GTuLUTw=;
  b=ZvQMELaVYl9/1HehUvX4W12cErlwzsywqYhBhlDPX3bLQYid88dISpcT
   sE6HKVhv91wK1Z7EYnZtBd/hfClEWqoou96Ywf6JEzu2mTi3n+BKC2Q3c
   xyF/0qp4UNm6qzo/uOLm1EUg4LUXe2FzRlIqSBtWyS8Pd8t9nNYIdtL8l
   0oqk0JZWVCXpi734+C7h5ndTNJzz0dxl4iH6DCw5tHgqoDofy+Dviyi8E
   O5kBAVZrhQbSN2In+1CHroIYbdlOvf9XEQ7BZSV8aEgPwDsiaLezaeMaK
   mZu5SQaaSerK0Zg6rnaY7yjBXOI+Nl0JqcAkt9qTj019s0AIF9BxCem4o
   A==;
X-CSE-ConnectionGUID: bhei8FD7QwuKaTRxReiu+A==
X-CSE-MsgGUID: Ilp0HjwHSzeK+NhFSCEG3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3959122"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3959122"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:15:49 -0800
X-CSE-ConnectionGUID: 9dmdraZKSPyeX/tkRp+u5Q==
X-CSE-MsgGUID: 18IcvhUHRCOHw8kGt1MIYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10381950"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:14:47 -0800
Date: Thu, 19 Nov 2026 19:14:44 +0200
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
Subject: Re: [PATCH v2 4/4] x86/quirks: Use pci_power_eq() in
 apple_airport_reset()
Message-ID: <av8uhCdgJ9hX4eLT@ashevche-desk.local>
References: <cover.1795097970.git.habilerenturker@hotmail.com>
 <b690019334998f34feb12ee06db7e99c76815bbc.1795097970.git.habilerenturker@hotmail.com>
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
In-Reply-To: <b690019334998f34feb12ee06db7e99c76815bbc.1795097970.git.habilerenturker@hotmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 02:35:50PM +0000, Habil Eren Türker wrote:
> Use pci_power_eq() to check the PCI power state in the
> Apple Airport reset quirk.

...

> -	if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != (__force u16)PCI_D0) {
> -		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> +	if (!pci_power_eq(pmcsr, PCI_D0)) {
> +		pci_power_t_set(&pmcsr, PCI_D0);

Haven't checked the code, but consider (if enough users) also have

// update state if it wasn't equal to the required
static inline bool pci_power_t_update(...)
{
	if (pci_power_eq(pmcsr, state))
		return false;

	pci_power_t_set(&pmcsr, state);
	return true;
}

	if (pci_power_t_update(&pmcsr, PCI_D0)) {

-- 
With Best Regards,
Andy Shevchenko


