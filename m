Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592017;
	b=Jeu/xagSzFk0unTf+3wmo0bA1vrt7NteL+x1IYahlEYZpGJgW6CoKFs/kPTrQzT4q51D
	 wGH5m/odtf6o73SUf3imnkvHJ5E21aMHa93LHfFePWJQ30TawWhGHZcPBDUImTHCgv8eS
	 BC6iWeWo+cgdS1WokRZrcFR0UhXRUKbbfNpKZT53TOT28kyM2R83/KkzeK1MqzxpQXJ0I
	 Af1NMCAMkBhoXP1F+CofRPk3iOgG5OhFebOpV0xHOwtmd6mHX/Sl4Jp2A9chL5QaL/M9a
	 OKVlUz8Damoclc2D4+jVztdnZRKCJqrDclyf7a3EfYU5vWQb952ov2g42/zRdUqQyKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592017;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Q4AcQuj6gDGkViZ/PYtRyeNDusm6GtQh57eijRafgSw=;
	b=x0UPCDS0PTVBTAdBV3Lgt6HTZMPiifhEJYVJFsayFs/lJOuNZpcV8uWCxgOz3qzxbm8S
	 VoiZ07yfOX7Xbzb0GtFTsPMLINFb2Jm75YNqkQ3FwZHP6/vtOOMwy5JrXi2a8X9CaCysB
	 nUHcZvcyDvcsoY4719YlglNTydKyzSas3B7H+3OxHoBRsuB4cVKTnKZA8CSR6ljK/fO6z
	 kDqm+pYeFTAZza7HxvVdaGuqgj+mt6ECmUU6XDAtHry+BLNV5R8JMR1tkNwVjKzCPr5YX
	 eGrmCeRiiETccnP315eBrzsBfUKZI8+I4PnCfNBvzeY/zxrlKUKob1HYy0vbVPiyqAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=sz3h+W8D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.78
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021078.outbound.protection.outlook.com [52.101.125.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AB606A319;
	Wed, 21 Oct 2026 14:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C86AB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=sz3h+W8D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g//T2gH/fEBHTb1H4uu+cNQHT0hqAnBwLsuDUStCxYOX6fHQZYVVQgYVfLjey5/Y0icTzi4RO4WZgOoAET651MiS6VeYOeIeFmBc3gvFxdfZfGIaJhH+TlRkGmK6TxHJB5q2BeCaN3LKfm9epkKy4nMRUH/d4y/TaObmGNu/SdV0MbFYVp7ddgMSxmGy/GMRgqr5sthYxv4PTdxeRRb6MhUu4mqrsDn/XlpmX/CAqZbP41NM0Wsz4MCr6kWruordwd1yA1mkoV0AQ1opF09IEcI7W7Dhg0ZKhcVIWvM13bs+YA8MgQr35sFF+Dk5gjfct4ljjndm6BmjPQKF7kngxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4AcQuj6gDGkViZ/PYtRyeNDusm6GtQh57eijRafgSw=;
 b=TN8XX6sPcsuzAxpM9eck4TqQr8HHeBzFhWhXY3FAvO52ro3X/vV6QdQU+yGfFcuwKoR4CVyz32QqUudLXR9r900KI0un5Pp17dieiU0uWFYd/czzLPI4+/8P2CTU35/MoUbhpQWPTk1BNoeX7vpANf7FR2vrtXu76zdIv0wz6vPLurHKK5UJYBREIii+F2TtIIT1tMLHfrvMo+EgpMHZUiucusRgauCqy0c+fb2mK8QcqVAzLA/uEm1xQ7y2yzvImBOrm7l4muhYT/38tQziQsLWTNetIrbsua/9DgKPPNoPWENv3H0slCzJ6G/DXcp5asEChtZm3u3yd8VnKj4jPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4AcQuj6gDGkViZ/PYtRyeNDusm6GtQh57eijRafgSw=;
 b=sz3h+W8DIBtnyDh5/zl7iVxTcNTMHNgI6VT0/OlZEsFvz1ZcUOx3QAhubdChajaj8Yo9mBm//IJGJwHsj0NMWVg4j7ONfb3djIW7bMegYqkpC0T2j/zJ+QwGFIeeKngK/r+xM8lV3njG2veTGiBelFOHnCYfig96GYPvyB/4xIA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7873.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:46a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:13:32 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:13:32 +0000
Date: Wed, 21 Oct 2026 23:13:30 +0900
From: Koichiro Den <den@valinux.co.jp>
To: linux-pci@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v14 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <4widgkxchtmhp5erxg7kgag2adkxankg2bhnf46tg6s6ut7qdn@n5xhmlksgc2l>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9a0e8e-7a72-4a49-c235-08df2f7d7ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|10070799003|7416014|366016|56012099006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	l/IQrqyVZwH84/gIH5qH4YcBRbho4jQgQlT6xLlH9NPH1doBWbqmEC5D64OlBNHWsHqvFxWXSWcp/SqXpMPzmvn8Aro5PkUpYvUqAnVVpNFHJOIEl/6cQC2dmhWcOR8YaN6yPJEJG2G/xk/VAOi+2jJYZFlMiqq1ynrNddV9cZQhagroMDzVnXKR8yCZctP2lhJVCcrpjEuRePMfGMVbn9vQZk83y1TxI3AGyO5SFeZ1beByzM8iqPT2uWLGWbF9v9K8qiFNR+4iV8y5YQq22SgfghMnJSBepB9+n9pd5ZHzZuYbee8dXIeqSgFWGR0sgpeF9Mg1VWYUv6PfkaNvD6qVB86k5IPxGZ7DVR/tsms6CDJA9zaLK14ayFiKFzFLzscF0deyiP3n2HJwrA1flE6VTgBmbcfZ9F9peAg4+DDqN1gT9pn6TywbBJ79H9Fich3fE1ojAX5ZMufHeEwvwDsTK2GoQRoafwSZe9vTNcaqX8gygSyAXgmQgJJLFh0hMkPhDM+VwWx1d/N3y+QO+/s9cc291k7hGoCdNBNxh/EYMkCZyJwZvilP8hf8j0DbScVTY7FUWNmk45Kh2msddJMtZ7s9mzmtMTyvUd2IUEZsHulxiUUjy5K+TjHxG+bF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(7416014)(366016)(56012099006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Azv15hc7GRP/eZwitfoEURYnZsoIFdV3cCcsT7JWURd//tRMh8rbi00lNMea?=
 =?us-ascii?Q?Zk+0/JXULWqDH1X+Vok+td0Bc747fAs2KrSatKlT7Z1xk6eP/FH0pwwNjemJ?=
 =?us-ascii?Q?UDCRIbehXoXPusSMgz4TVcmzSXZ7tsv3kNvqR90XraOv9/4G7Td4MDt/kcT0?=
 =?us-ascii?Q?mBfRdh4A/nnCsVDDFwd2vdMpgVHfjC/bjFe5rxmQhpgB9cR6/SSN60yeB2B7?=
 =?us-ascii?Q?pO0eWFnkYu8vtsh4rlx1QhXo3io7Jjc3DqqR8UAi3Ucnzb+9ZMtNEEO1XTHy?=
 =?us-ascii?Q?NlMLFHMekTjsTAvth/eBhHCpJB3LE9+PsV0pFua5ClBI14amiUwdDk6XYLMN?=
 =?us-ascii?Q?kxIpP0/0Mgoj8aiLHZT+LnbN/miXZfsGFgx3j/wPkgpowXqrzd1Jd16HJbRi?=
 =?us-ascii?Q?pH81zj/xWh1DV0oXM66enO+i/AMHX9QkseXhmK8Wg1sTHVp2dGpWdIVngHdM?=
 =?us-ascii?Q?w4vr2K6KGS2o9QWXSau7PfTqofKlAo8VqoAGZE3dA0r8GpCtbYxHepzW7Svh?=
 =?us-ascii?Q?QXmiS0XTL6Z0NB8c8Bc1+Gw6JOhQgcVWa7U8p97f2CnFCn+HjTPjOOWhKpD/?=
 =?us-ascii?Q?T3M+LHhM/Qg3D5f3bT1dPdJgaPq+ToTTykt8dz9V9/k4x23LCn5gzBFJDxUq?=
 =?us-ascii?Q?DaTY1rYQwEgKw4CB++VDPL7u1cYhk8SVs8z3DbpaE4dyzGqJF6iwhamIOLTn?=
 =?us-ascii?Q?F+l3Pz54p6Y9xAQBYy7KdT83UO9gq/dmPv/+Sj/AzE+S1lCrJyFei3BHlpo4?=
 =?us-ascii?Q?84d+No/iZvaygWKlKrILaaUQk+ULLBaXC7mKlYhG/skaCudY3PCgVT1utpyB?=
 =?us-ascii?Q?DMFBctupwYgb3ckSQe7xhWM4vZg1jTP3eeJbUwBvSCwAdvyTw5fTDXpCx1bk?=
 =?us-ascii?Q?/3qamzC4BYpRoz7NVVPBEkKcDG2X+YNSh6OyH675x680S60CoawQwJlAvqww?=
 =?us-ascii?Q?fhk4vvkLNRx5G132QjNWGVi3FPlw/9pnqYWjVTbVWSmlmVxGnvM9FyeXR6bl?=
 =?us-ascii?Q?1GumomQjPvnPn3LL2pzn/V3FI5HMLlJk1rQDPFbLggiYaarvKr3rpPsmZCcL?=
 =?us-ascii?Q?jhscN8b/JofLdG7vW0UUnHHHLvS3oQyTILQFwMGh88ajkbP6odT5nK6X6OcO?=
 =?us-ascii?Q?67iVq5YWsRsp0myFVyZPnNx/M0wPAiU13bM547j68WSKzAxuj3wmAqlagaBm?=
 =?us-ascii?Q?TJ5RKL3DWE+oNHglKX6nFoD87xkA36WKulHIdlKxcVLNpeAFBFAS+Y3N8ilq?=
 =?us-ascii?Q?ZPVpiTcTxZb0pdhRrVERgsQ8hGu8tFzU0oLvWecI0Xp0MkQiea9Um84qp1ay?=
 =?us-ascii?Q?cfpNOJi5HA4Ic5Bm1zxyMxYQGrd7KJ5UmcFBPdCoMLoXwBEoP66Hv8Y9xI1a?=
 =?us-ascii?Q?g/wra7wpfBY6Ai2qqrQvnzURZ9gYYA0uHnwSmPTYR7UbbfMpxcQbKVQGitj9?=
 =?us-ascii?Q?4mCHkypDRxOWfkLi9PEf2yLXHJuQbq4sx47DoN9XSgjUlbozhofh4fAKO/HV?=
 =?us-ascii?Q?vQHyQk8YNeuV3uCnorFSu3e3lpNfXz4NSc5OG5pqLRcaDDbBLu3aRSj35hc4?=
 =?us-ascii?Q?HrQQ45ARswcunA96SzNk6Y6rzsSf56IRGDwGLGjbjiTsDSbvgVZKBhaTCLfM?=
 =?us-ascii?Q?ItqTwNoqckZiY9azLCm9m+F2UtVIbSot+ogYE+eI1KDbPgnJqsxB/g4BoTD0?=
 =?us-ascii?Q?G/9mvjRuwvySaLvA3KUIsCDNq8K/fDip14+YvN6GSgT8Bjdim/SIhRFPvBIK?=
 =?us-ascii?Q?XirQYLwzfpHqtlhm0f6WZtBfX/UPgmYiedFARcnCdYGryON+NHRz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9a0e8e-7a72-4a49-c235-08df2f7d7ccf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:13:32.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ppeogs67JK4YlVuVfqAMAKGvDBDgQKN0nNofvzAWeJK7sstZALGbgmyMhgOZSeKPksSSr2nxsey4GLtcPPbe8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7873

On Tue, Apr 14, 2026 at 11:15:07PM +0900, Koichiro Den wrote:
> Hi,
> 
> Some endpoint platforms cannot use a GIC ITS-backed MSI domain for
> EP-side doorbells.

(Mostly thinking out loud for the record:)

My primary interest here was R-Car S4 (again). At the time, I didn't understand
why the doorbell writes weren't reaching the ITS. While looking through
pcie-rcar-gen4.c for other work, I happened to find that the driver just
doesn't program AXIINTCADDR/AXIINTCCONT in endpoint mode. Just leaving a note
here for the record.

With those registers programmed and msi-map selecting Device ID 0, ITS-backed
doorbells work in my S4-to-S4 setup (I've tested this).

That said, I think the embedded doorbell fallback is still useful on R-Car S4
(and IIRC, RK3588). The R-Car S4 Series User's Manual (R19UH0161EJ0130 Rev.1.30)
says in section 104.3.24, "MSI-X by INTC":

    [...], the PCIe controller overwrite the BDF(RequesterID) in WDATA[47:32]
    of AXI bus and notifies the INTC in AXI bus.

If this description also applies in endpoint mode, the ITS DeviceID directly
depends on the host's RID, which might vary between hosts. I haven't found a
documented way to remap that RID (to some fixed Device ID) on S4, so I cannot
yet say for sure that the ITS path will work with arbitrary hosts. The situation
seems similar to RK3588 in this respect. So for now, I'll hold off on submitting
the patch to program AXIINTCADDR/AXIINTCCONT in S4 endpoint mode.

My bigger concern is that HDMA seems to be getting more common, while the
revisions I've checked lack this interrupt emulation mechanism, as I noted here:
https://lore.kernel.org/r/sx5lh6keh27nxq4vmdr7vj5dzb6v7pl5mbj4yaq6v4mkjo732k@xfrncjywnjz4/

Best regards,
Koichiro Den

> In those cases, endpoint function (EPF) drivers
> cannot provide a doorbell to the root complex (RC), and features such as
> vNTB may fall back to polling with significantly higher latency.
> 
> This series adds an alternate doorbell backend based on the PCIe
> endpoint controller (EPC)'s integrated eDMA interrupt-emulation feature.
> The RC rings the doorbell by doing a single 32-bit MMIO write to an eDMA
> doorbell location exposed in a BAR window. The EP side receives a Linux
> IRQ that EPF drivers can use as a doorbell interrupt, without relying on
> MSI message writes reaching the ITS.
> 
> The DesignWare eDMA interrupt-emulation doorbell is wired up as one user
> of the generic EPC aux-resource API. Other vendors can support their
> MMIO-based doorbells by implementing the EPC aux-resource callbacks:
> pci_epc_ops.get_aux_resources_count() / pci_epc_ops.get_aux_resources().
> 
> 
> Dependencies
> ============
> 
> (1). [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
>      https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/
>      Note: already landed in dmaengine/next.
> 
> 
> Tested on
> =========
> 
> v14 re-tested on:
> 
>   (1). R-Car S4 Spider: EP <-> RC
>   (2). RK3588 Rock 5B (EP) <-> CIX CD8180 Orion O6 (RC)
> 
> The EP in both scenarios prints the following in dmesg when running
> DOORBELL_TEST:
> 
>   pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
>   pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> 
> With this series applied, the DOORBELL_TEST succeeds:
> 
>   $ ./pci_endpoint_test -t DOORBELL_TEST
>   TAP version 13
>   1..1
>   # Starting 1 tests from 1 test cases.
>   #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
>   #            OK  pcie_ep_doorbell.DOORBELL_TEST
>   ok 1 pcie_ep_doorbell.DOORBELL_TEST
>   # PASSED: 1 / 1 tests passed.
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> IOMMU coverage tested:
> 
>   On R-Car S4 Spider EP, DOORBELL_TEST passes with the EP IOMMU both
>   enabled and disabled.
>   On Rock 5B EP, DOORBELL_TEST passes with the EP IOMMU disabled. The
>   enabled case is not applicable, as the EP IOMMU is explicitly disabled
>   upstream on this platform.
> 
> 
> Performance test: vNTB ping latency
> ===================================
> 
> (*) Re-tested with v14 only to confirm that no regression was introduced
>     in v13->v14. No performance difference is expected.
> 
> Prerequisite:
>   To test on 2x R-Car S4 Spider boards, the following two commits are
>   needed:
>   - 13f55a7ca773 ("PCI: dwc: rcar-gen4: Change EPC BAR alignment to 4K as
>                    per the documentation")
>   - f761e0deb4d9 ("PCI: dwc: rcar-gen4: Mark BAR0 and BAR2 as Resizable
>                    BARs in endpoint mode")
>   Note: these already landed in pci/controller/dwc-rcar-gen4-ep.
> 
> Setup:
>   - configfs (R-Car S4 Spider in EP mode):
> 
>       cd /sys/kernel/config/pci_ep/
>       mkdir functions/pci_epf_vntb/func1
>       echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
>       echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
>       echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
>       echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
>       echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
>       echo 1 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
>       echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
>       echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
>       echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
>       echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
>       echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
>       echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
>       echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
>       ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
>       echo 1 > controllers/e65d0000.pcie-ep/start
> 
>   - ensure ntb_transport/ntb_netdev are loaded on both sides
> 
> Results:
> 
>   - Without this series (pci/endpoint)
> 
>     $ ping -c 10 10.0.0.11
>     PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
>     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.1 ms
>     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.17 ms
>     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=12.2 ms
>     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=6.10 ms
>     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=12.1 ms
>     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=9.96 ms
>     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=4.04 ms
>     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=10.2 ms
>     64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=4.13 ms
>     64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=10.0 ms
> 
>   - With this series (on top of pci/endpoint + Dependency (1))
> 
>     $ ping -c 10 10.0.0.11
>     PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
>     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=0.828 ms
>     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.822 ms
>     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.848 ms
>     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.869 ms
>     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.775 ms
>     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.889 ms
>     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.893 ms
>     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.964 ms
>     64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.890 ms
>     64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=1.08 ms
> 
> 
> ---
> 
> Changelog
> ---------
> 
> * v13->v14 changes:
>   - Rebased onto the current pci/endpoint:
>     1d3225cb5d82 ("selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC")
>   - Dropped -EOPNOTSUPP to -ENODEV conversions.
>   - Fixed whitespace and alignment issues reported by checkpatch.pl.
> 
> * v12->v13 changes:
>   - Rebased onto the current pci/endpoint:
>     5ab7a225888b ("misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table entries")
>   - Renamed pci_epc_count_aux_resources() to
>     pci_epc_get_aux_resources_count() and have it return the count directly.
> 
> * v11->v12 changes:
>   - Rebased onto the current pci/endpoint:
>     185596ad93f5 ("PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()")
>   - Split the EPC auxiliary-resource API into
>     pci_epc_count_aux_resources() and pci_epc_get_aux_resources(), both
>     returning 0 on success.
>   - Added the corresponding count/get callbacks in pci_epc_ops and in the
>     DesignWare EPC provider.
>   - Updated the embedded doorbell fallback to use the new count/get
>     helpers.
>   - Stopped warning on duplicate DOORBELL_MMIO resources for now; use the
>     first matching resource and add a TODO for future multi-resource
>     support.
> 
> * v10->v11 changes:
>   - Rebased onto the current pci/endpoint:
>     e022f0c72c7f ("selftests: pci_endpoint: Skip reserved BARs")
>   - Dropped PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_CHAN_DESC from
>     this series; they will be added later together with their first real
>     consumer.
>   - Picked up tags from Frank and Niklas for patches 5/6/7.
>   - Dropped tags for patches 1 and 3 due to code changes.
>   - Revised the commit message of Patch 2 to better explain the purpose.
> 
> * v9->v10 changes:
>   - Patch 7/7: report the dma_map_resource() DMA address instead of the
>     raw physical address, so EPF drivers do not need to perform any
>     additional IOMMU mapping and the semantics match the MSI doorbell
>     case.
>   - Rebased onto the latest pci/endpoint, and updated dependency references.
>   - Re-ran functional tests and vNTB ping-latency measurements, and added
>     Rock 5B (EP) <-> Orion O6 (RC) to the test matrix.
> 
> * v8->v9 changes:
>   - Add a new dependency series (3), which moved the BAR reserved-subregion
>     framework + the RK3588 BAR4 example out of v8 (dropping the corresponding
>     patches from this series).
>   - pci-epf-vntb: rename the duplicate-IRQ helper and invert the return value,
>     per Frank's review.
>   - pci-epf-test: drop the extra size_add() doorbell-offset check, per Niklas'
>     review.
>   - pci-ep-msi: add a DWORD alignment check for DOORBELL_MMIO, per Niklas's
>     review.
>   - Carry over Reviewed-by tags for unchanged patches + drop Reviewed-by tags
>     where code changed.
>   - Rename the last patch subject (drop 'eDMA' word).
> 
> * v7->v8 changes:
>   - Deduplicate request_irq()/free_irq() calls based on virq (shared
>     IRQ) rather than doorbell type, as suggested during review of v7
>     Patch #7.
>   - Clean up the pci_epf_alloc_doorbell() error path, as suggested
>     during review of v7 Patch #9.
>   - Use range_end_overflows_t() instead of an open-coded overflow check,
>     following discussion during review of v7 Patch #5.
>   - Add a write-data field to the DOORBELL_MMIO aux-resource metadata
>     and plumb it through to the embedded doorbell backend (DesignWare
>     uses data=0).
> 
> * v6->v7 changes:
>   - Split out preparatory patches to keep the series below 10 patches.
>   - Add support for platforms where the eDMA register block is fixed
>     within a reserved BAR window (e.g. RK3588 BAR4) and must be reused
>     as-is.
>   - Introduce a dedicated virtual IRQ and irq_chip (using
>     handle_level_irq) for interrupt-emulation doorbells instead of
>     reusing per-channel IRQs. This avoids delivery via different IRQs on
>     platforms with chip->nr_irqs > 1.
> 
> * v5->v6 changes:
>   - Fix a double-free in v5 Patch 8/8 caused by mixing __free(kfree) with
>     an explicit kfree(). This is a functional bug (detectable by KASAN),
>     hence the respin solely for this fix. Sorry for the noise. No other
>     changes.
> 
> * v4->v5 changes:
>   - Change the series subject now that the series has evolved into a
>     consumer-driven set focused on the embedded doorbell fallback and its
>     in-tree users (epf-test and epf-vntb).
>   - Drop [PATCH v4 01/09] (dw-edma per-channel interrupt routing control)
>     from this series for now, so the series focuses on what's needed by the
>     current consumer (i.e. the doorbell fallback implementation).
>   - Replace the v4 embedded-doorbell "test variant + host/kselftest
>     plumbing" with a generic embedded-doorbell fallback in
>     pci_epf_alloc_doorbell(), including exposing required IRQ request flags
>     to EPF drivers.
>   - Two preparatory fix patches (Patch 6/8 and 7/8) to clean up error
>     handling and state management ahead of Patch 8/8.
>   - Rename *_get_remote_resource() to *_get_aux_resources() and adjust
>     relevant variable namings and kernel docs. Discussion may continue.
>   - Rework dw-edma per-channel metadata exposure to cache the needed info
>     in dw_edma_chip (IRQ number + emulation doorbell offset) and consume it
>     from the DesignWare EPC auxiliary resource provider without calling back
>     to dw-edma.
> 
> * v3->v4 changes:
>   - Drop dma_slave_caps.hw_id and the dmaengine selfirq callback
>     registration API. Instead, add a dw-edma specific dw_edma_chan_info()
>     helper and extend the EPC remote resource metadata accordingly.
>   - Add explicit acking for eDMA interrupt emulation and adjust the
>     dw-edma IRQ path for embedded-doorbell usage.
>   - Replace the previous EPC API smoke test with an embedded doorbell
>     test variant (pci-epf-test + pci_endpoint_test/selftests).
>   - Rebase onto pci.git controller/dwc commit 43d324eeb08c.
> 
> * v2->v3 changes:
>   - Replace DWC-specific helpers with a generic EPC remote resource query API.
>   - Add pci-epf-test smoke test and host/kselftest support for the new API.
>   - Drop the dw-edma-specific notify-only channel and polling approach
>     ([PATCH v2 4/7] and [PATCH v2 5/7]), and rework notification handling
>     around a generic dmaengine_(un)register_selfirq() API implemented
>     by dw-edma.
> 
> * v1->v2 changes:
>   - Combine the two previously posted series into a single set (per Frank's
>     suggestion). Order dmaengine/dw-edma patches first so hw_id support
>     lands before the PCI LL-region helper, which assumes
>     dma_slave_caps.hw_id availability.
> 
> v13: https://lore.kernel.org/linux-pci/20260406155717.880246-1-den@valinux.co.jp/
> v12: https://lore.kernel.org/linux-pci/20260327035422.4020455-1-den@valinux.co.jp/
> v11: https://lore.kernel.org/linux-pci/20260324083728.3744734-1-den@valinux.co.jp/
> v10: https://lore.kernel.org/linux-pci/20260302071427.534158-1-den@valinux.co.jp/
> v9: https://lore.kernel.org/linux-pci/20260219081318.4156901-1-den@valinux.co.jp/
> v8: https://lore.kernel.org/linux-pci/20260217080601.3808847-1-den@valinux.co.jp/
> v7: https://lore.kernel.org/linux-pci/20260215163847.3522572-1-den@valinux.co.jp/
> v6: https://lore.kernel.org/all/20260209125316.2132589-1-den@valinux.co.jp/
> v5: https://lore.kernel.org/all/20260209062952.2049053-1-den@valinux.co.jp/
> v4: https://lore.kernel.org/all/20260206172646.1556847-1-den@valinux.co.jp/
> v3: https://lore.kernel.org/all/20260204145440.950609-1-den@valinux.co.jp/
> v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
> v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
>     +
>     https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/
> 
> Best regards,
> Koichiro
> 
> 
> Koichiro Den (7):
>   PCI: endpoint: Add auxiliary resource query API
>   PCI: dwc: Record integrated eDMA register window
>   PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource
>     API
>   PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new
>     backends
>   PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
>   PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
>   PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 119 ++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.c  |   4 +
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  drivers/pci/endpoint/functions/pci-epf-test.c |  84 +++++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  61 +++++-
>  drivers/pci/endpoint/pci-ep-msi.c             | 179 ++++++++++++++++--
>  drivers/pci/endpoint/pci-epc-core.c           |  80 ++++++++
>  include/linux/pci-epc.h                       |  54 ++++++
>  include/linux/pci-epf.h                       |  31 ++-
>  9 files changed, 567 insertions(+), 47 deletions(-)
> 
> -- 
> 2.51.0
> 
