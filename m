Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF91F3B8A;
	Mon, 23 Mar 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267184; cv=fail; b=JYc0WZxrtuPQwigaECkHE02mbDyCVByj8WhpDepyQ5lXcBB14zdglViWdmhElum7/Gu2T5OUhSusCx8EvbclRrdQVwhT4vsEPhcP9Kc50LNmxN63gt/rZ2OQv/ULEhGwJkD0gQHkT5zZywV7uf3DmKXimgY+3oDI9zXlteELupw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267184; c=relaxed/simple;
	bh=fpY63K4uMKx9CuprrnlhMcdNs3dFbe238pJ4Ks8d2Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hqb42D3yci60Bg9rXblqMlldLyqT8hMydgK8KLBO1zwcCbk3sEbMQKZUqgKes6tqZsuNyAeddT+k7yCHNPJ1j2QQSZdUYER6Tu+5UCK7H2DfXr8DR4+KnD7f0RcezArK6XVTA7QgixPgOYWKRyzg9l2KNHVdIqiPKTbVwbhWGl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hPSgUsCA; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hPSgUsCA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv/bN8Jb1rRjRHwr8vXCv7BBdULxnJesZ+OjJU+nlk/qFfbwtdjgZUkLAE014kkGUt59g5NIbHHhPIgKTacko9Qrg+fg98D0d8+mVBurEDhtB8yIiTJfxplfJIuOvjn3Mm24JntL3ol0Qh8/eh4Uzs5DHsvBCANV3O3gz879cmxFqOroW0e8j/iiisnQtXGa17G3tF7BJ8HIyWYyZ6cMD649GjQEsK0XNh9BjkHvvLr5zEwYGOoO/myh5aDxcy/cg4CgjJO1SLutqMCXiQ4az4JsrqpHZz0J/u1fexodF30r1cf+EJnTgnXVsaYbuMSggmGgMNtP8kc9o154kJUVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPtDEvfBSXqH+bMuBdZOoTSjD4UD0yBV+k5ft1nM8Yk=;
 b=etXlvKSM0n5zt/cKfpHnRAD/O5eTB74YqO/haYlGVLU8TfIU18kMoopUe9GSO5Fant3qDZL7g42Wnzo0nWEWI6sUUFhhVw+YDhiXOScgkMaeo8RyGgBaIEJZB2+ACFALF58gnXe2gFj24NvOP2yQraIbN31RhYwExNt9lSjhrSs5O2refnZaYO5eC1eSCEn8OYes+5cEsXHZwaK1Py/ycDejBe1MoY+faxdAYdnY7t84conb8Rv2EgZnMHrIOyVSNS3Owz8mvNTpKv1kvZiX9Yvi3ZKCMjJG2uwCvmO0X/F2oKymIG6swqrLp0Yx0AUtXxo+1nzVUapIaGk/Sdpn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPtDEvfBSXqH+bMuBdZOoTSjD4UD0yBV+k5ft1nM8Yk=;
 b=hPSgUsCAiuJ20kzW/37xxM1yI6f1CLEpzB0A/fS70WCV/2tclrJvkV7Ed4y7UMQSsz0xcsE0gUrF9WFpFGGdmD6zQzJz8T+qGS8NDEQuHbBQ5ua5fTedjeQxiHzEZet5cjeEf0YkB5806i9Z7hn/yV9JImC8txLG0V/tYxzEsYlFrbXpGk8LZkizCgreiGXIsyRcotJXmn2TRE4fg8tVeOboNDuUZVgMBEz9qy3qb4N3GnqeqeVlX1RGp+SMYFm0wCA14TsonyefnjoE6EpPU/TyGpRDMSyFDH/v9hR9mDzFZehVwJ2OOnop7Z92BOitDoYiehI5Tzf8oqHqxG4TBg==
