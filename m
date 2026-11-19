Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107073;
	b=bQAHM1CYIdgvIPUv5fDE3mUOJlOFng0SiZe4yy4Dt09a2rm6kREI2TeCNvluQcHRx9fl
	 wtNvhEoae96FFAJm454WM+6VdLdFDdyKjqxo5rcfKhWJCF1ZcW0WqsCSLGId/53hbvEDE
	 LqjDmKjm+im6KHHPOEexDcaZA18PO1LbaqK5NmLhQzxqOmWegL4k8KV7s6j2ZJz2TlP+u
	 KuHLhykdLXeQBecf8ff7Vs71n24G2AOPRdB6PQ9eiqYcgX/7OZyrcj2fDmy7bjVG5POs/
	 77jVyLDRyr3HwpZPVbRdO8IDLcjlBmLMBQRftaHXc4Jc1PUACyRg9S3yS1SnBJfxN6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107073;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=+Pa7zujiqaQ9mN6ie/tniePVD23YMAntnT6ltlzFK7A=;
	b=W0Bt1ni9tLHEVqXT189FBcmY64iWPd6DlSAzj6gsxOBtiYLTeGqY/nA3fnncNsYjNf4Q
	 9L7lpr1eEXbjZXl7xaB87hqFo10y/SFsJAaPFHG59hiKK6yGUxdE6i1R1H/UM2gZEM8lJ
	 MSlmW+ESRI29x0RlHe56ge43XhccPxyzmVzbF2ZicdKDLadfxdOQaZyPpPFY91DDJif3w
	 ou2Ak+elX/UlCXL0x9nOE3rtsne/YFFSiaRTkQ+rRU5CIo+I9CyZ2tE7Jy1wF+Ism5qJH
	 Utm/Dn4nr/j36ksigApYljMCpAs7CkfEzxiCOfBXyMbfoMVFvdkTcs8ghDgO7QzkUXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGRr3SDZ;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3579C606A334;
	Thu, 19 Nov 2026 16:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3579C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGRr3SDZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795107073; x=1826643073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CnH3d7KYmA9dFojq0/2V4Q5BLbuUuGiihFiPmBh2Alo=;
  b=lGRr3SDZ466BsKV5q01nalBDobcWcgCoELyrsRrSbFuXd7Y3Qblpcwzj
   2T/QbGCtRFXWx3qmkYHMK1liQ6OnsXFeBJBP381owuVWuPmrbEZTUYTDD
   ULINOv3X6WnCh7ZIGFmW8vcqnk0b7muMf+GYDQzBhWOL7Ka9xooTFIqKM
   Oc4oKE109VQCErQhKtpVryo9s5z1p5KVbdocCjg9cSd0HQFGC8YdXdI/+
   thnUHJd5wtsmbkDhm8KMQV5srdvSQ/aqpo/X+y8tzX/lVH0/eTqATlHiV
   lsDEyyBxA7tVWQfPQDGD9oChh+fXZ6n/4Mb1jYnacORFb8PpO78xJnE1S
   A==;
X-CSE-ConnectionGUID: QCGnVbyNSFe7inVH7+pXlA==
X-CSE-MsgGUID: Je6AuPm8QhGrD6Ymsveq3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3995993"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3995993"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:51:12 -0800
X-CSE-ConnectionGUID: a3Iu+BfVTJ6HzXjxRnfILg==
X-CSE-MsgGUID: 5AonpJSxQeGpsEkRGR2ImQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12203555"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:51:10 -0800
Date: Thu, 19 Nov 2026 18:51:06 +0200
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
Subject: Re: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Message-ID: <av8o-tHHScd0gjZM@ashevche-desk.local>
References: <cover.1795097970.git.habilerenturker@hotmail.com>
 <29fcfa729d7f687f66578781c2e23db9e3367c86.1795097970.git.habilerenturker@hotmail.com>
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
In-Reply-To: <29fcfa729d7f687f66578781c2e23db9e3367c86.1795097970.git.habilerenturker@hotmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 02:35:46PM +0000, Habil Eren Türker wrote:
> Add helper functions to extract, set and compare PCI power
> states in the Power Management Control/Status register.
> 
> This follows the discussion with Andy Shevchenko and
> Bjorn Helgaas in response to:
> 
> "[PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()"
> https://lore.kernel.org/lkml/20261118161559.63617-1-habilerenturker@hotmail.com/

Make it a Link tag with reference

  This follows the discussion with Andy Shevchenko and Bjorn Helgaas in
  response to "x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()" [1].

  Link: $URL [1]


> Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>

...

> +++ b/include/linux/pci.h

>  #include <uapi/linux/pci.h>
>  
>  #include <linux/pci_ids.h>

> +#include <linux/bitfield.h>

Put it upper to the proper group of headers (they are grouped from the generic
to custom).

...

> +/* Helper functions for PCI power management */
> +static inline pci_power_t pci_power_t_get(u32 csr)

Why u32 as it seems the value is 16-bit?

> +{
> +	return (pci_power_t __force)FIELD_GET(PCI_PM_CTRL_STATE_MASK, csr);
> +}
> +
> +static inline void pci_power_t_set(u16 *csr, pci_power_t state)
> +{
> +	*csr &= ~PCI_PM_CTRL_STATE_MASK;
> +	*csr |= FIELD_PREP(PCI_PM_CTRL_STATE_MASK, (__force u32)state);

Why u32 and not u16?

> +}
> +
> +static inline bool pci_power_eq(u32 csr, pci_power_t state)
> +{
> +	return pci_power_t_get(csr) == state;
> +}
> +
> +static inline bool pci_power_gt(u32 csr, pci_power_t state)
> +{
> +	return pci_power_t_get(csr) > state;
> +}
> +
> +static inline bool pci_power_lt(u32 csr, pci_power_t state)
> +{
> +	return pci_power_t_get(csr) < state;
> +}

Same questions.


-- 
With Best Regards,
Andy Shevchenko


