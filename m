Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285862;
	b=b00X/J+kw1V5M40pIImrqG638omhFegr+bzLYl5O+yfffWcP82qtilG/Pq7N165XY/zI
	 MgDUEQMHqPE4O3hQYabK7dFWoqurqbMjlal6KNTT/Bc7jQSPmeee9Q8eD24rwybV4Du+G
	 rc4iUiQevGtgVkOBh2a3Na4sBDE9cuEMIEbiu1v9cNqBgQ3DqODmwZ3RPahV2u/1xuJsX
	 a4+FM/YzHuZgRlwQvYg7xrlinQmhFzbAgWzp/otRM2JfNH5zNzUa2XYBcE7G0pEto6xT+
	 e3MPwncMMsTyCLIgTE6NUH50b7jgU/IMdQuGRbc0DoyZQelGtCro5wrGtWelmfo7sZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285862;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=U3NOPJRcV9yyIDDrvTs1dixarL71vTf7V8XoX8CphYA=;
	b=xs36a2895RobaW8e8U0vUPGDHQTegP9kMdpe6SJzVpFTJ7xf0oVUxL//ZfapTh6H0lvE
	 IacDYBcaKCKmHCuHuid7am5hbhdpqgjoqQu8yxtWngZNqzeAxiwPEehxy5tmJyPWjYPAg
	 kBI3mJyBZT2rkLVo9WyDDmGI58OK8DKVJIkjqLC49pniZgreY4JpQUHxzSPqfKUx4MgkY
	 92y48AoD1TWKWC4SnQIm1AMWdqLLyWGq8dSAO5F30NLfczI7Puq/dNU0Ym25lCUnDIova
	 aqowDtVo5YvS4bTowNE6Tv9Itryat4zbQT+pkGoMMRnm8tP/g8n87UHFx6dpNrJ7OOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Z0eu/mjJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.37
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B460A2637;
	Thu, 29 Oct 2026 14:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 696B460A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z0eu/mjJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovOYrAOlQbL49yehn/+Br7yDr3bEiWaNfU0B9qYsvPjCQ+fjgBexlKSeBoBWR7oKKbaq8xy6hWPB6+qWV1SkfV5xqrw/LTSN0ON/itLDz8Q4KkdImxrkSy6zb4zXAq9572B8PyCELxGKhm0dUXwsjMIcm3D81GF/aeJ/ldkAuYzfq1jHxjA/rIiyMC8UFHQAjYZMChqMGu9BWk1MFBEzRXbFzPfS3izUQWj7F0KoISsWHovd5PuC3cDveOWunJaVtgnP9ixKJycjBkEArV7yAqVGXjp3hxYmqYZo7RqcQ+blHGe6I8lbUo8uOdkXk7/yRf95EdjU7F5IjEUBz50igQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3NOPJRcV9yyIDDrvTs1dixarL71vTf7V8XoX8CphYA=;
 b=iLiQt26+t3z5hShtl+TeIFUv1uGv9wPQMzWHY7W5xrcbjSVsW1tIy/gM9GCQrVnW+F4O5fOk0bMnd6+4kicfyvb9bE6MckqUpYthfvE6K7Faq2ZO1qoDtpADuXlHoWrb2H2WYZfIEowQS6ta9u97huM33fStTWvjmRUfZJZYxQ0pmAfjAUj4oGwL3JITZj2001A52CAvGNePnq8GilWoIF/mDa8EY99vuSgP2lzgjZF7em06snn8ghH5UIS9wwxx2ia5dujn9pDZTRTU4F0EZSoV3zuVbqEl3JoH64Pg8zevKF6l3ZzzAqDbRKaC7EG5CUn1a78ZILM6G5oEoQhOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3NOPJRcV9yyIDDrvTs1dixarL71vTf7V8XoX8CphYA=;
 b=Z0eu/mjJd2l0noRiVRu5WgsdwJ1+EA3l1lE04YYk+bIkPWB6o//WlTMZUrAxacXrucZWk8h7yoz22W4OBmYFwVkYHPR1uCyg2P6LLIMi3XbDJRy8+DMkEydGdYPiuiODVuUFoFcZJTS/a7/UJk8ovhhyg4SpJZ8av9SkaJLOArBsFDhbdvgILWMDZJONiUm6EvBzs18w270J8XvFQcJ7BSrrinxsT334F7X0mPsR4c7b7v7BPhmqP2T0CDZRPvDq+ACkpIIRL7hAamr12VlJOiZ3K59RywNHK0yeQqHnQZkjW72WheaZROWvs3qba9waD+rE0v3tM9Jrm+da5PKNuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA3PR12MB7922.namprd12.prod.outlook.com
 (2603:10b6:806:314::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 14:57:37 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:37 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v16 09/18] cxl: Refresh cached PCI HDM decoder settings
