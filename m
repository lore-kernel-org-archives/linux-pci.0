Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A5299927;
	Mon, 23 Mar 2026 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235766; cv=fail; b=DrUvsF9xmA7ZPP5blvktsUFQHaZbV3LCMRFOFTFvNChdO3/yncBzceugD4UIM7GKXkU6xtl1tKgNKhOiIyiaBu78CO8B/sKINQ9aAN5/wRzmftdIAXEyUSaAGd8dkTrJTubyYLNUK4uCY/x+zmLq37wrHO0v/gOC5H0lRo3tcAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235766; c=relaxed/simple;
	bh=U+Uur7vH6JWkGwJJyAVLL6Lc4guRl6EBUtd9DBKBh8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rc3RtBkVLIVA8Ch+42l8+ZmSHpPkk3/2gwYyyfSOvcc0Db1VOr82BL9xIMQRvt8Sebvaec0X31N7K8sVEhP0eBGE8wKss3J00TmULuIeV9oCuWqSBXwy/TVzaX/Xi4ohCzdRyRdhMK16yaaGlk4RJfFkQzCji9F9Gp0KrnasZ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jExrFyRd; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jExrFyRd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIMkq+QQkLBbRcOE+xZzu/rDPwYqHllEpTEE0uJXWlhbGKzy+cKmkVYL/GNJ7FyDtAxG8F9wA/8lL8rpAdtxqqmfUwkA6TMCi2pqq6Jq/MT+1YsiXPhGJ7+MMQ/06GFeZXWVynD/I1K9cCzC3iuNB2Y7muk8O6T5JUPYzyG2npdT5OcOhA1n/dhycH/xcrWb5Hf7F2cIG0ST/uUreEOUYAean58HzllyoLbYQL4vuNwxlGnTUpzFZXsXzpNxibJPJMmrFfCgmCTTJeFGMwwdhJRI3SSwcMUCEgTUNenJeFsmuxaphzjwac6zTfCQyHqRKClWS8EthTlkHFv6QmJU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mKWJBoxEqm0W1XtQsaA3SdfPjnW0vSnzsUsSRAGltk=;
 b=gcTxusqfWazyVyHOw/Zr04dvsDGjWku1PQ3SrilkvCYIbJtvj47lJpUhPDrQcpWu9F79Zy7EpvfozZYd6Tc5wvUQNHqicszvh8n8hrXaD25fjmD+NiEzB9W3YnVHrq4xVqThehQmUfWIzGdFR/UVjtZOhvdsnkL9Ugg+8OGd/94PFCYQI1xO6jEk0d/fuxmnvqCsv0GLriDZuKjdtrcvLc3W2Xzu8FuIi6rgyK6S6w9VqBjLbYiV3+TJ+Ujtdej6Vwb5xgSXRZY0OJb60Co5gPsHxMeoJJO/z7Z1HfVzqXjbw1VYzsvaUdWpyYh4FFKiJviPnX4ofACYQ14N2PWaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mKWJBoxEqm0W1XtQsaA3SdfPjnW0vSnzsUsSRAGltk=;
 b=jExrFyRdVY1aPd+qnWdZesolKKFkKA7kww2qGK0pZZ26fEaIdyBPDcUCxNz3TFTk0cpK2/T6Q90QGBxhxgeiERmkxKBkkHfigCr3/iWR3utm8QOLfoOy+MvALujHcwy2sS3iXNFnB7hOq5qUeKj9UVPdEMzTaFe69Ee6DK0knS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2385.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:16:01 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:16:01 +0000
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
Subject: [PATCH v3 04/10] PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
Date: Mon, 23 Mar 2026 12:15:38 +0900
Message-ID: <20260323031544.2598111-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::12) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9e628e-c079-489f-2ba3-08de888a82e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	lv+7ec7Vqn2Cru+U+k1YMjHzIbau8tUFND6FrnGrb9+Df0Q6YY0o5vX4YWGI1ofAK/rsrSZpKk+ta2EXiPu274Bi/o4V7S2BPDQYzAV5XgGbsLQC3Jn9t+EipnK7UD7Il1/U4BqV7PwaM5G53hPduK+ozk1ePGsfO1frMNCOk04UGc47Dvol8r9mAwunvEGbCFDNgjGxhdgeBk8Q1z0WGT6wu1wGX+0sthaBFcEVd7iSJtt2kil+Tkrhy2aua+aDbSdObGt0hm1QacmgPB8esDvGmRXRMjdMNLhR8f7ML3MQtGJ3J3SBlQJAr7mcwpzfbIHFf4svupstyoGLlIF2MDstAhLY9hZ+wrCJ2Dgvt8HAy0r74SgKdXa9PILMTZ/eMATyO2KB+OzKi/driLJzfjOl6MYiVFbOUvBxEVKziV2g8W1xmC7z0qlzECrSYYjlVla6zJs5BC1co8TRKl42EKZozNgnGb/Q31M+KP1DV2AGV9sThKgfePk7VUXodmqcZ2fg8tmRYB05zz3N0V9Db1x1Feoyl/VPeJZa4qbLvDiZCSmQ6ORnvPK0+wqughVJM9I4Ay5j7s2N2JAe6a1dIGLaeEK+jT2e1o0MD5IrTc8Mr6Ci9i07f52W08+WYkC7mdiffyOUgZn1uquEJKnp90WOYBzeBICvW3VurKH0YZtAGIgdfxIU63npoN6sErVDl6JDExlaQqnTHusqb6RfBciw0YbyPgt9P29R1MvfzuVa0/ulcRg1rxU63x9vcX7qzkSQ5kDniBaljBqBBs+fLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YsMjvwx9l7JVK1gjk3VSWBzmddO7AsxMKdnK0A2FD2LeffkURoZT+gZPsjLj?=
 =?us-ascii?Q?EAFEOVrE7KrCeT6rA6qbFS+gok3p9A3wA/LfAjnLhGAlV9LFEGPFuKOjLQ0S?=
 =?us-ascii?Q?XZE2jQcuqtjLSH3EeKZjA4p4M/HUv3y2ebM/cjrH0lDW9LdFMYggmom7App9?=
 =?us-ascii?Q?QOc9oHJ6TiyedY9cIQ+hHhTC7yK+3NLAHrYm213BiDxNKTE/fMTHDqp4TcSO?=
 =?us-ascii?Q?AwXlpcKGuD4kWLg3Y1SmlVq54m9ApiHKjB5rJEe6pEGB1mD1KXWOSZcM2/az?=
 =?us-ascii?Q?PJ9LUsdDFprrRka0J0TL+heDMRSAAQlac9l8gfUfTQtoPULo/xiwVBkjSQfe?=
 =?us-ascii?Q?6OsNS6HFU364dZVun1goCo7pC0oX6J3E51n19IH8vwB5PUv9jys7XDNxblJ/?=
 =?us-ascii?Q?fQsHIvCw3EzidEhO/j5yCNuVToZGEb9Di5hMbm+kfPtTwwOsPvu5pajZfrQX?=
 =?us-ascii?Q?b5GxBR1IDqoMc/WjiKYa2VYg4WPsO1F0fuM/pMFeZEppiypqw9ubU5oNwgTA?=
 =?us-ascii?Q?bJqtK41ycP38oLwdDRr5Lt5fRnYmcsErGFV/v19Rx4h8gMQ1FR62qUpHMVb2?=
 =?us-ascii?Q?9gn4Ch7t9Koga4hPaM/zG1zVaRa49sJLa9FhiTfCq0pHVFycb9pHx8ns1cRW?=
 =?us-ascii?Q?378DqkzzRsASTjMVt/mt3PJyZiTuosQfYZnvuScKBNFgzRbJmvPcTWpTGcEH?=
 =?us-ascii?Q?bzFRGZ8Fbwqy1rok+V2YlacL/Ue9HLzaePL7ZF8UbgMS/vxSCOhKoJ6aJ0nG?=
 =?us-ascii?Q?TUg1bAf/+7NnLn48J1qevqqabIbNM/ztFGdpOAjl9/T282aqC88okgv9jlZZ?=
 =?us-ascii?Q?jO6mBZhYaINQUvQvmPABqP31Xqr/Jrn7WLxirElePILEG2LYWfi3qAcnnJIx?=
 =?us-ascii?Q?IZ3h1JJkZOtQvx8m0kAJx6qQocCafGyTaReOnyGUMlb5jWFDolSh1LTUNUvH?=
 =?us-ascii?Q?BtsAP0lWKlnWCjmBZNJbLzUcrv+tyGdcf9n4duazY1qLEUNwOXQrQwZ9IoBx?=
 =?us-ascii?Q?93E5bVWW+8RQQRcJiToQ1Mal/I9aPLiJARaPQWkrFW+MfcFMzn5uE7EBR5Kb?=
 =?us-ascii?Q?7juZqpZ4N+vrIlfVMU2JDSQSlcCGjv1n2In/zMxzwfxWxKkUjmn67GqK0t2R?=
 =?us-ascii?Q?zo4SzxweqwApB2cyYoaTtgEHloHBP6/oybz+DTkDYjewfg5gdntSvR/Kfyfe?=
 =?us-ascii?Q?H1DJy6k9IKZbaQr8ULradaqR4GliHIYsrdIg7neyagYh9hicLaCBNp18o9Yy?=
 =?us-ascii?Q?A/XIeh+487EjFEYF+iXnViT5jmPDlE7uMvn0bDY01ZajKiAxX7PVWYUrc4Nd?=
 =?us-ascii?Q?3/sF15kT2SE8sqGhAFob++iAD+okrLqlks4hJavVT69A8SeZBk1oDMOEGHQE?=
 =?us-ascii?Q?x3APaPTELmbOhcyHtRr0FmKsAWNern+kyl4w+MS3YO1aLeEVI0sLxz0bP++c?=
 =?us-ascii?Q?jbdEM12A+g6ytB5WDOdQlpthb4xcWvsZ46ilB59aFt47PTenYjRSght95xoD?=
 =?us-ascii?Q?3hrpf/vxM2GKCjF877L+Ti2DJcXRasaA63zfKXnKGRvhQBVkts+C1pU38bqy?=
 =?us-ascii?Q?NaD/zaTWARjSIYAjA9wN1SCeFHomDfoZA+S7IxZApYzx2lRPj3ZDvCteoKwF?=
 =?us-ascii?Q?aLSbqyTYEoZ+jCad89BF0ljvTnRXfpkhSJNSckPwybUsN04bnT3EapaFot0v?=
 =?us-ascii?Q?ru94z6+6g8Z0kvAgWLNHibZtESs7+WJjWtIspRawNsqkumrusRPRbSAi1d9I?=
 =?us-ascii?Q?Zu2CBY/MaBBYxHoBSiwhLjxfDFPay86rel6WQ7RtNRdB7O0VzGE4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9e628e-c079-489f-2ba3-08de888a82e4
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:16:01.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+lG5TMBYcleJg7qPPHikryh3k3bauM1Fpuejw1U0z+UrfVtVTnqPGDZywCW4MLqgNpiFCnKQDpySg9wgO9ZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

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
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index e86dc530c08e..d91033ab8e03 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1268,7 +1268,10 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
 
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

