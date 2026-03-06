Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949B3ACF0C;
	Fri,  6 Mar 2026 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819177; cv=fail; b=LhHXt/QqFb7gSJGlT5dwD/p/b2ljyBSgqx+2FqolxEb3irEdYxmDWiqIB8jja+ZiUk+t7gHAEPAVs7na5v0fg3mX1yQvxMOQCJGVSposdbpscDn9DhFbPYgW08lFv99Rz8nRRibVmH6qk6S5nxI+eSKe3veZNUqfq9Uqx9YDsTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819177; c=relaxed/simple;
	bh=D6udS3pnhkT82+ziyVv83XOYdoSfAklHl+/pyHz+0PM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR5JIA7xXpysDvGEbDXdH2zVwMLzwNXOjee288mbqbRvYTzoiyZYcSDNZr1g+KQwS1WRo5QZpuzQ7fH6UqfetuU6XLuqeywxKGb/IOlPgvGpJfm/JFAKJsXIGDJROab0ibJc2O3m89bKTteTkv6SINAQo0zWamsUfqEE+8wakxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oxBaHt2Y; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxBaHt2Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVtnCmTvnvqCoy78tYZ/UXOBKP6kDlieQCZ36089iYQ5DOWspgiBQ3nBWVEwVpg7i3NRr67puYqlT07erSdjbxE1Xj5Z3CptR7Q3C6jm/kt7uNW4cftqo8SITjVLCSDz8nXj8hGs9eq0BJENZefA0pdNqJS1GQJJzq4ryiE+xGywQvNGeAxS1PRKvT1PLFeSnqd+XUXfj2zRolwrxRf3i8ZloKGqkMDxfxZ+Oh96H0iAOC8lQ3Mkp3pzJRk+f7OoZk2S6CW0qWR/sOK5mweof/tk9BpLqNjO04u24pmuOwiPwtiQI1E/sazpKc+yklatQ/cMhN0VoqKbxd+D+3R2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khYs+1so1d0wDdb+J31AJhv1MqkIzUrlVsbCYrzdCgo=;
 b=yTN8P4Yp8IE2AMYMzs9II4S0j97pbNMlND9hTZ5z+CZL1kqX9nX/oILfDqbL/u5ir6c9AcbZspfKm1vgVBWu+nAL83H/dL74zf2ldoWxryD7PoK7TpSaTrGrEQ8njApDDfDugp4coXE1oAoNyej4Jhsn0WbWUO4lB/05thVKdRPhxjAG2WSyxxnf8NEghyIyFT7XgJKrleaw8NgvJC+l+3U42N70ABykrF6ekC2HiYc/+/y+b/A7BWWTKjXlaDadn31BVwce00TyyGuabDyGRxcJBC/Icesx+U/d4xSfHER1k/cPn+exh4vzruP2lidoBi6kpltbhRO2P5SCimGMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khYs+1so1d0wDdb+J31AJhv1MqkIzUrlVsbCYrzdCgo=;
 b=oxBaHt2YJlms2PNs4+PGOZAX1Aje2jVKUls4bDTmLhq98rrbYBTwEX0Y+Jc6gSIS1L8S90g90SQ+gDKEikUqNTsm2oW568CT6XeNe/B3EHJfxpj2jDhu7wUE25YLxjLqWFkDfHYbmgElefUuMsIL9qBhPJ14uMS8BX2SyzLs9ydwBV5E0LDFk96rE5UF/F6VHi1glYxO+t/vsRYvVlTob1y3wpsItZcfxaRBPORd08dH81IUAY42mN6MjQDUhF1p5VMf5X1NFtQRt4DImZ59IDfZlQRSGBuQLChJuEHaMlJhPeJZgnLK4uvKDOKJBXRg167fJ0G7BIjFipae32lNQw==
