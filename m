Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3803A6B7A;
	Tue, 10 Mar 2026 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159244; cv=none; b=sU8WHk5LustDgymCck5rTM2D/5Uva+3GRaIpZzBORG04YJY8Q/XCLVwalp6wJq0yNwoMblVy1vSYXJc20P7m4x9AnouMZhQ+rQt+sp4CqczGQhMwNyRqnMDZFUzJ2cSY7+YfXWtsfYftPad0ZfBk+M5zlvTFwD1CpdEdF0ZiG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159244; c=relaxed/simple;
	bh=W16GSmTPEmREHa/ncwuLvenYoXFQJu4+w8XRQCYhwsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSEE/c9o2HY6ejtt7cGsdY4bbPY7rC+mdqAv3SVpo67hPH716++akWzJTME54sRUY1QIRs1OxpfY72SKd4yuKMIPT/f/ala+fZOjblYRd/q+Z5jP2PJBEJxwLaIca9MK5p6dRq6FPypsfVbXksy7Z3mcYdjHRFG+++YhUNuB364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXDYQMP6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXDYQMP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773159242; x=1804695242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W16GSmTPEmREHa/ncwuLvenYoXFQJu4+w8XRQCYhwsg=;
  b=gXDYQMP6GNbALh6HHfORGadAnrPEWX3GSrlUSIyP6GrK0dP9h2ZiLPoT
   AFhxFEISAlD6zfLb6zUuxX12OelIWwqKIPrMjMmmR4qGrDVzHZ24Hkztg
   iXOwAgZJBm/u5/DcmPF1x6CAoGJhVAFiIo7BxEkjBs3K11wJcdzAWab5n
   B5PO7h9SFz6I23F6Jbn3VAuMjBG6HV9DsquRouJ2Dg3Rkb7EIfQna/Q6g
   nxeKC7PVyUXraLoREptAJVBqUIEWGG2wl0aeO3na60suvo4zK7/QxF5n7
   ChGlDn/9bGTnaKHvpfJmshIcAQQtU0dECYxXHlO6m4mYWjlNU3pj1kSyn
   A==;
X-CSE-ConnectionGUID: x4WaRFWLTCG2DXa+P/a3dg==
X-CSE-MsgGUID: Sf3Am0CfR/ym6PvG0fZC3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73407675"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="73407675"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:14:01 -0700
X-CSE-ConnectionGUID: 5JlbAd8ZQBONj48y4Bywaw==
X-CSE-MsgGUID: xrAf1p2aQBOmi+e8t4rPjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224621553"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:13:57 -0700
Message-ID: <ba5b26b5-d69a-48bf-9ebf-21e44aa75a60@intel.com>
Date: Tue, 10 Mar 2026 09:13:56 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cxl: Move HDM decoder and register map definitions to
 include/cxl/pci.h
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alex Williamson <alwilliamson@nvidia.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, Jeshua Smith <jeshuas@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Vidya Sagar <vidyas@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Derek Schumacher <dschumacher@nvidia.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <20260306080026.116789-3-smadhavan@nvidia.com>
 <20260306104516.50ac6f40@nvidia.com>
 <DS0PR12MB772529689331805F3B034630C37BA@DS0PR12MB7725.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <DS0PR12MB772529689331805F3B034630C37BA@DS0PR12MB7725.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/26 5:35 PM, Srirangan Madhavan wrote:
>> So moving them to the public header is just unnecessary code churn.
> Apologies for that oversight. I can remove the unnecessary moves from this patch.
> 
>> Also, specifically regarding cxl_find_regblock(), where 5/ implements a
>> new cxl_find_component_regblock().  The latter looks significantly
>> similar to the original.  Shouldn't we refactor the new PCI implemented
>> version to be more generic rather than scope reduced, and export it for
>> use by CXL code to avoid the duplication?
> 
> Regarding the duplication between cxl_find_component_regblock()
> and the CXL subsystem's cxl_find_regblock():
> I understand the duplication isn't ideal. I looked into generalizing the PCI version
> (cxl_find_component_regblock) and exporting it for CXL to use, but exporting just
> the find step from PCI while the rest of the register discovery pipeline stays in CXL
> felt like an inconsistent split across the two subsystems. It seems like addressing
> that would mean refactoring a significant portion of regs.c into the PCI subsystem,
> which also doesn't appear correct.
> Given that, would it be acceptable to keep the current scope-reduced version in the
> PCI?
> Please let me know if it would be acceptable to just refactor the cxl_find_component_regblock
> and export it from pci.

