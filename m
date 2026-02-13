Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091B34F24B;
	Fri, 13 Feb 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986181; cv=fail; b=scCPJAduAKA+8g+wVwKC3EqIV+WNusJXl2Cq+d2W2NB5mSpBMlcWp8x3f2HY15QuzRG1itD0+X/YgYeGjAcnuD0/E9dqpmtHFK2EqkNY9EN+iIOQgGyBTi5IIlJ17z36Tait92a+gKTqLwM4DCIjfcuU8A2UFaLF6VahHbya1A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986181; c=relaxed/simple;
	bh=o0iC0pJvpAiSTRylvyrhfbriG2+6AU0s674kBAZVmBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3rlNnTsnoK2fnIrHk88xQSsd1lLkpqm9yS9qUssy98qgKpOqoOWHKPJITnUVd6CdTdh0D/guoxISrvTc6Wq/D6U179OazGyNtAVO0an82pqmQh2FWgZg5vEoljfIfCA1/ziqKCVrEKE+awmdN3weYoCn0dzLes1s1UBZoPTofA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tcw8eTgf; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tcw8eTgf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJxRH6FUOGCCq95atdexYByHm1lkCFKhrmxrd9eGAofCCPSjA6vjczcSX/aykr+BBIblTHIe1sqFpZk7FPH2PeeKqEcE+XWQsGfTwDmdFOP5h6D2zduM0NhyhsiPtlvB54deqbq78bk2AwFejnMhQx91g2awFv5jis8ouXWTfw9UJSyvh1XoPDnR9oI7VDz0DK2qZyMZpJoIscPcuENsaIonvyHo8XgOQF0Gs4Jnl20HXc1SPtwXOIo75wfRp6SZWsDvHsGe5PDHDCJtxcbYpzPkpIEutC9MAPPWl5CRCY9yol4gFdBh/GUd+PFRYH9gDMovmYGqnzn40uy57fMU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAIWeEu4XKXu7vc7Bv72vrZucxeR6akG2FvL+NgGV9Y=;
 b=OHh+2cfVlinOkjDK9Uccg6mDdwdmxlnvPPr1SAiXwMhqWTAzlydScK0fmdjawXBReBcNqbue+7MJJan12NOkhKz5+9p35MiV93rSs+H5t4aUAKCeOOfcMrcp3USy5p35vmjJ59+cj5aVc9sRYawPFLibMyO/dlpUsS6YjghiR9B3dSGn1qQ/NmuFPYSIvdUjicUZVbY78HBQTtghCXjvZRqMhtYO8mdZ90R2P/Q8xzF83uFneqivzs84Opl4m3oJnYs/9tyLXjPcIfeXBbycHn0zFcFuu94Lpziqv/F21aNtgckB2ssc88niqR/ag8qXyspHqeVLlOELTv+hR0HXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAIWeEu4XKXu7vc7Bv72vrZucxeR6akG2FvL+NgGV9Y=;
 b=Tcw8eTgftaQaNAZvGZuqzUvObITNtvHyX6wBxzAcsiDfgSegTZuBgexwO+yBt7xHthquLtsH8GPLDogEtrOIEim0X8tHDxL7Db9pdqskYuUClKCZZ4OHfywYOUmqOb2f2YTkftvPH4dQQEO3i3yrs9CwOjUYAKl/B3EriZxwbYQ=