Received: from DB3PR08CA0030.eurprd08.prod.outlook.com (2603:10a6:8::43) by
 VI1PR10MB3519.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Mon, 23 Mar
 2026 11:59:38 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::44) by DB3PR08CA0030.outlook.office365.com
 (2603:10a6:8::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.29 via Frontend Transport; Mon,
 23 Mar 2026 11:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:59:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 13:02:27 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 12:59:37 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Mon, 23 Mar 2026 12:59:27 +0100
Subject: [PATCH v3 1/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in
 subrange_setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-skip-bar_subrange-tests-if-enospc-v3-1-4780f296a5b4@foss.st.com>
References: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christian
 Bruel" <christian.bruel@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|VI1PR10MB3519:EE_
X-MS-Office365-Filtering-Correlation-Id: 096181c2-4ccd-4c0f-2959-08de88d3a899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CRVYAMo97GbV8iYniqEWH56kJsGrMs1jcYRuHyrovSmnv44xWUbgIO8olcfR4RAEmXq6OABcOlsSxo3TJozhe619ATbkl6t2MyoFb7MKyOP2uA9JbBwDFdNVmXcUyiTp2q/XwAxYme9rHMQfJd46NiQWwz+SnZIbNtyv+pjydUSh1jRZtPrsbeEju1L8BuGqog61hqSvFLRRYVUwnQXdkZRMsfm+zJB1XwmRXbT8k0Phvh7wNC5FXecaBd9usOLRdMOTnXMI+kdHZd0RiUXNmigj5sVY2oNRCZMexsYsOBKHh5lb9R4rYZn4ykrH6TSfb+06f/HmLuT1zJWmwlpgZ+eIY4QfPdR0DEzCmBYEYVaT6VFbVnIq/PBCUH6b2GHzAtKH9acQq04Qt/PFtq6/rv0Zge1Z9pF4nTva+Vf5rDGeyU1IyFXqStHzOv15hVvDHxgF/YyeyGiET/IuzFbKGcRnGW6vvLWbb8oj1DS2tBMdMFkeeGzNdjRPBvxKPt9u4sQI1oKN3eEX03MRheDcVTLi5eiH4OfCooUvf0Ee06eAIcyrjOcya0RNb8m/fEsA0ZAXhHRQhFcmy2W79u4Zrgs1IZo/6N8nO/z7VvwAnoa8v6U7woINbtwu338sdaIr0Z7HBxwYiVjeTFvLnOO5ZPegdFh6AZcLWquEkcD/xU4Kb0XTksFrwAGg39im0tu5sUpdsrcH//78vqjqnVnhiQDied3tqnBtlRdSjENQIkTxOzqlv55uZQL+h4EBVKDEgoQw3G2qXWMX8L2oRWUXyQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OwSVz/0nqyz9HYv/BKgG7TaRT5vFxi8S5aU8ogLgpAh/RWbOZ68dxLqXWYbgX12TH0UYhd688rSc1Vvy2OT5d7YXiCzmIDT9KLXAem6Z+HB0a2XrAyz3Gs91VxmeIOTZnQtq4OLx5Pxf6hGwbL5IIro49IOe29bXea6y7yenAt6Z9ezOJHpfpRmIwwaWAIf1hnu/L7CyrFze81/dafWUJuHnh4EqWS49Ot/0HrJmY6SdLdYt1tPqXsSqN6vViyjw+8Es6wEreRo5XABdNtimAPzGuGsvqTJbclfUFCQ4jGMOz669bCtmpXgjy7FRHop0lzo9307NXqRvLxMcLaEJJM4mrNWBnGy7IlYomc3uNQ7O5G+MWgf37+nmYEzOIfQypni29Wnuf8efMUk2J8XUTWn2Reh/P4y3IINc5FNbJDsYOUh+lzdhs9I8sA01GvFH
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:59:38.0139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096181c2-4ccd-4c0f-2959-08de88d3a899
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3519

Set the STATUS_NO_RESOURCE status bit on pci_epc_set_bar() -ENOSPC.
Here this is used to indicate there are not enough inbound window resources
to allocate the subrange.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 06bf53b28fb7ae2244a6d82bd5fe76d40db830b7..591d301fa89d89addf5df16e775e80460b689589 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -54,6 +54,7 @@
 #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
 #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
 #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
+#define STATUS_NO_RESOURCE		BIT(18)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -901,6 +902,8 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
 	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
 	if (ret) {
 		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
+		if (ret == -ENOSPC)
+			status |= STATUS_NO_RESOURCE;
 		bar->submap = old_submap;
 		bar->num_submap = old_nsub;
 		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);

-- 
2.34.1

