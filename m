Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992639E166;
	Tue, 24 Feb 2026 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940109; cv=fail; b=OXmgCU/b2QDdL6G4F6ivGw2ky9Kukz0sfQ3j3iGKNHI5ArJxNDNEHJRWUS7i0Dc/t8sNNk6Z06PNzQteDWZ0odNBxul9t6tqPeNYUEQt52ELntO0Hj66omo+9pOfMCkHlEoue3r4IryuJkW9rIrsNSpjvWXHs8JJmciQUhck/RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940109; c=relaxed/simple;
	bh=GiJpcJwUomJO+tUPDX9S7F1rGaOkFFqvD55UoiOmE1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RMAvNSM27mvL496inA1I8J8DdD7nJdyCvLV+3kenQzJpgt8CsCFUXzcOemP1tJcWx14vf9iSpbIhqVY3R63LrIuMpEXDBeu3jwxNu2d3EOCAL5BJCBv884dF9WrIUyGMHHlNyxMBGXQBvlT+SprevRTzoYJhUaoO1C9neKolCaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rxSL1NGW; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rxSL1NGW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUp1MK5ENRIk8gc/APWtbPd2rtF91/iPzs1z+bGziRxlP/H/63qgjy099OWy48QdtbHDemt7GLCJvHwu4L91diRGw5t5+iMhtk04nOS0lkqmGLq7KeBrBr/hdigl9pOph82amXfh9YwsRgQcADxo3hVN+TXrRfDMxBXPXR8LGpXneHrkwdzkXXJ9IURlqDXI9MdSmho8+qIokpNRx1K7+qBhlHNsmnytqVCiPAjA+cLjG0rDRpnsydV19L0eejZBw5Qs/mL9sls3mORHli/ODO/67vqS7bxrDpDmSi2yKAMDT1sbKfYp4SFgEg9tx5jlJwz4qTIo6a8wXCPjpyic0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRT8Ot6ESiRRYVGD9RTIzAuEZoniXr1jLCIoakX0Ons=;
 b=S3GvSDpuDH63kzPuanwL6qD75K94Bf4N1H0T8+POCSsy+mutL7+/es5CBNCOf0hVSSWbceLelIMbk1m3lvYHSi2k9t5xY0cX+DoNmUOR8lWAKIzYNqlMd9ZvfgAJoDM7ON3+mYUR1GY1TAW79dt5EgMghg6oYVeEGYDxtd6NV2B1IeZDjifYiZkWEzDN16N2QgH1Elu6+rKqzqRBQhlQQbc3Mw7xAqnRvDjkyRNyhJbwEWbJMG/0pvZHMwtXoHH7Oww3iJaT3Mvtr4FDicK+mPue+UYiTvKG3onS2din7aKTpvgEIYEODuXDKSg57ci7TQzNuPtn1RNqhfywfLVESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRT8Ot6ESiRRYVGD9RTIzAuEZoniXr1jLCIoakX0Ons=;
 b=rxSL1NGWz9O/9K7J1Q0SSHBoW20fQW8x6IhjpOYm/jnQcPLkxrVZ6E8WNXoYivGN4N9Pz8Yru4mOnDzqnGKHeVdIEaCzABE9mPHb1J6uDXf8MrlgsMQthfyXX6ii06zQAbSV/YFX8bHwog7obkQkgD5MzoTyUVNB2clzsOl/rdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB4764.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
