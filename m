Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D93A9619;
	Mon, 25 May 2026 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691964; cv=fail; b=C36B7u7rhTLtXQg+MiZzsvCdbxoae9fbVs5Prf8/EIVJX0buTv55GOY+tiX0RCijQJInWA+x/36zaF4ntvwL5wfe76FfPb1OE18FYA30xwukByxhPztGZzZLfrcSRrsK9WvLagVdtdQHIqCHHnDBH9QE0oYM5GzYbfiZw4DvtQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691964; c=relaxed/simple;
	bh=x6lM6XDmbDLTEc2zQjE+Oqk+fxu7uCukvg34a7aTDyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A847Sz7/z3w8vy3dQcn0vgDxFe37J/98O5r+Ctyds4B25I5+8jehH1RI9aAdQC64ve8yfO5JuVMJM37YHObWDSWBuvXN85r25VrrbptdkbAfapZwjGD1YVs7rw0gjyVz5/2dwN0R3aCipewMXujZRNd8Ub0GTRabZe9qv8aUwKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=czsrPM5l; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="czsrPM5l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGcX37O2mEVA+ktJpmKq+Soh4CPzREzeCEFW+CfMrA6mBCrKk1krPiI3iHsxMd4HqQXc3z+fs3C2KqNJPXg/PZ9GrmG8ePrrPGUkvoLY/2l+4WC9o9HY7yHuc4gJryrWWSStwSNOKzrKXi1CK412PU47F2uMnfbjRBDhsBSU7qHAqxlsYqn+Vjyq36GXmgBdqE85t2F7dWzLfZX11YSsDyKWjweRBhRLb3owkmKIG8EXR0l9fXs/RxZbJAgoAQ6vhBHa6o25KtFVjtbeTN4dX3pzChfGG1NVMaIsDOktBb/BR71aE8bJJpoigW1I8J5CrIsChfIZK/imD1zcZZrBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bMbCTQ16D/vgzpodOpw7Tsnx2BwD0W5m35IIjcyBLk=;
 b=e8dsfCK/oRH6+LdwAbfxwSUnjJ9YqcY+eYA3qjpD5wyeSxY/J+mLnEuv4J1MwsR9LcCZuluctvdOi2ZNZ1pWT7EFW8yEC3yFlUTXA7UAiuA+Rv9ZS7DigwGdkgXi7z6+X7dgSL6OkqdD0cZTuXuYxf5ssqblrE9cH7THezlbctTRhHEG6Rn2oIS2luGwENvpul3zXKARDamZ3WzqnE/Ejv3apk16wn7pfbTttoJAfiK8+dSaQ0ELYzzWh8xlDauZR944GjoA6SM0ZcJGjMd6TbE45gEyqM43rL6yGMSMLi4WKA05oGEnLpvFdHPdUhnn21ttacKeNEsT9JtsrGIthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bMbCTQ16D/vgzpodOpw7Tsnx2BwD0W5m35IIjcyBLk=;
 b=czsrPM5lrA2PJsorPvj/VW7jpAtvdSKAXdeSyAYjgDeBTJPv2wQl7ZXiK3QtVgITEaxb270upL1EXQmZtUg5EP763PLC/dIaxdxOoH0qECEoajXPx4hmzJ2yCz68P7jd3M4x/GflTHeEAz9+JwEsh+UnPY8zR0FClAX12kf1Wne0INuBm7dVLr0LCO71LRBSyz79s5370jJosMdidQBYJik44lKLBru/Wa932BgSaK9hG2lje29EG/bW0NMGGQNugPmGmFgyvGmdhbngHX2n7sSzQxiJrEf/7puOdSDEq+hojFN0j6NsCQepTseAI41PUwRAQ0wLyI1RKvHhdrD7Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 06:52:37 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 06:52:37 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V2 2/2] PCI: imx6: Add imx_pcie_perst_found() to inspect the parsed result
