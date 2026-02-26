Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277E396B6A;
	Thu, 26 Feb 2026 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095356; cv=fail; b=LbduRzBCEnNyQCS88TDhshhAQAOeOJsjNC5NiEpphu53QLUN1PWGeplXB/ow9qrY018lFBwKLrrY48NPDlfpj3lzafHIs6hZverGZXbRsFRiwDRD72j0fAjfSWg688p36hovmQ+ZgJ5bwzuSdFkvxhC1LO6dAZJYawK6Whn2c2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095356; c=relaxed/simple;
	bh=gdAXRhIl4rAiO86c4mQtwJSAlJdoSahM9kdhybYmaIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgbD5bvDdUo2eqKBYqqWhxPjbwqFy3EYMtfMdLT434dGMXPe81xwmqLqDhmsMNDeAg3HVk2VWWjkhp3Zf9gxzIJexvjN3lnqKiG+0pXHgxVv0KYnI72BKIn7LOQe08/NI0pxsoNV5NMsz2XxtfGH6a6jrRky1JBouR0sn98Q33U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wRqQGUox; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wRqQGUox"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTftvNfyaWrZD53jCED8bs8+RrSI6wO1YMt2T4KLNXCqA+DyU+tdTURfZt+J76wtSno9HH9X/21gg9Ynp0PMFS+xUYOHxbeaDkhRbfA0+wt34BeoYHvvgcPdDj3tSzvmPKCOh8D6nkU2RewbessDVYEfdZZ0DkQMBICyrpY7rIfQIL1bSGj0QzbrTlgkrWG325fECUU95ScdHhBJ2JiwmH6aOq/g6uF+SEMQXRbRlD/kdga17emO/PidLfgyQO+dsl4QuqOcZ4keMsLPd3L/a5vcm0Zcn8ppVf+u9Qz2pLMkkwm+dyjw80de97c1PiEJHj7xW2zyIDUQj5vwWpixeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H06hx7Y3NYvxsmF30o9U98OlTnseyB5zbz6laHdEhY0=;
 b=qkGrZujExxuM8Tw0ZThtTNg6BpAkGcmW6x41xZuiaWkqjupVKYy7f/GCJPkoV4eOgBpqM+6/CAEMoZy4Wd3xnwjO4e95SbHhPFrK14OJnPzmj5dbewwEL+4McNvXXB5NUhZRxFipYgjsppnV5rBtfGPnIhPVh7mkx3biu5lfgpsoVMbysz2lljMQX37aHH6JdmKEGRg9gAqo590vQEoXJdhCAtZzeKQKWs1OaQn6cUTUuC4JeozKtvWkqtawreXQQLbQw2tLfdlnGUnpuvLZFoB4MI3Yh3qG57pwm5AH3+iJlCiTFJsF3LOBqfiKUPPnhvo+Q9fAXO2ouXvI3HJ2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H06hx7Y3NYvxsmF30o9U98OlTnseyB5zbz6laHdEhY0=;
 b=wRqQGUoxMdJ/xl1alBUWR7BeAKkVlGD62lJIfje9WHTMrTHsFPYuaIV6EA8mjvCPQ/mIff5gaBdbGXHKEAkk0dmy6q4OkktfGqRyL5bk8Gy/YXH+oE0Ps/VD7t0JfVCZfTUNzan3vNNHPILqjnb3snV3zwGKrail9TWcCWaWCQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5288.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 08:42:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:42:18 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	kwilczynski@kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ye Bin <yebin10@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus teardown