Date: Tue, 24 Feb 2026 22:34:50 +0900
Message-ID: <20260224133459.1741537-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 61320a09-5213-4a15-89cc-08de73a983c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5sf0LHuJAFPZ68jqtPRIiHy/4dO877I/9BjisOZEgFmPRGrQsoMp3yPm0R41?=
 =?us-ascii?Q?Vg83qFaRVMPACbDhYz473H9d1+v7onKXAhNMU4AyuJQYtE8F3jZg9bxOEL8/?=
 =?us-ascii?Q?wToxC47TsUuOv+TSUO6Ueu4fMgrwUnItmBjhFMKWqj8qS+yxhuNr9ny5MOJT?=
 =?us-ascii?Q?jdB6DdsMpMvsqvCJTqjL8SE7V2gZYLwNCi7JAAqTOigke5ZfUQ+0bwkzwNu6?=
 =?us-ascii?Q?lGPCf79WGY9myV1CPTzgofJ+bCQs7iWY7pQX5Xvi8EBZ/hn4LkULABtNFY6X?=
 =?us-ascii?Q?3VNxBt1eWmjFjaJR2pigJ4LGjTROxZ0rqX3MqGa1nDmzbLLKHl0wwjG4hieK?=
 =?us-ascii?Q?up5fGjFX0I6tUXgJw0GwrAiimMChqmT2Zwm7YZG/Cb/6vO6y6ZRaHwKxYZJi?=
 =?us-ascii?Q?T+j1imdYijq9AWRig2gYINRVBNS6Uw/0Bw6s7mdP5pK4cQEV5QM46WuGXIQf?=
 =?us-ascii?Q?12vCODBuWlcPUaV3C3DoZRFwiWPAtpQO+LL/FOoqMwZXDOlo1bC8fWw4TTkS?=
 =?us-ascii?Q?NTq0hgZpatQ3wOrPHQrh08kfs1/BU8Zp2J6t/Y47pBUMvhM6ZNG5ef3s7Tr+?=
 =?us-ascii?Q?18sMvolh8EDcUf2SKbG+UrPQYpKj8iCOZ0WeTyxe5QJPfFJoM85wySXjBzbc?=
 =?us-ascii?Q?ll6a2hUk9nJGwP9B+3ONY4JxZSvlfflBtDwUSNQRUKKSVwBE+12591n9wcwL?=
 =?us-ascii?Q?x53wKOHnTjVQms/4uOIdjAW0EAeF4C0nuukFCorZCEgLpLp2vmPiZFxcJBz0?=
 =?us-ascii?Q?4fRPQwrd+HQuFkr+g95kUcyUpzfBEq/lMWzL71jQ4SnMDCCn8MwvX+48sFfs?=
 =?us-ascii?Q?52saBdjOMYS57uc/VJzLxXJ9rcZeqPLzrXC7zUjSwlkFQkMR7oTyY4enFqd7?=
 =?us-ascii?Q?dUV2zzVqdNmTsUZWitqwyC4r1iVe7d+QIfhIwPIWvt5aBI80TnCuGidW4xa3?=
 =?us-ascii?Q?uudSJBW2cBDm+tkCq67iO8D92XOFyIhQwaxKW6YzrYG7ZFDa92eQBMQqRuAq?=
 =?us-ascii?Q?9zTvtUr31sPol1r86Ad8WK0sabILQdNs2ZR7vIWfa2PavOV5iNCYvtQKMrZ7?=
 =?us-ascii?Q?4KK4gTXHL+4ctBbt+ofvYeIt1IsJH0ZACo4CGJa3PKOk19+fwzqh6iUZxYw1?=
 =?us-ascii?Q?SGbLheo50UwFVuwt8zB8jFZeUPc1s1prPPxyR3bAFjwSRV3HunFjAvHYvHYB?=
 =?us-ascii?Q?TJ/bCYoGRM+bIpZaAvo9ATmxXnS3aAE2sTqppoDIaCFoINLIdl5HMaoyS/A1?=
 =?us-ascii?Q?Vh3eRz8jSoWyqeulU0A/7RYqBTQktg9rt+Q+5leG1ocqaO9G8FV87H5csGyY?=
 =?us-ascii?Q?6zvKbN3cBMO7CZjvV1P9tmQktqZVBnBpURp95R3RSnY/ux1GpBUojIl+Tjch?=
 =?us-ascii?Q?oTbstQONFIz4O7VV4My4TpXFJ3H1F41lPvCXl/ebEP1gv8SDb9vB3pCIooUf?=
 =?us-ascii?Q?iaxB2ugIRcbYBxl/J0vOpLmuCVlkGr5RG+tIIQSO/nvPRrA//yE6z8Umpvkg?=
 =?us-ascii?Q?KZ2YUtVfwvvPbXwG5wCg9ed5dqoA7+9DFnV+pbFvJhlJX7+Vbd2RsaJ9ZCOV?=
 =?us-ascii?Q?ehDBiT+G0922y6H3I2mjm6rE7aSeEu6mtZ6HUm6fb81cDydcebNwMPbe/Xfd?=
 =?us-ascii?Q?8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qw1aYFXlsbDlj3QeGsmez1MvrW+FMLtiaQOVCWLLef2VgFEgVA3HH05CWdPx?=
 =?us-ascii?Q?Pb3MWsDje357EvQWes2skz8nfOs+JaPFr2pE9m7vY/kMZVvi+p4AbsPwxpQh?=
 =?us-ascii?Q?vB0BAyMpdEqVkEJypD4lv82fDDsthSGVV4lKzwiqZ75wEbfI6flvYpMPML+C?=
 =?us-ascii?Q?Seu25z2FHMDpNmeFy3Th2tXGQEfnu3m+5dXl2bBWmCgEMI8/9n6KZvoeMxWX?=
 =?us-ascii?Q?tPmRbso3vvl6tQVBLmiyz1UyRVVlZGyeU+EKwUM6cfz4i8Iwmdinkmlk2GYo?=
 =?us-ascii?Q?Wj374/lhqrtXOBu6aHNE5IeVucmMuq9DTyn1qHkaIBruC9uhAniWW15gXfGF?=
 =?us-ascii?Q?oDE4cSzphS/baHMqagl1u2E6CK/L5VVgJxK+SLvvOgqD7hIo15jMdbTvMrJQ?=
 =?us-ascii?Q?gKFztm10V9f1pNc1HfSKZiyV3KiX2hnovYDcFHwXQzdVGqLFM9MsW9Dj493+?=
 =?us-ascii?Q?rwPDj7iEVxe+T9QyM+6kbrogWn1RlbWOeXI+00SApF3zvQ1fi3617QpbDbwg?=
 =?us-ascii?Q?N1uKthBftbeVSIm8wMey9m6Wm7wM38H1VC4P+M2FYIx62YweFLIwb76SV1nh?=
 =?us-ascii?Q?ri8CD7HT5vfSrc7GZ7XLwJn2v8wztNV9428+6eaB7zombfH9zkP/lerTTaxn?=
 =?us-ascii?Q?dwQBo4dEsjncUmF/xvAPNKcs166s79SqCfky//KvOmUFx5k4Iw6m3ccUXNOA?=
 =?us-ascii?Q?BBPcMaKjBLaw8NmeHXrkEcigEqVsNn7hmRoDprU4iwQlEpG6fxDn7Vtu1AG5?=
 =?us-ascii?Q?pADBht2p1YvDHSKHu0koB/UmJH3y8uGRdEZ4/Uvslv4s0+IAJ65Tkf/It2a2?=
 =?us-ascii?Q?e6i+T45A9S6KIbWDacKcpTZuFyC731LoREdMI4uBrJx5DIuIp0t3pflsFxZz?=
 =?us-ascii?Q?hg6U+2d7ZpB8aGgyNEWkJbFPrV5qQ7dM8hcbJ7qgbSAKB6XEOJVKODR7R1RZ?=
 =?us-ascii?Q?Kox5UXOJuaT8sVFyVWR/yZVyzwU3tRwo5pTpbZ9JcQPH6tP+ModnvFGzeZIH?=
 =?us-ascii?Q?3XWB/MVs5D8P0itdAa0pi0gRPT/34lc6MfmyxzVJA1KTH5++iMz1QrM/cfbH?=
 =?us-ascii?Q?+Fg/ZkraxFCksSicQv6bsfCN8GG1bJgc/jv+tnuxfklQ5IT6DtDydz0pCRG4?=
 =?us-ascii?Q?wRlAVS3cdI+dcn/lcuQ+kFEQ3390rRKjobADCYkeUVHnJq2yqJBvEqhXV12y?=
 =?us-ascii?Q?fD0RG8YPK6p/5UVX/oPuVDM6BmzVtI13lE59CMWdMHrtjOFthm9GxBYqcsAE?=
 =?us-ascii?Q?x1+NZF8KR0HnF44d833s4Z4mu4Oq4v1S1Rbrr8OhvdxJDCD9M7VL/OU7rUvw?=
 =?us-ascii?Q?fQkjiIv0sT+9FI1f9HuQFpx86yNUA/LpgrHuf15F2iKDAeY19XMgaiZHWX1E?=
 =?us-ascii?Q?EdSb0cnBg6CbZGtKuGHuZyGeLTEX+gjjgjCXZ47hzdkrz1nyzaIL5OeAmlaj?=
 =?us-ascii?Q?+Z/FuX4Roa6/ldIyV1KSTgOUArBB3V6PB3CuWuVhLh8bvUbRwDKppIH8EPrp?=
 =?us-ascii?Q?nWCMn4dnA/aPWXHbBeYaTj10bIltnpIVtAVyieMmZLkVouN4USx//IoTOS/6?=
 =?us-ascii?Q?3nR8o/S6cxVKP7Bxk+ptJOrEkoBzRdz5C3QBx5OfPlE/1qevwYmMWEC1S/YN?=
 =?us-ascii?Q?Th6cG0Yoeibubi7g/kQ46wZjpYkiin/ScMDFlRVpKZHjhPBqadaxkiy0De3e?=
 =?us-ascii?Q?WFZ5QMCojrdzRuMCgmHG1882pJ7X6BzLhTQJavQiEcOFj1fnq9grUh1tDMTa?=
 =?us-ascii?Q?pg5gaob/wadGj5FbJYxxQIkfwDzTvgi3nrHVDfM9WIAgbCyw1Q1q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 61320a09-5213-4a15-89cc-08de73a983c8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:03.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsPAmD3BohPY1T3F+v6/Nvvk665o+SJ2qWr2ODqoZS49lVmAG+UJPZ2c+zONeunkkrEnpE9UjvBcXPhkVqXDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4764

