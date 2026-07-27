Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3F42BEB2;
	Mon, 27 Jul 2026 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173133; cv=none; b=hyX3QxWZhoNzlbY6OBX/BnBkOXeVB2iYjeW/hkITP6KzIV2LmfFOLKL5iSxd8L7BZRlRQ1sFybWMr5PGgTj6pSsR3Nr0mZF8+WqZJlJgw6Rap2s+ZtEJK2w1PARQSQWfQLnnwOK42VieYxeEJQjOY9qK1U4NHhGGI12iXrMycew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173133; c=relaxed/simple;
	bh=xIc7mbEEDl2XzJ10CqzA3H5i8CNoTKHQjJm395IfRYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8I6KGoB5gmegwISCmWdsuUofDGEOcmB5aha/NuL/Yl67uiOnS27Lgvxnuotf0d0sVmlJ5zkFD644TExr+5wAFx0OzgwsPC6hZvAhGufl+YHrDczwsIiyOC9pwPNIsq6Ubk6PMCjUnfIyzCmY+4++oSO5M7oHl2Tb1y9tOzKgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBphBV0E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBphBV0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785173129; x=1816709129;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIc7mbEEDl2XzJ10CqzA3H5i8CNoTKHQjJm395IfRYM=;
  b=dBphBV0E2yiJLzo/btO5CeLY1LvDlGf469nuveMER+6dYuKPvZUiJ5WP
   CisPAElLJ/uWRHveq7PAbqR/AqVtrWX4CwoKpDI4jFDbrSDryNiS3M71v
   TlJlAzii201Zwv8ALt6q3I23934I2AHlGgrhJkRXT/ZGoEvhStP+6la69
   23gTy2rCCD+ZDN/WlvJ2CJiVdI49YE7ot2mJPVnvFjZIKPYbn97RFWlsU
   hF96N2lRAZcldLiIK4Wj5XEMG9/nlZkzA1VKltW4UTxlrljBN0/cRWcGn
   lUxxYwsfeKseAfB8iRMgpMJmFF/s8e+f25P2AHbCUxoRocokLtGxvMFy4
   A==;
X-CSE-ConnectionGUID: wiZHmS/UR7Om7sqXJiV6zA==
X-CSE-MsgGUID: qXWKMgpGSICrmgyN2+7pNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85616619"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85616619"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:25:24 -0700
X-CSE-ConnectionGUID: eJcnvQFeQH2jgYbho+PJBA==
X-CSE-MsgGUID: qV4n0T5IRLyMVSQ2csM7uw==
X-ExtLoop1: 1
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.47]) ([10.125.111.47])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:25:22 -0700
Message-ID: <ce2fc791-e84b-49e7-8d9b-f864ee82aa25@intel.com>
Date: Mon, 27 Jul 2026 10:25:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] ACPI: nfit: core: drop unused assignment of
 acpi_device_id::driver_data
To: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Ira Weiny <iweiny@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 nvdimm@lists.linux.dev
References: <20260727-acpi-refactor-v1-0-ff900aa326ee@thegoodpenguin.co.uk>
 <20260727-acpi-refactor-v1-7-ff900aa326ee@thegoodpenguin.co.uk>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260727-acpi-refactor-v1-7-ff900aa326ee@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/26 5:10 AM, Pawel Zalewski (The Capable Hub) wrote:
> This module sets the acpi_device_id::driver_data to 0 but
> the field is not actually used within the module, we can
> just drop it from the table.
> 
> While we are at it - used a named initializer for the
> acpi_device_id::id field to increase readability and
> drop explicitly setting the list terminator fields.
> 
> Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/acpi/nfit/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index cb771d9cadb2..5732df5d53f0 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3515,8 +3515,8 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
>  EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>  
>  static const struct acpi_device_id acpi_nfit_ids[] = {
> -	{ "ACPI0012", 0 },
> -	{ "", 0 },
> +	{ .id = "ACPI0012" },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
>  
> 

