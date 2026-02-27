Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420936C0B9;
	Fri, 27 Feb 2026 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182206; cv=fail; b=PzfYTywArj2iYJijWnqInAL1VA6b9mGkgVMSicCUBVOw7qMg2NemaQoR6G3cz0d+EgFeU6X/0JL/75MFl/nKWNPaQ7Mkr1cWQ9QyVwyvP+3Edw2Q7KWwOvFPKtaTIttaGTORhBHpNDZm+T7n9LgqGWp51UndKdLKhW+qBOBU5As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182206; c=relaxed/simple;
	bh=Rt3iILqB0+j6yjP8QUelB1mjYOsM6FF2c3x/exRu56M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mcjpo3Er2VS9MCqevnU9N6kI41OYtp/DasaQ2bnqbau3Uz8YGryYo1k4mnfV8FqTGgWvMReZmm1bixuqpwwXdB8rCNzNnZ2Zm9VD1h4/+0l08YGi17JCFbuE2dIsZ2W8rDb+D91NKY2FRBQI6BYc+dSp0KSrdn5GTB9ALg4nfHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CLI2mWPB; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CLI2mWPB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfDvKNFLqUFLWVxK4XUHzcICF3wQrf8Df+mvQJxX2rBQL5RqyCJlbfCJgXcvBalWAbZajjBMB1wN/uyeIK/M+Tp6DD2ZyM2eQpsS5si79Std4uJWlU2GWC3AsnQ2ZIeW7NHqae/j0Dho3nlPSoUxIdqMhV1P6NyXhXxXjvJC7kILBkULdr7bhYNLOgVwK5opmHOyHnvYxQtH8CrnyOtWdY8zdz19GqzJC/EvTZAiZTjHKUmIIQDB3szFHrmy4QVm5mTX4nTyTD/lGTzJlL3Gv+1qc5sjDmr0XuY3rr5GZh8bTUGSuRJZK3cm0kag9Q7EKVKuwtGLcJcb2zvmi1UE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7SAqfZyaktnsFSyUyuk+S1dzpKRPClby3AeUsoBJ7k=;
 b=UT1HGR7VsmQuhI737JUBK/eHaQ2uzVq9TfN3LCcgIFp8krlabvezkmE7FeYPDKP8rFdXjXxE8JBraucknPyWe+G/PQOKIBIg1CXcWaAJh4VqborAyMTDqdd1+9cvyFiaGiNOPj5vT5HLUMLcJW8FINg8XI/Rwsa7kPuwHKTcsOgOG/68x1TiYcLwlHzJuPDXlQ4A26XzMLZdbrK3WpF/QyhBCeGikwlbgdRbF7zqwNiIexgtG5A6Qe5EvWlZBBuDSUaiOecLhM6G11jlfj6sJG36NnxKAwvCBRdqo8AnISdjpR5EKBGyhC5yj2xyzaot3LIU9z0ddCDbMln74JyXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7SAqfZyaktnsFSyUyuk+S1dzpKRPClby3AeUsoBJ7k=;
 b=CLI2mWPBSz2MrrTsOfHeWaazt89WlEq6TZvpdq3/JJTIYbBRycZB+iY2XdlBamn4KjPvleTbjtES6rCH4+V6jqNKwr6az8k4g2pZDsnyJBrM5iLfCCYvNx8YfjEw2vLPM2x7oKuPXEfFyXAYvZ4Ap5XWNZ/Aai9VJ+BlVfC/h9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4075.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Fri, 27 Feb
 2026 08:49:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:49:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
