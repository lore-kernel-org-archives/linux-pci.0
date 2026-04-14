Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DC3E8C74;
	Tue, 14 Apr 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176197; cv=fail; b=dKOnHitGPi7ebvxzGTAemDQKLea8K1RlmMtAMTESyr0GgFOmkXLJ6SSOzOVoV62eMq/2eJh59MBLMrpG3AL6Z1X5YEWjhLZ3THDtLfoOb4ZfMO5b8YwZ7Ff/k8Kh/7wnKKIHnCxQXup8flhl6eRh25wjT2qTQBc20gxHI3l0tgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176197; c=relaxed/simple;
	bh=sgRjIYZasZJZC6aHGGTqAQ1lBQJuj5jFMHNuey/EsmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGmoQ4gBiUSVOlPQ7lHHYWn/D6s4z06fcG76LLD4jJjM30InvBHnwUQ4k/l6z1NO/3RTwU+SRK0wnHicWbhz2JTEqOz5GE8qtGatjzu8W/2wqN7kB4jL+hwj06Yovp/H0pBATpdMA24YVQv/6KwFEiCWi5NeYewt9Bh80sMy0S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OhCC0IiZ; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OhCC0IiZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDi62shUrsxSeoMtiKSB9NsQzY/e1qvaoEoLO+uCAEFUNh6fWcHwBypwVecrIqsycD5iz2emLz/2PYsxLeKQFcI98T2Z6gY2tk74N5MAVILcr7+qVrwQEuXBYiaYnyQQNCDGYumYADFXDcMyjKDf2Rv0AbjcioyCprdIxj+qQuS+ohSI2iT9+caYWmJxc9WA4zoVxE1t68Qjefp7/0nZJec/ocVQq5HhPITTz78mMoElBrwRAY060uXTEYEliKFoI+eqlY4ty7VXCqM3xHsBByW7wKatYTLXYQZY1YLE1lqPt2+f0vNgSgOtAG71Wjfxu/UCXkKcB87qmDIrXrihbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b35G/jLYtQSzKulf5UWuDqd43jYQoJdbINzQbTRfmH4=;
 b=d4C1vsDWuVdklJ5JB6E6sUeIOCPQrZIVyKBOVDqX9AtoRa7V5OeO/xworp427H0fFBOrogwJ+04FcvWnlor/c68TlCt3X6oFiB8n1myuTZiFvuglmLSfi6txw64Wvg+vVw1qQ+TPglPG+EJEm+aktPk+hBnO5MChgEyqjaCcSnF8HyFkGYCIjR/oYyMlP+ejADGz6CSjHJ/EUMyBEh0oj0N1iB1ziskjiyWiC/308nacIxzej7q3cw2v4DbV3GDzY2kyh5CeYsWTwZVAZQHr2b8CLjvgRx7APb15vvq4rSHVQCO8ik4tzJMuekaZU+nzcKT7FL6Cowih0YIQ36rXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b35G/jLYtQSzKulf5UWuDqd43jYQoJdbINzQbTRfmH4=;
 b=OhCC0IiZQhbMbkK3I4J9VJFNMUUFj2kqY4sZpAHrpdqK3CbmOu51SHjaBjFV8SW7ju5e6WMy2EGN8NMT+v2emoPTKvzVHrCI0YhSPlY3Mwn9LJLlNvX/KtFQladjY3Vf5Gk8h4ODbC76mlBfUAAaR0KW1al7p829ADE8At5fugg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2529.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:16:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:16:26 +0000
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
Subject: [PATCH v14 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
Date: Tue, 14 Apr 2026 23:15:12 +0900
Message-ID: <20260414141514.1341429-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2529:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ce8525-9f3e-4bc4-cc81-08de9a306a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OrQeIVgM6jtalc2D6i1RS0lET0ovNt0XfIfRuSnFqzvd2sEOgAUoPwMoqXNroxTRhT31ejQm40TPgLXyAvMbLZKiW7/To2q7ujP64drlDsuH9r8oWRuq3hW7aQ9uYOsSdHstpne+Zy2mRinhdOdl04m8cH4cYlhEvGMCeJqptuwr5fdv7KeJMfQ6uIEEPv+bh8h7enkBv+1qr2Cwl+L+P3n5+NSGkN4JjzkTJoA3josv2w6a49wg9EaFKS9NVNXfwZyw3Q0tPfKSHoJ31/52yUgqDVbm1jeELlBX/EBqvsoApUNYj6TWhf+tYjKdnk3yrftH10bNr0ZDdkrsxUp7hjvs6E/HLYCL/cNmqairoJF6JQpXgoC9wlqFbNZR2Og24Abm80plz54CRJvd0pw/9wPhD1Om6TsK7Po786il1DJ2JfXVCqizbx8+c5d9ip36AUhunRZUZA1CgUuUx2uMZtM97VAUF1pmkBmw6r2UVQWDrwUfRCAL1liYxIo+vqEqUSenbbyPg+eCyE5gOZYQBu0SJILlJLzxldYJu4OQ7LZaGytr43WX596SS39kI8v7DYtEM18PggKSqwN1k4LpqVPJr/8EQkBDGxpkN23ykGrYxM7hAIBwiTSoffDtLM6WKpRTVZg0eR/V1OfQg/tHnD/eKJZx3Dv4JwNsEfITZZYRMmKziyjpu5h8axBeTuC8xZMv9D2VspjLO9Ahwk/0W6/KatBZrufUGmISuZjE0iXiFx8SALVqwfJk0+tAvSHwNBWwRMYQ6ojxsUTdZaeINQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QoWYrA0bR2pEYzlmcMUK2KurBlUE/WKlNlzbSd5CvcTpt14qws9YIrIjmt7?=
 =?us-ascii?Q?o44xLndubct0fR26DQeF/f+7p056EceRw4gNPHPchnAhHzhaGB9dHGa2N0jt?=
 =?us-ascii?Q?wFG+9tsjzc2WcjQ/FCrRYckwnjOTWRsYne0J2M8DJlzmu3KFF55a0bwgEzgK?=
 =?us-ascii?Q?7U9r4y0osNXUYtdDdPRJ5uGod/xrq1xER/P644vs9DxDuOSgSlob8hHgDDKj?=
 =?us-ascii?Q?NcueWYzGxjblsqq4zCTZ4rVophEZKNy/4dxLqq57ltcyAzgMXhtRIKeD1Mtt?=
 =?us-ascii?Q?L2HHcOfvY4hsAAhra8P1u9JOrKAIdj87x2zkMUQujfdhCZBWDPnSRpc/r9Ue?=
 =?us-ascii?Q?sIJhTm3ouYsLOxIDv1ZG19qXaLi2UaqgJkpbCGsm1gYPWj5yj0rn+Rrl+35H?=
 =?us-ascii?Q?4nUs/TsBi3erN9tok5ACeF1SHsD8gtJU57EvBZ7DHXUvwYuEfzfHz2OpRMr6?=
 =?us-ascii?Q?kUIgKNEdHqrSsWFf3rUYHYvLBgdK29cBvOUECHhQrEmg3+0Hj/ac/3cHFWY/?=
 =?us-ascii?Q?C0mhwmuPjCmruc1x/fB/rBZ1HYQr5jdS9T/iZ5V4z7+YbBVMxU1dTG+y6p4Q?=
 =?us-ascii?Q?oXvjhj0ItgF1iuLoZC2Bq2KDVWHxjWVA5R5qHmVZ3tHF/6YYhcwvB5Qy13P8?=
 =?us-ascii?Q?1MTJoIHbTzeCpbKC1PsdULhDWtGlbcoyvU7VlzHiWCci/7EGkqW2XzdzJhq6?=
 =?us-ascii?Q?3Wp31GF5GmZ8vhZ7Vrinf6kAkEHpi0iAAH2mgwnIVEmw/zEbQYxx5RWUEpFU?=
 =?us-ascii?Q?mB3pY+OT3v+Yy8fR3+iVfVtky6qtGWXR9ZkcscKCx31mSps/Z3H3ZspVwRLp?=
 =?us-ascii?Q?uQrZi/q0sHu3bv//yROTAJuVkyADa8GR34mI1moJzKCRY+XniXKNFFVEr0WO?=
 =?us-ascii?Q?/+6nG1rMLSR4dl3tKo3EvJojFpRM6DopDH9L+M3t6sx11i3IXN/hmL1MEY2w?=
 =?us-ascii?Q?btyeGzlcu5lKBrU51eIHkyn7TGxEyE/i3X6P3eEgZaGs20A6izd7FV9quWXJ?=
 =?us-ascii?Q?yiI8ag0PRkICQuT6TgJgo0Bufxi3NjyIDvmuujmKmyv/MEowsRkU2cwAAqfA?=
 =?us-ascii?Q?agMI5jkh/nFqlGRJAeUsbFt/Mo4LL+kFtLqavo+Ng375E8MDhKN+vXzsT0FH?=
 =?us-ascii?Q?saRGrrC4Pyh4nqVW/b1z0wsasX+OhNkjFO3Xk2WTFnzg0HRYAiRJHp74z02Z?=
 =?us-ascii?Q?g4HUvqaokvb55HaZmG5b65mH8pJ/54Y1gErdQC/kcExDtPp/o3MZdLKh59Xp?=
 =?us-ascii?Q?fHdlWRH0Vq7CRt5KWcvGUvFz7XE8SOSh/eIsvD8apoMzXwe8e2gXXtaQ2Gsz?=
 =?us-ascii?Q?4ovcgWAkuDMqeRxAP+DJyNh1PWcAUPvxx5r1AUmE5Dt2wz7IIe97qPxygvFf?=
 =?us-ascii?Q?QiLc7QaPywcc35yzGCdqhTce2SJr+jUkDCqW1hRx6lxo0Z3MU0H4pmqhBAlV?=
 =?us-ascii?Q?YwbI0uwEUe9lucj9xuiweCuFQP6LIXLIh1q9gB4dhroM2sopViGRIYG3BH4D?=
 =?us-ascii?Q?VQGvCZHYYgIBgI0Pguab5CL6Q9a2IMYr60Y5nJjF5kGOR4n3sO/SKDpUlwHM?=
 =?us-ascii?Q?ksy7QFlhMhn9eE75c0Vn9NAHEGETccSh47GmD/mXPZjj7wM6vZt1upvrCmTn?=
 =?us-ascii?Q?iScEFqbQ4f+62HSWSIgKLa+5V6UERx4VCB3UtJuVh37aldo7up9zkKqkoY3c?=
 =?us-ascii?Q?MJgDn2AR93YpYi9o/zUs6fGR9rc5oej54fgnwyQRFxgUs/C8q6IH7LS95l+v?=
 =?us-ascii?Q?pkP1xM4E0XVVBl5mJX19h+eDZV0JXK8kWIG8yTMlFd3KgrMwFeRI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ce8525-9f3e-4bc4-cc81-08de9a306a38
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:16:26.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TaMwArrL+iWicMWvhjRjlDGzN3TvSK2orqlKGG7gQ9/z3U6bTBgnkSJibyZa1Dy1dQmvu2MtrrfoDtaBeUW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2529

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
index 2256c3062b1a..b493a300da4d 100644
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

