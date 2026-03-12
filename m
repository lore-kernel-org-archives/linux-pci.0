Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C53B388D;
	Thu, 12 Mar 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307599; cv=fail; b=Cqy+TgR6HmpVBgnUjUJgOWyd50wDWGHf1ma+4mk7yosRLGq6lB/kHM4vSvGnoJUtHe15cSxzPUTpS3gxLQqmUaiLP2jGlAPcjukWrJjJh0Ie54KVMQjbYVHhA3dpRonxmswX128txGfQ2sofL8SfmRmowmo+4He+qrw0FPp3FyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307599; c=relaxed/simple;
	bh=DKvSlpv5vWFol/s3cZMogPffr69k6YJ6vaDQjNhNnx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/bksMEdA3OkQ5GU/C1h2M2DvsBr/KiEN7IsDulq+W2KPbV7oJbW5hqqcIL/BMCdT+7DCvdqaEYOIUeM/8VP0yO5aUcfOtwevlF/BlEc4KyLqER5C2D+uxuLejOSjqXP2e+UIMfN+0ZfEp2Oj9OArsQvtGlsgB8+My9Cjll1YbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eUC+iDNo; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eUC+iDNo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzsChJvJwvLtdF94pZki4Y180ttMRRkqoJmLPRGE1q7NPkq97CvS3ktBw29RuKJj4xEMVl4dCw9t6xv4sT72MdotfAVI3YDRZHYmTcYskvPho0k6RQPCip1jQUk6ktq72Wp+o+ulzmIZy7MYqdlnhziqyisL8EBJvhc2/GIAFluw1OZjJ+R/plPBUsv8vffrGjZPWCwyz5BAc3dvAPbLpyL+2OXgPScREa6nw/7DqUdv/03pg94J1CoLkxKg7pWNN3ZzPVjLl6g6z1tocYS75DrHU/Nzi3zMEaSZLC0778h1T3gALXlhme1L98C6DemF3nsYm3IZ4rst61jp3aBOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7zYa3rethFWeSqSsg+nTWO5iQazvHDg0YBDJRI6zM8=;
 b=ZoZOfzq8i+B730qHea3lebtYDC1YsVoF4/Mz0d6WkV/QKdbtHHJfyZshojU6S5j5vUNOxK2nai2blwx/LeBmms63OeV3kv/S+ZoYEb8P1esakRTOS+dAkjVj88S9yw7btSmmy1twaanKQNm7QBVG21EK33Cp/TTck8ZaxenJ+D3qyNyfcbmSi5LzkGzTHt5zVNDDa480Zcx14QN2KsvmDTL5xO77rqTl7vrKnGltBSOpn38I4KmiKA3wjYH/nnlLGY0uYKgUepEDeHmPjwnLbCe2qKfpAMWrADXmaXWv1eaLbOUMnpXE6CtMTB2JWhLUA7IyylbcfplLZw1yDUAEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7zYa3rethFWeSqSsg+nTWO5iQazvHDg0YBDJRI6zM8=;
 b=eUC+iDNoU5I7XbtKDgrpMCYSHA1h6bjutaYKg+2B9drIxdzxGUBX8mYiRfgP0X2Gf8tOSyg8zfd8shjGfOwtLEX3JJkCGPCcaj2tmBY3sXrwR478rJ6L+e9eSZprGm0djvY0peb64e9c3+g79k8hH5syWztZry9Pb5VOShYHOrQneAUtjsf4PKrhb5MqFpYTAL+oMLuB/qOawbyf/SLMIEcpps3FJWUybLHoQpdkWu2Sf++jOrosLm/6+/MQ158yRl06DowUesFbUExmNR4RmKppHiztebh96L9DCfsncYDJBtNID93ZYAxPgT0X0rUmzMZEudcYwTVhXepk5ebhuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:26:33 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:26:32 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/5] dt-bindings: PCI: imx6q-pcie: Change maxItems of clocks and clock-names to 6
