Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794811960;
	b=zJsJR2DQxr+bkBSKN5POS9dCP0tjP6gGqzlibNWSOt056m5Ti+2JHDP4JANzS13w5BGE
	 4+lTZZ5L++lN4wU++WOpAjalbt6YP9Y2EpJrbXK/ryzM5L68Uom/m9CCve3+KQxCYGtLN
	 n7Ew52Xjtj58Rp20GRD4HvXs8hJcAdWPsEZa2V0wtCSh6/+a6PiJ3TYYIEoA06AXeaOZy
	 0FRC+0NGtMpu+4Zsq7iYmCYz44teaOfZfVDy5mrw2NXMnFPnDZNHalJ0MtyWtRmgcWUuT
	 i5ysurKREaPachboF6I2IOWDFxWOkabDbd2sNCqp7gUeGqWXfVIT4+EJZ960QrEU+BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811960;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=04rq93KHt1yRCn1cWxw0lWVfs7wcq7Qp3MwAGU5M3uM=;
	b=X6wCtAi3ruo9whV3LGvIm19FXYtgFq0G201F8C9CRSceWWsEJNdoKrCXsMZ6BoCFrea0
	 l024ieR5TR8kgqGJPF7GqBHtUR4xZyov8t4mNlNrNn5takoQcUFdtc9ko6Jjnj9l4R27X
	 yTykfSBat6zsC02ZyeV6B6KAVN4bpTbjZeLYAAun3oDT1gx8ZY6CU/86a9LGYsmsKpud6
	 19VQY27cO0ULrcZz+NeX/ZJlyBoEmg1AwdDiL7xDHaux3HTN3URj4TIZAZs6gFTQMcQOX
	 Z3irfT0RdYyv45IoFUswnsrI1KbB/JMi5ZKM5HlABYh6gk1d5A/NJW3SJt46vpkrlmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="KKWP3Kk/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.9
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D1606A31C;
	Mon, 16 Nov 2026 06:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 234D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KKWP3Kk/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuJO+IpPFqP25DJnSnrZDQp8lkFPzveYM7taokXi2PCPiEKgHBXqqI64LBgxqGJeOnWovN55naOJxpkbokRn7iJd+r4IzfJnwslOLHAoaEXyTYad983Nl+EasAVImPelA+26/wAf3XNGrNdIkW3dYqEkOYpdFIhtcuhTm8fqJGLOTiKHTcyuyDqsvXAiwuqEPrdQ5qPbdE2WuItwZb2+0hBTrSw4ZJaZCoiJp3ogOGveKOIy25nHCO++u2A/DfuRIK1PSvUBccy4Ptu8KGEYm18DbRhztgs/NWxvyp4RSe1umaNmTIlnRqscj9MhSthOLywNHXXkHecKLh5OoqG8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04rq93KHt1yRCn1cWxw0lWVfs7wcq7Qp3MwAGU5M3uM=;
 b=kHPLqUnAsEUhL5dbS52wc96ydk6lG3On/Gx34AhFM93L48gV8Px2KYeiYtAFt9I8HefD2KzQ2/kCgJsSQGl6eesetyuNc9FBz0+xFQYM6eGvhlEuqdw1fjT5WAmGhm82sZRgKjUOTJMMmGnhUdtLv1p4inH4xHZf4e0Mxc+EJgaKqOSmXi6gX0LkEqjGssrKgvlaIIiaiBBcwWazezOJRtQV6xgyfDbpPtb2ztE6oMFNxlTXnC2xbjekKvgariVzZma64tFIkWQKuUGWvIJb8+pFOK8VVxK5++9d2plGMa5EFf6MiGh9clOe3ldo6DG437F5lZD7Tf7UtC7Eop5evw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04rq93KHt1yRCn1cWxw0lWVfs7wcq7Qp3MwAGU5M3uM=;
 b=KKWP3Kk/8fQ6M6+AgsEA+zz8ELelQG0X/bh/0xcU9uQr34VFVkbd/7bB012T2tdnwQ3Szj/Hp+Bq1YZRBEyhXgiHdfXP9c+CB4HynTC3lBJUvVVQ3bzCx+eCIurtzMmL3lfxqF2By6coYnIug6neihp0LNYgwXSbtD4GOTy5tiwJ7XYiA9JQFqDh4ZvjY+S55odK80ExicWYLlIW2VvRkKJTndzkBYdlys7AXbruO9AIlJB/UJeUm5931VDEGjKXeKy7yduBhDYRcxX8+tDEGXzoSjRLl+I/6nQhV6np7yk2iJM18sVHqN3ANZuYut/pTCjF7F+FL14IfYvagaEgCg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV0PR12MB078426.namprd12.prod.outlook.com (2603:10b6:408:3b6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 06:52:37 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 06:52:37 +0000
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
Subject: [PATCH v3 0/2] PCI/CXL: Guard device accesses during reset recovery
Date: Mon, 16 Nov 2026 14:52:27 +0800
Message-ID: <20261116065229.38194-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:295::15) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV0PR12MB078426:EE_
X-MS-Office365-Filtering-Correlation-Id: 619f273c-d435-4f02-d021-08df43ae32e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BBOnXaYfSU+TgJgFRtVteY210gZOPjyCguYOlMazqGbsP7gr85M3LQw8V3nxC8sU05/I72F4G+tCGDVE+fKGMcTjhIWKZSEjK8cNTzJEvCvTrQ2x9s0Qo31mUQ6wJPeK1xVVUG4LsH45acLZtyPZDDfV1+CuYC/RE4xwI10QWauTnNTX6unoZpyJ6i0d7hyIBNebGFsCKZlydzKhCqJqcziYjKjEiRKsy3yNlDSwrxvIbBPzBiHUY+Lt9Xh2bHPDu2M8esTwIMjko5QWNlXR4VrgRkvX7s3hRdgvM5v08WqOr0bmsigoSsDKegbrY/xNg8dsa9heCNBaDRB2SG4aeNWI12U7vvfnuYGDVRhgv/+E3g4gze1Gmy7pjrGunQyBjVhmvyDPXSH/HlBWWN93cMhfI9U1EkaUeG97pIW09P6a19JOdEeYvQ1xqpbHwB/69rCLdfT7rVjB+azWTZen/y4P8wnAvBULk4prkc0yO1Auea97+FafNGU5ZHJDaFNhdy6lJZYpU+TGVW2kXUCtnbnyQASeYRYUArOp5jr/gKmmiuUZilJyNKzXgvzOJLotHQ+ocfv7mOg753tRYTLl9HhNLb6ne4ec8spkW8Dng9HoaDI7rQPeX3NEvgg5EY1iGoGFY8UynIfMpaBHJicfPjnDf+5/e9gRdDqHtpXmbUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNSGYPaweGVltcZYkrzKbIu7FrzRiRZuGebw+5BYSp+gWLH6VOQ7kqT659Bt?=
 =?us-ascii?Q?ZEFzB+ZhZok1CiJzyf2YKp0kQmri1rM515sJGG58DoaayxPW/YMZP6YnM9F4?=
 =?us-ascii?Q?M6fFmSMnB3fMIIiMqTqjMJpcSE4Rdd8WerdhjFBrDad70XOMUxBSQe5pKGA/?=
 =?us-ascii?Q?7vNZimy80R299khKB7N5FBOw7FhtGUCYigubHJy4UtNNAcGWYa1PSmpVN7IF?=
 =?us-ascii?Q?S6f5OzSkHptZlJVHK89EcUL7ITpN7c4sWYGBF5GgFniUO5jBTu9U1I58Y8iM?=
 =?us-ascii?Q?G9tkIyDD1ocME1ha8DTUVF2mrAF6fPpZfhRT4Dmk2emn/L+S7Of+9ONWdO8m?=
 =?us-ascii?Q?ZFA6sQ6y4C8SW9y2yJYqjALoFGRoFcPd3HEljFtwiZHyUWpzznN5rOOHLgl4?=
 =?us-ascii?Q?FinL/XvDSsLyyw+xcn1kpryT+zQTTYILSzzwa4QbGVo+9smV4nYBLujagBKl?=
 =?us-ascii?Q?Gb3AhsW58oTFPbBPflbefzPaQO2g4HOTCXJZzMfd4OHkrsHmazWUkjzjeh1i?=
 =?us-ascii?Q?mVXNKtOJs68hu6EWDiNmRQFE1Ao62xosZon5/uVuBtjBiB6ehg6VR0BugKlc?=
 =?us-ascii?Q?7DrBZcQp93nYS69PdwJ6bbunHxH+CQSLaoC0CnlceWVnmhvbqxTiGZjEufEq?=
 =?us-ascii?Q?dyNjLSy5q55V1OAnPY+cGVqEef55RghAqXihiYjKGBTk7B5952Vn/07beDum?=
 =?us-ascii?Q?BeDP7RsryUpUyipSudbV850PBchBo+cyfBG4qLX+yxWOrbIvC6Tf7zIO3zgk?=
 =?us-ascii?Q?CRyG3a4y0XaMxtrN+FfTTjpYPxpzyM5NMblpxxRW2v1X0GM37pDyvFTzST0P?=
 =?us-ascii?Q?GmtLRH6JkUdLOF4waUdhUbJY6l0OjXn4DEEIb1s18ssfpvXnZwHt+hIcazJp?=
 =?us-ascii?Q?/vXfECaC8ROIoizcxy3871y2pAc5k5UM6/q3a0CvIXZ1ZFCRHO+Oj0rQDpLV?=
 =?us-ascii?Q?govA2vAWyeE47w7LSFTQ0kN5s+mLFH5f5zmGDCKYHmPtjEiTRfW28gNa/cQQ?=
 =?us-ascii?Q?5eGHtGJBSexh/5dOgCMvMGvWxOlle/UYQusKY7Ma6FG2IfF/T+6PGp85PFW4?=
 =?us-ascii?Q?d0RpCw+j39klRFdXK5+iNof4gF+RWdgBpkXR9GJ0Wx3CDrcmb94eZFxKsIV+?=
 =?us-ascii?Q?eX5/+J1gB2mn5IEVg4al05pWfLHIz3i4YzZZlcoZbAj3lKEeHhpwiSw9DDEc?=
 =?us-ascii?Q?D5Hqf4o0OPJKbUsVzlikyr/nycIIFJToJ4TicadH3kMsBaAnOKFwtd2a+Dg3?=
 =?us-ascii?Q?mtKHJpK+Qrno+x5m9PHfMq4JIN8C3XuHRynz4jKYza8/hIZjES9K0FqElrk6?=
 =?us-ascii?Q?Zof5YFYM+Fs9h+aVr8DCfmHJYWyRNb36rwQ3kenZjO6nEgp0oPKBe6BW9tNL?=
 =?us-ascii?Q?VPc38ZbBfWplfu0dPqoRmXtJB22YGQA9nuVvBB4g4/8JhBwG1YsnlPk7QHun?=
 =?us-ascii?Q?kWDc/6f+nLly/RjoOsmlREEOR4Y5HbM1FRnSDTRnerojT1oAzYyZ+E5BqA+U?=
 =?us-ascii?Q?tfVUQA+mE+vs+0la4iyDBBL0z8cYgSWDllN0BsFh1tIlSHbBhLAcjxbqtfqm?=
 =?us-ascii?Q?9p/ejo8rvksncywHcVNHfz8+JUREO8U8iRnm3009nyCsss7LM7psgWZrKmr/?=
 =?us-ascii?Q?62s9QSWSlgs/sMtpJXc+lhICMhcdPK30KiPii1efNsKJnK4tHSAdZFtVQPOH?=
 =?us-ascii?Q?7BCDf50pFefJn1AYzAnjjJ1+ch8wsixuMjwFCPERO/9cfIEo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619f273c-d435-4f02-d021-08df43ae32e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:52:37.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: likSvQsUx+atZr4yyZq/45StUYLRng3Zo0JUzOwl0gmp0e1Be9Ve/xFuKkn5xkWJx3fw5MOMSiE9HrA07acChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB078426

