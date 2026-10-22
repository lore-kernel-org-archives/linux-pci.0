Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657367;
	b=cc3AN8ggf6IzeRvc84xIymZv1suKgw6LN4YD8XMzhRDAQ9/Gx1PYiZb99iLFc0mCL05T
	 g1H3Zb/RqBdQOfNbht1TNDJASTUTd1X3NAw+1cKJONuixb5bw9DgWmoD7fBlihntO4600
	 8d6/XcS3lh4D8nmiQrAh7Zerz2bJ+3aAQQKw50DE1jLjiP8vjQ2HelYb1lq2HRkgdRQO6
	 z1q4CEf4u3AX4XhANOhdtzOyJflJIuFw8qPMClzzfkKwmOUP1YU9vFf73e86FSXNe3aKJ
	 QYskDVb0Al11DVKv86hViEMnvE/1y8r5TdbLg2oWyCUsqJ9GoOgyNCNwqh6Mi5FOBwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657367;
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
	bh=ngTKcADRZHZVdjg7HzdxoCuvbsL7NKhch9JexJbvOrU=;
	b=OQxKkLPGS1NS6HH73kry9d4VIHEGdc+REHP+Db2u7UrF/apTLioPj7p66tCokPtTb37z
	 /fOHCcUGgO/YTDb2WSkAfiNGdxaUYrMR5W1s4wzYp00jAqz9HKulT4LsSYqN09l/hwL/a
	 DbddgbiUX1iw0qGzs0UuxNTn8KACCKDo5Usg3YvDmoyWyK0jnfiJtQVGsIHQUikEaPKp1
	 VLqT0LZpfQ4NEYr3zR8Pq0EXHpy3Rg6urEYAXpnwnEXCH9QUFuhjFBmjFNDibpB6Ai76c
	 fNI0jHc5cP6x9zcAFFdGUAaRX2kkMeeRCS9bP2SR+3lkKahNaPcjb2VcY/7d76AdJmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="JYF/eeoy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E1606A339;
	Thu, 22 Oct 2026 08:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B3E1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=JYF/eeoy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdwv4qfjZ6zioviYxpKDVspK9Z332ZeQ6hC2mu4FXiJVOWOIyy6l074TnzzvUw4Vxyqica1RZ8t1D0x2QnSX72nw3wOpcwO9YhNEZCMxNTeLAP4lJhrZTPbuCHMjik3uZf1XocVuduD0M9XPNSvdOORsRh3RWhPice+r9LAz8CNLkubF6hSAJHjcvvXg+Obt8Bo+8mBLNI87/opXX3eQIa5EfnPt7TCAy7BDfiVW/sApdEpn4bJhZN/4oXwbWo3+9tmb8Dq6n0blsnZXK+GVyFY/tsAba0fDEoAzo64eIfW/MhnkOO5KaiBzAtKMSOKa9LhdCOuWOU1xmCEtfJl8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngTKcADRZHZVdjg7HzdxoCuvbsL7NKhch9JexJbvOrU=;
 b=U2I6TwSc+VqQabf0l9uhRgdJokiBqIFDgRe/0KgKwDDm7UKE41OhGOYQH/iWzXcxhovmxdRLa6cK96XYOw/MD+zAu2KWkaYh/t7DB46jp/805LLKDt+X0od4Ha6ONRFW20oGUf63W3bS/gCP0AZjv+k+/dkcajwlrm9m9OaPqsDvSAEFlz1zahLklhfzy1CgtbvrYwQpVMrlfHD0rRClc/cvE7vLH5r69KzUPDrBLT+fcW9g2fYQ6QgtCKStceoYBDkspoDHzdTrPr3Z9fOZdiYfk6a3oXQSfvUKCc+FGyJrpvTmbbnj8XQGdVydgFrWZSE6gBY3MlShzvqDKgV6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngTKcADRZHZVdjg7HzdxoCuvbsL7NKhch9JexJbvOrU=;
 b=JYF/eeoyo6WOGSKbV4z8fV5rhEiXYULE4DweuN3aDWHGLP663bjXrAL3g13PxBivyQdGjyEXDBYJ6Mr5laVEc9SmmX1EaZZAKOsm4Zz5n8kFMG71rOtXYuNysZ81PmAodb1BqYPAnhSQdFqsRtXkTXRHQIRq9LsPduwmNkB20NM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:37 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:37 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 05/10] PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
