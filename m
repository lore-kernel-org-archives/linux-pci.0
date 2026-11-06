Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793963928;
	b=r6ti0CM33FyBkSmAeblLW3rIRfDqbvx69jzdp8t6OuLEHna2w6nkA7hyFw6BA/l59n1B
	 cFEkSjGxDmb7BCitq/AruGPk0/lL8kgHjLa//CQUshywQIQ/X49kakYYMph0HXYtHmeNd
	 /ZmDypejSnrCbwYLFyoXoR9NBAUp5P2JKMIj8hLXGkbq2sN8+TxfoTNbMrzLsFLOR5l5R
	 tSZ90HBXzdqLUKMOemKoakM4io6i5Z7sTgq7AdcTSnI2sj04kE7H4MqUtbq43wuH5PNNc
	 lnAVuu5nKiXZ5krC9pOs9V+zDDpdfzM90zcfNjJ8vBUinv2gZFVc5rGa0uzANbNb7Sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963928;
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
	bh=wDdDujTy/yWRpau/gRJDSw8DMCIlzAr/0t/Zqbmxga8=;
	b=k3YE4I9hsKRGO1jAg57LWPpU/4pPWBcNrYTVYpn0ZVh0ce0bhZR8ahiu1JjbR5etK4Zn
	 T9nmavpR0ib3d3AtIj+e7xyTSMW3LBzp1Lu2WuV8/Bndd2cT16sgmGCZlC/5FDJRxaLry
	 BFsuqpO+VytTVw/brq9apkYunEMGbg7Ga8IgOGd12wxTkSF/UXBT2uAZKnFR9FSdw1Dt8
	 tzcG4H+02q65kZDaYGlrL5zdO6uumwUS70hBzLm+xZzscoRR1Mp4SRIiCU88AonwkrhCL
	 43HdpJMVEyuDkboLM+8RjHGvXtofpiP5cGtcaRfcmiKascepsgeL8C5T/u131f8cnxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GIt8TCok;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.58
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A39606D803;
	Fri,  6 Nov 2026 11:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A39606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GIt8TCok
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nultHiRj4BhisP9LGmwwYqN6TAXwBcd2mOkt3nOq+5irm9zJMieUaJizAy3748W+phybGG8ezocokdw838cRnBacngSSx7oOs/GMaiOXA0coYQD6Lg30KbpguQmmtehCVZKmlxspUhFC3eLsduQmaBDe1CygS2QRL2ElkOhjLPqR03TIqEHprGGJFeN77rtmbtvXuub02Z1ubZSEBDJMgsyIsfzgwt/LJOX4Q29HnafRJOe8yNsFiarMh2A41XOzWs3wqwtQTigZgjcE3alq37dktViAzXgb6bKLaRp1GMV6yANqo13MOkXajMO9OdtWUPQGHJpxqsiW+9l/geKLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDdDujTy/yWRpau/gRJDSw8DMCIlzAr/0t/Zqbmxga8=;
 b=ssuXvMfp8Z5+UYzZaJTbx1CzKS/JUzDAu8qjuFuu1+PbL+yYDuFnYTF7FM52cuN4P3cNLPonYWJ5NmWB+8SL7LH0Y+oZlfTW3xfv812mGmQ57uMntEE2cDxtFBYEFkw44Mm4Mkdp/TwNiU0agzp8yoxVbZBMnErKCOJ5o7yO8VIFFVuWEBlWxPEJS8ACi64hFoiqLN+alAaiWoJzZ1wRzXONQYOpLQ32FcjaprLhd5Rg1OrTTap5vvPLwlXuzlqwFcwPB+z20OV0oMPAn8/uX2R3fOK4Dw4AHSOheLf2E40UC6ORHzMsXG1uolIdoa4a7u4du7maMJ8LzvZ6aXMKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDdDujTy/yWRpau/gRJDSw8DMCIlzAr/0t/Zqbmxga8=;
 b=GIt8TCoklyjrAI+AhapMrT+FUmvrNa7Gwz1PPIKDcRskop0r9qGFUFwf4zdFxoyA0jKV6AISYITSpGZ5bxtN5YLuC2llW7PuDywgjnOsKAOZ3NXbw5gxMu5o4AI9ZoWc17lwvmluUKNHIT0J6kwzOY+EWttX+caEE6KkMartg3BxXFcyJN11+mJAtbU1Qq92EAtEpuhjbSgkQ5kFp6KR6GVgufDTRpwduIHxkXWplkWE9rnnmY0Ui8PJ7TSPTPqcauSqhJOJn1zozASFtKhJ0zUxaM2AlDBUMnzUlZ8eR9cIeFiDzmKvmoNq04MG92FK3x2ilMKVyJqMFMGtpsv1IA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 11:18:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:18:44 +0000