Date: Mon, 25 May 2026 14:54:43 +0800
Message-Id: <20260525065443.2338629-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
References: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: e926594b-8296-4fc3-30a9-08deba2a34ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|921020|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wYiE2Dgxk0YYhUMU+9sY+RhwO/vsWPnaR3nvjC1V0xS+YpDAu1YUaj0VAtHTIW8lX9njayuiyDX3s/NgN7pcWbp+L2nAunFE6GIvKIf//FxC5F/DMmm2C4TLyRe3yhCE0VQAvmRIhctYD+DoxCg1Au8FMyzmZLaYaxqYTQBy25QtoZrwCkfz4/ZwDBbFumRxPhblmYmWlmW/Bn70tTtc2mvVY9AATziSTtbfTT+py4xqjlaZD6Knzsq2Y62qsaa9l8bkM4wQ80m+mK2vnvqf7rBiosbOYYml3Yb+fh/grL7HHQoqthq+Vw2C4u0ayavAfhRGNq1dlJhSvJM8QpzRhhIZ6x/rbMbH67ZlxK8H1v/ll89YeLnn6+RbfzTiXg/Xndam5prFGO2z5qQaTeJ1j/ha4w/rWv7akjxvu5yCipom9voKXo6fQBsX80atHf7qjVb1ttsfkM6JENA4MqYEv/2M8R8SWWfGWUsJnb2nziIxOHPyD/Pg1NtsA/gu0gQlnqX+qG0gimlcRkBN+Tpsx3LP8u48QlwKg0AS8i49RDM6hOv+8Jae1RF3NftznwgscgprgQlKt0QXeV73Ri87pYdKJ2w95vPZJTEUspGYDxyIDoQOwiuDJlDur+lIhqE1vQ13Jx+m4O83O3YUyOIvcStasPlCwUFAVyBLZIUQS3Qt0l5Yx883LAJ9ZKzOvP+lK0PsuWrhnb/o/hczmogVV5MnefKetxqYBy3/pXen8rA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxsDRfMOT9Sszs+QV6msohP7GITPWwBXg+HOKdGhqxtbygB27ywM+kOiSuIS?=
 =?us-ascii?Q?7NQ4AucQxX2jvUaHRsDIiCZN0gAOkJaBsapL3BA073H/Q8EQRhN1ckQ/576s?=
 =?us-ascii?Q?42+4hWsoKdhSCRARMiMhJIc5Ullsg2LyaIrR57WmQO1Jh98ps2Mpx2fgFX8P?=
 =?us-ascii?Q?qcymRXYXnjDjzTiSBUKw3w/BGX81kmweMuJj3/q30b6BncE++j9WBv2ch8I6?=
 =?us-ascii?Q?tiCIlCsoycN9P2ZnU3E0tG9yfvJUgSEN8ELc0SX2zBfmDDgY/37z7JC7W7CS?=
 =?us-ascii?Q?tcVWdLn42B9PXKJAZw05bDBzYMEg5ioTg9avaqJ9bwqDaXW9k1eIQZ9e42pO?=
 =?us-ascii?Q?2597F0OXYjmom6drGb2S9z9THc78fHkahXdyjzvYArTMB0xnGhMDjoxa0n9n?=
 =?us-ascii?Q?krw9nwAjzmPoFrGX++NwLlWExkaBzXjQRE6dC7GU1xXkG2ngoT2qnVz+jjQL?=
 =?us-ascii?Q?ig+EG0ngLPj5eQtzz3F/nGL4hapVz92HhvnoVIygashdwr69OfAdq7zutj1i?=
 =?us-ascii?Q?YcbV58Ht4b/yKyliOlUinm2VuATEgmt+t5dTSb7yPVVYerawcBkwJdrfJlao?=
 =?us-ascii?Q?GW45V4HfG8pR5a7kfnObd1TrYTHCozO56rCg0zbyUeacjXuemLxf7SLSBXpE?=
 =?us-ascii?Q?os/o/kD50MX+FLNgEjXUYkciWoslOVaEQftDZEtyV+OMfw7t70GBzKumXDPk?=
 =?us-ascii?Q?Xx8g1cc+RVPFoih8HlUMTa/T2J6BCrt72OoKd6U3B8qeTDsGBBHASwThixo6?=
 =?us-ascii?Q?qttwQ40QoBloaOWhrNhRTq1aTVeJpxg7lxCdOBpNDURFZUACqaKb6zd3H9ha?=
 =?us-ascii?Q?n6+UkKtqeovq7dO+AoTLUj6neVwttQKPwOmlKQv+XgNpBIH54Apy1MH6cnn2?=
 =?us-ascii?Q?0Op/U6ZTz4Rxx9HWrOAqhEww+fgK/b24jRCR8HW2piO025kYHF1ULZ5WrjB2?=
 =?us-ascii?Q?A3ph9JSNdV2jbV3VKGpDfD2qVHvM71Qstjn9gVEC8jbIzSjW/QzywKhvR8rd?=
 =?us-ascii?Q?lOISk8ypVxlhm1kOp+dPAsNysdhUQ9b9i0K9VW5jFq7Vm8p3UKUcKfOEG0Dl?=
 =?us-ascii?Q?zsmkU6HiI7qbOyXa49DLCWHpRKxZa7tPBHNhMrBEmGMxh2hcb/mg9nTVTs2K?=
 =?us-ascii?Q?OEpO3BhTpdKA7b1zTIBXUY3xRNG5Yc+D8oJFkrCduN46pwqoAQBksgvgF0kX?=
 =?us-ascii?Q?8Pv4pFatUDfOnwSbK7x4WDFHIbdLSwrNx+pWZUmDeeWBkn7AYuhW83jTjrRt?=
 =?us-ascii?Q?sjDI0ALvUF6fVs7txCimQCIW4rMCGv4Wt9pGPFasvINZzFxbrPUZVuNVq+7I?=
 =?us-ascii?Q?mxtRyrFTi9nxCqYtLWA7pShghrC+CbeW7WiKYPL/ZrtIfvp3h+O+Fhq2nqOH?=
 =?us-ascii?Q?CZO7X2QGZKkLNTWb5n+xAcaju++1Zt8b3/3vDmBhCXypUXz/nVPGmIeTow2z?=
 =?us-ascii?Q?dTrBJA5TpmNvT76ZCMtRW4SBUHvi2XNTQUsPVmVGGuXHgL2PGWiodKm6wcBn?=
 =?us-ascii?Q?3QSYbSvnToHBs585QsweVLIkRUZKpeHLcvDGjsgK+q+/z01T4n6y39SGOuJl?=
 =?us-ascii?Q?c+h6c3UCWM9Kz3fgtPTBsRVTBxMubi7Ja1I4CaxpGpt6KxR/WAMLpLtbVaIx?=
 =?us-ascii?Q?/S3sAumaPWKBzWCsDutVNtuSCQbiqL0ZyEYla6jjM1ZkSNf6UyrgMO+z34Sh?=
 =?us-ascii?Q?6PxniPkFI7q0z85aTM91QdNdO4j+qBrAce+jDeNP7xtSUzejhJ6Ty9OAQX/Q?=
 =?us-ascii?Q?sTdqETDz0G3gTG3xQGtTjEKRWtHZGaGFL8Bl6a8DzcDnZ2gn5Da+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e926594b-8296-4fc3-30a9-08deba2a34ec
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:52:37.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJURK14ZXmD8lkW18R9Z6O38fN730YcmPAUjqgSzgvO+CNGdPjde4zykEY7fz/kP7p1QVVJevFlUHT4DlL+xTdnLrzt+0N6wruIGTspEL5Egu+VQZXTM366Pb13cLLbJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