Date: Thu, 22 Oct 2026 17:22:25 +0900
Message-ID: <20261022082230.3164834-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 85996ed9-6f7b-4e2a-f5a1-08df3015a1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|5023799004|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	lUpLGdoyI0YSQRSg1Q0G2lPCoyPSqGC8Kvy6DVGHtyF51A4XokAnRdm258+HbLXKfDOhxnC+ajrRzNf1pTBjAIL2DFM3snOUnFcSTpEANOHpyzcNTj0o/wym4Fx8Ox7KHQIP0YV356FPMs/6BcJE09TS/fO55hYRnlxDo/OUNWXtzuf2D5gxkw5Kh5inxLnMvPaGjQiQ8djsH53KFPcK264F6MsVP/IvQyH1Nr+VV1eMt/6ZcGtFqtuJd6s6tF4vSTMpDQbX36USHWpG3LUPVvDbbkS39jvxAxBwEhIy8L09xxubFbIA/wlT3CQLhsvh2ECobriWVq0MieM/3CmY9qzO07kgs25zF2VJsPdIQ82cpcy9rzGs01/b1ADqmIYUTkxN9P1GDZSS8dNn6k1OJEW5DlJ2zVMryACsVTiFsBBdCEgB9dCXXh1JGn39WJt/tCeM8K2Fv7uV5i9ETltnq45kK4F/v76RQWYNjShHDjNDltOWglm8NtGwVBIhasxZ3bi+CmletQ3XnRE1wD3eoTobugxAN4bcLN3PQJ4fwd7FxmWhCvE5B+vDMDk8gxGEm9rYifThKAFY1wfFRdGw+s5+Em/d4YpJG6OhfOHeLxqwN15Uaqsmz8RfQuHoiF7z/nwrkBy9P7fHqtECY4OpMV+C5P0r7eCelcakn55/FYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(5023799004)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OYxZ1MUXQZzJLEQXw/eQpCIIU3eC69Anb9i16sVmMdaVNxc+QDhsG7ERZ8gp?=
 =?us-ascii?Q?D3lsShzUQqORbigqMH48fnqtipRGacXyAg5TmrrEWAm8IHClxtwDoiZgUtyO?=
 =?us-ascii?Q?fhKXfdmf1IWKbaBjPjzCmTPrlbGMAscpzF0yNtw7XrXjPgnPDSha3cDaKJ5M?=
 =?us-ascii?Q?gSedBhrIvs8c696JfhSBcgAD0yeaYdxfOaq+ME9AIc4a5tFF7D4jwPBfd1LU?=
 =?us-ascii?Q?ErwDFtaixpYGk5AQB15Yst6FDrguKpq3dawCXN27QHKXcPO1lA5M4kfSCdMH?=
 =?us-ascii?Q?QAf4cEwj70Ht1gmx5EvdWoYJSe7TRtpcc1naO/4mSY0PIorE4eop/vfE5Q+H?=
 =?us-ascii?Q?Rp4/OW9X8yjQC/dheJ6LyUo+nsAaong7C2oog6fPHcZp3TEC+mJ9u/0CdzJD?=
 =?us-ascii?Q?dZx3ApTWeyhSmij8S2qhp58PoOUmgWqBFP+4clkfdbcNZGTSVXuAPKX75C94?=
 =?us-ascii?Q?n+ZSlbCEYz4jQ7CO2E+5KVJcgSpAbeEKQvLdu1tMXbcPALwSf0ede6i1qVJU?=
 =?us-ascii?Q?4iL0Gola0eQVNS1x+EZK7wQRCxzr3QlsQnYVMHEVyRe+ih3b+tNrEKE3+1Js?=
 =?us-ascii?Q?Bf3mYqJqKrqxQHD42N0D+TIM6HRWrfx7S9EcM4o0SP1sikdK02UWNL0eeNt/?=
 =?us-ascii?Q?/aRL/PdE3AQ8NLxJd0ZJtbGvqlFB3QI01yv62kf9QL+1g1YWAnVMePsTeiq7?=
 =?us-ascii?Q?OkEVt0a9BSTof1NmcM7qTczsRQpFAhOUNxQNn3bbUFbO6FCnkow3m6HYQJEc?=
 =?us-ascii?Q?gfTO1/42FZcC8WkRDXZ0biaZMmEG7+Izc2NhL2fo/1omxD6TKNbC7fZAlWlj?=
 =?us-ascii?Q?g+CbFE1RLfER7UF2XcNqdfDR9+SQkSYZxvxxMhyxh2QtwyWkTwLVvWtjuznY?=
 =?us-ascii?Q?CiyGllXIyVTl2EK5b7vNnTfOYb4XMqu03kthr/E4jpP6GzAiszgSJqAnL+ot?=
 =?us-ascii?Q?BgZAyoG1e7aT5qiwJER4OUw1K0JBt4IiIIXfmsI0N+fRccqztm3wYLc0/Vpk?=
 =?us-ascii?Q?XQAsWDagKkKm0fGmSQ55icJ8s4W0aonWwUr+KSvm32U3msK4wmPkDV/fevxn?=
 =?us-ascii?Q?LPxwP7j8Mgp3+/mzaKH3gEl6+7F6ppuPOSlEH/OPiXXnp8h2ibwvXCrua1F9?=
 =?us-ascii?Q?1T+v3IBJnggtASqLxYQ60QROL7KOqtyLdZyAgVn4YvQ0gBWukj8bJ5rAOCnq?=
 =?us-ascii?Q?AHvcIk4X7yNg1Cu0oyngbZcMCODWWb4kR8dj5s3vsDajgLPYO4VZJuf+eNpX?=
 =?us-ascii?Q?NePAkKX+MwVeeEYL9azuu8wuZmoUtXAYPtQKmOjM1ZI6eQDfEa3nweJMnPGt?=
 =?us-ascii?Q?7IztaJovLZeycD51fzxqRu6maXmy0reDQ00D3VpoPZr1UOUcv0CL//ESMrQE?=
 =?us-ascii?Q?JVs9Jie4VWDSvxCghNcwlvO+MuTj0S3QvZrsQlfxzAe5P31hKdQ9quw0O2XZ?=
 =?us-ascii?Q?pMZ6fJMGYfE0psPP/ByiY4R5VjKhDtxmbgW7rcS7VrbzaWfYgc4h/eXwX+6V?=
 =?us-ascii?Q?FEFmRyWzOgAed6AKIEd4cJhuBlYbLriChiDosZ159C8T1uswRee60uJTPNnv?=
 =?us-ascii?Q?xUT6KmceeBTB9LNBwP/uJm6I+0dEeLbJSQpdQVJADz/VdHQUKp2DTUWWu6XA?=
 =?us-ascii?Q?hHmv8dn6lS6e6Odgs+qmSNu/uYJ1Lt/Wbw8ObTZF7M26avhWXGTze6duILn+?=
 =?us-ascii?Q?An2VNjthPcUJxcYLAOxZrmAaCE0VuiN8CJai+Ph7r4EYC3uwgVSYjzWopbXw?=
 =?us-ascii?Q?kR32EF9t8mFty8Y8njZ/tnRsqnH2nzDGqqU3TFMTWY02f98WFKGl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 85996ed9-6f7b-4e2a-f5a1-08df3015a1bc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:37.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVCnkpmkRDdxd4B1QY7n0RWMDf65V1C51uSH7tLsXxDWdtKfURz/sai8+KA9rTvRRpyCF1Z9jUn8gyZ9nN89cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

