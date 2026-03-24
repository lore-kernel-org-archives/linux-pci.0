Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51E3A9DAF;
	Tue, 24 Mar 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341530; cv=fail; b=CeSbhGA/vgCvGQzf982la/Li2ktrFMC8U09unhXsqNpQTOOHHurAAyZMkTCdArndF5OohGVpnDLQcRC7g4HBB2ui2iBQ3MUS9ia8I2C5rY4a4Is7nR+pGXFqMt90lSeyptXfO2jqa5irCViXIG1j68+D3Z4KC8loJsMdovkyOo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341530; c=relaxed/simple;
	bh=ULI1kJWrKZf9dgqsssHd8S4r5L3Gx58+ZUaN7Tme1pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNwES38IuvV8q91Hed9ptPJAtQkrmDWhBKS3phKWDT0EdH/0hvKYv5EMI62RKcGn7UEem81R0yxzX6T0Max45a2rQV0JdbFwX6nWi/z0CHHzN+K3WeS5yMkCiln/lS7gIrGV/jydzApkM4dsuXgOXMDM6w4HLXCrP83fW/OhkVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pm6u8fcK; arc=fail smtp.client-ip=40.107.74.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pm6u8fcK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTcRzvrIsdkhhcz9LMxBLTVXvS+CdsAhwkBKWL6eX4ZyK8B5teMRLR6fFqAW/U7ISvaEf2mu2dtLQVEEOktPo15HZ8dznpMqZY6ny2Rb4ceOTKE3acg92vdUPgJj0fSUfRRB2M6Vo5L9zqbD0cSBQtQwoN+oOgime55KbGmA9HNYkA5ykbzg77aMRczurt1RvNRI3+UgHJXQp8nsOUmmrSaGD9+ZqZv+yF5E28YHYizCxIoKqmKnBfHDw/Tb7vTNpKjw/c71SMyGQ7O0xVTot2dXKIgXEmfpLuIdJyv6VW94UXquV0x31A6klNHJL+jRkwDJDii8t/VY6546HWBG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knfGowzlpIuEygI7/1PTjdey52MiNgAUn86Co5ZbMw0=;
 b=tzrOq/8zmxUGUsXeqYGzq7v7cnmnp0e62V0jtdc0vA0RVncB8cNUQav0F0OY7+7+fxA7bSm38MGvPRBKmKf+K5ycAb+wgvflehXmhI3wrGxp7kJU2ezqyhZ07lmmJYXfbDR7ruVtjvl6PwG8Onk5BL7P9ocsjel4GquRtif4vIJGasD2ODBlEMAUPFm1DPK3gCWgfXkq/cRjGGm0O64z28GOK/NPJzytQ3ZvahToBeH7qEBKcXpAdmnyyufOnYY1yVXRLbar9yZyARgoXrikbbSfYd4JuxbJd6fjqO3UYf7gUiO1wq6LLEQ67MX7kbevoNJdtzL4jUllFPNWCmc59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knfGowzlpIuEygI7/1PTjdey52MiNgAUn86Co5ZbMw0=;
 b=pm6u8fcKdNjgj3Nl1zPxlfslZ5hUgd9BkLlY2iCPuCITVifSQXs76SSuf6Y8kBtz5+VSo+eWN6QD3R3xzdu1e+HONUXdMCYR0N/bSv67z9KvOj+cmUew79sOicQAyjHmodzUAZIFbDTCwpmuhmPlr8h4cuHNirC31HECAB7BhAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6981.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:38:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:38:20 +0000
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
Subject: [PATCH v11 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
Date: Tue, 24 Mar 2026 17:37:26 +0900
Message-ID: <20260324083728.3744734-6-den@valinux.co.jp>
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
X-MS-Office365-Filtering-Correlation-Id: 3757862e-73aa-4eca-f055-08de8980b41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qy8mlmNa1Sn3aX60Q2251K3Kn3W6UZ90wuV3ZkW691AIyPump8jSdiuxw/CxHhaPUXiAm99y4QKBwwwF/G3c8PiuiIoYI/ZWJmmvdmQ7km5P0xuEW+S6XWIXMyg0YZLXxKbyR0ferIziHtVw8r1QhzuEklFKL3U9VnZ/x9x0Afj3o9mFymegmegiimV14Qzdqil0S+gMLmpigkRfg98fmxKehJKfVHXQesa2n4I6T96K6gcI3ix2PJzaofDrATCufu2fJ30C8b5rU6z7MHSfWS8zGChq7zXP0/YLTf6lfHzqPlyvPdtE/Vq2+rZVBYr/QxB22C1q+KN/CNYnP2gc1UPT4pr52B/MZtb4aerwv/Z53qeg6S7p4ae+5qH6+O9sA0G3H2/P4KESqXJZNb3Q9UA4WHtJ/7AHfEHvHiDuUjNyR7dd8k1q3YFL87kS1mHvQnV6aUdjj3lMMUjOVTlyO9uKhHJtfXyv4bSC30b1zlTR6DSIz5+7Bq4paWmFVQFi5pH1pbIcGJdZQLhUvYNCPJ2T4Bo1jqauRnoM8kp9J3MEzLOoT5AUKjg+L5ZD02XfFI97muBt6NAGj8+qU+sW0u8iuTwZ1P/wYcVVN4pCCcQwLeZy5kZvbKCxI345vCQmwdNuK1yMnr9R9KnRqq6bThW3dR7slHlLbWSxSvywm6DX0xaH+EAyf3y8bJZNP0doKyBKzPZ6CtFV6iqxgtV3xgATrhlKurhLtK7zBuQ9/qREImIVy/ZomCdgiZufA/mT/lqX4jfXKuhQlpMlrwO/9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIFOCwry2Q6QO9DF4iMgS7Vu0Hnsx7opAg0PLEHbLTxVedAB4IW5qA9LDCzV?=
 =?us-ascii?Q?xDuR4mvFx83xaNJJqCSA5mwVBdWdJfhLZcSVpG5n+Psi1AmGs0zwzOJwOdSe?=
 =?us-ascii?Q?QTGuzlF8yRInQ4HQlUFq2JrxQTjQ2j72no6nKnTCcqLE6Sa/N+9rOs/Jq86r?=
 =?us-ascii?Q?TVozT2+EP0r8Ihg4Q2FSYDP6XTiFBUYdrmmGEWt7lg7e3zgqKeqeTsyDO684?=
 =?us-ascii?Q?88Wsc2SULEhnVFZy2izCNDO7peDeKdqBfMCe8O27OEq/w8WK/+DbVg//WIym?=
 =?us-ascii?Q?sQvRJpx+hf5OYasZ55/LsaCF4wiW7W+KDMXdWycosRxxWoYdtB37JOuy66lq?=
 =?us-ascii?Q?BWzNYq6DlFTk3mvADdfQiepzYFR/38yr8bwDMD60LsNwm68hi86PasKWi554?=
 =?us-ascii?Q?72VVnCE0zbPdPUbjPr7O1lnNUen7WRX2Rc0ymRdTZSiG5Ghwyv48OPjMkiST?=
 =?us-ascii?Q?N61rs0+el7u1AcDczc0ohe0sIkt6D27lVl/hwwH+fG9vhxL0ZPrPC7fb4g/6?=
 =?us-ascii?Q?Amb/Lkh++In3fKcrK4DnLZZ+XqFrguKtJ2H1dAxXhBS+qJeanalCCPuFTEED?=
 =?us-ascii?Q?1fryGUhZmO089YWMZTWU+kcl0P/G7RI6p4EiHRvyYG4DQjd0fbAAeUS9FmjZ?=
 =?us-ascii?Q?YEgyo2kh/hmsz7YuqtgtKAgMOd3cDS3rBp0AYpvyir5nyLUnur7XqCp+cIph?=
 =?us-ascii?Q?I+yVYslhDMqwlsYlIEfI7vQgNBhG/Oh36C0VQ/sEQRD6o156EiXlAqn6zUjl?=
 =?us-ascii?Q?mIR4Jkocg5ClQSjo3vRZaZAnJgL2DTpioS+ebgypw9CrftukhYnrsudGPnbd?=
 =?us-ascii?Q?NHPMDe9srfyAq7SoK+7EZHdYuln6YNgE1St/Oieqgt/89YdnAMnnYm+MzKB9?=
 =?us-ascii?Q?mUSrQHUfkXfF38tXQerkMCZNu8oT2n4WU1q+4thaGbl+7rkfEtQTOO6P/qwW?=
 =?us-ascii?Q?NsSZxcABF7irUi9TBDkkicB6o4DTkGxZouhkGJJWk4mdEoGrTV6NMa3t6naX?=
 =?us-ascii?Q?oL9yA0JIexS/ht4Hf3VWGswx+VuPFVrskjUTLoOg9nY+1APkwge5sKA54vmR?=
 =?us-ascii?Q?amBYmQ/lVx+1G5BVvm2izkDylTfj+tB7PNCYj8H4Y0JxSTWp2vBe2VEl0IPT?=
 =?us-ascii?Q?9vlFwWsNSiIZtTDDMMy6PuVXN75XEvoZju3qAcgkld6fXTOHvaNAak4NHk1x?=
 =?us-ascii?Q?6WhZZ8Hhrao2zUjXyMcUqQ2LvWtyzOs0US9AWoNTjyJbXN/48dwC+5rj5Ezk?=
 =?us-ascii?Q?ZBy0A7+WG0lTziZSd23ruQYDvp56d+Kq5shfnjBJK1mahlPv+cU2KENL94oA?=
 =?us-ascii?Q?wq+XLf9w+gdxoTiDKWhjQVqjomZv2QxGZ0Y3dFJIce0uxmHGfCbJz1bVKnQ3?=
 =?us-ascii?Q?Z3vumPpcSbo8OrSyrfZlDr/1lmMyAEBQ++gaAlM5jgOPl8UpdB7B7XXAemMy?=
 =?us-ascii?Q?tJMIiFSFOLjEG+0I7Shi86E7hJWYHCsnvHJblPOqa22dtJcgsvg4mP3Y7fst?=
 =?us-ascii?Q?gNnXod6OeE7oj7mM5oD/FYq49uJ7LZ4eRSt/TabTYhUbUJwYhbQIi1Tun4ci?=
 =?us-ascii?Q?+gylSfqANp0t2jSX7wRPx6Mh33UnoLo64XIgp7/6cdn4G6mbQaTtyz5TUKqU?=
 =?us-ascii?Q?/OEJHrmTA5MOFGbAcP28OMAvxKdyRmBLrzZGV3pUDDK3LgIWwZq8Gk4O4dIX?=
 =?us-ascii?Q?zHkBzBHyVV7AP/TRTq7p+8vAIMAo3K1c2NRjWqcFQWGsvHlXMgToPZhNGmkx?=
 =?us-ascii?Q?5O+t7ehiCqWNm02H3BiaL+DFXRFgtK3UeCqhz7rpkbD5/ik47pa3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3757862e-73aa-4eca-f055-08de8980b41a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:38:20.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8PHOe+lR7jecgj3cC/nY0KDnEg7QOaJM6BEcqnjO5deL0Cldq8DYZMyyMueMskU/VJXcFQCZ4qhKXjmLrqxZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6981

Support doorbell backends where the doorbell target is already exposed
via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
must be requested with specific flags.

When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
pre-exposed BAR window and skip programming a new inbound mapping. Also
honor db_msg[].irq_flags when requesting the doorbell IRQ.

Multiple doorbells may share the same Linux IRQ. Avoid duplicate
request_irq() calls by requesting each unique virq once.

Make pci-epf-vntb work with platform-defined or embedded doorbell
backends without exposing backend-specific details to the consumer
layer.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 61 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 805353528967..608d5a54e1dd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -134,6 +134,11 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+
+	/*
+	 * True when doorbells are interrupt-driven (MSI or embedded), false
+	 * when polled.
+	 */
 	bool msi_doorbell;
 	u32 spad_size;
 
@@ -517,6 +522,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static bool epf_ntb_db_irq_is_duplicated(const struct pci_epf *epf, unsigned int idx)
+{
+	unsigned int i;
+
+	for (i = 0; i < idx; i++)
+		if (epf->db_msg[i].virq == epf->db_msg[idx].virq)
+			return true;
+
+	return false;
+}
+
 static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 					    struct pci_epf_bar *db_bar,
 					    const struct pci_epc_features *epc_features,
@@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	if (ret)
 		return ret;
 
+	/*
+	 * The doorbell target may already be exposed by a platform-owned fixed
+	 * BAR. In that case, we must reuse it and the requested db_bar must
+	 * match.
+	 */
+	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
+		ret = -EINVAL;
+		goto err_free_doorbell;
+	}
+
 	for (req = 0; req < ntb->db_count; req++) {
+		/* Avoid requesting duplicate handlers */
+		if (epf_ntb_db_irq_is_duplicated(epf, req))
+			continue;
+
 		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
-				  0, "pci_epf_vntb_db", ntb);
+				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
+				  ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
@@ -545,6 +576,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		}
 	}
 
