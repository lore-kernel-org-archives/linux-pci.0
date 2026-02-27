Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B613B8BD4;
	Fri, 27 Feb 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182223; cv=fail; b=DXG1wZTv/7GHsuHSLIJFruB+lFaDNIXEtPdS9ORnpfr280rzVMzgd73IPIXl1zl5Hj+oZI47CTgzxhH/qZb7ogP5NqI554+Cwh/7OkSDd6wMnmP/ikJOyyAXzhobf8hMILbC92rARn5OvHw3E9w7UciYTsfy/kJS5As3OtsOsO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182223; c=relaxed/simple;
	bh=vQrX+hPHoVACTDuFEADHMgSw2Ha+DMmirrfI/OVy2SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6vLJ3NJ69MkvsvjrQFFAfEQUqZdQiTQl9TOzpADLQvMUTA7trD3UbbmH7GHBgaMLWhUuJly0ITIZYPovFnP8HZfSMjKbcZOw/Eax4SIs0vAhXqEhm6nF+huM63vFwVm9sVP9WeB7P7sjKBI3PEX2e3E22953/XblMBirJd4Ygg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZnhLclYw; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZnhLclYw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXPnFz1XxYUXMa8wb6UjIB9UPpmVOSmKG/qGhp6+mylDxG+4gOAgDj1VtmMWRnAvXmlyecK8k5KL9B2lb+M53RHLwiY7OEYA45rhe53HA5I5fdsiqiC25kMztUa1dNrEeBs6hRm/GgJCQmmvlKuwcGfcQbr3IBo5w8zNzatZWI0F02Ticrj5XZGlD9MyYha4mJSSedUzyor0KbqW1aNyqt17BcJMlm/7XOTvfZclxw5D9l4DHGYbbOi+mQRDeYUK3exV3KrDakaB/+qPM+JwmsBJfOWI+O+vGCJXppVeZWm/a+NbPkKOICtRRXbW9S0MgZ0cfoevQ19D7bRHZXF5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5LYrye6HVBsqsCtVF4MTnDbMB0uWuo+tdulik9VrxY=;
 b=rh7mMMiNTpUFC4nSk0G7LhwDdLTzg0W6P2cSlqZTPpNFX7ogLUxFL46k73oZIExETtWAyzfEFuI40n3GgG1WbpUYF6ejZdI6OQeHZiuMoE81HeNSjUVdea0GOSQ+KzAmHsPfRioxXJ/GOrbAsIQ5iY1S+j9yxeeGWmWn0NR9ybiUAWsFy6aDKlTxZovBLeF/4HoDIKX8+2dLKw76OLV9h5gKsSMSxAkwv/YSZ1EOUZvcgKbX+FhHSTlZzaMkcOkxNcf3yuijzm2xF5uYtkR/6Zlyc1j1cXAAKWEAQAjpHg0fl9L5jbBFNSkft/98PksjyNa+8twa7Udof94sUFf0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5LYrye6HVBsqsCtVF4MTnDbMB0uWuo+tdulik9VrxY=;
 b=ZnhLclYwF9OwEvOb/0j55cI9y0WugEfZBOXLYgMVKx96uo2ybKkM8oQ+bWU6iRlutCkKjDCLcl28HdstAHQdSYG2rddnEX2BSzUyejLTM6lmdIVxCbdvXKtVnYxRrFqdNFdWZHoNOjJUUd0dsgPeBU6ZZ/sF7HBYoq4MxawWxRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4075.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Fri, 27 Feb
 2026 08:50:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:50:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
