Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7D288C86;
	Mon,  2 Feb 2026 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014443; cv=fail; b=YEUc98rhs6YCot6B5R0KDFwrwofTWlvw0AzRzL+Ba+eyDYUJOO/l1Bq+yNGqw7R6Qb9Lv14SIK8j7gKhpjmvGGSYAX/Xk81kgDUfGx3BIL0+JIvJpuRpnILEFpShLiKWf8fy5CmVF2zTjPhvgOkEuFheemFbsX58MJwSBkp/ttY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014443; c=relaxed/simple;
	bh=lX7lUf2W89HWGXPSGxOnpQqGjuN15WWjzZeYaWAF8lk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eBDZJ+dopJdO3QzVulqM1H7Mu398s2FCKCFSMFhM2znOL1ZHkkY7Ron9bsTDtNEIwL6hpTESTM+2r7/wrUc7F/lW+LsBO3eGkQ6In6+F3/+Y3mTM6t2LoYyT8hNl3qc1ELlad1xIJxCVZUOOcPyZ7r4aUTfXfsgCEuNuXdsgxU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=EeRw7hLs; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="EeRw7hLs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Msoj4Htltj6CL097t7EVjsgR+j2iecomrVae2FzptSe5p7aOmSOax7VFli/L8vVCcpQVdbWdgFSE5Fxk05K2wotaGpN/4JI3BRM1csj81OVUzdGO6IT/1K4e/LySy1+PIS7Br31dKthXSaT4vM+BwtYf/mekXp+COfMgNPUmXP2s3aiR18UwWwsRwXb7vmYPx3txbWQmMaJNbzCXtnJ3etfIx73H54av5V0C+a5HAdkxyorC/64LlZbqGCpimVlg3MNJ3dewfKY+RPZQpTtqpBCX7QmjWhd+fmTS+webRxI+vEvxyubrZ7ffRKyqdquUwxP4if7iKTlBAMbk1EPjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itfPUBV6R9ZUVdmA3EgMcpE2PW2f+D3sztOy5hwKet4=;
 b=BlXFFkFnd790PW8DvsqKRtDx8BrAvIGgXH++8cSN19haRTyG7f2JJkC6/YM6qKAuviok1QF71bNK+z2JGaVXtlqIMj893EOepTKJbY/3skdGgzd6mUpwS5+nQySPDeyAF50uKloTnINgRltLtujn+YTzDf4kzmEKKNFl5eRgSphM+FWcHqEIyWEkArHumwLxVGltkxpcsKBGFB31WEtZQs0A1E4Kpz4e5dzxEffSy4fCMcGToiijwi8sObKbXnX0bgbLO8iMqvL/HuAyJTsrtGHyRgwvEYI6kl1cBU6jt+WMNgxXIIPpKlKwmQbUWvwXRotHbeqoL4LcuN9uozfvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itfPUBV6R9ZUVdmA3EgMcpE2PW2f+D3sztOy5hwKet4=;
 b=EeRw7hLsH32zIWrLHXB6cyQJpTHnsmTAubu+VGVx9lu0v2Dt08Wtl+rg7c/Yqd91+oLlU56hd//Unb4F4/JbN8A+NIAtBkfLyxrGz5kr1VjAlatoGDessxFPxDQNmKw7hmwlIqz0JE9nAYzitxX17cILT7x5yRJd7WzuLqtsPUJphQWh1OrnxWn4orOzWCoi+49WBVWIH0PxS2Sp0Atp+u4n3ake3Zc9jhuoVkNI7ITDyRBjw1HZzsClfaAiCGHpusn2PAMBYWKt1RvXc+jTZ7o+/Uj42A4WTCw5z5v+A5dUNvJ7FrN5yZw49fDqWfOTBEbvwhhzNlXSUS9wH6Sj6g==
