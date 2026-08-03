Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250E42DFEE;
	Mon,  3 Aug 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780300; cv=fail; b=dq23u5wy+1YjMvhUAB4jtRB4W7jFdmr9K6vukxl5AP++x8YdxWW8EXi8y0j+LHgwKE4/a0qCQP1hPc7k0yyw/rKyBDlaP0Y4mEGUe2JHnKOnDjYvuFr4DXV6UOcDzywWohotCkIAwW/hJglhuCH2AhWk363h84fmxW+zGubDLEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780300; c=relaxed/simple;
	bh=dVMC7vRzznBw/KGD35FFQYRoYJ3czUaOh3FD4NS/1Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIFN4+hIGW4n/6JHuz/3OemumY/6cFC/mCZ7fbUuMYXDo+9ExyMm/wtNjI8CT9uWKKME4R2dOV10CI8v/Wb+OqBkuM+6nMCsoxrj1WxUBh5eLgPqgc4yGumIjQOya1NRjcYh/I4nMGclGV2drh3XWTx5+tF98mW0N3WlZ1m3z3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eLqoDye4; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eLqoDye4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPmJjAEE7kLcJU4H6oWEJHBd39qNsw5E12eUuPg0jWD19RDWFN9xvtxt/Wl/pHuiZOmuzTo2OhExfN04FQn7pXQLVuI+4L0S5TW+QOuoS4RHVeqieFX6DZ/FsJL6nrY6VMkkyLAyMTjTRiV5cYitT2L7pPIVuNbiekyQ9MMkjxPw0R4h1ZX6amU8EynN7aCCa/G5UOJSzsAG5UJl4/1D/JLuFGHBEmskPSYKCgN11mI7mZk4Ue0ywT/A8dkhH8r3PL7iHD7d6DqtTd7O6UGvX8erh9PDK7gNjLR59j2r+XQO04qECfH0AOT+qb1z16vBLwLxhUrrsCMAk33LU601Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMiWaBZtm/B+LIVBIa/WUf354IRSc5IeZ73GyXMsXso=;
 b=oexEgLX/63QJ5HODpb9fsGEj1+A7FxjiAM3Swo0WqgWJYSiZ7R/wlrqTG7uMZzact1NpEC+E2h/e34swImS3wxUypnFmtYA3uGu5VRf37qLN3zE+yCynniVSwteUyXbmuxsfLjN5273MlaaTDacslpngZoAQkIxJk2r29S0+8n775pE/p/+7Ozo6xJIl5cIQ1TEpCRDJ/F7L+pGbz54VFcfd85UwcAx5gEnaEvga+H0e8TxF9kh93axhJ+DN2N5FcmssZu+Xgc070D7zBfVFcrSAivgOT1nLJfz899aJcNZFRta3Csnacf8y0U+0/zt5JOLOJl/nqmd50YG1TH0gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMiWaBZtm/B+LIVBIa/WUf354IRSc5IeZ73GyXMsXso=;
 b=eLqoDye4WeHUPh7bVcdcIWWVw/v2bA/18mpNK6LNmLHgDLERyWPpUCEja1WgJbYcfLSTHrEUEiSjDdcktD981y8wo708IoK+LIp94C7se0NWNMO3zucvJQTNbp22B0ULWhusCpxhSyAorccUyAIdFHYDVkpa4/jTjBFgOSp1nVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:50 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 11/11] PCI: endpoint: pci-epf-vntb: Expose packed MWs through configfs
