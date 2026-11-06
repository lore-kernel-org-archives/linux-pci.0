Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793963937;
	b=oZsw3O0NYPSFXn0AV7sm9v3LEGVx3LaoxrcazHFuPWYhcTMxi5zy+e0UAcQBV/cJwl+N
	 T+8sY5H4ER2RiQkVX+yqc9wUVcWe/MilVM+vV5LAhFvyVpFojuyAm0bwVUGK1lvElgYSW
	 g0C0EEmRQ9xIcsu8gGHc1u3hTIyg+ZhL5WCt5LcMwDUacOoKCfFc+sVRYGvHmQPY3WPw9
	 ki1uIthjOrF72txRn6foMXc7PDPN0K+QlCmhvbxxYo8JRUoX2XnCR4PU6sALyExCzPGPl
	 3puP2rPjzUg2Q3v7meuYWPjziXY4RKC3DIvw/HwYiAOQe6tKHOZaNc5LwUIDmQ97VNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963937;
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
	bh=gTRDXeut2KhDUjRQ8n4es6NzsXqRoRtahL1aDTOK1Ok=;
	b=RZkXe084Fys0dqqq5WKQbu0inoDVptwCfoCggXGrWHTrBbA2WGjAbpFz3xjXQZ/um3xX
	 tuu/MYZfM9Vd5LMIDbquAGAOZ+BqEEiWnHWbfDUWhLLiijAt096MSvnvYtiXJvJsgLUdg
	 a8x+k19FGlRTr/BK8xiERbNNDYa22DJffvLXQRnK4XUbpn/GSIVwZglNEsb0AZRFlOPx7
	 p8Fu9cvj+WQeSsQ0SIRA145z9NyBdeDEOO1uRvlvUA7okYuaiXZDiR+yXXz049B/xaJdR
	 G3gByE+H3ytW1SOJZClol0Rlz8pFjb8P3JHr7pDTXdjYAkCk7hqbuViZpLJk/IcJ93A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HHIgoDFh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.24
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9BE606D816;
	Fri,  6 Nov 2026 11:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF9BE606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HHIgoDFh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fn1jQd23OFEhcMq42R7+u4RASzhLebRP0DybGvjluK6G1bFuRXq2R7Bm2JXwpumoeu4ol/NMFd+1ctzyAdCPuLse6EYciLjJeIXA7lpZS/z8+/gtlhpXz3HxecYyI1GWvRvcpkOQdHm7WI4lX3DVhehoj5Okin0hxs8wl/u6rl6ifUnuuL/RQBw7qavfPw0tCY9CVHBnzECD/rySnM74gJLv3C+vlsEQhdbHEQnaP5qKD0wQdbo7Lts0R2ZugdqAudjUCw/1HCr3Sw+re97EHfRXHHNZkPbCQOLaH7pRLrtWLFhJYAaWkPP+I+nziJyrMlAL+imW4dxF/MY69aFfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTRDXeut2KhDUjRQ8n4es6NzsXqRoRtahL1aDTOK1Ok=;
 b=qT/avvnwy+vGSrxGTEGX8rhwHK/5OIwWVSt3ikEdxyNW9JhrbTHl2+haRLA+9YgGAd/nF1mZ2puDHZwpW0r++8/ko5q+jWAilXOIU/F1IA/ThCMKrd64qk14QEzBTvlSvTeiNSthl7UsbZP0723P25sWbS0j6cvuthhoLgSVOY2232XXDaqgYpA2FPsLoXsNyx2YX9x65MV6HPpkTNW9f/FGyp1lk45Ve7z7NhCyBZLPGwMnvI/mMZrpTOc6KsiuQRat9ztejHkTs5ok+Qkj7vPmYdkpnxKMbKhlaNRWTqTwIlAsVnj0ye3Og4mFkem7GNl+Jp4MuAXvfe7Nd8TMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTRDXeut2KhDUjRQ8n4es6NzsXqRoRtahL1aDTOK1Ok=;
 b=HHIgoDFhF7TUglOGvBLk6wIQGXoXTLqqkDiezVFZfmgVv4qlviEWxaTFnOyh/ZWyOgnU2o9+QDPOz8o+C/T3ve607vQsVG0ZjI3iHJAB27vTgYmH5Oc7JYvEiXa4oJo5l0O3ZyALR5sqzfZqCXp1KzKCpY8ba//tl2+0bKMhJhdRHwz7ADYR2+AAjtXbc4k+LqKjYnPEGok4Zale4R94DDpIuAol77yucBVnYeTo5yu3a45w5C3fPwnfIQLQnwHtErVVzqjzNrCGX18z2qtAaQsZQrebE1nHMUcFg8CsNDEUyBA7widqv8eQpKnsz4Ek4HZQzv6QI2OrdSlUt60o3Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 11:18:52 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:18:52 +0000
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
Subject: [PATCH v2 2/2] cxl/pci: Guard decoder accesses after reset
Date: Fri,  6 Nov 2026 19:18:29 +0800
Message-ID: <20261106111829.55823-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106111829.55823-1-icheng@nvidia.com>
References: <20261106111829.55823-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:295::19) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 035e0b71-f150-4062-93fe-08df3bf7bce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261026140227099003|261102123227099003|261028144727099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	yF2il+At1rvgmidAuA8myNfgXTDudKYlnOHBQq/hIu12CQFFwdcOJSCQJ/RPb61hcKdR08E9oqw0AYCZc7gn09E8094d3DEmphQpgiQtaj0BFIIai9HUaBQT0XT7ixWumvuHuvRyJGbZdJXtOhDt0Py4ZS0RglS6773DussgTUj6r+Of/YCim1qoBFL+A9h0E2ZhRP+U98A14bDuY4Torw1x/vhCTyWW0+3yQ/yb6R4jtQtweygRT7IGRxPgW/OUMo6rtHnT5OfqtvfEb+Kd8aBTW6T17d7F1YzuX2G/vR5UtnzDLL11vTXJKT4Kcf6fINaDDXx2bWix/veIZ34fGNbmgDEoSCZVshwAiFYRN3GxFjYsoCPZSp3iVCQo6cjhmyzp9JU6EJj8SlS4Fnf0lMEnvYpGwRmPR1HyW7V1fXENlMQ1o637oo/wPTvs6Kf3K7MJeU8141wa2QTHV3uPYb7Z3fU5196njR+/54tG83S4Lcx+m59emC5Boi/lvFtod1T1hj0QqyvP28vCmSioQIj3e0uQVAj/0nYQUYZibPNccVUCSfMAf+F5Ex/2xpK9obpPYYQJB2wP6hc9cjXVlzrYz21Dzg/vzNcJKa2NHLS5plESeS8kQ8/KrsNQX0brSQdXYAoco7MseCFhRnz1K/aqBh0vWmAYfb2Qc6zJj1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4hwxCKfLS6FzNaz2wQCvxr3tQx4EDQmkzBYVu1lMRGsfkhq+WnufkEbfRw/U?=
 =?us-ascii?Q?cvaLp7xR3yOGawBLIXeGVozxde6UvEDN534DUpAWfVRdL1U1mGd1RAqzfJP/?=
 =?us-ascii?Q?+IkaIeKP1mvtM0D9ByT6j/S4H6ToPuaw7bKR/Eofr4PNKLwrQ/E6pjhwJ3oF?=
 =?us-ascii?Q?tYVnt3F1NiZAsZ19b/xwpIDtyJXUiud2+p6Pm3iwnZXVHS8oCBQvQvchgeY2?=
 =?us-ascii?Q?/SM2USpCKGArcUwAzIvVCGaF8YifuL5HhiRsuYLqzTDjE5VSXNTpIsB0O+7u?=
 =?us-ascii?Q?BC5MIYZ98Uokak4uKGKI+Z5Vz9O9sI/Q9c+rLWiEIloR4J1mV4G1k8vApW4V?=
 =?us-ascii?Q?HSjtxnkKQEsrUd9hfOJC8SeynuUrCAg4qWGoCje5rTqhLYwqGFilxrkpO2C2?=
 =?us-ascii?Q?n/m4shKj8ENrH0fuAnu6DxX6Ha85UAHUGnEqEgHRqZlnD4RcR4nYRN/8g7Zw?=
 =?us-ascii?Q?KYIMNcruJlzUrYu3dU2QwZvw0PJ6S6/3K+6E8Oo1PwDhxNLkliy1XpvMzqa6?=
 =?us-ascii?Q?PILPwrRbWgLfkRkT0kXg9wxAim7duvOCsXHyKCZqVhtcMAd36Fxsj/2j7qrb?=
 =?us-ascii?Q?laqWgbujY/OJfFzCOZjAxLrRNMvr85YyXls2bRsXAYLr8G/sgXx/jGzjGCQt?=
 =?us-ascii?Q?grjhw5T9vFqgVfau6Rm/kAdXAOf+dFuxtGxUfdfZYavEJRdnndx9v1UwGWLt?=
 =?us-ascii?Q?aVCs0dCEbVYVPJ7oe6dzL8DQ+z2oZq5Wow60L6p37oM5wjtJxUYRc/qeDQUv?=
 =?us-ascii?Q?4Ar2PUHlJnJYXd7/fby6DqV9LCDNAVXECOdr7W/rv2ZngUqLwYLFeUMDkyi9?=
 =?us-ascii?Q?5//2cEpycn5YD18ORbOojV4DRTZNU7rCWVzgDP3POgYOxoB6wKkv9LM+D6W4?=
 =?us-ascii?Q?A/kGyhEb3pm+K+giJqSXbes5bgcIcNxq/OKdv0xwXiN3A8iB+/bRqH64bMa3?=
 =?us-ascii?Q?Qkg1BLhg7dVgsR4zeqoXUvaSv3wjaYKuSNnx8uXCochh3+4GMVIGwNJoDka7?=
 =?us-ascii?Q?cixVJZdeAGdqq7DgjwVMHPjH9ywSlRU3ahvKrlpepVsPTZ6V7il1R+/YkgE6?=
 =?us-ascii?Q?fgMIfbIsESWNQOuFPNbdQgDDcrxDjpuLkjbtxk4AhouT6bTOXFeFSdJ7b2PE?=
 =?us-ascii?Q?2bd6dZYSJjlW+NlJE7YiHNMyxJRS16DhITvm9whChmRaze9rvrGshj4dDKoX?=
 =?us-ascii?Q?EbtgYwVudk9047DTw69NIvu9KYbaMvpp871WcutBHL9mgVEkzRvoMYJUQDNQ?=
 =?us-ascii?Q?E71/HfGZGg78nvWCBUqPPeXhf6IklN2cylaZIuLfOUv1HCl3HazWq15DHBWb?=
 =?us-ascii?Q?msfZqpFaGlwh6NIG5+sVYlLYQ8l2NGDxlwNV2QsKdTm/CUZNgeVIoF7iofOH?=
 =?us-ascii?Q?McfX8dV3rY5anQSm5KzfeGlytFFkT4KZTnvUyYUg2NaDi26sl6leagp0B2xC?=
 =?us-ascii?Q?zZPh+7oG94PbNJfYNvVky/Amsc/07F+++6+yZ7wYXjYcBICoT5ga5Iek8+tS?=
 =?us-ascii?Q?vpLepeebP1zxuipYD8T8UYHl1kCnYfdmlsIAAhYX2maZpKSgNY5+i9NxSByi?=
 =?us-ascii?Q?XAhowj90VNIe7L7izsCqTCjurhbOZsQcnmtEN63chM/mH42REOq3T+wZ2dZG?=
 =?us-ascii?Q?iMR2eK/eF61UQsBJ36LSxkW6PlISOIBz0D/pHNOEDaxcKh1+f76NOtT7fLij?=
 =?us-ascii?Q?sE2GdYwNT7Lw/esUzoby1AsxPQD7R78d6CLmdYaplY+7dgOa89GssDH7OERe?=
 =?us-ascii?Q?dMm+wjRAYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035e0b71-f150-4062-93fe-08df3bf7bce8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:52.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPWPcAAD04PXEBhAxIrPFFTPU3S2YtkugcVYkdH8LsppxURofGDKi3fl3L0doShZdP2tCknMjHC7DI3ExFWhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652

cxl_reset_done() runs even when PCI state restoration is skipped.
Reading HDM decoder registers while the device is inaccessible can
trigger another error.

Skip decoder checks if the PCI Command read fails, returns all ones, or
Memory Space Enable is clear.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3ed7c3e70042..ca9e2bb505c8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1106,6 +1106,12 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
 	struct device *dev = &pdev->dev;
+	u32 command;
+
+	/* PCI state restoration may have been skipped after a failed reset. */
+	if (pci_read_config_dword(pdev, PCI_COMMAND, &command) ||
+	    PCI_POSSIBLE_ERROR(command) || !(command & PCI_COMMAND_MEMORY))
+		return;
 
 	/*
 	 * FLR does not expect to touch the HDM decoders and related
-- 
2.43.0

