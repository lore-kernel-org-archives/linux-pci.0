Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285879;
	b=oxb2bcK6uN0QAJwBsLi+f2G9QrXSV9JwhMDjC5impTj9CpU7PbGobqau5QmhFkXtuwGX
	 T396IlV9qEbAGgKyzQxBS3ik6sfngDlkzHYNMcujWDH2PkK/FhQatJD+xXLeFhqIt9wR+
	 jZ4kXFnuBLEFeCyGcbNPgNj6bpbdHJTYqvxcYRD9OXlcGgPEdLCQ72JGiFybCm/J24+Ea
	 bNhaqSlfzH7F4fETrlm38pyuP5ImF0oedx90SoRsT590EIKjHaQi655IJxFvz/MR/W7gT
	 Gmx+EpUGvcKxVmXuHgRX65zzlRk8sbAJ3EHENhYHK0IkCc/O9v9k00mP/KOWhQFOUzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285879;
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
	bh=kcifZqZWUU7DpBnvYHpzcoG71QKOrnOOjD/MyXkzcz8=;
	b=OxRO7e81R/BrN4lgE29pQsgYWVFpJ/uKlcb6NqwINUYP3UBdG5aYUopOVXi8wmUFOXyy
	 CM/Lc+J4IjUvTjz0va4Sq4RUpySaudhDNm9i3wecZjwPwG1SSJYBdzs9vWqGRkGef6gfR
	 mG+Wq4KrXMYk6X/lsdGIat6b5xOqu8lAZ8+5i9aBt+rsYuPC7R2OEeIvCz9eYpKfP+Ucb
	 tEsC+HZoc3CIju2/lrLg/Vl7361jnkiGwk7tl43WYWtlaB73abbsrN11RNziSHBvq1st7
	 SMty5qMXnlPh0wFWWb6kyg+oWdYcKJmg/sNvMzK79Msd4UotUCNMsCtxDF1HnnrqQbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g9aHk3vN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.30
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125A60A2617;
	Thu, 29 Oct 2026 14:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D125A60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g9aHk3vN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmdz7Xd77woiTNUcPulCna87j7KuE+OvFlsxPNgGJkotip11XBc38TJ6qyzghlNIQ2ivVH2PJmS8g4SzDxIK66QFdvIIF4RiBMciXCVhOROYRwoTzgnQkCjtCYze5ZGXb9ymJVWvMTf9bhB/dDd55zC9IZlaqmT3yEl1Zx7j8Dmpr7ILfaI/ASPfkjsZ7BQ5M4YOHKZb/Jiy0hlkAeBPwC1CUSON8mjR6cZbi4Eq8WqGM+jZyVfvvyFvoHS17jEMgN0hHUPWlvGMRXNSBCQ7dFj86vxppSA+xmrsfOExcoB6x7WDOugXq/FrO6JmxKDP/UCjRsVPcjsxBfPnb7Iklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcifZqZWUU7DpBnvYHpzcoG71QKOrnOOjD/MyXkzcz8=;
 b=g+uouw386EfkmltVA9EgCOCDcNw5/dMClsKqk6+mJs+dyHWNlIDe0LzUNEfIA1TybUFuleJr0Jcyhhos4jP6guQLuIj2quUPI+nd5HkaKNHog0AqsuZP+zt2BAPVO/4zU2fBi6YsXSTK98HuS09cOC6dOoFbcN6UaYwa1W9bHv83EdtKucC2IuSejVRBSmEn/b+eaG6WCfC3Mro5Y1yfMFV57mW0zV1FjzGStVtXsmWDtPGaYfpRO/yQiuDkIvsJfQiOCdvgu2U7/q1EJcd4YCIA6tySYX77NJFSruyhwziVbBfRpeo5vyEA0hVX7QNsIQhq2O97A48fZf0Nvzbcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcifZqZWUU7DpBnvYHpzcoG71QKOrnOOjD/MyXkzcz8=;
 b=g9aHk3vNg4GTVWTChtMZ1Zp5zFuf8PyoqLhEHEWpf2kdzsfx9HNnOiRDHb3C32VSwJaXNqrf3shXj4Mi6vMLaNS+6Z4n3Y5H5dPg6+ev8UcfjKEfP/KEld+/RIkrYJ/t1ZYhmAvUxG+DObkN6EBWc4ErAFCOfBcl+AAs+3XK7smYtZCxy/244J1kWxGuCSExpTV3nx6q0OI0pgJQBRgkOMAiY7Cs8aW2RVC7vQBNoziFkNFUk/MUcbymU7MsJKgnfqv1ejMdEJDVvDX72SCVo0m4vKnYQ4BTtM4vUWotQ4KXsk2FU+LEe+WKNXwGMWBS9jC8R7U6RUZY0F14qHmZIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DM6PR12MB4355.namprd12.prod.outlook.com
 (2603:10b6:5:2a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:53 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:52 +0000
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
Subject: [PATCH v16 15/18] PCI/CXL: Restore CXL state after PCI reset
Date: Thu, 29 Oct 2026 14:57:00 +0000
Message-ID: <20261029145703.2185231-16-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::22) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b69ab92-f53c-4423-974f-08df35cd020a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|261028144727099003|261009223027099003|261022105027099003|56012099006|261026121527099003|261026140227099003|261022113327099003|10067099003|11063799006|261022075727099003|261021121427099003|261021123027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	P6YQ0H66MJre7Pn4nJvx510EWu0g2c2CPipWsUlQ7HjIMzvSNVNPp9scKfPgywF+znSbNlqnauwzCDU3rgwNDODPKs0JE94G0Zmp7D75PWba2AcvX0HZtHAOdP3F9AwsHK6ZNTHMpHY7KDg2p+x/SGIGyoYkRu10BnE6NYfHXtVCKbxOTBQtr6XXtYGL3gFNh1eVRNdFfhjbX4Z9yhaQ44TZMr8EyfE8U0n7tTQ3gTzeJHvTOh4zBo/u1i8xBZK9oufNaLKzhqngFxyhna0gKgPkBwtRFwCJlKIVREuDx85+ljVaUdlvKBdqaqktxJYNz31k++1xOj20W/pkV0sj0JVmu9eH5XSVCxM6wClv4s3n6l6q3ZdlAETdMd+vDBcemXhM1ku6aTg03pFtZmUH9siHXUR36lZpThxzu1Z5SL4MAPJ8n5YdgCKlUKUCsUoFFqwisZd3ZMHh0Inm/UOLIuc3RNHyPAIgLu5R/mMmLRFUQ2nSn/D08I+gr0AufTPjKxoALvgHPCxYJTyCgafr9WrLZKdUZQKkdfPnZZJMjCWSayRazLWImeNa+WULtsGa6fnzV3wLzllxiUCL43fH1AOZMMPGllEpd1x4skGrz9F7SLNCDfv8NG2Q7BtOE1gZAV6/yJ9ZRzS5kcDz7CkuFVGeenUtXrkCYrd3cRReC9KG/Ic4FemqPDXncpvMRZMi1dWANNMiMBS7LW+87SZB4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(261028144727099003)(261009223027099003)(261022105027099003)(56012099006)(261026121527099003)(261026140227099003)(261022113327099003)(10067099003)(11063799006)(261022075727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wvnBWc1VxC5DEQ1k84hHJqJRZkgheiNgOeLYv1HUslkNvCAJhbhPJTamwAje?=
 =?us-ascii?Q?XukcGBjJAyLmjE5rMrxOMOzkh+QvMpw0wyPM/HfgvG/2pW4qGalm3IPTjV1c?=
 =?us-ascii?Q?GxSMF4uXhXhv/4HNC2J/C5V0x298aywXznXb5M++KDRvfpUyT0xhN3+1jBP4?=
 =?us-ascii?Q?AArCGoO80frRNtWJqXA3j3Iw0tHyn5MPpHfef1+dNE9V9EDBd1X3G0WnMRM8?=
 =?us-ascii?Q?5yQT88pGGUqTTL+uC++OTPFfCV5cSOecANQW4Iz5Un7tf7nGUL6sUovledGf?=
 =?us-ascii?Q?m+tPrsve5DipV4EtVGb5B+r8s5PloL0y1hbASuIXVn2XJ+5EAJKCr3WEXYWR?=
 =?us-ascii?Q?/MP98zOAhJw+TPwZOF+yg1tLllRxc4LsT2iK7K3szezg++AFc1OLzarCAltE?=
 =?us-ascii?Q?5dSinvvlByZJGTzIzOBGf7Zw0WVLwJieIHPtPtATuspgEWa78F+g+CqCrEbx?=
 =?us-ascii?Q?gEm/81MEaCz+yK0BmcTybIpYhG+GhoJRtWRq3FgJ2XZrJBwE0dbM/NIFKUWd?=
 =?us-ascii?Q?55BQW9+xeKXmTl473lmRIR7rNbGh22skWFSO1bb+HE/E0YdHT4gxn/LweMM3?=
 =?us-ascii?Q?lB1zkRme+iiGTRVLrOf0MNKgFJ1tAumG4yeb+GlDQ2Y3NetRHcIjzQ7uZrsx?=
 =?us-ascii?Q?eI4o3ajmNNC6uTwp5CnUtq/GWdxjf5/tNie+/3Dtpimf0Asl1etYdVukLSjg?=
 =?us-ascii?Q?/GetasohVL1sV/VZI/SvU94KUrYdrnUp1b/jAZX9TkyZq3s9JViCFheHTYG9?=
 =?us-ascii?Q?R4r243mmx7MVIrsj+pIQMSpG3iUh9msrDXi3giXWyCvV/8J9YeE3YoTQ6fAS?=
 =?us-ascii?Q?fNPgMGGZZkgrxdKF2e2wY8DE6AsQJNelTHr/b2+SNDC8ISo8V3yBdF5qOeif?=
 =?us-ascii?Q?O1xBP7MriV9xw4crrgVLF1vvWM9fPociLCV1WdAw2MORqZ8sgZIod5ddaQub?=
 =?us-ascii?Q?VPqnNMa2CDLUpwTLjmcD9n2FxYzpl6Btr6sETrMH3cWil8Y+5I3r8c+rYO8l?=
 =?us-ascii?Q?bIeBRswQkgi1FihacmQMNdepDzl7swABY0rWgkl08IBDpACwIXNuOcWNAK6T?=
 =?us-ascii?Q?vWQ0r3U47WSIel7TFw6StHAe6EdN2qocY42FSdXTFNlNcgarucT4GK5/VmjL?=
 =?us-ascii?Q?KmxEYETzEbIPrjoQxlNIapWAFYT4b6pGJnv5AE/srYszZPG1DR+HqbG/um4w?=
 =?us-ascii?Q?Y+a9QcpmG7vo7gz5+Oolw25G+dZqHQmTCi/xlt+HBNrEbWqbIbKuacA+IoWH?=
 =?us-ascii?Q?NzNjBSkafcqR2Ywq61N7FSF2ypec12TBoZjJA7y3Kt/rqbZ7aBfzOpQ9v4+0?=
 =?us-ascii?Q?Q9XOUuRa2y92dQMHhcfqHNPLKx7QhqvDG+/JyGfi39U6mS0pmPLsteRriAxp?=
 =?us-ascii?Q?6mOHijaIZDgiNMmnoNgbyyGmjB/8ylI1SciMqc480C3zbdfx7Ttf0ddJMgfJ?=
 =?us-ascii?Q?FQH4rhT86SXr3EZqffJJU7IepKkWGZBFZc2BI5tvISPtb03vELalVA5nxTo/?=
 =?us-ascii?Q?IukIiRHW1UE31hwud4W53Jx/eKDBHlvMHlHvI5UAOvsceCNsRX2JE6W1srqJ?=
 =?us-ascii?Q?lPrZo7o6OURXuiNISlL9viu+K5TYTmIRntc441aBOQj3KzgB9hpEGVr25ZDK?=
 =?us-ascii?Q?UrP27ChotW/fQtm4f1o8MBxjHdX/f3rs0aM9nAz7lNw8AC5dLRs5BFl6OBJe?=
 =?us-ascii?Q?R3JiRgyvLNHnRsGsWA16o31bHN7LAJ2Oh6nX7+Cca19ZPfjfKJlFPffUA6Br?=
 =?us-ascii?Q?MdvXBfYz9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b69ab92-f53c-4423-974f-08df35cd020a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:52.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzOu4bxfhs/Zkn0/Uwknvx+JvqEOa+G/uBM6b4nTolmbxkV5psqlLb6EJ75qINVvPboG0Gv8+qgcO3Q4DmtbMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355

Restore the PCI configuration needed for HDM access, followed by cached
HDM decoder and CXL Device DVSEC state. Set Lock On Commit before
recommitting a cleared locked decoder; leave surviving locked state
unchanged.

Stop at the first restoration failure and preserve a disabled PCI command
snapshot. Keep IOMMU exclusion active through restoration and post-reset
cache invalidation.

Program the decoders from built-in CXL code that takes only a mapped
register block, and keep PCI state handling in drivers/pci/cxl.c.

The restore helper structure and diagnostics follow Dave Jiang's
reference implementation on his cxl-type2-reset branch.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=81fff5893a3140361cac625b09ada798afb92e03
---
 drivers/cxl/core/core.h     |   2 +-
 drivers/cxl/core/hdm.c      |   2 +-
 drivers/cxl/core/hdm_regs.c | 153 ++++++++++++++++++++++++++---
 drivers/pci/cxl.c           | 185 ++++++++++++++++++++++++++++++++++--
 include/cxl/hdm.h           |   2 +
 5 files changed, 325 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e34d574f6594..9fc9fd6c771e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -145,7 +145,7 @@ void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *setti
 			       void __iomem *hdm);
 void cxl_commit_start_switch(const struct cxl_decoder_config *config,
 			     u64 targets, void __iomem *hdm);
