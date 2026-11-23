Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428587;
	b=WLkmuDWGAG7BIbIIPw8IJDUPmGi94Qacll+rw0LlIVPyl3OXeYMnnAad7KSxq+57/JUz
	 1rKXYHdJQ2PvafncthbS4KuKXY5b03cLaom8M8QtT4PDPOd/AcCKD4DZktmwGEaPrTMvz
	 tvAwWmNZ8knRGtONp5vSj3k0I9D9dm1hdIwLj0UQdis7EIsohREu6DjUDukgR+59vowqf
	 vlOd2FRzEnydWq1A4h980EpbEMu+eOXy6GZtOoBjZhce2hjUD9fZlRWqa3y0QoLi6l1gl
	 XsEwmU2c7IRZduMzJTs1GacAETj+BNyLrIpBfeRR6CiwifMXpIbnxz/Vqa6Ntv4KjpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428587;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=vKsqzQdgilZLKKpEMaxqc13Wz1I+Yp83P9O1X9VdybI=;
	b=WRHiIWjCyDlvY5HacTzqvaDRenLK6F8+a0BWJNqYpozT/rq16Lrzbxb8vAV8dX5z7CkB
	 e5rDyilNf+AhAJQAps2g9wO+DAddLdRfqeyzyZRlBbZV6pTU+BmwS/KkAY0zx9eau+NrH
	 FAyO7tjNAXqu7M8meiiUlWf4Ewj9sj8WiwUjzShTR+9gLxY2rni1w1yoZgdDte19wAEdh
	 AnsT/nwXv3G9j25iPtX9QZeQHSRgiXtEim/k1ey1n/R3YAGBjeLShxPHVlCetyQuhcpHc
	 ifo0rlPqsdk5eCs47jabFkXVEnjgSjblaNuuF7hA8PwaIabRmOJi8Tzk9kXwMdVmYmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mS+q4Jld;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3788606A31A;
	Mon, 23 Nov 2026 10:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3788606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mS+q4Jld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795428587; x=1826964587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=umHwqwCgRH5NkFjHA77LT+2C8t4g3TBwxNLwFYUk57k=;
  b=mS+q4JlddpAUrcoCYuRrlVxXV86RS5EBDcxu4PFyDUHCuD+GErIN2k6F
   vIHpRLwUEHEHqFJbCeiSLeymOQp5gyCWiMZ+eavG+dwGKK3jNEkNldaPD
   hsbcYC38cxanywjWlI6+mbWVMfuuCl9Mo7N3ErgE/s+xNSxI7AvVt8zsF
   vB5TY/TooA1A6zBXW57QI4nM/bhoGQ8tX5PFkcCQ0lxlbU1YBE9If3h0T
   2DRsA9JQkmCrLiuTy5QSERHhvpSCidY8BYGWUv6axYgXE/Lp/LK1AplKD
   889TaG7WmupY4jCH6AkxhUA7H/8kbGeqdWAN/NzM61fSxn4QRCez9A++v
   w==;
X-CSE-ConnectionGUID: 0bJFFayvQbuR9Gi1yPfPRg==
X-CSE-MsgGUID: aO6zrNhKTC6CdWIhMEflgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4240052"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4240052"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:09:45 -0800
X-CSE-ConnectionGUID: G5XU8j3BTUScGxPoZxYh7g==
X-CSE-MsgGUID: 6rR+wzVNSxqNE8VnnNlTsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11158962"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:09:43 -0800
Date: Mon, 23 Nov 2026 12:09:40 +0200
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] PCI: Add pci_power_t helper functions
Message-ID: <awQQ5Muf-IOOK9Hw@ashevche-desk.local>
References: <20261121130936.53191-2-habilerenturker@hotmail.com>
 <20261121130936.53191-3-habilerenturker@hotmail.com>
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
In-Reply-To: <20261121130936.53191-3-habilerenturker@hotmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 21, 2026 at 01:12:32PM +0000, Habil Eren Türker wrote:
> Add helper functions to extract, set and compare PCI power
> states in the Power Management Control/Status register.

...

> +++ b/include/linux/pci.h
> @@ -40,6 +40,7 @@
>  #include <linux/io.h>
>  #include <linux/resource_ext.h>
>  #include <linux/msi_api.h>
> +#include <linux/bitfield.h>

Can we try to make some order here, please? Id est squeeze the new one to the
above to make the longer (but yet sparse) ordered list.

>  #include <uapi/linux/pci.h>

...

Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko


