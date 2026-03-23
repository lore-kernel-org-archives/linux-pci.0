Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8752D8795;
	Mon, 23 Mar 2026 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235776; cv=fail; b=bebEoWG8jEMKYdOcCFKXdiBz3+VHJKC3kKnMe9FuMP0sXSotCwGMVQ25GO3SYERyTDnDgOIi4JFPWmmH7+dawJVqYAt8Z6xt4xYPBqWy6bWOZlACoc3mUaw7os4KELWTIfNjcQBEshRG4eRhbElvxuMkcwx5JGE3C+aUhuULxBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235776; c=relaxed/simple;
	bh=kAkciJLkkV49DuqUiVs/lIlddw4yBQ48zUQdiAM8mOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKSQK+kAdlhqq88OTJXI/3tqqcpqIWXQ3QURhIs/2SIsgk03I2xPrfd07Vz/byfTHZG5b/erQf4wcmHfeDBErwroPF1SY+cuBKENssk0xNhLo8fnBlDdI64vwsLltPSlW7LonoAGq/t3g8JV4lMf7I110NadmsiERb39Wqi513A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ej0GLGx+; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ej0GLGx+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W08ZZXJWfOXlZpnRu85UGXNk/2JOv3bS3eR60F3ewiK3THaA0c2M+Kp19CBctB//8tXKW4LwHTk1FshOIzlmWnDOt5R0+owlKAkgADhSgvkfXXlTWg7jnjy2ozeTiGW/6fVso3t6lk4NG5CPipqW6P81bw6KY8EyQsy7Bv/b0DxbIUk7Xyc4Wo343nygk9zixgiMJaL7LzMiVlgp5dd2CTFYu0ck2lnJjYRaGuz9Y4UMdfHwjKvElxGxz89k76ak/qhjbX0BhOqmsTgorw6WLqzcuiFRfQ6DteN6Y8iMx3TkEbjyIf3K2MNm/AZHQs/v1cTBvuUkrDcTVwSto/rjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfamhXT5+lK6qNPenNuwWWw/vsKs0erujM6csx7Zjeg=;
 b=MHZsnMcjN9ANKkFEXkjv1GGNDKIvOzYDxpwmP0ZlJwVwB5MNufscdbeQaq/ovhQtkwsQPdK1WmTvF6JnsYluoH8nFkeaYUfOjGfiSXYdz57+g7P7D70ryTrx4ldZe5uQ3BOiy9YTFLdO9fRo/QtsJhmB13PJGq74irS0H1+gSWwSgyLPumC/WIt5hqEqAB4UHrETgz2Na4DCbyF7ZYzVBrOpV2XEnA3fOTCGQxHVRrkMaT0Gi0io/zrmXqnC7+Pgj/0YCx1QUMY5RiHHWDYehwSSe0hq0kjE57tiXRVkt1pGayymG6H+8BF3zg9LgNIFKgcYaAmtomPbMnN2tHkHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfamhXT5+lK6qNPenNuwWWw/vsKs0erujM6csx7Zjeg=;
 b=Ej0GLGx+2ygN8Kbgrg32GzVGzHgKI2QTgHKb30P4bNHTljbH+xBONZDIRJra7vmxSy4Bi+d2/15eJJ42FC25RUOdoTgT7ZGjiVNwokpi14a9jihwaaCyxL0qyKbII7bkLNZbbqZPe4A2yUMEuGipiEQ2lcp5Q8jbFc5etyYny6A=
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
 03:16:08 +0000
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
Subject: [PATCH v3 10/10] NTB: epf: Implement db_vector_count/mask for doorbells
Date: Mon, 23 Mar 2026 12:15:44 +0900
Message-ID: <20260323031544.2598111-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0133.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::20) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: c494783b-097b-41e1-8b59-08de888a8728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	opfwuiVbMHmNBgGIesDGXebowLngmpUedm8HK/V43KH5fcLoFnH2ScwvVdUYqhb1eAzJPxVhb1tqthMR6/Vd3qqFAxh1z2D6fCfUVeD3UtR+lGXVQd+u1qkRMOtUhxNf3xyV/Ve7pYIXRJJp5JWh1mIHve+1whEK7ozd6hYOCx2XKGE4XABk3UYSFMExHCzBvDUc2Dw2eEMn3OoQQzcjkvgVzWJZ7M3mgX5xTmdtXRO0ErEGDDpiTnvV3Z5k4A3yIhyWTEgcw+zf6Fip0Bf93w1u+enUlPxXRkZzEmGiUyM1nl8A/GHwL7qRgVplIkSkgiyv9WSo7+ynnjlYJKjZgSLFAzVPyeDDBamilSKNizlJ2zPBJe58E0aCwO061kabOa49Kw4Y2TT/pkhqxSNJCoYe6CFI1rlEd1LP5SWXSL8Gj8Mwlyapuz6cngghUcyJIHX4c0aXJMPJYMTpj9AlwpdhJ7tjxaFQN4jzyR2ONW9s7Hv277S50I1DqtUnVyc1TQDXdlttqJKT8sTaArn3ApW/hNwPaIyFKF1nr+56tDl0L2XaS7P9ixTpYVT1Lo7VrEjBKMBfJvPgPSDQqGzrhSL8aYMv9bca5i02Cb9uvLz1LDFYwLO9iPUFBsr4JRrzZTy2mr3oSB7yleTwSEBbUJpg+9o9fA2fNuIDuXJm2xi2Bic4DLHfoL6YssVviIk7iayrnlwLBcxry7Kkf3aOI0R4r/tRaikdlElTujdeSkdnBML3FtIKoKFqldzFu4OlPwdFElqGN7oGNF/y99fSeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aOwO/9VeY2zZGp7EYdirGpJzN2GSMsNKjW6ElrP4n7lOQC71b+awe/5ju/CC?=
 =?us-ascii?Q?0yRY6t+MwW0XcWYc84eefwRhhaJFwVessoIA+1jw+wyCt4HoR8hPTe5mdpjq?=
 =?us-ascii?Q?XpB9JS9iwVvcjhbLbI+RTfQBgckhVes5B22PgMIu+jkWbF8EY5kuR9j6YVHM?=
 =?us-ascii?Q?hLynWOhHnq0JaKEGnhfazqh6plzqfsLUXAoSunDssO74WQSKucbF4UC95FkX?=
 =?us-ascii?Q?QIgp5q+7zA4RaubTsNNjWWKWqhC7Wd/jmKgcA9jGnRr78T/KlPQyFqX+Q7Be?=
 =?us-ascii?Q?Z0zBGq3Sp85LZv08p78XvLgkrWL6whjzDEI12FzeOdNTkA+5cn2MIVnn7Rzn?=
 =?us-ascii?Q?XKngxgPQfpV9GZ+9E6Bw0I9+/6yPoJEyLnTdw7P1smHgU1Wyf4HiYejolmQN?=
 =?us-ascii?Q?zHNo8o79l7KS2QCWNhcxaN4wiNlyn3d2jdxB3BDMP074KG41eVLIydLUqfKF?=
 =?us-ascii?Q?1VHOZNuncN+PqXMpyefV0tSabk62A2+PQP11qvOOHEkhz8+aT3CKznwRYH01?=
 =?us-ascii?Q?34Arc38mCideWDFOeQ0Gg9av/jM1YiexACkEyImStaU8f8YWRMf9TdbHH1o+?=
 =?us-ascii?Q?GMAPCbj14UJjhD4zjgHe5RJ74mmpR2PR4Hpl5bFC1Te9P1rW92qoCvQV5GVR?=
 =?us-ascii?Q?LYYSIAEHRpDlaLRphOdn56SlgdcvVqsc33BIefTY3jmePwQ267RylFo1eFRK?=
 =?us-ascii?Q?8Sxg8vLEGXNOYP6gQ9fw3YQBnp7/65tHHNqricQwdK52yxxv4Hfj3Svk/qqZ?=
 =?us-ascii?Q?6h/g5BVKnf82KfL3bemqqfsj9G6rElkyi+ana6tnc+4DOEKBmaPqxRPwaNui?=
 =?us-ascii?Q?3hCrgT6c9l6QElHQLYkkFR1ycRd8n6xr4v4hSSMte0DanKBsFobmqn2KfkSF?=
 =?us-ascii?Q?EJtCk0qP6t1UDB2LKnehRwuHzeSb3W9AjK/BB0PoJlt8SjxjTjQSb2ENqaEf?=
 =?us-ascii?Q?CW1Fp0R6aw9bwzHji7A3viVIAiUK3SFjv1nGcDol8kMY33I5kLpA9OraxQXQ?=
 =?us-ascii?Q?LeBkfpPUrNx/HnND90zFWVwwnFkCibwB1cHLX7ftPvqDmlpzKNi5xlnoVxQx?=
 =?us-ascii?Q?a6jh2vccC/t718iJBCyQFrn3o0wbfAzpwSfz0BUbSLVziQtNUrvjdxmn/pUk?=
 =?us-ascii?Q?IhBZomeHkjeQ5CY8VN64zJvi/jAPJ1vNeFH+xXsqV6qu61lRWQPW1DkL6Vr6?=
 =?us-ascii?Q?nmuLYqVYLw653Jk/2WIRvPoMmueFHl4RhwUVfZNL2l+yiCeOxHVu/gznzukz?=
 =?us-ascii?Q?l4nGAMrUGDA0mn6nCO2tDt/guW7I4W0rBtTRNlWmcZYmEEohYiGm+kncHIZg?=
 =?us-ascii?Q?pJ+Yt/aXNPM2QUf+9czRH58F0Je8myyoqycRjB3oJJfj4BWWwJayI5adz2oW?=
 =?us-ascii?Q?iwczNg2xHM4m/vsI5Bbqb6j48DJfyZnY4m5yfvq94QzqokihhjyEcb3txlhJ?=
 =?us-ascii?Q?lJPXnLWk8KAfaQGJjRiOEj4frhHZYuWDiwUir+u8pQB7TZ2AXqCq1YI5gCyF?=
 =?us-ascii?Q?fhDKKFTnZvFZDnkItrJ/vQI5OEpE6o7OMBPBmGxKS0qQM53IPvaGCoQl+BEh?=
 =?us-ascii?Q?XzDOMgzA5qcS/+GB4B9NPSrPjJebZnWkLnUb2hq1OK6T8FYl7kOXA37XBjsl?=
 =?us-ascii?Q?iekJEGzJz9dpmq/2K+G7sx8zbWuathKqlG3QyZot0V0s6oujdR94DW8YnIDq?=
 =?us-ascii?Q?W+sOZmI1VDbKaMywO4vBRqJXgopa8gTDd35CEjfbe7reiavG5d94Xwu+nzB8?=
 =?us-ascii?Q?s2d+xwEpE4wwBhwFHMXHZ6QPWsbCcKf8J9dtCAzavjqLYutsDazi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c494783b-097b-41e1-8b59-08de888a8728
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:16:08.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y8BB/WohpyU75iCBFroIhzR6N+PfKjZfVq9cRvQMMNWSNiRw9s12VpQQN0A0p41PsTW6AXIuEdywooQtjc/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

Implement .db_vector_count and .db_vector_mask so ntb core/clients can
map doorbell events to per-vector work.

Report vectors as 0..(db_count - 2) (skipping the unused slot) and
return BIT_ULL(db_vector) for the corresponding doorbell bit.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 741d30821390..d420699ff7d6 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -420,6 +420,34 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->db_valid_mask;
 }
 
+static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	/*
+	 * ndev->db_count includes an extra skipped slot due to the legacy
+	 * doorbell layout. Expose only the real doorbell vectors.
+	 */
+	if (ndev->db_count < 1)
+		return 0;
+
+	return ntb_ndev(ntb)->db_count - 1;
+}
+
+static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	/*
+	 * ndev->db_count includes one skipped slot in the legacy layout. Valid
+	 * doorbell vectors are therefore [0 .. (db_count - 2)].
+	 */
+	if (db_vector < 0 || db_vector >= ndev->db_count - 1)
+		return 0;
+
+	return BIT_ULL(db_vector);
+}
+
 static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -554,6 +582,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.spad_count		= ntb_epf_spad_count,
 	.peer_mw_count		= ntb_epf_peer_mw_count,
 	.db_valid_mask		= ntb_epf_db_valid_mask,
+	.db_vector_count	= ntb_epf_db_vector_count,
+	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
-- 
2.51.0

