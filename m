Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905186;
	b=vZIaYZl3b5P1I4zl3YcR5iJELfdPA/VPQCKB3CxnaZir6we0hOaijhAk/+UuVr/cJW6O
	 OnOgH1p1NjtfDX7st6+kUoWpr6P+I3/CnE860LtjH+D463tEEUDNljHYVd/0E7DJAL1gl
	 5RefbtYZGHS8o8pDDt2OKa0sRsJ9g1Q5sgK8fca1VnAh5BGTIOBPbH5zyB2iJUcpUnm1U
	 5VXZRqCPv9rKHZDiFu/oWYlPp1jGqG+AzJEaTTPuYY3jzQY85PJmnuotgC5s3J0+9eRkL
	 ZMdp1/gTfAYwdwnHoYYwWobU2110Pa1g8am1CoYKCUOGp+4QQFHsV88pS4yfhfHF+lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905186;
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
	bh=YHUSrdyCnmkeTwF1DoxsZt3yxe4WYwIqmbdu2KPrPXU=;
	b=ipPssIdoNUT2Vx/eJMVKqm21A8C62FipSSQ5LeYyhMkGB0DftxW2J04Vaz0CxlrSg6NZ
	 gCzLb48kUqHFnGAjfa8SnkzZL/PI9BlRvQQEq7fB9OylpW1oafxZujiXKEZAkSzJ2vKcp
	 jlD/7HVg+Yj0AftggXK5Sk2Ia364aGL6bHwKbIRh+boZCWEdcqCR4I4chElfXZmPf17lT
	 UgdJZW3PzX8rpvbtZI78CnqrKSvRhnv7Xx2tIIRHV5mOq5elu73ccxXv0soAmLwwmc5g4
	 j/2OMzJkD/kB71YqyVWcyzLXNqVjxdWwGHcoGFxvYViME+Eug+nAY4KX7zlFZPFYKjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Grlk3b2l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.52
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F7606D808;
	Thu,  5 Nov 2026 18:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E7F7606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Grlk3b2l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wje47awgJ92iv+nblJJeBPpz534RnwOia2FqVAS0PLdMpEQ5v1wYHsbAfkdysnvasy6NfoLKXHfkFOASHTjVbOBssPieXrNpUK5F+3mLgwq0prmOmSlTunqrCV7bhfeXh2M1gY+zrvos0+ZeCkojz4I4sDpbmwPamPM0pXyfAwNMN03XaNyUBwCWCTd/iTcXwZLGzAUQUJHi4mHzSYIbB736bItKBK838cy7ptFBODJYBGlMqU+q7rP41eGiHO8xMAK1n7R0H/9XAzM92kBhe3t0d1L8XqHn/r/wjvCk2RVWMdpXzXwukWbIvf1CW78fL9ah/DBxi3izWxGAnYeFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHUSrdyCnmkeTwF1DoxsZt3yxe4WYwIqmbdu2KPrPXU=;
 b=J73LojdsSgopo71A19G16orM9/Owqaf/4991Mtw5k9sxh7NlNMPiI8PJLnf/vKESZ6BX0T/6qCWbQC69sNZ4xS02TqkHNpiuSQ+pslQWjy9PodNDqa7zhyo1sdXWzxJWUgAc1uo8HDwWrlzur7GHclZ2d00Wm9AyS9E3DufB3P7S2HwruZOmXExYSP5HP8VQwqtkOqG1ED7v4zt1XrgojIS+uX22gnc4KsbgT0YG13Aroh+PLXf4BqUcGTVz+GwHDTI/Ix6ftK4mvIrLWII2q4cryWy08U6MWimo1BWVVJapXVtVkhLfhmU9A6GJ0dwqhkvwe0kzVPgBE9MrJ4+vDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHUSrdyCnmkeTwF1DoxsZt3yxe4WYwIqmbdu2KPrPXU=;
 b=Grlk3b2lTl3wTa8v769KX2NBJ9iL8jF4L0Yx42ECwGsEuEZcuvK3ph+WPkRdx3L8QYodFZ5G/ZU8gY/VFf4t3C/td4iUagoYHYDZzix3ae5dBD2jDGSbgk2//eK0t+xapNXLjIIf041CddgfN0Bw4zucsaxgbNMH1h5pa77bBvx6pjNKEZB6RSVulUN0w/W6mbJnNunYbI3HwW/fuVLMOUPPMlZFDu+yjacUbSvZXfUbabuevJaLTd9X+ODm4/1Sc9mz4wapKQaF5ivSV2XV2Fowj65zf6S9+DmA0wTBpeIKeRulM9D5HEjc795KMKit13uSaZailOv9srrESyvBzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DM6PR12MB4105.namprd12.prod.outlook.com
 (2603:10b6:5:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:37 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:37 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
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
Subject: [PATCH v17 07/19] cxl: Share HDM decoder register unpacking
Date: Thu,  5 Nov 2026 18:59:05 +0000
Message-ID: <20261105185917.2667656-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 80357b8f-5c7b-4ca5-e4a7-08df3b6ef086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|260925021311599003|260925022911599003|260925021911599003|11063799006|261026121527099003|56012099006|261021123027099003|261022075727099003|261026140227099003|261102130727099003|261009223027099003|261021121427099003|261102123227099003|261028144727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JQzbacmzoUC7us/BbnSMT9+IIm4corzp4rHFP6qdLMJrID0eGOMN+33bGl1wCEQyFHPqUCJD9AX/ZOuWEKDdiaNunr3IeVcZkbr+3OTSC9VRTViil9cKBsrZmhppIOnQUh2fZHPNxHW9QMeh3m9Ih+t1+8ibMZ9C3rFezOmDRIZB5skMeVDC6qg1zjRj4vbJKvcBxcDS69Nrfv6zYxwBqBwjUHVKJ0mY6vJfF8xH21u9aG9x1DSch7lJHwdUtgTYmczrBiPJqOZoACyO8A/jxsyR8PzzHqJOSEW2H2UBHKBmTPOTFXWs/UthGaCNyfA+wpXRmEF4QD/Mcf3/5cPMQ7ECRlMbLcX21tMkJrGOCUXxJtCIWM7e14hvxV14mBOCMYg8zXRCsGgRSbdX3q4pMsS85WlKgcq8vHksMaRwiW37PRIEBe2XufzErRu4Cxo5eKG1Vw9pMBaImsJjYlcVkMubaaI12c7WnJXwUVcrTL1PLUW8kYV4DjSsfvqCJq0jw9nbAlcANaVvEF3mJ+ozHkRApyfq6bGsjNBMwNwxYVSC968YzXTIQvJ2lw0le7q4ln9OJGhq4VXLcWO5MVfivyjsFawd0OR/9JqbgV0RXKb7Yl9Qa0p021sD1ArQ5DmP4BnMxzUt+hQ1PITOcDLj1J7KPlF5JXALqGYgrOXoRup8RG2SPVrZgwLJV3uNK+vb0Ow7ubLkhE0Vk/vvlwWOYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(261026121527099003)(56012099006)(261021123027099003)(261022075727099003)(261026140227099003)(261102130727099003)(261009223027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AyKl7+bx3ZcSEcObXy6VwVo5tcZHXHjI5ehdWkaQYyAbEVCq6aKI6G82liXL?=
 =?us-ascii?Q?oMMTnfAKhmpOBCp/6pCIf2eACfEdeDdMBNPAc86qpkSudypQKLtLLQ0TVIpt?=
 =?us-ascii?Q?xbW93Jh+2LOfuTrBb6k6Loao2xl5WxlpIjeVxXfQm0qWzUo/fZEMLL1wnBZG?=
 =?us-ascii?Q?sLEYj1JU1qI+iy2uaNimqgW6ezKZG9esORVzsyjjhMFvUT+0nJSyyqBU1vdR?=
 =?us-ascii?Q?vflKD9h1ifc3Gg7VF0LZvx4hVOSKrUYsck1N9fQ/+AKHpWbSe9jJgbWDxL3T?=
 =?us-ascii?Q?RdmXryfponL/bt13pdUZ9ylxPwG3NDf1kZVfJl5B0cStyhSq1BM7dG/KHe7C?=
 =?us-ascii?Q?FeqooLfyGn2zqtBU3QZ3xMpUq3Z0Nwhvo1y7DUFZ/R01CQme6fXWGYYn0RKg?=
 =?us-ascii?Q?RSpOr0m0DCLkKqxsGw+7jgC2VDNvVtRHqUOz4vXTtZDN+OI8iL4Yh+JiSjQc?=
 =?us-ascii?Q?XQmmQXMc6eaYXp8blPz0kN5Y6AlWdMznsPLQ8pnCLZWdsHpifmf04OIco16/?=
 =?us-ascii?Q?dC0ydUomUgiGipeTBV4fo9ovjwl/ZijytXlum0mqaeVAEyy1Ki9LaJxBH9nk?=
 =?us-ascii?Q?4BqCBZqZ7N0TWpgIi1/D1NIXUPWu3sfM2vtQsLbmZkDmLwz/y7BxDOlL3+Vz?=
 =?us-ascii?Q?8+THeTWVL++7Tlcbp7EtWpt9/DS1tMva4nl1XvcdoQNWxrdZrLVhmq5XHQDv?=
 =?us-ascii?Q?G8fxmt65ajOTQGs6WQX9WQhgPIgHj/UF0Bo4zHV6vWh2cXav9plym+Si69Cs?=
 =?us-ascii?Q?hqZ+lt75OdstHAzp4HxOBwrTJ8vBAn5ss81C59roOnL0yl1M3iCBGgLHGxSt?=
 =?us-ascii?Q?DhlmUhr3c6CpfmJLEUvpctvBcmfVnsR9KVVGTLZbOCCi19FW8/cwr+2vtzni?=
 =?us-ascii?Q?q9bBCdR19efXnqf1ze1wcUjNL+WRhLnGtGxHJm/F7i/dyedeuVDOwrcB4dCN?=
 =?us-ascii?Q?veyvivp3yjy8VW1I8IbsIpvSUbAqqia3gV5uW5bm88Om4m9YNNZz/rp0eBkc?=
 =?us-ascii?Q?L2vnwIFXkt9d0wIvzjPusI9tVYqB/3BrpK3P5Gj78vT0v73W5FszSGN0q0/9?=
 =?us-ascii?Q?by1AD1qPF4gmVyJGtTPuqpX5RIxc65VA1wkccI20QeYoMWOd99rC2Z9A6K7j?=
 =?us-ascii?Q?J4jwvtWQMtD/vShT1L2/qdxqpkuqv/4PyDEgOv2lhbrvcJM4trx+4dnGpBSY?=
 =?us-ascii?Q?CVtMIdjPFGS/APmO03nqkNSA4kf4Dqj34gwqby3d21FFV/+KoYsTZBON/Adq?=
 =?us-ascii?Q?DY/wi/Df1tIOHdRZEP6L5YkCnb+DK9bf9URJ9E61Fh0E4GGSM68yWB/D5v0C?=
 =?us-ascii?Q?iceR9+S3uDgykPUDOQ3ffNfteFIyg+n+KavRZ/Ox0YcHgqK8pvY6eOIJYZku?=
 =?us-ascii?Q?u3EAnRw5LGvJLPOxHztJT82j1marfdoIzrU9yl3RifbKuGonJmzKr0M/VA/H?=
 =?us-ascii?Q?2y4q1kS4KQ4HW58E4avztMEmZ8vhIkaJ+PI14SOzmNf7319piSiboWCL4zE7?=
 =?us-ascii?Q?2ddQCOlOJEMA7v3RWjPmbxxwgxYEK67Nbm7JB/uEEz5Dlt533h5RclsXf7x2?=
 =?us-ascii?Q?P6nELcN4XzPnlEPaykwY/zIhKIi5dpd5HjxpgBqztl7O0D+9aw5WimOkrMvy?=
 =?us-ascii?Q?pEklt0GVWutOk+hbC+A1l23/T0lWpWSnahfe4BTp7k/GokkZtTAxL940Um8F?=
 =?us-ascii?Q?I39/2fkffJ7xTbQ6jVpKDbdWAOF3qpq3UYn+To3ZN6nZa3a6XwLgSyIfozwg?=
 =?us-ascii?Q?Q/e+BqrbKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80357b8f-5c7b-4ca5-e4a7-08df3b6ef086
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:37.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXdgA3sRrU62u7kiYZKJaIB3vSPPGvJ2WZMPPWRGwxfozB0+cNdP7h/yN7RELR/4vcrVyDjNeXdFMC6+M78XPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

Factor common HDM register parsing into cxl_hdm_unpack_decoder().
Validate range and interleave parameters in locals before publishing the
decoder configuration, including enable and lock flags. Reject nonzero
ranges whose end overflows the address space while preserving the
zero-size range representation.

Read decoder base and size registers low then high through a shared
helper used by enumeration and the reset snapshot.

Read switch target lists and endpoint DPA skip in their respective
branches of init_hdm_decoder().

Preserve the decoder ID allocated by cxl_decoder_init() when publishing
the parsed configuration.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
Reviewed-by: Richard Cheng <icheng@nvidia.com>

---
Changes in v17:
- Initialize the zero-size end to base - 1 and document the zero-size
  case, removing a branch (Richard)
  https://lore.kernel.org/linux-cxl/auQ27s1rSCcbdRJ3@MWDK4CY14F/

Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=7d6ed7faf7d8e14abce8ae23902d5323738868d2
---
 drivers/cxl/core/core.h     |  5 +++
 drivers/cxl/core/hdm.c      | 65 ++++++++------------------------
 drivers/cxl/core/hdm_regs.c | 74 +++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 49 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index fb14b222f3ca..ea539f00e55d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -147,6 +147,11 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
 			     u64 targets, void __iomem *hdm);
 int cxld_await_commit(void __iomem *hdm, int id);
 
+int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
+			   u32 ctrl, u64 base, u64 size);
+int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
+			 int id, u32 ctrl);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 2c373dfbc070..5b5f5f22ea32 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -938,11 +938,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
-	u64 size, base, skip, dpa_size, lo, hi;
-	bool committed;
+	u64 size, skip, dpa_size, lo, hi;
+	struct cxl_decoder_config config;
 	u32 remainder;