From: Sherry Sun <sherry.sun@nxp.com>

Since pci_host_common_parse_port() doesn't return failure for "property
not found" (-ENODEV), the caller should inspect the parsed result and
decide whether to fall back to the legacy binding.
Add imx_pcie_perst_found() to inspect the parsed result.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index b137551871fc..34756f28fcc6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1287,6 +1287,18 @@ static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 	}
 }
 
+static bool imx_pcie_perst_found(struct pci_host_bridge *bridge)
+{
+	struct pci_host_port *port;
+
+	list_for_each_entry(port, &bridge->ports, list) {
+		if (!list_empty(&port->perst))
+			return true;
+	}
+
+	return false;
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1299,15 +1311,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		/* Parse Root Port nodes if present */
 		ret = pci_host_common_parse_ports(dev, bridge);
 		if (ret) {
-			if (ret != -ENODEV) {
-				dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
-				return ret;
-			}
+			dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
+			return ret;
+		}
 
-			/*
-			 * Fall back to legacy binding for DT backwards
-			 * compatibility
-			 */
+		/* Fallback to legacy binding for DT backwards compatibility. */
+		if (!imx_pcie_perst_found(bridge)) {
 			ret = imx_pcie_parse_legacy_binding(imx_pcie);
 			if (ret)
 				return ret;
-- 
2.37.1

