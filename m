Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021141.outbound.protection.outlook.com [40.107.74.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4E3911C1;
	Wed, 13 May 2026 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640579; cv=fail; b=i4kYbEDdhqcK5EBREiSLW8QFTt+FGF8jqqRj4PwrsOZu29GdNCOkiyLoNlIFZHNRQmHMqkzRLcP2qI/4V0fk3LFX+sEusXuLKnNH6RFbfS2b1/g+aGrBLbg59AYHyPn8qr6dC+aCT5KrbtFPI4I9de+VI+QmlRm8CMIJmqUHzDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640579; c=relaxed/simple;
	bh=HLNHMqc9p1a07F2u6h4tcUwtkJx+z/vXO52UNO3sME8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izpLw4hqvfG6Nyhi/M5ktKr3gJRlEv402jcwdUm3+wxXoT8l6YkZoYqHgK6upASuzwx9MCGy7whbmogNaICp+G9IPEGRwNYy7WF5va36RswtRdrEpRXvqd8b6dZPNVhJ06ewxeSCD1+SmodO9FmuKIIVZUW5s95RynRTPgqvV9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=nsAVDmM0; arc=fail smtp.client-ip=40.107.74.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="nsAVDmM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a45p6EzBN9JVrnmtXkFxo/MhMCLgJhVTRsyRHn/1Jpg/DuvIJlnn8FLXfSgb0To3oUq7ncXQ6ee5kFEX8pimM9MYsKQ4sYgHOpOd7RzBqI5d1vPwuSqzuf5lS/Tx9qUiEZf0zU13HD1bs+YoQPmDsftRF3FOfIu8V0EW5A7Mp40qbLGHJ/8Ce0tYAigdAZnk0sf15p8AFZr3pSfMVa0VAcClI4J4tCMvbTBuK13feEfJAnZIv8fYL81mzZvAmYlrPGsepP3sQ5szpClyW4Wvy6Sfd03OQLeiQbAA0bVAjmKCoz2vcbDjdv/w6m9jFAvQXuOgKK315EGUwwW8Qzv4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt/2gZEHEcFJ6VfJYLaOdL44dg0jQNSThMRI5XoHRi0=;
 b=eYFoL9pKTFUmZV7bgFfsU9YLNThSSDjXO6DNsbtM3zadCS4U/3RXaefc6LEIaF79V3wJUIit7iDWViwFFG/ixuDgAIz5YVuqx1Oa539+c3Rawe1qdXplMErccX1ipkfnsem+or8vPX0uSTVuyTwHcizkekYUJamGo5zb49nmVwwlCWvqR9vhYCmLrg4WTllXAOQB8BBoiDLFZYupm0+R44zzmWE24Enjvt3kg8fM2GOaA10dl2KrbqvLQyAiv8tsQ4Wj2GJgHGBfyFr1JQ1T6xbLX41NEo5o3vpnUcu9xJU1IvaS4GFbfKTY38Stn5+ufqAORKOZfJZjH7pfDtmOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt/2gZEHEcFJ6VfJYLaOdL44dg0jQNSThMRI5XoHRi0=;
 b=nsAVDmM0E4gsKunFu2cACkg/DC/E44Rz9pO0lXgAbd49+jE55zMRfy4GNree/Qw8dRCL+++h9Y5pxWQLcRqrhvCDsekm4aiVCpMi4DQL4XuCF0I1Hf+XYKJdVVVV2tZwdg4Q5Qpa3dUChnVOcJDNSwz/s2WKvV1+kEkzeXpf7sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5341.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:191::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:34 +0000
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
Subject: [PATCH v4 09/12] NTB: epf: Make db_valid_mask cover only real doorbell bits
Date: Wed, 13 May 2026 11:49:20 +0900
Message-ID: <20260513024923.451765-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: c40a9ff5-98a5-4b2c-9c3d-08deb09a43cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vXAqga/8HdfKVLuwfmm166Z0RZ3uWAW1LlcUMawlUjw8zfxcSMOwk2vC1atYk4qsYfivGApmJQH84v/viTRuENPenGosXn8Sk4cAk4xW+WANQSqKlUBzsas3NqPclm2iccMFuFjxPYx0+ZbE+UOm0bGrFi2drHBjvxiEEuN397iXfwxTFNB5xXN9bHZE2i6gB70NdORzq0HLMeAlbtHzlQX6IRH8R1G+zyMYvOcpe/O/Kc7I9MnRYsp1WyPBZg39Zv2OlxMYaD6EnXDGkLwPThyPThnhM/+Qhwa+UCk7tVa+q9Dx3qhRvQM65gvkaPDfVF8r7PYkFSL9kJ+X0fIsyENxs7HjMFt0alLRsQvbtq4Qwe6vHY4WlDqxJ8X9GislG4UBqSwALcrG7d5NTkIG4ZeLnOVy7v0LtlbnszsgWLjPMUWc8fQ/xzoWkSqcuRKPwRa25FsFPREddhIUWwmXzie4gVAf4BP6ZvE+DWb0KsyLajty4PvbORmaIYF5tY3zYN4QSXQWWIMGQ4owK3yNOGf5XxKxxm9ez+NmAAML36y59DmitMbRuZD86r9mt4MCFdOsbNrcQblEQRaBCwUlX/MMDVb/u1YTkvTjsndOVUyg5JtqXBfrkB2oxoBpxFGNEmgIDpLQLEBnufnKvz5CQ2CcpYJ9kicEiDFad71e91MgyfQB2vGLatfd12l3IFaxOs/lSUYvU6V2KQXeBsUEczyRoGEb7pz4Tubq7KNjaz4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HaRwhb4sB1ogxtUx0zO5rfV0nhItlm/PlgNUtiWrxEXHZEXi+Wz2FzKg+Thr?=
 =?us-ascii?Q?9rxxQTNOAKbFuzEbkWF/fE4qzdnnPvgi3/zDMSYFSSIqAg4tgktzKUOwjcbP?=
 =?us-ascii?Q?KbOMpMBWLJBxsUTL4p6Ryv87mNO4Ql2Nd3+YeqVd1WnbolY4JGmE9QAChsV0?=
 =?us-ascii?Q?UrXGAuPI3SlbROVr8Lh+rsUx1TK26bbUnzlD6BWdF24SkO9dlkNDpYeiCOON?=
 =?us-ascii?Q?KjeVGqUk622JTvawq7wIa7KMXeMm3k5V693nj4vpdfJ+6ihmhybHqqXQMzu0?=
 =?us-ascii?Q?JFJ6c1gkImCGRSEOjrF1ImdJC+VnJXDnPArwSbaJEOpceo2UR9NdPVLwjO4f?=
 =?us-ascii?Q?YM64Y10f2I6w+GdduOv6XPHm2A4NKdbuK2wfZHI2wgNmFate0p9ZpjBkYtPa?=
 =?us-ascii?Q?RLObZXl29D3KFhJbiS6mmoQSy/WkYwO5N3xAe3VN9y+62x/BLQ4fnQiBmmWR?=
 =?us-ascii?Q?iqxQdfHHWPfBqZqTyHYeXxLpCOU21lIK/6NuzqJ21qNNFhDQUymmMT4HVoST?=
 =?us-ascii?Q?6Nqkc0A+8FsZU8V48WkQcqeAJjuj1aYHQOsw+NWTMqku61tm0JWOYo2vcdJf?=
 =?us-ascii?Q?8e/XONUdK/80GBlsSLMPPKmT7hhXBwcNWTQ6ZrdM/0dmbc3jtdi5yCIeVwfa?=
 =?us-ascii?Q?UtPASQdAvq6damSG4/kvBY+QyZSjuuxfb/+MwnLt8ovltFU628628i+AEEYe?=
 =?us-ascii?Q?5bGyzPSFBb0l7juAVUKQPOiW90u5DGb2T3NdG1Z9de6Drhfbkqyj0IITDYSL?=
 =?us-ascii?Q?QwjHi5GtsjAHMGJFGL9szoyvj3dKzp8E2BsdNxglf0t+XTshuU5c4Z2gZLvH?=
 =?us-ascii?Q?FMbuladcuHNFR9zOYl7eZIyGMmwSJ7b/wPDxN2yQMQvZh04e1Zfoo2l6wdf+?=
 =?us-ascii?Q?WUTdlkS64ebq6g08+sAFIAneN8sxXA0clYJ7tdcDFHUsXGYeRNjbUyKCJd0L?=
 =?us-ascii?Q?Zkh6E+OHjJYrmSKtbUIDkL+twFWos0u/b7GI5vJhj3aGuZcPsyiucY7rBWg2?=
 =?us-ascii?Q?sahZMk2gbJGfP30jDoWlWbzI9YwhmiVEqyFFsfvsGTtT5moPIaFfbYojIXpP?=
 =?us-ascii?Q?Mm1ZWyhyFIxgsS0VvhnT/XDMvJG2eXbaVwURClQP9sEQVdGQimyHQ6QpyYED?=
 =?us-ascii?Q?D+3Cu7rxuqcVt2/77NzPi/CqoLYKJW7oUm2CTePyxCYlxisyEvbk9dvxQ3AY?=
 =?us-ascii?Q?GazYJLpkOunaR/PDTmhjCma3DthazS4WFNRKjVQGn+j7Pb08sEQY9+YWZcsa?=
 =?us-ascii?Q?6SuoaV7Gy2v0KAOGVivL4qFgP3GhixjWsfrSvZ2aMRCvSO215kg5v1ZN2NzY?=
 =?us-ascii?Q?92rxaAVL+58kBlpfXOEZaDCyg+JTHpyUb5WfwZ8+WBSLogEWEuBukERpRNpg?=
 =?us-ascii?Q?gFyzCMeNXasyfx80h+3O9ns1GCWa0gMe7lrNHX5mf3BTM7HQnqY9ESPEWsl9?=
 =?us-ascii?Q?J1KgTv0CT+P/9jKPOBZHESON2tml++zbFJUzJznDH+DqqlkJdKwjcTDzgPel?=
 =?us-ascii?Q?EUtIyFSOzI62ViUq2zuTe3NwJnmC9x1uavFARLJu/OHU+fbo26jyN8xh2Rap?=
 =?us-ascii?Q?+untizlK3HWMpMSn2BP06Wn+J831GMufeUrFzoVLfiheq3i2f5w++pHYcAot?=
 =?us-ascii?Q?cKc1CuS3+Ms3SHbY0bWQcInnhpO0nHiWQRpL84pwqKc+4Qf9TAOAK0aWfpaM?=
 =?us-ascii?Q?qajwIvcKxztTgkRry8c4gC2W2AnQejE7Vc+u2cQ65pHwfFb13g5sZEMmX/E7?=
 =?us-ascii?Q?d/h8TAipYpn+kcVuVetT3UGF1Ymz1Wa3D4tebrz6VYIlwNZvbwA9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c40a9ff5-98a5-4b2c-9c3d-08deb09a43cb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:34.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnZnRFhtL/RKNxeexCaQVraLkwB7hyeXdNSjRC1MQI3wxRPkZSYlEcvnXH2hssQ4mCqbgqlsASRoB0W7vBEvJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5341

ndev->db_count includes an unused doorbell slot due to the legacy extra
offset in the peer doorbell path. db_valid_mask must cover only the real
doorbell bits and exclude the unused slot.

Set db_valid_mask to BIT_ULL(db_count - 1) - 1.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - Drop the post-init db_count lower-bound check; ntb_epf_init_isr()
    already requests at least NTB_EPF_MIN_DB_COUNT + 1 vectors.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 21d942824983..c0bab3292075 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -580,7 +580,11 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		return ret;
 	}
 
-	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	/*
+	 * ndev->db_count includes an extra skipped slot due to the legacy
+	 * doorbell layout, hence -1.
+	 */
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
 
-- 
2.51.0

