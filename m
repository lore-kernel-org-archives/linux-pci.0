Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC31A6835;
	Tue, 23 Jun 2026 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183934; cv=fail; b=OjAYqEEZ7sPoStT6re4zZmQvoikX4Lkg14RXyhMEZmbFt4n/5SA5KVBfyETZvrxzkQm5+Iimt6nnMnIoHlBTkHYrGYaMzyW+OHQaXFarfPx3rc7nuIGaqS02xmwKiQbyC8KWzthOlkUeD4d15cnvxclBHBoaklriSdR3RxmtplQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183934; c=relaxed/simple;
	bh=/S2hpu1VO6wk3knxXokHzmxeMobWxtKHBh+9c9XVMSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCkxfYrx00B8PAPUVgvXtF0PI8evFIyhLXra4x77pguUy3nlgfIWIv8sDAX/VM3iWIIC3vtrl1JvvnrbGPQ/9QHgE7G2B+5BBh/+Ejf9lwG9YUaIDPX0/S16JFUrYRqSLRS6OiwP6U9aqnZT67hzydhKw6rcjvd2qYJ4DInQyS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qBtwv5Jw; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qBtwv5Jw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAGyUW7U0UZvpqT9yZ9EvK1Xcnqie4VN/roT6W5wkfIt28eIM6Iv9A7ZXlPO0qNiQ3OKRL1QJB5w3y9DMd+fTElqs7a9Dw236Ypn5OKxsIbwWNHyRf5jZ0OPaDEqXCYrswHX8uZLIUQWQ9WVIFiTo0N988e6SNWWOrTqK8pY3FGvnKQRpmcsT2kjAAg+GAjJuBRizUj47fxOCO6nrVORU+CdFSN+Un92WI3LiUpz63njd5Efk3ICQT6p/Efhjx00il3pRUgttklDW5rjRw5iDoe1kH6JjzYVQ99zVZTrRyLbpJcSlnz4v5mMpibsk30FsV+6B/4Xodv0negl5Bj+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOAIc9GpzKHLQ2A530C7XuoClQvQp1mbAZawDFeOtSQ=;
 b=chgOLS7b8NgVCRocwTV2zFj/c3IRqcooblDAe5aglf1ok8zm8Dr1QIOh8cBHAL7Q8/Syjl0OvUC8QE75v89hJr5mEtrFPY4YGnuMQ729EGJ+IcDywtFZpYnXE5XVtrLGZEnrZ2HcKdOcKtgUXL683X1RH61IaErDwMOfEER54mCPcsNivgQxbpSPAy001s6zWiwp+ZqMhxcJv8ePzc7mHj/xrZDJENR0GvtQZKy1O4j4dUAAzbnkjBiDKWkmLqh6uuRCl6K1FKNq2eQO+myOvJVddD6xRMxlvSqvB1FqkksbzNsvGQZsFTXWmV40YnBqNewlfEkjcF8D7D0TNQN03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOAIc9GpzKHLQ2A530C7XuoClQvQp1mbAZawDFeOtSQ=;
 b=qBtwv5JwVQTkdo6aloY38odWOlqWk5XM4Zzv0St+2kESny5Dj54mr2notLWek62iuna0kx/pmASnn2sZAtpqzCZ71qEjujDAvX8RPQfGhU60YdSUpqgdH/T9I/BWaUOnCjVGOmBl4yPLmwJtTf2UXOcsCtjNEbT2eF+TAb88vE9vkQllSNrrHGbjhA3GbS5pIqaWk6BbR4UF5hpMExhmd0zF5DGwjvivFFkh8UZL6JFrFvl3Ws4CPmmXsHyHoUBu1eZKUbcZRrMUrxnuP/OjZ6SOndyykSDi5gLpTCBPb2i7c5iUTxeeWE5gOZsrq4GUvH5gZQheB8DvSQNtF7tsrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB12188.eurprd04.prod.outlook.com (2603:10a6:800:332::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:05:30 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:05:30 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V2 2/8] power: sequencing: pcie-m2: Add PCI ID for NXP 88W9098 and AW693 Bluetooth