From: Richard Cheng <icheng@nvidia.com>
To: bhelgaas@google.com,
	dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	benjamin.cheatham@amd.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tglx@kernel.org,
	wangruikang@iscas.ac.cn,
	vidyas@nvidia.com,
	lihaoxiang@isrc.iscas.ac.cn,
	xiangzao@linux.alibaba.com,
	shawn.lin@rock-chips.com,
	alifm@linux.ibm.com,
	18255117159@163.com
Subject: [PATCH v2 1/2] PCI/MSI: Skip MSI-X restoration when configuration is inaccessible
Date: Fri,  6 Nov 2026 19:18:28 +0800
Message-ID: <20261106111829.55823-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106111829.55823-1-icheng@nvidia.com>
References: <20261106111829.55823-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: d451b917-a8ab-4d6d-79b8-08df3bf7b7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|11063799006|56012099006|261009223027099003|261102123227099003|261021121427099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BjDIIdLD69bSWeud1V44Yq3Y1I6LAN3l7nDl0AP6B9Mjw/rDRK3VdA3SynUQ/o8QfRNwZ/OOrgob1bhpDY3TxZJ4mXPq8xJtjvPZ1GmNi/6QkySn+KVgl0nPzCgb6gxG3r0U3L+GEJL3rFUO2lsCdWt5APmP9dA0DxUMosFkn1FU9TOB47AH50WfgJhTiRr1rGLzOHincW0qTKeRRb4ombKLPEprqRWTNSifskAbgILxke/9TPdjXP3aqhUZnrIbfCvMrYntlATXAaOZb8KXiggpMaAh9VJkhYReiB8tU27NMht/EHfDVXBz2AAqjyDeDdE4RrUhLHm1Ti/0p0EiUvR9UuBvBAo83BXErcJxQeePimc/56LrmE30KzcDOCHmg/eOY26nMdyRiZQ/lODCtiv+g26O8Yh+tdJmAGOXWXK2twTcQ/xrOOHUYdQV5oEEP7DmgnnGDYof+p0cCogezMFPqspY9d9sx8TG6Z0VGQmdqc9n5pr8ZiWxZGmx+NZlcInqGNZHazRV4LIZMLIL1VufGjD169LjKpAdMpz+wXDtLTkYKivgZbqJljD7nnX2aymjlusJeBVen+0Wjly9sN6o+x5U2t+ozZDh5CTcNWF9ls+W5zUWsMJsa2fZdYN4ZtoRLWfqHIoPYXewC8koKIHZmnBG+ksStZ0cZJDMA4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIx/TX4sGcAgNKLeWjjuoJrRiz1dQsP40WaxZXmRBkum69C+BzidRsEs1VEC?=
 =?us-ascii?Q?ksJYdtCsFcdt4+JyAw8XTFa7RKD0K4+G033nIL+KXBDEY6DFtmZ2UjtbhYU7?=
 =?us-ascii?Q?uObJvOKrwHGZ57xxp8ix43oAtqFcHXhjIWyZAfLgZ0la+2mGYOErW6hEZNic?=
 =?us-ascii?Q?MVZik6qeX/JefVlQgZ4CLR5qG9nN+LbnJ6hxLy7K8Mnszh88ULY52JSrNYUD?=
 =?us-ascii?Q?oTjOzg18oTejNRIEpjjwFytWjAy74Cno+I881gApZKkri+MeqElaB+PiDD+s?=
 =?us-ascii?Q?AokE1THe/hDRDVtWa0ZnDGtHpN0HtvUVPd0Mz2JiY9zQdWgTognICpuyHRLq?=
 =?us-ascii?Q?xl+Z4yM2q0ZBDVi8y/dndeHFIl9ZMnZiEoiy2FEo4+f3VGJZLmE5AXi+AsEA?=
 =?us-ascii?Q?48SSWXZGZl7V1S0a7KR1F9h60QFoVP4FMYc7aSnTuSvelb2/0BSGCdH8rbGf?=
 =?us-ascii?Q?WmL8M9yLM5ctIouPh6RBZQ9cZdLZ4UDcAcxtgg8SUJ8c0+L/8Ay65pTaAvv7?=
 =?us-ascii?Q?ixlCPrFQQOcD6EDv+YNg2GWcd0lpuy13mDwi2Xyg5BTHrA3k8ZbzVxzJ1nq/?=
 =?us-ascii?Q?LfrK2rWXABpcdTBm4mHnKfiHLug/TqkhQP8n8bZJfVx9t2otXR3ArSEBn2l0?=
 =?us-ascii?Q?rytbrENdFZtZ4uLUwWt5bfRtqt41IXoGm9542PvHA+STTlDrp5IsE/TXS8jm?=
 =?us-ascii?Q?wo59kPUQpiRGYOZHyPydfmby56Rrm5+n7juaKUe5Yk3MiatN2rqRz6hNSUdF?=
 =?us-ascii?Q?QW0oE4akw/BaX8XF2P7xib+PYperfbIAjrXiyj/0lfTnPXjAyvq7+Jm1t1Tg?=
 =?us-ascii?Q?5FUjl6e7O2i9jTQj4+aOekbxnQLOa+AeL4oo6pSnKPEBn44xNy5fGkMmEOud?=
 =?us-ascii?Q?2AwtF7GQ1om5FXd24xPjHsVlsioGUX72IoEZacf3l2P7ubkdVI2fXqwra/n8?=
 =?us-ascii?Q?H39AyfqGqeqo/cPOT6AkAvAnedac/pmdo6lrmIgO//YmHshFVXPlljjehv8x?=
 =?us-ascii?Q?+AormO0qG/g/nbUI3GEU5STt1+XMTEItNgF1cH3iA4hv/ww/B1C6BIlehnjZ?=
 =?us-ascii?Q?oQ7pyo2hN9rn/F379mGa8EMe3dpuBOj0kOCkuTRbVz8sxPSAGEaNMcSyfUeF?=
 =?us-ascii?Q?IfxUbYNIIcUY/RlUPUEDG5Crn/AOGAEcr+/0j+ANWZhC3f0bhTOejEzVuPLy?=
 =?us-ascii?Q?FnKXwkBB94jq+bnlnVy5wzpal79K9JFeOBwFppr6uN8MEg+b39SKoNmDZMSo?=
 =?us-ascii?Q?IEExP3x3uXY25by3rocD+ROt8gtH11CaYFUoOLiLD53Is8pqOwUtKDueDj4Y?=
 =?us-ascii?Q?jaGcrFUzbpchEVeh4pmEgXPINvdTjSTxwwQLrXgffdPjnW4nVRSl/zx9ldNM?=
 =?us-ascii?Q?KOR4k/p5LPpU5Azb8rysgQTg4NxxbURP4EuxVqJTdTMIQbDKiSUUF2B7KVXh?=
 =?us-ascii?Q?dlNK1l3/T0nkUAHxFW/GlWm1+U30pYw8RfYQVVgEEH0F6+fvSyn3bOwLqvsZ?=
 =?us-ascii?Q?t1ACQ2OtzLbSqCaIOIIuqeMG8ut8ZTVGndCCJ562xiLPAtGP3qfjavbKujlB?=
 =?us-ascii?Q?pv/y6sp/W1xedOu65DRJPdrSuxiAWTwaqeWwy+DdrLXb7h6TmBozuXICPyLV?=
 =?us-ascii?Q?4/TG2uNJ65zqhrfKW5pXm6cAK+8kycJH0ztnJuyQYtO7nbhu5hV1yVhwOtgA?=
 =?us-ascii?Q?p99PZBJa/ifqkE2bfXPgsKuWCUzB5E74P40VMQDO8ieHpSFThT+Kl6dO2z2g?=
 =?us-ascii?Q?D+NrGR9rUA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d451b917-a8ab-4d6d-79b8-08df3bf7b7d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:44.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlX635vTUzj4u1e8a8Ib7BLhN6yvIW2d16frGoO5O7RtDFCkf59Xwp9z7xGZ1ovmkBLd1dXAr1UwsLr0l6FIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652

PCI state restoration runs even when a reset fails. If the device's
configuration space remains inaccessible, MSI-X restoration can issue
table MMIO accesses that trigger additional errors, including DPC
containment.

Check the existing PCI Command register read and skip MSI-X restoration
if it fails or returns all ones. Preserve the existing handling of a
valid Command register with Memory Space Enable clear, which temporarily
enables memory decoding while restoring the MSI-X table.

Limit the change to MSI-X restoration. Leave other PCI state
restoration, driver reset callbacks, and reset return values unchanged.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/pci/msi/msi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 8a0133a6a286..37de31f4cfb6 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -887,7 +887,11 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 	 * Since the MSI-X Table and PBA are in Memory Space, enable it
 	 * while restoring them.
 	 */
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (pci_read_config_word(dev, PCI_COMMAND, &cmd) ||
+	    PCI_POSSIBLE_ERROR(cmd)) {
+		pci_warn(dev, "Device config space inaccessible; unable to restore MSI-X state\n");
+		return;
+	}
 	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
 
 	write_msg = arch_restore_msi_irqs(dev);
-- 
2.43.0

