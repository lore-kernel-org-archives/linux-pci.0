Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3852D738F;
	Mon, 23 Mar 2026 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235775; cv=fail; b=sa4jGwc5/IXQyPm7nSbMSAPCzLaYI8bFHk0Awe1ZaO9OFZk5LDZgwf+eX82fp+gEJxHtqQDZC7+6etVas+u63z7t5EOt3kNUF3bYsE2moBcQ4OsPN4zah8RfFtziPFmw7gcUOAXGirNlvEwa1znVHKJ0J73TYhuFDRUPCb+CqJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235775; c=relaxed/simple;
	bh=kPP0A/AR1ebZqUwSTgUol69K4dSKle4AwfbfAdy7tuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EDzoo508nXhocr4o73jib1mdQYrN8r0/QoL75imy8vOayM5OHUj0Vst9BMEzyfWMKoD9juNUGpyZkYe4Rw6G4dkCNMb81Ah1ZSbLPxiW8n4hpLq8qePiZ0rNgJtDba6jtikDokohri197TNd4ywdR1Zk/26alNUplNx35fzbXww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UruKTosq; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UruKTosq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRIKY9iPsqGWAI0Qf8xFqEj20WGRw2Vd7POU5eM5/GYKk5LyWiUkTuY4WuzC5wrH5DALDp3KHKxxYrtne3BC6Ogfg9c05tXzlOdywRsMJ85Jjmu9dsV9NyC6vZRW9Kb27lb1qdIx0xNtRzC6aahpphGftw38L6NPVcmHMRM549ei1cF8lBcaepHhSAA6F8T6rzYzI5c1HtwRg2ovDMZGA3abz6wCx6adLNgeK/iA+cqb0p10kAFbWalMC3VZ2jhvAawAYBCIi3h95F8ncHXjwOZLmltkbkzhVR0rCFEOVLYCFbNZcRuUtDNYUrwyl2okQcaUVL7qhC0m6QRtsRwpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TEfxpn/KOB8dLfXpvJYFyka4rnviraWJ8+TBIbOLRA=;
 b=YhlxQWUhJoaX6WXlDHWfmZLN2RPYj2AqjbyQLLRTw6YvrslBopTnwDDMPW2DT9+sBjkQojMCSZvkzvWazhF1M0VLWX32iXDA9JGmzVlREcMqboFZJc0nb256RRwDiuS+djEj8DlM4rx45K7RBTw3kYAyGWCpjyREvwsniKgMRnP9UqjcQ7XzPQ1amDIE73o/WJUH+VnPfY8zlmaq4AncPqsO8DRFsgSnZrPbO6PvWCIDc7naaREqvkTaZuEDpUs1V4ZsBeYjQ0o6D5XeSapAKTIw1sTycG58tPO9HkC7keWKy/u6zn7A9MvJdHuwcdJireYIaA8UaSzxVJMzeyBd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TEfxpn/KOB8dLfXpvJYFyka4rnviraWJ8+TBIbOLRA=;
 b=UruKTosqikEqp4RJaKTVt/I6kN5EBJ5FMDXgRMt6q+WL5n4fqbshBqwKtwU3RqssswvqZXfg1baBvdImzcpchKZtvesOEAq2nsg6l4DFKmNuW/omqcRSpc40iuQxQ84sege2l3/fZyOsJ77N8OeyLkUiVPHWVPUgjiDqHWaxgPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2385.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:16:08 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:16:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v3 09/10] NTB: epf: Fix doorbell bitmask handling in db_read/db_clear
