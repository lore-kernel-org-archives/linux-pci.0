Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597967;
	b=3SAd/VoFOSH1mHxc7i41ElpgNCw37qbnD1VCV98QOE6/ydzg6qaokBDMjRS3pA7RLlhf
	 O0LO1by3TfxcBBZA7GRnj27syIlwBGbYKW5rk9sAjoBGtnm9zlMXhzgM4gTEvuRtZG+Bz
	 kJ2VT4VROYPDnS+d6IZtuzDXGl74JDTTNujHDz7URAd12Oxvez/mgoQfPh5ow33P3/wN5
	 f1X3G6peif6oxc6NfCDw05wNgr+MTIoeFF8PIfQtTpgGno77aBkLZ9Cg57GucVMnsgL8U
	 ZkNoxtjwQRuozhPo/BNzAeLYF0lo/sfuikiOyOWPE8DrNCQkqW75DeOT4jQ35AKqSlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597967;
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
	bh=02+wEQdgLTW3eZZVhrqDjV7jFC3sPSN4njyhJZ/cxHI=;
	b=rXX9HFsdDU6urr2opokTcdRYbcuLirUdWaKkHzJZI6qpbxyNtrWKoniDdG6AiMCtkBOF
	 w+Jzpgs7bHLM5CgWG8iq2poZPGWGi7kYSgeiu+p9ytxwADidMKVRU0T2hXVTBcPXInKCh
	 m3aB0mvQ2EIazEqXYR5hdZKEDZi+fHumTSza4Ew+k403fhymbUWXLlZfw0+5Unj4zYz4c
	 n+pZWh0v5VTKPzl3SpzD/RdkRaq9r8AuzqPFFCjiw5ZBEMKC+XYuvhc90NiMMMdkHKTse
	 6M9iAN/1/hBktxMZsTq3ZX1dIK6gB8Jzvg3s533qVp9qutkB4e5COVfIFRax7qWgdvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iFJkUEAE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.30
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FA606A31B;
	Wed, 21 Oct 2026 15:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5FA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iFJkUEAE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqwfXfqg+kn1j41STUDyPFElhmX4dPon+ex75R5CIPv/k9TS8HIxBa+Olt+XpAZqVsliE47OG7oJ2k2CbLQRcQydJNvY3Cwt0Cmrj2itFNjGAUeDVx4J5ML1MntI2rjIZz3+pJvJSGhiwHkzBbsuhH50M8Sdd8sNWi/HR2ye7sr07Rs2153IDwRAFxYKnDizToI+Zw2HA2IaWnSueOnXXgwSbEMBejez3yh1kJ/AQR1IIFMCUsYQdW0RFjScZ832nHKN/P8qT0YgOMS6wAFeVZuJYeiisDaoZknDm+rOZ0l5n7MpH4kiLRDagWTNYlRSZywZSeXHUmCb1HoUFfKPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02+wEQdgLTW3eZZVhrqDjV7jFC3sPSN4njyhJZ/cxHI=;
 b=SAWnDkjfAw0G1XyxxP2XcMygI2/ECT2afUSRIdRYc5CQqyDqXpZAd7JBMUx03JmeOLd6FevRc3HApPvq+XlK4qgQRftc6VGVDhyUxUHuRri8LaSOCDHYJgSlB1Sj9+3lGn8V/6+NCtnFUO9XYNYZow/iGyaZEcZM0XXIasQDjlbT+pkjiD1aJOE5zTPpYS5NIgRKEE0GFJLvHWF0CeQpxsnjlb6pMQzCBx0/TEABua0+HkjlffDa1I0x0zBaeUanl7GafyNzLcOCPnypySSH0AvYdhs004L89DmJq8UncDiKjDSHBPut4CAkelicvcYo19bFxO2e4a21O+AO3TMipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02+wEQdgLTW3eZZVhrqDjV7jFC3sPSN4njyhJZ/cxHI=;
 b=iFJkUEAEko+FLHb3VcapuA0+39NdkosjDizWY+/QVb9bVbSF/SLAY/fNK3GAPHi5G9hLtYmvtfu5Q0NCTOBrYpsr2X9Z1G9h4HVUTYYON3vcfRSrRY4VSpiSYQAy5gS6Ep8T1kglQsJvjn4LsOJm0r6BwdpWDlIofZaDV8CtlpWkpNNxkgjwYDajeVbPb80PO4K2vhchL4VoFN8c2ZNdm4BIs5Cuam/LDEbYO2U3t2LIBfw20gjYT2ffY6XdFevEy92LiBy/OlcEC32XIKeeAv0WeitXybTs3mYR0EVhfzRqXj8Aw5Xu3/GI5efVQy8AhTCKck+kMyLPkcHgQmzz3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:52:43 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:52:43 +0000