Date: Thu, 12 Mar 2026 17:27:41 +0800
Message-Id: <20260312092745.295578-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260312092745.295578-1-hongxing.zhu@nxp.com>
References: <20260312092745.295578-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM7PR04MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6d26bd-a579-45bd-de92-08de80197286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jOKkE47E+Ina21V7MGYVMS3WcWP6BXFBxcfb0FFq6PTU9PWTsyglzilusJ8NVDtsWw0tHZ/5VaZ2G1IKXI6i6A9TguEPk7O4OIAlebSlZq9R6zcVGJb6G/2tF4DDjpqiZb0ABT3lyXCbA7AZorT52z9N2dGIsQMWuoEgvf5j8Ei9Rp2DrNcNGpfJk2P/OAejgX0s7Tq0g0mbAcl7iH4L3pjszXBXFr0EM58/e18XWLiWxau6s8PvRLrFKL/sebexoWgzx/ZW6oftPOy2YWAkVZZG4aU9re//tHDWdVvP1tWLigiIwQHle2l75rz1piWvuY29xkLB8dWN2rjF15NLSMyoEmmy+hD7W2fbPC4z31FLnBmvQLZ/9TVCST+jdNi1EMCASpcPw8cGh3mMnbqTOOudigZyxPm3tZVXPrkaZRXtMfJgNct5HHPzjE//NC7g0pI0X3dKr5OmDzVMs7jkqC5wvg0S38BxMFuvDuvoWEk0/sybOZpwFyYz4Yg1VXBt7CV/lxF8xswkRJtszBQklx4/7dTsq+49kdFrWkP6l/ztAGwCOL5L2eBazi0QtN8LjOHupXBKUmHs8LNHZEZWP2H8ZGi/EiXzlChBzdTZZxXiL0k3I0JGqQH9WEI3k2+x98Y2WhiosFHd5+cd8AdgYwu9IrEHWhw0aWUJZNFKiB3TGYN7JNV1yGHYyym0NeRA4enAqoqhGF9u8YxEvQkQhWfv0wcNlrn6Bf8dcFwjp4tlec8TBLfcswHonxT/daRIlxvN7DxoVyYGiUwI8d8b/oyNzgRkHZ9InW+d8CMuLQmJAbpDssVdeNDLcwVbxvnq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yM8bl2zA+bzg7tJ9v7DwOTEcXA0J1vdLACfgRI2Pw65CfL3ivmPsU/wQrlp4?=
 =?us-ascii?Q?xc0pJPfzbW0GgwPdyFZik6zvK7tfV9fCnRNRVizDgk2+JqxuqOj2lE29aLQS?=
 =?us-ascii?Q?oiM0XqTuL3QnFuu1NOG9pG6ekLWnF3eESDa0a7gL80x6zccsOJG5DYuVJFAq?=
 =?us-ascii?Q?CUVob5OiQMtpjI2OsLL7dilbRDrGJcQwnPhT0wZu9lGgiJeKhoowKs6YlzUS?=
 =?us-ascii?Q?WHzuKXVAe01CA+Y0P7uQcLJpwjLvPoHBgFaYmmUaj1HCTSavhMpfQDN5G6ja?=
 =?us-ascii?Q?njrWVlEZR6dQMc7r7N2pGZlFqcQrXrQn2lic7NkpxXWQ82r6H/PPsIKEXnpV?=
 =?us-ascii?Q?uuQvh8zBjboD7Hj2J9hASlj5zUMhMYo4BnNodpsoeMtCurW5K5DAvEwAsTu/?=
 =?us-ascii?Q?FEKBMuvo1Unl15Y9SnXvuEowusdLjeBDjv+JJKaiI6EEZ03z6y9QYY/H2Ffh?=
 =?us-ascii?Q?sSmaewflDoiPsAOiFkxmzyeuz5K9EcUVCYUH8TnBs6E0hVqw3GsTHkhwHMq9?=
 =?us-ascii?Q?EvS6QFemOvIpqfMK4UZCTx47VuSSUlsdC42GHIUHoL9QlvSz2RB9f8DBR0iV?=
 =?us-ascii?Q?oHmPOcbQzPHwvV/d04/TT5XbhquAUmlWkPaHWWfOZ+RVt5WJzeOZiUGgcr/8?=
 =?us-ascii?Q?jlc99esqwn4LhR41KhVhQ6FZULDWrqnubASg4Q9DC8m12ewoWhIXPx9d7Sbx?=
 =?us-ascii?Q?UOTfZ3SslBwHCjkscaho2x7Twv4y1sWe3lULS0ad48fAXLn5udECSb0Trvwh?=
 =?us-ascii?Q?SD2Tc6hMewShElT4hTu/eGiWdyDUsXJRvfuOSYU8QHvbI7M0CR2qPrwmGZmo?=
 =?us-ascii?Q?OUS8caPyDiPl4Ip0d8S1rnZ0D6f28JrZjWx99PNVFEUq1MGQIIoLFa3oS0vl?=
 =?us-ascii?Q?P72sOM0dzeFXT5v6er6doUAFypG/GMhkYxR4BgpcFwCl6KhTAsYMhw32bTvT?=
 =?us-ascii?Q?Q4Kaa8duSYeAVdRbCfzyupppUitHtYPADb7Lkju16Lu/t5BTWBYAXIXLPOZa?=
 =?us-ascii?Q?+0yk46hFW4njFmMkhsPCPN/Jt8K7ZrrByXbzg8z/QYNKW9xRF5aUeMyrsi5b?=
 =?us-ascii?Q?2xTMNEa8SeeMk729sdtL31A09ZTXDsnn0xLiLeZMyfQ7fji62jtFfRAxW5Zt?=
 =?us-ascii?Q?02WDYaZD2cHK2Rslr2KmsdW/acVHiqI2uonmVHyroB10fV2auoX3H9iQUb/U?=
 =?us-ascii?Q?T3hagL/YWGcNAzRUo7UV1+n1xez7c/qw25R8ubcWQcVw2B6fs4Bmxf5bEa2g?=
 =?us-ascii?Q?XjznqRt3hmb0iRxFtSqFMguP4MSzbxb81VkOo3iW9aCAvyac3Ybjl1X1k6ag?=
 =?us-ascii?Q?OaXyMYWOtG98Ax+Q1PGdXdNA1Aw90minlkbYMgKtyRlsxJFwnlLefUx8jBKp?=
 =?us-ascii?Q?zDZFehKzfu4HG1goNBiwiYaRslYuVLCFnwGfwBO6Pm1LsBWdGbNIOr9XZadk?=
 =?us-ascii?Q?3ugHpOWtXuJG7SDKRjnne40JhvzzlU1G9vif4kFtDoZhGx17ps0arfNy8jMw?=
 =?us-ascii?Q?YNl0w2h7eD8wSdkA8Gin5JmlrlsaDN5wWQ02KYSeD66Xn5NsWFfpx5O1M8Ic?=
 =?us-ascii?Q?IHUvfDEJ+nHjYmkHvNZixb1L8zhtM1oL8B+I3MYX9ZXZhR5JIrGcYXAHDhGF?=
 =?us-ascii?Q?xcY8kEF3vDsKpZbkb4KtlKfYYfXncu2CZtYH50uVjRyFdFQGedncpvh/JMmI?=
 =?us-ascii?Q?kukm+JAlkpBIIwoQEwLIKvybZ3OheCOVxQ1rZtdFXO4xRVqUz4siV5ZPsLIc?=
 =?us-ascii?Q?8Ah8m7vgBA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6d26bd-a579-45bd-de92-08de80197286
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:26:32.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egZAdmCLgDfsCgo6yCfWy4BXV2ulCaLLdSUl8Jb7rCRcLelDjLeb2w8cgZcoqsqL12gRestnNjxLWbV9KsHSdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

Previous commit 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")
was incomplete.

The constraints for "clocks" and "clock-names" still enforce an incorrect
number of items. Update maxItems for both properties to 6 to match the
actual hardware configuration.

Fixes: 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml        | 4 ++--
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index cddbe21f99f2..0488c942092d 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -17,11 +17,11 @@ description:
 properties:
   clocks:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   clock-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   num-lanes:
     const: 1
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12a01f7a5744..7fe1e0e9b565 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -40,7 +40,8 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
-      - description: PCIe reference clock.
+      - description: PCIe internal reference clock.
+      - description: PCIe additional external reference clock
 
   clock-names:
     minItems: 3
-- 
2.37.1

