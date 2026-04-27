Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62A35F8C9;
	Mon, 27 Apr 2026 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267078; cv=fail; b=A6TF8CwDuYgg7AxH0uy6n3mbBARH0WCyYbbQQntWp7GqHJxQCo+yh0vsiixVmYgAAHvDdeJ4QOMPS7Jmi9bI+HLcOvOX6LMtUxHdXPzdRDKJKyG5ArBbg72px+M9pGoCFm5SWhGjaLwRnivOQgqtlygytzyyeud8FaVmjTHn/qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267078; c=relaxed/simple;
	bh=AU2tmT050w5QUdA1DilwIKJCBqKyxpv+4Wtui5dDgcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmvfJja6zatUAQuQ+93Jb6y5iJmVL1OAnt7PLnHwupjd9bg6Te/UTvNZ22Rph85XOI3m2Z2sb+miQuv8ymD7BtUlRp3T3Fa9Y2ZjyJ1Y/7FzlWF/xI/C49IkRoBINczZFMj0xN3m8TrqAAflYJ+VsU1ICIg6eKVOuaTtviZRH6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y4APsze+; arc=fail smtp.client-ip=52.101.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y4APsze+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udOf0OnU2Mnp3CSYU8UySY5QYr9A6VoCVZnNHloIvW5M3cLrBZe2lgn+DUldggXN/FQRm/5Yd9DSPKFzVQXc5HHcqsbgZWPnzdvSrAEJJD5dwP55KZsFqA0vmv7WLgytYnsBSueRvX05NCuqkvWS33okkR0IAzZjrpdp+vkF1hiO6ttDVPIYIWzeUMqL8kNkPppgTu8DnmOVS6M20/z/BcwesN+dI0srjqKRuAJEQWtrXHhmLLRm+ewLvRlE8FnjFn/xC80PdJi3QhH/8OYdfOmZ8GdNcmLMx192cNTY8/PGuqT6Yw8zGo4sUmqAF0lj7AkgYHAuiIZnMLQ7xH2PHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8JBZMqtv1Pt4wVxgxeU2LN7N+/GeD2QW/j3Kevx2U0=;
 b=MZsiyBQfcnRyIvYRd292WvMerYT0RwKGAOFh7JUHb3TK5DeA1cRI+vC1FMHShgwWqektrnowmjttWsue1LezjPKJhyfSpKxfB4+OFmGm5Dcqdj3Pitz1l7vb/Go1awBaCREc0KwXJMR3sii8m5edeLwY/ryLpKjamIxn1/nHYdYWomSaqVHzWXDFOru1mkgvXVEC9f0UsYAX/VGUHcMBufSSs1D4jCIYTznEBwwl/e4PwDke5/VDj6Q3EjS24SBml2ypY8K3s+QRLh0LmGZGLh3hgr4++95b63hnVCEetWFBqMRZTGNubKHinKgkQ18qLgQJ8dAiD8vRnvsISc/UMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8JBZMqtv1Pt4wVxgxeU2LN7N+/GeD2QW/j3Kevx2U0=;
 b=Y4APsze+72FH+radkNBaoWO3ODgCD6U23wiApGXenIUry6wacdq8tTnSCQOIi2wABzQTl8MEq1E/KsyGjxKtPoMOUztAnwZj0oAwxxVx95kL4Go2FwR4Ws1mt4N8hscLqozODQ4A0K9T2p9wl+WiUnHVrOtsGrcou8q5//jU4WM=
Received: from DM6PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:40::40) by
 SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:17:54 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::3a) by DM6PR03CA0027.outlook.office365.com
 (2603:10b6:5:40::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:17:52 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 00:17:52 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 00:17:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Apr 2026 00:17:52 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63R5HQUr2543740;
	Mon, 27 Apr 2026 00:17:47 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v3 4/4] Documentation: PCI: Add documentation for DOE endpoint support
