Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BB2EFDA1;
	Thu, 26 Feb 2026 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095344; cv=fail; b=aTg1EGlhNqnT6SMSwNJ+Om7+QTA7o3URBq4VTlDW5Pn+ySavIhykOAy1h9QOwBGMjv8GJwT7lJeVckym8RBtBZk9Rz3XBmpsHE2CzwOf/mCIKnV3ezWvT7ymT2fRqHz3kzWy15Y3xN9okYiR8xderWRzTEgSOac6GAMRUOO31zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095344; c=relaxed/simple;
	bh=yhR7cCOwgKgQ62mJhM5S21yzkkg6SlADMMswS9WTF4s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hi7S36gJIlzoK8VP19lNIOiCUrA8Ks7KauImUEBurTMCbk0KgGzBRDfQ1QkHQG+Z8yLuUpFEibTpThZKeMU37WpH3e8zgKk0CW8m3Pakipn1hGZdEqUQ/H+IookKNCudk/YxTY1c9GxkEdsvYniX/e72gg5s72EFfGzGcMSl3b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=smsJoV67; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="smsJoV67"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBN7n3tpcNW9pSdqDx3ZFMvCyMEgPBJeTgVC9RYGH9VjkZqoZTrKT03MQ7EAjCW5bSxdFtJj9gONroJoHRGZxi0RjwVGtPXeUqn9l8ADtR3aEfrMHCPVbIo+FmSZjdNn2Ynpt1Ms2ngLeOq01S8gwnqmiJMyNIY5t2Wu81wFUekoFdQskJmTSJ63Tlmhs8wrU8AG9pJuCbEjM4KnSOUnrTU5DjKnhYJzHjyBa3vBc+WdpOsWiug0jsz6iAHqBgbdzBjb8kBykqTCGi9sS7Qv7Yf525j4a1dPAkshwbCH6XQl3nzPwbtXlK0GJwgAjw7sEJ2bAqaZPPDVRwHauotAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWRyTGEQI965W7iehvi62FZ8o9pLsDx3CWy5Jh1Xl5o=;
 b=kN6DV7yRr91eBVklJRbi3mqqTrjfUS7gO5w0P2FQGnCl43R3nY9OHsGrPK0Hyjn+hCsd+F861hsEuqAthOGn1CPVBtM3jvr4tpouRS1SjnYbWteqzCB155euEYoRAV0IHW86dkm/ocaa5Cc/eaExTFr8pPMmJBsNKvTnL4K3/L63lq/4s4grZHYjUNGfvyCRds0RhbI+PZk3NUMqGLDhRZIm4nPEHystlR04ymzuKRmyKB3g4QVxEQ8AQDCZ29e6nknQXbQP2TN09XZGpO5lCvvb4+fcH6vq52zz8FFlLvcPfEKMJSpheyzC+qlk0ltRvRomeq8WTRYv2JQTCqqzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWRyTGEQI965W7iehvi62FZ8o9pLsDx3CWy5Jh1Xl5o=;
 b=smsJoV67wjYchnyIht/djdoDmRL4gKvctkCMU7stVPfdIxYoyxQynIaUgFksHe72D7O49UK+hj0Tmb+8wbBMhDbFheRhaRZ6j2LfkbjerSa8wZjf70pJCD5iB5eT1ygIdveQ3lfbKa/xpNXh4v0qw2+Yx31FIlNtiZMlP2WvCks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5288.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 08:42:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:42:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	kwilczynski@kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ye Bin <yebin10@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] PCI: endpoint: pci-epf-*ntb: Harden vNTB resource management
