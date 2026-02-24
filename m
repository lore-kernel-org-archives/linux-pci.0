Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2D39E178;
	Tue, 24 Feb 2026 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940111; cv=fail; b=dmQW1JXDeMZrgBl6VbCu0x6aNKX71zcBFPTEXd8+BE6lX7ZGdwLaB1yi7WE04SHs48hajtS4ptF1tJ0iujDjIIh4ofy/WzqZDXAZ0iBHMwiY4q6J6Bc60a1i9pNy8xShXMs+N1uEWA/TMP6WHZ+N57w1jUWs/zjy1LvRoELOhGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940111; c=relaxed/simple;
	bh=6gjeGH0tPS7nZaTYTcQm/dqcX11JHS5rnE/fIaorklI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+oDWOqkCTOl1PR5i97GXmw7+12BijW482uUIBGaqH8ebTqtcEaZxh3vXFiNc/LKRYfOl8uSbOK8LsmDLMQBa4F9Ed7ybh6CgTs4vux/tjNiiI3yJyIHzJcU04X3FfvOxA3Zv+A8lW8Aenzbx5NeZor40U9Tu5fuDlHIqpi8HYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=sKImSXVC; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="sKImSXVC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp+VNcxVrYIsMmRIIAmyEERTdchsIWBAbIfvYklTl5oxU1LMGPyZDXdR0o4i8nip5INNFziGZUWw/mdrtcRZ7h9JxSzaDkEW5kHMjsGZxNqK9snvB6sPrGmA8KO8jODUWb4G7QwjCrgVrsjC9B96gL0oXxP/zrwUqk8Rk7obqWzTOLYIxXszvjAGdGMF2x3N5HTeAOUpggLAzHyHtOYEvDIOaGCBcC0o7yOwfUenbf1JtKlBp0//eKmz40lknPwqUmzRbYgnuQKhdmDXI1nRkmNZMXj9rrVDFmf5QRx8QjKBCQhdxrMtkWmSvJVIMLI98oL9AvK23SBoJRkdG+zb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDPcNgV2BVcMgp2QfIW8n3dyqyLLc1Mg3Sxz3blHLDg=;
 b=aNDkso3U3anx5eHWjK/Fk5TqTiW2UNZgqPOkM70AM21tx6lrTvIsvI98MuD/J17KLyiuG3pNzB5CSWvt8W15CSvl3kti7fKPln7DOwuzplY0oG9jukZ8UVOMXnUh1XMrlT2cXY7DEc3m/7FNc8Cw3fNZ+Pguxydr0DaSf++dXWkkvwQj2XEnAOvUj2XjiLPtxWVZ4NY8JFAJeyHW1CZkVkBw/4GXTrYpEXWSemPM3+bbX0SZvckNrNoCV+ouOlR4cKE+hd3UNavbm6AKNxiO2Hy2eL3Sz1o3eS0xyc90usNq95Rh9iB53EvMKxu8R/c6oNwkQA6TXIqJKgsmeXruhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDPcNgV2BVcMgp2QfIW8n3dyqyLLc1Mg3Sxz3blHLDg=;
 b=sKImSXVCyuk3vi2t29+N2U0VsGvB5FTDnoqHRzUyuN/gpZTGTvC8puTNIgrXxg60Rvs8YIvs6lEsLSXkOLIXvkRMbzJh+7jyB9b+fPdZceWIGc1veOoYVVBFeEZDSM7h9s5rc92t6SejJu3hwc99MVo+merQLvWGQE4fMYhn61U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB4764.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
