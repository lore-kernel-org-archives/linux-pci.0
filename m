Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850803B5843;
	Mon, 30 Mar 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863756; cv=fail; b=fluC5m1RuuH4t5krVnF97ZZENK+X4xHLyd+doFde4P7i8E7WVXA/Z91ky0TwW4gJ1FxvCKo81xMiM3oY4zbvHBd/j8k92lS+K82u0HF/q9C0IFNqAGb8QyHeh/wt5w0vkvJHfO+Z8/9+cOZ0OdlYwLv+nOFda38KvtttMG13PcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863756; c=relaxed/simple;
	bh=3DdNfduovS/XZ0aFQdZcOCtyRKiP3+e3bA+u8vGlb4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJlh15vfzTZ8Cz/mDAHHnr4MpPXvjP41WuX5zVOMfszNuB/9YFJXSDz/Pjq4f9xjtXhdxZBe7K0+Cvi7k39JohqlBA0YDiCMjCkKbQprY4cRc0qBsXv59k50F6JmuDXSHnJujcuqNciXf0IZbmzs0++2zgLqAH9e1QzoJ9PTxks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IFSe1/xP; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IFSe1/xP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJbxyYuIwsdVVqJtU9Mp2wRHf6nhyOcJGK6TeCgXwvmGduZb6OiLDGfoJ3Qzk6vxMs9BLGEpWh5+xvwB65Aa0//vO55VkH8DaLd4LXtuTVdH7KWXzgokLZXp9HCdn0tcINm53LFHB9IRSZvBTMmeVx6vPUrWby3AkIzd/305ezXCYlJoS0FBIT5ve4JLcRbMCk17xVE/aJko71gNvgIuqnifoq1AvevJptOBymOhPNO03qrs6k3rR0TY+nk1uodfsfOpnPLJp61C9FJfT23pEiPHFhbTnZTY35ZxsZfx44hxTlre/CiY96Y3ZbuEeg0n8SbkiLT1vJfdk5dLMfX9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT5EAPvYUYcGHy1V/++7+iiZbh6/09CSEK8EMczoeCM=;
 b=kt67PiLmapHtOGYtDqVCpX7t2RAKG1K2FsoYrgDtG4e792zaDxG2i8KdD00FUKe/wdqhPlJXoeXenQumDjbUwavu+tyZnpPcHAyWjLI2hhL6RQj9vjkiYnHy4pIAe0NFznQPViFkANaL55iTtioOAtkn470JJSd/kU6f4qwvcZ8V+WqL+Deu66f9Daji/U886cI8lM8B7Vv/e2hXztRCDz+VHFOrk3ICQ88uej5+W+urcJh2HeHC+VNBiArwQkW8cM7vUZmTrrzR3esZDpJgmQx64TKhKyFZ2qh6WsfuHjZdpRsExAaxe2kT8QROk7JGFVIZIjA72Bxqn1ADNQfZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT5EAPvYUYcGHy1V/++7+iiZbh6/09CSEK8EMczoeCM=;
 b=IFSe1/xPx2OBPF96HrmT6kY5NaP1lD8M4HEHP/xV1owE3uJEA3YgavIMct9OzhEKAZzF2bkrXD6Z97wG3hQzMqO0LqyVq1ojJqEsrnYr9012b+masaASOXI+exxvvX9CZXQmKPYHZWl5r5I7S8x2j2l6xna1wKPp3xMULHe5f4uc0449DsyY8X61Oewwk26vKypOz6RP34N/46cSLcmg8dqmtSGrtn193AZ8LI36sq/+kMjtaxrzxvI8nRkF4tilvI8eDiDgEVDkKiKqPFZZeqJl2bjyx0KRsGpTtLelBAUPbxEE+1q2gTuwrToGWZcVrKPSrlkVgV5nw4KozwPdBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:42:29 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 09:42:28 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org
Cc: jonathan.cameron@huawei.com,
	helgaas@kernel.org,
	guohanjun@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 2/3] PCI: hisi: Use devm_ghes_register_vendor_record_notifier()
