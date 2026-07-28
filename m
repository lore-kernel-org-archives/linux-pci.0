Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020115.outbound.protection.outlook.com [52.101.228.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879FF3A6F05;
	Tue, 28 Jul 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259401; cv=fail; b=n8aUhcUSFR1kggKHd3kFToRvpYpcxcJd9TwU5iPFeeiN7dPwh/NL7kI/SLPZNLEOtdon514mJKnzFOpJ1UNIXRwdGlKyZ250PUhX56O6yQszS3E2aEbZcjkk+mixDbS5Jr5zp79/UuVHCmpws/rNZsN97tNtTwIiu08iRMAwGsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259401; c=relaxed/simple;
	bh=Hd0XUlb8XziRpmLVebdrUaluq8LSRipFtbNhma55/AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YuZuipdQQj3CdHcLPMKh9J5CYi8umcwD04o9Ld9ksWbh+94NvVVXAu3cw+0wCb53iFZCeyNXXgY9jLXUtUUO9tMiRBEcyms6ZW6O4wap4F1lTx0T64ZLCCS7HGzRRj+VWqBykwf60X+Nqxd3FsYoFCKWlwD5IqYBLmLrb4NHtHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VnKi9+p4; arc=fail smtp.client-ip=52.101.228.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VnKi9+p4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWVKRsT8z3gxJmtGcRALgco4QBmmIVQB+RHdkA5itQBbDWtHh3OSX+VvxqDy9IvNcgY5oZnVQTvHLUuJ7W/tdkE3bPtro8GbpoBVzZKXzWPWhxDSm0wV2PmKGoBRCdCgZLNxh1/uXZOt1I4pSV+cCBUFF79PLMliXU2V8O9Z2EAdRmxB92gc9WnUObXC6iqxxwv9iJU5X06cbk2eN0oDet2dcHfBvkv3Ril7obWevRsa033dcwzrVN5DRP/o3Hi7d4KPXCS+YwAyeg1SDzHw8+17/+IrJ9ZWpRzHtKrAmvvil71LLkItTHhC+SM99DTzyklGBkIUhxx0Rfn8Vt2ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsT1TddFbkUh2C1jp65VPTUEsCBH0KbCOjzb2C/xgg4=;
 b=jUDasOI6dL4g8Tc3xG8tPOyhC6Yq3csfFRc0qTILfmAJSKzPta1raaYj8uNrjHjK5CWpM1LYpAjTKn0DWlTUjebxqdYZX1acbYnquVTRplWYQBYieN7k/doeM9DTdrgl5zuemaLD2NcTEZAP7ggEuoIZ5PO+0swMf7vbArn0miNKGQUBpYErYZz9Dh09XQ2zn7hm07AMqxUcPwRquIm9eLJiWyQoZSLzuyRYwMGmf4vyBiutvnNrdbZwyL5oFmRYRw7dlns5pw2Bw1RG3Dmy9hPUaZUdEEDut3EnApXyYppAJRL/IF6SNBFEqYVtay842GiP2O5WpTcPiNW3+r++gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsT1TddFbkUh2C1jp65VPTUEsCBH0KbCOjzb2C/xgg4=;
 b=VnKi9+p44/3wAKPnCTfg49wZsNO679dKvBgKPC6aFvxunlI5QDiXhpoBkGoEFL8CdUfmoDNUTVn04598EP6eCFTD9MseK/3nQTvkzaQh5ATT4fXIFSPM1bGAp3izk79BUjltOHXi+mb7jl8vzf3JPJYlZo+sPm2R6d75XGKw6V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB6129.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 17:23:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 17:23:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: endpoint: pci-ep-msi: Let non-first EPFs use embedded doorbells
Date: Wed, 29 Jul 2026 02:23:06 +0900
Message-ID: <20260728172306.2751813-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260728172306.2751813-1-den@valinux.co.jp>
References: <20260728172306.2751813-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 452a1040-1f42-4109-02e7-08deeccce705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iFsy78Y1VCD4MisAH9PJaLWJRPh8LLfQ5cK8X+ZG2RqIiP38b6jEENLqQa8P4Vjj66npDWOWhl2bWhjnf4m2QOt9JkkruBYKfiaAtTrPJ/WPFVmdmZ5ikYjbHyvqVlixkuFClPjMDxAXuY4z8MGr3NXdKXTS4U8r8Xqu/WFlfT+hN5M34v/yuzfLS+8oVCdzN4bqIIolDaYpTw09ug1DD0wTcoM8H7pj95T0zHUjkrcTtFbQYYgnH9wCouuJVBrD7jD3RietMckMSHmzVBwtFI/nYhgzpPvyTK5J45/h9lnrz3PeQtsTsOc8POPNmhPw3dTmEJJssjdfrpxD1Qst1S7TBaQ4WIeKUWrFlkmDrT+pfjXXEGad4zZmC4zV8ltA08wmy4JQsFT5EhJS98Habl/t6ZfKjlcZZMtEEm+Mz8XJkrID91G01P3feY0n1xVOf2YPQpF2EV+KhKEdObmQWVh9CvotA/BvEqW4mMb/gDPLgU6x7sVsZgVSW3EFoa6qX7nOuKVgpqzeCRcCHeWVjNcFjWSyB4XpOj4H80vM6uZ+w7eSS1skSD/KhsFN+yyIDVqayCQEereuDRrj5dujTSBf2GNBVTlyBqxr+kwgnOSRhagKf48lzQ1/OK3pAaloSBlKTf40HLTh20cMXeHoFcIkOZSPqQOL6BYQU1uO0bQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aErUcuGMq+kakKmvLYzQNZTES+OVN56kJqZdZSr+24tvyu+oM6kHTgkAsk/U?=
 =?us-ascii?Q?G6Da8TglXvoCgiJMn6NhrK9P2cinPhaTNXa8QreOHOLmBRKXCxLtke7mx+WD?=
 =?us-ascii?Q?bumvLWe1xHRNFYbxpb8LXcPN8qSKEXH2glkAAuNW85g+GTsvxBepcVqSRBCN?=
 =?us-ascii?Q?z5FILdfdlspKM+4mIcrAgF6eJcNx4XzSrr1KTiaN1vR3ZhFUwpdQgVbwhsnq?=
 =?us-ascii?Q?WXu8eLCnyajxHXzJDWltKol2tnAYJKM0awDV3kBaEhr/axEyUT9TiesB11Iu?=
 =?us-ascii?Q?tw29RGsoeFqs9+i2tC/LZKyySzuqrLslGffRfR9kNiZXBofBmGossspnusnV?=
 =?us-ascii?Q?qusIFqpVPn9TvFI+nVNnzYE6PrcJcDiwpviVWSW2hdihC+L7moPv4hYwX9Pz?=
 =?us-ascii?Q?8Sariax08NREunc55hLpGcQy8KcjnEA5V1ZDPD6K7A/Svu0I4CEs7w7W59SW?=
 =?us-ascii?Q?ioR9ASmZ7l+Txe4D9lMT27lpWjTs7eI6fWQlLv3Urh1gBQUda7LI+oJElHVn?=
 =?us-ascii?Q?RmyViVaysbYX4Ar7OIo90kiAjApQ9uHE0m52Q9H+kcIGAPU7Bi7jCt04OC5+?=
 =?us-ascii?Q?TRaqGslap3AiRmJmgpZyJu92YkBzesggJMUDkgHEP80JD1MM0ohZPdzau1vm?=
 =?us-ascii?Q?HXjvB3OnIaCFseY/sFZ03Ma/vOvVp3NpPde7ppngP5IeLwKkk2tNGRpAGnO0?=
 =?us-ascii?Q?dawmFOG35dLyc27lKrKiUCdMUHV6nLFFZPsrzqMq0dBnV/G6aP55KSEj/IdQ?=
 =?us-ascii?Q?Ekb3dpLyevXZyAdLp1iwQG2UwEBEerio1o0RQnW2RCP8Vdh+gfQyb9nNNmeo?=
 =?us-ascii?Q?6zsp+reqgfTDqU+YrFI6rPcq/oqAXZ6vEndBGdTCtsKXHc3ibgkkIVV+kB+z?=
 =?us-ascii?Q?2u/1+6LQOcljw1ELwCaHSpmLi3dAW9OUXZRJS/BZBVppa22s+GtWVKc8EmnE?=
 =?us-ascii?Q?+i1L9vsxQjqUXgpShGTD+CoJcg04mzhWn7OHHclLJ2onuR5jcv53sa+fly3+?=
 =?us-ascii?Q?A6JMhgHlDZdwIbBPk07EMoE8neUz0daKGW0UtPZitGJCfvTuQCArhFGyf8ex?=
 =?us-ascii?Q?F/2Dc8Qd3Xc84BLeYofE+yT1xzDfbW5hhJQRX+U+0tt1PZUIBiZxkvUbuWdn?=
 =?us-ascii?Q?0LQuVbMj3oi6ewH7ngcH7LPmX7SP0aaGuCMdPnWhh86VVS2CZUNxqMMFV6ie?=
 =?us-ascii?Q?HCdgFuo3evEbbrfaJRZx6aayRX2fXfW5/atbVZWrt1nYkNyPgJoMD0B0F7fn?=
 =?us-ascii?Q?8Vs65C82dXsT6DDhW+x31dnH11u7TFye/0KECbQsSK5vv6bvmSkZbuesqPOl?=
 =?us-ascii?Q?e9wKJEpqsZ3n8H/pKs1pnRBwFSaVrLg5/egGKqjzGaKZ7iquUZn4glViu2M3?=
 =?us-ascii?Q?1eHjqjhyO7bmjqHr43KFUXOUgm3Eb6dBJgBK1G9ShacUaJv/ZDT4gbeTBZnm?=
 =?us-ascii?Q?SORinpzWP7OoDPcIDNTxLH1JA+hDgaxufPQhpAOplGOFHgWynBmRrHt6Eo4q?=
 =?us-ascii?Q?yR8NEPkS1TX4WM0TzXfKvuXgYxSqbJPa4Enhybv4k+go+p82z/yV+rFw+IOc?=
 =?us-ascii?Q?L8OZn9+98qGwGzEkxUWmFvUQV/oT1i2oAtL685EVGSx6c3wzii5Cn6220kf+?=
 =?us-ascii?Q?MQIdMBUW8Eo7sXfWuXbeAXzmSAw0k5Xr+3ltsyPnXQqQ9t0HGVr/KrwwciDI?=
 =?us-ascii?Q?qrqNDaJ1VarfiaETr9YIY3XJfIRcih+bXmdfAxirgzdSvnFEh2NWAPcjYkif?=
 =?us-ascii?Q?HREjetYu2SBinlVpbVeQQuBb5fSqPAAVFxUTHsAG9G6J1H+CQ3xx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 452a1040-1f42-4109-02e7-08deeccce705
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:23:12.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aogHN6PwVWnJwh9HZdUMXBSsmo6HN3rWQJyrq+eD+iwo1ussK72uZRavzJzp3+8wMoTTf+v5W08IN6mJdWotDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB6129

pci_epf_alloc_doorbell() rejects every EPF that is not the first one
attached to the EPC because the MSI-backed path can populate doorbell
messages only for that EPF. This also prevents non-first EPFs from using
the embedded doorbell backend.

Keep the MSI-backed path limited to the first attached EPF. Let
non-first EPFs skip it and try the embedded doorbell directly. The
embedded IRQ is exclusive, so a second embedded user fails to request
the IRQ instead of receiving another EPF's notifications.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index a123a189b4e6..5ea7eef9794f 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -199,28 +199,31 @@ static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
 int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 {
 	struct pci_epc *epc = epf->epc;
+	struct pci_epf *first_epf;
 	struct device *dev = &epf->dev;
 	int ret;
 
-	/* TODO: Multi-EPF support */
-	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
-		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
-		return -EINVAL;
-	}
-
 	if (epf->db_msg)
 		return -EBUSY;
 
-	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
-	if (!ret)
-		return 0;
-
 	/*
-	 * Fall back to embedded doorbell only when platform MSI is unavailable
-	 * for this EPC.
+	 * The MSI-backed doorbell path currently targets the first EPF attached
+	 * to the EPC. Let non-first EPFs try the embedded doorbell instead.
 	 */
-	if (ret != -ENODEV)
-		return ret;
+	first_epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf,
+					     list);
+	if (first_epf == epf) {
+		ret = pci_epf_alloc_doorbell_msi(epf, num_db);
+		if (!ret)
+			return 0;
+
+		/*
+		 * Fall back to embedded doorbell only when platform MSI is
+		 * unavailable for this EPC.
+		 */
+		if (ret != -ENODEV)
+			return ret;
+	}
 
 	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
 	if (ret) {
-- 
2.51.0

