Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793294928;
	b=NKJMvpdrbdu8hXUc6KhNvJMuMbjvlJsVMQgJO6hujgwE5nFT3VzeiGz/9yEe0CJ9kJbs
	 ilcRhOslPgwV4muc0TaYvvwRM+kbl9s8AamvNhUpDFXBZcK9Flv0tifhoGzHM3y1Q7Eyz
	 tKAPaZ6RRvfhKsoSlAakfcSU09WysRqMIXi9+fXrqCEIHxRiqgLZ/2e5seV8xNHzssl44
	 qTx4CLoWkcz1nBVs55vrvvoNL674JAUf1/VQyFn38+qdlcMO8xMOrnJnJB8s6LluQE1Ns
	 8iwcB8OWZ8oPtiXpK3aXAfY23+n7jQ2VN2c3OIGwmp9c5WiWP0uuqsUIyiS8eacKHMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294928;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mJi6WWhgZ95pB0ZMYJUrCPhVGLd8d518FOi60KUqsEg=;
	b=KIsi4Mg/JaR8z8qAHtrZEJ00paopt94iRc5cy1/Qw8dDzeqpuLSG3KSvo+nesu8eLdKX
	 swJhHpRbAphbgmn8k9rmyhqAfA5GtFfXHYgUfGTC5OxyX2E7yYb4s5/qXJmRMs4oWY3Tv
	 J4mi5wL8/AAxg4zIudOqazvqwjj5BqhfVE4A/wtBwusl+Svon7ls1/mb21y75TU2zOTNm
	 u3upEKEm1jEh5S4NUbqIB4ZI6s98LMl3A5pDdIyCzacsmt+EXjwbm7zA45LSQp0lrrSHc
	 YeVNC5/0990rYS4gJ46TQAHoGWINDmp1CfAzziRt8GLJmtcB8/YXspWMMQ/3F20dxTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=mpFpYnNN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.49
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010049.outbound.protection.outlook.com [52.101.229.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FA606A31A;
	Thu, 29 Oct 2026 17:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 246FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=mpFpYnNN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOOxYUVNWeb00bzJvfHU6FMtpNKGeN5jiqe0MgMRh7qRqgtKvai57gB9Sq47/Iq7wFKPFfZPUvveR0hs8dPy+i5wc255ZZ2E+t7flo0tQSWQrUZMZ2VY9iOBcOst0nhFTApaZvuAJMMZw4kfZ20854odZnN3iUZBMKhgl133+KUWFLcPDMu2mEAVRGhqs02prgpdIb41bYFd6phWul1Ya7hE2Sc/oQ6/CFWbEacd/gABr9QbNU48ogMGOmGZSEO7nJGnoC9eWOAokaWagaGUAKhOfh6QOWQ9tl4fi0qFoQDgNBB2mlQYU2ACyoxuCz4WGklGUFTPenC1asGZklsccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJi6WWhgZ95pB0ZMYJUrCPhVGLd8d518FOi60KUqsEg=;
 b=HHjousS2LX2BZTYhqFbG1sPFqfe8AxlItElPQBCWOXGirI14z88hchbf+cMXaT0uIpczim8/aYKgoAbQ5LV27wGELmEZ0t38rMY6nVZ5GVO/nJ56IScE5wgND9bYY3EnQyAPUpEvo7a9mNQ6XFAa1hgtaETNHm/fzGJu/X3B/A9JPAvwEcCFP4gGmlz+wTFx5suhukU/GTYJCHJ4Iu4f/obWY2IGj4mmgkv3mQ40EOBZN08hlqBPNt+b7DO8YBBgnVlYu1lTYkwJRczfaZ8BY6463CzMu/gsrd2W4hvhOImHH9Jn+/EV3JuDjdMMJG/ChCQUksjZujfcfP9M2CyNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJi6WWhgZ95pB0ZMYJUrCPhVGLd8d518FOi60KUqsEg=;
 b=mpFpYnNNPQZbqNiQe9pwnO9sj41Jh07sOFSm2EcT9KTvN6X6JeEEktDFibSoSJklxQ/0ApiQt3K21GUz0TvYYKMSiregTbWuHat3BOIW6hHMIcBbqkjcYyc6oGYAMVHG2F3xWoxGWsKHqBnxCHZrArF8aKv6QZs2dRDO86CHIYk=
Received: from TY6P286CA0015.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b9::12)
 by OS9PR01MB14003.jpnprd01.prod.outlook.com (2603:1096:604:361::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 17:28:43 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9:cafe::4a) by TY6P286CA0015.outlook.office365.com
 (2603:1096:405:3b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Thu, 29
 Oct 2026 17:28:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Thu, 29 Oct 2026 17:28:43 +0000
Received: from vm01.adwin.renesas.com (unknown [10.226.93.3])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0AD923000E97;
	Fri, 30 Oct 2026 02:28:39 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH v2] PCI: rzg3s-host: Fix NVMe resume errors after s2idle