Date: Mon, 23 Mar 2026 12:15:43 +0900
Message-ID: <20260323031544.2598111-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::10) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: 000a165c-ed26-4d5b-c4d0-08de888a8697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	rJC37j7FrQiu6ym+zTMLeOwKn+6UO8KNUe17Xb5U9EW4z72fWXeuk9DoIuiytouw8WqH+SFfnnS8IhxwkLdUmtoTlbftSPBB2JLdWztPvanBzZcjjfkt/NuPHhPWI4dPfpUbtnfMs24Nw7MZf2LzQmNUnEPMMuww+AlT4Pz2P5S427nIVvWUZi+8J/icHX8O5ogc6nkPVfVv29nWBtIePU3tg8dQYRAGYhQvuXoUXWodyS+sjUKUPP/RNk+yaH8cMpZkwNScfk6ULPiSazEhDc14659XTvENjM7A4p379cuvjcFB3rNcRYDqEbK0+4b6Cq5uSQxuzpZ1Kfd9Hv+Q/BzUf4nbBJGVFgbrBzD6all3NHD2WAcVlyhPKBWhs9Jo3s4Gk6Se3rEtjK4400XOAzL0/+EtZenpy89rhhRl1XEOAn+wFLzKEHamV5bc6g226AOKol/djXyVoQA8hQPQAxEi4/Fhjnb5s3TJq91HQgX47C1dB3w0zBY4xrQODZa1Rt+4wZ1W/cHqaKhai3AqhgkyFar9I/sl5St4XWz1m+ZuNi1tdcP+UuxYJ0fZD4qqVVJW980HC2xBXQLLsZsrmXs0kAtCfR660JBQ+ydkIqSWY/g++qf83BrNjlhhXEktFevd39gW2UjCJBsHwQezLmOwm9muGdUD5NYn/RL+/DhWLVCbdWis/gaR65y/lOZPYsLEjMTaRSFilK84jstSA7hRHwZDuhlv+X817tYFagELHuIvq75DQJdOKKk8pc+DUG2nrf/HN7U1i3Qca+tlNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CVVuT4JH2mts5AQaNJaGlPXyePUdATw/3BxSmwMzLUL4MkmvDOgOhWNVNki1?=
 =?us-ascii?Q?Rg+e/VzihxhTIKaaitqze/3je5oftOPOfcruaduDFLotnx+KUbxPXO3NwtT1?=
 =?us-ascii?Q?eLvjwlTEwJyEpkws9IJe26oTYmdDzITOvxlmllklIiGiOfVgf3XK62NW0cbo?=
 =?us-ascii?Q?0TUGhG+NWRqKNDN0nIIpS2wc+qVetBxlqE48e0HS8bUQy9btyOXXkJwQvqZ1?=
 =?us-ascii?Q?QuFpK3OSAWEQG/vRP2LFU/Kc+inoG7yYfhpzgSs5XDDczEi2lnEaWwq9vIfg?=
 =?us-ascii?Q?rV2szUdds1seB8mHJ27LNXE2ss8ZlCMeeUvDXTsWsAMJ/TQFKmP1FqU7Js0U?=
 =?us-ascii?Q?Vo0LFriX4h1xsSNOwA+0RKKniupUea8UphR4fBxJKoDCDoJ6bBtNVbBfj4sG?=
 =?us-ascii?Q?bzlplWP4o2c8hwkEmonUI479wYx7e8M4b94Trqf9QLzZGj/aSCO+d9qUEPr3?=
 =?us-ascii?Q?emrF69bgvntHo63sbZrW6EEBNaghie0MDHCeyvacu/r5auYtEhjm6kiybsRJ?=
 =?us-ascii?Q?MYHttcnAYNuXax21k9cjWYmtGOTTlPQfDlR40EaMjP6q2Jm8jFfxEcGmHQmE?=
 =?us-ascii?Q?KM1Fh/xeOZxpsOWwiugiGMade1dxsAy2T9wfvFFeIoovvmIoJvkDJQ7qvF7u?=
 =?us-ascii?Q?y1MpKT9M0b1iP+23IaJ7Sld8/hqHukPG06RaFwbcWYlp8/Bo934XIACYQICG?=
 =?us-ascii?Q?7Vv9tx7S0vEKGbLKUynh+ULBr0XGL9AiyXsw2a+ssDIt1scVXoTAAzFZ1VLV?=
 =?us-ascii?Q?m1r0wOCFlom/pL4a6Xv3uNlJQQ6/ai05j2MLOgI8uUQujwWHuuLAxyEKRb3N?=
 =?us-ascii?Q?0cd0WEuUVAFWObM4xAkGB33eUcbhZCX8el0aGew6o5raEucmFT4ElMM3HHzv?=
 =?us-ascii?Q?zeSlDmMgQfxSuQsjNwBkxuXqbSemXI9u32B14MIS0JA5pwVY5B4COTK5Ce07?=
 =?us-ascii?Q?l7AMjeMPkOpd6Q6sMG86V6aePlIk+edsYLJ9mSsn1gfaKlhPnvP331Jr9FrW?=
 =?us-ascii?Q?H8iPq76NHYWQl3ZwV4+HuNK6/pgsgrmR6lTXv58cRUfLPf4i7AmC27whY2DN?=
 =?us-ascii?Q?iJ/G5HhN20pnp1BMusFo+x8crrsbMyaPh7BQmlVgZHhYYe+iwcVWz26DKqyS?=
 =?us-ascii?Q?PehmEIWZNckmtap6T/RfT82KhLgNlrPw/KvnzdR8ylRWj+Et8roDkibXYys2?=
 =?us-ascii?Q?SLjoAds2AhOh/QEvHgEQQxUplDYiVqezvPDKdtPgjFvfBi2IYMYoTtnMvPWY?=
 =?us-ascii?Q?OCrA72gxMc1Me2dzGvgu9koGg1nTH9tATe3MYia9fDyynnbOv/zyj7bn/uir?=
 =?us-ascii?Q?2cdbSDzxqiiOwQ0Gd6RuM4P3zut0cLVHU3UVA89qzpKuvknLrFcWeAPH8gw0?=
 =?us-ascii?Q?tCa+nvHLR83i7GAjq25I52pR2OMldOmVyXlriEIj5K3ujvOTgLiGbgbMhnQY?=
 =?us-ascii?Q?3ivoEyOAyfAIye2WTwbiZBmU9wZzLFZlDJspHs8oP2uCw7cMlbdMfoTorC3Z?=
 =?us-ascii?Q?j7UbkJOidN/q2ApA7k9htdc49IozOlVL2XejRnSghpt1MxXIZHmPIc8994mb?=
 =?us-ascii?Q?WMPjh8xUHlZLaswYggyIluxqIhEmEycmAgJqGPiRU8kSaOC5ONSBRjyfbSFB?=
 =?us-ascii?Q?0TSwf+WbGP18RT65svSyi88rXVPV5pJrMK+7hwx2zSIeGuxScBXTTLfpFA9n?=
 =?us-ascii?Q?JgGEagTLKdrnOEC5y6Eek4RjWcWx0SBUXNXwlKg3rjM2qUZXKhCQfwh3ICWg?=
 =?us-ascii?Q?S92/pyHA90Ze4tLW5UI315Wko9edt5qIr+XGck8ZAOb+ATurGKUl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 000a165c-ed26-4d5b-c4d0-08de888a8697
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:16:07.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4x/E50OJ9P+mXNjLRjGMD9htTCTi5yZol4Gnab46YM+X9FuuMK3gbE34L0klJ1SZhID/0wzjih4o9yIHly64bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

