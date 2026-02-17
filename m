Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021097.outbound.protection.outlook.com [52.101.125.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C42C0F8E;
	Tue, 17 Feb 2026 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310352; cv=fail; b=H02uEmQy44qH6FSp2o+q+fqprb+RysnBmyuXQU3bFfYjLZ5GNo6r3yv1GCQ2AcS8myDSaLl4o2Ngodz2uGbTnc8JC6VMQZtrURyAKI8y7x6xd3v5zXsxOkqz4GRbUpJ/A21QptgLgf3bUwrilK+dMoPCcEpig8VrVwLMzIskSPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310352; c=relaxed/simple;
	bh=yplZ7MfaBOegIpjf1jWx7zJzCu3QxUeMgxwUqPkqwCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxB7ZfntESZ1fe6DzkmQQnxXDJRSDsPMEwvXNDNzRRQAjNlpNNsR7XhpoMeD/5qTkpC8A/EnIOEpBb0YoqhEgUa6N1nvalf8FTLTOQ+DiQJHpr5j99FNyh9FqV1R/K5AqOUbVp9Aqllyy8gntND5ec8jT3aIZwWUxlOGTzlLq64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=N0plAydD; arc=fail smtp.client-ip=52.101.125.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="N0plAydD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbosxVjp1zjRnKbi3SVdAn5Orp9JaBDgbwTf/T1vuh79rhH3Y4jH16OFMUTwr5xa1bUz6KrXrq2F67DdHNedN6hvGQHccMFqwE7D0fduIA/3ENgXVVxj1ScMDo5ZtG9Y6tP6xwf5rldLm6eDJhRoeFVb894ICY9wEkp7GWYlz2kcH3Y9lFNjldoifbYJ37L3acf6D5vE8p/4SvriPbjWy5FuSxk7ifMWj8pyFEyC4OV80lr50DSAtk/tnUPRp0wJsbLNnv6Y4w4mAam6BDO1UbaHkb9Sn86GRVoB43wAqMyI738r9sRq8PHYqn8F3EHtDoJAf3yd3Fme5HIe+g9GDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UaumhoG0Mc5jj3re5SQuj+5eOfdE38/HMjFKCjENW4=;
 b=qi8SJgMFPJRWRvsVVOE2CFAXUfAtbGphWIDSWTiBWZPqGvA8oiI8uDHtLsiSDxnZfLaeHzOvXz5zIvsJiZIdjjkfic6w1mppKDKKvdSvcCBlezGG7CjyKMccbbK4ITT1EcvBLFaziMn8Yu/SIDKq9aCprl4Jp2LnnIjKo2aQYXjiMqN1Q/EbZsCiIrzd7JhwbJenXadtpsFQ4BWgy67DtzwagJhgS9LHixS5KhKsA9kBJSR2PJHG6ThBaPrED7MvP9s7ZtFmf3o26DfchMuBmJEq9Zf27rsU67En6PS6ZtgbhfrdQ2r6pPZGjwOOZ+hOd5UzNgTqdS31JUUQseB+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UaumhoG0Mc5jj3re5SQuj+5eOfdE38/HMjFKCjENW4=;
 b=N0plAydDTFSEeWYsau30jaDOYDw3cZQpQ5X9GduBVKM5ojH3czTvg28eaDm0PykgGiyRrTFFJfOlSlWnQ/orM6h9N+sbYzHvNbyTQeWLnmTfQs7plzcypbdCoqN6aiUY0f3+MpGR+J4U42lI843wVf590fKkMag4hrnxJ8rv0qE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7477.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:356::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 06:39:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 06:39:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 3/3] PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
