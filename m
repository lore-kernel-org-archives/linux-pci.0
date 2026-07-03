Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68395345CCA;
	Fri,  3 Jul 2026 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116324; cv=fail; b=k8R5ryv2ixZR3Bj6DpEMkL7dZGWXac1eIpKGI/Id5/xUygR2slUxp3wobRdpZxPhbJ6DtOqns9UBhhCNb0tOKF2WcKEJYM49UKbsM1jHTNclycv6EQ+aBkM2L1hUDlKa7KtKQneAr5jY1YqI3eoFMStYwt5x74+jKi0pyQkUlzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116324; c=relaxed/simple;
	bh=qV5QOcSeeyGWREuC2f4gy0bgQ4/u6rkP80veW4Ee92Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C5oZDouyS37+ej2aLYZbPWJhgI7SUvVy+hm9hbVHhIBaTgjb7VjIVDHC75KL78iDfExMNNwcS48r1yxI8UievhvLWRJcOPnOMAkv1frC4oSrcXN5YQ6OyGM/o7BWXPQ9REYhmXHc8T7IO85hfvKmvuch0jOn6bobznXfrGLwJNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U/+eaKw3; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U/+eaKw3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnHtmWZSBe/q4owe9q/PSeB0Bn9AXWAsL9fcsBoII6WwhTOuyNmWRbA4te6sFCMtjl8lexpYgxKkGJHnJYsSHP6/lrTZTVHiAk8KpD76VEV4sGajB6xTuHgra5QSa27yC9WamBenTjSzHtKpsFLkfbv2KISGlEh5sXSGKO70ths1dHpIzev7xjDF4auwjHgdhIp8Fp6iMlJMU4DjB8VKpj+znIvVl1IYNE5w9u23PHuFK/jOwks3A0TFti8jITrL/fOd5rIvCv1NAbvqsO3RHbJJIxrlZVEafhT01kQb66b+CzKpkjO247tIN869Eua/gUtVdz+HURzveh7bRa1EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LelyM5KkjErVMrvsyDrEooOQEvpM3UUWe5wWc4fWWpI=;
 b=quRJkuo3Q2u3Y7K77LA1jeRJgD5YCNAtxKRFfOq+PP5EqlU9WK8fL92C3igzoYYWOE98tqBIa2ddk0zDBUPNIaya0Cqt+QX4vltIWY5NdGSsOooh1b6FL/W5VRnOGqEnMY5Q6LbzPtL2ArnDIxnvWv2gjc5AFX+GsnqMi1ZPqs+G4Flwxhib0Jecc+P769CN6ZesDGJZClci0ZghWMSLrhBREqvkqJJgD6OgAWjSKI/4Jq9i5BAf6aZKcF5+SovLZWCUDmWf6xx/oPO5grTrmdC3CGwoGgKzJT+FTkhnDlEUKjAgV8t4cWcfkGBODNmbkw9ctX6IB/+v2cywk4EUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LelyM5KkjErVMrvsyDrEooOQEvpM3UUWe5wWc4fWWpI=;
 b=U/+eaKw3XafNVVla5+sE2lQfoAulkpF9xC/uV0D4BVohVtZw1+dLv3K48pJ7akbmnBcKfnyQQkbfpcKHbZV0ef+RAAgijAsDzRdrdFkMauQdIV/e/u94/O2BOl+rOUOkXpBtxFd7pyHs2xBVa5719nPa5e9jgZo6zodNDwnKzLGiMjOPeA0TVFs3clp9wnzk5+u5nlZczEKqgWRdi8ZsXHGHaQRfiAgBLlixPgx5njyilh/D+RbQEJuaTocNHjgLToMu2tyASYLnOQJ9daNRORHOukIOSCghKSos93Utwi+//yGjYYaCFsdH/op7YgelFhBv7E+47knGnu3qgKmbWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:16 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:16 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
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
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 02/10] cxl: Cache decoder settings on PCI devices
Date: Fri,  3 Jul 2026 22:05:00 +0000
Message-ID: <20260703220508.546528-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 335a8efb-2502-46eb-d3bd-08ded94f2a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|921020|3023799007;
X-Microsoft-Antispam-Message-Info:
	ggEDV5T/+fkaPuIdKEZbUYWNj0HWNOX121gLWTcy0AGnh+rzhXnnXItmOxCRfItQhrn/KFqLpEq+whF78Z50hOYYVPiFmVqxIpZlJCrocV7k1MtUk5lnkKUv4AA+gftC4rYq2oA8jl4vx0t0FDjX64EvhSui9nHWaEuadrfv9QPNyIT3WulUtTMQDXEg+jBiXweTeC3vrJfjTf6DJt/yoAqy39wZGwgTHBWeAFJ8JwcMv+ebIUocrNAfV63bO9kkvrweN3xy1+HR8PJUKgTlVFYvNyD7OIFlDs7ahAF44Za1Qh0dtl+P0GV/tc7nmbipy49jOhdMKTouhk9fUdosciQMyfzjW27Mv15BFlWBoAEpVyMEoTAZwVcU261Mse+CVU4XoDIMm78AHQzbTV+5gme1CPbVWypYRsqbBD94XMJuWfPa9443+R4K5gZdGqrpnC0+Rv/wA9GRamPXwZ90ZWWPCdl5CLznMlAw3YR6sVnV2F+lFWe1ZBYtgQsIOckKhMBH070pcRtmHrS9ApPa61JdLzEAOynOqD0o43fVRc1TDmxEK51Pdkr5FHrABGBA7Orjihq6+Aio1hnxZVn3BPcZYxPziFFARjineqEYW9y3+4S2QCR/NPiz5ySKXpVY/p6sy/PyYAJGxHrr74KenTtoi3Lfw6EbjIf4PrJq7CKo/bwo/qB1FrIR6vDd4rpl995nkGuj2s2qE4btinPGgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(921020)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MYLGA0vQAbTup2gQvhAiuZZ8Xyeg3SHU9GoJuX8exgZvgWq4d+DAcI5BK8OA?=
 =?us-ascii?Q?bvSvbmthQfFrQfyzD4b3FG4BQnq6sjEVUUX8yWWA7ShxRZGalz/W3qaj2FNF?=
 =?us-ascii?Q?Dlae0YL+dbqM1uAqXk8ibYkdN6a7uykp+LFqyWA/Xi9wioEXU+G0T7TR8ACf?=
 =?us-ascii?Q?WZrTog26owqaRv2YShvzCIp3ddWY7OOYKnMlTsstSD1yRKOzvSVFCcZdwXRT?=
 =?us-ascii?Q?iTTw9QUZrNC2lTAMgyfHVk2nihH/n93JK0Fvt6GoVxscn9CepuR5f7f4Cx++?=
 =?us-ascii?Q?lRd8+tns+P1Iav5s6+iwMV/pL+VgvCGx0+PIMyV8b3BOyuWNMf3E1/qQMULX?=
 =?us-ascii?Q?QjCTaFLmdA1EP5vBfcyrJXFlc7P+yfS9ctFTQ51gPEZpkj0foRK5grQ/WZ7e?=
 =?us-ascii?Q?jQuoC637pzo+jl828ntzjxWsgbKeMQuDswloZ3Qd/bx0PnP6KcF7dRdCG5NI?=
 =?us-ascii?Q?uTyfW8r43g7Jtfyk8/FL1SEKV7V4TebY/XdPT5Fhqsenm2jpN3EHwwoyeCdl?=
 =?us-ascii?Q?Vmq8t7RzRCbBjVT3MCAgwH1r51ZdUSmh+hfxOfxVB/tOv4HL2Whi5CANL+J3?=
 =?us-ascii?Q?LW+5IAQiura9SWK1WOsL4oy/YkdNC403zkis2/lb5HMiteuM8urDwnoBFluI?=
 =?us-ascii?Q?9BauwUTx58d1fei24O2LAFOxwjGsR26lRE/u0qxM0GzMS9jOMXrV0lpzA9bv?=
 =?us-ascii?Q?+gj/VIn937fQJarm1C56tqXr9NvJhPQUfUYj3f23YB1flVyF/8spLebxoxJB?=
 =?us-ascii?Q?bg7p6ktgTJkJxNckFcXwfo/XWEhX/z3FJse3l5eK07YJr6kAGFcyHnZxVpGh?=
 =?us-ascii?Q?YJggjZlQ2EgUXpUpx5iDsmGvU7uIbNgqg/+5Z72i7DiKWwKSIBQps/qD1WN/?=
 =?us-ascii?Q?Xo50cbS95l9t0FtVboMbC5QenMZZ7roD+sYRXsARG49JVxDjg48EYpskFadF?=
 =?us-ascii?Q?1Qrq8k2VE+30GpQpi7WVzucN6BmH4QWG1EE8g6mF2tNRI0Z3TI4WCqjbGreZ?=
 =?us-ascii?Q?KPPXnNEqF4i9SqQzblIP+5CpkQi5fOpJwiPoEEbKzwM6PdfRz+vnLKDQwqVs?=
 =?us-ascii?Q?C3rLXuf0WjvImoVtBIRRUiZYkWF20Qqpi4DrTMPXmeRdvyYoUERkaLF14SRE?=
 =?us-ascii?Q?6xntUQ7C/NH/2RW3eaywdutTmAT3SpZ4v3f2NKCQMqaTaDQAWDjrCZucYTS0?=
 =?us-ascii?Q?z1tQo1cy14MoXXoZxlmVYG67BuIL+UKkznL/P7Hf165NAJCNWVnLzuqibL6/?=
 =?us-ascii?Q?C9y4HcqqnnkwMJnCTKwLFAmKx0QwCa3UGoCs0B5VgA3iX5E/EqIE9wlD16xO?=
 =?us-ascii?Q?+cC25pklLw8gwIcMT65R0pcuYChrZMgUGkwjCpT1rbZh6mBhg5SUk0gHKctb?=
 =?us-ascii?Q?hC6QcxttjyyPZl7aldOEFJpXIvWSNk24rEqen2ahJ7S/2OrlkGbB9jABxJuS?=
 =?us-ascii?Q?zye91l8+96W+SupOmcbSHeBPGyQ6Sgx7ovDHcbQ7gZOwZw5F0d7A51dkgVO8?=
 =?us-ascii?Q?EtrCyu8LZfn2mQvaTNV/5dbZZ8yHeqZq/VQqpJ7tdvE8RVvHzH21PdBXJDit?=
 =?us-ascii?Q?/nZ7dBY2BJ1ATvx+srN91ZUkzUFYGToUR74GK7Ia+ftbMYDHTpeLbHSilD/x?=
 =?us-ascii?Q?qRNrqeKGeMqWuj60m2n15nKsfnVvPPsUicjcRgybmHcG8GyrUk5y6669niKv?=
 =?us-ascii?Q?w3Sn1NYtYxJybBzDzjgf6VDAC2u4BB6bX37SUBU9wzgdvnJc1a83KwF2V/tG?=
 =?us-ascii?Q?HFgc1pGOBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335a8efb-2502-46eb-d3bd-08ded94f2a10
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:16.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuHCFcKEHlRb1daon8nyQ+yU8ROjB6SqtnxunW5j+Jo4UX3Ef/EYrr6MgO/ZBLdZfP/9BCqfo5ps3Wb08pBGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Cache CXL core's HDM decoder settings in pci_dev->hdm as decoders are
enumerated, committed, or reset. PCI reset paths can use this snapshot to
restore HDM programming without walking CXL topology during reset recovery.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 81 +++++++++++++++++++++++++++++++++++++++++-
 include/cxl/cxl.h      | 12 +++++++
 include/linux/pci.h    |  6 ++++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fa978c297546..83cda63f76a5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -84,6 +84,76 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