-int cxld_await_commit(void __iomem *hdm, int id);
+int cxld_await_commit(void __iomem *hdm, int id, bool committed);
 
 int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
 			   u32 ctrl, u64 base, u64 size);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ec387070d7ad..ad8cb1e76afb 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -815,7 +815,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
 		setup_hw_decoder(cxld, hdm);
 
-	rc = cxld_await_commit(hdm, cxld->config.id);
+	rc = cxld_await_commit(hdm, cxld->config.id, true);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index 9409beb26478..fe5e65a9ddb1 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -52,7 +52,7 @@ static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
  * clock skew and other marginal behavior
  */
 #define COMMIT_TIMEOUT_MS 20
-int cxld_await_commit(void __iomem *hdm, int id)
+int cxld_await_commit(void __iomem *hdm, int id, bool committed)
 {
 	u32 ctrl;
 	int i;
@@ -64,7 +64,7 @@ int cxld_await_commit(void __iomem *hdm, int id)
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 			return -EIO;
 		}
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+		if (!!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) == committed)
 			return 0;
 		fsleep(1000);
 	}
@@ -220,8 +220,7 @@ int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
 }
 
 /* Read one endpoint decoder; a disabled decoder keeps only its id. */
-static int cxl_hdm_read_decoder_settings(struct device *dev,
-					 struct cxl_endpoint_decoder_settings *settings,
+static int cxl_hdm_read_decoder_settings(struct cxl_endpoint_decoder_settings *settings,
 					 void __iomem *hdm, int id)
 {
 	u64 lo, hi;
@@ -230,12 +229,8 @@ static int cxl_hdm_read_decoder_settings(struct device *dev,
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 	rc = cxl_hdm_read_decoder(&settings->config, hdm, id, ctrl);
-	if (rc) {
-		dev_err(dev,
-			"CXL HDM decoder %d has invalid configuration: %d\n",
-			id, rc);
+	if (rc)
 		return rc;
-	}
 
 	if (!(settings->config.flags & CXL_DECODER_F_ENABLE))
 		*settings = (struct cxl_endpoint_decoder_settings) {
@@ -267,10 +262,13 @@ int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
 
 	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 	for (int i = 0; i < info->decoder_count; i++) {
-		rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
+		rc = cxl_hdm_read_decoder_settings(&info->settings[i],
 						    hdm, i);
-		if (rc)
+		if (rc) {
+			dev_err(dev, "CXL HDM decoder %d has invalid configuration: %d\n",
+				i, rc);
 			return rc;
+		}
 	}
 
 	/*
@@ -286,3 +284,136 @@ int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
 
 	return 0;
 }
+
+static int cxl_hdm_decoder_uncommit(void __iomem *hdm, int id, bool *retained)
+{
+	u32 ctrl;
+
+	*retained = false;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl == U32_MAX)
+		return -EIO;
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR)
+		return -EIO;
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			*retained = true;
+			return 0;
+		}
+
+		return -EIO;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	return cxld_await_commit(hdm, id, false);
+}
+
+static bool
+cxl_hdm_decoder_settings_match(const struct cxl_endpoint_decoder_settings *saved,
+			       const struct cxl_endpoint_decoder_settings *active)
+{
+	const struct cxl_decoder_config *a = &saved->config;
+	const struct cxl_decoder_config *b = &active->config;
+
+	return a->id == b->id &&
+	       a->hpa_range.start == b->hpa_range.start &&
+	       a->hpa_range.end == b->hpa_range.end &&
+	       a->interleave_ways == b->interleave_ways &&
+	       a->interleave_granularity == b->interleave_granularity &&
+	       a->target_type == b->target_type &&
+	       (a->flags & CXL_DECODER_F_RESET_MASK) ==
+		(b->flags & CXL_DECODER_F_RESET_MASK) &&
+	       saved->skip == active->skip;
+}
+
+static int
+cxl_hdm_restore_decoder(void __iomem *hdm,
+			const struct cxl_endpoint_decoder_settings *settings)
+{
+	const struct cxl_decoder_config *config = &settings->config;
+	bool retained;
+	u32 ctrl;
+	int rc;
+
+	rc = cxl_hdm_decoder_uncommit(hdm, config->id, &retained);
+	if (rc)
+		return rc;
+
+	if (retained) {
+		struct cxl_endpoint_decoder_settings active;
+
+		rc = cxl_hdm_read_decoder_settings(&active, hdm, config->id);
+		if (rc)
+			return rc;
+		if (!cxl_hdm_decoder_settings_match(settings, &active))
+			return -EIO;
+		return 0;
+	}
+
+	if (!(config->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	if (config->flags & CXL_DECODER_F_LOCK) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+		if (ctrl == U32_MAX)
+			return -EIO;
+		ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
+		writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	}
+
+	cxl_commit_start_endpoint(settings, hdm);
+	rc = cxld_await_commit(hdm, config->id, true);
+	if (rc)
+		return rc;
+
+	if (!(config->flags & CXL_DECODER_F_LOCK))
+		return 0;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (ctrl == U32_MAX || !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK))
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * cxl_hdm_restore_state() - reprogram endpoint HDM decoders from a snapshot
+ * @hdm: mapped HDM decoder capability
+ * @snapshot: state from cxl_hdm_cache_snapshot()
+ *
+ * Restore global control, then recommit each enabled decoder in order. Leave
+ * a locked decoder that kept its programming across the reset unchanged,
+ * after checking that it still matches @snapshot.
+ *
+ * Return: 0 on success, or the first failure.
+ */
+int cxl_hdm_restore_state(void __iomem *hdm,
+			  const struct cxl_hdm_info *snapshot)
+{
+	int count;
+	int rc;
+
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count != snapshot->decoder_count)
+		return -ENXIO;
+
+	/* Restore global HDM control before committing individual decoders. */
+	writel(snapshot->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (int i = 0; i < snapshot->decoder_count; i++) {
+		rc = cxl_hdm_restore_decoder(hdm, &snapshot->settings[i]);
+		if (rc)
+			return rc;
+	}
+
+	/* Flush posted HDM writes before restoring protocol enables. */
+	readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	return 0;
+}
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 9a298e90586d..58bbd5b47539 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 /*
- * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
- * memory device at enumeration, so it can be restored after a reset without
- * a CXL driver, and implement CXL Device Reset. HDM register formats and
+ * CXL reset support in the PCI core: cache the HDM decoder state of a CXL
+ * memory device at enumeration, implement CXL Device Reset, and restore the
+ * cached state afterwards without a CXL driver. HDM register formats and
  * programming live in drivers/cxl.
  */
 #include <linux/bitfield.h>
@@ -16,6 +16,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -232,6 +233,162 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	cxl_hdm_cache_release(&pdev->hdm);
 }
 
+static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
+						 int bar,
+						 resource_size_t offset,
+						 resource_size_t size)
+{
+	struct resource *res;
+	resource_size_t hdm_start;
+	void __iomem *hdm;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
+		return IOMEM_ERR_PTR(-EINVAL);
+	if (!cxl_pci_bar_assigned(pdev, bar))
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	res = &pdev->resource[bar];
+	if (offset > resource_size(res) || size > resource_size(res) - offset)
+		return IOMEM_ERR_PTR(-ENODEV);
+	if (check_add_overflow(res->start, offset, &hdm_start))
+		return IOMEM_ERR_PTR(-EOVERFLOW);
+
+	hdm = ioremap(hdm_start, size);
+	if (!hdm) {
+		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
+		return IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
+static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
+						  u16 *command)
+{
+	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
+	u32 restore_config;
+
+	device_lock_assert(&pdev->dev);
+	*command = saved_config & 0xffff;
+
+	/*
+	 * Restore BARs and the related PCI state needed to reach HDM MMIO.
+	 * Temporarily alter the saved command value so that
+	 * pci_restore_state() enables MSE but cannot enable BME or INTx before
+	 * CXL state restoration completes. Preserve the original saved value
+	 * for the outer PCI reset path.
+	 */
+	restore_config = saved_config | PCI_COMMAND_MEMORY |
+			 PCI_COMMAND_INTX_DISABLE;
+	restore_config &= ~PCI_COMMAND_MASTER;
+
+	pdev->saved_config_space[PCI_COMMAND / 4] = restore_config;
+	pci_restore_state(pdev);
+	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
+}
+
+static int cxl_restore_dvsec_ctrl(struct pci_dev *pdev,
+				  const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	if (!snapshot->dvsec_ctrl_valid) {
+		pci_err(pdev, "CXL DVSEC control snapshot is invalid\n");
+		return -ENXIO;
+	}
+
+	rc = pci_write_config_word(pdev, snapshot->dvsec + PCI_DVSEC_CXL_CTRL,
+				   snapshot->dvsec_ctrl);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_err(pdev, "failed to restore CXL DVSEC control: %d\n", rc);
+	}
+
+	return rc;
+}
+
+static int cxl_restore_state(struct pci_dev *pdev,
+			     const struct cxl_hdm_info *snapshot)
+{
+	void __iomem *hdm;
+	int rc;
+
+	hdm = cxl_pci_hdm_ioremap_current(pdev, snapshot->hdm_bar,
+					  snapshot->hdm_offset,
+					  snapshot->hdm_size);
+	if (IS_ERR(hdm)) {
+		pci_err(pdev, "failed to map CXL HDM state for restore: %ld\n",
+			PTR_ERR(hdm));
+		return PTR_ERR(hdm);
+	}
+
+	rc = cxl_hdm_restore_state(hdm, snapshot);
+	iounmap(hdm);
+	if (rc) {
+		pci_err(pdev, "failed to restore CXL HDM state: %d\n", rc);
+		return rc;
+	}
+
+	return cxl_restore_dvsec_ctrl(pdev, snapshot);
+}
+
+static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
+{
+	u32 *saved_command = &pdev->saved_config_space[PCI_COMMAND / 4];
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (rc)
+		pci_err(pdev,
+			"failed to disable device after CXL reset failure: %d\n",
+			pcibios_err_to_errno(rc));
+
+	/* Preserve the pre-reset snapshot if PCI state has not been restored. */
+	if (!pdev->state_saved) {
+		rc = pci_save_state(pdev);
+		if (rc)
+			pci_err(pdev,
+				"failed to save disabled state after CXL reset failure: %d\n",
+				rc);
+	}
+
+	/* Ensure the outer PCI restore cannot re-enable MSE or BME. */
+	*saved_command &= GENMASK(31, 16);
+	*saved_command |= PCI_COMMAND_INTX_DISABLE;
+}
+
+static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_err(pdev, "failed to restore PCI command state: %d\n", rc);
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to save restored state after CXL reset: %d\n",
+			rc);
+		cxl_reset_save_disabled_state(pdev);
+	}
+
+	return rc;
+}
+
+/* Caller holds the region lock and keeps device traffic isolated. */
+static int pci_cxl_restore_state(struct pci_dev *pdev,
+			  const struct cxl_hdm_info *snapshot, u16 *command)
+	__must_hold(cxl_region_quiesce)
+{
+	device_lock_assert(&pdev->dev);
+	cxl_restore_pci_state_for_hdm_restore(pdev, command);
+	return cxl_restore_state(pdev, snapshot);
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -412,7 +569,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
 }
 
 static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