Date: Mon, 30 Mar 2026 17:41:56 +0800
Message-ID: <20260330094203.38022-3-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330094203.38022-1-kaihengf@nvidia.com>
References: <20260330094203.38022-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b7b472-3b5d-4a58-6663-08de8e40a7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ruXstUKN/mCCyI99/9d+InUcL0FSarxXCuL0iHdRkILU9zLe9TBMuFNDCOYdX2VgEmBASmBoMZsRfaFG4NkYmurqUdO2WD0ol3owcz6gZHzyiDtFXNVlaKwDkm1zUYI+A4PuOgn4nwAoIqwtfDu7ZMlI7HKZ2/1vqCAUG8NaAb/88xQrn7ZNy8vJPSCQnwBC8PTdx4gX8bbKECJSESYn8McD4f2yrcCjo5dCSox5EfXkglmM/MQgpkx7OBq7hbZHThsw4zPnSoVeWvIXWZdGFeJNdo8AtnsQn3PWklYP+lh/RySYUK35qyZV1eEqQirNlVD6fqyw5MIM8gOxUYr4MiGeJWp6+nFfDCANoM4id+XZU1bK1Q1GQLK9TD3wTVwB4IXlYIc77qx5Udc9BNK2KYFMsV/3VfCuzRN7P6CfbXQDsRQbtK1LGAVByI+F8bj17ZHb66Ltx22LNL0pQDqqk1olHXAJz5t5JhJpE/7UBcz89//BaIEARSjN4ijnGlwvtNgWe0EKgomDSKn8kdeLEARvTtVhu1YMTpTcr6Ux6jjbHa4majTN1eLDQarOooZqSvZFk2WY0wqdw6ynN8J+YUeZQG/+/GIebbNsGr36onLBeE0iDo8WEVcG0MaFPl8Ab7n01sL7fnokaISmY5YJwcCbBys/uYLJdK3OTit4oxyfflyuHnHhnvE0umfw/zr0pHzwa5kDe/1F1b6YmbkkZcn0Pe4VzUk57HVcNQxCm9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1pBG89EziJv1i3cZTSkhBzfGXHU4BnwIK67Y4ekFKHyFOieH7J4EGh1+qyzo?=
 =?us-ascii?Q?6tAssPAgHPKy/4d//E1fVD7wNekzw/xo6BF+crN9chEMn8UKVY4CvSmAtD9S?=
 =?us-ascii?Q?Yh9TRZR+f7cyhdoLkxpT8fGMorjXwCn5DhNz5bDZexufvx8QnGnWmOmQqROX?=
 =?us-ascii?Q?JBg62P1R3c7YVq5cUNJXBGoXU2ffQB0FdzeSpN1CINGI90rdf4dMbCvhD3ed?=
 =?us-ascii?Q?voL7EvW/M3cadbX4XYO8R1vyDfZbb9G6QBwL8mR4VraPaL8VCmsH4Gqz5rNC?=
 =?us-ascii?Q?ZUb5FU4NPMNBtWFbHg11gykTRRzlrKyt8eA09Wqh+fAUjpl3l4MsrpwGgsZz?=
 =?us-ascii?Q?W82UyiqDxPu6ZbTdebJgjYQq48BaZ+ne23CMBiHLd7gYYCu4Md2tpIgoHOJZ?=
 =?us-ascii?Q?257A6ePd9bQzsgzJspCabeMZzq8LjbeGxKZtal2D5si81OC7HY6hgfknoaCc?=
 =?us-ascii?Q?VZjTNk25aJAeMIuzYywi1YPuKOdraAQxvWIIkaSHUk3CIBk8fhM3ltaF91OB?=
 =?us-ascii?Q?Y1kz2+8oiuvskKlKNRZYbeVMm61Xcb6mJl9MCrAn6mkKLDSlnC8wLfJpyDqF?=
 =?us-ascii?Q?A4tZPoQgbapukUrWtpj9Y+Q+GPMP1tl1T9habXjj/nL1thjuk3YHsFx99wjN?=
 =?us-ascii?Q?hDyjX6P2XIlRCqTexgjyKtGbjtRdIpD6EzYO8kYOwW/W53ar5hPzts7i8jb1?=
 =?us-ascii?Q?MhPipJbdZXaMbDuMl/od0iqTDYPmJmKeh0orv6xUuksxcpdocFDG4nvkPrI+?=
 =?us-ascii?Q?hZil/AchxeNcTmSeXi6uPRmc4AvYshPqW/2ggPsRcK67sK1RXM8XLAG7r5/F?=
 =?us-ascii?Q?DmwRwB8KftcnJZjUO8/eAAPMpCgQvUi8BqZKpyzAVozmucdxKziHWXypcOWn?=
 =?us-ascii?Q?rvPqwPHjAJKv/UOYP8QmUXFsv5tPauueMC3mUheyX63qXaXZzmGYIDyVlXk1?=
 =?us-ascii?Q?JY6Z15MbbLFfVr2gCru3vMyhPVYK//b9QGHwqlKqQbO17pHfF4LkQc7VePNh?=
 =?us-ascii?Q?4CFFp+H+qwqpXk372UIn4SLVZRWHZbQUpTYHpQS2BlB9iFyD6q5GmhOZcPUK?=
 =?us-ascii?Q?7wrXg3mw3EjHuONm3d9BUlvxQwQQciVXfo3bV4WnlvwQtbWN3kebgCtH0NwG?=
 =?us-ascii?Q?CKVJtwAXDvos1HE1KAfcW+d8WGnovYjIsoAJwZU1Vfl8eVeigSV/GXaQsFbO?=
 =?us-ascii?Q?fJYOl7RHfO1Dd1wVqr2BBva/KpwCxhs40ZJvuBZC1mOFF0BeM0L+jdaI52Ci?=
 =?us-ascii?Q?JRppJfyc+uyC+YS9zVorKgI4ee1Eg4U/5bcwZc6pP2V6L42ghA/ea+6w5EH4?=
 =?us-ascii?Q?OCsdRB42kNXfDnsIkKFH/hFnOuoxsDhpWqaeMqwyvMOqXLhlKbx4oqUGw9aM?=
 =?us-ascii?Q?oZGOPfTaNeXO+qaTd5P3iqXi13icvrymu/HPpuetrCPAMY8zcutv8P5vo27A?=
 =?us-ascii?Q?ZO2GstEm2+CPZg9iMnEfTLMso/Kp/SIdu9cTGRUtjGaGSB0qsxpFSwM8otZX?=
 =?us-ascii?Q?FXwMCkvW5MwssL6ajPuQTC6ZsKcrD3+aLm2BKjdXSDNTEXQx8p0qy2DrK8t/?=
 =?us-ascii?Q?mP2bR/F3lrZGOpQuOmP8mMhDUWo+0ouRBr2cGkwfvTTQUyuFHh5BMrBGXihT?=
 =?us-ascii?Q?6c5XOY5rnUxzkh4T2tQrei0zA2X8GwUeJq72PA9wOcmNYoSun9ZpET7ZCIqA?=
 =?us-ascii?Q?+6BnpeMCD2ADEH3MZQyPcwnLCklgBhQsbVg/NcuIX7hGcdWU9+eQZ5K24xoX?=
 =?us-ascii?Q?u5PgvLqvTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b7b472-3b5d-4a58-6663-08de8e40a7d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:42:28.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlzuuD5yFY6nrTLmmttyyoniff9jM3Iji+bKc8JVsdNv2VTO+Q2wRWu0nzgo9s931tMna4SZs0b3NdpcPo0THQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