Date: Thu, 26 Feb 2026 17:41:37 +0900
Message-ID: <20260226084142.2226875-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0184.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c87f6dc-68c3-4114-157e-08de7512f038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	1+krfijYigil8umqlyNy4wqK6KKC4ZCzhPIu1nLdXU1UnP+w5MKgD+o8ocHuGyimBULiP/DZ9hFy8bYtWUhvzzJoNmQBvq623OZ00mPp8JrE8WwIhYTJVtNCw2iat7+RrLNZt8q5GyYdGLDbjUjVQMvOxP86+z03SSrPhIwHvK6kI1Qfm2bpOUHM9PiOyuFda4nDRyX7xxDPEqrsC5gta1mvrYYkYOraEgq1kP9jMqc5ATAYKxUQrY1GJfE0+f1/F2AIZ20DfKVXKO5O4V9MstMkmFM/2VVQPC5Qbq2jG/eYYOYSswfMUb6rPr1oGri2YZMQfPjJ7Y1lNxbT9CGjVrVh6nBbVvQsj8DNmJ3eRdzkPVNkwOWuD2u+9iIHUx8TupS/pc5zB5hVQKSDlUlxDxARMbh6vSRtJfQIMdxIng3LodY/jKOcsPkUAxFM7C/kPDBXfDTOTIkMFr09L0uhVB9juDTwEgrSHVLc0ubLZ63uuE52PLFf3O3aeowZbPBEICSt7UB3lhZtAGO0nVBkqeyhKyMRgTmVL9sSrdttNfBhiAhiLWwOwrJAq9nYdgyRo/9sXD2CfVWT1gr09gx9ZlaEGrpuNcKweE508axS2ZdMqVLm4tSgm2BHtqxsWtNvCrFEW1RUaKlhWTd6cH9McLvvD3qHAQ5G1/SizpUnr6pjqDZkYhvWU8rHAbxUqe+HoiK59RIB2nDSK6Faujq/Yd8vGcg7myxlbf0fNzR4Cp3Vizo1RtqEN/C51r/SuwGwA/SwV0WBoWXBdzFu0/ShVw+WgYaaf2l0/98dZLutYvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0OrCOSMQ1n1g9RIWSm6IQ14od4Mrm+l8cnGrrJ1tIDudnaZabv7ToMPTNRje?=
 =?us-ascii?Q?jKHG0lVTznXccSIaU9tKkQuMdkv9XVri10dP/yMqfnk/Nh/CT0EwrA3CzpT5?=
 =?us-ascii?Q?bQM9BPAjkotyvTCEDAfVSgAqF0cZZsHccPgeerRbZtSuvfd7/pyQmigQPVDq?=
 =?us-ascii?Q?iTpXKQsYAX4ODadu9ARI3gJsi5QIV/GuAfyy5AsQStG1Nl67VgJFPLGojShz?=
 =?us-ascii?Q?3w+i0bSJjgM+w/p1gvgH23ufFAUWdx57CU9vCUOb7Kaa5jB/hZGDjdhp2wTI?=
 =?us-ascii?Q?HQnx4AfSZuTb11C71s2Xdq9miBajoWMsBhFMgHP/jxHyA03Lxr3sJcz7JYKG?=
 =?us-ascii?Q?HoW0E80SxG46r1Y5KgRqhpxnZ6pAmHOlILlWN2vLd5byDK9/wYp/55Cf4mOd?=
 =?us-ascii?Q?bjZUXfMV8u6qEya/uvE/D32L1/4DJcrFtRkW+taXbQKvS9IJ1A5tjIpB0S92?=
 =?us-ascii?Q?/nZKpQw97YDTgTKwEmkvDVEgzorUsFjn2M/DtuJTDpCJqo3A1DzwXOX2AtCt?=
 =?us-ascii?Q?mAzx/xA2jDck/3yMhOCD7wMCVSFKbLsZ8vYc+MCG8B3oDfzMTnCGUQ8SmiEt?=
 =?us-ascii?Q?ERJKKIm7b3kYeqHgSWk/a2rFNEmQNTdACXidWefeRKlZK3yxnvZO0PwUPa55?=
 =?us-ascii?Q?PfWkp2xk/nUE8IX83vaq6WRxu3b+bTx41OXN9EhqmoqI18afGeTLxyHyc9M7?=
 =?us-ascii?Q?bCIT0kLPfIPvkigAYarnZc8KKqfJ1kqZbsqE0Vuyq2vrIx/qS7S2kwlfSr3N?=
 =?us-ascii?Q?kloCBc8XKBbkaLB+/4emBLl+iFbdqXsARiGnPxFF+lp2th7K3S3u/I/SJNLA?=
 =?us-ascii?Q?8wHnpy+OI5i2IkSr4tINYiWtui/iHGI7khnCr8s3aDSa8fU97EVnQmuNJVFg?=
 =?us-ascii?Q?TEYJElgEitJuYQ/p+c9l22vwTnGyZOUT6+YkUlc5PTl14LSwTnpuWH0rROcJ?=
 =?us-ascii?Q?EuX3ESH+XvHtUUQqf0cx2Rb16kq8cMhOmr57feagQk7M3PXT1f8FXchaNz1p?=
 =?us-ascii?Q?/7xvpjdjNEHn7boJfF0uSKarN/DS+vvrjfqhhp3CfziFMmmVhUhAg+vy8Nu5?=
 =?us-ascii?Q?/3cdmP8Czwa+Hf4WXGjE3MPkK85j0zKxiGfrBwuiTZ6kVroR11Noth/CkPeX?=
 =?us-ascii?Q?qp/QMj3nD8h1VbmW2pbsvL1TXxZN1Y4uV1zvvTvAZsWK1nLsoyFExvT04Lr4?=
 =?us-ascii?Q?NoRnc+KJgOzVWb05YuWQ5wCABhQD3HCnWZ+GI+pujrX1XojNJFTc5retO2VT?=
 =?us-ascii?Q?ouY/jB/glinHUEhH6V1pSD90jQcu7YRmLBhRMq34bTnp9ISbtK5ZGvWPIyUo?=
 =?us-ascii?Q?kem23BxiHEjk1+6CmpGEOonQbqI4/pbvxzYislLt+MsLJqkHfjXmOhy7A6NR?=
 =?us-ascii?Q?YGYG/73XpD8QeRI1VWyYVTRQQ8a6Z2Gfgvp+lUzWMsSIYC8SchLjxLt2kqXI?=
 =?us-ascii?Q?DmEeN/62QTLmy7tqBWjDu0TBjM6Nq9lXPL2Fn+f3wXcB8TbFKTBTzdoRoOBs?=
 =?us-ascii?Q?w1HSRZaOLtKdVsPeW4xAJWyMIbPwdJG0XBZA7/9wSrb6TiaguNCXdvPxws8q?=
 =?us-ascii?Q?GwtZlkpSOaNuhl8HXeafKJQxqEm35mOLJSvFl2pgd5W++ZiVi6xNaeSUNoPj?=
 =?us-ascii?Q?Dpfkpy48oYYSFYuZlga7WU+R9HToizyNwrp9BQHRZO7O4+GyqoL9PlqVmtQ2?=
 =?us-ascii?Q?s+JTFk9oDpm80pl35jTAdN1aa15guLA+u4S1rbhjFDnoVdWyolJ5ej3Yl0qb?=
 =?us-ascii?Q?4zOTPq2fQLlwZXfnMFfB7usJQXu/r6LRdmQu6R2vc0wW7hbfIiBL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c87f6dc-68c3-4114-157e-08de7512f038
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:42:13.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKIJJUPL547LY03vBHVfiA8uVoZ5QcTrd/4dO6jI5TKxjt+MMi7Ua/WfzEyeamUW8XnWRa7sSE6DplW09TAUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5288