-	int i, rc;
 	u32 ctrl;
+	int i, rc;
 	union {
 		u64 value;
 		unsigned char target_id[8];
@@ -953,41 +953,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 							which, info);
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
-	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(which));
-	base = (hi << 32) + lo;
-	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
-	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	rc = cxl_hdm_read_decoder(&config, hdm, which, ctrl);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->config.id, ctrl, rc);
+		return rc;
+	}
+
+	config.id = cxld->config.id;
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
-
-	if (!committed)
-		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
-		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->config.id);
-		return -ENXIO;
-	}
+	cxld->config = config;
+	size = range_len(&cxld->config.hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->config.hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
 
 	/* decoders are enabled if committed */
-	if (committed) {
-		cxld->config.flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->config.flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->config.target_type = CXL_DECODER_DEVMEM;
-
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->config.id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1021,23 +1005,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->config.interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->config.id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->config.interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->config.id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->config.id, cxld->config.hpa_range.start, cxld->config.hpa_range.end,
 		cxld->config.interleave_ways, cxld->config.interleave_granularity);
@@ -1052,7 +1019,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		return 0;
 	}
 
-	if (!committed)
+	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
 		return 0;
 
 	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index 53d2f236e49c..cc5d77c4abf5 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -116,3 +116,77 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
 	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