Date: Wed, 21 Oct 2026 10:52:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Message-ID: <atjfwC1LTX3L6ncV@SMW015318>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021042229.2280937-7-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:510:23c::29) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c744935-2ce1-4c67-6ee4-08df2f8b57ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|19092799006|11063799006|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2JMk89tymaRku67/qkAhYtZEz34a9ClnQgH69LuoV8XRInyE5xknoVqWLIVEB0qrekrqkAU4wE5I9Um1JG6EplGalRdqzrj4/FgQrOUIpjkFw6axrmwwkVpi9I5wLTzUkF7jQCKzk7HsdnMz684mltkQfXOOSpeHFM2vposOe3rwibgBP6zJX46RHW7khJUDR3EqSPjrt3+3CbPBzjC1hV8sgcMIg4cP907k/w2eESEupW2O5Qhcio5neGLfvl8ieDGOkO7aqftG2H9RvWhlIxBEdwzH3y5Bm91gTiF4rnT4YcJFMFSfilpmsrNqC2zIRe7SirW8TPbeKzisxEYQi8nweN4KbDlflIvsDaGn53v+1aVKuQ8r0+D9iL2Ss6nwFzgqBRYRsotn4jinuqQEjMMBtXn1eTlxOtkI8era7w7l0cvX8TjgRao3FShnS/EQRxEEX3TLZL6uYlzb3eH/RAlx91K/8c8VuaOnMpswSbAUFzyY4bKLJwFMYygMDI0T4Z1SFskepGWydPWutzW0xFYkjhtEFS+F0t+W5TQxdpOytglSOW+y+7U2lZpTQYyAlX1lIcbswKdcrFalbXAYGQkNZ8y8xjkPFBK8lm+ToZlm2W6MXY6J6XDK+TiZaqta6FOEq1leVUDFuM/6IAijPUbVtigohUAbbDbMjqKjwqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(19092799006)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a41vRcryG7kSgX3wAnHUXNs6kiZRDTK2drHgTwHV4YOMGubbIao17HZAfw+8?=
 =?us-ascii?Q?6Yzpp8oEnlXwSifGgYafI1DYRX6vpH6vl0odC/baKUYv3mcJRnkbDXNFeIXt?=
 =?us-ascii?Q?BcUVwU/7A9Zyg8GWXSYWBOvEcvaEX+8jhJNhVNpPTyS1l+2ZeJu/9otdOxat?=
 =?us-ascii?Q?An0o29MARTAg/kX1nIo3p65726q3W78vgr4Fj349xmHs7sDF7svOXlhrG6jU?=
 =?us-ascii?Q?/qibklk7anbxcPHvYmnFGph/x6sY9Jf2kO0cMVu/c2uvzHxD350wWTWdhf/N?=
 =?us-ascii?Q?XN5PuwgNNSIgqS1V3s0epJL4wdfItybtE7LsR5+tlnKTZRSloGL2UqGDhOGU?=
 =?us-ascii?Q?4iIE3iNbRqcZtbnQPaf4kXg8aKrpZFdh045luq8RRwUgRbzb2OSFjpZwrxg/?=
 =?us-ascii?Q?a3mWXAfuky+NVbxxUStBVGQ3qIzAPplTEYrguDzH2JiZ3y/M8li87wfc5XNq?=
 =?us-ascii?Q?KgLJ3KJKRmI6k0qIgK5BY34XSyYgTCsmLQL6Flnx4tui9v8PZ2KMS//21zmg?=
 =?us-ascii?Q?mM9IffqoeVIVxezMWVGqqaJntoEIaTAytDjlG5u595gVgQcYZrNb+NB0YW8+?=
 =?us-ascii?Q?20F81VxGcrjlrpBZls+SQ7Mt/PbAHzn5fJV5JCIRyq8qf1G8sE9jPeyzjLSU?=
 =?us-ascii?Q?hL/118bqcvaTteZM/XtcqZa2SGhMEMZNworHmOVjWzfKVZJ+SXDaKK/OP9kf?=
 =?us-ascii?Q?FhyyWREFj73yBbxCtIAZ9sHYpprp6o8DuE9/f5H0x9sN88NPt/Lxoj8rdh+N?=
 =?us-ascii?Q?s57sryuFl+YRPbGugc1tHBZrw6+AwNgZ69MrRBLCg1/OgUeFxCfVZk9r8awY?=
 =?us-ascii?Q?InqHwtkICmLSKMFnwg1zBbZsVGix8isH25WngadsvYw7Md5shjXC9pA+o+hA?=
 =?us-ascii?Q?Ws0EaGo0xheacUFabO5A86M4zj3VrbCFxGIWi7xEo3ReSkh1eg+JMJpuggH4?=
 =?us-ascii?Q?TuKsk29cfcdkgUTRirm26kCGnn94wa0DFNqnpkJ/6ytC7nIWWyDlelszRwaG?=
 =?us-ascii?Q?lLexrn3TH/lKxCVRA4NiM06jN/0BPM9QeWFnWYB7W9OGsCsvabws+x7k4V5g?=
 =?us-ascii?Q?b5VbTlhYXcpzr75G6FJ3FzZRg3AkScn+5MdLK0FdpfI/IB1ymrplA+xi9A35?=
 =?us-ascii?Q?aVYH/yKw607FScEqJ6IfPyELdthYSJ1boi4L4e3S3kFgSlbtKPq4gRcImFMB?=
 =?us-ascii?Q?yECP+drHEa3icEFL6RnvbiNew1TOTXV5jBKBABHor7T6FPmlvspQJBMZzEdW?=
 =?us-ascii?Q?Mv73/aNgXRg3dgiqBW3X61r/6H0J9PVEdsXSa7vqmDfEGPhh9o+UA07meYfs?=
 =?us-ascii?Q?vFihKzFH8ignWJnGACtr7gREbc7TM66QOjJdonLsj/CswGHAXosBjCqYsJZU?=
 =?us-ascii?Q?iAIDPa3HiUQ5qDICZXoPmg5C6q33ynkOGNYBpjr9lFc/wU6MVie0x22O/WGb?=
 =?us-ascii?Q?n5oL0Ci6UZjqRpf0STZ9D8sEnoAXrp+wdREkSfgd61BBU2xVPcWvjztjKj5H?=
 =?us-ascii?Q?gYX4ffxgJdRv4pIRQ750gYjh4Hoi97Dw3+vRJO42ctrQMPoxVate0OwYi1W6?=
 =?us-ascii?Q?GYHXgfz8fLJskbYNTsBYdjf1+ITLPH6+6nPdHOpodToErV1H2uRqIFxYIAEt?=
 =?us-ascii?Q?U32/W1e2l/5tF9LPz9knTyuePR1ts864W1T9RfDghykbR38b6q7f/CJb7pgF?=
 =?us-ascii?Q?6ZAhkWWXYMbX6y3JriwrggJyMaHjOFeDVz07//w4BJN3CrIzvboJ+BeTFOE0?=
 =?us-ascii?Q?jo2cG6HR7Jd5IdscDy/QvG/TVGkW5Aikwy+i2QVUiuARMxK+rEiy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c744935-2ce1-4c67-6ee4-08df2f8b57ea
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:52:43.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R8w9CU3hf6n1QsYkfn2cGYsM/OP81qL5kT56ZiZTRjfqmBuN/FvLma8FHiOyCg0+J1ZIqxwfRZHaaTw6OlFmw0dHTgf/iMScV6esMktY3u2PkkZQNdYNwm91ZmKCdo9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953

