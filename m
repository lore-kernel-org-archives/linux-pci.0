Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967B3C73FA;
	Thu, 19 Mar 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918811; cv=fail; b=m6LJTOT6JhmYeThJ7KxU0Thks0nEPbHcbe+3UPVrhniHdZ5RuCNy1zLlhGnAtYxkTUFSDvfDwk0aA80vbICo3P50EtjXM1vq615ibiO5PMboxhdrx05wFv+i4HgBXUygKoNJo5Fa2bM+UPQL/nw1ELJ12Fs2s70UgdrAVKr0eOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918811; c=relaxed/simple;
	bh=mllck/LTr3m+S79bYyAWCYqup7HRRp2toSX5GS6DMUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9K0kwLa0ygVGrscxNfJGlYKaSFREp1pNOPwBuP0rVdVDTyUbHhWp+FmkPybiBqzMi8GEuAU7s3GyHWphfXes6rzwyqJRnQ+jbDDztq8wygW1PEJQB2BKRPNcJbViUp9xU6DABHnxivtBw1hE6Cyq7gFHZcdi2zS/VPxdFMKa4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X2Rwbkkb; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X2Rwbkkb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV0EdyvdTLbpzqFV3Vns5zJ1oOVFqxVGBB/GsRSjvhHQfT1tZWXW65gjuSaSAGPPPbePQEshziJ+S30tIzt85ojjPmNppp934OLMyHvjop+LpHO2k0ER4uqmtIFsx22rNQaQwkEPrRKuy5ckjaVVVSyNK65aI3jIhxo4Jp3LpCvQ31k+rRVFf38g+45uPAwGeAoeFZuFPvrGcxDbcwqAvETW6DbVONEw7ZOkH3ia6XdKYKw2TqDsAgKEQtAFVWFrJvjc8lsupwhllK7D+UN9tbqETJqdYwa3bepo4wfS32ZpXoWjgEdTrPwseHGTxZhDlSXfMgwpzsDgpjJDKLxEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4WlsFryTuxNrnDLVE36GyHuQiJyP6KK3bCcFvBLlhg=;
 b=Jyimj+rbjPHMsnNya7sfVLobCRsB+HJH5f7YXn46eZ/RTCQzB8eDeKla4wAj/wEFf0TaBa5dt5qzTHijmxqDs3/FbqCGSztW5ZSyT1w//0ORk9EbtNIeA8oRmzHlG58rBbQzxbjSCGKeNIHWz1kCSTZ8u9tIEtf5OW6VN6Gmio0U314MYg8bLHEOvUetrTifIXBn2AWyu0vPOWANy4gYNwFDn3ybkZNWOO1C33z4BhNx2WjjuUSWg4YZFayaXRvPqk14DLjjqtODBbTBhfnlwz13ljHgaluaIKqtD7PlwLjGIJB2aSw+o3mewN7CQ7uSVpCmDNCIESbUSPmWY8PTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4WlsFryTuxNrnDLVE36GyHuQiJyP6KK3bCcFvBLlhg=;
 b=X2Rwbkkb/AO7Y67luqSZ9pHxHoecxMy9Qg4AnqgseOb6d6GXLO+UJwO2RWamGXdJl97q5rGapVTYGGv46HLOpfA/V6aGbEVj1Wp7/UH8RBVOeTWEzHrkmndDt3KKfWts5BNRjuRMnaLlGG5u79z4fjwnSeP5DfEjORXwzaRksYwN8P4X01EUn6vkGR9t3YDUJCAkDcFawCBNu979MIlTWksrvI2MkrpVxV5ttWrrD7L+rVzgUq/SJZWdjF1mN3XQKfZq3UrH9JMo0HEgXc+z/KQzgYBzsvCtDhmloxp3apVCmB+VMRNUiZ1YOnTzlWNV5SkM8bhHAj5HC/IAfrj6cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 11:13:24 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 11:13:24 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org