Date: Thu, 29 Oct 2026 14:56:54 +0000
Message-ID: <20261029145703.2185231-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:303:b4::27) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: b628cf20-cd04-4bb5-d87a-08df35ccf8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022113327099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZtYTQdrA5ts1jECczQ1qUHyIVcrf2vFnYGXUy2nOay4U229UUk9Hv1A2RBTTvtYXfj3bioESdtMOqIYyW3N0oYANaLturOnTPrHqv0Yj9K4kVir9H+UVoRBJEs9LWxwwYDqpTs8AoByn/BlUKuLv7xgQVck2YY/nv9i3mpSHLzQezaeKBavEB48FPvldf6CCKdVCqNC2PhyNevSC8eSDH0Q8xS7eG1VNuIxgi4jK60zvv96DwF3Na85kPoP4U3rkOtvrdh1wScMVE+fLmdO/9CcrTmXFVhQ5Q5Px5KQFF0Mtb/yQ1jg42HZ2W8UPjsLmG3p4XIjVXpdgRlRjYVTaYHLkEGF1raw8L5wFkTbE4B6Uax0EwTnzZyvcBl/glDL5Lr7jwM1axISOTIeEr2ddt9xdzu3j4vYded+HuH8sFzD8BIXjbNpmpWemsYP5g7drFbMU5jmjtIB3e0qj6yen9/iik9ysmpctFU67GljIffKyAlBGlWfi2sDpudV57AgOfOpXbGPK2cuFXKBTMeMMy8+J27B/GjKnt/BvnkbF818MFMHX3V+SuDcrvNRWTKUkKGzNCU7XSfSGeeKI6Iw3b6Lbpaf9tnh/s7eGOER5K7RQUMxO3kZZ+Bs1ew9cBa4Hi1M2m0Bw/jAc9xv8seR6Z6FVbY5ZFmfERQBR0ZX4N+pSKex16OJRTiQcCXhSasVEOuuXY5hpM5kJfKJjM2SQlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NozCmFBwLNe5uxGu4E9OOScAoC/gQ3ZJZkZPDNNtL3lxWM3qfFHn5bcgpp2h?=
 =?us-ascii?Q?9nKwnuDopDb42jWc9HYhEaifSMTYl0vrsZ82V7oxhSvCaBIqoNqKYZSCUMHo?=
 =?us-ascii?Q?Z6uRoH/Y3ZLHD8otx6+vugbj3XbaTs1IpUmYN1QuRgCt1XuWVEW/0uG25wbF?=
 =?us-ascii?Q?vLojXqlf3dnqOBrTkp3oJjhRhaZjYvHHxVHixDObHh/9kde+nfsBidFR5PJL?=
 =?us-ascii?Q?NjHlkezj/TiGCQOcMc4GTQ45MHq3O3IFAh+sJBE+rkqLFc1so36aLr7lGpMP?=
 =?us-ascii?Q?ZwBUlJL/CZdUwnT3gittfRmbjd3mgCub8fs/J069zNbGlWgoIA0T6CVWK6IZ?=
 =?us-ascii?Q?jp+SAQoL5euk/LLXxg+URWZVdQfNvKeDcs/nBJOdK03k+oC0R8RmCZO/rvmM?=
 =?us-ascii?Q?OnLu1uSzkHB67cuXN6RV1L6QBZXOJie9CDXIRzqBXb6eAmDZFNrZAo7tvSYp?=
 =?us-ascii?Q?6J2JP6ojru+gsPNdLYWHbZrqqKa+LPDFXCHSZImAcdc3S4uoyiBo7cri+S5g?=
 =?us-ascii?Q?LZfii51e1l7ytrFv795eY8bAQd8zoN8XyOlO//66DXFjz73Jx5N7r6iWvJRO?=
 =?us-ascii?Q?svVhU2Xj6mHVuEdFON+I/H7wjzCO9HlNvVVb8MTgMzBg6up+1aZ8TslZj2AI?=
 =?us-ascii?Q?gKKoj3IXMHAezP/gimSbq7Dlv9IaPqsSZDNbN+OW2wGv21dQbQ5YvhkmN2uW?=
 =?us-ascii?Q?msi5E2tsh5cbKz6J2ha+ogDfFToJCzJDlMmQXNjfKhdtBEJiZFSiZ0PIawWj?=
 =?us-ascii?Q?a/171O6LMHLEwIQ0uqI/uzrSzY14Mt8rgnERj2/GbJRXGOaTlu7KzlNrmnr6?=
 =?us-ascii?Q?VMVHuLGboo+s5XI0wamuMhdYghp13/OrP7P3+qqBYccWFawnL9/vngsQpLjO?=
 =?us-ascii?Q?1qrHEARTMZx8EvYzNu7QEgMV5r4KAUZI796PYPotc1YoIgRE7/ePbI2DVf1y?=
 =?us-ascii?Q?sRXgsXDfVoR2TV0Eb0YI4gc+28gDXFIXRV9pSieD20l8sN4GX36lgEI298Bj?=
 =?us-ascii?Q?os2F+iVquVQ48FZYkRBQ4vb5mQ0mfLaaEFYjTIIvuJBW17yycpkeh14Crmey?=
 =?us-ascii?Q?76ffi2/wW/laW/kmvgwjm8CIonsjujYNlPZxu9tXteAadmCBzHPFJR+r44P3?=
 =?us-ascii?Q?Q9ti4lbqIpXYK2hjqPyuVY4E2ULOUXq8TH7OdCt6lZYUS/GqYD0y/A1CRaAS?=
 =?us-ascii?Q?A4gfsSd/VM0V2/ISsANv1k5D7BSo4bCT+fFJbFx3+QHct+7JqZOKvTm5bVSV?=
 =?us-ascii?Q?qqy4HYcG9wi9HXehoKKf7NBVxFLzdnZ9aRrvtxdkPko8C22x9759WIASC3fM?=
 =?us-ascii?Q?u6DIz7GcwcGDnPtzbw80/iHhI3/1LMqf7xHE1Xw7GA6FWxHRXFfUOJvidtdq?=
 =?us-ascii?Q?Cej58po4yxEBXQPOJ+6xEo6rES7tVNGi8Tu2hClcRFJAurlrZxH4eG7fmkqe?=
 =?us-ascii?Q?Qx+suTXCCbsRrVSfIeBOk73G945jUEvT6kP1eV+oBUhwx3W0riYzYuctFlau?=
 =?us-ascii?Q?5FsVViHD1QBif0ceT0jtt8NUWQySlqVJ3noF1p/39ebeXWCm2HQgUPwAZsiE?=
 =?us-ascii?Q?fgVGCN3Ah9utPR8j/76Dzx3FppPVWgBEJewUuJkYWqCTH/AV67RANuYAsbuy?=
 =?us-ascii?Q?V+tkHjgCd6dMYKGadXh3JRVLKgsq9g6UzLdKHMIfGz1pVtFSInIiVbf1QpOO?=
 =?us-ascii?Q?vXMedNu/qCFINsd5/mGAqalpk2rO7LkGlhI5X+rtBxznnj9Xn5Vk60pOT6Gw?=
 =?us-ascii?Q?PajpM+Ta8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b628cf20-cd04-4bb5-d87a-08df35ccf8ac
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:37.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mG/AT2XIb/cNcEOzlodxxxyO82BnXv74EibO9Ct0bnGXy2u4NdnpvOapnpPgAXueZs3cBaVn5uk+61RIvIZP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922

