Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794812034;
	b=w92ZiTngYR7OhvjBY7UtrM20FNAItJyM/4ZyDaY4a9r40eb168jnCjZz7vLopFvxzykF
	 SC9gaMy0mvlezQ7v6UJP/ZUB4SLzzODlpd1jpcbytPyAkYBOK6GT7b4TCoXGSK1dHeLGy
	 KvAJHFcU8B8MMoybmhGe/NcbeY6dUAE99ix7RzNK+bsVScFOb61dlsxNFmYRHpVQg7VuL
	 7R6hlcpM1K9TRA4CUeKwWVlwVYpQHz48i31FnjpnUPVGqPoYlSmWzZ3m7P3geUAmBgwwl
	 SQtvVCEnOZsQiuqRGqz/BzSbvch9ukW7bKfXW585bCVjHInm0NcOMFcsaXU9tjJ6NzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812034;
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
	bh=/04YFSwlqu9j6RfufyAdP1sORd8DfFvxWdA7ufXX09g=;
	b=w6tKs4JfdVESsrgE6DG2uzFysN7HR60ZG2j9M7z+OgK0x5WhRnXdYfx1zjgUWVxdTrFU
	 mEqSPFdqhQbHjezZIBKOSY1EFuhoDVgqBbatqyMLoypnjPP+mqk4jpqbqRUfwuGcLterd
	 IQAZMksAGEMkMNH9qwuefKKoEkzhzo8n+yt4Mst9ABNL0QqpR8O+OAZDApRtjcAF0ax0u
	 nhGxkKV085CZQNZxfqowf2AVHdgVxlzGD6ZsvKx1EC1sx8N8/+sEVjbHR3mGvQqmJW84K
	 VLN5PcGUGOlCsw6h2ssMLvZ4ISizC+DSaTHl8FDocYMs8RqDSkDxjZMXjQkM+VAG8aQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZJ7FtQGE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.51
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE544606A329;
	Mon, 16 Nov 2026 06:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE544606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZJ7FtQGE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=droKAvICkrUGrvhI3PI8l1Lqo254xr0P8n2lACPbEfiImUCl+B79oK4/TrqfcPcQ1r+CT8RFYKW/nauWaaUuTE1UF2LjUAw50z+sBFwvhF/6O9P6iBZ6ySppN8u5ZVQ2wh3p+FRwmM8BP5ryiYk7wBW1wALa+DKez8OJu6bs3sETofQQVtVot2xEsKtDaOW1Nx1WQ3T6mjiPZr06KgrXQzCG4HE8kSd9Lpbqb9WkYnOIZ88jlRuOOjwThBo0cRJOJJ33MRTaq85OBRvn/REhCw0E6nOdB3qzr8bLLgb4hgysTj4lFzpMRHFjzeyoHHqoDD8bGQkAjjRpMz/ZLERnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/04YFSwlqu9j6RfufyAdP1sORd8DfFvxWdA7ufXX09g=;
 b=UYbSUxTXlu1iL85Ydmo6EkDF6xjb+5fLSFh0OT0UsTluyqslAi1XZpS3H99R6iH67q7KVJmCpoK8woXOFQ6oMWEyGw93wj4y6fNMMUKh+mGucAIaQ2o2vAykWjt1mo+L5O4ktnN7oZLUsD6X6i4BnEyZfawmLgpdbJmZoqLbfCoOOpEjjS8VRoLUdrxdjexxx6aV+TvukffdWRN+yjlSQHLPxF4RTWWQrf8F47er+lTsRDMlMfKENj2RsoAvA0HUySSPLGYaAaxD99ZewKB1hW/hDkHcVZyUhgALyCKv3x9/KzaEGA5XpIzMmxlScwX+s1OOxBHiwK6OEzPnzp+Lqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/04YFSwlqu9j6RfufyAdP1sORd8DfFvxWdA7ufXX09g=;
 b=ZJ7FtQGEm+yEgUWYGgFJPI0b+zGbBGCNR3Dv/sFTLpHuWeWPmw06dhtd8tSbnzig8HOloXCTb/6DNKCXUEeRVOzfVUKWRYjROQSK1A2hlxYLnGvjz9c/KUNCP7BKS8hY09mjryBNFZtZ0moS1klNxaxnI0P52nhYBDaT+SJUqr0Qpb0k60Y9srnL7uKfUKv5/S0Rm1k/AY5PAn8Nyc5SWkpg5wOGoMLjuIXx6r+3zlxB2iJClsb+uNcRP+BcFixVU63B2nz/RF7WO+fdqkGCex4emEo0zatlaDt/BgaMqVHOG3s0fdx3Ft9IfyGIUqj4s8O2a6hMHvsj+Yi3cOuY8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV0PR12MB078426.namprd12.prod.outlook.com (2603:10b6:408:3b6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 06:52:50 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 06:52:50 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	helgaas@google.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tglx@kernel.org,
	wangruikang@iscas.ac.cn,
	alifm@linux.ibm.com,
	shawn.lin@rock-chips.com,
	lihaoxiang@isrc.iscas.ac.cn,
	18255117159@163.com,
	xiangzao@linux.alibaba.com,
	vidyas@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com
Subject: [PATCH v3 2/2] cxl/pci: Guard decoder accesses after reset
Date: Mon, 16 Nov 2026 14:52:29 +0800
Message-ID: <20261116065229.38194-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116065229.38194-1-icheng@nvidia.com>
References: <20261116065229.38194-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV0PR12MB078426:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b7e3c2-3ac3-426a-4adc-08df43ae3b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NrOanAJfn+teGdmkqod/sQPcLQ7hBF4f56qkVz5/c0qK3s35d+dr5QIH9pqsjfHB0C6MGcoAjzcUOsZGA7gli96nU9g8Aig5gLHgDIOUYhTe/YdRAnOhDcsVQtVmC2XHezxhW0xF6FnolapH9t0FTauGArZIn5yo2rEAloAoVgU995r6E9qCCn2WsC3fRbjz2pLysZVk+QmFnvwuPGm42UUvwr3+n8V0FryqFTFXdt6e7V/K71n/Zx2YKgP/STTLP6OwtmSvgQY5hXJWgC7rJ1RwgJWmKpmMHhez75MmOXbZA32EmCkVUiYkiTFZln6vBC/+jDJMphMOeDmtbKwncnqpazNB/pqm7ATt5bkwQ1qmqruck/g97rTkrXvycwFWl9pzlQIJePhXcGQgZ/9Rag+QcnY4qjybOIzmUMVS9O4YGZEK+xAvR47XXbGbrcOKGwVc4wZQcChwA1sLvJ2xKY/3Q9O2Yj1gENhGuN+fc4iPo63cY5+JS8r/CCqbMckr/t20ovfM+IObwekYgSDf0QQWFJ1hTIA+CJQEe8Gb/Hdpt6/ujaRXUwwJM/h1ujShx40x0cahrPmUbDTzR5zaX5d4h/AnK7GQXKjIrOdSPg3kkrSSNFmybSWQQ1zhmKOXaVMiAzbp8dZ+2/a6YqdKhKN3XZi8A0pNHIy1Ec29SgI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUkurncRvxQxeM0t4xocGXvuR6dLlSNJLeT/ye8q/Mz2RJdkb0wVLMf0nrxW?=
 =?us-ascii?Q?nwMDMkizsL7OyvHVSqKrXAHb3tyIfZCY7OCAJlK7tmm3Pu00deZSntUEIZaQ?=
 =?us-ascii?Q?inrPDMSNjXEiua22bLNWCCO0p6H5svCZRCymba5rg0FtXFysWtQy/PC3rbmK?=
 =?us-ascii?Q?izltO3zgY1lOYiNGTp377srLFrSRM4WOOsMdHxIFDaMOQqbxrv6pXZIqsXmm?=
 =?us-ascii?Q?gDMlzd7P9wUe/N5058EhkuULR8IsxKFf8AuBEQKwaKl3MNZgHEPAMvMVXeBP?=
 =?us-ascii?Q?Y9ZPkJ3aY5/ChReK90skYMjAnyF+ZPFrEXDcsY8wWT9ErKJgMBFhKLJRHwAG?=
 =?us-ascii?Q?MAwF4BsOSvXGd9YI0HEWhvLWH/xEVhKFvqyU2bQ5izu4s/sgIpi8t5r21q8X?=
 =?us-ascii?Q?S9nh2quHAyHyfO77ZbncH/A6YvP1a0coBrIHCDgZHGTdBIS1l5c/ztlVajKc?=
 =?us-ascii?Q?/hzdmoslzQ3bW8RpLS76UJv7Du0GZLCaVmEyAWYJK1PXEo4pZRnfFXomiunh?=
 =?us-ascii?Q?wVzmSVxAf8m+TcwDzdt+2suBLKi+SPU6o0ubzTBZjoUxjVWX1520xJb/Dspw?=
 =?us-ascii?Q?j1AQ1LOYF9L5wRB+VpCCUhht36tYULPJTcFDc44s1tphNrQMrzqbFNC1john?=
 =?us-ascii?Q?eD2zmUh74dCweawrYWsSMKNfMHilziz3k3bHgemNR3QmkoFZQwIjELLG5l+F?=
 =?us-ascii?Q?86Ux7YERKR42W0ssauE8Rt0BGWJiwyUgiKnsP/Mpa3kkH4SgKFr8BMloIrpq?=
 =?us-ascii?Q?mk9bFmCA5SpLtPh02phYyuO3Cd0D9xhg6OxXpXs6/kJCeIhOfwibRmD9RC7a?=
 =?us-ascii?Q?leFPtsbI2GjnnuZ7k/71sZr1um0eL90q5et5xGoGsxUxnOsB4bgf6mGpV23T?=
 =?us-ascii?Q?+1w38JYV1PVFOtBov6l/Nz/ps/0i7eqS1wtdOukyGV0VBHh2VmrlZVPPkXhr?=
 =?us-ascii?Q?SJjhA/be6sFHTjJFWUuasXd93l5TLCQk9ebzn++0pJHxZDGwPfpWfKMexK8/?=
 =?us-ascii?Q?Zv5fFZKtYjYSPnDYL7MKtOtSwSkKoj1kgnbLW+Ys/z2FcCDjAwRTUPRE2aAH?=
 =?us-ascii?Q?bkSeX/5jNZ3tbhtYHW6wcQA6Mo0Un3QgxWtqVuXcJ/6Sgc3va9K6EBVKqFpS?=
 =?us-ascii?Q?hkGglctpOoj7LChPJlM2kd7KFconL2lsJZHy3sdAPEab0cYC9Tg85uaNy/fJ?=
 =?us-ascii?Q?wCJimpl1TUNFFblp0NNG1g9VxrOeXaFrlzPnhKpXU/Lg142R2/7eWzLqBcBY?=
 =?us-ascii?Q?yWo2NrscU+VxU9JAvSvCnepgIQhy4AqBcxNUaOQ6Vs9mc9U2KizluXRQqgLz?=
 =?us-ascii?Q?KotJRT0KqvGp//9CvWNMXnMwgvYsS12SoWqtHZ28pFc/Kq4wrqhz5n0rV+Zq?=
 =?us-ascii?Q?DzB5aY6WYYZmYTWrHFoA1QU8+WWFrEX1L2EMX7uX1kb8/SSYmmaNlg8h87aM?=
 =?us-ascii?Q?D5V8KgumDtGS6qB2ddTItfWKdn/NinOlujdqL5O1xOo4Z/hOQqMGw/gbEDlQ?=
 =?us-ascii?Q?VQGXFd0wcaAfqK9/UD2Jn/na8qNwQtyBOhCROmFYrzhqhfcm5Wwdb3/fa4xG?=
 =?us-ascii?Q?kmUs7b8nj/QObQdEyXqpPLr2k5++h+l1ImBfIp0Q3SdfxIvV8at6FJCNE0Id?=
 =?us-ascii?Q?jLMLKP7panQe4pqluYHOoxYCybUpcs31j9caWZq3DY9VUaRoz4XoLfU7w0mf?=
 =?us-ascii?Q?5t2hnFUImVC2GCAkWBIOQnsJrZuTWvtQiJ+VnaYfUdmQJlPs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b7e3c2-3ac3-426a-4adc-08df43ae3b05
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:52:50.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oiau+dslxzAkx3SpoYJG3sFgHJ6jLUyD6EfhkIT0dwPz2Qdb3/WIxyD8UyFI3lSl3no/dli515ydWTM+TEvoFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB078426

The PCI core calls the driver's reset_done() callback even when a reset
fails and the device has not recovered. cxl_reset_done() then reads the
HDM decoder registers to check whether decoder state was lost. Reading
device MMIO while the device is inaccessible can trigger another error.

Skip the decoder check if the PCI Command read fails, returns all ones,
or Memory Space Enable is clear.

Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2 -> v3:
- Add Fixes tag (Sashiko)
- Read the PCI Command register with pci_read_config_word() instead of
  pci_read_config_dword(), since it's a 16-bit register.
- Reword the commit message and code comment
---
 drivers/cxl/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8ce58917c32d..dadca2db429d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1106,6 +1106,12 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
 	struct device *dev = &pdev->dev;
+	u16 command;
+
+	/* The device may still be inaccessible after a failed reset. */
+	if (pci_read_config_word(pdev, PCI_COMMAND, &command) ||
+	    PCI_POSSIBLE_ERROR(command) || !(command & PCI_COMMAND_MEMORY))
+		return;
 
 	/*
 	 * FLR does not expect to touch the HDM decoders and related
-- 
2.43.0

