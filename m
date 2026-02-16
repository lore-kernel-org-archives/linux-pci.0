Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B23271443;
	Mon, 16 Feb 2026 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244006; cv=fail; b=tO/EEy4M1c3q7pgcD+mt7iae5el00vmkKonU0tmD1X0ZlteEKLhYLCzLRjmKOI2nTzV1zhFZbocRbw7PNSlwvw3nwAdt/h6v7+/2XKGlI6VdOwy3wp3NiLduC11yZRj7Mc3xegkI2uJGGXq4n1ax2RRKcwU8EZmSInlaEfxIRss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244006; c=relaxed/simple;
	bh=y6Jqs9hXLmA27lW4MgFc6AbN7miBd3voiKfszyTI2ww=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpJOgM61Pt7kqxUSxutmko7X9rjRGVJ32j79/WiAdBwmW6UMccXB/kYHY1+i/CZceWkUsxsjMv8Zf30p5kHhuzQKYH0ZcjGPBdi/yo64asmIylVOUATYi17hDdTMxTevCc54Mdf2TZCJcNpcqJuUwtf7o5HATJ8uC3BdSMBQ/P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v6DfwgDY; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v6DfwgDY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZUz28nrKS9K9OtfZAhwwsjn1QDckr8F2dF+3/Y3MF+dnkcHX8XDWi8TRJi6n5ccsbH8lwySJGL0P5yaxeAlvgrV9bnT4XZppesFHCe6pfvo+X36Rrf18naMFXcrDKr0G1Jz4fQGiBlk4FrpAUK4fXnfy6nEwH36Y8OP3cyQFtiC14JObGPMbQg5mWkpx6uGdNzzYZUL1NH4V6GM3O1XtHZlmWnlMxXvXv3Kbs44kAZW4oKOT/zAWVpnVK0x1j5A8mGil45v/pKs9cPMjLOQ3UtpSivHnLZ7BSjejms1DdonAAnXKyrbSf/GK2CGtSEr2kSWFpVF49uLO/1kMrzTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5/ZKA7NDZhiAEXpQ7F/qoPSPBEx7teIW9/9D5x9FC4=;
 b=KgJlif+XHIgwnPojA92KOp0CoHK8+TMJLIFX7WXj2Bgo2j2RPpfwSQkOf+/W1X+LdGAvgvuBuFlA3CxchfnuSrvbXmOjrB2JQAXsh6cUH6/trZK20MggqO1W0ke6oaeUaC2mRYZAysylTWC3X3MPqHqSBlU+whGuuH8JG9E4aTpe6BLYFAwBnu0Xx7Rw7z46aGjmOpTiQD0b6pUnI8g02VkJqTUWZKnipBx+/Z+rCu2fskeNaXO4vZR43v688yXxB8ObbNhIgCCGvmpcYObIEL9rrolfZuoUravrrLg+yER0w3HIZfmZBPISGq3IWMHMkGZJu69W3rUqZWqm9W8BoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5/ZKA7NDZhiAEXpQ7F/qoPSPBEx7teIW9/9D5x9FC4=;
 b=v6DfwgDY8m6xDEyMgBvj8xZMAqb8+4+1lJezscb8BCNUhqAgRWXHkfArTnz6w97hxYVgpAroAUH5nL9jb594LrjmdPuPj4pYqoWRUDUM8VumLhqZaTzYsA1P9oZEYTQM5y/iRBn3J8bWyPClvDdyH9su2d8YpCTX6L6J44RC4A0=
