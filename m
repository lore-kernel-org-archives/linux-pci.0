Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794988793;
	b=p6uNBJ5zK6sQeEK0j+5JDpM2yBSa5yViiApDQZc5kytbBf7d4uFrWkuGbAnYbbA7P9tz
	 HZ37csi+pN5MkLtJpAVkU5BuhkEbgjUwkNchT6c3yXl8tzNuLC7l0bhfoxUciY4Xsna2w
	 nglfnrCmG0UasyqqH2vVAWKRdMujqPfSt8oBSXtfdZzL+SCFku+A/bv3H0a0+wbvt6KY+
	 zETuAli5RH15fPeBshS2FK2GHd4oBP4mQy8XWCbBWQKnsQGphiGPOhFeh0PTbSfW5WA1R
	 +BfCj5dIRtDDJeLD5/vqBS4ZuCNnTWqec24kIII5U2XSE5B7+dcQ6fV95RwkNuI2nzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988793;
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
	bh=7jrBTvfYMSFLmvB9PpPNqSnu4yacu68qL0Z4kZNcb+k=;
	b=AR432FzkC71DQUq8IqQ6GBQ0GbNE6XivwQ0bmOLdU5h+MfgsKYXCpbeDHG2iBGOhPwWo
	 YhU0Z55oBQTedYFDVR+9NYV2dYL9tKVwLM3mFru35bl7O0jYeaPryzyHQj2GENhgRowxE
	 8p+wVzaxupEOg50yJcBqBr2Old51IRfCs4klK+vcndekkB9qKBnD8sy0J+26N8hyKqWXP
	 q6IIMkMQV3YXGBchd19kAycfnsd/PhKNmdaL8h34h2RbATMKF5QGMKVRMVIACOIkC/o8r
	 Fro4DRAQAekwBzLuxXYqOAQz83xydIJA53t76ESMXUDFjG+aSJHH9cMogMGv2whrNfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=IhInFr61;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.126
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020126.outbound.protection.outlook.com [52.101.229.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BD606A333;
	Wed, 18 Nov 2026 07:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172BD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=IhInFr61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6ZHPyAoeNxk50P9zMoG5c0s1jBWMdx7QpbNSItDs9+I/IiXo1/qHj/aKwmj/VXEAgq0I7d3rrgwRNd8MeSacyHtpqvL22zcT2j5e67qN5cHgvMEBZk4riuX30eJm1N4icNXoc3heEnmQ5QAt8Nyqls9UQh7IHpH6W3I5dfV7bqkzheoiNZa7u3ybD41Ih2x+ZbesyrZcqnmsQ0fV1Vdsgricsg9OaO1WAdWBgL7TpbksZDooMBS0uT1f9XadIuF5H9KWBZzVHQ9tXKI7V8DMS0VkRZIbbhUcl+a7X5u4l2sQJhBa2LIHe1eSCr+Qx+/HETgqALLGasdkaLOC+taYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jrBTvfYMSFLmvB9PpPNqSnu4yacu68qL0Z4kZNcb+k=;
 b=nIvlWzVySTiNsZ5IRE/baizOMGeCPzgFA0xU407Jtq465SoHK8J6vPkP0rQRONtTnN2TxtmJXSZq84Spu2SRxaht6yC4VVnbYx0/g1NZpKn03b42YpeYX4LZ2CrBBbpvwmT9fVEoGUgVuq2yo4OppPhrcTLw4S+Q2XsykLmVzcNqKmNKBbmZ+lxiYhHHnSC+/gdjUo8/kF4eEXDh9m8lxj0aG68Qs3v2jH/61qsSc204MuArU71KOJFSoyMseZJpKn8CQMmarqGrakQj7SyGuJJ6cx+ZXSj9ftYGbTBWyCRN4SN2Qu/JjTCLwEPGaFhkbXGQKYuCPsKR90r6Oq045Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jrBTvfYMSFLmvB9PpPNqSnu4yacu68qL0Z4kZNcb+k=;
 b=IhInFr61zZAazMaQNtEAD5TM4hhMf1e1ofj0dHji9QagjPLDOVqwBNNbArldmOoaVWQXfwzhp3QevayUiMd3Ga7LqPDlSLAVJhFc0lOPA5kfJ2ldxH3n6Ni5pkSdZcLBF78Nb2sP9pdYeXjEj3I5zg6Bov2eE1tMB/98+MDWINo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB7459.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:59:48 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:59:48 +0000
Date: Wed, 18 Nov 2026 16:59:46 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut <marek.vasut@mailbox.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Shawn Lin <Shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v5 13/17] PCI: rcar-gen4: Route Root Port AER to a
 virtual Root Port IRQ