Date: Fri, 27 Feb 2026 17:49:46 +0900
Message-ID: <20260227084955.3184017-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0198.jpnprd01.prod.outlook.com (2603:1096:403::28)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fa6178-2202-419d-171f-08de75dd3028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	QIszRHjvtsmQHQeojnOAYjodPTtrr52OVsey1ziO/0+zuNhb7e1/l6pfHifHlDc5/03WlUVEjogktXManrGazJqYJvagiRWwCq/1m9yMHg2GvSUI5e7lAQgsS07V7blCZ2P49x8aAXJ1hIseoCXS1kD8A1twGqngcGb3EUz6Gbrzsz6P6P5Z4kyuVU7wIaXgmQhDL29ediaqyxz9o/DCUBpPoQu4vhkoC8u/1sC9JC/ohfBChosU8cOG7bSAJyTRsqu4ptYHm7q8cVs91SMq6zeAP6POB8RkXxGDPzv6DAvIBVHic1AVWuIvdtu6D15ZaXZ627eg2D1OXvC7ows66ENCy5WmIop2M/4lMeK3fLIU0eIVhPwtlNq9qRf2A/KPk00tYw7aAePA01unr3FwGIUPBxlyuo/GdA6X1eTQfMZmHNV5Yk+NAbP7eE4s2Vj9FaicZVg9VQJWjB0DAilfTxM1tdT3R2fS6eVbo41hD7BmyNhLgdULQ9Cc358qX5f59XKGEamZ1DQAnrO6Q07C7fDSoCcKbliBQ25W0VfXn3KNl+KRcTkQvBNjCoh0VkvzibNoubQ5hKbbRQUky9K85tRmZGTFxfGD1aOGnwNb/CCKkpSdpkWhxzSJJ1NCT+c/iZvHOh9vfcFAchYUe82l2OkzWgycfgsr7EPw8a7TWzTv1hTIOyzD7TMVFN7qHRbc+CFgbt9zg7p2kOkZx3V+X2efg4qW4KqrwEgo/TkgMS2MJ2cqijDPwmbDj0wiNbl6qgFV5/bwAvmvYwtll6vWsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WORf1FPzQtb6VNajT8WpqVt610O9su+bg9rAT5WAwGs6FTxEEGH1DEQlIwxk?=
 =?us-ascii?Q?B6qP8gvr3teQD3KJfI81HlidcC0fH8y8heXVMQTGUUa5bhCCC+Afzvgo+Dn4?=
 =?us-ascii?Q?kadxl1V8Gv4kVPaF1tpNMx4qTge1a8lEWp7hQUBrDR5dQTOC1EdMi9/nVbn3?=
 =?us-ascii?Q?pawVF5BNjX1W1olgKa1FgeKydEQMLN1O2dmvidK6/Q3o9VM9M6EvZq6+I5Hr?=
 =?us-ascii?Q?+0HnWi4RrPZ3A4xR75R9mhbQRC8gTbcQixhQ5DEWeKRIP4GNHBYAN+Tmkq9L?=
 =?us-ascii?Q?yqLJVAyI/NxZOcMcXlC2i3enWUL5jkUsc7SNjNzRp6mCVcYIqxihtO3K6D2J?=
 =?us-ascii?Q?R/Ikbl/XC2L0KhCEuTeJ3LIoozUTBhDmxcbfH1Li5HzHyg9j54yRxl+453N8?=
 =?us-ascii?Q?kosmB0wt/5jIH6fsMWVQDmFypFmF+lSOMhDEXdQGHxLo1atNOb9EKVBvlq1Z?=
 =?us-ascii?Q?7Nb8dKPFgSKwDw1ncMnCtvT4HctAOM/Z49VvLDx1IeHHmigSN3d7Euaq0d2b?=
 =?us-ascii?Q?4aOzdg4CYJcBOwOkif4w/rnbKbqsYrnY0lAqCNqaQPFhnQhMc428lb0z6K+R?=
 =?us-ascii?Q?uZ5Su54omyNcoM1QNgmmLZfAn2FiP2BgDCetKN5hCzN806FP4jzZ5ILXmckk?=
 =?us-ascii?Q?2ATYvKGSqEXT0J/cT5kjQBrKtBRfj5FvfcGWnzQ1nRT8LVVuIvGm9HG72odm?=
 =?us-ascii?Q?N3P28htUO0KRAwatsRnhRTg72zokLRbzPQzORgIffaNFwMneaDwdNxlygwzY?=
 =?us-ascii?Q?sQVr48VbDtVbacKTqLF38qI+UERKsPI8lKqvG9e79T+mZEGJWg1hNPz1eDCo?=
 =?us-ascii?Q?3XJvBK83U+lq34d35ztP7me7zB8NcBeLPjUg2hoEpBS8m2BFesWEQwoH14rb?=
 =?us-ascii?Q?zCdnKtaA2Uk9WZXEzQOc0WYyk7pyWQRnzhEkqLg2oL3YKIIZ1KX2a/cUgTgu?=
 =?us-ascii?Q?Fzz+VXdZtBzZE2QXvniwq7o99X/Q6mpMfD6+iZoFFBMb0Yv822e0BDjra62k?=
 =?us-ascii?Q?FpQuf0L/7xEj25MprCkN7J1hAzDw/lbTa2A/I6wgCfpIxEE28alxJr5U8nhk?=
 =?us-ascii?Q?2TO6jKcVKOtiAHel6cae0HQ0BgBOahJS79ZylDhqJ9W1xqIHdhkv+cWkXNoO?=
 =?us-ascii?Q?uh+0rc18lQi2rx/V+yGjj5Ix6IYoWKDeTkaJRiZbRlyZYICfsQAHMu05yhjU?=
 =?us-ascii?Q?Fj2NTA/tpG6c2XYX0YoIHi7PnBhpU5pOg91qAxf5XtO1zvRTl1uqGk9zMT2/?=
 =?us-ascii?Q?oQMOsCY8tRDZ3HIg44SCFemsJm+L9tVZScsYbwhVfWwAM3io0lZ+Kl9GpIh8?=
 =?us-ascii?Q?t+nhs/T7riILVx3+l+aD0ib4u0WaUDfjaEm78GfDD4ECuWFkKU5Y4SytUSwF?=
 =?us-ascii?Q?v4toPDg+CX+3qN9J3WpwcZOtA9r/Zk+8M+977PPU7jAih1Q37JD4hdS8GNDg?=
 =?us-ascii?Q?B0UZR3u03AwEpc8vptvRqjmAGfsFCzUlo40195tOuvC6IFNZkVgqV4kxUsDn?=
 =?us-ascii?Q?z7T6dSvGmAH5Fwq1ITL8Myid7gQGPILp69vJoygP4grVDyjUz+rqUmbRdViL?=
 =?us-ascii?Q?SkiCXRmkEBeYlvkeWQ/vV2kR3uszTkJ1JDxSNqH4FmFAYuqJgwUWDrXIwpRZ?=
 =?us-ascii?Q?LscV20Lfm9+EobarJ01/i02CXzDHUsBiB497IU5Nkil6mqV+LZwNN3dm2mY/?=
 =?us-ascii?Q?7aXPoE9P4ZizDK4k5QCly5XcDiA/DIthSi/obB6ie7UDM394814bOIVxzrfn?=
 =?us-ascii?Q?NXvn4qi6TWzi4Rr45IpfPcPJ0LxCpAXNaI0j3Bo7OobGalRzuHAX?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fa6178-2202-419d-171f-08de75dd3028
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:49:58.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOkT6qMXlQVQVpuTmWgTCWANcHRt8kq+Ofix3QCZaTn8Hbni++MELv3WobFPWrpRG7YyMn6hUeR0v/s9RYuySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4075

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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 148a3b160812..83372aba5106 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1379,6 +1379,25 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
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