Received: from CH2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:610:4d::37)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 17:46:09 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::13) by CH2PR19CA0027.outlook.office365.com
 (2603:10b6:610:4d::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 17:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:46:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 09:45:50 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 09:45:47 -0800
Date: Fri, 6 Mar 2026 10:45:16 -0700
From: Alex Williamson <alwilliamson@nvidia.com>
To: <smadhavan@nvidia.com>
CC: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl: Move HDM decoder and register map definitions
 to include/cxl/pci.h
Message-ID: <20260306104516.50ac6f40@nvidia.com>
In-Reply-To: <20260306080026.116789-3-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<20260306080026.116789-3-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: d0652716-2473-42b5-46ec-08de7ba83fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	1gHNB8cmHhNHbBCHPsKXHN7Uy3RHn7bBZYE2Ca9U2FjZNnHvMPgfSi9uGp9UincKp/BVjkYMfGngd+BdxaCaXG1BXb0Z84zo8JmHd6/gNCJ1adtORp5vVLMgsNwf+X+b9cbrmwK/5EE6TvWLFGxnX3ZCLuF4AH8xC/kdSeVK4P8NFxgA53oB5C6KFSF2lh+lylikCmRwG3pVqAdK3Nt9Ct7dweJJicSoOU/+Yx1S5ETE2z+fu4oyRBiKxvMtoDj4/BVbOoA30e086ueyLwXSBnRLd1uxbiAca70QthpGo7SRt98krZ9gvS+FALSv/mNkkSBKHYh7cypPEP9/i8R9fEc/A5Hdzyc5F0Z5hdxb0QQM283dq+hNCR42VYrXpGXTAYNJI0uchscxafFtntYSCBx8UGPras/WHJWgIad1PBVLUqmRc190lAvU9jF1LMXlTdBY1NR61C55ZmglOgZwHcL+0GoaH1IU7acrc812ap/6ivA+DtOfbIXXCYnle5oIITcr5drPLWWINJdAiOQ4BdcZ5ZQTGYtvPu3I+xTkO/rgHkJe9X2RXfXhxalDRYCSlam4jAxhNMPtEt0rloDsovrn3WUZka8BiSTCR4xgu2DC9lB6Lho6jsYyMFaXJqPiwJr8uVXbjqOgwCLEJDCmdQuNzp7v1uPmAFnlx3siFfzF26Eg99cBwyhed7H8fCX5TcDnDRvoYu3qDdKsdsWDFY/oJt4w/oN5liA7rfty6KTiRhfF075TnRy0O33xervF8ZXkS8mzrhZ/5Ei/DMq3eA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KH8OKhLuKEarQ2hEZWQ5lSpWsf3o7Iv3syN1131IEdQerf966jTVWj2Fpq1ILvfdJNzzcNpo5iYh5i3MPAH1GIavdwsQGiKG36YyN02htBdO/UJWAloRlWuaeuq88N4Hb9uZkp+RFAn5vZrgCd3nIWBPNIhWQeMCgl7ZQRqMhxbhi03LJBbL5PYqmRw5am02/DtPo7kCC51Ayt45jyKPE9v9ihyZYTrrn74piauwUdx3i0gwkaTrSXHHLcURyh/HXiM+rblWmUujkeXim/GKcZe5KUERxZ9envTR5c1COdap1X6UOFcIEC2dLLga0XJBCPNerDusd3pqj+TjiaBkCqS1Z7W3DCiGZxsAZFIwJ6GSMe4HBW8x5je4I2txIci11Q8hpaBqX1OJ366xKUg6mRkHfwAmpcT98IxuIEU9PzMBpPmcqUrG5AL1MgSaGFmy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:46:08.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0652716-2473-42b5-46ec-08de7ba83fe4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

On Fri, 6 Mar 2026 08:00:16 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Move CXL HDM decoder register defines, register map structs
> (cxl_reg_map, cxl_component_reg_map, cxl_device_reg_map,
> cxl_pmu_reg_map, cxl_register_map), cxl_hdm_decoder_count(),
> enum cxl_regloc_type, and cxl_find_regblock()/cxl_setup_regs()
> declarations from internal CXL headers to include/cxl/pci.h.

Regarding cxl_find_regblock()/cxl_setup_regs()..
 
> This makes them accessible to code outside the CXL subsystem, in
> particular the PCI core CXL state save/restore support added in a
> subsequent patch.

Yet in 5/:

    The Register Locator DVSEC is parsed directly via PCI config space
    reads rather than calling cxl_find_regblock()/cxl_setup_regs(),
    since this code lives in the PCI core and must not depend on CXL
    module symbols.

So moving them to the public header is just unnecessary code churn.

Also, specifically regarding cxl_find_regblock(), where 5/ implements a
new cxl_find_component_regblock().  The latter looks significantly
similar to the original.  Shouldn't we refactor the new PCI implemented
version to be more generic rather than scope reduced, and export it for
use by CXL code to avoid the duplication?  Thanks,

Alex
 
> No functional change.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/cxl.h    | 107 +----------------------------------
>  drivers/cxl/cxlpci.h |  10 ----
>  include/cxl/pci.h    | 129 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+), 116 deletions(-)
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 04c673e7cdb0..0c84695449d8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -12,6 +12,7 @@
>  #include <linux/node.h>
>  #include <linux/io.h>
>  #include <linux/range.h>
> +#include <cxl/pci.h>
> 
>  extern const struct nvdimm_security_ops *cxl_security_ops;
> 
> @@ -23,63 +24,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>   */
> 
> -/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> -#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> -
> -/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
> -#define CXL_CM_OFFSET 0x1000
> -#define CXL_CM_CAP_HDR_OFFSET 0x0
> -#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
> -#define     CM_CAP_HDR_CAP_ID 1
> -#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
> -#define     CM_CAP_HDR_CAP_VERSION 1
> -#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
> -#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
> -#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
> -#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> -
> -#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> -#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> -#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> -
> -/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> -#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> -#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> -#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> -#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> -#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> -#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> -#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> -#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> -#define   CXL_HDM_DECODER_ENABLE BIT(1)
> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> -#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> -#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> -#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> -#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> -#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> -#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> -#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> -#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> -#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> -#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> -#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> -#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> -
> -/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
> -#define CXL_DECODER_MIN_GRANULARITY 256
> -#define CXL_DECODER_MAX_ENCODED_IG 6
> -
> -static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> -{
> -	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> -
> -	return val ? val * 2 : 1;
> -}
> -
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>  static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
>  {
> @@ -246,51 +190,6 @@ struct cxl_regs {
>  	);
>  };
> 
> -struct cxl_reg_map {
> -	bool valid;
> -	int id;
> -	unsigned long offset;
> -	unsigned long size;
> -};
> -
> -struct cxl_component_reg_map {
> -	struct cxl_reg_map hdm_decoder;
> -	struct cxl_reg_map ras;
> -};
> -
> -struct cxl_device_reg_map {
> -	struct cxl_reg_map status;
> -	struct cxl_reg_map mbox;
> -	struct cxl_reg_map memdev;
> -};
> -
> -struct cxl_pmu_reg_map {
> -	struct cxl_reg_map pmu;
> -};
> -
> -/**
> - * struct cxl_register_map - DVSEC harvested register block mapping parameters
> - * @host: device for devm operations and logging
> - * @base: virtual base of the register-block-BAR + @block_offset
> - * @resource: physical resource base of the register block
> - * @max_size: maximum mapping size to perform register search
> - * @reg_type: see enum cxl_regloc_type
> - * @component_map: cxl_reg_map for component registers
> - * @device_map: cxl_reg_maps for device registers
> - * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> - */
> -struct cxl_register_map {
> -	struct device *host;
> -	void __iomem *base;
> -	resource_size_t resource;
> -	resource_size_t max_size;
> -	u8 reg_type;
> -	union {
> -		struct cxl_component_reg_map component_map;
> -		struct cxl_device_reg_map device_map;
> -		struct cxl_pmu_reg_map pmu_map;
> -	};
> -};
> 
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
> @@ -304,13 +203,9 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
>  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
> 
>  #define CXL_INSTANCES_COUNT -1
> -enum cxl_regloc_type;
>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, unsigned int index);
> -int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0cf64218aa16..9e825c039dd9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -13,16 +13,6 @@
>   */
>  #define CXL_PCI_DEFAULT_MAX_VECTORS 16
> 
> -/* Register Block Identifier (RBI) */
> -enum cxl_regloc_type {
> -	CXL_REGLOC_RBI_EMPTY = 0,
> -	CXL_REGLOC_RBI_COMPONENT,
> -	CXL_REGLOC_RBI_VIRT,
> -	CXL_REGLOC_RBI_MEMDEV,
> -	CXL_REGLOC_RBI_PMU,
> -	CXL_REGLOC_RBI_TYPES
> -};
> -
>  /*
>   * Table Access DOE, CDAT Read Entry Response
>   *
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..763a048262c7
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __CXL_CXL_PCI_H__
> +#define __CXL_CXL_PCI_H__
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/types.h>
> +
> +/* Register Block Identifier (RBI) */
> +enum cxl_regloc_type {
> +	CXL_REGLOC_RBI_EMPTY = 0,
> +	CXL_REGLOC_RBI_COMPONENT,
> +	CXL_REGLOC_RBI_VIRT,
> +	CXL_REGLOC_RBI_MEMDEV,
> +	CXL_REGLOC_RBI_PMU,
> +	CXL_REGLOC_RBI_TYPES
> +};
> +
> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> +
> +/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers */
> +#define CXL_CM_OFFSET 0x1000
> +#define CXL_CM_CAP_HDR_OFFSET 0x0
> +#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
> +#define     CM_CAP_HDR_CAP_ID 1
> +#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
> +#define     CM_CAP_HDR_CAP_VERSION 1
> +#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
> +#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
> +#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
> +#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> +
> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +
> +/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> +#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> +#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> +#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> +#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> +#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> +
> +/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
> +#define CXL_DECODER_MIN_GRANULARITY 256
> +#define CXL_DECODER_MAX_ENCODED_IG 6
> +
> +static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> +{
> +	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> +
> +	return val ? val * 2 : 1;
> +}
> +
> +struct cxl_reg_map {
> +	bool valid;
> +	int id;
> +	unsigned long offset;
> +	unsigned long size;
> +};
> +
> +struct cxl_component_reg_map {
> +	struct cxl_reg_map hdm_decoder;
> +	struct cxl_reg_map ras;
> +};
> +
> +struct cxl_device_reg_map {
> +	struct cxl_reg_map status;
> +	struct cxl_reg_map mbox;
> +	struct cxl_reg_map memdev;
> +};
> +
> +struct cxl_pmu_reg_map {
> +	struct cxl_reg_map pmu;
> +};
> +
> +/**
> + * struct cxl_register_map - DVSEC harvested register block mapping parameters
> + * @host: device for devm operations and logging
> + * @base: virtual base of the register-block-BAR + @block_offset
> + * @resource: physical resource base of the register block
> + * @max_size: maximum mapping size to perform register search
> + * @reg_type: see enum cxl_regloc_type
> + * @component_map: cxl_reg_map for component registers
> + * @device_map: cxl_reg_maps for device registers
> + * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> + */
> +struct cxl_register_map {
> +	struct device *host;
> +	void __iomem *base;
> +	resource_size_t resource;
> +	resource_size_t max_size;
> +	u8 reg_type;
> +	union {
> +		struct cxl_component_reg_map component_map;
> +		struct cxl_device_reg_map device_map;
> +		struct cxl_pmu_reg_map pmu_map;
> +	};
> +};
> +
> +struct pci_dev;
> +
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		      struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map);
> +
> +#endif /* __CXL_CXL_PCI_H__ */
> --
> 2.43.0
> 

