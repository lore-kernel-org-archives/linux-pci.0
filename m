Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020092.outbound.protection.outlook.com [52.101.228.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F5446060;
	Thu,  3 Sep 2026 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423909; cv=fail; b=sHK35aBQ8R9ztU1+AIwXKXb1chMJHBWaEGdARRy9PCqlwDMq8ubY/SwG2/KQi5em7/IFoyWFB0x7JHQ8UDqR1gb6g0aXczP4Kxmu1qi739GPEc/6LvOsBnPLpg+Xa8Uyhxg1o5nFB0TF7T2Wq6EwXFVddoxn+Dqtnf/lHh0ocqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423909; c=relaxed/simple;
	bh=ZmYRqQuwo2KMt+k/POwOBjZK20DG+HdEmgoLNY+9uOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekgpn4G5QCl8gWvCsZZVE+CQCm1HC91DDwW5P14ppKLEWEe8aN7WdC8xeO8+s21/rqZcSbdDpToBCFQj+gKMwEXNpj+2qhkrPLHBtH1jTHiZ1cq/8hAA5KS8wevq8wiEJZzNGVD3FE+qO6zvEshnmqXkVAIXhxW7qRp4Kt2pu/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DWkNveuJ; arc=fail smtp.client-ip=52.101.228.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DWkNveuJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO0PU7+WjR+4N2+m09O/QFg296iicTyGadgTXpeqtZMoU4vVuMvAxdK7IIEb5VTo+6Zt/L73xQIEOY0mYW4+34LuIiv8BKlRlDwwge7twB8dal7YAHv7SpgVX2arwa2YPizVW/6dfRfKpnWD7KdGgv5P57SJ7+A3LKEvM5ITGNW/gNrNQpUmiRWL9Iu9enwDLxbIHItPzNQ5dlHZhF3NoxA1+3XcezaOql/Fjat8sMbq+O7r1nrJvtohP1hAQXcuaQfxuMDjaoo+iXfdMYCWcor1o4TLJXBeIYanJ81u0T6SywHLVL+SO9GGQi/jVwJMwgkF5Pvm0PNRA9oja6kxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i34a2MtvtkpfcRqGauIC6uWYXJx5+ZyGLGgh04roNjs=;
 b=gDAwuqqKc0ap/9ubcre5jtGQVh04AxvkutJRuoi9Acwo0CunuEkiecH0SmWqKAyOWnubF5Q6yBtdDuCQi8TlBSDY/fHan87HblZaeh2004tLjmwjsk4wo1yrMKFZyoSlCv6sUhG6sVXqyn7PaCZ8oE8uE5VAwsfxgAI3C532lfRhrRZcRrU1qTpSOeCP41VH13sSDlpNHhu0b1F0wYcsfT4N2ntCl4GfN5jiqg1IJR98RJ3R4ANkEojk+t/8J10nxKm31ItuW00CV89mploDRc0N/AE+0hWJnMBOqsb+i86B/8wDQt5YxBJLkm+R/q8btgpPVZfF8k7pxEScP8LqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i34a2MtvtkpfcRqGauIC6uWYXJx5+ZyGLGgh04roNjs=;
 b=DWkNveuJY/ewkQn2RKwtG4StDMi44K5lHeLfwmgeaTyQFAxz0oheQQLeFODuEvp2pV84QH9wUSLLH+OTUmcxqujBB6sFGdgxMLmDQpa76Q5F0sltTm8wmH2pkwd9AQWSZi6szAMGLQt28bYTHhPcBsslvKhOefrKRUkwO1gQm+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7060.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:25:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:25:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 3/7] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Thu,  3 Sep 2026 17:23:23 +0900