An RC may use endpoint-local DMA read channels to transfer data directly
to an endpoint DMA address once both sides agree to use them. Quiescing
an unrolled eDMA channel disables its whole direction, so reserve the
complete read direction and route its interrupts to the RC when dma_bar
is configured.

Describe the controller and per-channel descriptor memory in a private
control-region extension.

Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
export. Leaving it unassigned keeps the feature disabled.

Keep resources already assigned to a BAR in place, and map the rest
through the selected dma_bar.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - No changes.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 487 +++++++++++++++++-
 include/linux/pci-epf-ntb.h                   |  39 ++
 2 files changed, 517 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3adbaa9d85db..ac83af54122f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -39,9 +39,13 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <linux/pci-ep-msi.h>
@@ -67,6 +71,7 @@ enum epf_ntb_bar {
 	BAR_MW2,
 	BAR_MW3,
 	BAR_MW4,
+	BAR_DMA,
 	VNTB_BAR_NUM,
 };
 
@@ -78,6 +83,18 @@ enum epf_irq_slot {
 
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
 
+struct epf_ntb_dma {
+	struct epf_ntb_dma_ctrl ctrl;
+	struct dma_chan *dchan[EDMA_MAX_RD_CH];
+	void *bar_scratch;
+	dma_addr_t bar_scratch_phys;
+	size_t bar_scratch_size;
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap *reg_submap;
+	unsigned int num_submap;
+	u16 rd_ch_cnt;
+};
+
 struct epf_ntb {
 	struct ntb_dev *ntb;
 	struct pci_epf *epf;
@@ -111,6 +128,7 @@ struct epf_ntb {
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
 	struct epf_ntb_ctrl *reg;
+	struct epf_ntb_dma *dma;
 
 	u32 *epf_db;
 
@@ -202,7 +220,8 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 {
 	int i;
 
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
+	/* BAR_DMA is checked separately because it may share an MW BAR. */
+	for (i = 0; i < BAR_DMA; i++) {
 		if (ntb->epf_ntb_bar[i] == barno)
 			return true;
 	}
@@ -210,6 +229,419 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+struct epf_ntb_dma_filter {
+	struct device *dev;
+	int chan_id;
+};
+
+static bool epf_ntb_dma_filter(struct dma_chan *chan, void *data)
+{
+	struct epf_ntb_dma_filter *filter = data;
+
+	return chan->device->dev == filter->dev &&
+	       chan->chan_id == filter->chan_id;
+}
+
+static int epf_ntb_dma_add_region(struct epf_ntb_dma *dma,
+				  const struct pci_epc_aux_resource *resource,
+				  dma_addr_t target_addr,
+				  enum pci_barno barno, size_t align, u32 *next,
+				  struct epf_ntb_dma_region_ctrl *region)
+{
+	resource_size_t delta, map_size, size;
+	struct pci_epf_bar_submap *submap;
+	dma_addr_t base;
+
+	if (!resource->size || resource->size > U32_MAX)
+		return -EINVAL;
+
+	region->size = resource->size;
+	if (resource->bar != NO_BAR) {
+		if (resource->bar < BAR_0 || resource->bar > BAR_5 ||
+		    resource->bar_offset > U32_MAX)
+			return -EINVAL;
+
+		region->bar = resource->bar;
+		region->offset = resource->bar_offset;
+		return 0;
+	}
+	submap = &dma->submap[dma->num_submap];
+
+	/*
+	 * The RC is trusted with endpoint-local DMA. Map the aligned span
+	 * required by the EPC, but advertise only the resource itself.
+	 */
+	base = ALIGN_DOWN(target_addr, align);
+	delta = target_addr - base;
+	if (check_add_overflow(delta, resource->size, &size))
+		return -EOVERFLOW;
+	map_size = ALIGN(size, align);
+	if (map_size < size || map_size > U32_MAX - *next)
+		return -EOVERFLOW;
+
+	submap->phys_addr = base;
+	submap->size = map_size;
+	region->bar = barno;
+	region->offset = *next + delta;
+	*next += map_size;
+	dma->num_submap++;
+
+	return 0;
+}
+
+/* DW eDMA */
+
+static int epf_ntb_dw_edma_claim(struct device *dev, int chan_id,
+				 struct dma_chan **dchan)
+{
+	struct epf_ntb_dma_filter filter = {
+		.dev = dev,
+		.chan_id = chan_id,
+	};
+	dma_cap_mask_t mask;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	*dchan = dma_request_channel(mask, epf_ntb_dma_filter, &filter);
+
+	return *dchan ? 0 : -EBUSY;
+}
+
+static void epf_ntb_dw_edma_release_channels(struct epf_ntb_dma *dma)
+{
+	unsigned int i;
+
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		if (!dma->dchan[i])
+			continue;
+
+		dma_release_channel(dma->dchan[i]);
+	}
+}
+
+static const struct pci_epc_aux_resource *
+epf_ntb_dw_edma_find_desc(const struct pci_epc_aux_resource *resources,
+			  unsigned int count, u16 chan_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (resources[i].type == PCI_EPC_AUX_DMA_DESC_MEM &&
+		    resources[i].u.dma_desc.chan_id == chan_id)
+			return &resources[i];
+
+	return NULL;
+}
+
+static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
+				   struct epf_ntb_dma *dma,
+				   const struct pci_epc_aux_resource *ctrl,
+				   const struct pci_epc_aux_resource *resources,
+				   unsigned int count)
+{
+	struct dw_edma_chan_config chan_config = {
+		.flags = DW_EDMA_CH_CONFIG_IRQ_MODE,
+		.irq_mode = DW_EDMA_CH_IRQ_REMOTE,
+	};
+	struct dma_slave_config config = {
+		.peripheral_config = &chan_config,
+		.peripheral_size = sizeof(chan_config),
+	};
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
+	const struct pci_epc_features *features;
+	struct device *dma_dev;
+	unsigned int i;
+	size_t align;
+	u32 next = 0;
+	int ret;
+
+	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
+		return -EOPNOTSUPP;
+
+	dma->rd_ch_cnt = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	/* DWC descriptor memory always needs subrange mappings. */
+	if (!features || !features->subrange_mapping ||
+	    !features->dynamic_inbound_mapping)
+		return -EOPNOTSUPP;
+
+	align = features->align ?: 1;
+	if (!is_power_of_2(align))
+		return -EINVAL;
+
+	if (epf_ntb_is_bar_used(ntb, barno) ||
+	    pci_epc_get_next_free_bar(features, barno) != barno)
+		return -EINVAL;
+
+	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
+	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
+	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
+	dma->ctrl.submap.bar = barno;
+	dma->ctrl.length = offsetof(struct epf_ntb_dma_ctrl,
+				    chan[dma->rd_ch_cnt]);
+
+	if (ctrl->bar == NO_BAR)
+		dma->reg_submap = &dma->submap[dma->num_submap];
+	ret = epf_ntb_dma_add_region(dma, ctrl, ctrl->phys_addr,
+				     barno, align, &next, &dma->ctrl.reg);
+	if (ret)
+		return ret;
+
+	/* DW eDMA static IDs place read channels after all write channels. */
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+		struct epf_ntb_dma_chan_ctrl *chan = &dma->ctrl.chan[i];
+		const struct pci_epc_aux_resource *desc;
+		dma_addr_t dma_addr;
+
+		desc = epf_ntb_dw_edma_find_desc(resources, count, chan_id);
+		if (!desc)
+			return -EINVAL;
+		dma_addr = desc->u.dma_desc.dma_addr;
+
+		ret = epf_ntb_dma_add_region(dma, desc, dma_addr, barno,
+					     align, &next, &chan->desc);
+		if (ret)
+			return ret;
+		chan->desc_addr_lo = lower_32_bits(dma_addr);
+		chan->desc_addr_hi = upper_32_bits(dma_addr);
+	}
+	dma->ctrl.submap.size = next;
+
+	dma_dev = ntb->epf->epc->dev.parent;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+
+		ret = epf_ntb_dw_edma_claim(dma_dev, chan_id, &dma->dchan[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		ret = dmaengine_slave_config(dma->dchan[i], &config);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Common endpoint DMA */
+
+static void epf_ntb_dma_release_channels(struct epf_ntb_dma *dma)
+{
+	switch (dma->ctrl.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		epf_ntb_dw_edma_release_channels(dma);
+		break;
+	}
+}
+
+static int epf_ntb_dma_collect(struct epf_ntb *ntb)
+{
+	const struct pci_epc_aux_resource *ctrl = NULL;
+	struct device *dma_dev;
+	dma_addr_t dma_addr;
+	unsigned int i;
+	int count, ret;
+
+	if (ntb->epf_ntb_bar[BAR_DMA] == NO_BAR)
+		return 0;
+
+	count = pci_epc_get_aux_resources_count(ntb->epf->epc,
+						ntb->epf->func_no,
+						ntb->epf->vfunc_no);
+	if (count <= 0)
+		return count ?: -ENODEV;
+
+	struct pci_epc_aux_resource *resources __free(kfree) =
+		kcalloc(count, sizeof(*resources), GFP_KERNEL);
+	if (!resources)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no, resources, count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		if (resources[i].type != PCI_EPC_AUX_DMA_CTRL_MMIO)
+			continue;
+		if (ctrl)
+			return -EINVAL;
+		ctrl = &resources[i];
+	}
+	if (!ctrl)
+		return -ENODEV;
+
+	struct epf_ntb_dma *dma __free(kfree) =
+		kzalloc(sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	switch (ctrl->u.dma_ctrl.reg_layout) {
+	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
+		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (ret) {
+		epf_ntb_dma_release_channels(dma);
+		return ret;
+	}
+
+	/*
+	 * CTRL_MMIO carries a CPU physical address, while DMA_DESC_MEM already
+	 * carries an endpoint DMA address. Convert only the former.
+	 */
+	if (dma->reg_submap) {
+		dma_dev = ntb->epf->epc->dev.parent;
+		dma_addr = dma_map_resource(dma_dev, dma->reg_submap->phys_addr,
+					    dma->reg_submap->size,
+					    DMA_BIDIRECTIONAL, 0);
+		if (dma_mapping_error(dma_dev, dma_addr)) {
+			epf_ntb_dma_release_channels(dma);
+			return -EIO;
+		}
+		dma->reg_submap->phys_addr = dma_addr;
+	}
+
+	ntb->dma = no_free_ptr(dma);
+
+	return 0;
+}
+
+static void epf_ntb_dma_release(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct device *dev;
+
+	if (!dma)
+		return;
+
+	epf_ntb_dma_release_channels(dma);
+	dev = ntb->epf->epc->dev.parent;
+	if (dma->reg_submap)
+		dma_unmap_resource(dev, dma->reg_submap->phys_addr,
+				   dma->reg_submap->size, DMA_BIDIRECTIONAL, 0);
+	if (dma->bar_scratch)
+		dma_free_coherent(dev, dma->bar_scratch_size,
+				  dma->bar_scratch, dma->bar_scratch_phys);
+	kfree(dma);
+	ntb->dma = NULL;
+}
+
+static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
+{
+	struct device *dev = ntb->epf->epc->dev.parent;
+	const struct pci_epc_features *features;
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+	size_t backing_size;
+	u32 mapped_size;
+	int ret;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	if (!features)
+		return -EOPNOTSUPP;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	mapped_size = dma->ctrl.submap.size;
+	/*
+	 * Submaps cannot be installed until the host assigns the BAR address.
+	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
+	 * for regular vNTB MW BARs.
+	 */
+	ret = pci_epf_assign_bar_space(ntb->epf, mapped_size, barno, features,
+				       PRIMARY_INTERFACE, 0);
+	if (ret)
+		return ret;
+
+	bar = &ntb->epf->bar[barno];
+	if (bar->size > U32_MAX)
+		return -EOVERFLOW;
+
+	backing_size = bar->size - mapped_size;
+	if (backing_size) {
+		/* Back the BAR tail added by the power-of-two size rounding. */
+		dma->bar_scratch = dma_alloc_coherent(dev, backing_size,
+						      &dma->bar_scratch_phys,
+						      GFP_KERNEL);
+		if (!dma->bar_scratch)
+			return -ENOMEM;
+		dma->bar_scratch_size = backing_size;
+		if (!IS_ALIGNED(dma->bar_scratch_phys, features->align ?: 1))
+			return -EINVAL;
+
+		dma->submap[dma->num_submap++] = (struct pci_epf_bar_submap) {
+			.phys_addr = dma->bar_scratch_phys,
+			.size = backing_size,
+		};
+	}
+
+	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			       ntb->epf->vfunc_no, bar);
+}
+
+static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+
+	if (!dma)
+		return;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	bar = &ntb->epf->bar[barno];
+	if (!bar->size)
+		return;
+
+	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
+			  ntb->epf->vfunc_no, bar);
+	memset(bar, 0, sizeof(*bar));
+}
+
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct pci_epf_bar_submap *old_submap;
+	struct epf_ntb_dma *dma = ntb->dma;
+	unsigned int old_num_submap;
+	struct pci_epf_bar *bar;
+	int restore, ret;
+
+	if (!dma)
+		return 0;
+
+	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+
+	old_submap = bar->submap;
+	old_num_submap = bar->num_submap;
+	bar->submap = dma->submap;
+	bar->num_submap = dma->num_submap;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, bar);
+	if (!ret)
+		return 0;
+
+	/* A failed dynamic update may have already removed the old mapping. */
+	bar->submap = old_submap;
+	bar->num_submap = old_num_submap;
+	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				  ntb->epf->vfunc_no, bar);
+	if (restore)
+		dev_warn(&ntb->epf->dev,
+			 "failed to restore DMA BAR mapping: %d\n", restore);
+
+	return ret;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -342,6 +774,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		epf_ntb_teardown_mw(ntb, argument);
 		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
