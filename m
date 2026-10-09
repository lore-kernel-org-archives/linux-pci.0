Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020131.outbound.protection.outlook.com [52.101.229.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658A3DEAD3;
	Fri,  9 Oct 2026 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522015; cv=fail; b=lghrLUdOS1JWPDFAkxpYxv2V4wNUXDMLwL0pu7UOOH4mojV5cwGiOcA+DFNbvRwPvCqYhCMzZFNNUKy/lslz3QSVSRMb+3jKRwehpgvfm9KS1kqpbMHQJkGKzd2hqhRm+itZCnqBjzOdoZmE7ZFttjK08pk3Ywc0TZyogK4Waos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522015; c=relaxed/simple;
	bh=LnLWVT09OxiHRgdMyiG68vaf5aHl+yY1aAvNO+23YCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1PrDu+7Kot0zM91FtzH72v4q3D08ESxtRD0Us+7ik++UtGtvqNyK9YhmBj7OoWLltBbg7ZLqqtXum1FB0vauKzVqfVY2ytu2eX5FEoj95ayqw/WO9FPZOz1xkelDTxm6fjcrfw1TGWdXm16Dpj3q3bXQpv1TZKqFw8Of4Biwr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=d9QJnDfh; arc=fail smtp.client-ip=52.101.229.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="d9QJnDfh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5f8sqkk/BwLOO4q4b3wZjkbATqmQAnzdwgKa0wqlD6Mca70DpKoPL0M9RAzoosxdBVGhscXPHoILWo3u2x24A5+yl5ZlyG10D15vLINaByZO/1vP+ppsviEOutDJ/kd7s0h9S3BLwRCkHoVXzpwxXriXUOfudkkQX8hls9UB2gYAWatg5MsUY13KCBTYwZCN/LEGUIQSsiw8TolT6Y91h9Y0Nl3679aC7XUoBjD/lveUgVvXCHBsKO8JG5IA02eqfH7gBTF6gPsmf/dn0BMlk+kazHP5JW3CvMD6EdtBNWJTdfu0OufDtAnTwbgQT2A1SQbwPh5f1P8nIkfGI755A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfP9g/3DP7jxVeah3401SAc9p+HVr134eq9wD/fPG9Q=;
 b=aDcRx1yVvYOpniNqQxt9+/5EsFoD1XOECCmlRQkaF6b08Uyup5DUsJWXL6iupCtLKV++3u6oQ7ETVfzDEJYc2ML/P2QlG9ul+Q0GEWJ1E9T8Ud6HpfyNIs8lLF4TG+qAU/OEQi6278iutpAUkAl2PA3UmjqEaFf0q+wRHd3qsfA6dePCWNJM1FFrX5b4nGOZz0pnZLbpEeuH67ZCe6c3mDwipO3Hy2+LdYyCuDAkO+xNEMOxWXxgm+Ww9hS3hjf2O2pleHuIZnipLcplOpGd08y0xGmXXObjoxxIE4EudASRaMH0AGzZzdFjuz4xeHJTrFk8qNQZ7m0FgtFNHLzLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfP9g/3DP7jxVeah3401SAc9p+HVr134eq9wD/fPG9Q=;
 b=d9QJnDfh3COsq1iHFltzQOkQx9HPfG9WqEHSOA6NKU0noW9agZRTZdqIG4wTMywSfqmUgizXTf3zAANZBt2hnuWIU/iy+x+C0ao0dBQ3t53Gz0WLa2crph7mt7+YrYz0YiLFJBjOi7ZI73yJeKAJUS/SEFGP9gbu1Poi3EdFUDw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4369.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:00:07 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:00:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: [PATCH v5 3/7] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Fri,  9 Oct 2026 13:59:45 +0900
Message-ID: <20261009045949.1109871-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045949.1109871-1-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: e370c047-e6de-46ba-1542-08df25c23043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bPgz5k0KDBtlFS7G43L0HJG6DOiN3HAmDboRAUKkm99pjBiTDxl1cUtXQl8AY+TxHeFwqF7xLRudc1Oy+CGJtETUW4REcAwn9mgH+zw2nlL7FxxFWHhBMgCVfkoEn+SoKVTS62tgE9wGiCJEFoedsdYG2oRbtWrlnEc+e8/gztcatvfhpEz7ME4Spfd1sxDqcPkB8l3qG0SzT2VhhqU72ilN+ld3Rr/PGobZSr39opjx8+HIpyhncVePb/cYZKDW5HknwYru8WUMRgukocvy9xLUjUD/0nn9t9O2ule5LjRLR8TqCm5MGNGQWO8rc+vX+ZieO0veOQkDYl+bLKZbaW4HfL9ZvmWRjsl/WRpEWV6k/aZ7QCfhBGA02tYzt7MfxuWjXO3jxudYLLUUSzjD+TZGw4SnydzoFfUNjNpStMNSp1vyjA+j88BUlqqpn22Ge8NMGi+AofL8YrCDFh9JG65FKNYH05zAaPQMOJeza3sWn/cfflG40Z16hAmDk9RIXRdGxyp1wMdZPDGko21ir7y9SVBEnTm3iI9QKSmnXmt61zQj8CxE0edWN6P+cJkJyvE6lrSMwUL1mhmioJtDODjuqZmT9n06IPJMaZPh7TSqQJTKDaO1R43ZOQUtBPCoAzSxknvd+SAVVtgC2ZTXO/i5E3UC4WcRuTVwa1seds0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?la12jJ0ht+UgFWnhg5fZyeLeaWa4R5WzPSTaGL4BBA96yVAze4gpu/Bisa9t?=
 =?us-ascii?Q?VIbi9SbSh8sV+oJWqHFrdGRI7l3zVxpttIgkxciHrw3MI8DuTRMx3ydM+h5x?=
 =?us-ascii?Q?hgQegbTiHXNK637+lYH2UaFzfibfgmMRgPb7fhWw6tYTGE3PcdBbfCYjyQVH?=
 =?us-ascii?Q?q7RIzt2HZ2a55GelCzkP4W1QzlhVNHIIK7fJShiWKjST7JeJ+gN3Kw1Ovd89?=
 =?us-ascii?Q?f3qeUCe0GnGOB6jVVHaReBPZ9P1GskvKzoozACDqO1JNBjLUNggQ6LdcMuhV?=
 =?us-ascii?Q?EAABPzDw5KmnBMEOm6jjc1t5CqlhAzjJn0pL+Gp+m9h2U6IvS/Ki5yNQ6lcQ?=
 =?us-ascii?Q?l9zw1RfiSM8J5tSzHg9TqZeX7owWCfAYMTp216GgnOoEGVQokCtFNkcM5hc+?=
 =?us-ascii?Q?oC/W0DRRcGIhGOj+ctTVW+4RDf23tU/IF/7Ngee287ivGKHD2yaA/eXqbiOZ?=
 =?us-ascii?Q?GBae1GypkDXpu+2Cb5R4lYJbpZ1lt40A8XLyLsyH0M4bMUwVyVTZjkBxDizq?=
 =?us-ascii?Q?r8lIF0achNKjOOqENt32d79aBGsCNlb3TOJVXyPqEqIrL23m/Sk0QE+rEvPc?=
 =?us-ascii?Q?1ro35R1G8mDdwZq5O+dlOTOylW8EuTCZPho2OoV+7YGdTPs6DQzN1fgI0YoV?=
 =?us-ascii?Q?z8c1k4yDQN7djT2GyGDTsIWQkt4oP0LjpeWuaI6lXtExOiOZYdwXBFdgJbLG?=
 =?us-ascii?Q?lHjUWjYf1Z3ixH06jEFIZrlf4gE/VMBLtgaOefvcQPG6WrE/kRcFw77cq413?=
 =?us-ascii?Q?juyXtzxJAZd8rHs1pQHe/tfBdTD95XcYzQlwNMFoYhgLNLkAzd1OO/j1kapi?=
 =?us-ascii?Q?vADe+Sc3l49JCidtEavusrFc0qRp3iKshrradbZUvEPZA73jUSdTAD0DOFhX?=
 =?us-ascii?Q?LjiEnjG2/nzYAySqaRWdpv5lW1RaYQpNfu0oV6eHkJ4L8pyQUBTY+hHfePSQ?=
 =?us-ascii?Q?vHAtLFsjrR+sdn9kyM2+piiRVtpqDGY1vbRbEDy9pheuFdKgDL8PqI1WJEdy?=
 =?us-ascii?Q?HvnGPITiKEFvkz885uE4LDUs9+kYvjM7vJy4uRj/BnyR3AIu6nYrd6JhxbL6?=
 =?us-ascii?Q?mLWq9LN/vTqlLNMyJS7x/Sp4lhrT91s1Hkh7o96TmCkvyiRiG/hHOkQBOLb8?=
 =?us-ascii?Q?g3ujG4ogI+A5FaMhn5h/SGzd9fkPnEHJjru37hICcLfrXqYXrgmQh0UdTQUd?=
 =?us-ascii?Q?TWl4qosJ+fs+igANMRhorMeyJBP8RSPMauAkbdlE1Qvpt/I3D79jePw72HRv?=
 =?us-ascii?Q?+R4D4w10rhTpOy3NHFOOje3T/2x48lwwVsiuiLdGSznZQWooKQcI2YEgi0ob?=
 =?us-ascii?Q?Wd1qsi71VkLwqpdTqMcLvJP23EtcYHj93sy5qzD0daUuAEi6rkUb9VR3IVN6?=
 =?us-ascii?Q?s3IM2K6bKbdrIhVN/oq6bnPNg4My++wl2gTKFtsXRd1pV91A7aICtaTCiUbZ?=
 =?us-ascii?Q?oUVJb/T972oK2oz91wZ/bWm+lo+sx+9LsRFjlJ4EwrD9GRptXZMFdYUd8Cxb?=
 =?us-ascii?Q?NAoAGAW+MmgAANXOO699UhW1uR85go0y/11wfauv608sim9bgfS89pMomsjV?=
 =?us-ascii?Q?Ux/Rey/mkOS8+cCvR5+RKX/Uxbl2ka81JiZVq7eyBbv3E+uN9kO1Y7GWTK9O?=
 =?us-ascii?Q?M1GWEQpGfKprkFx6py08Niwx0+VYBuTc346R0sknAKGt4jvW2hXCufdxqFvz?=
 =?us-ascii?Q?jD76HrSe46LaaOEol8LrDoujkafmBLT860y4hJ5+CYypW/RepFyQKEk58LtI?=
 =?us-ascii?Q?2HwTfeXij93UaIxL9P4j73e0yxI6mxFJqrRUJfGrww5GQwF9wzC5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e370c047-e6de-46ba-1542-08df25c23043
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:00:07.4142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjAFVrp2Mkjhdf05TbXstqAtStGu4BiVuSHxe8L79fb+ah9sGuomMf/AsU/LarmNe+1gv5yAS4PE/KXEt/TmhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4369

Move epf_ntb_is_bar_used() up so later BAR selection code can call it
without a forward declaration. No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
  - No changes.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 07ba338732d4..b6b3f1b7406d 100644
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