Date: Tue, 23 Jun 2026 11:07:29 +0800
Message-ID: <20260623030736.1421537-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:295::8) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB12188:EE_
X-MS-Office365-Filtering-Correlation-Id: 472d96c5-4c78-48b8-c67f-08ded0d44884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	RA5n+0Xy52zGCvL0E1ro2bUqbLyCXXtIaV3EKjgHejgMTZNUAvBebMDi0Py+pCXiDsBK5BPah34KjXg8Io5v/1DUZceI3L9MWvHXSeShtkN2Re6nJNxnMNRf23Zh7d2DIWpxIG+v3RgdutqE1MSGLiho1TWmQdDBBUODq6HsvQH73zEU64S24bEdcWBXd/013gj1X2zamUsmQ0uDUSsTKF74o5tTMdlbvjdnCXArEiKMZnGTyoQB6ES2Q+3UhfEjPXcAo7CjvgM3vFx6dNeXLj1X4HZd59uFbug/tDYxPEN1Js13+L7MUmoHE8gynHmqbS5QNRaTX3d5a6GnMRXtgxfnOvsWweKx+vw6kkeUXyR8M5sPR+s0PHNkJJsGgmaMJ7sUZ4+Tpr/gpPVgODTmlEca0H3Yx28cf1U/1sFxL/UoeyXRTWBhLVpgKtsZXPTiL1J0dlLYDTKh78O3uCIwNdnARueS4EVSslE0UtgS0NvP1026V5tVUvl8x7M/P45xAoYqNeTxU1oSK1i2MKTTfVHnazj1ZRw1JfXpLDFxiNfDjJVi29IulyqBoa0Unh+AL5HgGnscFTLsc0Vi5t4lQY6hX/CIYLIWmZODlzVl2LP7JhUg2tabDyn9uTw1czAzL75aEe97oKRYrlmH42XoJNY5jB4h719dQOSNXERPKM216q2LUWqhkm2WpEyP+4zfrbIuKsX2KpGnbXyvELi0Aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PiHXeTvp41KopNqvKSwgdlPVes8O91kJ0fI6W1NDboEWGRDdXqshw8Q9y6GG?=
 =?us-ascii?Q?zvo1MV4waPWefuqSBD7oh5L4UPfC/n6ICifwmGq7t7RMpvcCFkDMKZAtc8VQ?=
 =?us-ascii?Q?rF9ZhcQrBwIuYlqDJsAyTZoLPcpOvFb87wCUmFvyghwdJ6K+2PlrYr0jVDD9?=
 =?us-ascii?Q?RmCqDYcsHmmje1obuQe9i0hOFVwUZYvmMbrGEmKwhLZm5CT8hU8t2FAkp4E6?=
 =?us-ascii?Q?SeAz9G40ttYDZdZIkylW/+fH5//wB9Ew9qkFLm4VYadjjkXwrz/eQthg+XCm?=
 =?us-ascii?Q?C0Mq6CrhmENo3DEBR8+y+2rASTSeDjzvXDQOahoi213XehY5GFMOgUAMnjzg?=
 =?us-ascii?Q?DQcVpnYSpPXW7WRFLGTczLE/TFvummgKT2dNV2fjuhxHv5mFQoPgxXoXKB9k?=
 =?us-ascii?Q?0ryhFnwfZa9VHUWJQnAHGeOCZxzhCzPRxYb/esTRWtmh/7CjpM9EPJRVgYuG?=
 =?us-ascii?Q?1DiDtsAZz7UOI/7z6Ocv4mf8I9jxYgX4LVu1MpLp7vO2bAR90ukfiSTEsKJu?=
 =?us-ascii?Q?9drcb1r3xUUi89ifTFaU5mxL0xQymmw0amIDBklXSRcuG/cjek2Cu3aDrOiR?=
 =?us-ascii?Q?zhcd+I8PkXgDcR3Wd2k7ORZTGf8N7rrgTVAS7xgRaeQeFd/79/9Vjd9gN6fO?=
 =?us-ascii?Q?GslULh3tPrwPk3U2HSK0VYBnQwW5oYLYOx4yJmWNfq1q8HE4JOInrgsVKuQ6?=
 =?us-ascii?Q?JmcKS6o5zgSypJwvnthZuZibWZO4IB/2wPP18du5/6g3srX4f8/Ym6E/BRHF?=
 =?us-ascii?Q?UPQrHS4eqBT2OAAewyCP3esotQhEz6BD51xolJi9yuRtl2n1kXKtfNjb6jxc?=
 =?us-ascii?Q?OFYjrZ5LxuKmKkuCNwG6d82YM1DNETZMVc8YHFZRPh62LALxfy6uAX3Jmv5C?=
 =?us-ascii?Q?9gCOoZy4WgFZpE9gY1E4mhuK0/T5yMx7x5Ug5zngqkhSDFX5quGoSLFwus9z?=
 =?us-ascii?Q?+mJv5iUqjtFfVB26VDRwwsd781bX7/7+b4TUN76v+lrHqm1xzMvr0VgAEO9l?=
 =?us-ascii?Q?OtuCerUe0UX2PAiyIeK8Hfvs852/PWp7kAKSo1zzaonT2SYm7sc/ERbdy86f?=
 =?us-ascii?Q?DgeIszfyUiAyMKVxtXw+RBNNJskcSZz7H9Q0NDFqNlFhFi4hXesMuJ8L7ryh?=
 =?us-ascii?Q?NsFRaBems8/GRfTMrfsjftklToz6AF37pKGhjYjq8B6P2vJxHbT2UNQKvA6F?=
 =?us-ascii?Q?24xE7Y6/1tDbSmWYpqyZYYzGWQ/RZ4OgVcrzeZ5V8WWjjHCnat47ZrcNHBY7?=
 =?us-ascii?Q?fCR3XcDMKkc851Rzapm7ugusIsdJfCSjfq9k/KSXwdmE3zNYHq00pe/k0TD+?=
 =?us-ascii?Q?nj2EFmKIacFu1Tc6ZtgJytRRbq3DSqfGc0giJwr7Qk9bqINo3QaI+TOcdg5w?=
 =?us-ascii?Q?tiWYFfnHlZUexKEgcMn77L943rXph+S+SQeQE2BGgcruXKDlRqbloDoEg6ZX?=
 =?us-ascii?Q?tcckmx8Ws0qEoH7BgQSAqGuEgIVQgQAgn0ewMTQe3oAY0GvOuPuA4o5qPPns?=
 =?us-ascii?Q?T4On2JrSx92F8724efW2dEHKDb28rBkxngEJhXv2TA2jx0+12LsCi+aoSC/S?=
 =?us-ascii?Q?iGBNDYhxT9mPejDSr2GCmn8/bUYY0wsOjgovUE3JdlrJEdUaBhCtZKhwKdWI?=
 =?us-ascii?Q?ooLfF3ABZ2kGk2Zh2VcLb6ggkDSvE2djbHkHjoA35ORzxMhsdVhVRuI9nv55?=
 =?us-ascii?Q?updVKtm2XgWOKolK05F4oM7ww1HBVBCB3XAI9MPyFrAbBFmo1mZvgGpIPGhY?=
 =?us-ascii?Q?VvnHYxLUmJz8oYFZn1htN6OTET4NoFAVcN2YYpMN19wC7QND2JNr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d96c5-4c78-48b8-c67f-08ded0d44884
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:05:30.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2p6hC2yOFG1R+k+/tTo9uPJaBWo25LO6BdW7m2tSDfsuQNGeiUooRIXz7MJcdqTk3lNrnVbG92mP8XeIJTrIf+eb25sqr8rd0xgIHQ2gjkiaSk8MzLE7c/4cnj58GU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12188

From: Sherry Sun <sherry.sun@nxp.com>

88W9098 is a NXP Wi-Fi/BT combo chip with PCI device ID 0x2b43 under
Marvell Extended vendor ID. AW693 is a NXP Wi-Fi/BT combo chip with
PCI device ID 0x3003 under NXP/Philips vendor ID.

Add both chips to pwrseq_m2_pci_ids[] so that the pwrseq-pcie-m2 driver
can create the Bluetooth serdev device when these cards are inserted into
a PCIe M.2 Key E connector.

Both chips use "nxp,88w8987-bt" as the serdev compatible string, which
is the entry point for the btnxpuart driver. The driver identifies the
actual chip variant at runtime via chip ID auto-detection and loads the
appropriate firmware accordingly.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index b5ed80d03953..e3ba9169144d 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -186,6 +186,10 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 }
 
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x2b43),
+	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, 0x3003),
+	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
-- 
2.50.1