Date: Mon, 27 Apr 2026 10:47:25 +0530
Message-ID: <20260427051725.223704-5-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427051725.223704-1-a-garg7@ti.com>
References: <20260427051725.223704-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ2PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: d710bfef-d9a3-49ce-859b-08dea41c5532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|921020|22082099003|18002099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	Mzf/lMYP2fTZGsoGK/w6eP0ZC7YumKgYpCAhMgGq/0hz59h3uvEHDc1P/x/jPpbl9eiRS6B6JtTgzj2sAYmeetJaNpohrNXF9UgFGDl50yV9Mz1ja3ukGegG8C8XYhoy3+FmOWt6zjWNpN3vU6hE0Ka390U6QtjSCXQy3i3B774ludxN43vijstOZIVklNKpKcf7z8GEkob5mPfHl/YRuYk8RfsfBAq0NctYrI5uTQQtIJEgZtjR5axWJhLuJYhxsUPnqOXgas96k3LItmjK3Box8zEc1Ene+11XDE6zxVgf2958DUMpTuBW/g1GEq4GmOphylA8i7cQPxMqPNP8ivm6jI685KQkECw60MjYPsMhqIOWiBrLJP880HJvnv5hF56h+ks0UMnZIQGfBvUGm0fXSLALytcBGlbHHDfJE16fw+KVcwLQjnxH1ODaY/PR0oz9ml83EiZZPCLv2sKV4J75OuKYAynmD//Ocumzusbj9169a6D/FB/WSOxNjsmGEHUcUcPbjzm+7xizJ8IwksZtFAKnjQ/Om00/ixU5r6Z1zgM0YxDoRSUOi7iwJ+r8waT0wKYemIEMuzUsbPirVfbNviWhV/0pEDM8j/sCHTkLnwaP4uG8e9QOu2B01gYhwtBGZopY5SCzUPEDHggW+Z4+73+3sm4MeA5MudaUQKspU1VLxA2mHeGNI4EiaLmq2HLndGrIdQ1sQf2+NEPdv0hNHaFEm7TnhoyyFQSeYy2yMit3tfW1cdlzyhBBqaBlD7AOEk8GHsG+2zGW320f4yQukod3+tAhcegUiLweZJB9HXaAhSweOjWfXDfRx6nWRtSGVl91u46roGfGlG7smw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(921020)(22082099003)(18002099003)(56012099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QIFNIvyZs/QuXLMZmpO54pbNMA06DHNZVc/nPYCrYmCBsEDhKUrc7jtecqkS/XYTy+r69vqnzgTcCTGWTzx9xjGAQA11ARZI5fbCD1z1LArvCDDa1WLyqukO3++WyCH1GYw2QxoJWIxntZloKvrEWpCZgV/ieMKtA7anBSsVNZe81fLoBSw5QCnibH2MNaDrXLZObxO1Mr8ryaH85ie112e2jk7sYtR3zrviQ/u90bcUAT9nxF+AQtjBPCKwZtXD86oNvWrEVh/AvIO+9K1Xqm/nF2GwB5Hlwr2djgb9UcesKjL4aRfmbBm6fL/BdDpYhigUHQaExgJngYmhwEKZUc7K8xiyl8IedBl//ktp1dGeif/jNVbh/MaH+7LOEIfdS7GolQI5rN3KuwZAAly9PYsNOG0syltVT183ord80Vc0o60PDf0UBkEwh/CGw4Jt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:17:52.7742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d710bfef-d9a3-49ce-859b-08dea41c5532
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040

Document the architecture and implementation details for the Data Object
Exchange (DOE) framework for PCIe Endpoint devices.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- Squashed the patches [1] and [2], and moved the documentation file
  to Documentation/PCI/endpoint/pci-endpoint-doe.rst to match the existing
  naming scheme, as suggested by Niklas Cassel
