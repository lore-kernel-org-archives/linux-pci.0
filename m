Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A373E8C4B;
	Tue, 14 Apr 2026 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176196; cv=fail; b=pfwbLWDk6MqeOR60vO6rKAPzIrrjOdspv6ajmJ30KUpzlDxgXrRxCJ+8sK29h8DOry7PO4I1CSLueuAgPT38MCWD+pwzvzkw18esJseR59Qt6Ah+gwXqdS1HI5XGwtBCKDZUzBgU6IKElLqBmNrUtEE6OdMbEq5UECklJ/jZPwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176196; c=relaxed/simple;
	bh=24CtTktMCrTYnhJKM0CPxo89ofgYKr4aiWJjFoL6RkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFE565v+hhW8Ht1kp40TGI20ODcA/eXWxpCsRq4Tk6lWfYCfGP8m6dx3v9T3Q6zEvMb5dmE67VkBFUxrM+wGAWLETfT2lrLx4PDa5B7nIHhOqDI5apaq31bDhFvAZUpOHjkkAII9gjFlmFON2vCu4dbyt/ITtHlqEnbxMvY8oL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AFGZHpdl; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AFGZHpdl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgUHGYF8qN6gcRG3ulI3xRUepHbt4x8KQKRobTL/bEtivvD0UhlytCJFPvUsFJBzziP2iFN2LjgP0eMk0HlYN5qMSPw8BZ04NeXkac9VZtFrjShQQP6iutr0T8ulghhoCrjNZ7gSbKgkUy+WLU2H6QvK19RzL/z6AK4b86LI04MUclXlpYc/xxyE7J7SnyHTBFdyOCD8eaVq+aLRm18KtzZNjEfLD1SkQJlQ/UVOV0evcgpuDXcZWEq+t9NQW4wvJECYAn26pqUkmEG2sQSxUeKZc3E9Jbrr5c9s6bDdPkcbZismWh1V1nH8H2wgbb5y72T5VcsA7nlt6j6Jquclew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=iBwnFBLjmHQ+mo8+LWa6LKcfGREZj93tyj8JtHDQN3JaHPrbY6C79OI++U9mTxSeNQJc2UW/JU7U41fLOGY2z9W3vjWdwERT468dMWuTKbBk+j7KSC3vZ+QOrouz2JMz9FlkKM8HxByhgmCsVz9z3oLP8VHfbCmVcSFRKjH7Usz6F5XAXWkYhaJiRUPKXGpG4NJPsXWhbaGQ47IWbayMJCsBHcJtAt1RDNcxx9IXkKU0lz7fx2W5vXj8j4zPIN0lA4/vJgAAKV1UPqm5FJyeMDhokYp8BpnQvdYMgNAXDMnpDJibVcW9F2fF1cEc78K0qZjaIkj3vLdC3YXlhPlAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=AFGZHpdlGVMNlSnsqrc1SRA6Y/K3JNqJf/tfK9C9+Ubl0VLzxNXjq6Umc9zZazTt7bJZy/2Rmcj1SIjoflDVkS8PanB65qARjdZEfOHWo/bd2sd7mZH2YJsUFKxL2B3/mAtwAe6An6FwuuNBvYj7VYmingnS8WvRu1SVOrA4VMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2529.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:16:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:16:25 +0000
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
Subject: [PATCH v14 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
Date: Tue, 14 Apr 2026 23:15:11 +0900
Message-ID: <20260414141514.1341429-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2529:EE_
X-MS-Office365-Filtering-Correlation-Id: 2005e12d-93c3-4da2-38ce-08de9a3069c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iobLWUgKiN2k4CKxymf5vM9RdUBXB6RClTeLMD+oYdLHihSoEdHHg+8e6eX583xM4qBKLZUZidUGhE4aahu0ojtTiRFytN6Ys6E7tSqCDawVmXICdOdP9vyUXlvIBhECH09HQcQLcP+aQpdKrj3Jnl0XAVVTFgRdjiGshCkPLsiYef6POT+Qah7UKqRD0TVpf35LRvEF/Xp83PZjlzjscjMgNKRmgHuaI4Hgwg/iYZkDhr3moAB62kHq8NFK3NhN6GS6ofexTi1Xx/hH1SbBnBOZyGqBm/R25ogPeU/ZpWYfZk9k1XXcdfLhFLeXZMMrtfg15vVsahgbQvNl7uP9kFmcmxUoiZ8yHbgn3UUexvh4CCs7xBrq9mAwbwxwM8vx0S5kiF62tIeR3BNNq/L0SkpygqkqiNwmjhnZhKd6B7i11apAcoauMaWgyudfpmu0L+iqNNEai3N/F0XErF7lvzu21al1LcVaYd3qtk1R6laI20wNsRRsDmtnYKn6BhEjqRukGTkH4MrYNNpbHUbsbAvrXDaInY74/kx/9kcZul7ae5Ya9pQ4Vy1vtQcP9LqCcZq+Vl1NfvD+0Z/Mnl/HDamY3jOzmOITJbMDjQCASKgJR+ZN3gQUvjR92zmaic7KM1GjciAccr+U7/NeLH9KxolMNz8PaTx+e4A6x4M3kgHf0MyfZ/Fvdz5eB1b4G3AFMezchBYYyhQ83uu6N3MFylLtlEnF/vbeOXdipO0A1Q8zDR9MqhgKax5RqG70lMAM1K7yk7E40c3EseetMu46ag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yn0G7TPTOH55WqEXVlZNT3HtCk+x9EgmfPrihYPWFF7G0HokN9RFr7Nodye8?=
 =?us-ascii?Q?L56g6ArqNHaoM41zdHGYQ6I0L1BlNct84/SXz6GX4MgmX/4kJqS6lG0EZn66?=
 =?us-ascii?Q?se8DuJZMYDMzoHAOurnBHo4SU1CsV3zUpegjJZTb2C+i7Gnd1XW684EpSyL8?=
 =?us-ascii?Q?/UrCemI2rfu0YqirFiPbt+y+vc3ziuQYFSCUjXOrkOLhr9avUTdNJ3DareLX?=
 =?us-ascii?Q?oZZEs71BrR90YXwMFUjhx0iFBAoKxrFy0+cGEwyct+sjWXE4UG7K1F6+wv3e?=
 =?us-ascii?Q?j2JqhKNaLqe2x0DZeNHSVSA+SuksClz2bOGySA64nBQUJMWMlZPwb+zohyz3?=
 =?us-ascii?Q?ElQKzrZSSYvspBqrT3kMa1Z0auGJztT15dKOpKrqMcdx78NHuDInxO6pX02R?=
 =?us-ascii?Q?5TCtVNUN6ua4l2h7lD2sFP1GsHZk9S2UEeesfnunt8aN0MsVMHqpY5EcT0tF?=
 =?us-ascii?Q?deO0zq57uh0Xp+3jYT0uoWEmMax2gLe8C77KOsFJWjpwQ4fvDUu9r/OK/Y93?=
 =?us-ascii?Q?xwW/dlcVRswq9IzSmyzvhdR9qbKmyc2a/8mSIz7ZFVFWKzwVvTEM5GqGGkLd?=
 =?us-ascii?Q?FZdl7cWic6nYN2ZjmQwCa4Ro9mFoBER/3zGCC1lfdYt1/Esg85zCZBStsUi0?=
 =?us-ascii?Q?yj6tbEMWQ6ACo1aQ3B2NnHWtuohCuf021wPFw/pmIDOHTPn4OCe/KshoVPnM?=
 =?us-ascii?Q?yet1vqKtF2aPYB39ZBwR02dU1qFTqiHpmmzPF9OLS3IyTD5MhFcyTcz3c+Lz?=
 =?us-ascii?Q?DdWl3SdslcrStBox6wUK2M5HPClUMJH+FCRAJJeJvc6dG1IzeSCED51afR8p?=
 =?us-ascii?Q?mDWFMKYJ/SCvVtSF3/npWrJAZj9Nkg0jDMWzItXaBg5cRkzVlvSbDtG5/Znj?=
 =?us-ascii?Q?oJ1tFzIiTbMSLpmINhAUcns0tOaWBuo2a0eWNoHrf40KKEFc5NfxdqJrxrMD?=
 =?us-ascii?Q?sW1bDtMTHLoArFKC9dtnJup14g1G5mfW8IJ58Fs+4Ecyk+gqIhfcdAGHvBdc?=
 =?us-ascii?Q?gpQvYcvOT1gpDudLsBigkpxsssw6VbXRoA/WrFTBHo9BxnrFzwd/JORGwSis?=
 =?us-ascii?Q?YFlPclVH0JlgdcdokLhT+Q6Pjejxn1G/zq84OVzOaoFjk0Qfa0GsHyNIf7E8?=
 =?us-ascii?Q?k+zHy/OZcFYfWoucO5M9XfOf7KWqUXihiQDOrsCGWEA5OpR/uB9FBly528Qu?=
 =?us-ascii?Q?+LX4k0Xx3EjhdpKezwfO8SebaBCvcbNu8ZUkO8ZnIDfM0GlvX6zMz/H0jekW?=
 =?us-ascii?Q?Y1Gu7+FnxB61z2/ZUfTmWRC+TI9D0PENFGap8M8Qjvn2T99EoyLZMpQGZ6tU?=
 =?us-ascii?Q?ZaVKEpYgZVJrZlWNG84RpRnXbJ5q+HnQZTCe7nTcYajg1c1KrYZvD23uJiFh?=
 =?us-ascii?Q?6Pkqait3VE3/NhJSOvYJ3+eicF4/9aI/J3dQ7sVGAQdCTXbgUsc8LMK/MnFc?=
 =?us-ascii?Q?GhuXWRCBC3WMIBiajrWqj5Vkw50y7nU2Lw+TMWFquoZ+DsC7tBbpdiFsTjNb?=
 =?us-ascii?Q?djgTCndYEb9lGUAUexpPzlc6dzkYzasxQyj9zD56iYDeCqIEYW197XsoS9zT?=
 =?us-ascii?Q?djMm7W78jn2PVZnbzQ+u1jTrXfful8u1FzjTjo2ap9/WBCBibnVR+ku/jyRe?=
 =?us-ascii?Q?I6W7CzA4AES8FhSyB8G2azGIZx3O2cd2Sedj7HSZVJkV9S5ofQcA2TO0YZrA?=
 =?us-ascii?Q?OlEAY0Vf6By9XoDjPzg+CEcL8FzE+9wV/PFP1PRa4WQjJrwu3AplTaq0R1Cp?=
 =?us-ascii?Q?U/CKfDu1d3n69XseydEHcZYSBNWx0AfwPBWnBAJ4jZxoYaLcIN16?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2005e12d-93c3-4da2-38ce-08de9a3069c4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:16:25.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAm6afpjMwkxr+UpZdzRGeZgp67LvFeGSUtLjkYxIOixHTi+yFqB5S6crBPBGmw4MtZo/GYg7d6aXVQnLGHPUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2529

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