Date: Tue, 24 Feb 2026 22:34:51 +0900
Message-ID: <20260224133459.1741537-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a4479e-a666-4c20-cd2f-08de73a98441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?exSduWmjwJa0YtmposJNBgK7XePYEgClXgWT1KdK8KcsOqWepFJBKmh/0QNi?=
 =?us-ascii?Q?ycBEqEcbuiR8nDSqK9AsvM8IP3sXgdaOQ/bC9MVqzZGWPPXkxvfYDbxXzc8z?=
 =?us-ascii?Q?I/FUSLy8VqXJVq5JyU1yuiIoWTjp9s6k+9OQS1crBBTzC5dQEDmWYK7Zu5ab?=
 =?us-ascii?Q?DNrLbRbFwTBlZQoghVWb37k9vmCPbGhCoYwnA/2SBx6CbW84aCke5Da0ePzo?=
 =?us-ascii?Q?zI4EfgEdKYhfEUFz5ZaHk7DEwgAG3ow8/qYBafSyUmscmICB3YdI+/ijJ0/T?=
 =?us-ascii?Q?buVumRzBIIk/7z/tC4o8djSlVNTzj/eWZENYgOR8NSkTbgPZfhLZcuYu38jY?=
 =?us-ascii?Q?h73m6PuyAzOvEZewhgZc/lzFANMmB1UPnc0TeEhL9BPv4pcGV5QEHFMbvnSM?=
 =?us-ascii?Q?Du5UBbvOXU6RsjvKGSsZ7AJJyG0VWNIMGXTdJONCBQCGLD9hFil3axlBssMN?=
 =?us-ascii?Q?bx6HeIm4gdieLpN2UFKtyuNuRaGEr8e8J2CzQn4QTf8iB9oCVZUYXIA/1GJ+?=
 =?us-ascii?Q?kAekOZeEpSrJDKyRrV6fW0VZI/cPJspGKDLXEpiLaGXq4of9BV2lD2r4yhK9?=
 =?us-ascii?Q?yG1Gw3Y7FVzClgPFSilFo2QO0im3Q9z6TuAFvEut8VRok8xjMNtgLqVLULdX?=
 =?us-ascii?Q?qQNVm9i8HjxZXQ0TZZC703fjVypzIb6fLaI2Mesj+4Dmn4LP2RHxXFTUbdHD?=
 =?us-ascii?Q?x26Mdv5g0K7jQXwcE7R3iy5yVg75PLG/5iE6fmCrfW2fWTGs3TQys4oKv73c?=
 =?us-ascii?Q?qdUse3NaffaHak7Hu4NEtNS7xrtPEfDqNHxwudDzd2f1kJ1gAN8PrKwKhf3f?=
 =?us-ascii?Q?rl4JZBj316JYK0bXlUf6UcneK9gJ7mdejw2etzMUbCWBbcoVRtCsGgOC3Yjr?=
 =?us-ascii?Q?YftoZx03Kq3UXjhkGwkqpZtTH0DFzN2fc66AaweG6RyiJ7+Rw+3YQRqIZ0Ak?=
 =?us-ascii?Q?uB4IBdiJ+sczoO1+cGW6zoF9a2DS6ibdqr+Q3DlQkd7eLUvCzJ2BtooHyOsy?=
 =?us-ascii?Q?TGkRBbu7QWEyM7hLGXmjC8xjXqY7A3ze7ephMBUtHNDppCU3tcueEO2YO0vS?=
 =?us-ascii?Q?ttphb+fu17yHHAvP0fYxFJnPmeEimMS5xNmw7WbTFZ89evtAM9AU5JVpeZaS?=
 =?us-ascii?Q?jL+sSuhxb6wTov900hYFMaDxY8vBcrNYhjQZCt/BKWsvEV4vJg53V6waDoTA?=
 =?us-ascii?Q?dmEiBeR1dCpv6019sMx8dMjEeOZlDcKGTIhwjcIGhfvCM9NLDkjwS3Mibxx8?=
 =?us-ascii?Q?0jyb2MpwpKQqkHzz364WdqfDh/YJHIjEWaBdKp/ZObi+ZZsZOsvYTcHcGEjq?=
 =?us-ascii?Q?4fvwvZzVC1fVgkowWm6aLdoMiPjEtrxcz7Z5TmUOsfyQOqszSPMW6Rqo8NkI?=
 =?us-ascii?Q?p6mMG4Qr26jaBT/n++yGOpdYdnsyLYVrcWOWeHYHE0hefoZ0QiqNhO3kL+XS?=
 =?us-ascii?Q?FcdZiCQVbdeowhJdT1WEivcJwHmnrUoWl02dhAkXxlxyxSn5b3k9whbbPD6i?=
 =?us-ascii?Q?Oj85ltA18u/bkANB6MZrEl8sFNj4eMpDsRD3XmvWOOgGJyrD5dJy0jogcxXW?=
 =?us-ascii?Q?myoWQmhRbQrz5FUG8GXyomwbhBict65vVfIz39xTU1tFkeXomZbYpXEc8qf1?=
 =?us-ascii?Q?2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0v4QI/jJ3MJC+/SJ8RcCCOsNtUqgI8dh28VQCHLEAHyHOzIFO2ftwAQpsIGA?=
 =?us-ascii?Q?6PMOq2C2lMiUWzwV5kdJZagqR2pa+8CpUUnFF7iqSALwMxjsSy6gu0PgFMvQ?=
 =?us-ascii?Q?yclf3xGTYQv1N7t9of6mRDMfpq+IHHesi4HvIZmnbSjayRyvNIWNg95clBP8?=
 =?us-ascii?Q?2NcaVkWT2giCK40YKyBEvlgkMtSywwK8sOUxb1tTOX+hb1Lk3V4hxkmKUg4V?=
 =?us-ascii?Q?dkDLm+nBAAWe9x5wbWcOLuQI4fxiMiqWH+ZNUNpg+BmuACSWk0vm8I3B1nhM?=
 =?us-ascii?Q?WyBmTWxF8pulTLqDOFXX6zXmdfpELjAPOp/yxt7UbhUEx4jlTtU5Z0b7Y3z9?=
 =?us-ascii?Q?UJ86Cy38qrMT9rmsMe6LOP3PC67qrkrotF6G1/lo0YoEzHi6lwC1mVRTmQQb?=
 =?us-ascii?Q?z/iJoQVBnxaazmJydOmYK4RBmPT6DF8tpOULDbjM6M68QARX2D0SpuSNdRSo?=
 =?us-ascii?Q?zs3P+uLa8k944v+u8TfLmUm+JWa+RjXG+UU7bBj9RVu5Y6Hk1jTMLyDo1fbt?=
 =?us-ascii?Q?ftJPHWGARmWSfPeRzqbiro4mFYWKi9O5/WAuYF2llStBaJvcl5s7/IF43gFk?=
 =?us-ascii?Q?bDfGRjHmjAmFdskCH9nTU5pcR3J6c2R/K0CAlDoFHvkpL9y1CVy3MJCFfdQ8?=
 =?us-ascii?Q?pr7j3L5rCwZmUNsYyhtP4u+WW7ZoGCK2gArIcgUr65b+RSrW2SbiiMxItVRN?=
 =?us-ascii?Q?9jlJ6p5Elx3/cBauTySROKJIq89N5Fw3LtZNLRI3DkHpTgYgMgYnuZr3pFk3?=
 =?us-ascii?Q?T/RlnchHWannxNyUCba1AwdKN8hrr0bMnpAY6E2Z0hbKQcnJIkvuMAahvMEh?=
 =?us-ascii?Q?TmBWKqLesQUpUo/P61Lc+2jS6UPb24fw/RRYJxe90eMMCA/nRVxH+ahKEHlg?=
 =?us-ascii?Q?Iw1JjbgT4J64wW3Rkb2jrUDHPFYWfATSA1MQOwY73QSVaeMUSSZh+38RW+XL?=
 =?us-ascii?Q?x8W0bGFp5f9dRA0apozEIyrogR8Kk7VwmljreJMLkRPmtSLTKEuOMKXEJESP?=
 =?us-ascii?Q?3RO8fKphY2Kg35yDOForKSXwIJRIYEoKY433ZUb/MQ2bTI9qyKWyXtqho+W7?=
 =?us-ascii?Q?TcTGbvk0ivnly2E0DvYj3iVAHTKM0FvKjVgUtADtwckPQZRdptqf397MoRyr?=
 =?us-ascii?Q?ZsphvtEVUSOP9UPTU01C2imZ/lgnOJzJ0V7LgSeIWYUdIFu8FKSQbsjnCo6z?=
 =?us-ascii?Q?yhlhJxTRjz1VWBT6n+7l65Hmk1Z8Znt9cfFFttUOuEmW+yduerfe8E5QyWzX?=
 =?us-ascii?Q?rb6O69atw6mkVImQvoJkGOQwa00BmuuqXQKiq+h0VlZJb2D8RL4j5sW6RcIi?=
 =?us-ascii?Q?zYUHvVowaZadpMbUQPj9KlxRpjykxYF8Z3Rd9BifFC6Mq3eCOmnwDzA3wCcc?=
 =?us-ascii?Q?q9RefZ01Dxn1Eo8Naz4gebPhzWfBsIbmsrHpCiKEHLV3xhq3fFRf2lNNnH6l?=
 =?us-ascii?Q?UDp/1wgdtpDfRvl78pXtp+pwTAh1cNd4lndGKh/igb3CYeM7vfsYNNzGy9/l?=
 =?us-ascii?Q?/s1oVkB/lgDCy3+hN/OocNZXtUrvd32uHRM6+Q/OiSApd4dv+yUP/Rkh4ly9?=
 =?us-ascii?Q?9Rrs5DFCjry/Ciy9iS1/07k7rt+ED4nurrr9KbI9alUsRCXOAEKxrjTNYkI0?=
 =?us-ascii?Q?sHIplbF7Ks2PCIz+dkSqpvzgSaiIvREy/T4IhLGdx/VhHSG6WhmK0elAxgFP?=
 =?us-ascii?Q?rl4M705q4n7k8gahzUYJSL0WxKzKFbB2a9jqTTGCGK3ohpvAmdfEhwPVbzJ0?=
 =?us-ascii?Q?CdRt2ib+yG2o7X0Lx9e56F/q/oqOjt0w0f4z/hk8N8mRzkVPqA4g?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a4479e-a666-4c20-cd2f-08de73a98441
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:03.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNugI7hru4nsDCYCzabIwwY+Rvz3vwNHxwhQ/gqKxAcuaMcUDCZffKf3xRg3gKCFxpzBt6tCC6pDY/zD+9RXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4764