Early PCI discovery creates the HDM cache, while later CXL enumeration and
decoder operations provide updated programming state.

Refresh the PCI snapshot when decoders are enumerated, committed, or reset
so reset recovery need not walk the CXL topology. Keep cache access and
locking in the built-in HDM state helpers. Ignore updates when no cache
exists and reject decoder-count mismatches.

Use CXL_RESET for the PCI HDM cache. Shared HDM register helpers do not
require it.

Skip cache checks and updates for DVSEC-emulated decoders, which do not
use HDM registers. Keep cached global control when MMIO reads return all
ones.

Non-PCI mock ports have no upstream PCI device, so the cache helpers
ignore them. This avoids test wrappers and a circular dependency between
cxl_core and cxl_mock.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=50a88f5194e5df38590d413f925d8d5afa8a8488
---
 drivers/cxl/Kconfig          |  5 ++++
 drivers/cxl/core/core.h      |  1 +
 drivers/cxl/core/hdm.c       | 34 +++++++++++++++++++--
 drivers/cxl/core/hdm_state.c | 57 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c       | 24 +++++++++++++++
 include/cxl/cxl.h            |  1 +
 include/cxl/hdm.h            | 32 ++++++++++++++++++++
 include/linux/pci.h          |  6 ++++
 8 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..8b08bfdc4982 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select CXL_RESET
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	select FWCTL if CXL_FEATURES
 	help
@@ -244,3 +245,7 @@ config CXL_ATL
 	depends on ACPI_PRMT && AMD_NB
 
 endif
