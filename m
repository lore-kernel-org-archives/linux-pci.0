Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213263B47E8;
	Tue,  7 Apr 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563502; cv=fail; b=QAjEKWt0DxKxD4SCr+CL6gVlz2w0GBti5MHqCZtvSVYmhWmG4DXD3RBjwcRnmO6hF7khVU0BTtgMhoWSEVk2zZrx06LkGDP5kpOJjd0S/+8dtx4En4l1wXxSPZJP+K2lntjWQSRDAj45+7Lh+1/R5zt8yF2ODGvJdIIpLs8bQn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563502; c=relaxed/simple;
	bh=m+n9JAkpFsxmFyhQGNX1qXVOERhOV1OteQdRciMDZvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BS6wE3qmbTrmrH/kZCJbrPcdV2SYE8D5cTKXbDNKEQymgIK0l3AJ6bA21v+XyWo5Rgvlbt7mNR6CyJXmO5s1eannk06KU9HpZCNQKmUpjQMnJ28jHAgwV0IlG2nS2npZfzp1BCuKqo3CUd+ag7BnxFhY/DL9YVicue3RXsPQRfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dOOOQXU8; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dOOOQXU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGq05mFVO/EN1Xf5q6QStnDQFxXgQq8DDajTx5+QTHOU5v9yYHr4NeLi20FWX7ySNSL92aV980Cy36wntHBO1+1+JofRxBjVxy4mK7R45Ko3tATyO/H+/xKy54MTtTz+uActa0+MfCXTOroOWvvfa5q5oTia/E0Kv2CqKwP3avWRCiCzYr5fMSfGgDQH84hawI3/3kEL2sMe2VHho7EH67bhMxTo0LayjYyv+mxf2+VpjrK9s3KLPPjL0FPaQqfTIO5lGoOwXNtP7rWbyCd62/BapMT9OzV+fwba/J1YqsytuPfXF2/sXtudINktaQYCRAT/63rUUEvPz6ktlMHapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgpjzJkulvmQ6nkUd6DrICdC3suggmGyEi0bYwDhzmo=;
 b=yPZoauo43B80uKAKTxVoqY9Lb3jSumwSEdV+zAa5H+dnte0Yix09fVz8XARvjVzpIHhJ1dT+ETLBdwmcuZuHUeEJ5N6YGRmSUKqmEflGzgOEWa7HvIMGSMnjRjUn08dUH+O8kw48IAXeSJwfOaf5Gtv3pouDNz3uP7mKfxWcUUEuZogf/NgnljQ+ra3VnSunLyyXmLgISaN9kufCsQ5DRDsZeWUJEOgvfAHR7WZvx6BsB1QpmSKPtmH9OcMPvHS7RmoexoyO2jLLOu/7KmS3POcPXRP+u2hGf5Z6g72XpEx40Lp2vHynUzCRAVV8Mg7m1+s/fpsGYoxKCrp+iVZXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgpjzJkulvmQ6nkUd6DrICdC3suggmGyEi0bYwDhzmo=;
 b=dOOOQXU8K8ca+nC81Me6DeBfkhw6BXri+1P0c33jm1Pro87Xw8aUPsGC8QPDIMODk1dMi5IVELVetT4E8qX3fCsg3UlzkiwU6r2QiEn+Li6Ekox3aehfcuRv6qJRmXIcddctushB6ofI54p5FrbybMUS81BaZIA9JcaPvK0DqdRqiIlw2HIhWWkrToiRFWnL0/810PgFedEZd4OJjc6SavdPMTBB/OCwAkUiUKF5lN77hCteHOJLhoGWMG7sz4NPQp3bxYpf5mqIA8MCVecdVJLnoxEkKDkwZr5fMH7EhqXuNxvRlH0j/Bf6A5QlpIKtN/AGhTBCohkuNC1cWkdJsQ==
