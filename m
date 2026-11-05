Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905188;
	b=QDp5SGvd3a69U2KI4EgBkJdvpOgI+fIbroHkdQP/ccgcaxmRnfHQ3AxqVTWHR83A6nzc
	 qcLpQa83EXQn4NTaFAy3XJ6cqHfYbbkOxLsf7ZIiELvbwhFJCXOFatuuGjTDzcJ3ZQ/7p
	 t4Jl0WAc16+pr1AYRa5Zlm4jdmriUjJG3eT9rtuE34ygqDZjKXN0SX3J/3ju53ZpXyq6L
	 QPCz2fLpD9afY1fSDlc2Hh2gaOVSyPNm3/5oqMJHQrBsPMOGP7TEOFi5cZ9xCBc6umwTZ
	 syZ+Dp1aB0eMzfuJWyq4p++wBPZ6PuOsUQ3oAfMtVH5X5A9eTbfDWUvG58Q/uH6GccQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905188;
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
	bh=PsFHOdfjxolb1iMTuvbvpfAV6ib9rA7HB1dsgznmsBw=;
	b=M65G9nmuHg/PzgpycESl79EhmTj/L11OWuL00KzV00h9GtkZo+Jp595YOtFkcvt/VD0O
	 QvIT4hTdPM+K8hqoFKveQmG9FBz50xXeDpi27JtHD4O2lTFB9IiUPEHTcK9bnbIiRbcJz
	 vBfy/YsmpmWjeqnvvTwkXRWkMg3ISQ/WF7/VcoKdOkY92nC0eoaRM+CmlCbg9hmTrW+Ah
	 a/lWwb6bL33cug9pfOMublY3vqFoTbkjwO4NlVezLd6q4yww3w+aZZkbaG1bdvUOZ21Cs
	 2v+hBi/hRME9/2wHnUd7etD/QT8Lio6LyWizBOFcLjNkTdyVgxBz4fA3QaA7VjdK8xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="t/l4/YM1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.25
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE046606EEA7;
	Thu,  5 Nov 2026 18:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE046606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t/l4/YM1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE/uUd4ALySFtXbwdOAxVDJPX9ZpDDrJgG0baV4R01AHolZrFUfKVr0byBo5pRJPsVzH/uVyliakDH6UpIEAbSvpqAGI112u32MdzwJ0nNbJKcZPPhiKR0rzbVoW8qRjuQL84Qv0xJBZYC4UkmFipIt06KQjPtq0m0dWzofMINMP0ToIXjChrXtgJDDkr0IYpJmOqK/ipjlRNxXf9nIso+1wXuypI2izP+F+SjG9r0OLLiUTNgFSQ5Lt2psFkHAm4xDNXZ2kblQuLXEm1fWGF/iJRpgYw7eHfYnE31yba2m8KX1uIgIqd6Ke5USPOl2uVfOKxZGwvT4XGkthTTy2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsFHOdfjxolb1iMTuvbvpfAV6ib9rA7HB1dsgznmsBw=;
 b=n6zw/L39oXviY7kxLusDmk3TdTFO2vOR/Gq3NH1TusDmbNpTYV3D93daMaDJobnVN88ZEtVnxOBnt/CnUEVKpILeMKWxEiqZiAAsGRzLpJfGOchekxuF+0fZGkyewUXJIawwUGUxL73JccEHqqlQd5fPxTj0KrrSexqbY032Zu3QMxgKHDmSMDmMZD1uskQJ4bZUckbMNVzR0syWNFGKTdBS1LjIU16mo/hmiLhbRgAFViLZxZ9UzilRRzxa7sCzJIhvNqLam5wgMsu9iOjGbZoArfrEvmaeVPqRRIsCd36HEPUJwDoB/4KpixtBhz/hjySLf6sO/8v0OMumt6bQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsFHOdfjxolb1iMTuvbvpfAV6ib9rA7HB1dsgznmsBw=;
 b=t/l4/YM1Uw3gkCaYyd7yXXcfDGwWMFNPKCDW5ayo4vxiMf0GVqtoM2xg92LhKGZwHuiTzL+VwX9L86BBNzo1kxb+0xZ0DC4/hMQY8Pi4IaU/cAyjH5+E4dr+XNb+vj35GGIBYkx7t42oqs4os+8f4eUmHbM3onbcsof8hAx189lUvtO4jF1eCUQwddjYrbvVkMFIQpuk6VwSUPTM/Swu2Wl4ZX8+AuMXRt2ZS/WRzMl8bsiFa3SFxvHZvrT5ieMSU6Hbx02a0Xps/pSnsNgjWhUqf0yeCnjw3Qyv1hFHKoC6xgCe4eX9eQdFYvGB8HjuHTv9lMGRM2swSk/f2Ay1aQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7884.namprd12.prod.outlook.com
 (2603:10b6:806:343::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:40 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:40 +0000
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
Subject: [PATCH v17 08/19] cxl: Move cxl_rwsem into built-in code
Date: Thu,  5 Nov 2026 18:59:06 +0000
Message-ID: <20261105185917.2667656-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 84807532-4c37-4d5b-7209-08df3b6ef1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261026121527099003|56012099006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261022113327099003|261102130727099003|261026140227099003|11063799006|261009223027099003|261028144727099003|921020|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aCFbNQNq7WuPFPX29mFV7iFdE86PEysLkTkh6l/GgXQRASXKWZ2vNVkwt8DI1UBxdFJ+N4s2bW5dSda5EXtTe1PKBIKm1A2gRN7fcLJ5MpQFSCsfCCSNcboOKf6NP0ZjwnJ3nOWplh+u3NajJSAulLM63QVwdauFjDR6FsWza32w1+ScuxDnktsG7KVFnImqro7qCGTQOLAa+c8lCsw+sMHILT7ytxZhTqiocNh1F2G2eyIDb+2cu69+oav5YDHqPRMYNUWtiy/xrOTrPm59x8ivq/0mIHKqmuNfQ+lbs49jvMMoQbVsIsYcYtkda2wdjZyFHNDgfxwruhlQqkgQVz1zEhvMhl4gGBvFPapOjK4nW/i4XiDNDjwA7SoBgk+MbVX7UEDqIBQXZ6Xj0cxJjZHdE+qEbo5/oH3v+AhqRf2EY54AO//gnoPZ4NYWBHN4fQR3eHL/jsy5CSA2uIOZQuIj9lrGi/nC2WYInJiRvI3kU/NtzZj3SPLAQQ1v8UIQvOkmodB2VmA9DyDKGCKJOhGbbXdQLXOCjPfsJhXGAtFC9ECxiSNVI3weni3JDlG71hZw99XUJBhIaLl5s4i9IaAMNhQkc0OmbBjm/MAahTrHPzVJPGERNcqSS86Uodw126slVQXWxt8FFW9oHdALF3XBXG7EjBEADio2sKEe733hS/CMyMHTf+nBmm1gZQtNIbo3tM8vjcr0bI0F7MXg4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(56012099006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261022113327099003)(261102130727099003)(261026140227099003)(11063799006)(261009223027099003)(261028144727099003)(921020)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8qe+NmpErly+Cdr37lbpQKC5hOSlP6nZzYFnopPZKngdo+hd0Cy1S62pnaKY?=
 =?us-ascii?Q?3C7DIRp3uusnzXiSuDyUGF4Kz1Y3+FmPitat4PWQ5T1uhfEd898ve/BKAqvJ?=
 =?us-ascii?Q?OmeXCO5R2CGI7zivPJXmAgCaR861UXqBZSdoPwBIxEgOV0K2VcuPWEzSN0PJ?=
 =?us-ascii?Q?oV1AUhiAcIAvFZowCF7Yw8lZxSsDoAvAcDeLsLTZtgY4T0z6SzSI8koZYCM8?=
 =?us-ascii?Q?g5wdHYN9+/GZ3rR+LM5v3ZQRZbXn0Dm1ZsiyLdUCOX2UUuEuc+/ZtSdBWRtq?=
 =?us-ascii?Q?Ov2WilXIqVo6Az0l8MhWTmqSBw3G1O+xm2B38SWQYpmUpdv1xzNtKJy5KZfR?=
 =?us-ascii?Q?QST02Ad79aXOgBTIkF4ljnYe+wfZ73hi4Ycvdl/7OLqCEGFo4QVpvBPzfh8A?=
 =?us-ascii?Q?B/NtGl+3lleT6DjSvNyhZHYoLvIKnferkUpYWmBIv8XlWNEVKQ1tics76B6z?=
 =?us-ascii?Q?x75PVMGkfb5mRk6xCkucWTXQYN0X3+KrDTkdHeW1/tPlFZedl6hQNx5pwDf5?=
 =?us-ascii?Q?QQm64YQM0Ve8tgdwfJvEcWje39Q2Z1jCekxnAuMiis9GVh1y64CfHCva3Sov?=
 =?us-ascii?Q?YT292+Hi/tdnuxgjx6/O4u82lsXikH4LQVNCp/wf04wc0VUvrJEk+fnzVgM3?=
 =?us-ascii?Q?UpHQD1YUKfTwD3UFMcNuxfDmNzrvmyuZjYOZeQKkvDfsh+g+GyAF5fcTQ0Hy?=
 =?us-ascii?Q?EWGsBasUlt5ePkEZSwB1Tf3MNjHh3K3C5JRMXuxodcmvJE4k9pymecVYzmVD?=
 =?us-ascii?Q?03KnabLnvDHc71tIPsTZrhc7KYQ8VkceqpoEwp3sVbW2KMslvPh2JYwAivkP?=
 =?us-ascii?Q?ztgkO/dSMrkL3kqGBvpWlXfuaTcdXHGOPrW7szU6ml6/nQfRrCDCOFm/0xYe?=
 =?us-ascii?Q?yGQeUzfkWju2WtXYcAFTvEnFmQCTo9E57RP/WSHgeCXd7qqUtSgmeghdxsZW?=
 =?us-ascii?Q?0VGuLIdnXzwWx4Q/nZNjW5Qzmw69BAeG4BGQIb1TbeGkXNpidfIMucMLSLqP?=
 =?us-ascii?Q?Mt1TbuHVkHnXyXeC0GUKm8q+hdqtbq67r2GfITghwES8yXgbeu4akPmtnhvT?=
 =?us-ascii?Q?wsxdyXi2rJDUCtRmFLasW8nIubFM50ydDGpq8HvD6R36EGSl+/wmmKESJYi4?=
 =?us-ascii?Q?oagThXCgRzYXxSMdr7WCciAmyqvSEszTSZEI9s4J9TUx8SP+0A8T6RSvGb0m?=
 =?us-ascii?Q?JCZWOPgpszsJUtlKDDzdvo/5v4gkZaK4vep4HSAWpFN7gHa6zOIqLIJbMkJE?=
 =?us-ascii?Q?4YaDm128N0u6K3VBNZQ7SFbPR49wprA1NJyHNZw3sOSsOpCYXJnudQ3kVbVq?=
 =?us-ascii?Q?mgxncqn9edi9cW+1uAY2h77YmMbuMwp+bTDSZZgc+wx3uPJxv7cGjQ4oXdcB?=
 =?us-ascii?Q?b1jON8g6odh9vkY3uIPFpABb2I5ox7hxN6zXPD6n9I/5G0UxSMMbdP8JZba5?=
 =?us-ascii?Q?kSn6wo/T+p7S6NmkV/+z+wr0A40g3NCvKeTjp+fNyepB9BGbly514SbWWX8M?=
 =?us-ascii?Q?WlNfSTj6iKKzI3XuRiNUFLNCHwP3zy5TB58NriLBhrSJV5SNytGNPf2J6wtG?=
 =?us-ascii?Q?1ubl04WYI5ZhSylgXPgqyiIzMTXX+pNRYBjcV0V9sjaw7wKJm9aA3ZRz64RC?=
 =?us-ascii?Q?vpiXisFvtW6SRKiQdrt+8Me0pU61LRn7sPSXocq3GOztQh1wyoCOx8FlFhKR?=
 =?us-ascii?Q?9VgZgj0HUU0ynBM2gywc2jIGW2scANLN8ojt+0e8jBIrsmkQhqLp88HrwR+w?=
 =?us-ascii?Q?nOiOslplaw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84807532-4c37-4d5b-7209-08df3b6ef1de
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:40.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Wh/zfAxyosOTu+qXMYE0JPw0OcDBn9lfWMsXozyn2/OtnTzs5ho9T8YUWE3khCgfC0T1NRCSTe0bs2pq6+ILw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

Keep the region and DPA locks available to built-in CXL state management
when cxl_core is modular.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/Makefile    |  2 +-
 drivers/cxl/core/hdm.c       |  5 -----
 drivers/cxl/core/hdm_state.c | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cxl/core/hdm_state.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 6703c1729396..9971efb237fb 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
+obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5b5f5f22ea32..85f9abf58a42 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -17,11 +17,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
new file mode 100644
index 000000000000..c9cc019902ef
--- /dev/null
+++ b/drivers/cxl/core/hdm_state.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <linux/export.h>
+#include <linux/rwsem.h>
+
+#include <cxl/hdm.h>
+
+#include "cxl.h"
+#include "core.h"
+
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
-- 
2.43.0