Received: from SJ0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:a03:39c::28)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 12:36:17 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::bc) by SJ0PR03CA0353.outlook.office365.com
 (2603:10b6:a03:39c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Fri,
 13 Feb 2026 12:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 12:36:16 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 06:36:13 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 06:36:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 06:36:13 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61DCa6A7751418;
	Fri, 13 Feb 2026 06:36:10 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <corbet@lwn.net>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [RFC PATCH 1/4] PCI: Add documentation for DOE endpoint support
Date: Fri, 13 Feb 2026 18:06:00 +0530
Message-ID: <20260213123603.420941-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213123603.420941-1-a-garg7@ti.com>
References: <20260213123603.420941-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MW6PR10MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 87948c03-6c1d-4618-ef3a-08de6afc7b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTUvTzEwd2pOdnFUQll4ODhFZDlnVU90TmFoNGdPeFFYUVBSZ3puSkxLMEdo?=
 =?utf-8?B?SWxNYkdWS2tVUVh5K29LdXlQOVJQcFNyaXFzK0x0b3RCYi9VR08vUWhSVlBh?=
 =?utf-8?B?aGJKSGtoNmdnRUdpZzdtY05TRmhPZVRYYXcxaElmMnRKY29sdkc5cHp2WUNI?=
 =?utf-8?B?a3JaODYvSkp5bjVqcjF5TjB6RGNuZnZ1dmFXL0VtazFIM09NTUd0OVUvZ0lj?=
 =?utf-8?B?T25SYXE4TzhBZ0F3dElNVmpWVDRLdTZKc01FNjg3MGZJblBPRFU1VVJCdklP?=
 =?utf-8?B?SmJudTVNaG85RjRrRldyd1RyS0lybkR2aklyeGgwY1VzUTZWNTJYN3RweVNI?=
 =?utf-8?B?SmZtK2pZNVJXVk9FTzZOZzRhUGg3NmJwaVhBRDBVb1R1YjhYcGRqNU9ZZ0o0?=
 =?utf-8?B?WUFWZnJ3QkpIdEpHSllCNFZ5Q0didmk4U1N0ZklxYm1pWnBJV3NpOCttVGpu?=
 =?utf-8?B?Rmd0b0hCU2lONkZaYnFBNjZCMEhkaXVrMUcrVkZ0YWRlRXllUWI3Vm5KK0Q2?=
 =?utf-8?B?SWlwam1pOVYzRHgvL3lhdXR4TnRhQmpLWGdzck1sRlZTbTNzbnNlMy9xOGRL?=
 =?utf-8?B?c3FYV1NOT1dtM0hHWkhmOUM5ODg0Z2t1U3JBeFd1SDdEYlJ6K055U2p0ZjNX?=
 =?utf-8?B?Wkk1cmpPM08zU1pNZjVVeHVaNFh1RHJwZk5RWU1yY3E0aDVOTjhwZ3lVYmg3?=
 =?utf-8?B?a3FGTWZlMUs1SFRLU1BGTHlCYmVKQmk0TnNGUUhBY2Vhc1pGYzd2c3RLRTNZ?=
 =?utf-8?B?OForWG9CUDBMaFJ1bWtkK2Nlbnh5QlZjTVMrVHluWnJhOEw3Mm1oWjduOHBz?=
 =?utf-8?B?Ykk4VS95aUVKZFVuR29TcVBlZlE1b2F0WFJEaFlvbDVGTVFJRkpXRkFhYTBL?=
 =?utf-8?B?SUhhclFBZWQyamJxNVZ5eFNWeDYvREorSzhldmVtMEJqV3RBdEdzRGhXVTlN?=
 =?utf-8?B?WS9kcVZzb2RCa0swVkIrYm9oa2pKYmt0SUJERndkeEx3RGpPRUxuaTBRUEZD?=
 =?utf-8?B?OVNwWC9MSEI2aWdHSFFLOG1LaWhIOVdkaGx4QmhmQ0JrZUU4cDBmRFduTEpm?=
 =?utf-8?B?dUExVytXUnBiZkRlT0tPZXcwbjZlZ3IyMGNRcjZZb1l4eGlMTDU2dTU1dkRF?=
 =?utf-8?B?eHQ5dGdvUDFLUjJIeS9HaFZsYzcySWZVSVJZUkRVNEFiaE1Iek8vSGNTaVlo?=
 =?utf-8?B?aFhNQTlXYTJaejFJSWc4blZnMTcwNlJkNjI1cUhhZCtxZE9raWExT0NlQmpW?=
 =?utf-8?B?K0pvMk9zTlRMR2ViYTVOeEF4d2w0em1Ub3EvekFwOUFBWUtncXgrYis0NFNH?=
 =?utf-8?B?dmZNa01zMnI5SDRNWThLWjVObzhSdFJaS1pBSlRSeDdjU0lweHdXME1xRkVM?=
 =?utf-8?B?bjkyc1o1QTF3eGZqVjBkekpZTU96TkxHUUJPakxOM2Mrdm9HcGdkUDd1b0FN?=
 =?utf-8?B?Y21uamNONHlZVVRiQVQ0RC9FdVFEenA0OGJHcDhkSENBdDV5SU1aRjJ0TDRj?=
 =?utf-8?B?YUI3RVFoR0Z4bFRYa2YyK2tCcXB5TWIzY3dnRXRCZmFFSFpMdjl1cVZsa0lm?=
 =?utf-8?B?OXVQRElPRjI1TTEvWHp4L3FwRENQLzdhR0pTTTFta3VSODM1cHRxSzBLOFBD?=
 =?utf-8?B?TGZSOVlQRHVCZlJNNWloQzM4YkpoNk9tRnFRNnFkUkQ5T3B6Rm5hNnl0WGJr?=
 =?utf-8?B?d3dUOEpvcmVFTTlkYWdEWHZnNlByVmhuK0NyMFE1ZVh2dE1LNE5lWjZ1YTV6?=
 =?utf-8?B?b0E5ckpLUXJybXVkQVFLMzkyWWI3K25UUmplMWk5VTUzcFFZemk2YVRSV1hF?=
 =?utf-8?B?TzZiS2xyWWNIZ1I1emYrdDNXbGVsZ1pZNktSdzRwN1FEcm1QY3ZTdHBnV3No?=
 =?utf-8?B?bnFrMnAzVGtkMGpZS1FKNTdtYnF4Q2ZCWmdJRWs4MHRBY3RCaFlIWkdjWFJS?=
 =?utf-8?B?UGxRMFJiT01vYlpaN3lYdUpFYTZWUDRGckxGQkh6YlBsQWxnU3g0RTd2V3Jv?=
 =?utf-8?B?RS9wcVIzL2RMRWt6MlhadGlwNTlhT0dINUF5UHYrQXdLV2xlRkxCYjBZYytu?=
 =?utf-8?B?T3AvZ1pxamtPVE04VzBxTnFyblByNFhCREYwZUcwMjltNzQwVW5hUXBWd3dR?=
 =?utf-8?B?c1U2Wk92aTJDUFhUUjBSUmgvekc4dGZkNStFak10YUZmSXBtZEtWeTNGdTZi?=
 =?utf-8?B?SHQ2SVZvYldydDRienYweFRVMW1veGswM0c4WmJmL2ZFdVZyekdBcUMvdHFo?=
 =?utf-8?B?ZGQwUFhMakNvV1FrbzNWNmxtRjZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FXVlMDW8PuDVvbn6FKzPRFVV0+dgBmFH98Iun3fpmGzqmvtGbVj37uG+4gDZ1y+v3p0n+A/Un8MHzsqDMko2fuCzOIIdGarQjaEMNiSHKDIUm8ZD6TMGT+fZwnBnYZc+y+i+kjy49SRW2uj8k7jUh0mtrXtvgfGWVF9/UmWoTcu0atTOGupvT7jcv6NFV6JPzPA+J+XhvSz/LBsu2ur85W5ZSaXV3hi635oWuiFN+9xuJnc+VOlj2IlEARV7OwIWTeEme3u5CB1gMJpjX9T5MpwQ+KTyuR4wMRZvG4ILogZhWn1WrjpBQo2AGI2JKSYo2tV4hW1gc6kt3S/1eyGusg2NIxJzhOUmdAWOI2veOTd2xw+AJG99zAVNQEXenuJQQ2/LBkwDw7cyY0MhLekOi3ptPlf6zWpkazb2Fvz7q6676bP+uwuJrn3NumXvFXg9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 12:36:16.4225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87948c03-6c1d-4618-ef3a-08de6afc7b44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552

From: Aksh Garg <a-garg7@ti.com>

Document the architecture and implementation details for the Data Object
Exchange (DOE) framework for PCIe Endpoint devices.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 Documentation/PCI/index.rst      |   1 +
 Documentation/PCI/pci-doe-ep.rst | 291 +++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 Documentation/PCI/pci-doe-ep.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..4c9a4e749442 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   pci-doe-ep
diff --git a/Documentation/PCI/pci-doe-ep.rst b/Documentation/PCI/pci-doe-ep.rst
new file mode 100644
index 000000000000..d6715944c117
--- /dev/null
+++ b/Documentation/PCI/pci-doe-ep.rst
@@ -0,0 +1,291 @@
+.. SPDX-License-Identifier: GPL-2.0-only or MIT
+
+.. include:: <isonum.txt>
+
+=============================================
+Data Object Exchange (DOE) for PCIe Endpoint
+=============================================
+
+:Copyright: |copy| 2026 Texas Instruments Incorporated
+:Author: Aksh Garg <a-garg7@ti.com>
+:Co-Author: Siddharth Vadapalli <s-vadapalli@ti.com>
+
+Overview
+========
+
+DOE (Data Object Exchange) is a standard PCIe extended capability feature as
+introduced in the Data Object Exchange (DOE) ECN for PCIe r5.0. It is an optional
+mechanism for system firmware/software running on root complex (host) to perform
+:ref:`data object <data-object-term>` exchanges with an endpoint function. Each
+data object is uniquely identified by the Vendor ID of the vendor publishing the
+data object definition and a Data Object Type value assigned by that vendor.
+
+Think of DOE as a sophisticated mailbox system built into PCIe. The root complex
+can send structured requests to the endpoint device through DOE mailboxes, and
+the endpoint device responds with appropriate data. DOE mailboxes are implemented
+as PCIe Extended Capabilities in endpoint devices, allowing multiple mailboxes
+per function, each potentially supporting different data object protocols.
+
+The DOE support for root complex devices has already been implemented in
+``drivers/pci/doe.c``.
+
+How DOE Works
+=============
+
+The DOE mailbox operates through a simple request-response model:
+
+1. **Host sends request**: The root complex writes a data object (vendor ID, type,
+   and payload) to the DOE write mailbox register (one DWORD at a time) of the
+   endpoint function's config space and sets the GO bit in the DOE Status register
+   to indicate that a request is ready for processing.
+2. **Endpoint processes**: The endpoint function reads the request from DOE write
+   mailbox register, sets the BUSY bit in the DOE Status register, identifies the
+   protocol of the data object, and executes the appropriate handler.
+3. **Endpoint responds**: The endpoint function writes the response data object to the
+   DOE read mailbox register (one DWORD at a time), and sets the READY bit in the DOE
+   Status register to indicate that the response is ready. If an error occurs during
+   request processing (such as unsupported protocol or handler failure), the endpoint
+   sets the ERROR bit in the DOE Status register instead of the READY bit.
+4. **Host reads response**: The root complex retrieves the response data from the DOE read
+   mailbox register once the READY bit is set in the DOE Status register, and then writes
+   any value to this register to indicate a successful read. If the ERROR bit was set,
+   the root complex discards the response and performs error handling as needed.
+
+Each mailbox operates independently and can handle one transaction at a time. The
+DOE specification supports data objects of size up to 256KB (2\ :sup:`18` dwords).
+
+For complete DOE capability details, refer to `PCI Express Base Specification Revision 7.0,
+Section 6.30 - Data Object Exchange (DOE)`.
+
+Key Terminologies
+=================
+
+.. _data-object-term:
+
+**Data Object**
+  A structured, vendor-defined, or standard-defined message exchanged between
+  root complex and endpoint function via DOE capability registers in configuration
+  space of the function.
+
+**Mailbox**
+  A DOE capability on the endpoint device, where each physical function can have
+  multiple mailboxes.
+
+**Protocol**
+  A specific type of DOE communication data object identified by a Vendor ID and Type.
+
+**Handler**
+  A function that processes DOE requests of a specific protocol and generates responses.
+
+Architecture of DOE Implementation for Endpoint
+===============================================
+
+.. code-block:: text
+
+       +------------------+
+       |                  |
+       |   Root Complex   |
+       |                  |
+       +--------^---------+
+                |
+                | Config space access
+                |   over PCIe link
+                |
+     +----------v-----------+
+     |                      |
+     |    PCIe Controller   |
+     |      as Endpoint     |
+     |                      |
+     |  +-----------------+ |
+     |  |   DOE Mailbox   | |
+     |  +-------^---------+ |
+     +----------|-----------+
+    +-----------|---------------------------------------------------------------+
+    |           |                                       +--------------------+  |
+    | +---------v--------+           Allocate           |  +--------------+  |  |
+    | |                  |-------------------------------->|   Request    |  |  |
+    | |   EP Controller  |-------------------------------->|    Buffer    |  |  |
+    | |      Driver      |             Free             |  +--------------+  |  |
+    | |                  |---+                          |                    |  |
+    | +--------^---------+   |         Free             |                    |  |
+    |          |             +-----------------------+  |                    |  |
+    |          |                                     |  |                    |  |
+    |          | pci_ep_doe_process_request()        |  |                    |  |
+    |          |                                     |  |                    |  |
+    | +--------v---------+                           |  |                    |  |
+    | |                  |<----+                     |  |         DDR        |  |
+    | |    DOE EP Core   |     |  Discovery          |  |                    |  |
+    | |    (doe-ep.c)    |     |  Protocol           |  |                    |  |
+    | |                  |-----+  Handler            |  |                    |  |
+    | +--------^---------+                           |  |                    |  |
+    |          |                                     |  |                    |  |
+    |          | protocol_handler()                  |  |                    |  |
+    |          |                                     |  |                    |  |
+    | +--------v---------+                           |  |                    |  |
+    | |                  |                           |  |  +--------------+  |  |
+    | | Protocol Handler |                           +---->|   Response   |  |  |
+    | |      Module      |-------------------------------->|    Buffer    |  |  |
+    | | (CMA/SPDM/Other) |           Allocate           |  +--------------+  |  |
+    | |                  |                              |                    |  |
+    | +------------------+                              |                    |  |
+    |                                                   +--------------------+  |
+    +---------------------------------------------------------------------------+
+
+Initialization and Cleanup
+--------------------------
+
+**Framework Initialization**
+
+The controller driver calls ``pci_ep_doe_init(epc)`` during its probe sequence.
+This initializes the xarray data structure (a resizable array data structure
+defined in linux) named ``doe_mbs`` that stores metadata of DOE mailboxes for
+the controller in ``struct pci_epc``.
+
+**Mailbox Registration**
+
+For each DOE capability found in the endpoint function's configuration space,
+the controller driver calls ``pci_ep_doe_add_mailbox(epc, func_no, cap_offset)``.
+This creates a mailbox structure and allocates an ordered workqueue for processing
+DOE requests sequentially for that mailbox, enabling concurrent request handling
+across different mailboxes. Each mailbox is uniquely identified by the combination
+of physical function number and capability offset for that controller.
+
+**Cleanup**
+
+During driver removal or controller shutdown, the controller driver calls
+``pci_ep_doe_destroy(epc)`` to clean up all DOE resources. This function
+destroys all registered mailboxes, cancels any pending tasks, flushes and
+destroys the workqueues, and frees all memory allocated to the mailboxes.
+
+Register and Unregister Protocol Handler
+----------------------------------------
+
+Protocol implementations (such as CMA, SPDM, or vendor-specific protocols)
+register their handlers with the DOE EP core during module initialization.
+
+**Registration**
+
+Protocol modules call ``pci_ep_doe_register_protocol(vendor_id, type, handler)``
+to register their handler function. The handler is stored in a global xarray
+and will be invoked when DOE requests matching the vendor ID and type are received.
+The discovery protocol (VID = 0x0001 (PCI-SIG vendor ID), Type = 0x00 (discovery
+protocol)) is handled internally by the DOE EP core and cannot be registered by
+external modules.
+
+**Unregistration**
+
+During module cleanup, protocol modules call
+``pci_ep_doe_unregister_protocol(vendor_id, type)`` to remove their handler
+from the registry.
+
+Request Handling
+----------------
+
+The complete flow of a DOE request from the root complex to the response:
+
+**Step 1: Root Complex → EP Controller Driver**
+
+The root complex writes a DOE request (Vendor ID, Type, and Payload) to the
+DOE write mailbox register in the endpoint function's configuration space and sets
+the GO bit in the DOE Control register, indicating that the request is ready for
+processing.
+
+**Step 2: EP Controller Driver → DOE EP Core**
+
+The controller driver reads the request header to determine the data object length.
+Based on this length field, it allocates a request buffer in memory (DDR) of the
+appropriate size. The driver then reads the complete request payload from the DOE
+write mailbox register and converts the data from little-endian format (the format
+followed in the PCIe transactions over the link) to CPU-native format using
+``le32_to_cpu()``. The driver creates pointers for the response buffer and response
+size, which will be populated by the protocol handler. Finally, the driver calls
+``pci_ep_doe_process_request(epc, func_no, cap_offset, vendor, type, request,
+request_sz, &response, &response_sz)`` to hand off the request to the DOE EP core,
+and sets the BUSY bit in the DOE Status register.
+
+**Step 3: DOE EP Core Processing**
+
+The DOE EP core looks up the protocol handler based on the Vendor ID and Type
+from the request header. It creates a task structure and submits it to the
+mailbox's ordered workqueue. This ensures that requests for each mailbox are
+processed sequentially, one at a time, as required by the DOE specification.
+
+**Step 4: Protocol Handler Execution**
+
+The workqueue executes the task by calling the registered protocol handler:
+``handler(request, request_sz, &response, &response_sz)``. The handler processes
+the request, allocates a response buffer in memory (DDR), builds the response
+data, and returns the response pointer and size. For the discovery protocol,
+the DOE EP core handles this directly without invoking an external handler.
+
+**Step 5: DOE EP Core → EP Controller Driver**
+
+The DOE EP core waits for the handler to complete by the work queue, and returns
+the response pointer and size to the controller driver.
+
+**Step 6: EP Controller Driver → Root Complex**
+
+The controller driver converts the response from CPU-native format to
+little-endian format using ``cpu_to_le32()``, writes the response to DOE read
+mailbox register, and sets the READY bit in the DOE Status register. The root
+complex then reads the response from the read mailbox register. Finally,
+the controller driver frees both the request buffer (which it allocated) and the
+response buffer (which the handler allocated).
+
+Abort Handling
+--------------
+
+The DOE specification allows the root complex to abort ongoing DOE operations
+by setting the ABORT bit in the DOE Control register.
+
+**Trigger**
+
+When the root complex sets the ABORT bit, the EP controller driver detects this
+condition (typically in an interrupt handler or register polling routine). The
+action taken depends on the timing of the abort:
+
+- **ABORT during request transfer**: If the ABORT bit is set while the root complex
+  is still transferring the request to the mailbox registers, the controller driver
+  discards the request and no call to ``pci_ep_doe_abort()`` is needed.
+
+- **ABORT after request submission**: If the ABORT bit is set after the request
+  has been fully received and submitted to the DOE EP core via
+  ``pci_ep_doe_process_request()``, the controller driver must call
+  ``pci_ep_doe_abort(epc, func_no, cap_offset)`` for the affected mailbox to
+  perform abort sequence in the DOE EP core.
+
+**Abort Sequence**
+
+The abort function performs the following actions:
+
+1. Sets the CANCEL flag on the mailbox to prevent queued requests from starting
+2. Flushes the workqueue to wait for any currently executing handler to complete
+   (handlers cannot be interrupted mid-execution)
+3. Clears the CANCEL flag to allow the mailbox to accept new requests
+
+Queued requests that have not started execution will be aborted with an error
+status. The currently executing request will complete normally, and the controller
+will reject the response if it arrives after the abort sequence has been triggered.
+
+.. note::
+   Independent of when the ABORT bit is triggered, the controller driver must
+   clear the ERROR, BUSY, and READY bits in the DOE Status register after
+   completing the abort operation to reset the mailbox to an idle state.
+
+Error Handling
+--------------
+
+Errors can occur during DOE request processing for various reasons, such as
+unsupported protocols, handler failures, or memory allocation failures.
+
+**Error Detection**
+
+When an error occurs during DOE request processing, the DOE EP core propagates this error
+back to the controller driver through the ``pci_ep_doe_process_request()`` return value.
+
+**Error Response**
+
+When the controller driver receives an error code from
+``pci_ep_doe_process_request()``, it sets the ERROR bit in the DOE Status
+register instead of writing a response to the read mailbox register,
+and frees the buffers.
-- 
2.34.1