+
+# CXL_BUS requires the PCI HDM cache and built-in state helpers, even when modular.
+config CXL_RESET
+	bool
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index ea539f00e55d..e34d574f6594 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -224,6 +224,7 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
+int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm);
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_port_get_possible_dports(struct cxl_port *port);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 85f9abf58a42..ec387070d7ad 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -725,6 +725,24 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
+static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
+				    struct cxl_decoder *cxld)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+
+	if (!hdm)
+		return;
+	if (!is_endpoint_decoder(&cxld->dev))
+		return;
+
+	pdev = cxl_port_get_uport_pci_dev(cxlhdm->port);
+	if (!pdev)
+		return;
+	cxl_hdm_cache_refresh_decoder(pdev, hdm,
+				      to_cxl_endpoint_decoder(&cxld->dev));
+}
+
 static void
 cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
 			      struct cxl_endpoint_decoder_settings *settings)
@@ -805,6 +823,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 	port->commit_end++;
 	cxld->config.flags |= CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -877,6 +896,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1079,13 +1099,21 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
-	int i;
+	/* DVSEC-emulated decoders do not describe the cached HDM registers. */
+	bool emulated = should_emulate_decoders(info);
 	u64 dpa_base = 0;
+	int i, rc;
+
+	if (is_cxl_endpoint(port) && hdm && !emulated) {
+		rc = cxl_hdm_check_decoder_count(cxlhdm);
+		if (rc)
+			return rc;
+	}
 
 	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1120,6 +1148,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		if (!emulated)
+			cxl_hdm_refresh_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index c9cc019902ef..d4c2be1ef833 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 
 #include <cxl/hdm.h>
@@ -13,3 +15,58 @@ struct cxl_rwsem cxl_rwsem = {
 	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
 };
 EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
+
+void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
+				   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_endpoint_decoder_settings *settings;
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_hdm_info *info;
+	u32 global_ctrl;
+	int id;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	id = cxld->config.id;
+	info = pdev->hdm;
+	if (!info)
+		return;
+	if (id < 0 || id >= info->decoder_count) {
+		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
+			 id, info->decoder_count);
+		return;
+	}
+
+	/* Preserve the last good value when the device does not respond. */
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	if (global_ctrl != U32_MAX)
+		info->global_ctrl = global_ctrl;
+	settings = &info->settings[id];
+
+	/*
+	 * A disabled decoder's software object may retain its old range and
+	 * skip state. Leave only the decoder id in the cached settings so stale
+	 * state is not restored as an enabled decode.
+	 */
+	*settings = (struct cxl_endpoint_decoder_settings) {
+		.config.id = id,
+	};
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
+		settings->config = cxld->config;
+		settings->skip = cxled->skip;
+	}
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_refresh_decoder, "cxl_core");
+
+int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
+{
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	if (pdev->hdm && pdev->hdm->decoder_count != count) {
+		pci_warn(pdev,
+			 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+			 pdev->hdm->decoder_count, count);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 33b21c8dcb21..e2034a2179b4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/hdm.h>
 #include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
@@ -180,6 +181,29 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
+/**
+ * cxl_hdm_check_decoder_count() - check enumeration against the PCI HDM cache
+ * @cxlhdm: HDM capability containing the decoder count to check
+ *
+ * Take cxl_rwsem.dpa for read while comparing the cached count. Call only
+ * for hardware HDM decoders, since DVSEC-emulated ranges do not describe
+ * the HDM registers represented by the cache.
+ *
+ * Return: 0 if the counts match or no upstream PCI device or cache exists,
+ * or -ENXIO if the cached and enumerated decoder counts differ.
+ */
+int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+
+	if (!pdev)
+		return 0;
+
+	return cxl_hdm_cache_check_decoder_count(pdev, cxlhdm->decoder_count);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_hdm_check_decoder_count, "CXL");
+
 static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 6d6e564be27a..341a7c52894a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct cxl_hdm_info;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 219b9bb67440..06e9aa4479c2 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 #include <cxl/cxl.h>
 
+struct pci_dev;
+struct cxl_endpoint_decoder;
+
 /**
  * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
  * @config: common decoder configuration
@@ -16,4 +19,33 @@ struct cxl_endpoint_decoder_settings {
 	u64 skip;
 };
 
+/**
+ * struct cxl_hdm_info - cached CXL HDM state for a PCI device
+ * @decoder_count: number of entries in @settings
+ * @hdm_bar: PCI BAR containing the HDM decoder capability
+ * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
+ * @hdm_size: size of the HDM decoder register block
+ * @global_ctrl: HDM decoder global control register
+ * @dvsec_ctrl: CXL DVSEC control register
+ * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
+ * @settings: per-endpoint-decoder programming state
+ *
+ * Publication through pci_dev.hdm and all mutable fields are protected by
+ * cxl_rwsem.dpa.
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
+	u16 dvsec_ctrl;
+	bool dvsec_ctrl_valid;
+	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
+};
+
+void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
+				   struct cxl_endpoint_decoder *cxled);
+int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
+
 #endif /* __CXL_HDM_H__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..7bb37fcb556d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_RESET
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -566,6 +569,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_RESET
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