Date: Tue, 17 Feb 2026 15:38:56 +0900
Message-ID: <20260217063856.3759713-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217063856.3759713-1-den@valinux.co.jp>
References: <20260217063856.3759713-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d90795-e7f9-4110-5b0a-08de6def3ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MuOaMs2n93ufOrghNB67bgvHqNhTq7G+1exzFqWByy62lY31swyXJG/WkCMy?=
 =?us-ascii?Q?9duyk+9UMM9ij1ougmkNN67QPBd8JBSQXgUYuGwD1QkXK6GcnzQEvU/DFi4t?=
 =?us-ascii?Q?7PLNXWC5M7L7fKc9skZGNIAhOEYbTrrEN3SlxKeONBYcezU5/JA91Bk/KECO?=
 =?us-ascii?Q?s+Dnh5NRmvaJwo77scbaSiHYLN719e8DHd4hSJeDBH7Y8wQXU7j/SUFfYj1K?=
 =?us-ascii?Q?JbsuLOm6DOLa6ii36RrWTVgaQ2AxubY2roEkAyXafORgV+qYlxRL0I5IeRi8?=
 =?us-ascii?Q?+UOHKaSnhsAK/QN8yxirBoIxl1gfWpE/rVq8RTWxWu6utlI6dg+dOAW0eWKd?=
 =?us-ascii?Q?X4PD3KO2IxOVzne3rCjpX6IiRl0b44QmEqyNYKhnYIvCHfuQkrC6u4wYNvLv?=
 =?us-ascii?Q?4LP76HoJ6St5HeTSP+2phrNFM8p9y2Cs2vMo4tDn3PVViEyLXPLQIcj6sXrm?=
 =?us-ascii?Q?QSqssNMvW/YV6Mao4VMXof1uUzvteREEoH6thXr+Pfq7ulWd8sBGOLfCwEDx?=
 =?us-ascii?Q?dbOJloPohFh0UYMBtn3VpmjuuXsI5IJ4it+t5Xue/DHLPosTJWHA1HV1RZQo?=
 =?us-ascii?Q?nrql4yHlhblXbBUNa6AsNMeLHw3CZoGI1d9mX/ozgniWeETebOUUrALPty0i?=
 =?us-ascii?Q?83iK9t5PWLjMxiN9dFLrmGTAOC14vSfOxhVwqmhCBwVAQUEeY7dyhYX2Hahs?=
 =?us-ascii?Q?NplELCuULp9VS7a8MGSU8V9roWHx+Wl28SA0zUcpgamtXXfUeN0bvoAR4CBN?=
 =?us-ascii?Q?qUTZpNT3FK5G8tao335JHIG89j7BUTqKXSkoAFsfJwDAh11dfQAd3mKE0p8X?=
 =?us-ascii?Q?9QnT7pSvTvWfyqvO376E+Q+l70hxoE2aNhzo90mq23ne0vSh2V7PEzRVU4vU?=
 =?us-ascii?Q?gCDpHzttKGRci0HwdBKfsSC49pRySCJ2D0EZTHp+4+2ld2ohj7xEKLEo2snU?=
 =?us-ascii?Q?cenzZdNHrB6zAI299OW6u25msjpVidu2r6+UhgvAuoRhuFoxLYiBwdfPJwbH?=
 =?us-ascii?Q?N8dBLbL6OhVp+oGeljTxI8cz8r+TrQ5bocX9P0bVJ1MHuZVBDVyxGGR9pcQT?=
 =?us-ascii?Q?J9o93rcdXTi3fP+9B+OZ6lmWO5XNgxOCxjlCr38r6Oc7Gc2PP3h39tw0CsM5?=
 =?us-ascii?Q?iR9MkF4wjELSnya3aED+5K94fjqEyrwKdvcmm7V7GwcaNjnJew1Pr6Hu3IfU?=
 =?us-ascii?Q?OnBwYRMvYYDux3xTbMHYCslmfo7hcdKfzqsGrFhFlGuVM7efXy2Ugnenkm5x?=
 =?us-ascii?Q?PzMufdEKdNpgbkWs2t/f5pOVDwxnQ7jLRLcrA72RWdtRf+baA5lGh16+zG7z?=
 =?us-ascii?Q?fOtWPHnDKsZLRlDqK3kmBm2IRL65HPZkWAnkjNDbFwT5M3ojRmWnMLaXLZAx?=
 =?us-ascii?Q?yjVq0TY5+POCxtzMCV7RrG0j8cOZcYeWmOahfiQOwuUG59p1/F/EcT9DRCr8?=
 =?us-ascii?Q?qcASPvUh/JhU+stxHX53B3eKY+ufENcEZM18yiGecHDos1wsic3tKxwzhvRK?=
 =?us-ascii?Q?4c3OmepVy069bcGSw+0Wnj0BYsE0zFzSxWJCsKB3Zsm9BzwaKl5czuFW85PD?=
 =?us-ascii?Q?d9XW2JudCn5lG8kuSS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?akKL3DeQx/zfY9YR0yQEtZHDtBCaOUgijsbadFsKqo2vHG+bjVtAckQ6Femv?=
 =?us-ascii?Q?Frh6by84XgI+A9CvR520SyvVD66wnZlEh2OmqbQN8RmnOJIh8giG+pdo88Xd?=
 =?us-ascii?Q?o3yHqrUFKulEgpMS0UDVbEzCRRtJdG25XCcV85ycvrbeoRZ2P3Gc//q+ZhvV?=
 =?us-ascii?Q?mooMUZzIY9tJmaH3qqzTMeVALRqOI2VsVVzILO5DkmDujOoD9wpYmaOGmDMn?=
 =?us-ascii?Q?EA0/z5HgVt/SrNdx2Wuc0lB6BlE7D3AO+lFHsE3eA2cjUIpnEN0g2S5BleSz?=
 =?us-ascii?Q?0mUHwnNAGK3zI4XX4+bcXg4jMzB6cA0gltaFMQDAFMzUm2m21KaShkT+n1nN?=
 =?us-ascii?Q?HsXl5vsmOV7YE/SEhw1f+TALwr4WPVBW9ldkCzWCzgz2eTr3cVMsZbbS76AH?=
 =?us-ascii?Q?a6qOTu4f4/6cqmDznSUbN1Y4N2BMho418W2n+yxTShiBCTxvTgdK498yOQC/?=
 =?us-ascii?Q?6FHxNa9ziIqVFs1qLbdWEcRyJ/TTpYHvKckxkexo9MWpDkuo68qbKeNWIT2g?=
 =?us-ascii?Q?GOyIsLPIelU1eLoH6j9uewBg2omcyi8874QGhzm1c2W9+No937KCcPbylIei?=
 =?us-ascii?Q?hDRL+B296X/+j0lKHguT2r9EaoDjrl5sLt0l1SHjmuAUkVh5QhkMlzjXqglx?=
 =?us-ascii?Q?IBKbAPiwp+AuaN/cvr6I8+7hAw4uXwPkqEc//725JsZjlhrFFJASZqRT1Kun?=
 =?us-ascii?Q?eFXSqCKN3UaL22pSbdXD7mp3yIJgT3ukirof6jiq6FdFcu+89A9AeqWJfZJ/?=
 =?us-ascii?Q?U+qFxJFlWDBO+92SXlV4KmJyqbzCREawAGX7opBB/3g/7GBfBp+5DklicjJs?=
 =?us-ascii?Q?L72ZQFs3EKaIsoRJjI9nRcK3GwLS2Y73Jyy4XjzJETh/eA3pO+5/KtyZfklN?=
 =?us-ascii?Q?tiPUPxwC7qYq55CUqQBcHTU/T449SIZcGHKnMYO9/yQKkTC+jzkUviBniao7?=
 =?us-ascii?Q?uynxejS0MJCg+ubTMkkg3XRp/uktiocOkPgeul86GdtIiK2+rIXrrJXHOKEt?=
 =?us-ascii?Q?e3VISu1i1Ns8kxsTw5Z+ny2GDsDWhlc80T1PdY1Q70qE7z2uEnBTVhC+Aufp?=
 =?us-ascii?Q?rVaeDjABl0h9Yq02cEfz+2pO6wd8OjeJPIgp2Hk27Rei+u4CJIhqMmjb12Ey?=
 =?us-ascii?Q?jNg9moUesWBYHl74dHchbmOdoEPHuBBbN9W0dkDLzkenmfRW1qRiWBvI6Aro?=
 =?us-ascii?Q?59gAoI0HaKU5RUdwJI5rxiprDOl7K9tdynuDpPA2wgtmhExcIwjwUAsqTRia?=
 =?us-ascii?Q?8Pil5/jv3HxIKu0MJlSGxrfG6xSK+hmq8e4u9RCVKZyFFbyPzWy5KIADq/BV?=
 =?us-ascii?Q?+z9CBYZ0pr2BvQKJtrdpq9Xl97uqfMyyZP/Y6vVjcFmZXm+wt5yOFFWt93bo?=
 =?us-ascii?Q?hQD59YWVqW7iiWSR5x0ZVPs6LtQuzBi0l03nUoRoUrZl6Oh+TynSOtoLMYbo?=
 =?us-ascii?Q?VsCapPwWIFTcAi43ESg6TdPkU6N8u4pK9qcEN1oDOAGUceGk/kqP+fNra0Op?=
 =?us-ascii?Q?1jNyqyFyLimMeGp3Tf/FaKs/8pJp4wxhwumC9If9oiELax9UN6u4kzrmeq3R?=
 =?us-ascii?Q?NpskhRid0j9/AA7+e/k7LaLzPSmBH8pKFDk7VuERRFpWSNdaWH3kbP+bFVOd?=
 =?us-ascii?Q?4diNnW0nl8ihQbWtFu+70YTgRBCyIfXG9VRJ/IYKWyjP6TE8f7W3EbIiFQDS?=
 =?us-ascii?Q?Kw42yr6naht3+d+IvevAEyKXaW1/bkhzTHbCVJjhYBq5WKqE1tU56pkcfL4F?=
 =?us-ascii?Q?CNHRq9gh5a+Cj45S/YP7MguHIwJZoG32fR/Adis6jUy/JHenHhCl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d90795-e7f9-4110-5b0a-08de6def3ee1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 06:39:05.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h45QNgNo6/ftK6rJVZ3sE05c/9TQ26JTXBYVLb7XA4i41dVJZLnuA2Nx+EPRx9Cxd5OBbmhz5zkj2so+Q9j9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7477

pci_epf_alloc_doorbell() stores the allocated doorbell message array in
epf->db_msg/epf->num_db before requesting MSI vectors. If MSI allocation
fails, the array is freed but the EPF state may still point to freed
memory.

Clear epf->db_msg and epf->num_db on the MSI allocation failure path so
that later cleanup cannot double-free the array and callers can retry
allocation.

Also return -EBUSY when doorbells have already been allocated to prevent
leaking or overwriting an existing allocation.

Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 1b58357b905f..ad8a81d6ad77 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -50,6 +50,9 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 		return -EINVAL;
 	}
 
+	if (epf->db_msg)
+		return -EBUSY;
+
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
 	if (!domain) {
@@ -79,6 +82,8 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (ret) {
 		dev_err(dev, "Failed to allocate MSI\n");
 		kfree(msg);
+		epf->db_msg = NULL;
+		epf->num_db = 0;
 		return ret;
 	}
 
-- 
2.51.0

