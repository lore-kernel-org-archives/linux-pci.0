Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60039E6D9;
	Fri, 27 Feb 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182208; cv=fail; b=tGu8WlKAjV7sRSxjboyUJpHPrMVH7bP0onmbt0krGN1UHISVPIxYj094WJg3Kr5UR/LBeCNvkGCYKjj9TfBjapGeY4QxTzgCOsKaTZ4jMDrawT602QZ65jwWaOp4jad/ZyF4dsSOaWClwLUrYfOn7aLPe4kX+u7hhlitDE5LIAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182208; c=relaxed/simple;
	bh=Ke24XiEZKEwZcG4jqs21CA0hwnpGcF7vDn7+xorFul4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aISiM2fJJ2d75lQNudT1z3l7EpItqNHxVLYHi6x3HVZ5reB5x7aWJ/M9ghu7pCUrPqUbTQlgCsH+Vztr3FeYtwpP1eDaMRfA1noOywOqyHyYKx3Y1SmQh0/i2VHTpj2VhASDrf0RjaKlLGNyD4YmHlQytcsZbkJFGpYiKs15nlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wiqKGCkO; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wiqKGCkO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs6cl7wRfPkGN9U7tyx8HrKQS+1lRn3cdf+qWyevGi4NwYz8qQfA4G1th/HfYHoCCiktqNXgRjLdzO6JFeFKGF7fudsbHLp4/g/Ht6gjrqgY8yGY5csHZEpZnDJbH6bepMQ39BjfI5F0VFAl4fzQeYxNPQHo6s/86hKUB5rRAKFvkGPdKbcleL5dO7ZoBYG6aLzze6BO4MItmrrnnyP8kbAbhzZzokiW4MQEKflnoujSNfGQoqgKk+qevAElngskAkfjS86VUtXjYoMbQp+dLhVuyh3zI/HdtoNLbXWajhi4o+QMYw6jmbbHdO1ugd0VaF2VFYRjKHzzpsVR67g9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6A8tYAEtFJPVTNA1MESs7rljUx1W36VWo3eqFGTWj4=;
 b=MZQqECy159B7RcwSR/u5gEW3WNGMfsZBKjSQnGru4uH4Gg8AwmoYyU7MfcjXt1ytRUcHuF2OvwnL4KXf5OMtFEVJe54mIkatWK96W2RKTaFC7npbqItCJHE8aED9Bzel3+M3NQFEv+2B9IPTt8o/z0xZMhbkgTqJBRO/oh9jUyC5JA6/eUeRI0TksRyO51K4znr7FFBzMHTceks06EglkUU4+c6Zd7p+dVuPsIciqM2Gv/QD0TBi0U4gRzfguz283D0u60V5OioIeyYEo9pDweyWf9o56L/lshvx2X136NtxKK6eL2FV1c7ZCm3NI67PXafsplhH2a7RU8lXD5RqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6A8tYAEtFJPVTNA1MESs7rljUx1W36VWo3eqFGTWj4=;
 b=wiqKGCkOds3+YfJtmZLEL9p2c+WRo3EAEJ8JoAaq1hHc5vwsdbxGsfXqdrgCetMYrEYdnnFaNgAMObGQ3NqAzExVW8Pk4v9t507cTS8EPYP+cR7XBvUWG+BJNWeNFYHdgcPX1ZKBpfbyMCgcl4pyEL+OVhkE/lKNB0s5rEuUCWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2135.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:196::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:50:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:50:04 +0000
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
Subject: [PATCH v2 07/10] NTB: epf: Make db_valid_mask cover only real doorbell bits
Date: Fri, 27 Feb 2026 17:49:52 +0900
Message-ID: <20260227084955.3184017-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2135:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f6438c-53d5-4bea-84fd-08de75dd3332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	oktZjBBUFAHTMAvC/7vXwlYuCKdfa/1mJ8iO/lXfiYGLgt+Ek+n8V4PuCtuL2S/jtJgxv1eK8ZU57NzjnjlZoasUHgE9rcbsFET7DbxM0j37AoIfyqmIhG7PqCnGH38Fzu899RacgdxjNxeF6uT+K5gQg4GT0v9uNI8pJ7p17DD/ylBZ8m7cv9KHl7Qh5NNT0J7SfhcEum5aVlH1hYu86FcpsBJSMVTzbp265tiyBlJumZXFd7oUGMmYZSWT97VGTwEhyOEaN2sgubbaiwZpTN6XWfoDbuj1+jjxP3xQ61ZaiNoDkeuQk0VAeTGoSosTEOa66lwLtYmiJboiozY89wdS1OVU2/+sqLLSHSxbd1N+rbtYF9nJFEU2B7QYPVhFKr/I1UM679WDZsyCAnXTY776vh1ztM+pBm+02iCnCXiVZFe5eUOJmUQtbCqulm/0MbapL2EdTF4Hkn/JxTN8hLLh2oKDF4E61TDJ6yjix0POPH1D6m/diDIoPoCvQi1pPLKrp2o3A6LWfAnhBVI4y4lKJOMyZj3ckyzpZkG/LeJE5rQsSefG9XanR+dMmZZ4o07uasPPj/wWaMvfaDRzWBwyk8qyhjp+4Ab1VhoKX/Bqokfm3T469wrCUP6sSJDnQDS3WqxAY9c8HMxNdfJkhNDeeoLrZ6c5gSsNZYYzTHNLaZTtg/+zzuqF91Q4FUyT0jd+VrX0OgF/fXu1iFxr9nr8UwKJVTIBXjFqSncEiiqD/8JKoeJAoRtWWQckACFgnMXwH2+l3HuJUil7aDzlog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHVS7u2UYdk2u3yUTXVQpM8V9Xgdk9eiSb6JVF4bfjdbN9wEMLN9cmX2ZIvY?=
 =?us-ascii?Q?9wl43ZszJA6Xn6+1+Sp3KRoC6eV39ebR2mz4FAZrOvYbcTAexxDEKjXCPvJx?=
 =?us-ascii?Q?ZuaKMAAOJth6uRIJdaknsfzVFOFRGtEu/dvXClv3NPVDUnaDxTqwZ86w8S80?=
 =?us-ascii?Q?kRg1G7uodj4/Ab8bjGIGm/6n8uDPUQRvX69gQuEfsha3kdd+Ve37a/YPTD/F?=
 =?us-ascii?Q?n7WdEnPYaq8qZCeSfEeUB74fmoAPkIh7xCb/3QWwQYiLZuylaoJbN7fPtpH8?=
 =?us-ascii?Q?LsR4g9Bw0IiTfe2OTlLLxu5XMNNualBTpkGNJdTc+OoO9+KkHhuvECJ0DthK?=
 =?us-ascii?Q?PDlf52sbB6i9Vk9YzbIJaDhKvh8rM3XoVe3N3LOXIBEN59xzPsQzcp22KrVq?=
 =?us-ascii?Q?fw+t7FY0v57U/EBGkew1a4m5Y0prhtPpoQgSdUdyIy2s1S5McxIBTO0AGXgC?=
 =?us-ascii?Q?m2VqWEE7ghEbruKjhbGHcmcwMBP5ikKZjCm1LhkJkORR0iwjpIfPrYqiq26/?=
 =?us-ascii?Q?vXh8/xj3xvTcQePWoYbgqhLX2RZfjGAfcaVeALIxi7z59cJT15g220ETggZy?=
 =?us-ascii?Q?b5HHus2swb5WAEaPr5GP1W/TKZKlxjVjiXzmFBnLYBnY0CNsizEMB3TlMYAg?=
 =?us-ascii?Q?i18UQLmmwyf4QoOIfwwfyZk79pIzjpn9FaMBKNj2FMW1W7//1WhhyvSzpReJ?=
 =?us-ascii?Q?Q6582qhnYcs1M3IuKOcu+s+G4cO9ersTiP80Pz3SGKSEl9tw4RMqsG+bycwx?=
 =?us-ascii?Q?l4s7iyriOzAmtcAnOqAoixJO3NOrjcKd77drWroRqiWeFspWian/i7VFha6R?=
 =?us-ascii?Q?uQW0pTOMR6lP5nwzDKlMOOM0fx1VBoBQ5L13u/MXLbWtMBxYakwvMrTTx08f?=
 =?us-ascii?Q?/2EURG6MDs87+VLSxqJAH61Gv5Pgu7YJ3rNFx4wo2JE1YuJaybVQxVNFIB+L?=
 =?us-ascii?Q?EmzgRbbzX2wuWOwOCCrr+cVDnwS1YlcPPUb4z/c1gfk8qbSex3zVH+C3Crhu?=
 =?us-ascii?Q?l5iqCsYL6Ia3WagqVBGHQtws3lylkdaCCVVPkXXju0EB/xy1UuUUd6KfWBf9?=
 =?us-ascii?Q?Hnlz9BDB4ZaOYVlJn4N9Z5hvncZNi7dOS0j9WcMOYHzNj3QS7WLgy1DtpB+6?=
 =?us-ascii?Q?KWJu2F20aF2rZmaZNoLPC8oo6UKgSRzzORQjnMJEp4XAjMAXAgRE3ny7N1P8?=
 =?us-ascii?Q?lz4U9BN+OOrAnAUEjc2l07U41Y0jDCW7EWITjTBK+zzqO/uNTgj7xo1+3p9W?=
 =?us-ascii?Q?tl1X7dzl5KRD4QtHJ6Beiw1yP92NXHv6gBbpTipom+6XDNouAtlYRuCEQb/N?=
 =?us-ascii?Q?32Medbz1G6PJSjSdmuI41xWT48/4TwkaRerF3q5bIMi80zQ7YSDx01TfC2gg?=
 =?us-ascii?Q?lY2BlgdLyCtWf04k+k4pJur1Wll1vHdLgGyvflRsaM6axMKSzZ2bPvWP67gW?=
 =?us-ascii?Q?rP0JQH3vGIyOZDmY/x8lemskotf7z71+C5hCa9bNbPUhjcR8vWeMt8W5jrZt?=
 =?us-ascii?Q?PYc+C16WQlvmPJwtqPuYWEhTWFn697LKFOJ4z5H8DGsnnbJMJax/IZuaJSyz?=
 =?us-ascii?Q?q5VWQ0cBtynh7bolU0Y0Q8kneTJqc2ZiIb2OrK/sW5bqQMp+2PnAz034g6Bt?=
 =?us-ascii?Q?7SkC8DC0xXuJkV6fUXOt2UG8rBLrCEqO1rVXbtqDO4bkR7Tfwce/VjMhYD8m?=
 =?us-ascii?Q?H6nK2efRqtj6Sh0yTDOnOcyiri/WG9rdFPcW8xNvNTFLXJ0iYRvGPLik1+NB?=
 =?us-ascii?Q?/U123c9n8zePWnxgRp7h/gZUmcGMOQ69TR83ZBrbUhktDkDG42Xz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f6438c-53d5-4bea-84fd-08de75dd3332
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:50:04.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64+m2RPyFO+Roy6j4YNhRQe6HSkhrZDwo9hRvER8warSw2ZPr0g6NY1IPdYRahAogFZceJLbctdINPwiGQH/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2135

ndev->db_count includes an unused doorbell slot due to the legacy extra
offset in the peer doorbell path. db_valid_mask must cover only the real
doorbell bits and exclude the unused slot.

Set db_valid_mask to BIT_ULL(db_count - 1) - 1.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - No functional changes.
  - Addressed review comments (documentation).

 drivers/ntb/hw/epf/ntb_hw_epf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index bce7130fec39..07dc97d3270b 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -580,7 +580,17 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		return ret;
 	}
 
-	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
+		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
+			NTB_EPF_MIN_DB_COUNT);
+		return -EINVAL;
+	}
+
+	/*
+	 * ndev->db_count includes an extra skipped slot due to the legacy
+	 * doorbell layout, hence -1.
+	 */
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
 
-- 
2.51.0