+	case EPF_NTB_COMMAND_SETUP_DMA_BAR:
+		ret = epf_ntb_dma_set_bar(ntb);
+		ctrl->command_status = ret ? EPF_NTB_COMMAND_STATUS_ERROR :
+					     EPF_NTB_COMMAND_STATUS_OK;
+		break;
 	case EPF_NTB_COMMAND_LINK_UP:
 		ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
@@ -488,16 +925,17 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *       Virtual PCI             PCIe Endpoint
  *       NTB Driver               NTB Driver
  *
- * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
- * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
- * from "spad-count" configfs entry.
+ * Allocate the Local Memory mentioned in the above diagram. CONFIG REGION
+ * contains struct epf_ntb_ctrl, the DMA extension if enabled, and the MSI-X
+ * Table and PBA if supported, in that order. The size of SCRATCHPAD REGION
+ * is obtained from "spad-count" configfs entry.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
 	enum pci_barno barno;
+	struct epf_ntb_dma_ctrl *dma_ctrl;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
 	struct pci_epf *epf = ntb->epf;
@@ -511,7 +949,10 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
 	spad_count = ntb->spad_count;
 
-	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	if (ntb->dma)
+		ctrl_size += sizeof(struct epf_ntb_dma_ctrl);
+	ctrl_size = ALIGN(ctrl_size, sizeof(u32));
 	if (epc_features->msix_capable) {
 		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
 		ctrl_size = ntb->msix_table_offset +
@@ -543,6 +984,11 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 		ntb->reg->db_offset[i] = 0;
 	}
 