On Wed, Oct 21, 2026 at 01:22:25PM +0900, Koichiro Den wrote:
> Some endpoint configurations have no spare BAR for DMA resources. Allow
> dma_bar to select an MW BAR and place the DMA ranges after that MW.
>
> DMA submaps have fixed BAR offsets, so a shared MW translation must
> cover its configured size. Report that size as the translation alignment
> and require it to be a power of two.
>
> Older hosts treat the whole BAR as an MW. Require the host to advertise
> MW/DMA boundary support in LINK_UP before enabling a shared-BAR link.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v6:
>   - Split out the host-side changes. (Frank)
>   - Require MW/DMA BAR boundary support in LINK_UP for shared BARs.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 154 ++++++++++++++----
>  include/linux/pci-epf-ntb.h                   |   3 +
>  2 files changed, 122 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ac83af54122f..721cd841a1dd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -84,12 +84,13 @@ enum epf_irq_slot {
>  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
>
>  struct epf_ntb_dma {
> +	struct mutex lock; /* Serialize DMA submap and MW updates */
>  	struct epf_ntb_dma_ctrl ctrl;
>  	struct dma_chan *dchan[EDMA_MAX_RD_CH];
>  	void *bar_scratch;
>  	dma_addr_t bar_scratch_phys;
>  	size_t bar_scratch_size;
> -	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
>  	struct pci_epf_bar_submap *reg_submap;
>  	unsigned int num_submap;
>  	u16 rd_ch_cnt;
> @@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  	return false;
>  }
>
> +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ntb->num_mws; i++)
> +		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
> +			return ntb->mws_size[i];
> +
> +	return 0;
> +}
> +
> +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
> +{
> +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
> +}
> +
>  struct epf_ntb_dma_filter {
>  	struct device *dev;
>  	int chan_id;
> @@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  	unsigned int i;
>  	size_t align;
>  	u32 next = 0;
> +	u64 offset;
>  	int ret;
>
>  	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> @@ -371,9 +389,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  	if (!is_power_of_2(align))
>  		return -EINVAL;
>
> -	if (epf_ntb_is_bar_used(ntb, barno) ||
> -	    pci_epc_get_next_free_bar(features, barno) != barno)
> +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> +	    barno == ntb->epf_ntb_bar[BAR_DB])
> +		return -EINVAL;
> +
> +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> +	if (!offset &&
> +	    (epf_ntb_is_bar_used(ntb, barno) ||
> +	     pci_epc_get_next_free_bar(features, barno) != barno))
> +		return -EINVAL;
> +	if (offset > U32_MAX)
> +		return -EOVERFLOW;
> +	if (offset && !is_power_of_2(offset))
>  		return -EINVAL;
> +	dma->ctrl.submap.offset = offset;
> +	next = offset;
> +	if (next) {
> +		/*
> +		 * submap[0] covers the MW prefix. Keep its temporary
> +		 * target at address 0 until the MW translation is
> +		 * installed.
> +		 */
> +		dma->submap[0].size = next;
> +		dma->num_submap = 1;
> +	}
>
>  	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
>  	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
> @@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  		chan->desc_addr_lo = lower_32_bits(dma_addr);
>  		chan->desc_addr_hi = upper_32_bits(dma_addr);
>  	}
> -	dma->ctrl.submap.size = next;
> +	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
>
>  	dma_dev = ntb->epf->epc->dev.parent;
>  	for (i = 0; i < dma->rd_ch_cnt; i++) {
> @@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
>  	if (!dma)
>  		return -ENOMEM;
>
> +	mutex_init(&dma->lock);
> +
>  	switch (ctrl->u.dma_ctrl.reg_layout) {
>  	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
>  		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> @@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
>  		return -EOPNOTSUPP;
>
>  	barno = ntb->epf_ntb_bar[BAR_DMA];
> -	mapped_size = dma->ctrl.submap.size;
> +	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
>  	/*
>  	 * Submaps cannot be installed until the host assigns the BAR address.
>  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> @@ -607,21 +648,25 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
>  	memset(bar, 0, sizeof(*bar));
>  }
>
> -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
> +				      const dma_addr_t *mw_addr)
>  {
>  	struct pci_epf_bar_submap *old_submap;
>  	struct epf_ntb_dma *dma = ntb->dma;
>  	unsigned int old_num_submap;
>  	struct pci_epf_bar *bar;
> +	dma_addr_t old_mw_addr;
>  	int restore, ret;
> -
> -	if (!dma)
> -		return 0;
> +	lockdep_assert_held(&dma->lock);
>
>  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
>
>  	old_submap = bar->submap;
>  	old_num_submap = bar->num_submap;
> +	if (mw_addr) {
> +		old_mw_addr = dma->submap[0].phys_addr;
> +		dma->submap[0].phys_addr = *mw_addr;
> +	}
>  	bar->submap = dma->submap;
>  	bar->num_submap = dma->num_submap;
>
> @@ -631,6 +676,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  		return 0;
>
>  	/* A failed dynamic update may have already removed the old mapping. */
> +	if (mw_addr)
> +		dma->submap[0].phys_addr = old_mw_addr;
>  	bar->submap = old_submap;
>  	bar->num_submap = old_num_submap;
>  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> @@ -642,6 +689,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  	return ret;
>  }
>
> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +
> +	if (!dma)
> +		return 0;
> +
> +	guard(mutex)(&dma->lock);
> +
> +	return epf_ntb_dma_set_bar_locked(ntb, NULL);
> +}
> +
>  /**
>   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
>   *   to access the memory window of HOST
> @@ -780,6 +839,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  					     EPF_NTB_COMMAND_STATUS_OK;
>  		break;
>  	case EPF_NTB_COMMAND_LINK_UP:
> +		if (ntb->dma && ntb->dma->ctrl.submap.offset &&
> +		    !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED)) {
> +			epf_ntb_set_link_enabled(ntb, false);
> +			dev_err(dev, "Host does not support MW/DMA BAR sharing\n");
> +			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;

suppose it should be fallback to old method?
EPF_NTB_LINK_UP_DMA_MW_SUPPORTED is new feature.

Frank

> +			break;
> +		}
>  		ret = epf_ntb_set_link_enabled(ntb, true);
>  		if (ret < 0)
>  			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
> @@ -1269,6 +1335,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> +	bool shared;
>  	int ret = 0;
>  	int i;
>  	u64 size;
> @@ -1278,22 +1345,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  	for (i = 0; i < ntb->num_mws; i++) {
>  		size = ntb->mws_size[i];
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> -
> -		ntb->epf->bar[barno].barno = barno;
> -		ntb->epf->bar[barno].size = size;
> -		ntb->epf->bar[barno].addr = NULL;
> -		ntb->epf->bar[barno].phys_addr = 0;
> -		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> -				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> -				PCI_BASE_ADDRESS_MEM_TYPE_32;
> -
> -		ret = pci_epc_set_bar(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      &ntb->epf->bar[barno]);
> -		if (ret) {
> -			dev_err(dev, "MW set failed\n");
> -			goto err_alloc_mem;
> +		shared = epf_ntb_dma_shares_bar(ntb, barno);
> +
> +		if (!shared) {
> +			ntb->epf->bar[barno].barno = barno;
> +			ntb->epf->bar[barno].size = size;
> +			ntb->epf->bar[barno].addr = NULL;
> +			ntb->epf->bar[barno].phys_addr = 0;
> +			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> +					PCI_BASE_ADDRESS_MEM_TYPE_64 :
> +					PCI_BASE_ADDRESS_MEM_TYPE_32;
> +
> +			ret = pci_epc_set_bar(ntb->epf->epc,
> +					      ntb->epf->func_no,
> +					      ntb->epf->vfunc_no,
> +					      &ntb->epf->bar[barno]);
> +			if (ret) {
> +				dev_err(dev, "MW set failed\n");
> +				goto err_alloc_mem;
> +			}
>  		}
>
>  		/* Allocate EPC outbound memory windows to vpci vntb device */
> @@ -1310,10 +1380,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  	return ret;
>
>  err_set_bar:
> -	pci_epc_clear_bar(ntb->epf->epc,
> -			  ntb->epf->func_no,
> -			  ntb->epf->vfunc_no,
> -			  &ntb->epf->bar[barno]);
> +	if (!shared)
> +		pci_epc_clear_bar(ntb->epf->epc,
> +				  ntb->epf->func_no,
> +				  ntb->epf->vfunc_no,
> +				  &ntb->epf->bar[barno]);
>  err_alloc_mem:
>  	epf_ntb_mw_bar_clear(ntb, i);
>  	return ret;
> @@ -1331,10 +1402,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>
>  	for (i = 0; i < num_mws; i++) {
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> -		pci_epc_clear_bar(ntb->epf->epc,
> -				  ntb->epf->func_no,
> -				  ntb->epf->vfunc_no,
> -				  &ntb->epf->bar[barno]);
> +		if (!epf_ntb_dma_shares_bar(ntb, barno))
> +			pci_epc_clear_bar(ntb->epf->epc,
> +					  ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno]);
>
>  		pci_epc_mem_free_addr(ntb->epf->epc,
>  				      ntb->vpci_mw_phy[i],
> @@ -1936,6 +2008,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	dev = &ndev->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		/* DMA submaps start after the configured MW size. */
> +		if (size != ntb->mws_size[idx])
> +			return -EINVAL;
> +
> +		guard(mutex)(&ntb->dma->lock);
> +
> +		return epf_ntb_dma_set_bar_locked(ntb, &addr);
> +	}
> +
>  	epf_bar->phys_addr = addr;
>  	epf_bar->barno = barno;
>  	epf_bar->size = size;
> @@ -2134,15 +2216,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
>  			resource_size_t *size_max)
>  {
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> +	u64 size = ntb->mws_size[idx];
>
>  	if (addr_align)
>  		*addr_align = SZ_4K;
>
>  	if (size_align)
> -		*size_align = 1;
> +		*size_align = epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
>
>  	if (size_max)
> -		*size_max = ntb->mws_size[idx];
> +		*size_max = size;
>
>  	return 0;
>  }
> diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
> index 5cc0f0badae0..8131ed4c6ac9 100644
> --- a/include/linux/pci-epf-ntb.h
> +++ b/include/linux/pci-epf-ntb.h
> @@ -24,6 +24,9 @@
>  #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
>  #define EPF_NTB_MSIX_ENABLE			BIT(16)
>
> +/* LINK_UP argument: the host honors the MW/DMA BAR boundary. */
> +#define EPF_NTB_LINK_UP_DMA_MW_SUPPORTED		BIT(0)
> +
>  #define EPF_NTB_COMMAND_STATUS_OK		1
>  #define EPF_NTB_COMMAND_STATUS_ERROR		2
>
> --
> 2.54.0
>