The EPF driver currently stores the incoming doorbell as a vector number
(irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
This breaks db_read()/db_clear() semantics when multiple doorbells are
used.

Store doorbells as a bitmask (BIT_ULL(vector)) and make
db_clear(db_bits) clear only the specified bits. Use atomic64 operations
as db_val is updated from interrupt context.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 67cdc5d729d5..741d30821390 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -108,7 +109,7 @@ struct ntb_epf_dev {
 	unsigned int self_spad;
 	unsigned int peer_spad;
 
-	int db_val;
+	atomic64_t db_val;
 	u64 db_valid_mask;
 };
 
@@ -337,15 +338,16 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	int irq_no;
 
 	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
-	ndev->db_val = irq_no + 1;
 
 	if (irq_no == EPF_IRQ_LINK) {
 		ntb_link_event(&ndev->ntb);
 	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
 		dev_warn_ratelimited(ndev->dev,
 				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
+		atomic64_or(BIT_ULL(0), &ndev->db_val);
 		ntb_db_event(&ndev->ntb, 0);
 	} else {
+		atomic64_or(BIT_ULL(irq_no - EPF_IRQ_DB_START), &ndev->db_val);
 		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
 	}
 
@@ -530,7 +532,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 
-	return ndev->db_val;
+	return atomic64_read(&ndev->db_val);
 }
 
 static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
@@ -542,7 +544,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 
-	ndev->db_val = 0;
+	atomic64_and(~db_bits, &ndev->db_val);
 
 	return 0;
 }
-- 
2.51.0