Received: from BY5PR17CA0068.namprd17.prod.outlook.com (2603:10b6:a03:167::45)
 by DM3PPFB0C5EC304.namprd10.prod.outlook.com (2603:10b6:f:fc00::c43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Mon, 16 Feb
 2026 12:13:21 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::48) by BY5PR17CA0068.outlook.office365.com
 (2603:10b6:a03:167::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 12:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 12:13:21 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 06:13:20 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 06:13:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 06:13:20 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GCDGio1263345;
	Mon, 16 Feb 2026 06:13:17 -0600
Message-ID: <0b0fb3e93921dda6f778a96119077e597832ed08.camel@ti.com>
Subject: Re: [PATCH] PCI: Add PCI_RID_MASK macro
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Aksh Garg <a-garg7@ti.com>
CC: <linux-pci@vger.kernel.org>, <maz@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<danishanwar@ti.com>, <s-vadapalli@ti.com>
Date: Mon, 16 Feb 2026 17:44:44 +0530
In-Reply-To: <20260216120600.479738-1-a-garg7@ti.com>
References: <20260216120600.479738-1-a-garg7@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DM3PPFB0C5EC304:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7d29b0-9c5c-4ae3-741f-08de6d54c6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVFGRzlvWktNOFJlcEZZTmZYcFExTnpXMnhoUkQxSWwyVUY1cDRSYSt4N2pt?=
 =?utf-8?B?TXNzWkVhb2ZnczR4QmJCY1pRK21nTWQ5WjZGWDU2YmRWc1JzVnlPd0o2ZjZ0?=
 =?utf-8?B?QmVNcE1paFBuWjBBM05jZGFWWm9nMDhEdmNieGhnMDkzTFEyUWM2T1d1SWk2?=
 =?utf-8?B?ZHRSZGIyMS9JRUVsQ1E0Mm1haW1Ua2RsTWR6Snh4Vnp4cW1zMUtwbU5zT29a?=
 =?utf-8?B?anBkSmh4MTE5NUc0VzAvQStRSWtCZTIzL1FYREpTcWNMZHpXeTlpdmFiUWtW?=
 =?utf-8?B?Rkt3K0YyVUVPcGN1eGJvWXk4OU13L1c4Ky9uMDkrSXo1V3k4NWNHRHNKOVBD?=
 =?utf-8?B?dlMzYk1WbHpyQzkyVmJTQkdFblRUcUoyMkFMWmM0Lys1OXBETVQycGZFSGVW?=
 =?utf-8?B?MTZLR3cySzRzVHNqQVFBeitlajFNRHRmeGZDOVMxM1luZHY0ZmQrZ01hemI3?=
 =?utf-8?B?cjAxRUVjT0ZwcVVZQ0dsbGdhdno5RGhhUTRrNjhBUllhazE5b0VHWElUSk1w?=
 =?utf-8?B?dWRneHFhWnpnN1dLdWFDNkJDdkExWnR6U3Q3Wk8rS283ZlBjL25MbGkrbXVM?=
 =?utf-8?B?TnBmTXI0eTFSQWhacDFCd1lIRTlNbUJ0R0NMKzUxSXJCWWNYeUo0ZlBEUlNQ?=
 =?utf-8?B?QUQwNkN1SHhKQkZLdlAxMUZQQXdmMnZpS3hzN0ZxYkhPamI3ZCtjTE90Y25B?=
 =?utf-8?B?eVc0WUxiTFBDWHZvNmZtcHFOTm9PUE9uanBHd3gydWJzemJpL0QycGQxMHZJ?=
 =?utf-8?B?eHRFWFh5NTFIT2RMbFQ0ZTI4OXR1RjliK081TWt0a3RWZVhWc0hhQnU0Nkxz?=
 =?utf-8?B?WTBwKzcyNnNudUFWV0RiR3pVeUZuN1lKaWRTSnJNNlVDZitHQWtCYTgrVzF3?=
 =?utf-8?B?NnhSeW9kMU9OODRFcGwyOGVpT2w3UEhQb1dtZS9aRmJjUUpWTHVXdHFHWmhY?=
 =?utf-8?B?ckduWWNNbnVVak5ZbzNxNzA0bVJQUllUTkJLazlYQzR6bW9pTEpWZTNwNGxO?=
 =?utf-8?B?RVNoS3pmUEs1bDVzQTJGaDJnZGVBM25hR1NqV1BtVmJzYW5YM1pERERtdWtl?=
 =?utf-8?B?bTBHbVJydEo3RTRkV2dQU2hCNVBUQkpYaXNuT0FiOEsyZjlPY2F4djF5cDlI?=
 =?utf-8?B?YVVpMHcyVjdoZUgvMmovOEpQMEVLYVFCaTVuaVRqQkNONkgxTjRNVTY2aEc5?=
 =?utf-8?B?UXZ2OEpoakt6UEFkeC9sa0NvdDdHcFE3U0JNVUtYb0FtbnErak9xUThTblE0?=
 =?utf-8?B?K1pnQU5TZHBoR0QxeCtwREwvVktVWlY5UHdHWkt0L1pkM01uV2t1NDQ5SDRS?=
 =?utf-8?B?cFRVSndSL2lNZE9iSE04WkpucTd5N2MrZDVSQWtsWVNReFQ3aFNvVXFzLzBs?=
 =?utf-8?B?UDczNWQvVHM4MGl4ejVxV0xUS0lqWEd4Tlh4SlV1eUp0ZjI2d0x5T1FGSVhy?=
 =?utf-8?B?cHIxYmpTdi9tb3NpdkhWN3Ixa1QzSTRoQTBSY1Z3WC9iRmFILzVoVUtxaVZD?=
 =?utf-8?B?VjNPcWNndVZ2ZkY2V0xvWWYvalhEQ3BTbitpR0k0dWFpNlJGVGxka0p2OFlC?=
 =?utf-8?B?cnFTYThHUXdsZ2V4MzFhVVNhT0pQNk5NWXJMaFFHbHpubHA1emhldkw0VUZM?=
 =?utf-8?B?cHlPbDVYbTNhaG5NQWdoRTdXeVNCbSs0SWljYnpSTXRlSU4wK3FUbDJ4a09j?=
 =?utf-8?B?UG1hOVhzdFlaazZXalBrMjNDb0lvVTVEMjZ4SGVVVUxWbHJQS3Q2WXY3ZktU?=
 =?utf-8?B?enEzeXdjMWYveWhqdTJkT0ZNRUxnZEtGWjRnQlVCMkNITiszZW5teHVIM1Bl?=
 =?utf-8?B?dzlrd2dVbnVIekxmeFZBM0t5K2hYMlh3SkpYNjJ6U3VjYU9xaVZGTEo1ckc5?=
 =?utf-8?B?U2o5bUFoWWU2djhSNjNvQ3BFcHVpTnp1aUdBMi9UWHBBZGg5dG1IK0N3QlYv?=
 =?utf-8?B?ZHY2QjFYS3lhRWtjOWJmZ0JqQVZYU0VDbThoazZrNkFxcWxkRWVsVnJpWjlp?=
 =?utf-8?B?V095R0E2b25udllGTzc0UTdQOGdIcHBsZk8vektHZnBXTzltZkVia3VlTU54?=
 =?utf-8?B?YldCMGZzN3VSUUhDYTZ1OTVCSk9aTUxiNkRCSXVyTWhyeUduQW9uVSs0cEdY?=
 =?utf-8?B?RmdnbE1TU0tiYnZBVmZDUjM2VVBmQldiaVNyMjVoWjMzUk56NHdxQW1aNUZD?=
 =?utf-8?B?dm8veFkzdXRsSlJPbjRISUVmaVdISWlMdWNaSVo2a0djcFpaaWloVUV0dEVY?=
 =?utf-8?B?Q3A1Rm8wVGVxYi9aUzRvUkdEUTV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LtB4yOzhsMSZK7QaBB6/Vw0FejAZoThAQxk2v5s4D+YclT/63sRZzStb5l3PgzBJh0BErzH+SPEVvR7IOHX0KQmKueusmxc2DqSNkuEPNl1HRqgMNlxfHcK/XTKn4odMMpaGG+QAVn+N8jEt8yn8mnbaQ0lyzv1EO5jQbyj/Aof+8WoFQHoIzgd7qIeVDyXiqq3c/wKHgc3ERyNxmeL0MpZVGAVU13eP9m2eM9zY+WsIKw1kdbo18vvbYWqEgN3AcW1Po9hdLe42z2Q348yZVy6Ri4sYxP4l7MfuWOJUFBMxP1saBL0ylbodM25Sqo5RXebXy2SrOtnnuwTPAO/Hrt8ldgW+7joqwWKcCI+h/aRuxv37jBmfqe0XKg/5LiUyRrECTuYSFzs3+89KofZeMiWaIs0xUnDZUIpQliRM3fi8R6DXuhLSvCOnCpaCdcIX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:13:21.4255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7d29b0-9c5c-4ae3-741f-08de6d54c6f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0C5EC304

On Mon, 2026-02-16 at 17:36 +0530, Aksh Garg wrote:
> Routing ID (RID) is a 16-bit value composed of bus number and devfn.

nitpick: "Requester ID" might be a more appropriate description of BDF.

> Add a PCI_RID_MASK macro to eliminate the use of magic number 0xffff
> when masking for RIDs.
>=20
> This provides a standard way for drivers to extract RIDs without
> resorting to magic numbers.
>=20
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>  drivers/pci/controller/pcie-apple.c | 2 +-
>  include/linux/pci.h                 | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index 2d92fc79f6dd..6bf9fe102e2f 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -802,7 +802,7 @@ static void apple_pcie_disable_device(struct pci_host=
_bridge *bridge, struct pci
>  		u32 val;
> =20
>  		val =3D readl_relaxed(port_rid2sid_addr(port, idx));
> -		if ((val & 0xffff) =3D=3D rid) {
> +		if ((val & PCI_RID_MASK) =3D=3D rid) {
>  			apple_pcie_rid2sid_write(port, idx, 0);
>  			bitmap_release_region(port->sid_map, idx, 0);
>  			dev_dbg(&pdev->dev, "Released %x (%d)\n", val, idx);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..e3d9730121c8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -71,6 +71,7 @@
>  #define PCI_DEVID(bus, devfn)	((((u16)(bus)) << 8) | (devfn))
>  /* return bus from PCI devid =3D ((u16)bus_number) << 8) | devfn */
>  #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
> +#define PCI_RID_MASK	0xffff
> =20
>  /* pci_slot represents a physical slot */
>  struct pci_slot {

Regards,
Siddharth.
