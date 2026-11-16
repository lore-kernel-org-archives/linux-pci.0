Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845190;
	b=NJOvO9j0vXPQciB+6piMqjI7dU/7mKq3vPDOzPNad0jFDvmRBzVNX176i9/JKFyoS4Xi
	 kA25JqzQVeiYpXJ2WEjL4A+6O8slXD5I7ETRXG8nU7iGcsxPZf25ArafXmK4Iv9jYbWSa
	 YUhrSbiG8IoBv7plZ/WKwtaKJljEuyohlSnAVjKapsWN84WjRNdG8ZkaE4fhmJNg7pk/X
	 1kZEF7FkV80azf9f/VCz2FPCyaxq3wHN5od/WpU0cV9CW1tAXZUqYtwDEkKn2uGDgnSAu
	 hZObw96i3Zh96+e1D0TCGm/rUFGuWRc/XcBHvLdrh6svkKpk4104ooD036Ih4McvuHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845190;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KkPjuzoL5FbYvRRmju0PcrJ03uAzI07vEAWraSUh5PU=;
	b=a+fz7zqLErjVHHCYjyxW2RYR0Whv17J5da+eHgJUHln5pA0FENpOqzh8td0qCJbz9fM6
	 cDAK49jTHvZrcTF3i6tAHrFqlxEGp1DoSVBvhOZfMTXwl6tzycI0Ke1oPmxEj99nj3u/W
	 7LuBDTX40XTET2ZGe+EIxZpiTVZC0X2C/VWQqMLrp+LrjgLU2R7PWwswruKPGvUH5rRTX
	 q8aMMwYZmduF4/Lu6QyelzV+R57I383BPn8BJF+sItrJ7MByxChdvjnEyQM4I/Zv89TCj
	 5N3QBpWDQmA5K6i4og8LRwXFmMJ/KIOnPV8KqbR/ULQmFRlvHbZ2cl79tKdO+9yKIRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SZtO8pJh;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AA606A31C;
	Mon, 16 Nov 2026 16:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SZtO8pJh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794845190; x=1826381190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Db9OHh0nkyuxQ9oXRsKOwiEZL3Lx5s1Vi/G1JI8chj0=;
  b=SZtO8pJhtG9SVGUy7fFHeT5z3t9ey3+KZIqDkaYmFGKKXMnOwppKxm+/
   Bgp+JOoaQs0WsNTM6KJ4lXuSaaOdXUq2R9YgtBeJaOc7i5futAHpfiMIj
   5wibw68+gYUqHLZIlaIKdkNf02rySPk9GYKYVefzKGoIDcKsiMes+AmHU
   zPZMUgbuPP3uCeJIK1XF7qB5VauV4n+uq3+qZeZ0JO5kR8sLFAD3xUWeq
   CmoxQbH4I8zwDw/zA5wmjOjqgxvI850pHpdeOk0HHSqY6TZhBuYLp4S+b
   GNsMEZHQFz3bBHD7M8j7WA4/nJ9ugZqJQ9XmcrvOCKDwJt6DslNwM0L3G
   Q==;
X-CSE-ConnectionGUID: +i/a4lXJQHG4y8JXbQQtwA==
X-CSE-MsgGUID: 160xJzJnQg+TrW1TBArIqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3576266"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3576266"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 08:06:29 -0800
X-CSE-ConnectionGUID: AfzR70nDQR+OMGXOrPQ3nw==
X-CSE-MsgGUID: ti3VtIj+SwiLbX/gL4bSPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9751505"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 08:06:28 -0800
Message-ID: <9cb88cc0-f1f2-4c43-8a63-2698164da76b@linux.intel.com>
Date: Mon, 16 Nov 2026 08:06:27 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI/PME: Resume Catlow Lake Root Ports on PME with PME
 Status clear
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <avrouGIdiXIxE_5Y@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <avrouGIdiXIxE_5Y@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/16/26 03:27, Lukas Wunner wrote:
> On Tue, Nov 03, 2026 at 11:31:36AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
>> Status register when they generate a PME for their own hotplug event.
>> The PME interrupt itself is delivered.  PMEs from devices below the Root
>> Port are reported correctly.
> 
> Reading the commit message, I'm wondering whether PME_Status in the
> Root Port's Power Management Control/Status Register is set?

No.  PME Status is set in neither Root Status nor PMCSR. 

> 
> If it is, an alternative approach to quirking a set of Device IDs
> would be to auto-detect affected Root Ports, basically by using
> the logic OR of PCI_EXP_RTSTA_PME and PCI_PM_CTRL_PME_STATUS.
> 
> Sorry for not thinking about this earlier!
> 
> Otherwise I like this patch and I like how you managed to keep it
> unintrusive.

Thanks.  Can I add your Reviewed-by?


> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