The vNTB endpoint function (pci-epf-vntb) can be configured and
reconfigured through configfs (link/unlink functions, start/stop the
controller, update parameters). In practice, several pitfalls present:
duplicate EPC teardown that leads to oopses, a work item running after
resources were torn down, and inability to re-link/restart fundamentally
because ntb_dev was embedded and the vPCI bus teardown was incomplete.

This series addresses those issues and hardens resource management of
pci-epf-vntb:

- Remove duplicate EPC resource teardown in both pci-epf-vntb and
  pci-epf-ntb, avoiding crashes on .allow_link failures and during
  .drop_link.
- Stop the delayed cmd_handler work before clearing BARs/doorbells.
- Manage ntb_dev as a devm-managed allocation and implement .remove() in
  the vNTB PCI driver. Switch to pci_scan_root_bus().

With these changes, the controller can now be stopped, a function
unlinked, configfs settings updated, and the controller re-linked and
restarted without rebooting the endpoint, as long as the underlying
pci_epc_ops .stop() is non-destructive and .start() restores normal
operation.

Patches 1-3 carry Fixes tags and are candidates for stable.
Patch 4 is a preparatory one for Patch 5.
Patch 5 is a behavioral improvement that completes lifetime management for
relink/restart scenarios.

---
v4->v5 changes:
  - Rebased onto the latest pci/endpoint (2026-02-26).
  - Dropped [PATCH v4 1/7]; will be reposted separately via the NTB tree.
  - Dropped [PATCH v4 2/7], which has been applied in a different form.
  - Corrected the subject prefix of [PATCH v4 5/7]:
    s/NTB: epf: vntb:/PCI: endpoint: pci-epf-vntb:/.
  - Picked up a Reviewed-by tag to [PATCH v4 7/7].
  - Resolved a conflict in [PATCH v4 7/7] due to commit
    dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support").
v3->v4 changes:
  - Added Reviewed-by tag for [PATCH v3 6/6].
  - Corrected patch split by moving the blank-line cleanup,
    based on the feedback from Frank.
  (No code changes overall.)
v2->v3 changes:
  - Added Reviewed-by tag for [PATCH v2 4/6].
  - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
  (No code changes overall.)
v1->v2 changes:
  - Incorporated feedback from Frank.
  - Added Reviewed-by tags (except for patches #4 and #6).
  - Fixed a typo in patch #5 title.
  (No code changes overall.)

v4: https://lore.kernel.org/linux-pci/20251202072348.2752371-1-den@valinux.co.jp/
v3: https://lore.kernel.org/all/20251130151100.2591822-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/


Koichiro Den (5):
  PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
  PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
  PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in
    epf_ntb_epc_cleanup
  PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
    pci_scan_root_bus()
  PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
    teardown

 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 88 ++++++++++++-------
 2 files changed, 57 insertions(+), 87 deletions(-)

-- 
2.51.0