Date: Thu, 26 Feb 2026 17:41:42 +0900
Message-ID: <20260226084142.2226875-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226084142.2226875-1-den@valinux.co.jp>
References: <20260226084142.2226875-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 351d08e9-ca5d-4aba-66ae-08de7512f31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	MAMux5gO8R2cbjmrNjPwTsFClx6jxfTDPUBGshrEjWVk8K2uYkvBmN/JfoC2lPRg8C1xFpI7cGlQapDgL9s9Fc3WNUra0afEu+ebB6m/uNxKV5n/1hYKins3n7QPzK1SQ/oh2uolE9/cmAwyL/Sp53PXmNuF5BhBXfAE7vPd5ScKdXF8YhD6xjBQZnDIXj4r1PseEeXoULPb1QJy0/eEXmOL+NLgznH52vAbRtKaKKR3NYzskC4T8ubRySDwCFmr846JG0gDqHnsNdOdyOyF/EIAL763hczUQ4nz60wxqnNafc02w+apOPqrbrgezo2++sNzMwgjDY7v45TxSTp7yodwW5j5q04w0YES78mUZdiK6GQY2jWdSXgwDv48cWeelvprL8XLlJbkyV2P1iecuaBLaprofk+pqmyg9xnTbQJsV9/fpQYN6+RWHiX0aiUQ0meTeirBX75b7asUoSGCUIXGkkCZlgHFNh+0VrJZAt+jLFyZoT2gZoaaAAABkP4GqOFXrl/ja74mz7fCpcfwIVNkLvRbak5O+ZFm95G/B/ay/f6O0vkdINjVnSn7rEd3eMafLMc53XPxrpt9/8lJ9OdPCs3m2I4mDmPjq2E7uup09fr9BdsUyMyvrPX/nUvDfwf4o1YIzw7UD6jcvp1Y6HjOf9SN5inF2mCkZaFzagdmOvhyKN0Dp1ULR8C3aT3qV9MWeUWD1zjthOe8kBn047Pl45ebmryPIiNnFPCOAyprFRiR/Px7WOMr4unplkHfN/NAkGvWrhIaCJXLIekDmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?51KRkND8eXUUqhU1GOBNOfnaExV/B8j4XFnJQjRHdJN5Npapaz6TPZjr/hDi?=
 =?us-ascii?Q?ChKTzgbdAiK1t2ojCJWrqAcr8BLu5tJ8GI3uX2e8U2vuUKt8T9ZIKjar8z5W?=
 =?us-ascii?Q?ycOWUgmpwSmkcrONFtqtt84xarulSgLKUhrK731TmaiUnYUEamga1ajF3gR+?=
 =?us-ascii?Q?OpPsYUaRn7BFKSeF9g76o04BClWNj6DGAySYf9A9u5523tJyHttirpr82FIc?=
 =?us-ascii?Q?MOWf36mTdsDd5LDnteZ9f+xTaQNFcJBrK8npjDlRkYGHAC0MOfeNsL7UVs7l?=
 =?us-ascii?Q?df2UIOfllyxmaOfNzK8IWi2kO7Yx++OtzE+xal7nRuE74Mq7c68GCjmcWVUM?=
 =?us-ascii?Q?64w94iMcXI+xrIPDC8CB7mWsqU5up93bEUYF4b9k//ANwK5xWO98+Kpoq4Hs?=
 =?us-ascii?Q?F/gIRLy7rSNMZGrf2kMbZs2jkZOON8GcHcDtHxPoEN2vQ2T47ZJgvzqeuNTG?=
 =?us-ascii?Q?nQBET/lT1wpNCGBKaI3d0loeahfzypySK4iYTP9JZxKAKZYglUd7bQNThj76?=
 =?us-ascii?Q?ITDYeLv73mINsXDkyH0cWxKFbSZRdj8gcG8DypWCpqbA8bKpSSjf4xfOae4J?=
 =?us-ascii?Q?LNDVza/3Rig03J/L3i5wOOhK/OWETf6YKixV+kQFDhEBHXOQLu5xQOO8Fs8O?=
 =?us-ascii?Q?Uq87WARQwXGPgYeOHPd119x8YS4KlFrFw7ln26DmbZwLQG/NQcZrqP1TJJBt?=
 =?us-ascii?Q?ZblPrygpiGAbJvvS9+JQdB3Y0VRV1Kau3eRARFzE0GnWlEfTQBxFOTGtZRLd?=
 =?us-ascii?Q?FP5bTHdtkdei7YH2H235Qt4pNfqY94AX54d2PjjNLwP485+CKlTDfE+XB85A?=
 =?us-ascii?Q?ewVqGJyCx1EgL5HUtIcELAdsLMloTcMeKEnen7Z11KGz+5EDXaxZE/+h9d3Q?=
 =?us-ascii?Q?82E/v2VHQ6LvHHh25vE5WwTf6yC49hBXb2IQPQRMKC+cKznUZ1FzPRKcftIr?=
 =?us-ascii?Q?6mHy5JNtpGt9B52hVWkt7UrhlYG0ilQQmkTvcEU9CL1/Qztn0qa7SlRwIgEy?=
 =?us-ascii?Q?efs+wxJakvYHgo0PxLgSiC5j62nexawZov5nTJLrdH4y9C9wYz/TuXp/WR2/?=
 =?us-ascii?Q?khtxnFq7bovip4FiXTmWSxIO0XtTd3ND1s2gO18dDjlO/nFZT+RM4ylX3W2M?=
 =?us-ascii?Q?d1AeRXv+oOS006mpRuKoz8tppfOGx9K2MHzKKpqu+mRU6BB3gqwl2fSybq6D?=
 =?us-ascii?Q?xFEOjlvGNcfd2Fg9ITm2cwW4vdrFrktUh3PiB5+yiQ19dN+GCFdViTuSvTLc?=
 =?us-ascii?Q?WQ0Zzbw16gin9VxZNzMEr9QkhPq7FXB2BTRIFONSnmavP0VOu6M2yBw/q918?=
 =?us-ascii?Q?tVWo3loUvvHg1YWRzuOLu39hRHtoe4l0/sn6lrMNwOLplNVzeWBVx1xjFckc?=
 =?us-ascii?Q?UdooGH43TUnAaxs55ciYHOUXTNH6LO4c+OyZZCPwQ5CynPSJUcxGMHKjT9I4?=
 =?us-ascii?Q?iFA5SlWRlhJy1YOZoOyPK+bgk26AdYMiES01QjZB5amEywFzhrnunYdRd2l+?=
 =?us-ascii?Q?H7vllw8q2fMqBV+1MfFAgUsJDlvkAkvkMQ7tp790ONSP+MlD/PzZSWkgAuf5?=
 =?us-ascii?Q?Qc3O/ixcEy+ayMKyr8Tmc39rLuuEhy121b6U6a81IPbflWgrGW6EDNpcMTgi?=
 =?us-ascii?Q?8oPPQv3zahCfEPQ5CvDN9RkN7ZCVe53PMLi0JXcqwy6OWoNS0A/CsV+0Zpei?=
 =?us-ascii?Q?AzF9U/EXCJuvABgGkejQlVRim7jshD1aSLqDwFANp0y0ICQ2Ukn6ODDoVDQa?=
 =?us-ascii?Q?UQYwiU+AtbQkVcaB80jYOSKglhWO8+63RXkIsCQfyM2cKEworRQ+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 351d08e9-ca5d-4aba-66ae-08de7512f31d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:42:18.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM0xPUgumaL/OVBMaXP3+eZR4eDaB/xXNupm3VfTkOaFgko/ThSFtS7JsOQil60otR+uYHAVtqiSYT2Ib5FtXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5288

Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
or stopping controller and linking or unlinking functions as you want.
In fact, re-linking and re-starting is not possible with the embedded
design and leads to oopses.

