Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020124.outbound.protection.outlook.com [52.101.228.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900F373BF8;
	Tue,  1 Sep 2026 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244376; cv=fail; b=XjhwNFVgJiJDhQdXdW0ZN1B6AwMqWRtlPj8Pm439tLBkEjAqCAvljfXRtEP+63JJsiHU88xvLcnHox1GRJbAAKMUc3zfuc3Co1j0zuEEBthgBesAxICfOiXvIKQs9o2hNib1gLp8Fi/rJe5q5UKH1DHCrPcG37a2Bz51OlzBsxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244376; c=relaxed/simple;
	bh=AsJQWUObgALc5GM7LJ1cSCmMFjv3yAQ3i2g90CDimMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BihWJGHUcqrdAhsmi5zcZWnVR8ssAUZ0NL1A4Ioko/VVbtW8u4lyzb7iUP9Km1OFlJM1SvxFnR38KUW0aodFZ75dSatjxo9CtLkyRBBTxjJcUVBn0jvgwvHN/bzo3vAD/4+Ma5CE1Pax3i7LK9a2Eh1Wh1T3CYBaqQaXtYZYNHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wATH5oVg; arc=fail smtp.client-ip=52.101.228.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wATH5oVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYnw3ErKexNVqEuhPj5OtDmA7M/3e8oe5o5IGlz5r0g6Moa5RxOXxe2+jsQksOPPqBKbIpcC/uzM8kHwZIpPtZTyPnDsUUwnDabKmcY00OGzgK7j2vxAtB6UJCFE6hC1qzZ27sdSN7BE7HEhgWHcUoErj9uHF8hX7rGpdxJECUOzmgAaZHS133pYLdWkbCgEiNVYfIG9+1nDRqWF8k6MqZq0WxgXv5I7is2CQjXWteUJ0mCAomHgh9zcX+H6LheFrStiafpDV5CVvqv8+Q67NJboBt8aR2hI03IL4QBwS+zN263Dw7hlp+AOf5q3tDwWFGCLEuR2LNCR6XV5ZOoA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRL9rwvkBRmnXxytV6QYKMJdxRPMfURhXyeSEYdZiHM=;
 b=t57m7P3yqGZkPcdICjQDGW9xpNMc1Akon5Zb5Kxo2pdbDQ8tFmhS/aX+EmrXpWaSITkOrYE3eqD4id7U7lU7i6UhiTQJ4A00bXvqINIpTEek489XERAxBKonvVaxPXg4KCzak6Dqaz1sPQ/4iJyvFsrvmBYGQoZFet3EuxVq1qombesARps7vuznFHl/okZEg891VInfAHrCn/OpbwsY5V+v9qhcAvxif31cO1SvtCQ13HLTSy78MCqZxfdDYB9pLLMChRTI1T02Fpej+QQ+wVFUjRa1sQTBVXCbMp+vQlsjXhM0nTT6Uk6mWUsmeLWArPlZAJvXGasvoTeSUfY6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRL9rwvkBRmnXxytV6QYKMJdxRPMfURhXyeSEYdZiHM=;
 b=wATH5oVguHbKwQVonf03b6ZFkcIgtF1/l6Kpk8NLKIZsvI01ngnfn4qZdkXlrTBU9zNp2bQwvZB49gFAHtj0Nn9jFCiuMiu1od/5wpthj0Ff/gWMyqEQjjtI/DcwPyCg5upQH8ypD4ARX7UOlxKGM16fgCs6b+XXSFljNIn8/Hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2096.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:188::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:32:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:32:47 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan
Date: Tue,  1 Sep 2026 15:32:37 +0900
Message-ID: <20260901063238.631166-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260901063238.631166-1-den@valinux.co.jp>
References: <20260901063238.631166-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 386ffc80-aa27-440d-a386-08df07f2d6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|376014|1800799024|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lX3yOnCGjYP77KBBP0Uhy9UP3x8s1Uevi7+5LVDVmg2Or5JLFpnS1Caw5ivBn/p+z9V7aJ38Ilfe3O2WcgBDEAJpPfVmNNGxVhv2M4jEN0SDKMRHUAbDtkief6amHT4AB8pvXEK88aW4yaVmNXIxalKmXOEkeerJpHOIdMe6dipNzjlDbzz/ykatwajWawalaKpH4WlxaOpJuw2eIwa8IzCyoez7Vp9hQzQv1aaGrfCJ16hc4uISWSHzQjITyxFutP3P7RdjsdgPtT2ArU6JTvS/fv2saiZB8PSgZCxsnUO5MftJmjG1RiZmJvosRaxxKflk01CTLK2xdIm36MW5Z5OQdPzBe5UEjh4MuqtZHzOxBPnO7eFb0q3pIlq79Hmi6QNtHXd9YG0txWfyPD+lN3MLBOpQXKpBQq7/+OhyqXRGbrvW8LLm1sior85xYSbKrsGduHRAXT5MqtzQEUIfuBZauKKJfy+o+k6VWuAJI773x18C1LRhISEnrYN2IMx6ShENiKwLH5UQmmiGQH0ZNoOXbmxGNGVejM7Q6CsXmZRBAZwmVv6l1/WjmdIUjSBeCBnHQ5LRRPTekSBAX0lFsmxoH9X2/zB8FyiPU1b7YWfJxVk2L/TjgTfqp/LkpSE1Ue9EwrYdkvVzbPeXg+Ye1ehYIODT3B5fK4qNSbs0Oe4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oVkc9+9PviML0xz98GnhWg6kVr6Ngq+s0dvoiUD3wT7y3T7j/y7Ke4NSjpMS?=
 =?us-ascii?Q?zf1vnEEWgIIEwwNAD4eBLfdNE4tqEA58635kjIxHvun2qLYqOlSHjcd/UcKW?=
 =?us-ascii?Q?e8opaIvVyv/nZzIdfzp1obgSyzQ0BZFEXS01wXUdBALZWbR5Jv97UQ6uIe5c?=
 =?us-ascii?Q?RDrWM0eQkEBTUz+oA/zoKGyAjMF6geYiybUAQiUJdh6g2/MU2I7tgkeZAzFb?=
 =?us-ascii?Q?u1S3v2Pj0F3ts3DN0V2xvdJBDPEHFM4Vdy5ywXH+kIvKhe49ndBzfGWgF/on?=
 =?us-ascii?Q?KR7n4Oul4ExwFLaRr6VTqfYVb8ZpkiS+gSnTz/OVA8aYTpsoE0jq/7PM96PN?=
 =?us-ascii?Q?5IlpUQy/siyFtsI3LzOChYz/FZdEmF8krruKYEJ5HWNpJPz7GOFedIPel96C?=
 =?us-ascii?Q?/8yNXWCNrN4nsAPSsaXlIjgnAi9pOUzhm9LODsmxSZKtoVufVg5s3xdlVIHw?=
 =?us-ascii?Q?yvupPFZWNrtZ5ud88T6tB9aj/Wu1+M8AqscPzAhdqSayUZ+AP15+g4Tg3BuB?=
 =?us-ascii?Q?SxoAxG8ZEGK/lqSBK8hfDLJ7ml1e7CAOKxMwxQsue2JzChu9Td/8vys7Il6N?=
 =?us-ascii?Q?zbQbeg2rQCdj2jqsdz6wkA1OSXTiMDSCHlz20O5t2bPuY3jQ9LO1J84dxMYN?=
 =?us-ascii?Q?w/og4f7fy+bHPY8P5GoortwcFEkCPX624zif5Azh248RtH0KzjQ8E1hFL2G6?=
 =?us-ascii?Q?AoBGXZBen/02ShfJ3hgjO4HEKRpgJ7ly0RknGyBlocLV3KrpgA0v0gRtqdhl?=
 =?us-ascii?Q?OFOATWb0aRS7M9g9672/aamxETQAf+CIpMW8G7ds443XkLMSgSq4TdWXiD1O?=
 =?us-ascii?Q?oG9Kyuwu3osNIOS7kaBYdsowwj4WU2iIFd7ANQilxVQF0yFmRzlOvqtxalKI?=
 =?us-ascii?Q?0ViCzickWg53/CO0Pdy3HVE4Ph8EzxgsQebq5jT1vEJkK6VxC8LdQBMC/KS/?=
 =?us-ascii?Q?2Ji5UrD0WLJqX+XWwurKzUgazx41As4Tmjiwd1XPK9WIB9nc6zZmKULAdBol?=
 =?us-ascii?Q?FQIZ5FajBdML1woM0fo3C/5K1yZIBL8Nn/3mDC+jM8wqjQ7QdvNT1wYYm20r?=
 =?us-ascii?Q?rgU1fSNXNmPyMGMVyAe7vq8vGBeS9XG0I3ay0JMRY0WSyoLtLrzdiz6c8vNo?=
 =?us-ascii?Q?+RUYveK2jV1RqX8Vfmu0YVbkqklS9rS31Ysn8YFwqc3a3fOTGAh04V9EHwwZ?=
 =?us-ascii?Q?sG9QhQtMsIo7CRUkNUZ4D2Exf8+ZXLvrAsD2pBhpq0nLWCtAP5VwK//0gTM2?=
 =?us-ascii?Q?BdtkNt9UC+xxxrNDM7uEAKptrN0V6K+ecOIZWuV6enn6bwOevgdvmfIclUXf?=
 =?us-ascii?Q?yWpiXvIbIze1YN4VvfTNud8EKHTfipH4p6HePTCmUkaaWn/AUFZxtADvvWFH?=
 =?us-ascii?Q?VU6tNwh+U58uAK7AiVj9Mbi6/NUyWwo6JX0y+6Ql8lojN2b8OFl2XDhQ+Ne/?=
 =?us-ascii?Q?f6HyxUB7Xiu+zf7EKV3yoiBnIQewrG6Vz9cJPut8f07OlFmQLskmLKPfLnh5?=
 =?us-ascii?Q?rXPlVofgoBNx6r/a8tCZxYPRJxx36EUTtN6uNr9Er7KjfCRlAdPxWwyJfdIn?=
 =?us-ascii?Q?PgLwAAPgD8F1Y5QcG+wSEnoNT9Z7ZCHPw2tm4BdbxubGh+87EjN9i9UVj2oz?=
 =?us-ascii?Q?xyHGzg1JzfIqcR6VSYt/0b+gJ/hBQ+7tUjgGItxkVs2dbjvgsQdWdH/y+oG7?=
 =?us-ascii?Q?FFhMDkuYpaiRjpc/2YBW6CdkivTjYcCfEwgWDLQ+LL93ZzG2vAvfjHZO3mFB?=
 =?us-ascii?Q?1tYBHBgRzVhQnZpbIVXrZ5wC8LK569wPSFUIFxRg5I+d52yata2t?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 386ffc80-aa27-440d-a386-08df07f2d6a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 06:32:47.5205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/nK0pESE7xAQ7TY+gOlp8K2XVXk7LF2hECy9KDpsksaT1dNvEQG3G4hQNMzApD0NEnrSlU7+Wcf8kZgFHNg/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2096

The virtual PCI bus is scanned without holding the PCI rescan/remove
lock. This can race with other PCI topology changes.

Hold the lock across the bus scan and device addition.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/3tgrcel5fl55ulf3zjya4fkz4t2ms7iwwjif5rnzn2rafsydd6@i4e5etm7uqvz/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v6:
  - New patch based on Mani's review of v5 patch 4.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c3caec927d74..412e8cc6fb1d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1332,14 +1332,19 @@ static int vpci_scan_bus(void *sysdata)
 	struct pci_bus *vpci_bus;
 	struct epf_ntb *ndev = sysdata;
 
+	pci_lock_rescan_remove();
+
 	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
 	if (!vpci_bus) {
 		pr_err("create pci bus failed\n");
+		pci_unlock_rescan_remove();
 		return -EINVAL;
 	}
 
 	pci_bus_add_devices(vpci_bus);
 
+	pci_unlock_rescan_remove();
+
 	return 0;
 }
 
-- 
2.51.0