Received: from DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) by VI0PR10MB9768.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:338::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:40:36 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::50) by DUZPR01CA0192.outlook.office365.com
 (2603:10a6:10:4b6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 06:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 06:40:36 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 2 Feb
 2026 07:40:35 +0100
Received: from HI7-C-0001H.de.bosch.com (10.34.220.0) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 2 Feb
 2026 07:40:34 +0100
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <rust-for-linux@vger.kernel.org>, <gary@garyguo.net>, <dakr@kernel.org>
CC: <dirk.behme@de.bosch.com>, <ojeda@kernel.org>,
	<linux-pci@vger.kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>
Subject: [PATCH] samples: rust: pci: Remove some additional `.as_ref()` for `dev_*` print
Date: Mon, 2 Feb 2026 07:40:01 +0100
Message-ID: <20260202064001.176787-1-dirk.behme@de.bosch.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|VI0PR10MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: 7650df8d-fe0f-4780-e6b8-08de6225f921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jEVqxWAn4sDyvswL3fSfvuIww7xyfcyMMY2nGrXXl8//DRAkv3c0R359YsMC?=
 =?us-ascii?Q?bTnHpDT0ZN4lTGJEwFtWdXEEEkPR9ZT1C+AK/BdUuoTyI9WzLBFhz4zy4Pog?=
 =?us-ascii?Q?Xu6j0RSQ/vrOwFlhSzYkvrKBD3MvrjetguYXE2Aq2pKQFZH13hzZzFIOTlw8?=
 =?us-ascii?Q?B3P3fw2gEfO6V2wbSGBwjL0KW9LqeVwSzCCthcr+C65OVEdDLimq/1wLGs/T?=
 =?us-ascii?Q?sZF/ApJpSOn22bRCukVmM+rXQAEFWMBsO5+35z7CTDXiVizIn5FYxJgZbokJ?=
 =?us-ascii?Q?sKXKGVpD4Zcx0hCGFVOneXTlDotp1MLPqVUAAVKFB4eEeSdDwafUjWqCwmOP?=
 =?us-ascii?Q?5//IsJ3dprcojXo3I3XkNHrIBP2bM2WQV9WN46PU4Bfztmks+OQYCVRW1swb?=
 =?us-ascii?Q?OCQC+BtwOx9Eltcod4HyGwbySdR3oFcWzpyUmzQNxB+Y37UWdd92X6YrWlqP?=
 =?us-ascii?Q?Er0lMxc71n6goJxLv0+oil/8YEgwG5lvxtmBWMzeqwaiPZ66DlPWzPtL+vj9?=
 =?us-ascii?Q?Tswk8l+oFvBwQuR6bIdwPdMoOnyKnaRdbSO72IgjjEsc/0wvmvC6XwIuwu+f?=
 =?us-ascii?Q?kcKTYfpmAXczUIg7houdLrPJWOIdBoBI34Hy6KY9XAbOE8ZeUOrpgvqFpT6n?=
 =?us-ascii?Q?mnP0nB8NUaKZaledUqUKAEnHuQVBoelLjFPkxV/E/Qm4Wx9C9bgSMA8AdErQ?=
 =?us-ascii?Q?Fc4JN8d+sJoczYMtlVtxNSG1rgxvce76ZiAnIWGAagwTEsm/a14+zPcnSREd?=
 =?us-ascii?Q?A3ID4qQnHimKkEwTqKT9t2kZ58ZeN1T7D6WmHaxtDg9/TCqmF+Sr0iX2lJuE?=
 =?us-ascii?Q?+kPZ6O8Ylv0ceZDI9eKsgRtR086Q5GGSIwTy8Ts62U8I3dz4+b9J/7+bULum?=
 =?us-ascii?Q?q5onwnLQ+//fp8CwKYWeZQmU+RgZRbxG1qhLAlj4sgkbfwzKtpnjxxokj6Lh?=
 =?us-ascii?Q?NWEG4ltDZ1YM6dKXh9cx+apI4hFeV3hKJdD2QBManb+SK95Zi9ntPMe+xXNc?=
 =?us-ascii?Q?uGLe3vNm0qQ7Nq61IBdVMoIvSIY4SuyVLGIS7z+dLqyg8I/Zj8zFaM7P2T4S?=
 =?us-ascii?Q?KMS2gdpRIrlrz/PGSts5q5bi3uMCiKZBoeUrsfgIJ4i1LiQRsjYlQmcCgu/n?=
 =?us-ascii?Q?uMgmCNzxeGW+5HQKl49BW449eK42YcaZewie4nOyO7OPfARztQRd0IY7qH4T?=
 =?us-ascii?Q?4wi0sBhgFonWPn7GxFKn3e08E8lAoS8vYB8cl8SmwCIAO3dh2Anr7cac9zAL?=
 =?us-ascii?Q?jkWh9xPpinsX9ny9JyjmV6AdT+wEm0wT743K9LO3m3YSwlK3MnQ3wjQsRuH6?=
 =?us-ascii?Q?K2TJ+SXmu3OkR02GRcXcDa7KgQmeuX7USfXKm2xgGW9+UiGKEIOUeIS67CSI?=
 =?us-ascii?Q?j//XP7L5g2TayYkcY2h5z3ISaC075G2N77gtA+jDockOUrH3vlbkz7XWXs9y?=
 =?us-ascii?Q?7Gd5cNkgGSwWiLuCfo97RGPQuskx+PuoHl9JnlsHkcT1jWDTsRhCaykjrpQI?=
 =?us-ascii?Q?cyhvtHqw82aQQAcOz+OSn3YNalqW+ceDFfrsw1hpLLWaJM29GFzBLuW30X9E?=
 =?us-ascii?Q?cb6OezobXaDc/dN40lkUhgX3sz4gmb8EkYFy0x9dP8jXcn8LFSzTa1g8AzaC?=
 =?us-ascii?Q?IwDpUkzCfQvoGD2mBMSbZOel5qgXWTJGgq36FZb9DgZwRYEqBdtquV77lQ14?=
 =?us-ascii?Q?+DuUjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6AL8A90bJLqwy9GwELFkYku5PquYgHlE2KV2e8sTx4di6VqKHVv/dzqxZ8HBBWUPBSm9qnbI17euT9xLzmHvuZDO+L2pRQxd0BpjmA7JeMw7cytzCM//4RpAvSM7ezJMJgOqOvDkv4o/41H/DC8s4ReS2b6rv1wCzzgjmgrwnAI+yX7D6Zgz2jHdqXUZbRd5FtUHcON8QehmPgZVHne05E+aGf7mlYRwZ9YB9LrO4YcMBr/jqdv7iXujATSno6kI/TANoLxhMb11PfOTjAnrUWAbN/Vfgp7+AEvKQxLlO+bMJPPyoGtnEbmYnYkElI50M1fcdLDeerVEeRx74oTEYpCixtrDkoTJ1RZJgeADxUHIyPXWC1GTxy8qoU7fgUhv0TpbsJKQEGKz1sP1a63NgZe0jiwCCOnDoQUF5JY3PgSYVRY14cyfamFe+Fez88xX
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 06:40:36.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7650df8d-fe0f-4780-e6b8-08de6225f921
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9768

The commit 600de1c008b2 ("rust: pci: remove redundant `.as_ref()` for `dev_*`
print") removed `.as_ref()` for `dev_*` prints. Nearly at the same time
the commit e62e48adf76c ("sample: rust: pci: add tests for config space
routines") was merged. Which missed this removal, then.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---

This is based on next-20260130

I don't think its worth a `Fixes:` tag as both ways work and this is
an optimization / clean up only.

 samples/rust/rust_driver_pci.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 4dfb8a6a4707..d3d4a7931deb 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -73,19 +73,19 @@ fn config_space(pdev: &pci::Device<Bound>) {
         // TODO: use the register!() macro for defining PCI configuration space registers once it
         // has been move out of nova-core.
         dev_info!(
-            pdev.as_ref(),
+            pdev,
             "pci-testdev config space read8 rev ID: {:x}\n",
             config.read8(0x8)
         );
 
         dev_info!(
-            pdev.as_ref(),
+            pdev,
             "pci-testdev config space read16 vendor ID: {:x}\n",
             config.read16(0)
         );
 
         dev_info!(
-            pdev.as_ref(),
+            pdev,
             "pci-testdev config space read32 BAR 0: {:x}\n",
             config.read32(0x10)
         );
-- 
2.34.1