Allocate ntb_dev with devm and add a .remove callback to the pci driver
that calls ntb_unregister_device(). This allows a fresh device to be
created on the next .bind call.

With these changes, the controller can now be stopped, a function
unlinked, configfs settings updated, and the controller re-linked and
restarted without rebooting the endpoint, as long as the underlying
pci_epc_ops .stop() operation is non-destructive, and .start() can
restore normal operations.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Adjusted context due to commit:
    dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 53 ++++++++++++++-----
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f353e9a57194..41a2f42e8a39 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -120,7 +120,7 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb {
-	struct ntb_dev ntb;
+	struct ntb_dev *ntb;
 	struct pci_epf *epf;
 	struct config_group group;
 
@@ -147,10 +147,16 @@ struct epf_ntb {
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	struct pci_bus *vpci_bus;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
-#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
+
+static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
+{
+	return (struct epf_ntb *)ntb->pdev->sysdata;
+}
 
 static struct pci_epf_header epf_ntb_header = {
 	.vendorid	= PCI_ANY_ID,
@@ -176,7 +182,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	else
 		ntb->reg->link_status &= ~LINK_STATUS_UP;
 
-	ntb_link_event(&ntb->ntb);
+	ntb_link_event(ntb->ntb);
 	return 0;
 }
 
@@ -264,7 +270,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
 		if (ntb->epf_db[i]) {
 			atomic64_or(1 << (i - 1), &ntb->db);
-			ntb_db_event(&ntb->ntb, i);
+			ntb_db_event(ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -333,7 +339,7 @@ static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
 	for (i = 1; i < ntb->db_count; i++)
 		if (irq == ntb->epf->db_msg[i].virq) {
 			atomic64_or(1 << (i - 1), &ntb->db);
-			ntb_db_event(&ntb->ntb, i);
+			ntb_db_event(ntb->ntb, i);
 		}
 
 	return IRQ_HANDLED;
@@ -1237,6 +1243,7 @@ static int vpci_scan_bus(void *sysdata)
 		pr_err("create pci bus failed\n");
 		return -EINVAL;
 	}
+	ndev->vpci_bus = vpci_bus;
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1281,7 +1288,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	int ret;
 	struct device *dev;
 
-	dev = &ntb->ntb.dev;
+	dev = &ntb->ntb->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
@@ -1381,7 +1388,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
 				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
 
 	return ret;
 }
@@ -1468,9 +1475,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
 	struct device *dev = &pdev->dev;
 
-	ndev->ntb.pdev = pdev;
-	ndev->ntb.topo = NTB_TOPO_NONE;
-	ndev->ntb.ops =  &vntb_epf_ops;
+	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
+	if (!ndev->ntb)
+		return -ENOMEM;
+	ndev->ntb->pdev = pdev;
+	ndev->ntb->topo = NTB_TOPO_NONE;
+	ndev->ntb->ops = &vntb_epf_ops;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -1478,7 +1488,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = ntb_register_device(&ndev->ntb);
+	ret = ntb_register_device(ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
 		return ret;
@@ -1488,6 +1498,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
+static void pci_vntb_remove(struct pci_dev *pdev)
+{
+	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
+
+	if (!ndev || !ndev->ntb)
+		return;
+
+	ntb_unregister_device(ndev->ntb);
+	ndev->ntb = NULL;
+}
+
 static struct pci_device_id pci_vntb_table[] = {
 	{
 		PCI_DEVICE(0xffff, 0xffff),
@@ -1499,6 +1520,7 @@ static struct pci_driver vntb_pci_driver = {
 	.name           = "pci-vntb",
 	.id_table       = pci_vntb_table,
 	.probe          = pci_vntb_probe,
+	.remove         = pci_vntb_remove,
 };
 
 /* ============ PCIe EPF Driver Bind ====================*/
@@ -1581,10 +1603,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 {
 	struct epf_ntb *ntb = epf_get_drvdata(epf);
 
+	pci_unregister_driver(&vntb_pci_driver);
+
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(ntb->vpci_bus);
+	pci_remove_root_bus(ntb->vpci_bus);
+	pci_unlock_rescan_remove();
+
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-
-	pci_unregister_driver(&vntb_pci_driver);
 }
 
 // EPF driver probe
-- 
2.51.0