+	if (epf->db_msg[0].bar != NO_BAR) {
+		for (i = 0; i < ntb->db_count; i++) {
+			msg = &epf->db_msg[i].msg;
+
+			if (epf->db_msg[i].bar != barno) {
+				ret = -EINVAL;
+				goto err_free_irq;
+			}
+
+			ntb->reg->db_data[i] = msg->data;
+			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
+		}
+		goto out;
+	}
+
+	/* Program inbound mapping for the doorbell */
 	msg = &epf->db_msg[0].msg;
 
 	high = 0;
@@ -591,6 +638,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		ntb->reg->db_offset[i] = offset;
 	}
 
+out:
 	ntb->reg->db_entry_size = 0;
 
 	ntb->msi_doorbell = true;
@@ -598,9 +646,13 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	return 0;
 
 err_free_irq:
-	for (req--; req >= 0; req--)
+	for (req--; req >= 0; req--) {
+		if (epf_ntb_db_irq_is_duplicated(epf, req))
+			continue;
 		free_irq(epf->db_msg[req].virq, ntb);
+	}
 
+err_free_doorbell:
 	pci_epf_free_doorbell(ntb->epf);
 	return ret;
 }
@@ -666,8 +718,11 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 	if (ntb->msi_doorbell) {
 		int i;
 
-		for (i = 0; i < ntb->db_count; i++)
+		for (i = 0; i < ntb->db_count; i++) {
+			if (epf_ntb_db_irq_is_duplicated(ntb->epf, i))
+				continue;
 			free_irq(ntb->epf->db_msg[i].virq, ntb);
+		}
 	}
 
 	if (ntb->epf->db_msg)
-- 
2.51.0

