Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5D25524C;
	Fri, 14 Aug 2026 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715168; cv=fail; b=bSV+RRzbMyOcTrrnGgj4z5LqZRK151HuWyOSe7qX9bRma+7vFkpkgMyEIP+2UkTaJAQRG8rT0JAT6ATcaUWZJefDv8D5zJ0jjh7nhUJaCu2doGUczp2A4EgWN+gWwKYH28jyPI53t1pZal/iFsOLqe3bW0gUoIp0dcP8SxVer2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715168; c=relaxed/simple;
	bh=UBfwQPQM2vDYdr+dQg3M5/SZi+I3K5j9Twepk5FkVFg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UUgUqda0FXdXiqigizpE1z3dXecqaCF8ue26riT0yj2yT0NZwngMckutza6hkcvWtP1hP7LIMoXNJ/JuriQGbjZ7BW3N10W+LAzSsr9OOG0ab3Bw/RuPuDheM2T/hTAXMQVGFNRuo+0d4905xW/LW/PadHVKBdR/AmJ33DreDCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KOaHMbyP; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KOaHMbyP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYlgRg9N/5WYh7k0rEm8jSWjkB5fQkNXQ3CTPBQ+Rn8xEyjbvIAlnC+6vUVsssz1X/V0BtzdXlLDKUju4dxftDpNaXBQ7G+BjEfqfT85bIygtySC5qkrDV/WSi+E1xwjMfX9DonatMTuSW186gI+g+uqzrf6o8cpbURyQleO7j1Xx2ui800BZkShz/1ZKYX79siUd0IBlLUfhXaFIegnyKkFNqvjlJTL2MpGnKa/qUsPgn35F/6sZ+bbNvH49Jq25lqQj8wCFqURBXzm8Xs/76fkQhm/NI43rDlx21h3epe1r17j/zfzTRVrq5kABthdDiJ7AtGZHp21GmtiM0t/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtcSz3chhQdPZGpI7eiyfsNsWkDKe7s6BXi9QhA/EYQ=;
 b=JKd9WiJj+juVUmQRCkFPbzbiUc/wcDWRCAJFf42dmx2IndS+yNsh31zs+Pe64cTPi7g6jDq8m7S4j3aPEh6YlcMs6bi3GyG5bq0U0MF3jAj+CxTAe511yf5UcdC+teqymAwM3yot75crcs/oSjrdpgOS9M9sn3RC0QKmmlNRLur64ZMA04X9OSjKVHULTpUVHNtyh0a4EOtXF7osp/KGME3z+Js8YxyOqrzefkVAlUOojBJgxzPWIIX5hr0RfIDBJkUz1sqh/8jik3+uXPZ9Bah15BJzqYUbrRt7Jf8fAGCEWdxolfZ8tpTSNZue1k/gl75XCzt5e2DvX3kOvYWKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtcSz3chhQdPZGpI7eiyfsNsWkDKe7s6BXi9QhA/EYQ=;
 b=KOaHMbyPcftpNXc61Rm+bwb61B0wHMOb2lAfRxXdowLa/rtDwC3M4gfglUNVD5mluZJ+5K6vW4MQmWUhiXl3BCuydasE16Gb1AFthXfPwefJFkP4Emf99ueKfIbNVUpMxGHTxyJETvYmRjhvapQpDM/X9FT/5um9ZVCT0cJoFXasjk4WSMX1jyBop2I8EWYdQfT57sw9I4T+x3PAPrzuoU642ucZ6ZVKn4dxWc4fX27wQ3ToSbvihzQ+ibYyp69glNiSXKLiCpFOeAZe47V2EtTKgZSNndINNpbcbdi4NuxytiRhjagl3TxFy1EECYofMPuKuBwofOmksetlKHqCzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PPF002462CFE.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc4) by SA3PR12MB9177.namprd12.prod.outlook.com
 (2603:10b6:806:39d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 13:46:02 +0000
Received: from IA0PPF002462CFE.namprd12.prod.outlook.com
 ([fe80::ac1b:b687:4211:aaa1]) by IA0PPF002462CFE.namprd12.prod.outlook.com
 ([fe80::ac1b:b687:4211:aaa1%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 13:46:02 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: bhelgaas@google.com
Cc: mochs@nvidia.com,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pcie_bus_perf: Allow MRRS above MPS when completions are safe
Date: Fri, 14 Aug 2026 21:45:46 +0800
Message-ID: <20260814134547.23148-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU3P306CA0007.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::6) To BN7PPF0D2C72F0D.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF002462CFE:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf74720-3181-4f6b-2fb4-08defa0a60d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|6133799003|11063799006|5023799004|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	XQhBiG26kp6W5et+6cxJig3IJyCQB3iidAzE4dcRNzBNwm3+Tu5SAQFX5SmIjpcYRGLSsErx2i05K/0/GyUPk+VQHLi7ZnUNcR2b2WYaLTGtYzXxAzpkGOuYngIH276BQF8st0JormvtOmzF5PdD4j/ibdNm524PAiE28eRwB8FoST1YXqnVtne+UyzpxmUXNtkVAxQYQOB+Xq8qyhz+l874C6hpdfWBwR6hZr4tmxZgE/FbRDxzZFeY3QqJjxgCZ5Pgvz5aXX8sd+OKmTFhnQ9yP0KFzhA+xsGhJ7tFKGtkiJBgX1nc1jZBLMKOEXER4alc/5Z030VYAfCh3tBBjIan7gNjt4onHeVaHhwA977iu5MeWo55gxVk467Ma0VRbS8CQsPHuurX8eSUZjGPHfhKYmPsXbfcSzsGFc2OvMmIc/Nj+HdISGe5Z4u/Yb7Uf1OY52vWVcvD19WXLpB2JVUrYT3kIvi9L2h1Ox3+5zGxwtatpJJevr/y1vUtQLMeOmiiqOrYp9RfzElbTfoCSLNAzrg/Uijc717LQRlReMWxpcnNBwAIx6cPo9/qkWJFmZGzUnk7+n80zAnm8JsTSJVAcb0qRX3iLeJ3pdPk6tkIYaSIDLPwKKmcPxVcRsoiq2Rt3wFrL4WZBBv+TquQShk06V+CmiH5oTNVNEu91YE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF002462CFE.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(6133799003)(11063799006)(5023799004)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/VBWclMrw1+cvtLRajN2ALywrO5o5ktb7wVhGNfkJ44YaUBQiH+XzezPfTco?=
 =?us-ascii?Q?xSNtnAvekMZgCQjLoF8WXV8JJoJPin4dCIi/0AbVCPSDWnhrsYHRg0vBcWtf?=
 =?us-ascii?Q?nuQuCHww5J7iPH2YUBMC3cVDCigXK+1ay57Z0zFlbccZRgQZt/bXTpZb4fxb?=
 =?us-ascii?Q?az5fyl/9CUPdtyeOfJSbqBKg9FesNgCyJ+xmMMBA9Dft0YyZioG9DBadQ5W2?=
 =?us-ascii?Q?+cJOKyDTcgFY5GQ3j3MK3CnOGAqKTHp1WzH3L82vCUf9+EFkOetZK0Rgl1qy?=
 =?us-ascii?Q?8OqWCJpQSwrpt4NDY7Ty+CknJfK98pOsKaqXuXF1QMEOFjZpkhwn6xvq906E?=
 =?us-ascii?Q?Ei6tcNZWpUJZ5K8NwP0ZqsWKHac7HeBTQN5+ABDfG2RsScrD8Om++wVSpL2T?=
 =?us-ascii?Q?sd40Q/nfFnGx8dVq8qUAzwZq71UNu/MMdW9fZQ5dVPS35peGBjsKJNaMubgO?=
 =?us-ascii?Q?kGzdNnp4cugsDYAubUFKSa07NqILsK1BV68GKksSCl5yTV3NVGlw7edx5uOD?=
 =?us-ascii?Q?Jr8nCmX1aJ010I5V/QOKDBWnVdII+b8D5QrPI8eCNNJHH0pUSR7s2V6jAJ4c?=
 =?us-ascii?Q?HJ8JDZwzNnHB6OIugYU5nEH1KrgulZKxKjXBFiRNMR+JqQftkx8WaGp8dEQM?=
 =?us-ascii?Q?peClN+1aKrZ77rSSwmyrjNGNpx0MrLzCs/4yRGA0OqGXeLEasXjHbH6sfief?=
 =?us-ascii?Q?SxWeHPdZ5qomKztWVtlmlu/CNwo/Wer5I7nCoILvBR1HEyVZBd+wk5oy43P8?=
 =?us-ascii?Q?6HU2GQNP3ZbgEWPuqh5D1MoobKI2bbSv0/AEmvR+LQTG4KZX+TX1vUbkweZ4?=
 =?us-ascii?Q?FypkAPps19OtEZtVDt2UR2GwsUko63DhgeXuYSOqoL1QphZu3/euLw818eDm?=
 =?us-ascii?Q?q5p0422/aK050RAESQiCol6ITfj9pMwtEHKz8JUXISp7RGxY1o9KhRtYu0YP?=
 =?us-ascii?Q?gu9fPDaATUyoXcZeW01OQvyOjavdANxqrFlH1JsTW9SZurDeA+m2U0DHP9te?=
 =?us-ascii?Q?/N4j94oh44hnT/3OgO+u4oaBwK+MN/+ZIR3Eoo5QiGPmc6mvM2JL2UBFsXi+?=
 =?us-ascii?Q?On1CFKI5QK4mq2RCCRVWHgA/+hPJnpiyAC5LjRfOKHZZ3XoVqndngV8TcvTA?=
 =?us-ascii?Q?t0UGqs/g140qMGTKbX/ckmRTc4XNJbqqfdvZVTHGYZGr2PLsky82JXYjY1tE?=
 =?us-ascii?Q?7ZGKIJTDP+JehLMH2Uc68H8kk6JM6sNtffCL02+vI3hEt/LyxVHKd6ERBaRi?=
 =?us-ascii?Q?xbygzizVgMwFqXtya19mUTzMm+cTx1MtE+qZuTwfJzkw5LPxOcWqDrRQkuR0?=
 =?us-ascii?Q?Vzy1LH8pi92jzHCk8qFVrZdGmvPrjZA6YwSgy557/hEPgyIedAGy/+pxjNFA?=
 =?us-ascii?Q?1zufrMnBsdUHpKK5ZrSNzUr2wKUvLm22eN2S1f1St/pgX28qTO53RlJAbVPr?=
 =?us-ascii?Q?UUf4GL8Fh50SeKVa+8enQV8fh2mC3IRYn9D7AKFfsGW25yi72Hype8tzSyBC?=
 =?us-ascii?Q?D25xX6jC5F+8/XJ/RY9vqYGpKsJUwlBHGRFh+rqzeHAmO0ZbQNEK0wVNiP9I?=
 =?us-ascii?Q?qfnZ6PAZRntZ3dykOf4NyvQ4wPNO7RAJdyESPkMsQ7Mym+0OlJu4hE9MWG80?=
 =?us-ascii?Q?OsHimwlWBKiuHcq98vuuHJD8DJ0FUUhlQZGhDB8pJqqxYBzsgaSswGF/00o4?=
 =?us-ascii?Q?faDjD0K5DhHLIDUg5IEBjvFlD7IQHvuL7hoTNfr4ONZSk0sxcWGMnvLhQfoE?=
 =?us-ascii?Q?6GY/zIK1+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf74720-3181-4f6b-2fb4-08defa0a60d1
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF0D2C72F0D.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:46:02.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJHuVfucm+FKVI/11ZSDSbzcTNdAv+Fixbfjte9aYgyuBYRRQ5veuQ+pgT0oeU8GU8CJFEFhHnBttXub99Vevw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177

In PCIE_BUS_PERFORMANCE mode, pcie_write_mrrs() sets MRRS equal to MPS
for all endpoints. This is overly conservative when completions from the
root complex cannot exceed what every receiver on the path can accept.

Completions are sized by the completer up to the root port's MPS. Cap
MRRS when an intermediate bridge or the requester itself has lower MPS
than the root port (e.g. root MPS=512, endpoint MPS=256). Otherwise set
MRRS from pcie_mpss (clamped to 4096), which raises MRRS above MPS on
paths such as Grace where root MPS is 256 and the endpoint MPSS is
larger.

Comparing only ancestor bridge MPS to the endpoint's MPS is not enough:
under top-down MPS configuration every ancestor already has MPS >= the
endpoint, so that check never triggers. Also keep the pcie_set_readrq()
clamp topology-aware; dropping it unconditionally would let drivers
request completions larger than the endpoint can receive on direct-attach
paths. Fail closed for non-PCIe or unidentifiable roots.

Update the pcie_bus_perf description in kernel-parameters.txt to match.

Tested-on: NVIDIA Grace GH200 (lego-cg1-qct-055) with pci=pcie_bus_perf
  ConnectX-7: MPS=256 MPSS=512  MRRS 256 -> 512
  SAS HBA:    MPS=256 MPSS=1024 MRRS 256 -> 1024
  Without pci=pcie_bus_perf: no change vs stock defaults

Link: https://lore.kernel.org/linux-pci/20180123174821.GF5317@bhelgaas-glaptop.roam.corp.google.com/T/
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +-
 drivers/pci/pci.c                             |  8 +-
 drivers/pci/pci.h                             |  1 +
 drivers/pci/probe.c                           | 87 +++++++++++++++++--
 4 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3d35270dddef..902bc631b98b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5150,9 +5150,12 @@ Kernel parameters
 				supported by all devices below the root complex.
 		pcie_bus_perf	Set device MPS to the largest allowable MPS
 				based on its parent bus. Also set MRRS (Max
-				Read Request Size) to the largest supported
-				value (no larger than the MPS that the device
-				or bus can support) for best performance.
+				Read Request Size) appropriately for best
+				performance: raise it above the device MPS when
+				completions from the root complex cannot exceed
+				what every bridge and the device on the path can
+				accept; otherwise keep MRRS capped to the
+				device MPS.
 		pcie_bus_peer2peer	Set every device's MPS to 128B, which
 				every device is guaranteed to support. This
 				configuration allows peer-to-peer DMA between
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..3e17594e181d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5845,14 +5845,14 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 		return -EINVAL;
 
 	/*
-	 * If using the "performance" PCIe config, we clamp the read rq
-	 * size to the max packet size to keep the host bridge from
-	 * generating requests larger than we can cope with.
+	 * If using the "performance" PCIe config, clamp the read rq size when
+	 * the path cannot safely accept root-sized completions (intermediate
+	 * bridge or this device has lower MPS than the root port).
 	 */
 	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
 		int mps = pcie_get_mps(dev);
 
-		if (mps < rq)
+		if (pcie_path_needs_mrrs_cap(dev) && mps < rq)
 			rq = mps;
 	}
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..48572fd5b62d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -118,6 +118,7 @@ extern struct mutex pci_rescan_remove_lock;
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
+bool pcie_path_needs_mrrs_cap(struct pci_dev *dev);
 
 /* Standard Capability finder */
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..7ab2bd66f3a5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2961,6 +2961,76 @@ static void pcie_write_mps(struct pci_dev *dev, int mps)
 		pci_err(dev, "Failed attempting to set the MPS\n");
 }
 
