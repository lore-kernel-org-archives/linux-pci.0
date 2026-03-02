Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83D383C73;
	Mon,  2 Mar 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435712; cv=fail; b=XXBf8juOA8PrSHNO8diT7d+1CSlBxJCA1lWyIVeQBdXZNLyFfLJrrbPiHu/jlMxXk5a/umGi7PXN9tk0x2qCH7Ouooopch0OdyUz3sPTw8gI3Sw0QW4OXi3K5APFKtdD9Ykb8V4dcVYTr99Xb4m7tyv19/c7/VPvS81OKbPCZI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435712; c=relaxed/simple;
	bh=24CtTktMCrTYnhJKM0CPxo89ofgYKr4aiWJjFoL6RkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LC+q3dsmYOZphWATLZcfBpeSYg5iyfS5Xfz6d+cuH6XziPuIpA/x78wxop+ovh5GiHbaMoaTQtwqrTyg9wecLAsVtFnQLNLUJMaetaP8LCLPm2XA8qe1G9pQavVE6u6qhFRU7wEk0dKuHMYjlQYGj0yG6sZ6SCcJOlc0dJ0SsGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ReABcD+S; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ReABcD+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHMmJiy2rVm3Cl3qVNkto9KtKTyyz2Ia82w+R/c+1WiF5NQmrPdoxANUqb9Gxvj8op0RbNnZYozgHgdlSH0U2vbFDFw25XEjvSVKi2PcB8yKYW/Ln/P956zMGqlB1TLc6fNNqeBKxOOdSRmFnmnZWJmFsurk58+gZPsVmLTSUaHcpDzG2PYtBICJyj+8XjQr1fc0WIRVZnDzxrTKrbAQBKP3hHkNKZhpdgpaApmKprtTUNkWhnWHsgK+kB2Tk96tqXuoCFKL2KBxFk/Xd2FplAFXoSvA7meqmUVGJ60LGKhR4H0Ad45cdn7K+s4EtStMa64zHpbcCyajUp4IMyR7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=JCniCVtxtg8XsMk/lZalHozhYw+LSYXzI/gsDRr2TphPaiCHr1Y8JC8lPoVkBcLqCpJ7i0MjjBy5Ai0cY5VyVamg6l1P2SF6wrLCvCiGS1iDGF8/mkZk4Hz8r4gb7VIKGNIySEVslE4CcOrZ5BIBaqSmSvgT+thSkr7RASBg72PRSL9nw3S58Y8F6jObxyOdbyzPML4ybiDmnmGa6r3sm+GI8R09sVAm83UmLLZaYQplnD1htzISwwVQl/t230tcLUbgKWCI4rrqG+dC32zrs3SCrjyAsQ1fNc7Tc+qcsUkB6J4hy2ffvQTKSDJd3tWQk8ynUjnTQzUJZBBYr4/YRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=ReABcD+STKWsBK3i3SqSXZZY/q98gwMBQn1q79NDYioWV6Na9eH2co2FbmJCoV5IlhFSWxmqk1gRre6U4eHNoDsIU1iG9NDCwMnoT/Z1WAUsaANo7+xRw3Ruvd+lQ8LOWBT2IRLBS5B+wLkFfVdo1r2OBVMT9go6aaySteLSrcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB4872.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 07:15:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:15:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v10 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