Switch to the device-managed variant so the notifier is automatically
unregistered on device removal, allowing the open-coded remove callback
to be dropped entirely.

Cc: Shiju Jose <shiju.jose@huawei.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v3:
 - No change.
v2:
 - New patch.

 drivers/pci/controller/pcie-hisi-error.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
index aaf1ed2b6e59..36be86d827a8 100644
--- a/drivers/pci/controller/pcie-hisi-error.c
+++ b/drivers/pci/controller/pcie-hisi-error.c
@@ -287,25 +287,16 @@ static int hisi_pcie_error_handler_probe(struct platform_device *pdev)
 
 	priv->nb.notifier_call = hisi_pcie_notify_error;
 	priv->dev = &pdev->dev;
-	ret = ghes_register_vendor_record_notifier(&priv->nb);
+	ret = devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Failed to register hisi pcie controller error handler with apei\n");
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, priv);
-
 	return 0;
 }
 
-static void hisi_pcie_error_handler_remove(struct platform_device *pdev)
-{
-	struct hisi_pcie_error_private *priv = platform_get_drvdata(pdev);
-
-	ghes_unregister_vendor_record_notifier(&priv->nb);
-}
-
 static const struct acpi_device_id hisi_pcie_acpi_match[] = {
 	{ "HISI0361", 0 },
 	{ }
@@ -317,7 +308,6 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
 		.acpi_match_table = hisi_pcie_acpi_match,
 	},
 	.probe		= hisi_pcie_error_handler_probe,
-	.remove		= hisi_pcie_error_handler_remove,
 };
 module_platform_driver(hisi_pcie_error_handler_driver);
 
-- 
2.50.1 (Apple Git-155)

