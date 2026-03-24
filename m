Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020122.outbound.protection.outlook.com [52.101.228.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B23D567F;
	Tue, 24 Mar 2026 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341524; cv=fail; b=KPeb9du/X8mnHMxDJSnwodQ+f064HXInEvx4n6F+U0VS3ZTUHyfR39Qh++IZPdRTZL5a5tqAlMgqUs9fuQvDVoXVUog5fucHYjJj85Wk7sAZGdEAdLuMQTitPRGd2XbP9dTGxz7B6IyJOOdsvM59X7eDIm0ziiRH0nJxm4qYIuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341524; c=relaxed/simple;
	bh=24CtTktMCrTYnhJKM0CPxo89ofgYKr4aiWJjFoL6RkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uToqt9VoXs3Hp0goJHc4283QnK2J4DwJExsxrf1t42iJb5zf0AwQpB2rsGwd2cuMAv+IcstQi9ot4Bb6Y2/SNRyRrVlpSURIKx+Cmq7UIr9rGmklxjSqBWPcCHn70HR+Osat+qTquyoTQ4QuqHJlv7fz72VSloJGI4hzdPqCCwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HyDJ4zQM; arc=fail smtp.client-ip=52.101.228.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HyDJ4zQM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjbLWvK3lUG3wlXWEzeBCufEi0Q/WyTdy4FqX8/3gNIiYw+BkLIua5LScNYTPyi1YsSSDzYJjMIaoB/N5JcLKYeIDAB57xeMjKcXpmo7JuQF748Gg+qqpaamJbiMkUclMXs/9V24vOdU5aa2hqLstrJeGhRZlAQcRiSxIOxMnDvhXLUK5PRzSrLFq7Y0lYlynORTQeU3aemB9/auqXMjbv8OQ1C/fUSQnf0rbi4W9BNl4v5tUGESE4XapIGOR40kcvitkEelJj4XATUnbaLN5cdTayhd/qoqm8YYjd78zwSAPI3xxio0MlHbtFhnLEGOYGe52qoM1gVEOzcXFsCnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=WUSNUrd/pp9j5MugoNWHvN9kM527bAP/4tSjozT+A88L33qCG6QbAUvTb8TmQz9BBXHU/zjkJ7UOOTotLjGD9UH55fNeXs5iBzA800aN+yI/6ltKgSzSxFB72ORXhjcGBpfZlqPNkos4dNzu1JgUj3sC3I496LJ+LeENgsfwGh/yreLBWlZH/zi6KcyLHwLvFYTu0FJM4zHissU+FAu/Zi31ohiLC38UY1IU3tGnvkKxHSvzygr/MTpS8qvg6Ze2Bk7B2YoETZUxxr6ZpCZHXsCKFc+PFWV08ozQ+ZyCvyCoQhn5XRsXPT2hB8kqp5ra0ZsRewIZp8de9FrU6y33Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=HyDJ4zQMy/keGG9tH8jfyerBdSUCvfABOPBf+iothQj6GBHGN0IZROSvxCZgqJdTHNQSn/lphuCz8X4olM2Thn/les5LHD9gqoYCVcitoCdjRfPCp7Bd8JnAMtwUPzpqWwVlu92/aaW3POuVQ9h0re/0n2YGA+Ie4EMawIPYCEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6981.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:38:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:38:19 +0000
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
Subject: [PATCH v11 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
Date: Tue, 24 Mar 2026 17:37:25 +0900
Message-ID: <20260324083728.3744734-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324083728.3744734-1-den@valinux.co.jp>
References: <20260324083728.3744734-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4495a882-361b-4451-ea29-08de8980b3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ovDUwmdYb0cyIsVkqvPUcgQoNwFKFykaAbWbZcIUBurUAeQM4qXZV6IYHsJfCGrUFRV6sTVaM2qwIIa6WpxJgLixOpHUc57Zme2bwCkuJG+oouvDzA+7q8yofdAMWCzn6lRkvdt3F2QWFGDTGFeKtebJFJBJ/CXX0+6aeyCR8277wJQuFBn4f3BzimvQNAnLpXW0UsBYl+lvlupBHjFlck/rnbGYjdPCN6rDPaOAAz5yqO3HsaXl8lHD+6mvmtxRYG9xN9O/Z6HuOC40XITLnkmUEhlCPVty5YljaAHMLNMtQus34tHf91K7dMXkNb6QbmfinVHIOH+IYmMZmp9vD8T4rjjPyMueKo2nP/G7TuiRwgW85eSPJ345oRlYkeE7pzw/p5j/zkTKK73XV7oofIEVIOfPrJcdeEoWoQ3WY4F5OI7gqY/NFIjF54dNo1WHbyXz2T0uI6KP8e9aQWgohdnYdE6zFHmwq09fwhQy1zb22nakZYlz60Fm1x+IMOLkswWVyA9Jf+jvt5nuzzMkpoIh5ryLweVJv0eAIOMmox1KbZw56q5DiYJybDQZH+ZlLhkK8XQzgyOVM/0rprEd41JNA+jwGw0gxhrz9RRPN6UFGppJVqsPk99dmT7vAbsm7wjRIyG0x5RT9rAqoEb8+JLXwI613X2a5uL4hRQDewGBS5/RiXQliI3YSOeoFWAPPPUZFQrpaiz1NCLWGzDN6hsJMpwAqwE4K0HwSNRU2kJe3tjfmk5Qc8nAbw6e3X4dEO8cLkHZNKCgW4PHQLZajw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3DP5x61lC8t96O1ijl9tm6mdevbOYENOd46HNCfPOSpuXdpGtYyV0WZPTPCQ?=
 =?us-ascii?Q?Sg9Mmmpx5MN868p8wfmKa09ZSya9zxjhrRovHdN85dcIwAgafY1phxtA45t/?=
 =?us-ascii?Q?LRtQqE1NNMWVxqGCyHpOlLjGLW/Kymf608MZGyP5e6qoNNc2UzH03UUmknIG?=
 =?us-ascii?Q?tTo9QiXvJ+x67hqrIpOoR3fSboUnIcPdOeiNq/uX2Nja7vxr6O/Ox0xxMjfu?=
 =?us-ascii?Q?iQ3U2Rf9SV1pMO7hcolqkOQVBPGb7Jjejw/xAbmeRkiNYBL0q/LutI33ZfSL?=
 =?us-ascii?Q?WkwPYhgBxtSLvDh2oqdMEYsX9IO92Sc+ivPS5r/xQ+Vik1NSu+9tHLuex7Q/?=
 =?us-ascii?Q?p3tNoTr3rLQ4DRUj32LAl492pInG9HnL6d+BgVdRZ4YJkEzSJiKepn47cC/e?=
 =?us-ascii?Q?rtksIHoOFEz0dgZNgjSq9QbNr4okwVOPK5JPQ0OFG6ZdA948RvjD2msUyjeN?=
 =?us-ascii?Q?LZ2HJ6/VNWNyhbNj818iJFrXwwRGwM30OMaMo9Q3E2vUShEF4NgrWAa8/B2G?=
 =?us-ascii?Q?ofUciqHjRUvQJLF9Ph2N9zPSBM+uFRZ4VRqZm6aaH4yATPqmuxMy/dA77Bmn?=
 =?us-ascii?Q?rvvMfycHy6rlE3/UNBv0O5YMd76NGXyvX0GWvnczDAARCe+LGxpJfbKSKZjH?=
 =?us-ascii?Q?X22gSN2b8bE3pbHn2JWNcxFwFzE2IdodjXsNUDaQVpNmleYfFQHKcwvl9Sj/?=
 =?us-ascii?Q?2y5YHNswtcf/Cax1VlywUypjpzjxIvuzczYN7DouPf4SNzI/ZkiXUegKALXW?=
 =?us-ascii?Q?qAp9SPoEPh75cKp3b4GgcvZFdq0/7Spe65B76jccr3XZzWttkG5t8m1BRyFv?=
 =?us-ascii?Q?/yk5wnJHF7+TEc/HTiePAUOhOZp7386YP+6YF4GwiTvSXCtvU5hhdV9AhKgT?=
 =?us-ascii?Q?7vb8pHWrNr5e1OhPNP1n07K9/dwNVysW33WY36mNfNzoq2QtY7FoldyMYbqu?=
 =?us-ascii?Q?7baUz58bW7+lt289KtBDJGU4yPlOA1ffX6vH4eMEwhEVvlkJWmdm7mx+4Fkl?=
 =?us-ascii?Q?d0QTl0ebYkRrFC8aCxLbOrDoAxpvZaPYIFu1tix9Nv9DaTf0fERKV0mguLdA?=
 =?us-ascii?Q?bwdP45ZdGjaSz7XN+oWJfnUFU2DGk2dyx0gmCSgxKW29HGFbpbFodZl/doEN?=
 =?us-ascii?Q?q81Acd64t/TlbfZc4ci0437l8o54Lc3xNK01Ljlxs96taK0MR45rJy/cQ6sy?=
 =?us-ascii?Q?gtE/7uv28HRtkSk6S/q1aGs8M5OohFMH8siabtA1Km0D/lNiYV5QTD2mhhah?=
 =?us-ascii?Q?zeH0hunB6U4JYN6EwWdBVWafK0MFzjVL7HuJxQRnI2hlTlgy1XSx6EASWGFN?=
 =?us-ascii?Q?76IZwZh1ZW2pk5ps0Uke92BviFxvzOzRnY7cknFfA1q5mjFJdguhjLGIIBDR?=
 =?us-ascii?Q?yfWo0hv4ZPARMd0S7xZZwZOBt0Ewq5TszVjF2ctLwkU/OsLRUMiD56GskBrd?=
 =?us-ascii?Q?cIb8SEdCuCr5Ov3Yr27cym7IhA0jnRopdFJygBmp1sUxxvauADyx/pwrDOuN?=
 =?us-ascii?Q?qlRgn5+8d06t+qJaFoziHrTlJex4ZOuzb6Sj2BftsyfRrmf3cGZYE3CgtJLc?=
 =?us-ascii?Q?/Hx9Z7RZpVx8EYE6aioc4k4hJlhXCIJyrpoMGUI7QYH7Q8EpKHNiryaK5LGH?=
 =?us-ascii?Q?wX5o1G/vxkERp0L7Q2NRazGCaD5uOhsI1ihTVFKLGKhLf7PSZWMEgunOnm2f?=
 =?us-ascii?Q?XqX8kq8Dwf3A7caZTs1Aurk4q/fh8sGlxVKm1ArCixVAOC/s8z86Af0mnRkm?=
 =?us-ascii?Q?R+VlLTVsNrdWvpz4/362B8ioXceJoUDVg5A1Ivhb4NMuLeWVi65d?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4495a882-361b-4451-ea29-08de8980b3a9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:38:19.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtLW07WpTcRAWZ/ciVLCD6l1gb5vQvhu0VDpBX1+0//H2Cs1CEMbK0zahiVhplKuy+9/RXSO0PVAFLKy5icfsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6981

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