The NTB .peer_db_set() callback may be invoked from atomic context.
pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
pci_epc_raise_irq() may sleep (it takes epc->lock).

Avoid sleeping in atomic context by coalescing doorbell bits into an
atomic64 pending mask and raising MSIs from a work item. Limit the
amount of work per run to avoid monopolizing the workqueue under a
doorbell storm.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 109 +++++++++++++-----
 1 file changed, 81 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 4328f05acfe6..c00898ac8269 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -69,6 +69,9 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define MAX_DB_COUNT			32
 #define MAX_MW				4
 
+/* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
+#define VNTB_PEER_DB_WORK_BUDGET	5
+
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_DB,
@@ -129,6 +132,8 @@ struct epf_ntb {
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
 	atomic64_t db;
+	atomic64_t peer_db_pending;
+	struct work_struct peer_db_work;
 	u32 vbus_number;
 	u16 vntb_pid;
 	u16 vntb_vid;
@@ -933,6 +938,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
 	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
 
+	enable_work(&ntb->peer_db_work);
+
 	return 0;
 
 err_write_header:
@@ -955,6 +962,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
+	disable_work_sync(&ntb->peer_db_work);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1365,41 +1373,82 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	return 0;
 }
 
+static void vntb_epf_peer_db_work(struct work_struct *work)
+{
+	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
+	struct pci_epf *epf = ntb->epf;
+	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	u8 func_no, vfunc_no;
+	u32 interrupt_num;
+	u64 db_bits;
+	int ret;
+
+	if (!epf || !epf->epc)
+		return;
+
+	func_no = epf->func_no;
+	vfunc_no = epf->vfunc_no;
+
+	/*
+	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
+	 * Limit the number of snapshots handled per run so we don't monopolize
+	 * the workqueue under a doorbell storm.
+	 */
+	while (budget--) {
+		db_bits = atomic64_xchg(&ntb->peer_db_pending, 0);
+		if (!db_bits)
+			return;
+
+		while (db_bits) {
+			/*
+			 * pci_epc_raise_irq() for MSI expects a 1-based
+			 * interrupt number.  ffs() returns a 1-based index (bit
+			 * 0 -> 1). interrupt_num has already been computed as
+			 * ffs(db_bits) + 1 above. Adding one more +1 when
+			 * calling pci_epc_raise_irq() therefore results in:
+			 *
+			 *   doorbell bit 0 -> MSI #3
+			 *
+			 * Legacy mapping (kept for compatibility):
+			 *
+			 *   MSI #1 : link event (reserved)
+			 *   MSI #2 : unused (historical offset)
+			 *   MSI #3 : doorbell bit 0 (DB#0)
+			 *   MSI #4 : doorbell bit 1 (DB#1)
+			 *   ...
+			 *
+			 * Do not change this mapping to avoid breaking
+			 * interoperability with older peers.
+			 */
+			interrupt_num = ffs(db_bits) + 2;
+			db_bits &= db_bits - 1;
+
+			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
+						PCI_IRQ_MSI, interrupt_num);
+			if (ret)
+				dev_err(&ntb->ntb.dev,
+					"Failed to raise IRQ for interrupt_num %u: %d\n",
+					interrupt_num, ret);
+		}
+	}
+
+	if (atomic64_read(&ntb->peer_db_pending))
+		queue_work(kpcintb_workqueue, &ntb->peer_db_work);
+}
+
 static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 {
-	u32 interrupt_num = ffs(db_bits) + 1;
 	struct epf_ntb *ntb = ntb_ndev(ndev);
-	u8 func_no, vfunc_no;
-	int ret;
-
-	func_no = ntb->epf->func_no;
-	vfunc_no = ntb->epf->vfunc_no;
 
 	/*
-	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
-	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
-	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
-	 * calling pci_epc_raise_irq() therefore results in:
-	 *
-	 *   doorbell bit 0 -> MSI #3
-	 *
-	 * Legacy mapping (kept for compatibility):
-	 *
-	 *   MSI #1 : link event (reserved)
-	 *   MSI #2 : unused (historical offset)
-	 *   MSI #3 : doorbell bit 0 (DB#0)
-	 *   MSI #4 : doorbell bit 1 (DB#1)
-	 *   ...
-	 *
-	 * Do not change this mapping to avoid breaking interoperability with
-	 * older peers.
+	 * .peer_db_set() may be called from atomic context. pci_epc_raise_irq()
+	 * can sleep (it takes epc->lock), so defer MSI raising to process
+	 * context. Doorbell requests are coalesced in peer_db_pending.
 	 */
-	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
-				PCI_IRQ_MSI, interrupt_num + 1);
-	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+	atomic64_or(db_bits, &ntb->peer_db_pending);
+	queue_work(kpcintb_workqueue, &ntb->peer_db_work);
 
-	return ret;
+	return 0;
 }
 
 static u64 vntb_epf_db_read(struct ntb_dev *ndev)
@@ -1641,6 +1690,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
 	ntb->epf = epf;
 	ntb->vbus_number = 0xff;
 
+	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
+	disable_work(&ntb->peer_db_work);
+	atomic64_set(&ntb->peer_db_pending, 0);
+
 	/* Initially, no bar is assigned */
 	for (i = 0; i < VNTB_BAR_NUM; i++)
 		ntb->epf_ntb_bar[i] = NO_BAR;
-- 
2.51.0