- Updated the documentation as per the design and implementaion changes
  made to previous patches in this series:
  * Updated for static protocol array instead of dynamic registration
  * Documented asynchronous callback model
  * Updated request/response flow with new callback signature
  * Updated memory ownership: DOE core frees request, driver frees response
  * Updated initialization and cleanup sections for new APIs

v2: https://lore.kernel.org/all/20260401073022.215805-5-a-garg7@ti.com/
v1: [1] https://lore.kernel.org/all/20260213123603.420941-2-a-garg7@ti.com/
    [2] https://lore.kernel.org/all/20260213123603.420941-5-a-garg7@ti.com/

 Documentation/PCI/endpoint/index.rst          |   1 +
 .../PCI/endpoint/pci-endpoint-doe.rst         | 318 ++++++++++++++++++
 2 files changed, 319 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index dd1f62e731c9..7c03d5abd2ef 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -9,6 +9,7 @@ PCI Endpoint Framework
 
    pci-endpoint
    pci-endpoint-cfs
+   pci-endpoint-doe
    pci-test-function
    pci-test-howto
    pci-ntb-function
diff --git a/Documentation/PCI/endpoint/pci-endpoint-doe.rst b/Documentation/PCI/endpoint/pci-endpoint-doe.rst
new file mode 100644
index 000000000000..03b7a69516f3
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-endpoint-doe.rst
@@ -0,0 +1,318 @@
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
+DOE (Data Object Exchange) is a standard PCIe extended capability feature
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
+    | |   EP Controller  |                            +--->|    Buffer    |  |  |
+    | |      Driver      |             Free           | |  +--------------+  |  |
+    | |                  |--------------------------+ | |                    |  |
+    | +--------^---------+                          | | |                    |  |
+    |          |                                    | | |                    |  |
+    |          |                                    | | |                    |  |
+    |          | pci_ep_doe_process_request()       | | |                    |  |
+    |          |                                    | | |                    |  |
+    | +--------v---------+             Free         | | |                    |  |
+    | |                  |----------------------------+ |         DDR        |  |
+    | |    DOE EP Core   |<----+                    |   |                    |  |
+    | |    (doe-ep.c)    |     |     Discovery      |   |                    |  |
+    | |                  |-----+  Protocol Handler  |   |                    |  |
+    | +--------^---------+                          |   |                    |  |
+    |          |                                    |   |                    |  |
+    |          | protocol_handler()                 |   |                    |  |
+    |          |                                    |   |                    |  |
+    | +--------v---------+                          |   |                    |  |
+    | |                  |                          |   |  +--------------+  |  |
+    | | Protocol Handler |                          +----->|   Response   |  |  |
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
+**Framework Initialization and DOE Setup**
+
+The EPC core provides the ``pci_epc_doe_setup(epc)`` API for centralized DOE
+mailbox discovery and registration. The controller driver calls this API during
+its probe sequence if DOE is supported.
+
+This API performs the following steps:
+
+1. Calls ``pci_ep_doe_init(epc)``, which initializes the xarray data structure
+   (a resizable array data structure defined in linux) named ``doe_mbs`` that
+   stores metadata of DOE mailboxes for the controller in ``struct pci_epc``.
+2. Discovers all DOE capabilities in the endpoint function's configuration space
+   for each function. For each discovered DOE capability, calls
+   ``pci_ep_doe_add_mailbox(epc, func_no, cap_offset)`` to register the mailbox.
+
+Each DOE mailbox structure created by ``pci_ep_doe_add_mailbox()`` gets an
+ordered workqueue allocated for processing DOE requests sequentially for that
+mailbox, enabling concurrent request handling across different mailboxes. Each
+mailbox is uniquely identified by the combination of physical function number
+and capability offset for that controller.
+
+**Cleanup**
+
+The EPC core provides the ``pci_epc_doe_destroy(epc)`` API for centralized DOE
+cleanup. The controller driver calls this API during its remove sequence
+if DOE is supported.
+
+This API calls ``pci_ep_doe_destroy(epc)``, which destroys all registered
+mailboxes, cancels any pending tasks, flushes and destroys the workqueues,
+and frees all memory allocated to the mailboxes.
+
+Protocol Handler Support
+------------------------
+
+Protocol implementations (such as CMA, SPDM, or vendor-specific protocols) are
+supported through a static array of protocol handlers.
+
+When a new DOE protocol library is introduced, its handler function is added to
+the static ``pci_doe_protocols`` array in ``drivers/pci/endpoint/pci-ep-doe.c``.
+The discovery protocol (VID = 0x0001 (PCI-SIG vendor ID), Type = 0x00 (discovery
+protocol)) is included in this static array and handled internally by the
+DOE EP core.
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
+The controller driver reads the request header to determine the data object
+length. Based on this length field, it allocates a request buffer in memory
+(DDR) of the appropriate size. The driver then reads the complete request
+payload from the DOE write mailbox register and converts the data from
+little-endian format (the format followed in the PCIe transactions over the
+link) to CPU-native format using ``le32_to_cpu()``. The driver defines a
+completion callback function with signature ``void (*complete)(u8 func_no,
+u16 cap_offset, int status, u16 vendor, u8 type, void *response_pl,
+size_t response_pl_sz)`` to be invoked when the request processing completes.
+The driver then calls ``pci_ep_doe_process_request(epc, func_no, cap_offset,
+vendor, type, request, request_sz, complete)`` to hand off the request to the
+DOE EP core. This function returns immediately after queuing the work
+(without blocking), and the driver sets the BUSY bit in the DOE Status register.
+
+**Step 3: DOE EP Core Processing**
+
+The DOE EP core creates a task structure and submits it to the mailbox's ordered
+workqueue. This ensures that requests for each mailbox are processed
+sequentially, one at a time, as required by the DOE specification. It looks up
+the protocol handler based on the Vendor ID and Type from the request header,
+and executes the handler function.
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
+After the protocol handler completes, the DOE EP core frees the request buffer,
+and invokes the completion callback provided by the controller driver asynchronously.
+The callback receives the function number, capability offset (to identify the mailbox),
+status code indicating the result of request processing, vendor ID and type of the data
+object, the response buffer, and its size.
+
+**Step 6: EP Controller Driver → Root Complex**
+
+The controller driver converts the response from CPU-native format to
+little-endian format using ``cpu_to_le32()``, writes the response to DOE read
+mailbox register, and sets the READY bit in the DOE Status register. The root
+complex then reads the response from the read mailbox register. Finally, the controller
+driver frees the response buffer (which the handler allocated).
+
+Asynchronous Request Processing
+-------------------------------
+
+The DOE-EP framework implements asynchronous request processing because an
+endpoint function can have multiple instances of DOE mailboxes, and requests may
+be interleaved across these mailboxes. Request processing of one mailbox should
+not result in blocking request processing of other mailboxes. Hence, requests
+on each mailbox need to be handled in parallel for optimization.
+
+For the EP controller driver to handle requests on multiple mailboxes in
+parallel, ``pci_ep_doe_process_request()`` must be asynchronous. The function
+returns immediately after submitting the request to the mailbox's workqueue,
+without waiting for the request to complete. A completion callback provided by
+the controller driver is invoked asynchronously when request processing
+finishes. This asynchronous design enables concurrent processing of requests
+across different mailboxes.
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
+back to the controller driver either through the ``pci_ep_doe_process_request()`` return value,
+or the status code passed to the completion callback.
+
+**Error Response**
+
+When the controller driver receives an error code, it sets the ERROR bit in the DOE Status
+register instead of writing a response to the read mailbox register, and frees the buffers.
+
+API Reference
+=============
+
+.. kernel-doc:: drivers/pci/endpoint/pci-ep-doe.c
+   :export:
-- 
2.34.1