Message-ID: <xrgklao4xvrzu7a2bkcbcx4ehxjpuqknyw5eeimqqahogvemzv@kwnm2kipdcjm>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-14-den@valinux.co.jp>
 <33e7f153-9dde-4bf7-8ab4-d128b256239a@mailbox.org>
 <dwgbyrulxrbiygjquuyd6cke4i43um7oio4fefey4lfgngwuoe@lkkn7ulwi3vj>
 <avRZanGRks2mtIw0@ninjato>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avRZanGRks2mtIw0@ninjato>
X-ClientProxiedBy: TYCP286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6be16c-5c10-46ec-ad68-08df4549ea83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|10070799003|6133799003|22082099003|18002099003|261009223027099003|56012099006|5023799004|10067099003|4143699003|261102123227099003|261021123027099003|261026140227099003|261026121527099003|261022075727099003|261026135527099003|261021135927099003|261028144727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	fh9W94c5YZd8Vtgd5yHnSuNJ9huUTR5pq9Y2Qz1/NgF51SZupQbR3x4VH5nhfkxR/O3lM3cLPOE2lO0gLA+rZI+jH6bjgKkaJlBufMmlIbmSLwuSAoHgU/jUlsZ13G4eECa5YqpTTYWnsk0s5iPY8iOz0HSc1qE49V40z6PMtABtBaRCJzwhhpl9qeFmX1lMd0uUc/0FK+TvWSUe/rtEoehsq5Hu+8C8SU2gEdXwMs95IqjMguPokMc7+nh1meSxKbkblracFRKckYLKoTnnNz7ouNH4VPglkvesdDV/UPdERvlBGYxQFzSCy2CP+ct5knWDGNKRruxyHoLFZm2SwbsTXRmEVNkfvKn4XzgDoX1UUfoeq9d7w/mi/C7WvojkwnpU/kpyAlAuO0dC9MQoXJHyORq7iBOkqUbCJpl/XqwbrKwhA1snIk+J3X2MAIFCP1vriMxzjXqpNwXP7R7Cir2FMUUx6Uehryv51rw+7G2LPTXSSO4QO9phedAX5Z27/ICxTXGluTRjhcBXs+WT4GOALaJYpuqDnXqERs3O0Sj2cfjwFyho8NUG/R1kJRIeAOVWrZTxvWHxzEVAzZcqukaaHkfIZszXauggtNHPHARqag08DxDq5xUL4tC0Km0t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(261009223027099003)(56012099006)(5023799004)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261026135527099003)(261021135927099003)(261028144727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOPDaNXU531W0zuaKdGi/QS56TIKIx/FL7LSH3+C/Zzil6KSSUok1cB5UH+y?=
 =?us-ascii?Q?bwy/+vRdlfykuDPVxJNKvogY6Z2wt8qpHA+LzJi56nNBcVKA6m7tcIfSlJ4N?=
 =?us-ascii?Q?ZCW3jEoesL5ypii3yKpplMyIHgfsUVht2GmpmlsE2WbDxq+4CY5XFNMyXh7X?=
 =?us-ascii?Q?JEqn1n5Eq8uBe+9qXFL73nr9tjtBo0fpOp9012XY0DzpZbzagLP9GC4Fxvmc?=
 =?us-ascii?Q?2i6opel5qAEbn3ikbTuwAhhgmiARem/bopbq1A++uzFP9ZO9GIjXmvzBbazK?=
 =?us-ascii?Q?IaF1+YVCWJzDn7fbJaItNNew72pCz2NRwhSpxt/Jepi/gLwwaUcIo+Qvhawr?=
 =?us-ascii?Q?hkZbHY+qF+r4zLLOao3iHJVk0glGLMnwWB4HQgK6P/GN9/BDrQ3fBoCk8iU4?=
 =?us-ascii?Q?qGtojAVOO4EP08JMTn3ndBbHPBajz/Cyiya75dFYe9ubQzy1VQ07tR1l6I2b?=
 =?us-ascii?Q?VhD2A1mwA3cYCNSxdiDOEbOzOgWf6tHeUHXDh4ICLgo+xFPDGU+1iu5cMken?=
 =?us-ascii?Q?ytl5xcbJknVa7cBlXdwGK0Ld4V3v3XsuKoS1qJpj7ihteANvlzZZ+2Kw5zEQ?=
 =?us-ascii?Q?8M2BkTrX1n+Bw4NBoz/g5XrpchpMrhS0GVc4BlpqLcrLgnmgRw8OwHJhfRPa?=
 =?us-ascii?Q?i6RM9vGISJ2uCvGJO2cu7rcNaA+f6OfykVpOxVu/xeP3GeNbQKSg4vEBF9At?=
 =?us-ascii?Q?gnMZoZ2ZJNcrDzCfuo90l+h3AtnEW1EWLAbhyk8f4VfPSK+EWg/VJMbA+/tg?=
 =?us-ascii?Q?hBLwfAmCeS4tQ7F6EG25bJIdTuMuuqT8fVZw3XbTLJxxPJySfJOhWwMZ2/cC?=
 =?us-ascii?Q?3rZDGx39/s/PY2Z5xUiFgCJclWN1M04ayvlcrn108vdBx1RtuQcIy95LZhyc?=
 =?us-ascii?Q?+ZnLIfWHcQ/Lrz+Ch8Whs801kPS2PgojRE+flOUkAK/PLfhvQHg0NnvS3ddq?=
 =?us-ascii?Q?MW4RfysBh0C0YBpgKpFF7aBBszuwRu2gCz+BuMVwofly/OGyM2TELIgL9nTi?=
 =?us-ascii?Q?G9zuOO2NgOO1T6Lj013tKa6YSZuntoLvF//lskrq6FuNIONVwg5bvg1a0jZ2?=
 =?us-ascii?Q?7WqziDY25YeT9b8qmUBujc55CNzoGymia8zU9CbknyD3wj9W7mPcOPrEQrOT?=
 =?us-ascii?Q?uvWxtTIgAB2Ass5US9Bo+o/2zkTkJmCIxv5riZYw2oseVJxBxCsiiOi8NY5J?=
 =?us-ascii?Q?2+M1LI2cRSw4jmOPEMtIpqti9Gwdlacwhwobev74L8WCacXVULzFKtdJK8Dy?=
 =?us-ascii?Q?vuyB01xWLG5DOuTYkFD7e0K7GSFvNQnHHqX/uS0BNlBTYoz4/j4HHT/VzoDF?=
 =?us-ascii?Q?ElYE9r0wL2VxuI8ohPQR7em62vJqYbMOhQjba+l9Ua0g/xgGmd3cewzh4ZIR?=
 =?us-ascii?Q?WY8l2ZN05nFgLYqxfOtRJNVmxGqrANMaFw8lcPnQFu9BHq8rQYtKk+z0GXl4?=
 =?us-ascii?Q?6wUzEbWjbpEtp21kHRm38tb2G6koa/S6pGd6K3st6eSv7NB04je35vDTI6Hf?=
 =?us-ascii?Q?A9nMcMz6FwpphCiTA8ovA0xIrumHXQd5vCYp8eO8rRwDYl/IA6kL8YP7a4rF?=
 =?us-ascii?Q?N2JheV3X7VzJmOwOadx4TJ87uSWfwsx5PwNU9j7KOAUxkJ01I3Wkdxyljrcj?=
 =?us-ascii?Q?zJyqab0Bfb/GI7n26ytaiJbc6B81VMM4Nt6IiJoehhRpJWpzFuAmr7Z77+8U?=
 =?us-ascii?Q?PFPayj+4RH/AWrkxHKvOfCmW30RtG0UQnYwgHr6quErus3Hu3yKW/xuoTMvf?=
 =?us-ascii?Q?MKSaGOp/AQWz1ciRmPAuoiDOnvEg5EtTrO8GFIukkO5TLTx8x1Id?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6be16c-5c10-46ec-ad68-08df4549ea83
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:59:48.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ouq2OKrO0FDuV35JlTaAPIH8ScYYJZ7Vwy7AcZjzUYlxrmNRhsz6RKEaNPdPN401e1aEcX0pbmKxrdolYZw1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7459

On Wed, Nov 11, 2026 at 01:02:50PM +0100, Wolfram Sang wrote:
> On Mon, Nov 09, 2026 at 11:41:52AM +0900, Koichiro Den wrote:
> > On Wed, Oct 21, 2026 at 02:19:46AM +0200, Marek Vasut wrote:
> > > On 10/20/26 5:10 AM, Koichiro Den wrote:
> > > > On R-Car Gen4 SoCs, the APP block exposes the Root Port interrupt
> > > > signals in PCIEINTSTS0 and routes them to platform IRQs: AER to
> > > > intreq_pcim_lperr, and PME and bandwidth notifications to
> > > > intreq_pcim_sub. On an R-Car S4 with GIC ITS, a link retrain set
> > > > LnkSta.LBMS and latched PCIEINTSTS0[23] (cfg_bw_mgt_msi), but the Root
> > > > Port's MSI never fired while endpoint MSIs worked fine. With iMSI-RX the
> > > > Root Port MSI capabilities are already hidden, but its INTx maps to
> > > > intreq_pcim_sub. Note that even before this driver took over the IRQ
> > > > with rcar_gen4_pcie_msi_irq_handler, the port service was unable to
> > > > request it, as the DWC core used that IRQ for its chained MSI handler.
> > > > In either case, iMSI-RX or an external MSI controller, Root Port
> > > > interrupts are not delivered to the port services.
> > > > 
> > > > Hide the Root Port MSI/MSI-X capabilities so the port services use
> > > > INTx regardless of the MSI controller. Do this in the R-Car host setup,
> > > > which also runs on reset and resume. Use a virtual IRQ to deliver
> > > > notifications from separate platform IRQs to the standard handlers.
> > > > Route AER from the optional "aer" interrupt. DTs without it remain
> > > > supported, but Root Port AER stays unavailable.
> > > > 
> > > > The APP block may still receive MSI-form notifications because hiding
> > > > the Root Port's MSI capabilities does not clear MSICAP0.MSIE. Handle
> > > > these alongside the INTx-form level signals. Clear the MSI-form latch
> > > > before the AER handler clears Root Error Status, so a late APP clear
> > > > does not erase a new notification.
> > > > 
> > > > Check for reset requests before dispatch: on S4, DBI accesses from
> > > > the port services can hang the host immediately after link down.
> > > > 
> > > > The next patch also feeds PME and bandwidth notifications from "msi"
> > > > into this IRQ, so both parents may dispatch concurrently.
> > > > handle_level_irq() calls irq_ack() before checking whether it can run
> > > > the handlers. Keep the APP latches set while the IRQ is in progress or
> > > > disabled, so the level parents can retry through the reset checks.
> > > > This avoids losing notifications without a raw lock around port
> > > > services that take regular spinlocks.
> > > > 
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > Changes since v4:
> > > >    - Hide the Root Port MSI/MSI-X capabilities in host_setup() instead of
> > > >      adding a no_rp_msi flag to the DWC core. (Shawn)
> > > >      https://lore.kernel.org/r/bi3rvyqpdu4iq6pfyrqvx7eplyim6gmg2ijal67mpateobmtlq@gec7zewfm76r/
> > > >      I did not carry Marek's Reviewed-by tag over due to the change.
> > > 
> > > Bjorn/Manivannan, can you please have a look at this patch and the MSI
> > > handling, to be sure this is OK ?
> > > 
> > > (no further comments from me below this point)
> > > 
> > > Thank you !
> > 
> > Marek, thanks for the review.
> > 
> > Bjorn/Mani, just a gentle ping. Could one of you take a look? To summarize:
> > 
> > - v4 had 'no_rp_msi' flag to the DWC core. Shawn suggested keeping that in the
> >   glue driver instead, which I found reasonable:
> >   https://lore.kernel.org/r/20261015033103.3076869-14-den@valinux.co.jp/
> > - v5 hides them in rcar_gen4_pcie_host_setup(). (this patch)
> > 
> > If you'd rather I send v6 first, rebased on the pp->msi_irq_domain rename Shawn
> > and Geert pointed out, please let me know. Otherwise I'll wait for your comments
> > before respinning.

    ^(a)

> 
> As maintainers are usually super-busy, is there another MSI expert we
> could ask to offload work from them?

Hi Wolfram,

Thanks for following up. I'm not sure who'd be best to ask for that, but maybe
Qiang? Given the history: f5cd8a929c82 -> 0ecd890e3cf54 -> 3a4e8302e72f8
Let me cc him here.

Qiang, sorry to take up your time, but I'd appreciate your thoughts on this:

  For context, R-Car S4 has a platform IRQ for Root Port AER. This patch hides
  the Root Port's MSI/MSI-X caps even with a GIC ITS and routes AER from that
  line to the port services via a virtual INTx IRQ.

  In v4 I used a 'no_rp_msi' flag in the core for this. Shawn suggested hiding
  the caps in the R-Car driver [1], which made sense to me, so that's what I did
  in v5. (Personally, I'm fine with keep_rp_msi_en in the core for i.MX since
  the core would otherwise hide the caps there.)

  Does this R-Car approach look reasonable to you?

FWIW,
- Since v1, the base tree has included 8d6af27c0a73 ("PCI: rcar-gen4: Configure
  AXIINTC if iMSI-RX is not used"), which might look relevant. With the caps
  left visible, Linux assigned the Root Port an ITS IRQ. Despite that, the IRQ
  count stayed at zero when I injected a correctable error.
- I wrote "appears to lack SII2MSI" in the cover letter because I couldn't find
  anything explicit in the S4 docs that clarifies whether it's present. That's
  about as far as I've got with this. IOW, there could still be some other reason.

I'd still like to hear from Mani or Bjorn before sending v6 (see (a) above).

[1] https://lore.kernel.org/r/3796136c-cc01-472b-b14c-34d140a10cbf@rock-chips.com/

Best regards,
Koichiro Den

> 
> I'd also like to have this series in the next merge window. Thanks
> everyone for all the work involved, so far!
> 


