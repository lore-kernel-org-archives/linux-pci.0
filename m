Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9D245012;
	Mon, 20 Jul 2026 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586351; cv=none; b=rk/67JMLTX8tYaiGoxUkxe8pIZh1zoJtlKRjTH8AJxhP/+wLVAVt3NwwOdC5ZkR5n2zcA4Y1Y+EK5+hIGBHhitDszVi8Fbv42VD5/m8q3OyW37kvBRiOb/cfx0YK7kqUns3sHY5EF/jWRqK+0yuyqXEvnUvqutUibflxMy6AjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586351; c=relaxed/simple;
	bh=aQaapGffcvOYYZ1UrRA2bMN8GdVvJwcDNLSYCZzmY6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asyuYFKqnoPwEPbMEEJ6+2xufkcNPim7uUINRIPpd6CN4W9IEapRhmZLw63Pg1YoCgtFevvxVEIFzHlVDkrD18D4xMNBgLrGOaDFQPB3vfASrrGUqY9l0+PDepq9JyNJ9EStuZajhyyQpEuRWhoC4ZtspP3Cf0C1447jeEfwSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/aPfrGG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/aPfrGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784586348; x=1816122348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aQaapGffcvOYYZ1UrRA2bMN8GdVvJwcDNLSYCZzmY6A=;
  b=b/aPfrGG1TbDLEM9Oh6JjNIryheYlcWBqAERZ6+f5KwhEA0nvfR7mvu8
   E3VmLxQ20a18o7nI5b6bYQRM5aU7YhIm8DKyjZ9xBjgDNcq/4gM579Fc7
   lqY2qurJgHlFbF4/y0IhRMq+9OZ3ceckVIxaSp9CbYdnUHk9UZ2cHWB8z
   kQHx9duv/14p0le6jQ7gDuH1Q6xqbL6zHRMRCjUCjav/D6S9/WWNhLySI
   xNTJKRAD9yWYF6U/BjQuWJRRq+UP9pd3PcjtpMCKrwlUYijkYtOW7uMT2
   rQQ1DWw9WTkaqPTcZcsv2o0H/fYftsdJ0mShf2LPxUODvGPpS3EKiISod
   w==;
X-CSE-ConnectionGUID: GaNOdbLlR3WQEJ3oJQZdsg==
X-CSE-MsgGUID: DEeD48E6QKCoTv3DXA9/BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95830206"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95830206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:25:35 -0700
X-CSE-ConnectionGUID: NJlKNz+DSYC/FokOqWlk9g==
X-CSE-MsgGUID: eAHOkX6dS0iYqnFwKRU9Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="255803396"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:25:33 -0700
Message-ID: <aa1831f8-8808-4f41-a3d7-da511fe60ce9@intel.com>
Date: Mon, 20 Jul 2026 15:25:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 09/13] cxl: Update CXL Endpoint AER handler
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
 <20260717222706.3540281-10-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:27 PM, Terry Bowman wrote:
> Rename cxl_error_detected() to cxl_pci_error_detected() and rename
> the struct pci_error_handlers instance to cxl_pci_error_handlers to
> avoid shadowing the struct type tag.
> 
> Document the unconditional CXL RAS read policy: on a dead link,
> readl() returns 0xFFFFFFFF which is interpreted as UCE bits set and
> triggers a panic. If RAS registers are not mapped the read is
> skipped and the frozen/perm_failure switch cases defer to AER
> recovery for devices without active CXL.mem traffic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v17->v18:
> - Fix cxl_pci_error_detected() to use find_cxl_port_by_uport() and port->uport_dev
> - Read CXL RAS unconditionally; panic on UCE regardless of channel state
> - Document unconditional read policy and 0xFFFFFFFF behavior in comment
> - Drop guard removal paragraph from commit message (not in this diff)
> - Drop Reviewed-by tags pending re-review after message change
> 
> Changes in v16->v17:
> - Rename pci_error_handlers struct instance to cxl_pci_error_handlers to
>   avoid shadowing the struct type tag.
> - Restore scoped_guard(device) and dev->driver check around AER read.
> - NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
> - Updated commit message. (Terry)
> - Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
> - Drop cxl_uncor_aer_present(), rely on AER state
> 
> Changes in v15->v16:
> - Update commit message (DaveJ)
> - s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
> - cxl_uncor_aer_present(): Leave original result calculation based on
>   if a UCE is present and the provided state (Terry)
> - Add call to pci_print_aer(). AER fails to log because is upstream
>   link (Terry)
> 
> Changes in v14->v15:
> - Update commit message and title. Added Bjorn's ack.
> - Move CE and UCE handling logic here
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by
> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c | 24 +++++++++++++++---------
>  drivers/cxl/cxlpci.h   |  8 ++++----
>  drivers/cxl/pci.c      | 12 ++++++------
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 6f4a3c1b0bb85..d5dc2c22565da 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -328,10 +328,8 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
>  	return true;
>  }
>  
> -
> -
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state)
>  {
>  	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>  	bool ue = false;
> @@ -349,10 +347,18 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		}
>  
>  		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> +		 * The CXL RAS read is unconditional regardless of channel
> +		 * state.  Any uncorrectable error bit set in the CXL RAS
> +		 * status register triggers a panic because CXL.mem cache
> +		 * coherency is already lost; continuing risks silent data
> +		 * corruption across interleaved HDM regions.
> +		 *
> +		 * On a dead link readl() returns 0xFFFFFFFF which sets all
> +		 * UCE bits and also triggers the panic - this is intentional.
> +		 * If RAS registers are not mapped the read is skipped, the
> +		 * panic is not reached, and the frozen/perm_failure switch
> +		 * cases below handle AER recovery for devices without active
> +		 * CXL.mem traffic.
>  		 */
>  		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>  	}
> @@ -380,7 +386,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	}
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
>  
>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 06c46adcf0f6c..8aeb80a4e5732 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -89,13 +89,13 @@ struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_RAS
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state);
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state);
>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
>  void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
> -static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -						  pci_channel_state_t state)
> +static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +						      pci_channel_state_t state)
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5c21db36073fe..6cf1db7b85020 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1000,18 +1000,18 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	}
>  }
>  
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> -	.slot_reset	= cxl_slot_reset,
> -	.resume		= cxl_error_resume,
> -	.reset_done	= cxl_reset_done,
> +static const struct pci_error_handlers cxl_pci_error_handlers = {
> +	.error_detected		= cxl_pci_error_detected,
> +	.slot_reset		= cxl_slot_reset,
> +	.resume			= cxl_error_resume,
> +	.reset_done		= cxl_reset_done,
>  };
>  
>  static struct pci_driver cxl_pci_driver = {
>  	.name			= KBUILD_MODNAME,
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
> -	.err_handler		= &cxl_error_handlers,
> +	.err_handler		= &cxl_pci_error_handlers,
>  	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,

