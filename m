Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C9374E47;
	Fri, 27 Mar 2026 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583678; cv=fail; b=KOmyLy2G+L39HeLwbZsnVXcvDfBgSbk9C3VQyG9QVVVv814U2laWKXnjx48Ijy1Wf6AzZfyCGbbfp9GbrNjRx4XOaukwo+Eph6Xr1Fmvp2SzIrs3KO68QgvBfmf6OdEWQhTZGjHJouqLVYIiSAaOq5ZDNFJCwCoPIaqn5xGgCXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583678; c=relaxed/simple;
	bh=24CtTktMCrTYnhJKM0CPxo89ofgYKr4aiWJjFoL6RkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXevyDkLoIBgCFZ4bziu49oyei9xJ12PAMKs02SUYfrsDMGSvagq7LcaeT4NaIlOv9F1i79j/5Lv4fV/LHOfQGtQDzSrgnue86t83mmKCRF46fIC7gYMBQlq3msfo46H077O9103iqSr9mDuM49oFkKGbCtPGln4Cx5TWhtgk64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Tb4reD5u; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Tb4reD5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrbfHwzGtGU9XhGNC2+u9/YACzkg+nxG8YtxwVh1jW3TOZHRdjRMy2b0mHWtv3NaGla2lmgY3HCNO8J4kaZ0RN09jSsiZZj43bHf/Cu6pF4uFI70Bi52tQjEypmOX97GiHy6rIEr4F112fYh7MGRe5+QLH9enbAAsK0B6zwWOlx2iwaaLV9ThHmlEYsrXXMSV0YjCF74jQFQRYDBP+iE8j2je2fY2WpKEWYiWteZnuQvmRXNBUmPM7XcPtio4slceKQrE/UNMsix+x7l4ZSeImOR99DdTStSJue62L9y2MUcTPVueudsKqQew7LhyMIW2r0VOSZOHzcHv86nRA+ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=wddAnoiA04d4vwXSzf4LAq9fW7WKq1ceBRUTa3bDCwNYpAi+9B03pzJnjIOv4sgfBo1QoXeCeVpa6gYza60FViW0dGQFlqgbzGjrq5/qsggt3LDAeuMbYwdpNG7J+ZwtY4R1Fd53Ix4De9MOExMRu8KKnpeXSCHJCZ9nTUuDAsSmAVe4QnVyMXA3VstuF7c45YRO/EgXDkSWAI6tV8JcFecwi8kgj+ZofrhniNWqiJpJsfJVf4aOQ6UmQhyk2L0b4qeesKIlaFpYaib9MRj3HnCSfYlyKtx0EtNP484GNPmYZSAIp7813YWDRIXdbJRNEdBzcqvGgkSlkl/Odk8IYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7RiGuw4rdIqME4X0uRgpKq66eSKksk/+mPslKC5zL4=;
 b=Tb4reD5uehMZhkPvRf9GUUgi5xIJMTUuf6hEWrHVRC30b3jksR2XtvtWfR7dCXhX7/Q2dIvVoYkQB2GW7D2zr8FsvDDGnB4mOFn/52gtYHWzk3MascrhpTcHHwutyMzSfBWxAbHWFG/Sv2aTxofc4RuK6p9733AhXEeiBRafA/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:54:29 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 03:54:28 +0000
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
Subject: [PATCH v12 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
Date: Fri, 27 Mar 2026 12:54:19 +0900
Message-ID: <20260327035422.4020455-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327035422.4020455-1-den@valinux.co.jp>
References: <20260327035422.4020455-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: c1584c2c-1804-4ea4-8d08-08de8bb48b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hk8goOydukjTEYukIP3lJE3OOTeJvZJqPU9uXvx2bMpW1m9J0ILo2UZ26zilp/BPM7vMT/3LH2Tz4X3YfuvXh4/2bT213Z9M+Ar4DDB62uQkMqzbv1ZgKw3k3SwUYabgLBnVWm85WwhY5IeKR+cBjvYRf19x7DD5yr9uycFNC2LGpkKBdf/Y18N1NZiCMX5jIDN68eDwrIFcfK3s5mgSfEQmZCzfQtEsXOeYkVRrQCkzGTpYkFzTSsmOJsFY2bDRCrQUJxvQ0fsREmRJjezSBCmGH5JzZAjQMY5EUm8MCBU9PbSJOrr8JqXO/78ROO+F8yQmieOIYRjVO4DXwd5h1wLIj6NhsTouZN2q+2AyXdYMcgR/j9l73wGFEQhqYcjomZCgw23TPdi91birutKJb7AO61WtYFXK20w233D/ADyhT82491f8HWnPOHmGYAkYTNwb/uYBfchQjUOsHg3NT797fmULnEaBM6uCB/Jh0+uMsHUPQc5HCW74sXYe1SKvrCwYNQx2VVVQUGJjgqZDQ7mrscrjYotUUOLIcVBKT6+oml0c9/6mh5nn9IaEbTK9CF3xLmc9rJomJagFkFwlqeG5sLXhMhYNbmiB3EQLwcdOij8ehjwH7kSjVKiUqqOzhjnxFHgWTPTXkDyUSXWUplIfQeFNaPXJ1YNjUl2aUUVbyWtEZoMgXh36ftCeV5oHsreDgS9jBDnZB0I1DN1qlFDQonWdIAkeHVny7syaMx4eYTflWJgREfWzPw9yUwOD4TF7Q31D9YxpZvww/7g4vw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tNxKIpXn015lZvm4ILFwjHd8DhGfdhdqCPM0k1QrraWBKle6cuLtTzgO2wnz?=
 =?us-ascii?Q?Hqw3aV5Qj7LbXoDagRk98uuPRLEGBzkEjLGywUCiiWnAgVFwQDzYI1KqSb9W?=
 =?us-ascii?Q?ewZHOn5aMBnbW2L+1dcKZxLU0xwrj9scfERWekB9GlqU2JrHfRDG1d6qbbYX?=
 =?us-ascii?Q?sxQHRwodB5owSDkRbArHEkZHVn0kF53FJsN352aLAOytG/rFoJgHByAQ7n7Z?=
 =?us-ascii?Q?Smp0eU5kl66sL1qzVWsRNqaDEjbHoAdAcXL+9rbXxO/XXHgq0LXizMnZP46+?=
 =?us-ascii?Q?nauOqwdpVRrOihQ50NXU3PImHH+Es9LxYlGm1944MTezzNjAPoTh+dYNblUb?=
 =?us-ascii?Q?HZs5BI0JDDT3z+z1TSb3jmdZg5C4Irb6AhCRrpJv1u86DcpQcrqJOC9hNEh4?=
 =?us-ascii?Q?zK2KjAY9c2jlg9Q+c9uF+4QCjppJrKYWfnBb1r2ifzzVpFgRLEOEZCLYbI8C?=
 =?us-ascii?Q?0pHXuxRa0YjIUXm6at0bqJN+3wvP46aIgozqIv+llp8k3+DcHFXK/TGb6GPq?=
 =?us-ascii?Q?bijOPQ/nY6lTxK4Wc2z1VOh61mmwGEqaaP64Q52eG2foz8glWNm/FX/KXWaX?=
 =?us-ascii?Q?3CHyxfo3UL0fbbv+RGXG4VrcbQlY9jp/Nm5Rh9RnQ2oTda5XZ3RTDI5RKd/u?=
 =?us-ascii?Q?uBwumhByFnTbWz37LhCryI4Fza0sBPwp1/xzGiKnH87L0RmJ9LZ+XrK7yrkQ?=
 =?us-ascii?Q?H3X+T8iuKvnoBfgirE/0Go/v0Aqw1kCA4qigAAU3M40zAnwKqTsvILHBuEC9?=
 =?us-ascii?Q?nlUVOj9yYKrZ6gFsSDpA0UcjEvNyDTtgVzJ+iVe29Oo132GVb/wPMHoHnbQn?=
 =?us-ascii?Q?CiMiflCdn+ILE+m9rJko/34bZorcm84GwDOwp0g2OnB38W5nQsyoRksueyaz?=
 =?us-ascii?Q?NxufD3SQlW8JIEM5Hm4MXlmnMfju8DR8e3SXLcB5+DeO4fiFOO7yKl7pETwL?=
 =?us-ascii?Q?MF6wzcCoOxr4kzBHtJTIxN2cPygbKqn10AsQzNWY3Q0nZlk2ALGx325+JX9j?=
 =?us-ascii?Q?WQMx/q7v8Qir8Zt9pr5kt1cWqBqS6p29CANLOJOme2/sZNSd0CzFTMyFpD7d?=
 =?us-ascii?Q?g630rXwmaHXuw5NgUYVlENMAKDqNZ8OBKTUl2jaHiJmL7aB6B+aDIN+EOvE7?=
 =?us-ascii?Q?ZB7P3TwIW5cJYSLDsPhy5f1NvljtjsRrfLDKABZxYv0NncT8eel2hO/8U6XW?=
 =?us-ascii?Q?tBJ8xSPxOt8J5S67AHIeJ5BTcXuoFnBKylyFlbpm58Lpe1kV+g8WhZrhYmv4?=
 =?us-ascii?Q?atC0xtniWxmG/uHbFBWDddHNl7S/qPrv9hhHwyKIS9ozX3EzpLyYMLYhOzXv?=
 =?us-ascii?Q?0hW9RHvP0eiIErhPH4/jkj88Kf0T2n3lxbWGQPH3cNzkmYI0Pgb4XMqlWrHQ?=
 =?us-ascii?Q?b4ZaVdaBaztivZOn9cXKm/jbCQdGmwIEenNzzyebAps1f+6PA4bfI3JvQjFh?=
 =?us-ascii?Q?CIZOl856cvOkzk465SK+uVLk9Ei2NkNkufr8ZVXNnujm242ofkfGZOpRZXii?=
 =?us-ascii?Q?HrRBh/RhyvY79MkPg6/z2bfOJO+fZvAIcanQHu38Uut1i0EHp98CStC4XOEx?=
 =?us-ascii?Q?b+8aJ2Og1kvGqZm+S86NOHvD/5GNPHEZh3IF9SPWSXQ2zcV6olwoU4382lFE?=
 =?us-ascii?Q?d4Uet2ppepvhT9BooOLF0NcAr0pbmQ5fPjF/abHHs6pFtOo9TRFUdwUDK9u8?=
 =?us-ascii?Q?HAbsh1/+bKeZJtYhsuP4ZtAfFI8IuRKHYKnsGG2b/4QG+LTBk1qL09YMXjaN?=
 =?us-ascii?Q?JidMoGzV81oKEQDu124ZRetoSpTFkLh9+tHnyQZsYl2PtM1cLTv8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c1584c2c-1804-4ea4-8d08-08de8bb48b78
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:54:28.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzWd5laioE1qjy4+BTi3ecyElLgx9Gy8/AXxnSmUAK1orytZT4EiyL+l7FwqmLppLi3VjNkHtGYz7gcnR7rrxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7090

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

