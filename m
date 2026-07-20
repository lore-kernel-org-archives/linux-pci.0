Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E03B9D80;
	Mon, 20 Jul 2026 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579130; cv=none; b=T1rlcnkXW0sRRRP2aDRB77sH1s6O4+sb1MDA6I0Rxjy8j416KL3cse3LxUfwFpGmZUHUKDYt80W4q3kthd6GDI0Pf0h8btcP58clx/z5Pu4RHdVrIdMS6Z/4IFDyD/8fW6y1uH6OsUHU1mEZhIEdccvlBE9IU9Df5jxqxLupu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579130; c=relaxed/simple;
	bh=Lfc8ES4RaxKThEhEsV6WScyH14eDYM7+mOtzgzv1vic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9Vl6raR72NBsZ8VTn9ufFeCuqoCfkXIsicVXdy4cl769SyhcAZYvqIE7uyyCs6A2FDoeTGl/o0ZMjBJ/L+C5asqRHPzAdLNPVNMMTZbbjDsFrhaAh25HbfptenKjdWYtt/imJxK7N7njRlnaq5XJPvc0+XlkxrPoUuXzl38qZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1eiHw4n; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1eiHw4n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784579128; x=1816115128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lfc8ES4RaxKThEhEsV6WScyH14eDYM7+mOtzgzv1vic=;
  b=Y1eiHw4nMQ4zQUKxlNx76RU4Xw443VRWvRsZGLScjmefE1VAljNrf4QX
   dDQLdF8p7jcrHtttOxjXc0zu31kiC2MoSkFNACaI20T8YsfuCsLVxPAyq
   m0ZcOfi2Jw5pomZYAN4+vx8TSLhdMPVVUbKO7J/Js0Q3/Ptzd8Qb3eVeh
   tSzacY0L5vduPufqMjB0M61YHEE3UGb4qbEBhpRziwEILxorK/xQgV+Gi
   5lIt+HxhJuLUxzjdHgQjZQ3N2UYMooGNWf8uH/6E2iHFASto6jnz9ixgd
   E8+D6oyDSYZLFBUMK/fmhoQdcOjw2d06h6E/MIiwPDDorDb2PQPGoU5RA
   g==;
X-CSE-ConnectionGUID: fQ+85vtRQM+Tzqo51RcPgA==
X-CSE-MsgGUID: oV55OCcTQ92xKM7WdcZO0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87709268"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87709268"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:25:27 -0700
X-CSE-ConnectionGUID: FQ3gppGmTgqMnyy5lXezCQ==
X-CSE-MsgGUID: G/FdKpsqTWarRCSztogosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="280832117"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:25:24 -0700
Message-ID: <c3184061-58d1-4c93-b644-eef30d95d13e@intel.com>
Date: Mon, 20 Jul 2026 13:25:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 04/13] cxl: Rename find_cxl_port() to
 find_cxl_port_by_dport()
To: Terry Bowman <terry.bowman@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-5-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:26 PM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
> functions that search the CXL bus by dport and uport respectively, but
> their names do not make the lookup method clear.
> 
> Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
> method explicit and consistent with find_cxl_port_by_uport(). Both
> functions remain static to port.c; the upcoming patch that adds the
> first cross-file caller will widen their scope.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v17 -> v18:
> - New commit
> ---
>  drivers/cxl/core/port.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f90f899c31d07..cadb51f70f854 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1379,7 +1379,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
>  	return dport != NULL;
>  }
>  
> -static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
> +static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
>  {
>  	struct device *dev;
>  
> @@ -1392,8 +1392,16 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +/**
> + * find_cxl_port_by_dport - find a cxl_port by one of its targets
> + * @dport_dev: device representing the dport target
> + * @dport: optional output of the 'struct cxl_dport' companion of the @dport_dev
> + *
> + * Return a 'struct cxl_port' with an elevated reference if found. Use
> + * __free(put_cxl_port) to release.
> + */
> +static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
> +					       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1401,7 +1409,7 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
>  	};
>  	struct cxl_port *port;
>  
> -	port = __find_cxl_port(&ctx);
> +	port = __find_cxl_port_by_dport(&ctx);
>  	return port;
>  }
>  
> @@ -1895,14 +1903,14 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, "CXL");
>  struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(pdev->dev.parent, dport);
> +	return find_cxl_port_by_dport(pdev->dev.parent, dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
>  
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(grandparent(&cxlmd->dev), dport);
> +	return find_cxl_port_by_dport(grandparent(&cxlmd->dev), dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
>  