+	if (ntb->dma) {
+		dma_ctrl = base + EPF_NTB_DMA_CTRL_OFFSET;
+		*dma_ctrl = ntb->dma->ctrl;
+	}
+
 	return 0;
 }
 
@@ -924,7 +1370,8 @@ static int epf_ntb_find_bar(struct epf_ntb *ntb,
 		 * Verify if the BAR found is not already assigned
 		 * through the provided configuration
 		 */
-		if (!epf_ntb_is_bar_used(ntb, barno))
+		if (ntb->epf_ntb_bar[BAR_DMA] != barno &&
+		    !epf_ntb_is_bar_used(ntb, barno))
 			ntb->epf_ntb_bar[bar] = barno;
 
 		barno += 1;
@@ -1023,11 +1470,19 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 		goto err_mw_bar_init;
 	}
 
+	if (ntb->dma) {
+		ret = epf_ntb_dma_bar_init(ntb);
+		if (ret) {
+			dev_err(dev, "DMA BAR init failed\n");
+			goto err_dma_bar_init;
+		}
+	}
+
 	if (vfunc_no <= 1) {
 		ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
 		if (ret) {
 			dev_err(dev, "Configuration header write failed\n");
-			goto err_write_header;
+			goto err_dma_bar_init;
 		}
 	}
 
