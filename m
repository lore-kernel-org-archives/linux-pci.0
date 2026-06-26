Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022089.outbound.protection.outlook.com [52.101.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889383B38B7;
	Fri, 26 Jun 2026 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503414; cv=fail; b=gfbR49k0cSQhfyPEMpCtlvIg612B/2VUoxSB9KMjCZopHPWF2T7ynaRXTYRgGK1NakDNLDNpdUmDXacL+4BjXzlSezkoJyk1ft2f9vO/MYdz+yWJwBAzKtZKp+Rx5WSbqtv5mfLhjYfRHHC88bSfM5QbeDq5kvQGJ1Q1EcC7s98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503414; c=relaxed/simple;
	bh=KcmBl+CI7UevOxeWgiJgIaxlEodjIF/8XHGWWgNeURs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dqWz8NhsWU4HnRxnaH2Z9kgD6kEExZNTjhl5XKmIYDROfvOQ8FVIXKmr6SD4b207Pq76lTM7fXqIERzuqGcJL30WM1crhrtzbI5/KRMo9Gj2GE6gtRbE9zeDkIYEKc587YlsSJNwH+Cm9gmNEbcaKZeZ2xdTV9PIZBhpCw5cxpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=GFY7NTdM; arc=fail smtp.client-ip=52.101.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="GFY7NTdM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwtXaR4NSYDlXhunHP+TnOJIy5ljfe6DyFxERg+3lhoZ0aRVPnSpzC+ZzcUtbvEqq3ml8nu7uJcZlDLkIqGHILjao/0Sw/C1EIbPbc0ax65TKJ54S96nOuUZ+pP44Bo3r10e+8COwCa/4d6CqzRX3Sqyfkg9PeLbqxpj8dRleQ8DlHvKqS4t7Aro+oqnLPfXfXTlExC+Qv7gF44JZIustsySwtmKs6z+Om0EuZRWL1bd9bWn6gORqrvu5+jvFRzCejDlo+ERQMpxmIugVx6r3W60kmbSGIIGa9QM+xmdPa/owiyl+Gd6qWuK1UMRVzojwODlVOA+mBESHz4WrcHcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILnpS4LjmylLCTWHaVnBUuFZd9eAUafms8tqAVhFWts=;
 b=evCjIVOFYeiuRqTM9J268Uu9uI67DhdT1HyI8OO0c48YUuED/dIeQ3zQqZZnjbbkDuBiLUsbuOVjqJXJZ2dsJI15S8WNHF6dyEtwWo8QmaU1jbUxURLQz1Nj99uY9t/66IWTnTQ4v0YYvi9vh9rA1+FSY8qN9kI099WvPlzMocp2ARDE7o75gz3RthyQbvYLNzR5GsROjVo1I0F9i5EpTZELUWItLFw2kZl1a362wFA88UdfFiGYp13/OQJjd0cqu/KFu7muL05spHXktNv7VEK0wHuOujrHzGpcv9plkhEzL//e0S36w2Z5k9hj+DXj3+vgVnVip631ulfJrmASOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILnpS4LjmylLCTWHaVnBUuFZd9eAUafms8tqAVhFWts=;
 b=GFY7NTdMRx7pCFyKW8H4SNc+wCJ74TMjwy5gcCzezTBJW77rJsOuV23GoA/iNMwYOIzrY+NRKSGNT+W/Eb5w+JnMQkgravM0PU4dne7PeJlmhtFAT6Uh6YWMQswwg6/boys2MJmKAqai3nwIBe+OBZjyQ4h3UPYrA06bhf1FQHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2905.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 19:50:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 19:50:07 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 20:49:40 +0100
Subject: [PATCH 3/3] pci: fix UAF when probe runs concurrent to dyn ID
 removal
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-pci_id_fix-v1-3-a35c803f1b95@garyguo.net>
References: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
In-Reply-To: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Zhenzhong Duan <zhenzhong.duan@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782503406; l=4299;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=KcmBl+CI7UevOxeWgiJgIaxlEodjIF/8XHGWWgNeURs=;
 b=chpmYr1u/gt+47BS/Zt7AMy1oXANa9zfIPgOJ4Y7arOxiHAPo0yU+Esz+lvaOTBhXS+d9il9/
 hf9HAibn+KgC7+YBrptCFf4hLvRMpAlTGnYJQbzmEn49WWwCOXkmPWq
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2905:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4b35e0-1cf2-4973-feeb-08ded3bc1ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|376014|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	QatdIXICAKLozzgR1pejAdgQTBaCDUVMoffr7IEuCGWmoqInHY7xgInUQ3gzhbBoxtQUBr5dC3QNLT0zsq3ns3mpnMcQQAz26n0GamZKacDr4bBiCFts9D4uEhvDJ3JIQHFetoWGhUWICGVJNkBg1gn0ZyiqJHGZ2jSTxv6dAottLVkZh4Ov4vzKIIjAuCU3ZMVBg7e6ShzKqHcr2eYrVtyUcj//WeCpL5G7oR2NuzOJh9r1p8A7TjFziKzIW7C601X+ZRYOrQcvuCSFuBwIt8RsEwI/O3G0Y6CrYoEh/nuxTjbM22liKjPqCciY6AWxPIYBaCb7xQTOSzho5nRp+Y5teUezXJ2Od4GHvpdUi5RTp1iNnVoguOl2XJPvgDS3SlggKlxvl7tAxRL+6oFytaDVPhQ7qXUTCbUkyM36RZOzAg75sE018IAHfDeurV606kE+4pP1jfgR+3qxNtbWZXsPAEnCYISiSOBHNRozZ2o0Vy+Lh0AuAHM83U9VK6iX1FBa4fzN/JnC8ClLfXGjWpJrE85luINBHnwvgje+8ofBhE0ZIfI3vLB+A86/T7xGGzredkGiNhGaAzVn/xa0hq9oN3ckK9ZRZ7km/YwLszmzFTpmdQgIVdUzNT+mGXW/4e69cEzFesvNJjqQywzXkwn86oqzTZD0HT1DvMFY4o4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STBMcHZFNWswS25zdzROS3RXSkNmTzlEamlMaEJyaWJob1ZjUmtjc2tURzlI?=
 =?utf-8?B?L1ZETXlHTHNoU0piSTdwbjFMNndSa0g0MUZObXZ4SWFXMm9LaTZ6TVpmUW4y?=
 =?utf-8?B?REpTUEtSUk5MQ3pvVGwvWGlJUE50LzdYYUJzb0NCSTZCQVlEYzdtZU5qdEdi?=
 =?utf-8?B?ZmQ4Qkoyemx4Z0NlMGx5RWNRTWVhUjVJWDk4TDdYb2IwcmFyU0dGaEZuYWxG?=
 =?utf-8?B?T1M1WndkbDU3YXJ3ZmpKTTlLL2dhdklza3ErSzVSdFA1Y0xWUFVDVjNhNUMw?=
 =?utf-8?B?c2ZFZXU4dWNjWVBxYXFMQm16U2ZHblVtQVQ3a3VRekYrZ3EvQXpvWEdFeUJ2?=
 =?utf-8?B?bFBiMC9jWElCQVZvelZpMXR4L0N5SE1hNDJGZjhPQjZzS01lNEREc0kyNHBS?=
 =?utf-8?B?R280VXV0MGZKREU2U0NTYThNN3Z6SHRURVhYSHN3MHpCeEVHOE9RdkY0L0hM?=
 =?utf-8?B?M3RQS2pwdzBvdzRBRGdENDFabWlHM291QWlIc1VQbHlSZmNkdWowV1NtUUhT?=
 =?utf-8?B?TGJiTjNkd3ZUM21SNlhnYVR2RlBIaXVFL1dZbFBqSFpRWUZGazR4NkdpanNG?=
 =?utf-8?B?S0J1VXVhOUpCMG9vdjdqdGh1cnhBZi9MSXFseE1PenRldUczNHlwT0d1M3p4?=
 =?utf-8?B?ZTl5NXFMUDg5MXFza080OUxFTUt5UzlrUmRoNHNGYnR5eE9ubW1OQ1RPNloy?=
 =?utf-8?B?eEN5U1RLK2I4VzJGUVRwand0TU9jeWlqaEhlajQ2QmZlYWx4MVkrLzEyZEZX?=
 =?utf-8?B?c2VEOE9tRW1yVE9RV1RyTkpJRjZBRkswRk9rdjFZdHUwZlNMSHNzRHNHVlRV?=
 =?utf-8?B?MGRYU3lnSGpicUJ6c1RDWkdCWmhCMitRdGdhN1RpMmNJZEc2SGlZL1RjZndM?=
 =?utf-8?B?YVM5V3lWM1NOSHJDT0FHQ2NZbWhmV1JIVlZIc2doT1B0ZDRDc3VxdXZaZXN6?=
 =?utf-8?B?NWdsSVNSZlJ2QjlnSEZPbzBkYVcxcmMyQzdQRWJKUGVCWndGQ2V0cjlLcTQ0?=
 =?utf-8?B?a1NuaHNYT3BXd0pHd1RHSWtkeGF4S3FBU2VDNWlaRXBUM0Z2TWtWSlpIYVJN?=
 =?utf-8?B?azNKRGxKcE0zRHpWSENiZTF6bjIyZzV1SkRXTVc4K1Q2RmZlVjgwVFg3VUYz?=
 =?utf-8?B?YnE4dVVlakg1VHFJaU9EMXN0cHkwR3ExTk1YYmJpaDBwemRzc21zVnh3QlQ1?=
 =?utf-8?B?YTAyTi9BeDg5cGJwcGhDcC93TWtDSThMRVhuNXhZZ01JZ2pnOGZ0cGJmQks0?=
 =?utf-8?B?ZnRReXFJNk9RMGR2eW1DWEw0eno5bzYyem5waVJ6Y2p3T3kyV1lZYVFFTG9K?=
 =?utf-8?B?bmhwemFTNngyVzd6b0NyYVFML21hU0NrMWhoTDFLNEhEYlZTLzhqdXJ1WGdq?=
 =?utf-8?B?bDNjWmo5emJpVjR4blJaTG5PSlYvWVhWQVNXeUtxaU5Cc0pwYm15NWVNV2ZK?=
 =?utf-8?B?bDZTSDgvanVTU2lPdnUrL01DQTBCU29qaUd0TXFWQ0FQVjI2bHYvUGliWUtQ?=
 =?utf-8?B?YS9hTXZNV2VRYWxNbGtHaU10b2N2TmpBbmpXZ3JlRFJDbENFNkpnYWRCbGRm?=
 =?utf-8?B?YnI4dUUrTURwOXVDWFFDa1Bmcnp0ai9mNFpTZzlRaDN3U2dVbGdMc1NQK25y?=
 =?utf-8?B?R2lQOERBSHlHZk50dGwzTGtQTlVEOUx5RUpTTEN0d0E1TEl0c01SNCswZTFl?=
 =?utf-8?B?UWtTTk5pTUU2cmNhZHg1TU9Vam5UTUxic0VoYzNKbDM4WEZnWGZsdXFUZ3o1?=
 =?utf-8?B?TGs0NWVFTlY5NWozekdvUlRPaklXazZTVUVLRmhRci9nNHhJanhkQWxVdDFM?=
 =?utf-8?B?RDNZUW1zYUtZdkFEN3FraEVYVEZTSGUrWXFObVNjcjVtREl2aDRMa3hKSXZC?=
 =?utf-8?B?MS9yRmQxLzNLOEUwdkpxT2lmUjIzQ285OFBjZ3AxNHdWeGtHdm5hd0RZZTFC?=
 =?utf-8?B?aFhqK3U1U2VyRVBNbHkyTlRlblJwdGV5eFNOd1kxRXdYUy82VFhXTmlkOXcy?=
 =?utf-8?B?ZEl0bTkwV2ZJNUVMcG5PeE4wbERjQmt4MzIzMUVITkFqSFlFbE9mcWxkWTJy?=
 =?utf-8?B?U0M0SUJQQnFpYVM3dUw3a1Y1eE5xZzFwNGJqK1B0WUNEQWNSSGtFc1ZMUEtz?=
 =?utf-8?B?cTZCc1JpVEJMTkdjNklIS1Y1TTRKek1TVWtWK2tvNGE0WnZpUnZIVVloK1B2?=
 =?utf-8?B?U0dLeG0yUVNoTDgzZ01tV1VZVklXNGdhdVZHZ1NoTkkrRlVzUkZmcktId0pE?=
 =?utf-8?B?WlJSczQ0QU84c0gxbzBDOUpuamFqZDUwUFU5QUxPNHNobHFnS3pVNVpUNEw1?=
 =?utf-8?B?Qm1PVDdxSkU3RXIycXFLbXFFMXE3REREdGVyVHkyTU1FTXVxMGwwZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4b35e0-1cf2-4973-feeb-08ded3bc1ffc
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 19:50:07.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJDrEdloQkQcunkzHRfuxOoc2ttV0/jBa7TM3m4d58pZKmVBYYyNaiWfzkSMbJK27kTuKMB/z9Xt75i8qpxU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2905

Dynamic IDs are only guaranteed to be valid when dynids.lock is held,
as remove_id_store can free the node. Thus, make a copy in
pci_match_device.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel.org/
Fixes: 0994375e9614 ("PCI: add remove_id sysfs entry")
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/pci/pci-driver.c | 60 ++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 464ee52346fa..2c76bba9a715 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -177,14 +177,16 @@ static const struct pci_device_id pci_device_id_any = {
  * pci_match_device - See if a device matches a driver's list of IDs
  * @drv: the PCI driver to match against
  * @dev: the PCI device structure to match against
+ * @id: Matched pci_device_id
  *
  * Used by a driver to check whether a PCI device is in its list of
  * supported devices or in the dynids list, which may have been augmented
- * via the sysfs "new_id" file.  Returns the matching pci_device_id
- * structure or %NULL if there is no match.
+ * via the sysfs "new_id" file.  Returns true if there is a match, the matched
+ * ID is stored in @id.
  */
-static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
-						    struct pci_dev *dev)
+static bool pci_match_device(struct pci_driver *drv,
+			     struct pci_dev *dev,
+			     struct pci_device_id *id)
 {
 	struct pci_dynid *dynid;
 	const struct pci_device_id *found_id = NULL, *ids;
@@ -194,21 +196,19 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 	/* When driver_override is set, only bind to the matching driver */
 	ret = device_match_driver_override(&dev->dev, &drv->driver);
 	if (ret == 0)
-		return NULL;
+		return false;
 
 	dev_id = pci_id_from_device(dev);
 	/* Look at the dynamic ids first, before the static ones */
-	spin_lock(&drv->dynids.lock);
-	list_for_each_entry(dynid, &drv->dynids.list, node) {
-		if (pci_match_one_id(&dynid->id, &dev_id)) {
-			found_id = &dynid->id;
-			break;
+	{
+		guard(spinlock)(&drv->dynids.lock);
+		list_for_each_entry(dynid, &drv->dynids.list, node) {
+			if (pci_match_one_id(&dynid->id, &dev_id)) {
+				*id = dynid->id;
+				return true;
+			}
 		}
 	}
-	spin_unlock(&drv->dynids.lock);
-
-	if (found_id)
-		return found_id;
 
 	for (ids = drv->id_table; (found_id = do_pci_match_id(ids, &dev_id));
 	     ids = found_id + 1) {
@@ -217,18 +217,19 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 		 * In case override_only was set, enforce driver_override
 		 * matching.
 		 */
-		if (found_id->override_only) {
-			if (ret > 0)
-				return found_id;
-		} else {
-			return found_id;
+		if (!found_id->override_only || ret > 0) {
+			*id = *found_id;
+			return true;
 		}
 	}
 
 	/* driver_override will always match, send a dummy id */
-	if (ret > 0)
-		return &pci_device_id_any;
-	return NULL;
+	if (ret > 0) {
+		*id = pci_device_id_any;
+		return true;
+	}
+
+	return false;
 }
 
 /**
@@ -474,15 +475,14 @@ void pci_probe_flush_workqueue(void)
  */
 static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 {
-	const struct pci_device_id *id;
+	struct pci_device_id id;
 	int error = 0;
 
 	if (drv->probe) {
 		error = -ENODEV;
 
-		id = pci_match_device(drv, pci_dev);
-		if (id)
-			error = pci_call_probe(drv, pci_dev, id);
+		if (pci_match_device(drv, pci_dev, &id))
+			error = pci_call_probe(drv, pci_dev, &id);
 	}
 	return error;
 }
@@ -1567,17 +1567,13 @@ static int pci_bus_match(struct device *dev, const struct device_driver *drv)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *pci_drv;
-	const struct pci_device_id *found_id;
+	struct pci_device_id id;
 
 	if (pci_dev_binding_disallowed(pci_dev))
 		return 0;
 
 	pci_drv = (struct pci_driver *)to_pci_driver(drv);
-	found_id = pci_match_device(pci_drv, pci_dev);
-	if (found_id)
-		return 1;
-
-	return 0;
+	return pci_match_device(pci_drv, pci_dev, &id);
 }
 
 /**

-- 
2.54.0

