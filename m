Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020092.outbound.protection.outlook.com [52.101.229.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C439E6FF;
	Tue, 24 Feb 2026 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940114; cv=fail; b=hP9qUKDvYBQMlU/Rzhsy3qugGZLyYqLteNNlM2e6cvgb3monAnwHfqweyXDQK3Hb6vNG8oyrrHBHzw6SonJg6ulRu/vMKmOc6nZjnTZp7Yso1tHGlUmSqegY6idqlKQgCOaLuDMOZlZkkFuxU3JjBORSYL94nTxfb43vlImU3dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940114; c=relaxed/simple;
	bh=xcONYAJxw0nCRzaQVoy43uXmj3Mg7zz4s0usCBCg5oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Af90bxkJ/GrPP3ZYn4oH2Y82L7sEIJuxPQf/wdbVwglhrjQyI3KqYE8im5fQ0roB+ccDM/tl5I3SM9d4KfRnRTGVr6PMBJHO0yoxc+dRgivn+KQ/+qDf5Z5SBZqBZ0/G3wW91NFRcss4ZoTJsbvSnXKpHHiX4TfN3gnC07jjrvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=sS3g3ALm; arc=fail smtp.client-ip=52.101.229.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="sS3g3ALm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZDwudG5MabDa9+QSMkUnUSlGg71k7YBE4Uy+anoHUJ3Ybf16VkBPa8mGRxp2+yfxuc4Q3GzWtjiip1OcL6f9LCrn0KB5NzHe6eYwGf4hob+WRpc9uT/Mhk+nX+sylG7HNYN6AhrQOJJW+jZRQbBtzxBgdxwBCk9BJqlGkcaiTMmpO2ww3nMgYk/prsSLiKqJa1hpJu/iMJ0bpuT138EIGFWT430MHmYoBfNPFAUxQEF7m6N9QiVwjnJahJJnO4k0HecXeRNUy1OkWqQRXDbPeGwdSyWEFf5gaIhx/7wthzbVCvVopd8m8WAeh3qhZUpf8r/YaLwmBdqU24iTilJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvgFJDEA30LV4mWUU7R4FOXMO1gxJIpHPIVkLbZae9k=;
 b=RMIB6MHfDKOTMG9f+CieJkFcpJcE2/azSz7/TZhf3irR9W3Vi2ICF1kU/CzY1r++75cNd7gBVOgogZ3Kzkw+6HfEiQUDBhkf++wGC5RMdfSNCNLLNk53aTNphj7TSEpKYWsJIF2O/OTzUMiLjv4mwOvlY5c19zVdjm+fXsnOVBShJLEEHG/QiYsS5WtMsBIzRyQok3uJm6uDcaBCPZrTOzi9Z5k4K5SCZsBqZhVaPk5H+C9ry1mm7FIe5pUKj9ljlRbAd0tI1HkB/e7Gerdka1LBS2cHBpOOa9wS/+eaCTNDV/K5A5Qiv6anxe0atmdjA+Ak884pyJK/hLjJqpPXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvgFJDEA30LV4mWUU7R4FOXMO1gxJIpHPIVkLbZae9k=;
 b=sS3g3ALm/SWAGNW4EJBsVYslKBBoX4ADIK/zf2kCSWJgLZ7dg6tGL6qqV5Mm4BD4QFptPKmL+DK3sPu4qaU5eC6vA334qhNlc9Tba9gEW6aTIQrcqePHzEg49EwnLgwknCngF4g+llUdfeh7URNwg0gqyPVvA2QbnSTv+IHozAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6278.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:08 +0000
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
Subject: [PATCH 07/10] NTB: epf: Make db_valid_mask cover only real doorbell bits
Date: Tue, 24 Feb 2026 22:34:56 +0900
Message-ID: <20260224133459.1741537-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0318.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad2514d-bce5-4672-09c1-08de73a9873a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NfbJspOBlFjsGRhIyWT3/p4/dk+4A3L2R4BWVjuH+GaGHEdq0c2vkW1TxZu?=
 =?us-ascii?Q?lTNiMqEFTOAvexBymWJsG7sGg+6rQjW2KB79p1Kn1jgr13FAnS2JDP8/kL9p?=
 =?us-ascii?Q?HKY0u9jc+yVXQ0WN9v/edapI/CiWgTP6pG8Av5GXbq+ngeSZUMr/avb5nWe3?=
 =?us-ascii?Q?2B/QT3CwINwgnSYjzuBPwZC+3imQ5usZ9hmuLdblKxftnImahQ9rz/GUWsa1?=
 =?us-ascii?Q?06GDEtUnkRDDTvMy1H8DN0jzB8siHNaSsnUtlm6yCviC+RYFzfSYCUe3C6w3?=
 =?us-ascii?Q?kFZmQE1TCLl3DnnTngepxbVm1i1ClI//LG/vjRhIhqaEeRwkI/+QwhGz2BIl?=
 =?us-ascii?Q?jaG8SPO2uDPdRMikmhPyTfGRQ+Buxi/nn67qFXXzTkBUgJKC7VHIZcUcsQGe?=
 =?us-ascii?Q?j4mCorO7c7dpEF4Rv3VFYz5MKInBRo9yy1K8/7juMh9D48d7DV5QfJkhw80E?=
 =?us-ascii?Q?wUj25UqVouYwkhR1gcNObsf9eByBBvZEcTnQii9LZCFFmYjC5W5+xMt6J5Kt?=
 =?us-ascii?Q?QYElA7a36WAAnS7BLc/OQUkvz02M5uIoAB3RttXIdn3IJZqAYYhF2QmnBw07?=
 =?us-ascii?Q?4UdQsSbLHPF8Dgh0cU1jdgoOfy7gnUGCcXbyvc14VhCu8uieXvEn0xiHa7OO?=
 =?us-ascii?Q?pYbzBMcr1KnMUlaZAZoqjVKZ4TczbU2DxZ43TVEN4+Nnnnl4o+aIvrzaChe4?=
 =?us-ascii?Q?IkoPuqJKJDmxx9SQCqKiVImHVVlbESCWnfgGDOWiQ5Hmn+Dy+7QeOZ1fqvoh?=
 =?us-ascii?Q?/BYUBe3V6b7av7bZ/g6S4bnSOKvi6lFlQerIm0V/rrgwvEQmC3oZr2o6pIK9?=
 =?us-ascii?Q?gD9lzqYPjAeOS+WuEsJuZaZYXc88scCDzopwZLJEJvilrzaNQUC5kBC7fcfI?=
 =?us-ascii?Q?dyV1OnxuoUKTLZeAkIJS4Zjg41g5wa4Ob2kET4DW11SYKw2mMamXjKBKG0Kf?=
 =?us-ascii?Q?uV0Pp88Dm58EuIqj7OctFdKjnyiTey042ItbHd26iTtpMefrixH3oK0u667K?=
 =?us-ascii?Q?UF2otXK81yh8CxHwM66Y9jxokIpxDOESBEQ8H7IGK7Hl7wgjkSG5E20tmgID?=
 =?us-ascii?Q?nw82SViCYIfEfg4Nz7fJ8coRI+EMdiW8RYcRQ0Hqg+KlWr5Knqd+Xm073HXo?=
 =?us-ascii?Q?QA84tBH4IrJyyvzYW0oL0K7RpdvH8fmXcKUpUmcJG7wMWe1TxO9C/vfdGbfB?=
 =?us-ascii?Q?nWkJ0Wnxo7khVFIuIXBlB0lCNSlwN0VvfTE6BVzLQ2M9Trzwa4TJJzpUDe3c?=
 =?us-ascii?Q?/JRLv0dbfoTe/K7uFeedRvpP6Ya6jA+tqW8NX+Eoc/BObgTkAj9p0AbBNAlt?=
 =?us-ascii?Q?aaIadx/iNzdo6vAomSfYt0v2LItFc2CZSCFaF8F51p+UJPC4R1n8tvyzVrcM?=
 =?us-ascii?Q?i2LvaUhtQSKhtg9EU5oglwzOl6mrsBtKKXX8qDLESO5XYnpxDisqPubhsn43?=
 =?us-ascii?Q?Vjx5725H7pY8CDRNEdzPImdJmbDUKGlvqwJySyl6NYFY/qUv+YJBz17jrmc/?=
 =?us-ascii?Q?4tYB3Of1rRziksl7js23Enf1uZsWocwkSNySso4RWeaLlBKmlCACZg5SO88s?=
 =?us-ascii?Q?vdVxmucVRB/5gg/7U0AfPsBu7X23joCa5WOcXeZnotnGKY2aoROpfbb03Zhr?=
 =?us-ascii?Q?Qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MXWCxBBPLbYY5xHQa/qzU8XkWFd6KBtO6IKQlxZJzPNIz5maUAKBkBEIfZCC?=
 =?us-ascii?Q?49oIT78I6syIT9b/ObpB8L/uc6Df0lIIL6zXRSc5AIqdJdSg7Ll/YzEnWxyQ?=
 =?us-ascii?Q?0sMZOem/0M1lmQRIrXQJVF3zS59dujhj6I3MzikiqWCPMhPGrLjDAElNNCvY?=
 =?us-ascii?Q?4gJm+9PGP70ikjbxes5+xmxD6yM4Lh4bu1vAUTUj0WD2G5EChkYRtrqHo8Zv?=
 =?us-ascii?Q?4KdD3X8LuuyRIDQGoQ5yWQGEzvjvWb+OpgB8c6lnmvtmWsEBQR1QV7lgoIBp?=
 =?us-ascii?Q?ktDAAmb40q84t8y4QAVzOIfkl+vBMI+qS+XMYmECFLRZ0iQQJyUYOshi/4Uk?=
 =?us-ascii?Q?bRWQgkglxjWNdKfi4JSF/LOFWK2qZ52pdDzyLJ+h4yHMl+hBgrRbPEVLtJzA?=
 =?us-ascii?Q?y/sipR27UMxtPI7sFuenjvH0oyKAnGIw/sVwxB5j3nCJikAZme3qvHXSBxbE?=
 =?us-ascii?Q?k4UdFaMTUnMaxi1XIM6fUFrJeqHbqvYtYl8oBboSC4K6cHdLOzte1j4AtEGw?=
 =?us-ascii?Q?NI7kY9VK5oQSOzTeLqOXnokHI9K1+AOLgbLiDMFRFzwjJeqIiFFJaEu1Ey41?=
 =?us-ascii?Q?dspeaj4yNm07auajSdZsIEHfZ+eWHRbsda1no4y2XHfS5vOAOFu8yjTHyhlv?=
 =?us-ascii?Q?KOylVMpM9ANyR0L3u3Alx+f9R7kefC96agTTI10qvHH0N0je27FWusE6pM/t?=
 =?us-ascii?Q?6THk8a06sV1p2ojU8zXVH+z/xl32tNOZ5CwXbL59TtLsiGLHtCJaz/yy7ai1?=
 =?us-ascii?Q?9Odnsyw5LAwUUCjkbOyzEN9n2ZQyduMOSv916uR6ZLl5FxPGw+czD0gmoa+m?=
 =?us-ascii?Q?EpsqLkV/c9RN8SkckiXidHySrNSO9HZkh+u3vaCrhxg9DXCijRerDULgs7bb?=
 =?us-ascii?Q?n9Rank/9B7LL0PMd4KOSPoD4bYkyCyMdTTZtLt/dGYaUnL6lImdznibHhH0V?=
 =?us-ascii?Q?15am8QEFiftqVuAYenJcKXesKBVJkgeCCyxHFygpWLu7f9iWfx2mSjJq0Tyj?=
 =?us-ascii?Q?r5wI9JKx2icIjbTkqekrkQUsFanmDVnmbZMw0eHDmywEEE3TLwUfc6SROfIA?=
 =?us-ascii?Q?hnKsLXqUbaWpNZmPi5MK5aC+wjjcz8ZlhVcMAfWwJY82jj90goksxvf+1nxS?=
 =?us-ascii?Q?PVmna48x5S9KVzacDYg+A8XuUIpTXIMbZ4KFmUEUIHqdeFUwOad4dNGX/Jfn?=
 =?us-ascii?Q?ibSqgvCdV2TDtR4ZBf/K/4d/kG9bDRcDa9D+uazIKLl9KvXJ31Zp5FTb6z8v?=
 =?us-ascii?Q?4NbLplsekncCz7r0z2LZTTgeVvedSR92Qq1JFmes90D+gBqmIixoeWBpD65U?=
 =?us-ascii?Q?GQ4gufS3S5bo4FKnFZIEp/jR/c8Cb2W5PXfelCkt0nBrk8Cka9CqdthzSWKd?=
 =?us-ascii?Q?Xg3OCqPTGS+k+xDLxRvcjysJfo5W1YGyywz1+X8JB1ebtyhKNt7GDVLjikPl?=
 =?us-ascii?Q?upS0eQja8BpUxuZnDsdOOsIgHuDPEZom31K9JWCMqitGr1jtzkYakkHQR9je?=
 =?us-ascii?Q?L18bz10vH96FNBk3aWH5O28GJ5rsv9gEIZDa+aRyckr2BFD7oBbw9tSVEzf8?=
 =?us-ascii?Q?3Agbj1F4ymzNOq3vK4FzGBc9o9shZ6HAWzzXSxCmUr7A+wATQBWKYjbpXGuJ?=
 =?us-ascii?Q?/EIGyeu030Ft9YEbLgNffrqlHTUSYna9yoAV7J78waaWQOzePZecUH9msepe?=
 =?us-ascii?Q?Til11kDCg0hl+UAv2zKGK+1yaClKDO6tqNT/QMrZcP4qzt4YOguauuXXvvT+?=
 =?us-ascii?Q?hjqHhUUP6GhsiMAbAGA9a+2myGt579zurUwNGAfdGHIk2eiNBEJT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad2514d-bce5-4672-09c1-08de73a9873a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:08.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HD4XRbdn6Wi5/9izT1xQld7KIlJceiyRFeIykWEbC1znIz0ap4fUrV4Lq6VK+EViZiSF3mDfF3pZosZSbbQk8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6278

ndev->db_count includes an unused doorbell slot due to the legacy extra
offset in the peer doorbell path. db_valid_mask must cover only the real
doorbell bits and exclude the unused slot.

Set db_valid_mask to BIT_ULL(db_count - 1) - 1.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index bce7130fec39..ee499eaed4f3 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -580,7 +580,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		return ret;
 	}
 
-	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
+		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
+			NTB_EPF_MIN_DB_COUNT);
+		return -EINVAL;
+	}
+
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
 
-- 
2.51.0