Date: Thu, 29 Oct 2026 17:28:30 +0000
Message-ID: <20261029172831.9409-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|OS9PR01MB14003:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d0b7543-fcf2-4acc-3341-08df35e21480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|18002099003|13003099007|56012099006|261028144727099003|11063799006|5023799004|261022075727099003|261022105027099003|261021121427099003|10067099003|261009223027099003|261009221227099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	eXO9uA8EvnRAiHUzJ5L7xo6JaGFFyp8KdXqwpJcuXNrhf708dwswExIVdtrC8c5vyZtsv8QsZ5yWOkguPlBv9SC1R84sQ5TRUg3IsbnBzEKxrhNSFFd39HiTNTR9aEr5E8vO5Z2TxKct1Uwvd/VNBq0tUhevB5xJaN3LFGbFuEk5d+Z7mRblm80E+jNgleandHHTK7i4yjnmk/tm4a99M29pzzqtj8fn84cIFPZCUTe1ot37pjTnsp7jB2/l6WNk05mPKrXXHcE+h/gj63KYyEkjpzoh3lFh4leul7b/f4HrQey2sWlkdSoqEMcT6mmcoAAgIIa1R6bwlZC3Qqy1rbnYLtvEl/CRXJruj0pweTray34o5iJcMIvaToL59Wv++ShU996SueghVmu2lq7ObGtH/6uf6tXn5NCCoOG9hP4QGkVoSEKQpbJjnBYH2ym9ztRrzoPhupxWKabPYLR5zOLnIY7FVpsOXVn6n+RPBt8loBTGTaJUIAQcs9xEn8cBQmZNTHI+7hX0188yRkv7Z5OZXobNEwv5iyGgc5Iqs0EKAHihRzTGIAgetJcWourZCz1WqhCzQ8JERXpCjYiGTo8SK/jPihZ7zJx1Es3xGArV3VIEESrMEl38zVG8tUjD9Y63mJoctFRTRjWdgFMC6w==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(13003099007)(56012099006)(261028144727099003)(11063799006)(5023799004)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(261009223027099003)(261009221227099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xuObVSYLksJJi/QiJrEUf/jbBY/vBT+Ye0h9Nj6WFZ65u119UZCPIVW67wWgF3jYfaFlynGIAuZHCuH21yKzPhlzGCO5EPMfjjxcI92Rw44FrcoUEmHzZCMWYIAvLRhFFEeDM32wufJC1BMSFs/KHMQMb4PcwLEbppjFoajlz7D+QlwChrJReHnSeuOcDvV4f1doQm+5P69lDnUc3ALWaFueeAbHmXWBTgTTUGN69D9mZjxs8YIse2LQJO0iPhUwl69FxhWlpqGBwxIIBCZmw6dcvnit6AdLMe7dsd2RIFuX2S7d8LTd+dELldhkCJ89V+7u0K1sMt3rhJm9t9tHvbdmvFbZJHzQXS0gsg7XCMTmPRq27meoCIIRTwuXFPAqZvWYQqy0Zd0ITTaxVfB83yFhJb8SMH8ofN9k1/sYWgn9GQjFzpxNJZG2/K98maO+
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 17:28:43.2217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0b7543-fcf2-4acc-3341-08df35e21480
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14003

On the Renesas RZ/V2H platform, when ASPM is enabled, resuming from s2idle
with an NVMe SSD connected fails with:

  nvme nvme0: I/O tag 27 (001b) opcode 0x9 (Admin Cmd) QID 0 timeout, reset controller
  nvme nvme0: Disabling device after reset failure: -19

This happens because during s2idle, when ASPM is enabled, nvme_suspend()
does not shut the drive down. It leaves it in D0, puts it in its lowest
NVMe power state, so that resume only has to restore the previous power
state instead of a full reinitialization. This assumes the drive keeps
its context over the suspend.

However, rzg3s_pcie_suspend_noirq() doesn't take this into account and
it always powers down the controller and asserts the controller resets,
including PERST#. That resets the drive, and the command the NVMe driver
sends on resume never completes.

To fix this, similar to the dwc driver, use
pci_host_common_d3cold_possible() to check if the controller should be
powered down and keep the controller running otherwise. To keep the
controller running, also call device_set_awake_path(), so that the PM
domain does not turn off the controller clocks.

Do this only for s2idle. In s2ram the SoC could be powered off, and
neither the PM domain nor the driver would restore the controller
clocks and resets on resume. In hibernation, the controller must be
reinitialized on restore.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v2 changes:
- Replaced pm_suspend_via_firmware() check with a pm_suspend_target_state
check.
- Updated the commit message to mention why device_set_awake_path() is
needed.

Note: This fix depends on this series:
https://lore.kernel.org/all/20261019065025.2146539-1-claudiu.beznea@kernel.org/

 drivers/pci/controller/pcie-rzg3s-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index f6823c9bc414..996a51f2ba96 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -2450,6 +2450,14 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 static int rzg3s_pcie_suspend_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	bool pme_capable;
+
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
+	    !pci_host_common_d3cold_possible(bridge, &pme_capable)) {
+		device_set_awake_path(dev);
+		return 0;
+	}
 
 	return rzg3s_pcie_host_stop(host);
 }
-- 
2.34.1

