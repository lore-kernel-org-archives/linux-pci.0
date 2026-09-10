Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15663C1F5B;
	Thu, 10 Sep 2026 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024130; cv=fail; b=Lw5kO/gBUDqZEVeKgwxkoE89UbNzVAWXNhwJ4RHyjwyW9RTxIVuT0oslE/xteqr7Sm6MMU2EzBp898BNqOT0UwwBgp1hvke2yq1tbFvzWQhg/QrtgDYpG2G1Hsv71IXZ6laH7Scp5U1q9GcAhukZJGM7p5yw/HxgjeMDOe/Da2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024130; c=relaxed/simple;
	bh=VDmwCNegrnAurYpztlL3oMJNp7yvbqHnTvl8nUAXBg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TqkZZT9qYSp5jKNiYqk0HkHWkfqhhA8LzpcgOTXKv8yHf2xt17wz62K61ROXjb5I+RYxnCAAauxGOYMTs8GTc4R1KjKva38WQqMBbuJA0itUxbuSTBQUuXOem5KgTJ/p5xbroDGxThhPuhKcVd5s10EuOueBXkUdZeYCdBfTTAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JP9LKgUR; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JP9LKgUR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+PIZJjFIrSM7tjPotkZVvgSzFfFZLaaMnWvuuOFGu4d03V+skSpQkCctYuMVNCBjSKtmHgnMt06BRoGHotXBAjX3j7fzctpbQCbWTyTa277iQsi/nT4IUfPDxqPonCxX0hBY0kfGw34TleNp0nBauJFaptPF8CdN79g+DzscZRjtr6Ra4Xio8mRynyoz+VLhpgb6fTsJJanZ40jXEgDceebbtK6dD1Hw/odEmj9MNBIgHC/V5JZKW79vYcZ5Zomkje+6xMxf0kk4dMI1S8GP1j7H/llk8QFhqSuqJedpu/X9jojoFLGUNPnwbBETWmrRaPS64iG3NVX5l8EZPpWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjBqIRCHONLi2PU6tOVV+a6+sIjPAZTwG00rRlOV1z8=;
 b=iwoEX4e8sEUi306/fTH4uj+R7KQRm65Oza0yWTgQI7zLlr9t9JqZJ/jWcAR+PGlPwNNl1f2OD7t0JSrSHxRGgRznmBz+6MYQWPDwkSzOHzsGRBjjH1MjiAcY3uBPlzAG89x/CaLhGoLzy5nVFhf2lRsujL2zD8f8ugncrPY37MTBCXcD+hB0P3q8A861aaLvZn8SOtoawKPCs4mmnNPQCfIIK5Xi/xWn2mCinDpWv/SnAdp0Hv8YXLCnTZzkFyCz1jrY3ZZvpgA/J+G9xbmstdkex9JhNuRPcEr6PEZqJ2JX1X9Ln+bZV5TveQcEZksBfg+n7CGZLB/WN7MZbQtUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjBqIRCHONLi2PU6tOVV+a6+sIjPAZTwG00rRlOV1z8=;
 b=JP9LKgURipQ7x48xtQCsPCkQ/fDDU5efB2jm1f7cHm3RiyuIaLS5fn82f/40KwkOTSgpdNJVic0qiaJyfn/xmeDQeyJ4oSg8kT+xNPZ1F8XukXkUerFwilBQFBak21RrPSIbNJ+nTKtToG9Of1nQi8HGy8UTTFMr+CspaWo2t6AgrWZyfNqffC/BJZntrk73aCth6v3k6HURvnWa08PPIidZz63hCqUoYLIxUFkRJuJkU3qK8JtwcTamJhCi+QKFlO3/C5Fbs64uiVxvB38OD3fw3fWTyaxrLWo3PB8l6omyDRhGDE7P4yEyco0J5C9U7MkGH4l8/9T6ZawOkUqTRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:22 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:22 +0000
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v12 03/12] cxl: Share HDM decoder decode logic
Date: Thu, 10 Sep 2026 07:07:59 +0000
Message-ID: <20260910070808.1444264-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b4489f-103d-4ed1-b35c-08df0f0a4d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	q1V33ovOPDAou6k0G8pM2145TlMSQ5Ryp6QNF/z+2LBCej7W3fsDD8nHdqQ7tu5BqECqCsr2JWqKyLIqZhTINvXmBG6V4Hxu2rtSw29bWeENcJkst0TmP238O9x0NCdMX6D5yySzkYC1aRazPTcktb5aPe9p7JA8FekIeeT+3wV/RpjnmbPm7otnLfcgInDncHL5RKbPDBqQpJT5rk91JZ8xk4EfeE5hWfovDk77z53/pRJbYjFk5d8VsO/UtAUDrwDVb2q1gdGrUg0QrN9h4pEV0DX52zjsA6vTafHnd0W8aFeeNITr+rctfLyYdJ/x/SIAvIsUKza7P7/BDxsJLXDi8cxcrEr5O5tC80outGddYKi+AWTOxNSMPVXpW7xWIoacg/j3dXn7qcdfwhwz3sIkaWizTbAsrmlEm/1Hxsm97cgguHfE4Wqfa020Q700gV53lwUHdM9nr9B3ecYrzCKg2J8WaXrJ4ImruBiFmJs0sk0dJUJjwUXcE/UJSUpVtJrEAAKH24E/Bw8czPXFNOIAcKi4pT1P6018Jw4MCyIWYz9PBn6b3FCPYtH8MlYpVaKE0vAoEjRsGypxtDU7mzmM5nIKWEhd8gdXEH3IIXlVZDJgeVI4+6h3eW+XUtLDtpX9jQrsQvDE54qra1nUt91m/4cbdR/GNX/sZAHDEXqvc5bAp1USq3gjsaAcFHPbYuTPiY/sHp9+M2HqTONcqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TV/S4bHNBwjUPEUtc/OB0/a+nfUyMgTeRW88ythD/heE2QItIQYSzXl/cOaR?=
 =?us-ascii?Q?FMCgSp3Rx1w1YbNtPVs+A2+RlN6CdFeURXdabr3crqW4PmqBgmjHaMBZ1vLW?=
 =?us-ascii?Q?CCjj85DOaYMUbaNcFf3HqnCZzfxaZ6DeKtdfSmB0hqimNcF3yNggEVgdT7Ua?=
 =?us-ascii?Q?esfho1d4I6uAMcGTdlDjReHl9wSXz19mTYvVJtreth5GuEoNzXjy2jJ7gP4m?=
 =?us-ascii?Q?vSx1a6tXnwgWvkJI2WpwHzP+RsiXCxsorR+QFGdsAGdnReIecENNZjOQzdj9?=
 =?us-ascii?Q?ft58/WLty1ae8njbCcd1/MyC+yg4RTrqD0NcQMHWL2KTGajm9sRvmWnEnCLU?=
 =?us-ascii?Q?rSUGYXnxKx/tbx+pwji2hxySIG7pnW9CTm0duwZwN3jTA/9+Sd1ZsdQMnbON?=
 =?us-ascii?Q?fVLcBWH4NqlUhK8sLzdxNpJKovqyKfR/z01iMMRlO1ExL9wJ3p6yxG8xO387?=
 =?us-ascii?Q?5i9Ll+YbIjYSptQICPEHa/sUJNp2gHLSft9qPkq97IGmHpBjIDR66rGP0j+S?=
 =?us-ascii?Q?8kXiLEy3DcF4ShTa4yKuoXl2PK9ETkbvkpnMrX8z5QNUone35XE6kzhJMaqZ?=
 =?us-ascii?Q?63dFOcyO4gIm7PaZAPcWjGlDJJyI3OIC39XbfQ8X3m9J1Jz48dgOsMlY+Pkx?=
 =?us-ascii?Q?8+vwg9NFjmrOEFZ9CandTf6li0z/+tAYgKmX3cMwUplCP5m8tCOLxZZy+qJn?=
 =?us-ascii?Q?PagUtRi+mmCRxfHnOwCZ02zQGoYdD/QeMVnMTBs5/y1w28LlXHRyQTbCiHnD?=
 =?us-ascii?Q?2PxkZRGXZO86a37HIEU6ld1eMLtURAb0MtCo0v0y3c4iEjDkHag+ONLAQumx?=
 =?us-ascii?Q?Oo3hUlugkDUkJ1560yJbooGGm5ir0ZpAAFPMNi2xcqioadrNk7WVAxehm3Np?=
 =?us-ascii?Q?DH38X6tZ5kCWPpKawsBXBVlHLoqrPV6rAOUjwcqKGP84kdYqE2BaOOT7aOCl?=
 =?us-ascii?Q?hNplQhnim0PbtF6l8XcPcZGc1NJ8HfncVwXwwUvQVXFhZW7mtv804Hx3GVp3?=
 =?us-ascii?Q?w2c/+chhDK+oSXKGl7BsMKtJzZU0PkL+c4tynuPjGZ5f+D7paGIhhCvaMmHY?=
 =?us-ascii?Q?ZY6BjnQnyWYTPS4GclZNf3Nt7Oukn8HCiE67cilBuFuIFyiq/d+wC1r75Eji?=
 =?us-ascii?Q?XGueUDw18VuQ3aP6Rn5ecfh6Jlfq3GlVt/oHOoOpZYQO+7HfNnK29HfrGE08?=
 =?us-ascii?Q?kIISI8MPKzNE2Tm9bCRBf2PmLPP2HOikwdRaQRRfX48IMxk/AtPubF1rqR7C?=
 =?us-ascii?Q?ec8gIwOEMdHJwpfybypFS99BRUv6ghyImaKn7K6Dc3pOsajxQYIaK1GAa0WN?=
 =?us-ascii?Q?0nimGMDkbpWTTdBiHcmCpQG+acpoaTcYt817a98QsTVNuMI/9MXNG4LnxrJi?=
 =?us-ascii?Q?atN1r2ueDNKdqeI6tD7nLjnzt/EPVDG5Emr3QvbczWnKS3RWbOgLD0H9pWdl?=
 =?us-ascii?Q?mcUjm2g3N0dzrSZpHp37up5MHR8Mcfha139RpLE57DI1b9PB/lqYP+I2n75G?=
 =?us-ascii?Q?UJA6xfflBzX6dXxfsiDYGaxryeU4sgVNeFcAowiPbdOJa2G0owyS4sRxYl/F?=
 =?us-ascii?Q?fICG1XKi5VoVeoVmqiGOXoOPsnpMNTMz1fEr/eVwEHlToNhoYqwhfiTh4Oct?=
 =?us-ascii?Q?a6PaWLDVRlbC1nTH7p2El8ySHQhqiS8R01xI36KSw5TRJGxbgiiRc1a13k9s?=
 =?us-ascii?Q?ofSB670NGjANb9Exqx6SkIPlslN3JH2lB0xfPGBtPQXNb2RJ/Nw79dk98nk7?=
 =?us-ascii?Q?NyZbzxpLbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b4489f-103d-4ed1-b35c-08df0f0a4d01
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:22.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bD/ET0AIBbo1kg+x16wC80YIlVGYk+0p2CNGsYpprDIWQiaITPTAZenhV/5ML5TK4VHQ7LGEXHDTpJZGKSG9ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Move HDM decoder register decoding into a helper shared by normal CXL
core enumeration and early PCI HDM cache setup. This keeps validation of
base, range overflow, interleave, target type, and enable state in one
place before adding another HDM parser.

