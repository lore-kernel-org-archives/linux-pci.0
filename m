Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022941C6A;
	Tue, 18 Aug 2026 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092661; cv=none; b=dgwxje4E437Z9qFHk0CuEhb8UOFC/Nijs3ZbIPzR5atLHtD0K5tLv+hfw7KyySvuh+jOcbKJl5Q2bd6YzMYCJApwitkHiOCSyDYJ8LAGluskh0+nw+faQMWwJ/8TXI2dGdVne1CyFAC7bYDtHf2F+lxFqaKWKVoSFlCw2Mb+cCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092661; c=relaxed/simple;
	bh=v3uIBq4ta5/dQkmr2NGifq11i2HrnYaNHDNEEtLSFYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjfIBXKOQdYina3z2fPE7hoKQirWFJnrx4K4HbSSy5eFMIchEuYokyHB5pbSjP91uEep7Tys6CEtyWKoICi9ZiN10F7GbHxIBdNVyMKmIhJGYuEZ/yrZnzl2PS+qB/XnQboYb5fAUpZYVDK5clWEbuLfeBW+iAvsusvYwUwRQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjOsrmum; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjOsrmum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787092658; x=1818628658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v3uIBq4ta5/dQkmr2NGifq11i2HrnYaNHDNEEtLSFYY=;
  b=OjOsrmumizL9qzTg3ulOQsk3+jv0YtqdFzYu2w4UtITtTkG6cJpA/GPI
   U8oiFT56uhZr25fhBauVGaoH6yYii6XRGheohcCw0rrtl+DPC6ZBwvb+x
   gmGA6aKuq8iIcPJjPoxIcaC65WO8aoKDYA2VsamHtqsNzHrTYr0G9sbMS
   6j3S+IyTgELVYbMJbLtPjV7btVZwbeTGj3R7277SO//Itej6c3Whvvvyp
   wIs5cWrH4EctRs2oqVevLCbAQ0Hb1pxEUN4ZN3fcQxxxnRDGdHtJlkr1p
   Xs3guMsdA6/sG9qIdWTYidjvFTGGWAwnh7Dl+3ZC+rMgWzEhLjw00t1Qh
   Q==;
X-CSE-ConnectionGUID: oJv6L4G2SfOcqXMe/7M7nQ==
X-CSE-MsgGUID: CwnmGSHeT4O5INm5Mw5dgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87452136"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87452136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 15:37:38 -0700
X-CSE-ConnectionGUID: npeUlikmRvqALNmhGyGZxA==
X-CSE-MsgGUID: P2K9tFEyTSyJ071QLqMekA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="290177746"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.209]) ([10.125.111.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 15:37:35 -0700
Message-ID: <2ba00f98-c950-45b4-aed7-202fa8811863@intel.com>
Date: Tue, 18 Aug 2026 15:37:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Add MMIO Capabilities Register Block
 definitions
To: penn <engguopeng@buaa.edu.cn>, linux-cxl@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, johnny.li@montage-tech.com, peng.guo@montage-tech.com,
 jingzhong.yang@montage-tech.com
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
 <20260817075854.17207-2-engguopeng@buaa.edu.cn>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817075854.17207-2-engguopeng@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/26 12:58 AM, penn wrote:
> From: Penn <engguopeng@buaa.edu.cn>
> 
> PCIe r7.0 sec 6.35 defines the MMIO Capabilities Register Block
> (MCAP). It consists of an array header followed by capability headers
> that identify the version, location, size, and vendor of each MMIO
> capability.
> 
> Define the MCAP array-header and capability-header registers and their
> fields. These definitions allow subsystem drivers to use the Vendor ID
> along with the Capability ID when capabilities from multiple vendors
> share the same MCAP.
> 
> Signed-off-by: Penn <engguopeng@buaa.edu.cn>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes in v2:
> - Update the MCAP specification citation to PCIe r7.0 sec 6.35.
> - Document that capability header indices are one-based.
> 
>  include/uapi/linux/pci_regs.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..4dd22cde9e71 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1338,6 +1338,28 @@
>  #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
>  #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
>  
> +/* PCIe r7.0, sec 6.35: MMIO Capabilities Register Block (MCAP) */
> +#define PCI_MCAP_ARRAY_1		0x00
> +#define  PCI_MCAP_ARRAY_ID		__GENMASK(15, 0)
> +#define  PCI_MCAP_ARRAY_VERSION		__GENMASK(23, 16)
> +#define  PCI_MCAP_ARRAY_TYPE		__GENMASK(27, 24)
> +#define  PCI_MCAP_ARRAY_TYPE_CLASS_CODE	0x0
> +#define PCI_MCAP_ARRAY_2		0x04
> +#define  PCI_MCAP_ARRAY_COUNT		__GENMASK(15, 0)
> +
> +/* Capability header indices are one-based. */
> +#define PCI_MCAP_HDR_SIZEOF		0x10
> +#define PCI_MCAP_HDR_BASE(n)		((n) * PCI_MCAP_HDR_SIZEOF)
> +#define PCI_MCAP_HDR_REG_1		0x00
> +#define  PCI_MCAP_CAP_ID		__GENMASK(15, 0)
> +#define  PCI_MCAP_CAP_VERSION		__GENMASK(23, 16)
> +#define PCI_MCAP_HDR_REG_2		0x04
> +#define  PCI_MCAP_HDR_OFFSET		__GENMASK(31, 0)
> +#define PCI_MCAP_HDR_REG_3		0x08
> +#define  PCI_MCAP_HDR_LENGTH		__GENMASK(31, 0)
> +#define PCI_MCAP_HDR_REG_4		0x0c
> +#define  PCI_MCAP_HDR_VENDOR_ID		__GENMASK(15, 0)
> +
>  /*
>   * Compute Express Link (CXL r4.0, sec 8.1)
>   *