Date: Mon,  2 Mar 2026 16:14:24 +0900
Message-ID: <20260302071427.534158-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302071427.534158-1-den@valinux.co.jp>
References: <20260302071427.534158-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c56e4f3-172c-4d2a-4cf9-08de782b6db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	UAVbZ7EXjcWJZA575UQX1GYZpbXKzvJvvLNh/vj+dX1A8oFyVxmypqOAiZ51Zg/JgqknDKiSD1S1asbm1cpDoA7DmroMvmxcn9EeSXCWf/dYsiGAW8VLCLIds0CcF59Dvs5HaqI8o7f/pf9TciaAzl+siZgSUjl1Huovp4CNh+cN+DfkechWJT2lq+NtRlZLRe7G6qkURMsoYGrLLqOGpgxesbgmOyglVuLPJrgKZigcur2BfLUJYOE+OYN6dJvitSr3pvt2MLryJ4ZLJlruWho5gJg/SBrmSAXMArLCMG3sLGa9lgUCZAqwjlFFBdjaRJesNxSdmuNsxgzD9WMNo9iaz9Y9IbPiv+7ziXbLKWAoHqaqrK4+wirbgvhK9k8Vtxc2E6Y5aG/BhwxbRFMI9b2QpSXXuo+G+JH9eaMULnfuBy3NpmwmbOya4iZQlbUjYYHm9RDysEqLi5RPzU9uYkz1VDQtzlHOMky2H4WF3lW4KMg0XyfDLRWWTovPwQdmw+Eq6IQPlctfvD6bNUyQMP6nQ6EstAfO4Y/jgJjwcKjyHGYc9eGOemO1/MKlDQKgv/TfyrrIk7Cq2jgLwR6QTAdD+CdmvMJUKiYx9MQkuxQ6Nn/nH5TnyMcG2Uh054+ejb6r9AeU3eWhv5msTd3bEdEhAaBi16Rj8DHRmyoCr77lAH/YtUtuAaRXv0bCNduM3kPv48Lh/uj0PihSR5HtgeXQRFYj2Vo4ug5J9FUANeUpu+/HK6DrelAwGVLhGmX62QMmPBYGbXwuNdvcPB6xqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJALBbnvS1dLHszUMAtoZSYBP6DAswiiuAUD9wjSrD4/7RaXcpRVBib+DWpe?=
 =?us-ascii?Q?Sgf0VddfT50mCht2PsKCUb0YJjGLKcVNnPGBt5XDk0OmepDL4tRR9jy8X3Hc?=
 =?us-ascii?Q?y5cTGg1udIbH/X/+2t/Ri3AqHrNv0HZVA7OgDQyClCkkcIKhoZ70Yw9f/W0x?=
 =?us-ascii?Q?zPvmKQ/doJTOFA6J44deh0dqPxngpqrWus6zb3GTR9d4EK9IpI/OW3Fe0T9G?=
 =?us-ascii?Q?mwvCXJCuP90UmVcnKKgcJ7kPTgkA0RMDU3C7/h2AHWMWElqG7wLoggskCutP?=
 =?us-ascii?Q?5HCiM+c0G/8AK7Ax5UsYl2e4QxszR6GQ/ZY+bNE9bDAsctT7CsX2KKe2C8Ro?=
 =?us-ascii?Q?4mfbYlz1MeZwiR2rl5lAcq+5NVvmFRRKFDUTyML+tyADaZQaJ3du5E0ZnkP2?=
 =?us-ascii?Q?PziZGj8Y4zEgUFPXAOcISZfekUr2ZvKx5ZptD/jaCEj8kViCbdJ/8I/AkqK0?=
 =?us-ascii?Q?BPpuD7lR2VjW6e/Uc/MR78c/+cdOdPq9iamDT+SYggavy0HfjswmNuhgAq5h?=
 =?us-ascii?Q?hdr3Qwc+sLpRD/RC8AWpO5Rq3AtY190bBnUp2bfqqrVNOyeRe/pemphvjx5e?=
 =?us-ascii?Q?SNndYHi8tLPXDwznAggQl1Eq8YSWZAxyMqGVwYDTdHEP869mHQY9NlQlxScQ?=
 =?us-ascii?Q?JKxojRDh3dz/vpkZHntDT417BNnLiIVjt7/vEEW8imyLKmL0GVshV0Znzwz1?=
 =?us-ascii?Q?gIwjfCw0ogOj3q8lF4LV7xVKxyl7b3mPwdQ/ZOj+B3jzY1CxtfBMVz+4qmC9?=
 =?us-ascii?Q?ITayIm91hOu0JpVRf5tfAVjXbVaBEV18xRITd8iwVNIVbmbQrEdCDjNIC7TI?=
 =?us-ascii?Q?xffu63KiAJAQ0uMnvkKExhR/mLNU9VFFg8vFV9exjCUrBv1BMLzBlbFdT87c?=
 =?us-ascii?Q?5lDbda0QA3uOKTsSFL3gPqaZBtcCb/rdvA2JEJrW/b44DiOUnIoEro1DlNGo?=
 =?us-ascii?Q?r7TqLTe0XQlPwUE9SMA1TkFrlv+qpxg6e9gvNElDgHS/X7VbsgQJf30DLEsq?=
 =?us-ascii?Q?ZVLWWw574Jnj+/hXKV+1lDquBTpstshQ0sND53H7ThR0YPYQVQbytPnxedfH?=
 =?us-ascii?Q?CW+RAgxegkp5O165N5z9aaxLK3z9GMqFOu5nD0tMKakx7+l7/JWJSpVBddlq?=
 =?us-ascii?Q?KdotUPy2FHit25H8wa4XXMM/0tb9UWqbaTFtI18FRStj+vWOSc91d8NJIGVr?=
 =?us-ascii?Q?6BnNGlfG9ZBBikCvkRB9mY2FqMj+QiIxaOUG54O0Tz+BH3yqzCDx6Yz2nn8R?=
 =?us-ascii?Q?XyFFKwsm4sSCnEG3xD7wKzj0Q/lzOABOoiPtXLpYO1mx4WE9Mam5V2/Smqc5?=
 =?us-ascii?Q?52PtBou3B63N6mmkoG7W+fIY32733Luf4q2x3aY4q9uO+5QoCpyMZdQuOoaJ?=
 =?us-ascii?Q?Mif7B8eCamD/Ish5YjH3s6hQ4eF4kjKglXn/Lisp5PunCnHVKbfNamGmWPKI?=
 =?us-ascii?Q?2ZSBmReaEOS1or0UksD9msIbdYnbNtS9RHdqbRLltdJQEtjjrQog1JFCs68B?=
 =?us-ascii?Q?dANcF6VydwikLy7hHWn6piFGGxKvTCmYwsuTalU2dHppkaOxhous2WSWkRYk?=
 =?us-ascii?Q?UymHrNYc58i6PEcqZqjiIOvHQXbD4j5CecgsO2LuuiYYEBbaOScCFPI2hBws?=
 =?us-ascii?Q?NynHj1iSYDK/Pm7VElLoolCcvXUZBZAnRt2UYgsp2/lb3L6PQ14jXGrcF14K?=
 =?us-ascii?Q?D0ZxCQJehpZYO/CePWK+YQ0cizZb9H6I46ME5J9sVj9XvKopVlunAjagdZXx?=
 =?us-ascii?Q?VVB5cHtNrDgIxGQE/F3SM0Jhbp9YiXpsjCTgFo8gJm6t4P9Mfz/X?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c56e4f3-172c-4d2a-4cf9-08de782b6db7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:15:05.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1U4tbi+l0Ru+OJT78Ohw1D5zcpNGAqpABoc5xhBvmEzwd4ogWLOX+OagI588e98MsdBFioD3tfxRetBG1afXtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4872