Message-ID: <20260903082327.2345602-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903082327.2345602-1-den@valinux.co.jp>
References: <20260903082327.2345602-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbc0fd8-0828-4ce9-74e3-08df0994d891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vEPd3mPOMcp9Tu0MmsEphWb4TvzoHgFgOQGmeZUrgmJ4h+O2onPaGtOkecpKuzCEOii8MzqiPc0OwB+wgFdRSFDx1v1VTdriEnjVx9XTJvMfj2Hc+20fVU7AiVQnlzAaQJ+O24MNT2xDQ9/qfdHL+j+90XP93akkHlzT2NQLNU6aGFqyrGYrqmY2rjFplyZ77UuWygiYjXB/FBxx15nEBReBcJ497Gp3gKXjrKiioTwFO2EoXUTVcGcWZ0y3/gTwj3Z8rCM4akVmYTmtRkZWRnbWNiqKVl52mRCoSA2KC2TfVR+8aMvNtVuWnwF5d662oUY0Z5ss2KDn20OTLlikFr2Sn6gCsx6hxhpM5Y0KHh4i1MIX/lF4QfOFXvDQVcBufAnvZKjFEafcQcdrRQzHW3kkA/IUNn8gtXNhWqkBWVn0E/+j3LqQqXJPqwvfku6Hr09CqJQVIk5fQ1QYhMUpl6qnuVb4a3W5vgDihNb7PYeXTb60v5zMIx5n4SelRnsl3H9XrC7/o1bID8FOmgj67oiiT5+S0dy+mE+erm2Y/utmr5Xm+ZEPayVXywmG1QcBoGmkkIViOrn5NNi0SPPc4H8uf0TSHGITATjRTYRQD/G9zEZ3Yvekx7+W4f8nReELu8FXT5Wm33ZzV8EvLi4b0ABuUP4nlj7Z8XAz2X7Qwvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p+eHMR+C3NShjsvr0hTyGnQiRbp7JcWzYf68tinUyuv1mPvyQm6MwPoPbgU2?=
 =?us-ascii?Q?k0z1eNzVIw2TxYpKREVVcCj8m5aqOeR1nL0OgGqTxeVwEGeYGEgo8jGLc6Fi?=
 =?us-ascii?Q?IpwUAEswcIDFuHule5d6MtOQN9gwFS0H4UHqCWHLPnNUTb8tajTN3toEYiqL?=
 =?us-ascii?Q?1I4R3SJEKUGbbpJmyza1lff8R30Xzuczl/pnRTKBBIz2dgTb1fpwNZ81w77k?=
 =?us-ascii?Q?PA3UidMRS4lXjqoG462K6FTHwBWlJfPQE0egzclyVASUFTN5onppwgQ7bvjl?=
 =?us-ascii?Q?+0ZZT6VtcnJWj/i79eoEiq3htM7K546TbS3AcRm7ZqfCQxQ6eYSQA+mmoKWv?=
 =?us-ascii?Q?hxDdpfuoDV4rqCn8nt/OVviCSYmr1qrjh7C1tGJ+6cJY5GjaVB1rxQGfWUn5?=
 =?us-ascii?Q?Y5te0jpHuMRhkS0Jwb6h/M6hF+jgbf12XPrcVuji9aAXqb9o7UmDmpvpL6xp?=
 =?us-ascii?Q?CRco/wMM73pxFNkPmcvf2/L9mh/TF50hdfarc2F2BIobSqJQlr13ggm6u0NU?=
 =?us-ascii?Q?XSG4vSid0vcW4g+7JZtaOGyvssjYb+GoqlFirvZOPIG5avjoN2CNhGpqmOfG?=
 =?us-ascii?Q?GYW7m4SSr9UD90VB/KB7d31Z14BOSv+YU7+1ckzdlJE4Uje0Fiu8PBy9EHuc?=
 =?us-ascii?Q?oiHXd+I4fR43r6TK+ZdnnnHf/QsFCwcglZzT71ptiPewCgPYG+JXXKqQXBwV?=
 =?us-ascii?Q?8U1TXw9rRxS6L8mrersEJMSU+QSXChIHXuF4hhs16Oc/s7WPT+EfIQECwWBl?=
 =?us-ascii?Q?ItCsr9Jk2eL44GFFTIZh+zmhwULGmMNHwLLX4JK1MtgmCmFMdaZbn9pDiVXJ?=
 =?us-ascii?Q?h/3x7Alrt1Ulqag1KxbmjKwzqOH+qYCPDec6avyjn/LttFwAHCQgZ3cHkFJz?=
 =?us-ascii?Q?NrwIfykbGvgtDdUFOMwPQm/3q/EVp1F3zUFOK8ZoL/R2IMxFcmDOYBrC55Qa?=
 =?us-ascii?Q?6nsUKF/UDmtqHpZKbzGOKbhweM0EXzYzd2PU51j5N3u6/oEAw6odKqDTjA7d?=
 =?us-ascii?Q?hFQT1eBIzw7C9qlomitkNO2XJPqKsu/Byab6FvlZr85sP43wY9I2BvOPQPSU?=
 =?us-ascii?Q?BDgE/i5U0ocweOas8sEkdtxeis+7oZZuKR+8gXMtGGwfMvXTHyhvWvroYi7v?=
 =?us-ascii?Q?1HVjHWeoUhkJhe701z/Yzx9p06x1iy7piwcRYC2jVYC0kRFf696R3Eceefnq?=
 =?us-ascii?Q?KBFc//i0TyE6XFTJq5cXZYGOjthckLaAK/kGaDcrvTD96t45wQKf0ePrKy7Z?=
 =?us-ascii?Q?monTRQUcbfVHUpNgUH9gTvKNNu/TyxHEBKTEpJ7JtrMzi8c8pNcd+Augb2EN?=
 =?us-ascii?Q?/3tNuLpifrWNmiV2eRAlh1SsM6NtiGZUZxN2G4kGVhSsxcCyMl53BskxaYg0?=
 =?us-ascii?Q?kJpgiJLuYDBBv2DRr962kaTxtokUaUkS6jJOGOM3TskWuPEttCTaPi5AAqBt?=
 =?us-ascii?Q?aePf2ZowUyz3u1GQL7aAHPb1SzRlvhRY8niZ4QbMXyghQ9KqzQIftrHN9IfY?=
 =?us-ascii?Q?ukRij1jUiPdXfKAI4yL3FWPVgCI2Y4O8mGt5/0kKvP8tDxO/+FU4+zjBdqQK?=
 =?us-ascii?Q?anARPE2sj5z0wq26EQgdaBGuFB7yrlTyKod3IkL1HG5FeLJvRKwIcjVsXxaK?=
 =?us-ascii?Q?nhj+xBjElIw1NI6X9CmIFjLJ5cJdS9mUW0cJ1ADR2ZFP11o7WyGGSqtyP1Y4?=
 =?us-ascii?Q?Ertu2j4im+PA1j0qiGaRYB/BxB3wU3V/Z5IkEBPZsbiZw7PpUcGhka3MNuwR?=
 =?us-ascii?Q?kqOPExtqOG3DNNPwhDfOFXsf3B4Bcj3eJGoyXOJ1qculzk3cSIwB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbc0fd8-0828-4ce9-74e3-08df0994d891
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:25:00.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz6ihNjyULwFeL08Dr18PqRIQ3SMVj13PEoZ+mgAVul3BOLzeb3pxmg+68XPb28PxzRJl1l2iQhFXOd2Y+9Pow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7060

Move epf_ntb_is_bar_used() up so later BAR selection code can call it
without a forward declaration. No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 992f5e7f8d4a..73479b5e5d26 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -204,6 +204,26 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	return 0;
 }
 
+/**
+ * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @barno: Checked bar number
+ *
+ * Returns: true if used, false if free.
+ */
+static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
+				enum pci_barno barno)
+{
+	int i;
+
+	for (i = 0; i < VNTB_BAR_NUM; i++) {
+		if (ntb->epf_ntb_bar[i] == barno)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -841,26 +861,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @barno: Checked bar number
- *
- * Returns: true if used, false if free.
- */
-static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
-				enum pci_barno barno)
-{
-	int i;
-
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
-		if (ntb->epf_ntb_bar[i] == barno)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
  * @ntb: NTB device that facilitates communication between HOST and VHOST
-- 
2.51.0