+static void clear_hdm_info(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	WRITE_ONCE(pdev->hdm, NULL);
+}
+
+static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+{
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
+	struct device *uport;
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		uport = cxlmd->dev.parent;
+	} else {
+		uport = port->uport_dev;
+	}
+
+	if (!dev_is_pci(uport))
+		return 0;
+
+	pdev = to_pci_dev(uport);
+	info = devm_kzalloc(&pdev->dev,
+			    struct_size(info, settings, cxlhdm->decoder_count),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->decoder_count = cxlhdm->decoder_count;
+	WRITE_ONCE(pdev->hdm, info);
+
+	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
+}
+
+static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
+				     struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
+	struct device *uport;
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		uport = cxlmd->dev.parent;
+	} else {
+		uport = port->uport_dev;
+	}
+
+	if (!dev_is_pci(uport))
+		return;
+
+	pdev = to_pci_dev(uport);
+	info = READ_ONCE(pdev->hdm);
+	if (!info || cxld->id >= info->decoder_count)
+		return;
+
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		info->settings[cxld->id] = cxld->settings;
+	else
+		info->settings[cxld->id] = (struct cxl_decoder_settings) {
+			.id = cxld->id,
+		};
+}
+
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -747,6 +817,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		return rc;
 	}
 	port->commit_end++;
+	cxl_hdm_info_set_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -819,6 +890,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_info_set_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -989,6 +1061,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
+		cxld->targets = target_list.value;
 		for (i = 0; i < cxld->interleave_ways; i++)
 			cxld->target_map[i] = target_list.target_id[i];
 
@@ -1062,11 +1135,16 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	int i;
 	u64 dpa_base = 0;
+	int rc;
 
 	cxl_settle_decoders(cxlhdm);
 
+	rc = devm_cxl_pci_setup_hdm_info(cxlhdm);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1101,6 +1179,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		cxl_hdm_info_set_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 757d916a6330..84924ca06e52 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -121,6 +121,18 @@ struct cxl_regs {
 	);
 };
 
+/**
+ * struct cxl_hdm_info - PCI device HDM decoder programming cache
+ * @decoder_count: number of decoder settings entries
+ * @regs: mapped CXL component registers for this HDM decoder block
+ * @settings: cached per-decoder programming state
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	struct cxl_component_regs regs;
+	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
+};
+
 int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 
 struct cxl_reg_map {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..7db2daf8597c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -334,6 +334,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_HDM
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -563,6 +566,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_HDM
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