PCI reset recovery may proceed with state restoration and driver
reset_done() callbacks even when a device has not recovered.
Accessing the device in that state can cause additional errors,
including DPC.

This series adds checks before two such access paths: MSI/MSI-X
state restoration and CXL HDM decoder checking.

Patch 1 checks pci_dev_config_accessible() at the start of
__pci_restore_msi_state() and __pci_restore_msix_state(). If
configuration space is inaccessible, warn and return before touching
the device. The DPC containment was observed on the MSI-X table
writes, which are MMIO. MSI is programmed through configuration space
only, but restoring it on an inaccessible device is equally pointless,
so both are covered.

Patch 2 guards CXL decoder accesses after reset. The CXL reset_done()
callback independently accesses HDM decoder MMIO to check whether
decoder state was lost during reset.

version 2's lore link is at
https://lore.kernel.org/all/20260929020405.9724-1-icheng@nvidia.com/

Best regards,
Richard Cheng.

Richard Cheng (2):
  PCI/MSI: Skip MSI/MSI-X restoration when config space is inaccessible
  cxl/pci: Guard decoder accesses after reset

 drivers/cxl/pci.c     | 6 ++++++
 drivers/pci/msi/msi.c | 6 ++++++
 drivers/pci/pci.c     | 2 +-
 drivers/pci/pci.h     | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.43.0

