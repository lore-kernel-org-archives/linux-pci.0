Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC05371046;
	Mon, 23 Mar 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253745; cv=fail; b=anBe5HIfiofTkn4v6I3Zc2NFQCkrPLOy01n/+3odtx481oRBp5LY2thch4TGnwDmR9PVsY/55LCpUH92jwT7DRJMBNDnlfMMNGDiEYWNVkYJp3XeLjthKowONnNgyHWgQL124rVYdBKFaPR3yuI5hTg5b11f1rwHXHehlfnh6/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253745; c=relaxed/simple;
	bh=GaOhrDK+Z0M/BbC4roojuAf4K5NsvFX0tB38Fz8KZ1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T8yrvPBOL06RL2A7FILtcQ/fdC1MuGIUOXiACu6ERxtwcfCzhx+oWEinMzc9fjt6KYA1SFEG+Crf9l2UY0ZicxZYwf4MOIS2jSZj229BnacYyrTZdt8gLHVmUOgOxAH6amaqNmaEJBERzszJeRW2BmTWYsCwwcHsDNT6OLAHyfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NT1CX5pR; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NT1CX5pR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6QuEKYKUN9muVQ28q8hIk12+yiLTDwISfV1WGED14z57zkHqIar2jBlCf6Xj2YzGxkSpgL/sTNL8T/oxr+rB42cD63Fwin/945HpaTRdzpqUhno7Xm3GC6HBI6VSsOvo8myGFt0cmAbNH7B6QKunfsXx1HPC3JcNawq0/bJTVhBVklfpSjghNoTlcgvacBMYa7PRtxh/eEoS6aCVCTSziy4SKfEX3BzkqdaxWlRdjBcEVe8S1wGVyzPGUrDtjau0em9x+uv0tzfsCtdFhENfgQYsevKuqsDQ0AMDMbCtBcoFFE2aE48g12zVa2Ewy65LBdtC8UvJgE89VX7pKC2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4squsl6W/5++roGn6ymxlPl5hyr3+/SlgpdAa+laCU=;
 b=O4gZp7eyPvg3CLVnPXbqjrbj18tnXkzQJH467DTFM6Oun5jGNkFJtunTbIIHVNIFv8R1R2zFkzPDVExg4NOI0kQVZsjARi2RweXn2UVb2oAUX9SacRLBIKGLSy6ZUlVhd9W72Y6FSURls84aRyqBaJGpLe7nybVAZvuaMZoF9kmU4zvibrlJLIIDwhrAgm3ALzHFg7zgzZfctVUN1tnGQ2Z8qQAn4P0XP+K+5HQkkGU04PCs0YdSZalGZP+KPV6bK/UpYUsWgXu0iUs02/svYr2ZFCrwczmdln+B/0TafV2m/Apt2DOfB7OniuZkLYLfVruvtR1e39S0JGr181KnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4squsl6W/5++roGn6ymxlPl5hyr3+/SlgpdAa+laCU=;
 b=NT1CX5pRw/DU9vJbrqfKG7VdWAUrFkMWe0hrD9gxfugeMbLiArWrvj33C7yeOEvOAT2veGsmTgHTnikPZAu3IuP9fH9kb2Bumj4xJiBQDv/H//SRgUXffhFJuP0FLe8WdAn7IPdOV8QJnit0VbFCIX2pUfw4q2IXMQ7wTR92+0nuat+5XA70BSxUz/AUX8N7GZnjFH3q01LFX0SzjnfvGT/dixCClcHPPDXTnE1uGVZ1eIRekRAkon8c7LtLwirlqUjd1fSu/MgrVgO355rqcQ4PoNMmsYRGho9JVF1625+wh2G+4jsEK5gwEF4gLE8JRTg/H6cCCFXd+mjsqbCCIw==
Received: from AM8P251CA0015.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::20)
 by GVUPR10MB9880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:347::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 08:15:38 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::99) by AM8P251CA0015.outlook.office365.com
 (2603:10a6:20b:21b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Mon,
 23 Mar 2026 08:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 08:15:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 09:18:26 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 09:15:37 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Mon, 23 Mar 2026 09:15:23 +0100
Subject: [PATCH v2 1/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in
 subrange_setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-skip-bar_subrange-tests-if-enospc-v2-1-2080f878134d@foss.st.com>
References: <20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com>
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C712:EE_|GVUPR10MB9880:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae9ebbb-39a7-434f-298e-08de88b45df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+s85Yx6/jCwfgzhfbC+1WVuCVgMaH0GcTzh8eJRPTKERufv1a7XTG5pmF2F4TfnGg+uIqSYxCODaTnOco3UgJ4mwoWq4ionNej3hfvPu9BeMYvKxdFfp1kH8c9UDjNnIinX5EmCnbzDxmYh5AV2v/M3l8G6JucPCQrEppLyWPh89BfBtUuzDe+d7pssvUyjYQZcWLUycNG4d1JrKbb4nWEHw9gOvXKgvJHEdYuUuKdKmD9A4xmiVFy3Qlyd7W2gMHM6DvDqzWBr7CYhtfD/ELQCKqpmC0b+92VIAskUG6Ll/0KAUYx/afH/z+n+nXHnhh9cfP1jr6PiLn4kQ1icVeh/YWykA7/MviCqmzwIrVwryqRzeDTzKejw5CuxlhONBxNRwS8PIZxiMc2fw8igd4UqOPwY5rC7ZdJE9bgrKuXAU5NT0z2quTqdZhsGAWN9AHDh8keiZzJiVoWVVzX/FjmR6cJXini7howLH4LwUAktufqQqFLS23qyhlpcZs05a6ebio2XyQhOV6R5dFuxgdfXaHkUk5AHtv1pHRrPqNWpkQeatp2M28bRir+zyimxoMJfK5sqIJ/NkeKh7M9P+ayqsfcSE0II7WkTvAtyKrGRcQnmCEgOqvlbBA937BFB2ctjA+ejvctyv4rEfIw9rOV0cpoOA1AH6Q8Vftnh4VrFMzP79Ansbcb3x7Y8IPZ7O/2D2UlKaTXbWvpJhsTK0dvUk1a4lPk6MwAq+EEz827q7RgDckAZIUsNN2FM+wwdmrhLtFYWq2rq9fOo84B59ag==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IMElpVEojUQwSp3DlPvKnDB6AWpbAUeefJtGLv8j6q21USjlitd4UGajPE2Nceb3Al6eXE0oa4Lfkks0BD2bVxeraj1/eVLDT9AuNvdIUGoStx1qVZGpE9T2XzDYIjQvzFp7sErHMYRME3gHmZeXSw9hRvv4gFGXHHJRAzbN9pBlp9FpZBTV2vO0QxQI4eoqicdloFup6jkwNxXBmrZxZjS2esX/P6sAIBpJEfKc/0dcm6g8FtkpJby7Dg5vgxsx3Cn3DJlRHYyCnjqBqNGJYnteiTcRoBGZIQkhyxtWVQ++Xy3aPIm+TyPHNrNQbMITNK2rf9o4bfHCrV3DTXbuZltvlTuQSyGXaEwMF7JzJPLjG/PvtcRyvSSF9SiLaFR+XnGWiZ/RzJFLklakWMYK9SQ8wzy4x9Buz9z6ywdCVmLIiUi9pN+0UhcrTSKjHJ10
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:15:38.4045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae9ebbb-39a7-434f-298e-08de88b45df3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9880

Set the STATUS_NO_RESOURCE status bit on pci_epc_set_bar() -ENOSPC.
Here this is used to indicate there are not enough inbound window resources
to allocate the subrange.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
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