@@ -1038,7 +1493,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 	return 0;
 
-err_write_header:
+err_dma_bar_init:
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 err_mw_bar_init:
 	epf_ntb_db_bar_clear(ntb);
@@ -1061,6 +1517,7 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 	disable_delayed_work_sync(&ntb->cmd_handler);
 	disable_work_sync(&ntb->peer_db_work);
 	atomic64_set(&ntb->peer_db_pending, 0);
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1267,10 +1724,13 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
 EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
+EPF_NTB_BAR_R(dma_bar, BAR_DMA)
+EPF_NTB_BAR_W(dma_bar, BAR_DMA)
 
 CONFIGFS_ATTR(epf_ntb_, spad_count);
 CONFIGFS_ATTR(epf_ntb_, db_count);
 CONFIGFS_ATTR(epf_ntb_, num_mws);
+CONFIGFS_ATTR(epf_ntb_, dma_bar);
 CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
@@ -1289,6 +1749,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_dma_bar,
 	&epf_ntb_attr_mw1,
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
@@ -1847,6 +2308,12 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		return ret;
 	}
 
+	ret = epf_ntb_dma_collect(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to prepare NTB DMA export\n");
+		return ret;
+	}
+
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to allocate BAR memory\n");
@@ -1887,6 +2354,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	epf_ntb_epc_cleanup(ntb);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb);
 
 	return ret;
 }