Prepare pci-ep-msi for non-MSI doorbell backends.

Factor MSI doorbell allocation into a helper and extend struct
pci_epf_doorbell_msg with:

  - irq_flags: required IRQ request flags (e.g. IRQF_SHARED for some
    backends)
  - type: doorbell backend type
  - bar/offset: pre-exposed doorbell target location, if any

Initialize these fields for the existing MSI-backed doorbell
implementation.

Also add PCI_EPF_DOORBELL_EMBEDDED type, which is to be implemented in a
follow-up patch.

No functional changes.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 54 ++++++++++++++++++++++---------
 include/linux/pci-epf.h           | 23 +++++++++++--
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 1395919571f8..85fe46103220 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -35,23 +36,13 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
-int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
 {
-	struct pci_epc *epc = epf->epc;
+	struct pci_epf_doorbell_msg *msg;
 	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
 	struct irq_domain *domain;
-	void *msg;
-	int ret;
-	int i;
-
-	/* TODO: Multi-EPF support */
-	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
-		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
-		return -EINVAL;
-	}
-
-	if (epf->db_msg)
-		return -EBUSY;
+	int ret, i;
 
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
@@ -74,6 +65,12 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!msg)
 		return -ENOMEM;
 
+	for (i = 0; i < num_db; i++)
+		msg[i] = (struct pci_epf_doorbell_msg) {
+			.type = PCI_EPF_DOORBELL_MSI,
+			.bar = NO_BAR,
+		};
+
 	epf->num_db = num_db;
 	epf->db_msg = msg;
 
@@ -90,13 +87,40 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	for (i = 0; i < num_db; i++)
 		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
 
+	return 0;
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	/* TODO: Multi-EPF support */
+	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
+		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
+		return -EINVAL;
+	}
+
+	if (epf->db_msg)
+		return -EBUSY;
+
+	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
+	if (!ret)
+		return 0;
+
+	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
 void pci_epf_free_doorbell(struct pci_epf *epf)
 {
-	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+	if (!epf->db_msg)
+		return;
+
+	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
+		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
 
 	kfree(epf->db_msg);
 	epf->db_msg = NULL;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 7737a7c03260..cd747447a1ea 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -152,14 +152,33 @@ struct pci_epf_bar {
 	struct pci_epf_bar_submap	*submap;
 };
 
+enum pci_epf_doorbell_type {
+	PCI_EPF_DOORBELL_MSI = 0,
+	PCI_EPF_DOORBELL_EMBEDDED,
+};
+
 /**
  * struct pci_epf_doorbell_msg - represents doorbell message
- * @msg: MSI message
- * @virq: IRQ number of this doorbell MSI message
+ * @msg: Doorbell address/data pair to be mapped into BAR space.
+ *       For MSI-backed doorbells this is the MSI message, while for
+ *       "embedded" doorbells this represents an MMIO write that asserts
+ *       an interrupt on the EP side.
+ * @virq: IRQ number of this doorbell message
+ * @irq_flags: Required flags for request_irq()/request_threaded_irq().
+ *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
+ * @type: Doorbell type.
+ * @bar: BAR number where the doorbell target is already exposed to the RC
+ *       (NO_BAR if not)
+ * @offset: offset within @bar for the doorbell target (valid iff
+ *          @bar != NO_BAR)
  */
 struct pci_epf_doorbell_msg {
 	struct msi_msg msg;
 	int virq;
+	unsigned long irq_flags;
+	enum pci_epf_doorbell_type type;
+	enum pci_barno bar;
+	resource_size_t offset;
 };
 
 /**
-- 
2.51.0