Date: Fri, 27 Feb 2026 17:49:49 +0900
Message-ID: <20260227084955.3184017-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df49075-5374-4e13-5831-08de75dd31a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	JneQ7vf9Q7psWJsOaHK/ifcDbv9HF5CtIMX+fRbCv3Jk7VY+5UldOYNjmGs27HjCJ4mityLoNJWtxt/dJ86LSo/6i1MQDiho1Aa8RZh73pufxegji/ZPg8b2YpvbaQPdtu3HgBeNmNfM4q7Aj5AbXXgHLj6R6uYwUMtRrDGT8ZkzxTHGGpMOqEUMHcR5FeivTVOeZ6bn0AwBSpm9VkxibBbviUUT0h8ElBr7Dj46rbddnAZdBjK8yoxPljzCBDOQt2p8LRC/jr361vkBJBrxT48uhaglBKTLMIVh5cTkX00JitRzp/y5lAQ5nSrA1js6OLoDNoUrZIwUR+KzYBTNuOOytsRSNrljZU84xKM+vToMiMc1Q66dosdXb3wJAIgM+JJZDMfpDr0DX3mVHp7W8oMzvlzgfd7NvjZdi7BXQXPBPjEWH/rP7PGVe+Zj5jBlEXiBUDg4WF4ah853fmpSNKJwNq1djvDsz/Sjg0CiI6ZagGjz986CAZwmfRscDRwZXPeldWBSccXJ3ccdbZTtPRITe3YhCe+RQwqZBKvzmdCz3GMi5MgKg0hM9B8QwUUVGHzzk4Y7MrFrFkghNf3ub9Z+OX4awFnhEwzT0e9U+2buHfQZnWozuktACgS+iUeH49gvb4jiwUlCZ92hAqrZjmnU/SyLfSJZDcEKp+F9q4YGrqE1a8O1jmci8pEvwjfNJRqQ6RlGPUpjP2gzxMKLs1teX3WobkLfdnaAy49CAJ9KURL6s1KHdSKh0oh7Lop5B3RF8CTJMd8qusbRPEO83w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kWwZ/bB3Hj/k0kvLd//IwdD/rfGBONGRbTn1xvIw932KhJxf1rw7PQe81dY+?=
 =?us-ascii?Q?R9T+m3jCXeGQdZL732P8WvpCqhrl8mATss0dFd+OuJjrNd26OHvKL7SaN2a2?=
 =?us-ascii?Q?4z2mVZl31y+mJ5mQ+mcziSzEFgq0klE0i7tPJYDH4LTekkzmdhALzTqHV1xf?=
 =?us-ascii?Q?MIg/8J2Y0JrunBUYdS2LINuaPOHB1c2EhmASHsH4taYE1j8TCmfrhChuJJ/W?=
 =?us-ascii?Q?xYb81nWuOsp4AAoGXRAj0NEx7WFvWRYQqVJQnFonCTI2ARVuXkKfynlIM/nP?=
 =?us-ascii?Q?cfBu2MUuxhKLd6eLRR6d6JznaqXEVrpZtzcECg88WI8Qe/yrPQEYf1G7rWSN?=
 =?us-ascii?Q?gwkY5LbrKadEOpdKCyyIoJchUIMU20VAI7jW/MmCONMjvrRm4+yuVHtSjmHt?=
 =?us-ascii?Q?8ZRZaswnm3gLLUeuuUjHAYkQZtcto6RuKt7cTRf7EHVM0hfhY/p7J0eGQsvc?=
 =?us-ascii?Q?fn+157aqMf96HAtCkedtR3LcM00P/KlqW1eKOIsJdRz8D27UczRdlpEH3CAe?=
 =?us-ascii?Q?b0tkBFQeGmlsiOHJlcGSTRHJU79xLrATDtkRm3FvnreXwBe/07YMN0Zx3kTX?=
 =?us-ascii?Q?gK41XWXU0To/NOVJe3RuXYbCSSgCpTGUfT8vi7PQNOnFvAxl3dAk7RbBTiX4?=
 =?us-ascii?Q?XWfM5oPbaeIv/XWg10HPc+Jq0PPccLPP1cOCUQRox0VjryRZmoeCSQRxOap7?=
 =?us-ascii?Q?raaDch31OHo370uSk5+nSafyRicP7ObkoKxmKjUBIop968txRa01KYsUub6m?=
 =?us-ascii?Q?Q7CDJyY0K0mTKL8URYvcN2zog1RyTs25I/tA1/n7fs7fI4v4JfL6oJtePLQh?=
 =?us-ascii?Q?g987vFoIXVhwQ6QY/1DeUTonPrc5KHT6kXC38vRGKaJDLKl/IiVlpznjD1Tu?=
 =?us-ascii?Q?qs+Iav//Wbb/hlGHrGhXt8a860cjxcb9W1vtoqw1OL2TPN3KVEM64xgEZNms?=
 =?us-ascii?Q?BczwCsOp3FnpTkLsmnuaUyXzztps9Q664x8kfdc27NzNZI0x5kwd7mkmhk61?=
 =?us-ascii?Q?K9xuWw5itSeBwisAcvDEoXYF1RRRP2dAYjYdt+yoQj2E4uFHC6DZUJ4olWih?=
 =?us-ascii?Q?ExxHGTFLZ7XasLDDtVTHDwc1YEQK4cbzZ4BhwV0noR6MVM2JJcW1//wKTmpQ?=
 =?us-ascii?Q?OaOnF+ZYZXHJ8LqpbozVUeYZ9gSQyQZ53ySz2sSL5Rd/r6yHqG9srV5KxxPH?=
 =?us-ascii?Q?P4HheSxYLXMkHgLRXZ2k1rkzLDlCFX61iqj5+NFfVEcaidsEbdBSw7jSf/U4?=
 =?us-ascii?Q?dJnbyEvEegWx6HdwnL9CXXSecNPUxZpe8xQtGKoJmDZrw+bxFWcOk4X8ldWR?=
 =?us-ascii?Q?flclJujDyUiZ0x0Lsjk8VKBwgi/UqnXrs7SgnYTl9uE0K7YUZDPp7fQLJaIV?=
 =?us-ascii?Q?Jrz2f3lrHKzM6wNKpHqVoj6BQ65hf3nUEGkQ3Jpxgo8oJhuc1KqEkOp7IhWy?=
 =?us-ascii?Q?KBDjlf/HlCjU98TOJYYz2MoNF4WEtyq4EgZ3Eq23Tiso3mJfxZTIR5QsIVi4?=
 =?us-ascii?Q?y/+4Kzu7X3xLlp7DnX+M7n7upQgFVumKM+cGeDCImEJzpBndBSS00ZsTJ1RW?=
 =?us-ascii?Q?4IzUulHdOsd0fmMxAA1PdzWHdYumrP2+icCiMIvNT/MbjkZR8lvWoWkB0jA8?=
 =?us-ascii?Q?GWq53RiimIcBFgSA+lUXTVEekxh8WwPSp2frPa3WtPrqv8PTJXd0ElS+sRGv?=
 =?us-ascii?Q?fEf+/gX+rUoxnrJNbJwkvZdn8K5dCEIZ4E8GxIqRRb5uqRzgzCxCw1vNKuKN?=
 =?us-ascii?Q?cLFnYAafh58FHRIODuVQJiEi494sKS1ND7WgUy1gKji7qhxwOoH1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df49075-5374-4e13-5831-08de75dd31a2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:50:01.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfpa38EyVvFv2IH7IxJ0Fhl9ORH0Vl4xuLnu+8d1jI3PYAf05BXl8YZCTR3blgfACuJzd37zzJQi0XkKFoCvjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4075

In pci-epf-vntb, db_count represents the total number of doorbell slots
exposed to the peer, including:
  - slot #0 reserved for link events, and
  - slot #1 historically unused (kept for compatibility).

Only the remaining slots correspond to actual doorbell bits. The current
db_valid_mask() exposes all slots as valid doorbells.

Limit db_valid_mask() to the real doorbell bits by returning
BIT_ULL(db_count - 2) - 1, and guard against db_count < 2.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - No functional changes.
  - Use EPF_IRQ_DB_START instead of magic number 2, to be consistent
    with the change on Patch 8.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index b13e0d2db6cd..b94e2e1d3421 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1280,7 +1280,10 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
 
 static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 {
-	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
+	if (ntb_ndev(ntb)->db_count < EPF_IRQ_DB_START)
+		return 0;
+
+	return BIT_ULL(ntb_ndev(ntb)->db_count - EPF_IRQ_DB_START) - 1;
 }
 
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
-- 
2.51.0