-			      struct cxl_hdm_quiesce *q)
+			      const struct cxl_hdm_info *snapshot,
+			      struct cxl_hdm_quiesce *q,
+			      u16 *command)
 {
 	int rc, rc2;
 
@@ -437,10 +596,15 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
 	rc = rc ?: rc2;
 
+	if (!rc)
+		rc = pci_cxl_restore_state(pdev, snapshot, command);
+
 	rc2 = cxl_hdm_quiesce_flush(q);
 	if (rc2)
 		pci_err(pdev, "failed to invalidate CPU cache after CXL reset: %d\n", rc2);
 	rc = rc ?: rc2;
+	if (rc)
+		cxl_reset_save_disabled_state(pdev);
 
 	pci_dev_reset_iommu_done(pdev);
 	return rc;
@@ -451,6 +615,7 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 {
 	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
 	struct cxl_pci_cache cache = {};
+	u16 command;
 	int rc, rc2;
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
@@ -474,11 +639,19 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 		return rc;
 	}
 	if (!rc)
-		rc = __cxl_reset_execute(pdev, dvsec, cap, &cache.quiesce);
+		rc = __cxl_reset_execute(pdev, dvsec, cap, snapshot, &cache.quiesce,
+					 &command);
 	/* Restore cache policy after any attempt to disable caching. */
 	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
 	cxl_hdm_quiesce_destroy(&cache.quiesce);
-	return rc ?: rc2;
+	if (rc)
+		return rc;
+	if (rc2) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc2;
+	}
+
+	return cxl_reset_save_restored_state(pdev, command);
 }
 
 static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 7919d872a34d..80d6ebb9f4aa 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -54,6 +54,8 @@ int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
 				 resource_size_t size);
 int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
 		       struct cxl_hdm_info *info);
+int cxl_hdm_restore_state(void __iomem *hdm,
+			  const struct cxl_hdm_info *snapshot);
 bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot);
 void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
 void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
-- 
2.43.0