vntb_epf_peer_db_set() raises an MSI interrupt to notify the RC side of
a doorbell event. pci_epc_raise_irq(..., PCI_IRQ_MSI, interrupt_num)
takes a 1-based MSI interrupt number.

The ntb_hw_epf driver reserves MSI #1 for link events, so doorbells
would naturally start at MSI #2 (doorbell bit 0 -> MSI #2). However,
pci-epf-vntb has historically applied an extra offset and maps doorbell
bit 0 to MSI #3. This matches the legacy behavior of ntb_hw_epf and has
been preserved since commit e35f56bb0330 ("PCI: endpoint: Support NTB
transfer between RC and EP").

This offset has not surfaced as a functional issue because:
- ntb_hw_epf typically allocates enough MSI vectors, so the off-by-one
  still hits a valid MSI vector, and
- ntb_hw_epf does not implement .db_vector_count()/.db_vector_mask(), so
  client drivers such as ntb_transport effectively ignore the vector
  number and schedule all QPs.

Correcting the MSI number would break interoperability with peers
running older kernels.

Document the legacy offset to avoid confusion when enabling
per-db-vector handling.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..4328f05acfe6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1375,6 +1375,25 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	func_no = ntb->epf->func_no;
 	vfunc_no = ntb->epf->vfunc_no;
 
+	/*
+	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
+	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
+	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
+	 * calling pci_epc_raise_irq() therefore results in:
+	 *
+	 *   doorbell bit 0 -> MSI #3
+	 *
+	 * Legacy mapping (kept for compatibility):
+	 *
+	 *   MSI #1 : link event (reserved)
+	 *   MSI #2 : unused (historical offset)
+	 *   MSI #3 : doorbell bit 0 (DB#0)
+	 *   MSI #4 : doorbell bit 1 (DB#1)
+	 *   ...
+	 *
+	 * Do not change this mapping to avoid breaking interoperability with
+	 * older peers.
+	 */
 	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
 				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
-- 
2.51.0