+
+int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
+			   u32 ctrl, u64 base, u64 size)
+{
+	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	enum cxl_decoder_type target_type = 0;
+	int interleave_granularity;
+	unsigned long flags = 0;
+	struct range hpa_range;
+	int interleave_ways;
+	u64 end;
+	int rc;
+
+	if (!committed)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX)
+		return -ENXIO;
+	/* A zero-size decoder maps no HPA; its range is empty at @base. */
+	end = base - 1;
+	if (size && check_add_overflow(base, size - 1, &end))
+		return -ENXIO;
+
+	hpa_range = (struct range) {
+		.start = base,
+		.end = end,
+	};
+
+	if (committed) {
+		flags |= CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			flags |= CXL_DECODER_F_LOCK;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
+			target_type = CXL_DECODER_HOSTONLYMEM;
+		else
+			target_type = CXL_DECODER_DEVMEM;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &interleave_ways);
+	if (rc)
+		return rc;
+	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+				&interleave_granularity);
+	if (rc)
+		return rc;
+
+	*config = (struct cxl_decoder_config) {
+		.id = id,
+		.hpa_range = hpa_range,
+		.interleave_ways = interleave_ways,
+		.interleave_granularity = interleave_granularity,
+		.target_type = target_type,
+		.flags = flags,
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
+
+int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
+			 int id, u32 ctrl)
+{
+	u64 lo, hi, base, size;
+
+	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	base = (hi << 32) | lo;
+	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	size = (hi << 32) | lo;
+
+	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
-- 
2.43.0