Date: Tue,  4 Aug 2026 03:04:38 +0900
Message-ID: <20260803180439.1963864-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: ed213d02-8c92-47eb-0adb-08def189b615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4bLtHAkd6CgI9W4V743lo046S5OrgBEo4v+AQLBkhIlROasI7e0ckF6RVcC6AhQ7TGvRgjFdJkdCSSiZkv5Fym7tgdTjSUwGBp0MlCBGOmmixi1ImonashU+DaaM9S8Hwi5lAh/EaqgY/bZqgRVcEI61MPMb5EmQwvdHIB18bUMjadurONx1hGUDUvXR8Q+GajJsoIuVJlRv2K3K3kcgsSTcAG1pmw3WphRl3m86qmbY2uJUyY3wDxLgKUNBdqeQXtC3Efrmr93RHH8vpL58YucZLhWpw7mPoSRUqSmDAxmjscqmPRBCyL3QUyVf1vYN92N7hzv2Z89+9Dct2cdVQoVhhfrbLOY3VG6mGRbkr3jSPfJdGsju2SYeRoXoNvI0mPL/e6cg+LZOHAzVujCX/qL8oSxd24z+fOLuq5vhlX/lB+4a/ZuRhAtSILoFf31/Eto9FWF8egP7tEZXOblWMx/SXhAuW7A6CdwGHrWu8pVZzgCoMl9f7wI6xDzbp882hI1QgJIJfMu+bWpIRmzE+rh7XJ0ZyWojPRv1N6PkbgQeWj7KUoKaMIkTiQhnNMIMsJf3Kea4O/SnatQ/B3+TiaoTLposlF1/NXWMd6sbavNjSpEsayUNubpWebQ9k8c3Ftl5StsWRiag0B7oRB087Z1iRhSQFC9rGHiF2HBelodsenCuvqWR7WP2QH1dd1wM1NgboDH+dA4LYPeOywrqQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Crlmweg7BxYbeHJbhEefKKby4yAHl0LWAVU19E2xMUpegXxG/n7YZY2H+/iD?=
 =?us-ascii?Q?sI9bRF0XI3LaFHP/mZIZM3oqYGe28eXDu0oH+sEEz+PZCKSRH/Pwy7bVmqHS?=
 =?us-ascii?Q?glflyNPwy3uy+rDb37sB61nA9eKqbjCBHWZ+C94DJLHG8ASz25O2cs5LyFZL?=
 =?us-ascii?Q?mVqRjmm0rnZGSFQIUEpjzCuEHe2MhGRYkGWrUepEoOZQaJD3xK4YuGFnMley?=
 =?us-ascii?Q?Dbj3CeahBJmmQXVUM1Ls2U13fGIU+kG1wvXnO6uvIy57nR5PtYJqMeo6t5Gh?=
 =?us-ascii?Q?rbU4mOGi48CQ6WtKIcFSiTsUB7lErSbQrbRhelRF33OhWh1iLx/1R4xEyXre?=
 =?us-ascii?Q?6hBhF1YxTd5SQpmSuukNIcWPM5ppQYEJvrCzy1mZRvkW1OEF0HBmc4P9I9rb?=
 =?us-ascii?Q?GGDFxG7nN3hQHwm1P8Ceg26pbggagwPq5CUYaCcSqrBZAZ4FSQb0gSlrxFqu?=
 =?us-ascii?Q?zxpU5zITxZeLftMoXIBq3Fdi7xIAEN1QXwV9JXGbDVrDzKqlkteJzn+ZE9Gl?=
 =?us-ascii?Q?qLXFyYMD+6q+o8AdQFARiI4BTevtTUYYa+7M4Ecb1CefMb9TqWRsjJ9TdbTs?=
 =?us-ascii?Q?qZ2otNWLEjoPkCjkVjTo2zq2LXva3pnr2T8ZlN+1Lsqf1TU6tWfqpP/2+q+Q?=
 =?us-ascii?Q?pxKtutMNG0qrUsQISJn/pJtq8ClcwAk/6hBG6GDPMEx0QWhLMI/A+OjQqdsN?=
 =?us-ascii?Q?rPg1CvSHosj0Or+UTT/LamIHd9L1o/dJEukIH5A7lJpNx/WUmaD8WX8WMq24?=
 =?us-ascii?Q?I4pUrPoHz0GHqjbO3q+2STM6dqao58iGGhLlaUtFsmK8c2+Ok9BqXmcxyQyO?=
 =?us-ascii?Q?9yoO3s06W+Z3cvp/N54amaxwhDyLxJFiLialUhcfC5QClUPNUPHHXVlfWupd?=
 =?us-ascii?Q?j1ZcCpUasChD3MxOK3Oovm//yxFHU/AwlbdLPWyqnw6rLgqHhjm7MqNzV7VB?=
 =?us-ascii?Q?5qKkhT0GItFAdlw23l2MP5Imf20+lsk+LLiTr69cPDtU0Jqqr8PvzdGpF1Xp?=
 =?us-ascii?Q?Ua78GZUM47OnoTJvjh/CUZkWo+2IxNE8xYwbs86hhiLVMEngLcUXl+ygLbwV?=
 =?us-ascii?Q?/oiCfTj4VIo5IJIaCC/0UcxCn3PJKC5C+S8RPmj5NHscTqSNe98BmR77f3Nc?=
 =?us-ascii?Q?nui0P8rQhqdKatBfpSdVgQttqCrqXpk5CpY5B7ttLSsfvAnMTP5hG/Tshd5S?=
 =?us-ascii?Q?MvuETh3PRM+GzZIRdHyw8ZZwBQdF7gqEgcqixJmYYKk9AyYqfoX1ncbu0j5t?=
 =?us-ascii?Q?qvcrmoxdoFhpgRvBEe8NOagR9XrlLB5XimvIQG6HyjJ8B5lvYHy/1CsY+77d?=
 =?us-ascii?Q?ITuquQmT0VYzRrOb8jDKikij3JWj6LOoanJ0V6MaJ/qCijAvVAHD1eXA19YX?=
 =?us-ascii?Q?ClWuFGG29rn2A/edNLfl5f0TFQkDzRDVG0XVSfdT6e0xKqSU7aMHEPgFCFqv?=
 =?us-ascii?Q?Dr+32+g0yPhBP3dNlFQG/S4tACp7qS1Pijq3Woqe2zQ/LHexTSbnNGQFKca3?=
 =?us-ascii?Q?DKiwzQcAOMxA91//4ZFNJHfnhR4QVXjjcanHiV5IU8qPPzBVDp14BT+I7jom?=
 =?us-ascii?Q?AJezQAwk8fpW/sldOJMLUBiA9IKk+KhFTuBq6NWbwjnHpA3cEtGxQgaUOocS?=
 =?us-ascii?Q?D8duoEIdG0PPNSxM3uXeTmzwrFJ+QuGfgNWRfBxN7LhT1Y9boVczBrO9Qqr0?=
 =?us-ascii?Q?y51PlXHTqkvWSfVBjmZtAqu/tRB0OUm8cccbPRSmNAyBR7fmDv5VE8XTwes3?=
 =?us-ascii?Q?KFcmr6Cj6upOgU53TDnI3VtvhTYRD+0izYz7ODmARacds6mlCSlG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ed213d02-8c92-47eb-0adb-08def189b615
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:50.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLK84diitKPI+YKAZFXpVAkiqj+fHGEMA4e4+UamuKJ2zDKw8Tb6LiqRKDw1cVakCJZZRouG8cYWhrKBsbgDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