Keep caller-owned policy out of the decode helper. A committed zero-size
decoder now decodes successfully, while init_hdm_decoder() retains its
existing zero-size rejection.

Preserve endpoint DPA state ownership by using the decoded skip value as
a local input to devm_cxl_dpa_reserve(). The reservation helper updates
cxled->skip under cxl_rwsem.dpa.

Reported-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h     |  4 ++
 drivers/cxl/core/hdm.c      | 75 +++++++++++++------------------------
 drivers/cxl/core/port.c     | 19 ++++++++++
 drivers/cxl/core/resource.c | 43 +++++++++++++++++++++
 4 files changed, 91 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 48fbc635975a..5350c154d88e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
@@ -215,6 +216,9 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
 int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings);
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70ffebd3e213..d621d827f59f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -907,14 +907,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size, lo, hi;
+	struct cxl_decoder_settings settings;
 	bool committed;
 	u32 remainder;
 	int i, rc;
-	u32 ctrl;
-	union {
-		u64 value;
-		unsigned char target_id[8];
-	} target_list;
+	u32 ctrl, tl_low, tl_high;
 
 	if (should_emulate_decoders(info))
 		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
@@ -927,35 +924,33 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
 	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	tl_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+	tl_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+	rc = cxl_hdm_decode_decoder(&settings, which, ctrl, base, size,
+				    ((u64)tl_high << 32) | tl_low, &committed);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->id, ctrl, rc);
+		return rc;
+	}
+
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
-
-	if (!committed)
-		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
-		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->id);
-		return -ENXIO;
-	}
+	cxld->hpa_range = settings.hpa_range;
+	cxld->interleave_ways = settings.interleave_ways;
+	cxld->interleave_granularity = settings.interleave_granularity;
+	cxld->target_type = settings.target_type;
+	cxld->flags = settings.flags;
+	size = range_len(&cxld->hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
+	if (!cxled && cxld->interleave_ways > 8)
+		return -ENXIO;
 
 	/* decoders are enabled if committed */
 	if (committed) {
-		cxld->flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->target_type = CXL_DECODER_DEVMEM;
-
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -995,33 +990,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
-		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
 		for (i = 0; i < cxld->interleave_ways; i++)
-			cxld->target_map[i] = target_list.target_id[i];
+			cxld->target_map[i] = i < 4 ?
+				(tl_low >> (i * 8)) & 0xff :
+				(tl_high >> ((i - 4) * 8)) & 0xff;
 
 		return 0;
 	}
@@ -1036,9 +1013,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			port->id, cxld->id, size, cxld->interleave_ways);
 		return -ENXIO;
 	}