+/*
+ * Check whether MRRS must be capped to the device's MPS.
+ *
+ * In PCIE_BUS_PERFORMANCE mode, MPS is configured top-down. Completions are
+ * sized by the completer (root complex) up to the root port's MPS. Every
+ * receiver on the path -- each intermediate bridge and the requester itself --
+ * must accept that completion size, so MRRS must be capped whenever
+ * MPS(root port) exceeds MPS of any of those receivers.
+ *
+ * Comparing only ancestor bridge MPS to the endpoint's MPS is not enough:
+ * under top-down configuration every ancestor already has MPS >= the
+ * endpoint, so that check never triggers. Required checks are:
+ *   - intermediate bridge MPS < root port MPS, and
+ *   - requester MPS < root port MPS (needed by pcie_set_readrq() callers
+ *     that request values larger than MPS on direct-attach paths).
+ *
+ * When the path cannot be characterised (unknown root, non-PCIe bridge),
+ * fail closed and keep the cap.
+ *
+ * Note: this assumes no peer-to-peer DMA, which is the standing assumption for
+ * PCIE_BUS_PERFORMANCE mode.
+ */
+bool pcie_path_needs_mrrs_cap(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	int root_mps = -1;
+	int min_inter_mps = -1;
+
+	while (bus->parent) {
+		struct pci_dev *bridge = bus->self;
+
+		if (bridge) {
+			int mps;
+
+			if (!pci_is_pcie(bridge))
+				return true;	/* unknown; keep the cap */
+
+			mps = pcie_get_mps(bridge);
+
+			/*
+			 * The bridge directly above the root bus is treated as
+			 * the root port. Everything between the device and
+			 * that bridge must forward completion TLPs.
+			 */
+			if (bus->parent->parent) {
+				if (min_inter_mps < 0 || mps < min_inter_mps)
+					min_inter_mps = mps;
+			} else {
+				root_mps = mps;
+			}
+		}
+		bus = bus->parent;
+	}
+
+	/* No identifiable root port MPS: keep the conservative cap. */
+	if (root_mps < 0)
+		return true;
+
+	if (min_inter_mps >= 0 && min_inter_mps < root_mps)
+		return true;
+
+	/*
+	 * Direct-attach and uniform-vs-root paths still need a cap when this
+	 * device's own MPS is below the root port's -- otherwise drivers
+	 * calling pcie_set_readrq() with a large value can request completions
+	 * larger than the requester can receive.
+	 */
+	return pcie_get_mps(dev) < root_mps;
+}
+
 static void pcie_write_mrrs(struct pci_dev *dev)
 {
 	int rc, mrrs;
@@ -2973,12 +3043,19 @@ static void pcie_write_mrrs(struct pci_dev *dev)
 		return;
 
 	/*
-	 * For max performance, the MRRS must be set to the largest supported
-	 * value.  However, it cannot be configured larger than the MPS the
-	 * device or the bus can support.  This should already be properly
-	 * configured by a prior call to pcie_write_mps().
+	 * Prefer a larger MRRS when completions from the root complex cannot
+	 * exceed what every receiver on the path (bridges and this device)
+	 * can accept. Otherwise cap to the device's MPS.
+	 *
+	 * There is no Max_Read_Request_Size capability field; pcie_mpss is
+	 * used as a conservative upper bound (clamped to the architectural
+	 * 4096B MRRS maximum). Hardware that rejects the value is handled by
+	 * the shrink loop below.
 	 */
-	mrrs = pcie_get_mps(dev);
+	if (pcie_path_needs_mrrs_cap(dev))
+		mrrs = pcie_get_mps(dev);
+	else
+		mrrs = min(128 << dev->pcie_mpss, 4096);
 
 	/*
 	 * MRRS is a R/W register.  Invalid values can be written, but a
-- 
2.50.1 (Apple Git-155)