The packed MW data path is now complete. Add packed_mws to enable it and
allow up to 16 logical MWs when packing is selected.

Use mw1 as the aggregate BAR size and restrict the other MW size and BAR
attributes while packing is enabled.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 16 ++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 60 ++++++++++++++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..8c74a39f1aee 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -92,7 +92,7 @@ attributes that can be configured by the user::
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
 	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
 	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
-	vntb_vid  vntb_pid
+	vntb_vid  vntb_pid  packed_mws
 
 A sample configuration for NTB function is given below::
 
@@ -105,6 +105,20 @@ By default, each construct is assigned a BAR, as needed and in order.
 Should a specific BAR setup be required by the platform, BAR may be assigned
 to each construct using the related ``XYZ_bar`` entry.
 
+Without packing, ``num_mws`` is limited to four and each memory window uses
+its corresponding ``mwN`` size and ``mwN_bar``. To expose 2, 4, 8, or 16
+logical memory windows in one BAR, set ``packed_mws`` to the same value as
+``num_mws``. In that mode, ``mw1`` is the aggregate BAR size and must be a
+power of two no larger than 2 GiB. It is divided equally
+into 4 KiB-aligned logical windows, and ``mw1_bar`` is their shared BAR. The
+``mw2`` through ``mw4`` entries report the logical window size when in range
+and reject writes.
+
+Packed MWs require an NTB client that uses MW translation group operations;
+``ntb_transport`` supports them. Per-MW size limiting through its
+``max_mw_size`` parameter is not supported. ``ntb_transport`` also needs four
+control scratchpads plus two scratchpads per logical MW.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 526cc31d9435..2f6af0306563 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1295,6 +1295,7 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
+	u32 packed_mws;							\
 	int win_no, idx;						\
 									\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
