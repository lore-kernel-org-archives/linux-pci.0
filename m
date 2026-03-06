Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021130.outbound.protection.outlook.com [52.101.125.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFB366069;
	Fri,  6 Mar 2026 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766922; cv=fail; b=i0SJyOmA51BrSNQKWBxewI0OSNoSsC3mwF9V/YNM580+sSPVY2+O/BKGUz4fj/Hh44wIquZdtKwCXGulhgAbwfq6eADXalSySD6Hj0TJa4BLyZ5gYTKH16E5MwPc/0xSY2xKTSh9Cpp0eMVwSgt1vGbAbWisopBLwi4PR40fmHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766922; c=relaxed/simple;
	bh=MHK+zvqDU3APKeI4wCxpf6sMm/k0c0MFFF7Rnmdbhp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqX973jrned9QPx9JrIaAuxAEH3dpraVk7+LWhZGHd/LmzapeayWPuAdoWNjPvdJQy7zLuFzKE/gh+les4XcbVjHSFCoIr/DmZenGQYbAozDnfvdzKpB2xCNxfxardlBQWGw91BNrqaLrX7I6dCpJvGnLFSaeu8A2FUtjB9+SpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JhAt8NNt; arc=fail smtp.client-ip=52.101.125.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JhAt8NNt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDq0U00AthwmPy1kDCANR0dVLbm2KNbnz9Llwxshf6PsFiowYG574PVB3OZpYDn85vuaLoReqFY2a7pAE5W6RZ8nY1UTN05kip6Syr3FtyDzX/9tVz1aUxpeeAsDGejg9PT4ax32BcCquD3k1U3BEsCmUYVXfL9uLCeDgd7SKbUiXyJtzu9f/B5LF0JaJ3IQziSfZwzb1f1sbLfnPzCEoPfn+8rAEUvEGO5lurLcko11wswVY5drdxbnNSHDBfvSyj24MuSltWAZVM5pvjGxy5KZ2/jZNepI7tv5/amv869s7oq+KlYGf+BoG3oRh1p1DAgKd/ghn2vekS9uvTz5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oobfy4EnWMAYmgrM6JidYGr0ub3YyN/1vNCjSeoz4aA=;
 b=tEIyVaLJsSHlziH2zhWMEHY7Rxx+13dSvERIrMdnpfyh4Ox6Y2gppmMgEEJAhkSMyK8csePQ6f35nFt/7oAFNIfUcxYNOCFL7irJTclfdCljfU8oTOFmwTP4WibqYyaxKIEzgFc/MayUlhFrdXIH9k2jO64e7aAvxtxqKotsXmFinbNnKL74TkS/a6uH6iKJP/QiThLc5bHkP5ZBj7lDk9z3Ojak+TN/HlQoNDlYdH+Rdva27T+ut2D9HUE2omgP9eujaZwFTHTHS1eVluVEIxMi6dTCYRcpgVtcnxbqoVuMyRu2MEmANRke0wGxRmL5Spm/U610xWEF+DDJSlrAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oobfy4EnWMAYmgrM6JidYGr0ub3YyN/1vNCjSeoz4aA=;
 b=JhAt8NNt9svvk38rMaQcVzDPTTXiLKnHQ4IyVqSKMuFqiAc0SXR2OjHBTvfOryYcKinabUJSWUESyOcHvXrdfkzn6YE8BovesP+ychvSta4Hzo3eo4c78++0Aao6zEGE0XUJDokeVhDF6puBULwMJ7WNvTCxZXuPgr1BE7qVgVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 03:15:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:15:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
Date: Fri,  6 Mar 2026 12:14:43 +0900
Message-ID: <20260306031443.1911860-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306031443.1911860-1-den@valinux.co.jp>
References: <20260306031443.1911860-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf37f06-ea49-499f-e82c-08de7b2e9544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	ZkSzdoFoqhHNeB8y6eVSwAc0VprXW7GF5lzu/3D7y8/lsjFGibWvW3i4ZOJFHAuTe8dUhD5eVZm4cGCUNV/tvWlHPaOeAh02Em087R5gOdXV8gPCehi34sJ0Wr1umgOel7l2qdO5iO8gD6prli16wNpaXtU37KWu3xIix+fxAohsn2PacB2grVEK82+I8UQd9RCH04z4da4gjSj2MlXdptP1TchjzW7BqStfHaf9HuKzNky7s//gQN54U0EkWCBqTrXl5zPoDMsuDH751vrTxxeX0dj54qJHQF984dQ5NZBlrbLtI2cFdyb/oKSt0LyNafbAP/4jD+Sj5iABIozjndqPjA/7UvJg8SZK0abxbH6jHSBKfMfSFij1xCmtLBX7PtV2E9R/1akTnodRuOe02vqIRsP2QLnonqelikVmk/w4VRC7YRyJUCHl+N762GG8PHx9/+qlwNHEOVhDEtIfN4sALD8UyJKoNdPHb9AYOelIZl2I8i+NJb/qOk3jSNJIuqpd1l3fa06wb0GppRfQ3nnXyfbcpOixaS83IekzFGE1uSDZ9NW7ptTxTq+5SXuzQkqY6EWZVDcu4VjMlUnChAJvdXSWLV6cOIQzpMudj0d10Eg1UTTy7Qa8ayB1MiLfffj6/eGYwru342ZY6momogjo22Lof7zLD3c0L9veFQtnP7W9Ztt+o1IXIJfJ3UdMqB/FFmOkuBIKd6c+k8PjUq5xhViQGc3Q6kRhmEdQnFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HCxDojCy76ma9FtYl8oALEiE2bTe9++LyMwgc5yum2hxkx27m5YwQKwRXWZJ?=
 =?us-ascii?Q?B1OyArrlmyvMKJSby7nMU115yi9g+TXykw4iGibRbNMkjerjA4qGdbKzzmF1?=
 =?us-ascii?Q?4JuRruuds1iRzQcljx2UK+G6+AKw5nQgvT2LUQHAV5HcwCnpJDHz83kFF48o?=
 =?us-ascii?Q?61WNjkYRdv+Yat8TwoV4ydk5RlDKABMLy002x6Un3wppG9vfBV1oe6qxzwO3?=
 =?us-ascii?Q?QxdTzUpymQTLm44lxBPihQRNVAQMNbSzXDBQftyT/W55O66rOKTblVrkIboy?=
 =?us-ascii?Q?VpjCoq7XeqZ5uVFxQfV9+RNvaImrED5kFc5OGfV781dYKZpZONrc0Xt1atxn?=
 =?us-ascii?Q?a03xqdY0NOUAxusmbATHfaRQvvvEu50bdQdc1iKVV+yspL6579RnnYMk+ctT?=
 =?us-ascii?Q?xodIymBpZEW5SyS+mKuYMuycIk9x3xLiukJ0zI2gxscZhO2L1eLwEaIxLEM8?=
 =?us-ascii?Q?r6gIcpvRkyG/nY0wcIo0l4/N4nfyb4cytd1lPZLWPByjjZJFjT+vfqlQIryn?=
 =?us-ascii?Q?j3hjvW44l30bzD0NlPO7uX4kjCb5E64KvuDrUZG0GONhTWASuvUZsL8b3Lvp?=
 =?us-ascii?Q?cGxo57JOV2+cJ9AjBBe6LKe477PkDb5Vw6gEfUtoaQMTAFmqg2V5xLfh6gce?=
 =?us-ascii?Q?zr1dYYWwcxtf5UHYMxoUtcKsBXZ5fK2zISiY8q+aP3hHKB94+zHL440pZ/Sh?=
 =?us-ascii?Q?VQGj1sZgsMlLrAr4xPj/Fh4GxdEt2AsuNcPs7VZ0NSC1GHU0RdnGtTaHWAI9?=
 =?us-ascii?Q?Ues9E1Sj5Y/Ggj9xTpeXExonZpJ11uekz53EVDV5RH4La0r95Q0NwPVD7gpY?=
 =?us-ascii?Q?v44kQUWoB92vKzwHWRDyPS/czjHRKX0r5/PckdKeJ6YCz5GsULIkfmUWMPcc?=
 =?us-ascii?Q?uJwjr/tsMOY1X4q5OHuA3K6d4Rel8KRG8SdixFsFTcbsu4yysBOur7OYbDlo?=
 =?us-ascii?Q?NmonOs6pYMtiR15jeElPAWjAXfnF0gsDzAC6AA8EVBXSaNPzWiTCNoqdsaKg?=
 =?us-ascii?Q?RWrLKY33Pv7preEpJsKXD4gYR1y4mkIvIAfEpW75bg4j3NQYM5ASL5O0BR4p?=
 =?us-ascii?Q?J3dqni5bCa6RGEbHlgJojuif26QmCz8obHmo1/QEtQsgAuv7aU73+PldsJXz?=
 =?us-ascii?Q?enCtTu925cVdwWoUkBunnlCOsiNguo7fSt83tXt9GFzMDqQx//5AoncMSpqa?=
 =?us-ascii?Q?wazF9+/8ppIUXKFolNHuEdKxBQl76J5gAZXu10trSmGBskL6fy0hBx42UQHH?=
 =?us-ascii?Q?XuD+l2gEJIzlPgtxyrudIVJv4lT5Qs3LTM+erFsxSnBOdqBLJO/YcoI1tjsb?=
 =?us-ascii?Q?UeekCKYCXXk3Ci6AO0dk2uCihttx9USWrZFSPUFX13hJzghKIiKnbKDrkoOz?=
 =?us-ascii?Q?rH9DZ+LVO7XlciU5EGuIsmo77HpXZXMtVGddiR+QnegH5xNuZBsjFIvg6va7?=
 =?us-ascii?Q?zVrGGTNAcuIytH1cmu0cu2zVXJt2kgYQvw0rqNcmJQJceNUojd/q17NAa19c?=
 =?us-ascii?Q?xWG2nGYXaKuuChsxsIS2mb23BRQvTaQqctRLzndaf2sg48uF9ELZyvOj2fV0?=
 =?us-ascii?Q?8/Tq/SSjUUjHwSFD+zUKwHH14Ru6q6YxNI/BR0+4xdS9ZuwqVShSNeGgL3Bf?=
 =?us-ascii?Q?8i1sHORQHYiqIdT8b4H2tpze5tNkvt6aphjWx8kcFTxgq/h/urQX5UjPu1f6?=
 =?us-ascii?Q?8X7aHbikwiaLfoXILh6+U+ljNPQWDEJnnUExIwVdm5H3hFZ2Fc7vVDLTCzI7?=
 =?us-ascii?Q?8h1HSeBmGAuS2fHaBHkT9K267JJXayk17GRYWfHr7t91/b1V6kek?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf37f06-ea49-499f-e82c-08de7b2e9544
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:15:13.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73j3jiq5wXFwrgVrnpcK1KV2+4KJ8AsKXre/EKXoqvAzE3G0V6XXrFOJMq/beL4NzGEEM3+5teEysXkd8Ta0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6984

When vNTB is used as a PCI endpoint function, the NTB device is backed
by a virtual PCI function. For DMA API allocations and mappings, NTB
clients must use the device that is associated with the IOMMU domain.

Implement ntb_dev_ops->get_dma_dev() for pci-epf-vntb and return the EPC
parent device.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..e5433404f573 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1436,6 +1436,14 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
 	return 0;
 }
 
+static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct pci_epc *epc = ntb->epf->epc;
+
+	return epc->dev.parent;
+}
+
 static const struct ntb_dev_ops vntb_epf_ops = {
 	.mw_count		= vntb_epf_mw_count,
 	.spad_count		= vntb_epf_spad_count,
@@ -1457,6 +1465,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_clear_mask		= vntb_epf_db_clear_mask,
 	.db_clear		= vntb_epf_db_clear,
 	.link_disable		= vntb_epf_link_disable,
+	.get_dma_dev		= vntb_epf_get_dma_dev,
 };
 
 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.51.0