-	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
-	skip = (hi << 32) + lo;
+	skip = settings.target_or_skip;
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..5085574521c6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -34,6 +34,25 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
+{
+	struct device *uport = port->uport_dev;
+	struct device *host;
+
+	if (is_cxl_memdev(uport)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
+
+		host = cxlmd->dev.parent;
+	} else {
+		host = uport;
+	}
+
+	if (!host || !dev_is_pci(host))
+		return NULL;
+
+	return pci_dev_get(to_pci_dev(host));
+}
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 8d3f43640199..e6aa55079c76 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -113,3 +113,46 @@ int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
 	return cxld_await_commit(hdm, settings->id);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
+
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed)
+{
+	bool enabled = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	int rc;
+
+	*settings = (struct cxl_decoder_settings) {
+		.id = id,
+		.target_or_skip = target_or_skip,
+		.target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
+			       CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,
+	};
+
+	if (committed)
+		*committed = enabled;
+	if (!enabled)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX ||
+	    (size && base > U64_MAX - (size - 1)))
+		return -ENXIO;
+
+	settings->hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+	if (enabled) {
+		settings->flags = CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			settings->flags |= CXL_DECODER_F_LOCK;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &settings->interleave_ways);
+	if (rc)
+		return rc;
+
+	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
+				    ctrl),
+				  &settings->interleave_granularity);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
-- 
2.43.0