@@ -1306,6 +1307,14 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 			win_no, ntb->num_mws);				\
 		return -ERANGE;						\
 	}								\
+	packed_mws = ntb->packed_mws;					\
+	if (packed_mws && idx > 0) {					\
+		u64 size = ntb->mws_size[0];				\
+									\
+		if (size % packed_mws)					\
+			return -EINVAL;					\
+		return sprintf(page, "%llu\n", size / packed_mws);	\
+	}								\
 	idx = array_index_nospec(idx, ntb->num_mws);			\
 	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
 }
@@ -1337,6 +1346,8 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 			win_no, ntb->num_mws);				\
 		return -ERANGE;						\
 	}								\
+	if (ntb->packed_mws && idx > 0)					\
+		return -EINVAL;						\
 	idx = array_index_nospec(idx, ntb->num_mws);			\
 	ntb->mws_size[idx] = val;					\
 									\
@@ -1372,6 +1383,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 		if (val < NO_BAR || val > BAR_5)			\
 			return -EINVAL;					\
 									\
+		if (ntb->packed_mws && _id >= BAR_MW2)			\
+			return -EINVAL;					\
+									\
 		ntb->epf_ntb_bar[_id] = val;				\
 									\
 		return len;						\
@@ -1392,7 +1406,10 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	if (val > MAX_MW)
+	if (val > EPF_NTB_MAX_MW)
+		return -EINVAL;
+
+	if (ntb->packed_mws && val != ntb->packed_mws)
 		return -EINVAL;
 
 	ntb->num_mws = val;
@@ -1400,6 +1417,44 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
 	return len;
 }
 
+static ssize_t epf_ntb_packed_mws_store(struct config_item *item,
+					const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct epf_ntb *ntb = to_epf_ntb(group);
+	u32 val;
+	int ret;
+	int i;
+
+	if (epf_ntb_epc_attached(ntb))
+		return -EOPNOTSUPP;
+
+	ret = kstrtou32(page, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > EPF_NTB_MAX_MW ||
+	    (val && (val < 2 || !is_power_of_2(val))))
+		return -EINVAL;
+
+	if (val && ntb->num_mws && val != ntb->num_mws)
+		return -EINVAL;
+
+	if (val) {
+		for (i = 1; i < MAX_MW; i++)
+			if (ntb->mws_size[i])
+				return -EINVAL;
+
+		for (i = BAR_MW2; i <= BAR_MW4; i++)
+			if (ntb->epf_ntb_bar[i] != NO_BAR)
+				return -EINVAL;
+	}
+
+	ntb->packed_mws = val;
+
+	return len;
+}
+
 static ssize_t epf_ntb_db_count_store(struct config_item *item,
 				      const char *page, size_t len)
 {
@@ -1427,6 +1482,7 @@ EPF_NTB_R(spad_count)
 EPF_NTB_W(spad_count)
 EPF_NTB_R(db_count)
 EPF_NTB_R(num_mws)
+EPF_NTB_R(packed_mws)
 EPF_NTB_R(vbus_number)
 EPF_NTB_W(vbus_number)
 EPF_NTB_R(vntb_pid)
@@ -1457,6 +1513,7 @@ EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
 CONFIGFS_ATTR(epf_ntb_, spad_count);
 CONFIGFS_ATTR(epf_ntb_, db_count);
 CONFIGFS_ATTR(epf_ntb_, num_mws);
+CONFIGFS_ATTR(epf_ntb_, packed_mws);
 CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
@@ -1475,6 +1532,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_packed_mws,
 	&epf_ntb_attr_mw1,
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
-- 
2.51.0