Hi Srirangan. PCI base spec in r6.2 introduced MMIO register blocks (MRB) that is patterned after CXL register blocks. A while back I hacked up some code [1] to unify the CXL register block discovery code with PCI usages. It never got around to go upstream since I was waiting on a PCI device that utilizes this new scheme. However, maybe this can be used as inspiration for your uses. Maybe we should start refactoring to make this code common given there will be PCI usages eventually?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=pci-mbox
 
> 
> Thank you.
> 
> Regards,
> Srirangan.
> 
> ________________________________________
> From: Alex Williamson <alwilliamson@nvidia.com>
> Sent: Friday, March 6, 2026 9:45 AM
> To: Srirangan Madhavan
> Cc: bhelgaas@google.com; dan.j.williams@intel.com; dave.jiang@intel.com; jonathan.cameron@huawei.com; ira.weiny@intel.com; vishal.l.verma@intel.com; alison.schofield@intel.com; dave@stgolabs.net; Jeshua Smith; Vikram Sethi; Sai Yashwanth Reddy Kancherla; Vishal Aslot; Shanker Donthineni; Manish Honap; Vidya Sagar; Jiandi An; Matt Ochs; Derek Schumacher; linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/5] cxl: Move HDM decoder and register map definitions to include/cxl/pci.h
> 
> On Fri, 6 Mar 2026 08:00:16 +0000
> <smadhavan@nvidia.com> wrote:
> 
>> From: Srirangan Madhavan <smadhavan@nvidia.com>
>>
>> Move CXL HDM decoder register defines, register map structs
>> (cxl_reg_map, cxl_component_reg_map, cxl_device_reg_map,
>> cxl_pmu_reg_map, cxl_register_map), cxl_hdm_decoder_count(),
>> enum cxl_regloc_type, and cxl_find_regblock()/cxl_setup_regs()
>> declarations from internal CXL headers to include/cxl/pci.h.
> 
> Regarding cxl_find_regblock()/cxl_setup_regs()..
> 
>> This makes them accessible to code outside the CXL subsystem, in
>> particular the PCI core CXL state save/restore support added in a
>> subsequent patch.
> 
> Yet in 5/:
> 
>     The Register Locator DVSEC is parsed directly via PCI config space
>     reads rather than calling cxl_find_regblock()/cxl_setup_regs(),
>     since this code lives in the PCI core and must not depend on CXL
>     module symbols.
> 
> So moving them to the public header is just unnecessary code churn.
> 
> Also, specifically regarding cxl_find_regblock(), where 5/ implements a
> new cxl_find_component_regblock().  The latter looks significantly
> similar to the original.  Shouldn't we refactor the new PCI implemented
> version to be more generic rather than scope reduced, and export it for
> use by CXL code to avoid the duplication?  Thanks,
> 
> Alex
> 
>> No functional change.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>> ---
>>  drivers/cxl/cxl.h    | 107 +----------------------------------
>>  drivers/cxl/cxlpci.h |  10 ----
>>  include/cxl/pci.h    | 129 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 130 insertions(+), 116 deletions(-)
>>  create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 04c673e7cdb0..0c84695449d8 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -12,6 +12,7 @@
>>  #include <linux/node.h>
>>  #include <linux/io.h>
>>  #include <linux/range.h>
>> +#include <cxl/pci.h>
>>
>>  extern const struct nvdimm_security_ops *cxl_security_ops;
>>
>> @@ -23,63 +24,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>>   */
>>
>> -/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
>> -#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
>> -
>> -/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
>> -#define CXL_CM_OFFSET 0x1000
>> -#define CXL_CM_CAP_HDR_OFFSET 0x0
>> -#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
>> -#define     CM_CAP_HDR_CAP_ID 1
>> -#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
>> -#define     CM_CAP_HDR_CAP_VERSION 1
>> -#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
>> -#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
>> -#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>> -#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
>> -
>> -#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>> -#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>> -#define   CXL_CM_CAP_CAP_HDM_VERSION 1
>> -
>> -/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>> -#define CXL_HDM_DECODER_CAP_OFFSET 0x0
>> -#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>> -#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>> -#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>> -#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>> -#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>> -#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>> -#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>> -#define   CXL_HDM_DECODER_ENABLE BIT(1)
>> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
>> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
>> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
>> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
>> -#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
>> -#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
>> -#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
>> -#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
>> -#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
>> -#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>> -#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>> -#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>> -#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>> -#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>> -#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>> -#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>> -
>> -/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
>> -#define CXL_DECODER_MIN_GRANULARITY 256
>> -#define CXL_DECODER_MAX_ENCODED_IG 6
>> -
>> -static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>> -{
>> -     int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>> -
>> -     return val ? val * 2 : 1;
>> -}
>> -
>>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>>  static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
>>  {
>> @@ -246,51 +190,6 @@ struct cxl_regs {
>>       );
>>  };
>>
>> -struct cxl_reg_map {
>> -     bool valid;
>> -     int id;
>> -     unsigned long offset;
>> -     unsigned long size;
>> -};
>> -
>> -struct cxl_component_reg_map {
>> -     struct cxl_reg_map hdm_decoder;
>> -     struct cxl_reg_map ras;
>> -};
>> -
>> -struct cxl_device_reg_map {
>> -     struct cxl_reg_map status;
>> -     struct cxl_reg_map mbox;
>> -     struct cxl_reg_map memdev;
>> -};
>> -
>> -struct cxl_pmu_reg_map {
>> -     struct cxl_reg_map pmu;
>> -};
>> -
>> -/**
>> - * struct cxl_register_map - DVSEC harvested register block mapping parameters
>> - * @host: device for devm operations and logging
>> - * @base: virtual base of the register-block-BAR + @block_offset
>> - * @resource: physical resource base of the register block
>> - * @max_size: maximum mapping size to perform register search
>> - * @reg_type: see enum cxl_regloc_type
>> - * @component_map: cxl_reg_map for component registers
>> - * @device_map: cxl_reg_maps for device registers
>> - * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
>> - */
>> -struct cxl_register_map {
>> -     struct device *host;
>> -     void __iomem *base;
>> -     resource_size_t resource;
>> -     resource_size_t max_size;
>> -     u8 reg_type;
>> -     union {
>> -             struct cxl_component_reg_map component_map;
>> -             struct cxl_device_reg_map device_map;
>> -             struct cxl_pmu_reg_map pmu_map;
>> -     };
>> -};
>>
>>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>                             struct cxl_component_reg_map *map);
>> @@ -304,13 +203,9 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
>>  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
>>
>>  #define CXL_INSTANCES_COUNT -1
>> -enum cxl_regloc_type;
>>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>>                              struct cxl_register_map *map, unsigned int index);
>> -int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -                   struct cxl_register_map *map);
>> -int cxl_setup_regs(struct cxl_register_map *map);
>>  struct cxl_dport;
>>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>                                          struct cxl_dport *dport);
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 0cf64218aa16..9e825c039dd9 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -13,16 +13,6 @@
>>   */
>>  #define CXL_PCI_DEFAULT_MAX_VECTORS 16
>>
>> -/* Register Block Identifier (RBI) */
>> -enum cxl_regloc_type {
>> -     CXL_REGLOC_RBI_EMPTY = 0,
>> -     CXL_REGLOC_RBI_COMPONENT,
>> -     CXL_REGLOC_RBI_VIRT,
>> -     CXL_REGLOC_RBI_MEMDEV,
>> -     CXL_REGLOC_RBI_PMU,
>> -     CXL_REGLOC_RBI_TYPES
>> -};
>> -
>>  /*
>>   * Table Access DOE, CDAT Read Entry Response
>>   *
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..763a048262c7
>> --- /dev/null
>> +++ b/include/cxl/pci.h
>> @@ -0,0 +1,129 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef __CXL_CXL_PCI_H__
>> +#define __CXL_CXL_PCI_H__
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/io.h>
>> +#include <linux/types.h>
>> +
>> +/* Register Block Identifier (RBI) */
>> +enum cxl_regloc_type {
>> +     CXL_REGLOC_RBI_EMPTY = 0,
>> +     CXL_REGLOC_RBI_COMPONENT,
>> +     CXL_REGLOC_RBI_VIRT,
>> +     CXL_REGLOC_RBI_MEMDEV,
>> +     CXL_REGLOC_RBI_PMU,
>> +     CXL_REGLOC_RBI_TYPES
>> +};
>> +
>> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
>> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
>> +
>> +/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers */
>> +#define CXL_CM_OFFSET 0x1000
>> +#define CXL_CM_CAP_HDR_OFFSET 0x0
>> +#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
>> +#define     CM_CAP_HDR_CAP_ID 1
>> +#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
>> +#define     CM_CAP_HDR_CAP_VERSION 1
>> +#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
>> +#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
>> +#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>> +#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
>> +
>> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
>> +
>> +/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>> +#define CXL_HDM_DECODER_CAP_OFFSET 0x0
>> +#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>> +#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
>> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
>> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
>> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
>> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
>> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
>> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
>> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
>> +#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
>> +#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
>> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>> +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>> +#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>> +#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>> +#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>> +
>> +/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
>> +#define CXL_DECODER_MIN_GRANULARITY 256
>> +#define CXL_DECODER_MAX_ENCODED_IG 6
>> +
>> +static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>> +{
>> +     int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>> +
>> +     return val ? val * 2 : 1;
>> +}
>> +
>> +struct cxl_reg_map {
>> +     bool valid;
>> +     int id;
>> +     unsigned long offset;
>> +     unsigned long size;
>> +};
>> +
>> +struct cxl_component_reg_map {
>> +     struct cxl_reg_map hdm_decoder;
>> +     struct cxl_reg_map ras;
>> +};
>> +
>> +struct cxl_device_reg_map {
>> +     struct cxl_reg_map status;
>> +     struct cxl_reg_map mbox;
>> +     struct cxl_reg_map memdev;
>> +};
>> +
>> +struct cxl_pmu_reg_map {
>> +     struct cxl_reg_map pmu;
>> +};
>> +
>> +/**
>> + * struct cxl_register_map - DVSEC harvested register block mapping parameters
>> + * @host: device for devm operations and logging
>> + * @base: virtual base of the register-block-BAR + @block_offset
>> + * @resource: physical resource base of the register block
>> + * @max_size: maximum mapping size to perform register search
>> + * @reg_type: see enum cxl_regloc_type
>> + * @component_map: cxl_reg_map for component registers
>> + * @device_map: cxl_reg_maps for device registers
>> + * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
>> + */
>> +struct cxl_register_map {
>> +     struct device *host;
>> +     void __iomem *base;
>> +     resource_size_t resource;
>> +     resource_size_t max_size;
>> +     u8 reg_type;
>> +     union {
>> +             struct cxl_component_reg_map component_map;
>> +             struct cxl_device_reg_map device_map;
>> +             struct cxl_pmu_reg_map pmu_map;
>> +     };
>> +};
>> +
>> +struct pci_dev;
>> +
>> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +                   struct cxl_register_map *map);
>> +int cxl_setup_regs(struct cxl_register_map *map);
>> +
>> +#endif /* __CXL_CXL_PCI_H__ */
>> --
>> 2.43.0
>>
> 