Received: from DB9PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:10:1da::7)
 by AS8PR10MB6152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 12:04:55 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::aa) by DB9PR05CA0002.outlook.office365.com
 (2603:10a6:10:1da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 12:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 7 Apr 2026 12:04:54 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 7 Apr
 2026 14:07:25 +0200
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 7 Apr
 2026 14:04:38 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Tue, 7 Apr 2026 14:04:08 +0200
Subject: [PATCH v4 1/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in
 subrange_setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260407-skip-bar_subrange-tests-if-enospc-v4-1-6f2e65f2298c@foss.st.com>
References: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
In-Reply-To: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christian
 Bruel" <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|AS8PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8286a4-72df-4eef-2ce2-08de949de194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DxOqJz88Pjm32zDeakV47dL+6SVEPapyxKjTHiwnNObsBTuheBTqfh2waw6puQtnGMmsBZi0Z7ilsPDEHmO73Gnd3ODRFTD+jzYIuupmo7iM4yO+ZKgyAdRm9MXkC8o/ctZejs8O+yV3cSpCixnIHFxmeO56NZw8Q58FzsQpsGZs6gUfgP4NltkTTHVh8APTqcbBrdkF3qrGNxCSvreLWaQdyo6+CPKguYYQRjoZ86NM9MPbEexzfkDhOWLyIcGbyv21HGFRe4MTJPwk+Pztji8Y7dV0DYXQ6xc1pFJAWdRvlJm2GCUDuOwPhiXdR75Dxd2trp/II4AZhkROa9YtDvOn8WwLLb3hc2SCSjgL/kDOjjLiYMJmyJe08dADawaOnmIwcJRl145K7bUB8P+LFfkhsmWXzwxZ4kfiRv4WnQRIBTh7tCFu1ebzt6BoDNP3/Zh8uUFNz2PCSy93dxVFJ582lDC2QYvnuiKDQvBXOmw5E5HA10E2haNAQFjpUSqVhfXo9lygBcZu4186mANRQ/XDYbz5rhMimRKFUbts2uEGpcLxcQt5WZHMExSYdefJf3V19Gtmf5zba+mzCLcmynyTYpQ6Xo1EqCjowPgTLWDVF1rGLiQYF9CEUPhRVECjAH87KPZ8jWPvpBmQw9pwNusWryDUXw5r1FsTcEes3GMR8ok3FK6jt3uc1bV+jU8cvOjmtpHxtK4F2TakNXpNs7McfrZN2KQtAm1MZQQC37d8hBzrefloxJ8XV9SvRJcw+6IuiEEIS2KgLpfU2OXHqA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	++KFV0i0NbY4drbgmXstcJPmqhidcaDD0JqOUhSSNpyFSJJobarzzl58yla2t0Sq946MWBRAstVQBCDax+PGHGEj5pmcE/Uhwv/uZ92W/fW/nBhO6l4IBPi1gx+VyT9XpZHsxUjaGeb/Gmbe5HcmiiM+6lCMe1PzuBIWACybrOCONK3clDIt0uGuO8DYjUB/1Cxrw629pqQJy1xSSAp53IJbNyXvM8IjdMXGo8m2IENM2dBt6Ld5QGshRUID4jBP+DtO7V7mB4099cYPGI5vtrRFXp6q+cNm6TE9CtHdErge1Kgs53Peh5K2vAVfYSxDn89RJu/qEdrZhwbm77CR8x3KjJ0pYWTkzFWx6pGuxVp2NUTV7svQXDgOLR200uv4rG4xJZbXnqE2dzZx2s5m63YCRlLsKNOFWpCAetgOUxdmiqFxMdzGBMTD5crVR+Su
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 12:04:54.7401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8286a4-72df-4eef-2ce2-08de949de194
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6152

Set the STATUS_NO_RESOURCE status bit on pci_epc_set_bar() -ENOSPC.
Here this is used to indicate there are not enough inbound window resources
to allocate the subrange.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 14e61ebe1f116ce04789b6f4c3e965296701ec53..7eb94dffac2d193477a43decd7b952c78b99eb5f 100644
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
 		kfree(submap);

-- 
2.34.1