Cc: Kai-Heng Feng <kaihengf@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: hisi: Use devm_ghes_register_vendor_record_notifier()
Date: Thu, 19 Mar 2026 19:13:08 +0800
Message-ID: <20260319111315.87624-2-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319111315.87624-1-kaihengf@nvidia.com>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4ded47-c648-495b-4533-08de85a889bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wz7Q3OX4HAoq8hSzgNcnYVZFZgSIdLEW7Fg6jQ1esGwMzAq1H3ZasI/HP8yfPPYINs+TqtE145A7/hrRVtBJGImGjXlhzgelScc9HH/isWyzxzqqvpErFtijhkgyc0uDqO1yfTAOiZ1Zkb3+tjpMf40/haMzc/xSdOj0omeniPoKSL/XwmrrW87bwgZWWwp2c/hCVcvWZQ3Jjzh/Iu+IJ66TMUwWBtWYAJ75vrm8m+XpCWpnV+8WCbgrRxc0R3vd4wc2anUOa2kbpOBCWvgSWOadDjIHTav/kFLG/1bSs9BZTVRencw+cmwAFkBltk+7cEOjHiNoiFvLdQMW/QRDEEp2N3ggwhDeNR3WOJ1qf7fCyEbW/35oW1s6/IEwkZARRDMD/MxH4eLbFth6sFPviscPxH0BHC6TZxzsuiLh3nbzyENCinLa8EUZqfHhT26iyNagBQk/ob9Hkm4mcv8HPUeQh/whSIaH3TIPDk808XDM7c3aHTz+Yc6dNwpn4lRODe6K6fhmX9SlIeFcElRCrzQcjNPAnw9aP4wVkcEgWeHrtmL2dhIrofmr1VhWb4K6I1TYSJTQozlmdNzxRy064EoYLCMBtUscC/k6l1E47+BeiIo9TJnVcPCYmzeZeg24LxDORjEXN8WBCWLwocuv4Wg7VSlYFRmewX93GA+eBfLlDIXS5tOtjqEhIRZP7sNCugWqrg/YOz6ZwjGvvCVCx5RJF5c5Tlmd0hk2y6b3lvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5lSZT/9AbbLLT9p/aCYijPkTh3Bstg0Hksa4ww0TS5BtskwoJwccBGjcaNU?=
 =?us-ascii?Q?BTr7hNHhWxH44WnTWRRIWC+2vzlyLdf4Va7iwmWgWtNh8hzzIMO6rUHDha3Y?=
 =?us-ascii?Q?lVMhSLXfd+unLtFx032qSzJlg246E2fZBdmXRsQlo6HDNWjjBxVxgUG0uE6J?=
 =?us-ascii?Q?NXRAJW4kVMKpcBch1xlAEVH0HDpjHCgoxBchO3CCsVcob2ENHZvRtCiBCNoy?=
 =?us-ascii?Q?Z6IUc49tVpINuUhbwY5u+L/waTNBSuOtlv8TrKA7xL9oZT4tll3NlHS7JOeY?=
 =?us-ascii?Q?XSHXzak5zKifB2NyRO/yEdYjO0gBK3Z9ZfG3t9y0llSDMJJeBcJCPOWIHWVw?=
 =?us-ascii?Q?SCJ6BWp/ZqS9dT9mZCS2fyn4hSBaFPNoJhDYVhkw/jwGsrNFPQ1msfVJQHAU?=
 =?us-ascii?Q?+G3PgPmi8swbwLpExppT6T6hkMyeEAVJtPP5v49XQP8u+ngx2DZOglwQfehq?=
 =?us-ascii?Q?g74Xals2m2ObkVC9/MSkXgIW7FG23QH65Chg6dJ8hiMZWRk6dtufusC9WrNy?=
 =?us-ascii?Q?cxucSmMUaBR+vSTt/0zBZiitjJQJUc6GGCVfMnUkXL2PI4WUGryrxvAYVUJN?=
 =?us-ascii?Q?gOVYov5+lUApX+1WtkjjCdG1Fxh5FxvBRcnhkA5QdnYkOIY4l0MgVGDisn8l?=
 =?us-ascii?Q?9xbHOm8mkRVs2ngwI3cdIz70aU2ClmxhoKEZ5o5Mcs6w5OAtAmnJFXlor4hs?=
 =?us-ascii?Q?k7QSXyERmn5+qCk8KgKxy23frf0gKGRo/fVKWf3/oEoJFUUuqi1LUDPD5atK?=
 =?us-ascii?Q?Sm6Tbq5zG/GVUb+UPDmIXKhns8EbtwLvTvFT5ikGZ5CCg23qLHVK4lS27Zn8?=
 =?us-ascii?Q?RtEay6mYqwUs8kjM2HgA870U3alp/2N/tIsd7XZyLTA34hicTTZ8XsNSJ10T?=
 =?us-ascii?Q?rrGpw1xlpkyG//VeY4LHpNriopohc0Ot5UlVsoPvOKLO8wdVuPfL2FtJu7nx?=
 =?us-ascii?Q?GeTjQCtHDsSbbA8kekrO+9niOfdUODUTZAs0h9GwCxCqxcKZl8ufYtJI74S8?=
 =?us-ascii?Q?R7YixwqXPNwZKPWIMmDX2jrl7GHQ2UK/crdylBz86GXSdM7/a/74tLT4d+Ak?=
 =?us-ascii?Q?ZoHL6TxFf6ihbVjdo+e3DqDfTGkk8X8YolmnzREO9BrzggGaPectA2mx0R7P?=
 =?us-ascii?Q?WB61lGm6d8bdoqf5z0EiGAU19k1AhylDIBA1f5Ywi6d7w2Ud404boAaBLtUe?=
 =?us-ascii?Q?3REYT5NdbQZn6HecNQ3EeOAOEvU/xwGt2u7vy0AlXAvDEO4JCyCtn2IYCp3+?=
 =?us-ascii?Q?Ypu9F/+2t1bM+Q6/2roGl5Pzpl4RrU6VdX2a9Bgm3uAUC0WlevzU4BZ1rcwW?=
 =?us-ascii?Q?plGKlkeuC3If3bcsC1rzpUIbwxFKVRA0r22HrcIQBDlj4OqfXrdbhlnhihwF?=
 =?us-ascii?Q?4O9E6NNqhbgXhrQEtYAiGtZfk2VjHuQ1lJt45vqBFbCypK+CrMNctQKhhj52?=
 =?us-ascii?Q?UyvWSTvUIqGk1CNt1Nrdm04hEoKHrDRUvnL9T3GY3bGc0Cb6q+F86bCqZWsv?=
 =?us-ascii?Q?ErCGWJgYXDACcM9SzFUuHykLk0NUOdnfqGmvN9Kt0UcKNsWkUsJvsvOp7ViU?=
 =?us-ascii?Q?S1ozka6L9NN8Hv7iMBJfprhfBgNOjNH6qq5jZV5HQ190C+vDGDAeIJFcR5fu?=
 =?us-ascii?Q?eORWz3ycwLJxwc07vFYyphkHtn76VvHjzIMztHD+eOpMHyhA1gZTHkEt/0WJ?=
 =?us-ascii?Q?X0EKF6VwkeXxKL5F9bGw8nOFaZGkou5ZImE0yo9JjsE/zOZPvcKr9c66jVKj?=
 =?us-ascii?Q?6JBkotHYcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4ded47-c648-495b-4533-08de85a889bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 11:13:24.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEYeZdbwy3Z44Hg+v7xhvt8ZlaCeOyxjakWznqbgZF7xzwTfM66wwWYBUNZ5eSRw0iBnEG4lIGb2FIMef7fFXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817

Switch to the device-managed variant so the notifier is automatically
unregistered on device removal, allowing the open-coded remove callback
to be dropped entirely.

Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
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