@@ -1918,6 +2386,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb);
 }
 
 // EPF driver probe
diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
index 0c02d709aa08..5cc0f0badae0 100644
--- a/include/linux/pci-epf-ntb.h
+++ b/include/linux/pci-epf-ntb.h
@@ -8,6 +8,8 @@
 #define __LINUX_PCI_EPF_NTB_H
 
 #include <linux/bits.h>
+#include <linux/dma/edma.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 #define EPF_NTB_COMMAND_CONFIGURE_DOORBELL	1
@@ -16,6 +18,7 @@
 #define EPF_NTB_COMMAND_TEARDOWN_MW		4
 #define EPF_NTB_COMMAND_LINK_UP			5
 #define EPF_NTB_COMMAND_LINK_DOWN		6
+#define EPF_NTB_COMMAND_SETUP_DMA_BAR		7
 
 /* EPF_NTB_COMMAND_CONFIGURE_DOORBELL argument */
 #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
@@ -45,4 +48,40 @@ struct epf_ntb_ctrl {
 	u32 db_offset[EPF_NTB_MAX_DB_COUNT];
 } __packed;
 
+/*
+ * DMA wire extension produced by pci-epf-vntb and consumed by
+ * ntb_hw_epf. It immediately follows struct epf_ntb_ctrl.
+ */
+#define EPF_NTB_DMA_CTRL_OFFSET		sizeof(struct epf_ntb_ctrl)
+
+#define EPF_NTB_DMA_MAGIC		0x414d444e /* "NDMA": NTB DMA */
+#define EPF_NTB_DMA_REVISION		1
+#define EPF_NTB_DMA_TYPE_DW_EDMA	1
+
+struct epf_ntb_dma_region_ctrl {
+	u32 bar;
+	u32 offset;
+	u32 size;
+} __packed;
+
+struct epf_ntb_dma_chan_ctrl {
+	struct epf_ntb_dma_region_ctrl desc;
+	u32 desc_addr_lo;
+	u32 desc_addr_hi;
+} __packed;
+
+struct epf_ntb_dma_ctrl {
+	u32 magic;
+	u16 revision;
+	u16 length;
+	u32 type;
+	/* BAR range occupied by resources without a fixed BAR assignment. */
+	struct epf_ntb_dma_region_ctrl submap;
+	struct epf_ntb_dma_region_ctrl reg;
+	struct epf_ntb_dma_chan_ctrl chan[EDMA_MAX_RD_CH];
+} __packed;
+
+/* Common header needed even when endpoint DMA is unavailable. */
+#define EPF_NTB_DMA_CTRL_COMMON_SIZE	offsetof(struct epf_ntb_dma_ctrl, reg)
+
 #endif /* __LINUX_PCI_EPF_NTB_H */
-- 
2.54.0

