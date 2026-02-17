Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8036CE1B;
	Tue, 17 Feb 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347285; cv=fail; b=Adglok7e8K8exojHFt0AvJ5yiT5U+fCWGuavykagzVqGSByxSyQVJksDAhyd5Ta8DIu5zlRKiuXsd75IKz84RIGLMCloQLL1ouNBsjOfeBSJq1dZQluwhuDJRf4sIqRZNk6bZ31OWMf0fu5zDpna1EFZYYljxOa+iiwOdRQQA08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347285; c=relaxed/simple;
	bh=Ze8sL3IhUSLUv9jvNOQ3DifyTiP4Ux0WKNytRofA3k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TzpEjVp86MApBbtLK/b3Xfzd2aSvtXfYSo7g1iOUAOahN2uBQPv1i9lXwnMozQEKNv8z7EqncPyGoT3/kRMMmKnicfrejIXMLMmh7B9qsdfHnAGAqHj2XuLFN+ehGzRVueNmPEsTpO6gDqvXC6nlX5+G5qFmyWism5GWdkUrcqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JZW/vpjc; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JZW/vpjc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVguGnxt6GwpAiT+DIo/7rdUg+yOvOSpm5blCC6OW2OjRZrDfPk1pKTGqX0alHkx6ljuHYqq4yDBC9m7H9pexFS7Go29sjD6SxyaWcVVjc2DEhGLmxu9Bk0TezffQZkkHTjADTsahJctFjH7f6XFZGoeEXNXgfBwAlyUXe9yO1TBNQvmYYMArXlwlME+9apNU9vCzl5dU1hu/4pMruAVSSFiMIFBV1zu15oBto4ijh0uV7ffIBFHA5ij9fL26LXnVV0yqdnBM06Wpot5lYTAF4yL5+y9G+Hr2O+1puOT0tYGNrrzbzpqV076IUcDFZYxvKXqdx98KydN+eKLtkBX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFKmYMLScGsB+Ouqtm4w74tk1UaV2qSdFGdbbxmhDDY=;
 b=XojijMZvU6Kippn6DXGw7jeROVRY14htZ7yiCGCyTGmdiXt4YrLLFj+T8H/QFvC1r4Segdbv+eD62R3odWxokrtWe5Lp9f+mWVPippN2iu/1fo9JPgDOzbJb5SnMPV2rumV70om6HUto2iRzMiXUTf1R7aEgJz9b9EwoHQ6nyHJo3WDGES9N875tGYw5RQfJONvljrznSheL6wbyLLxhYXyPkE1zaiKYnUxhryT19eDHbIhikgMJDLxnCbfzBxLT/rZZsj5F7FKI0QOG9muwJEMFCrmvxg1ysYYWEsHJkTkwLQcKss87ECAD4SiaJapRH98o6qqcclU96KLOqjQ+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFKmYMLScGsB+Ouqtm4w74tk1UaV2qSdFGdbbxmhDDY=;
 b=JZW/vpjcDuxFYy4LXZ53+2snRBz/6LKNFv5ySSRNxP11NrXkRrI3yRTG5TNV/P24ycjGWbt3o/fGmnEjx1L6jVBH+qbrjr6yE7lwGAe/Qbl5tjxDzAbb4wUoHqoRZOrFPUuiBlbESFfutIFPS5ihiHA9Pw5FJj8bQvUh3ri2PFZcPUiwWHr7uW/YNaX8xy00sYZFfEikQOKcXTljP/dc2JQjB1w8+uCdrmRZzSk3bIPv77eWbW21NZoTphAV996MaTVUSEcNOITICVeCeSDSoBmmhRmMzeN9/KlGd/ZEJ3atoQDaqrWdlNNFa7eTqlzKOcnw7KU4BebUkVKgPxqmdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB12105.eurprd04.prod.outlook.com (2603:10a6:150:335::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 16:54:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 16:54:39 +0000
Date: Tue, 17 Feb 2026 11:54:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 7/9] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
Message-ID: <aZSdRWdevAr6TpBP@lizhi-Precision-Tower-5810>
References: <20260217080601.3808847-1-den@valinux.co.jp>
 <20260217080601.3808847-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217080601.3808847-8-den@valinux.co.jp>
X-ClientProxiedBy: PH5P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB12105:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6fb488-eff5-4e63-9ce7-08de6e453cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IN3pbHS4OImqjjkYmszy6iuTb4HEGf0csKu+7Usg6ysKKKmOBworDGJZK4Lk?=
 =?us-ascii?Q?nSgkXCxjH5A25xxLCiQyJIDBQNVd3kMIlwchIBJb0YatnHITN8TUe3VCSYIm?=
 =?us-ascii?Q?mnEA5YHyitpSBUc4Rwo64CrRfByh6rhC3TwGy/+rgaWzFbwG6UXVukq2LM4T?=
 =?us-ascii?Q?/fQJihXXb2XNbM4P8jxWkNqTWDGrLZnpW3ivJ3ONBINVovFO3rDKRhW28aO2?=
 =?us-ascii?Q?W4bDWZURrKlqVXL/mv2XwyX3XssYWNxCHtomtouG6Js8HgDOvUyQQ25Cvp2t?=
 =?us-ascii?Q?tGf53FknlgjShVfoUcoOb3Cr/kfUF5beaMda7uCzLLHdUfrn3uskUoFWD7g4?=
 =?us-ascii?Q?sAd60wEuh4TTAIY52dCVj/0bZkH/+k/d2FppZlv5qyEzX8knYftXARf3NclT?=
 =?us-ascii?Q?FA0xqd8j3xTzz6REZycwkYSW+Sm2oD8Va+iCJkEkLbkwHZ35D3WO518niibo?=
 =?us-ascii?Q?YyvouVMMMg27tz5GaYxizxmTxxutD2mmNH1XbKRuIWLVC1PTuKtT4A7Os/uU?=
 =?us-ascii?Q?ToyTlQwPeLh0pml+N5dinLnoouRIYcwxQl05qrjdDtm7uXM/yR7ugWdrg/lF?=
 =?us-ascii?Q?0e2KfSTRpRLaCccKEKM20K5OMxgSL4sJx4M9/IUpshX8CV9vMKcd7C0l7axZ?=
 =?us-ascii?Q?Yo1gWogKHC+WnJFcyIzYxoZ39NHiT/CQWRUyM28k4MLsZxTAmmU2lRszIuK4?=
 =?us-ascii?Q?zShTf/X7VPfuiGeeNslOgz17TVNO1dVlsCjZ+GeQYQzkEY4gKWdiF08jpt8u?=
 =?us-ascii?Q?Y99Ujs+Y3vZr5XWzrBiPv4strb0+dzYsllpIF6VEZ6Luh29SVLgBGjWtSOzs?=
 =?us-ascii?Q?xttdW/2Rt+4GJ8Uvdq0Y3Q+b3aQVzVP5GkMtb0R36Y1GzrsFVkPYnwgZXBz7?=
 =?us-ascii?Q?LRwZyb4dqHGX81vliA3ASlfi1u1gvnBkkWCBJjsWpYmj4vgFTdKxz+O4a7i8?=
 =?us-ascii?Q?Lq3OAdae88YNMuIiq04+eQuBRlCvXRWeqB5voenlz/6C2oWp71JpwAQ1sEWt?=
 =?us-ascii?Q?BL1PEO9i/bJtARaUl7i+NtseNqriR+DnOvfVDCsLLwNJ+meMrH3oFju4NAcK?=
 =?us-ascii?Q?cYhOJyQOnj9SAvnDl5eEK2lkk4fzmfkZLB08KtxfqGi4F/AN+1fM4QLqYm0d?=
 =?us-ascii?Q?iBP0jLoIY5egds/zmKU0xqSLDb8ADLM9eRfifv03MMmMoaxhScH5x0OUiffP?=
 =?us-ascii?Q?KnGBW+vcbHT48xRdZpfO4Ma341C+n8MAvNMeb+Or9ZNLiTv2SdQjmt651GzK?=
 =?us-ascii?Q?jmt6Z3o4cRnwJRozj78sZtHwDOLhRDIUTzY6HvVSyvHgcC0I6NLflp+jsxs7?=
 =?us-ascii?Q?QNbbQ+bd626NrEIcOFBMJL1buzSXR7QZcmOjlNCcPFnd8QtAK3T4x7fpHuhZ?=
 =?us-ascii?Q?ufox9DsXOp3K/OaZmWZdZRXkhDvLjQsQ8zxDrFKRBoXA/whyhvbAHU+KjgBc?=
 =?us-ascii?Q?hwUtgAXf2dK4JFrS8I+nWK0eZddrePk9UK2jBfvrdeQ94JaIAyFqeNFjLiyi?=
 =?us-ascii?Q?gyEcF4Kf/5mxKsyeBKPkTmjMt0X3qsDBr/WRlp9XfsX00EBGCsPLemGAfSCy?=
 =?us-ascii?Q?MrccTNeUZ+wnCYDnPbRJJtZaouR42s5bjHRD2XlVoZGS5Zfpls+I68FoKVhP?=
 =?us-ascii?Q?KW14eGVCoYH92WF50NNCf78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FDAspRAJiPzZYOwUfcaHBPqWVs91qTpI3hetbtMdff7pyvwuJTiC13qRPTH+?=
 =?us-ascii?Q?YiWDjj5/E+iwU3uaLb+qhFo7zAuHohSFwfoeNg3FZ/qCjRjP+20542/CYNsR?=
 =?us-ascii?Q?G92KQ3DEStXUf3DZIiPeUa+zFxV7thy4IbQAspqjdHUo0jZV3Y/RmS+7N+jb?=
 =?us-ascii?Q?Xn5oBMM77hkh2Jw/xNo/A4RaiaVKoaH6p19Ns8zou4/+d39AVNDNtMZxuZoN?=
 =?us-ascii?Q?Tue360Vjj7p7ihB2tOXjgnxO7iCZP9qPUWv7MqDa+WlItrOXKDoVv7JQcKGx?=
 =?us-ascii?Q?yBH3XS4l8GN4Ky6Vt4sKVzAin75zuHZVFXqljlwUzg3Hh8ycxs6z5zwWbJ1r?=
 =?us-ascii?Q?HF36phLmZiS1SHA8V7VAS74jF6SocymuZAHm3I+KKktAK76KmoIpIJ9rxhGC?=
 =?us-ascii?Q?2kWB+NfGwq4+oiYPleaVvUwxQmnP53+V9Y76AzVXmqROn7eN8n40ux9M7m82?=
 =?us-ascii?Q?gxp19FMIfuJGkgn+P1l2nqglOyKduSYO8oX2uoOFfa2x+oy8bAyV5cDQTrBO?=
 =?us-ascii?Q?fWxcjqio3so21o5559s/8xK+sxnj4T2c3F0OpPD9XMM0qHGyls+qs7K+hFFA?=
 =?us-ascii?Q?p+qSNzeC+75u4NofScxE5npAe+qAE1iU/R/21J9l4r+ajQH1UjectbM5xPY1?=
 =?us-ascii?Q?9GAGJDGW9cN2KKKPAPSEEACoc/fj9klKV/YXJnCxHnNB1ZEe5hjfCXFRJGua?=
 =?us-ascii?Q?P555vRDXrn+ihCpsYz3HQkJZaMV/Q/mfdVWDLmwf8R+m3IIEuiU1ZV2rridq?=
 =?us-ascii?Q?L+3BkVWvgRL0bnc89mAwEatX7TBkfRFaadbB3EIUSEAzd3ayDVjut2c1PQUK?=
 =?us-ascii?Q?p4xPKrdg7vabEjU8zkamf78lrygzN4irIq1ehmV3J3Sjxn/yvTrhTLpHWYfh?=
 =?us-ascii?Q?TVi37pcuP68Gq5Ry2pPbd0g01Pvut8DFkhfgZBWJz1PG+IAfxSIG+UWfmgcv?=
 =?us-ascii?Q?guLkwe0krwUwGy6rGOncFAdXNB5iTGT5JtxsRG5a3skqa+hwd/I4VqZGa05r?=
 =?us-ascii?Q?V/5Dk69qCxz0H/wjGE378eOZP3YUVWsk8brssBJPDpHP7cYnI88PQ0kjaIr8?=
 =?us-ascii?Q?sy2YqYJdMeo+f3c76mEgYw9j8h9iKH7AyxUjR3dwUM71eF+Aem6w5L707mGr?=
 =?us-ascii?Q?ZdB/mbnohDXdqip264u43G1jfwJSmc3wNYmvqDvJo5VqFDo1rMJQVBsVphuF?=
 =?us-ascii?Q?wIQ8kAgiKfvWFjgT1QvKBEdac+2ocEuKqacF5SyZ3FBKGbctmq6FpJRH1dtY?=
 =?us-ascii?Q?CbWwYo1jeppe2AC8ng26b368NWNPE8nmCJdFPQB6Hg5jg2IfdANXiwC6zyMK?=
 =?us-ascii?Q?6MdqfO3vvXICQurhuFmG7UkCntc1+ml0nvzaapQFpzN6dQyZgwoWC7cLD/Oj?=
 =?us-ascii?Q?h0FJNxve5kqeCDuhFlJXvGMWQU9koJj2ZbB/AXM2q4HSj7vU1siYNZxWLiOQ?=
 =?us-ascii?Q?EpdJB6SN4NZQHDzkzU+1hQt497yC7oXE6Lmly1Xrf80TBgku9W9uVpp/98iF?=
 =?us-ascii?Q?dkGwM+fRuXC2CeTcyNFmYVUDWrdvVvxs1jcREY7jqdjYUDjFJi/0E+0wzUIO?=
 =?us-ascii?Q?IJdPTCZe4KT9J3JTmC/YVSF6zCm77st081zzNu5qFkWx5a3GyioGfNRtpiP9?=
 =?us-ascii?Q?NHih1RB5aDWjZCCt5d9gmKs/wrHOrUBEdBEuXYlRlBlabWhInSRrbK2QyVKt?=
 =?us-ascii?Q?kU4ZVjYge3vzS6I+qdpWxMbJWQFP+ELseQS9F97/yeTrpYuu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6fb488-eff5-4e63-9ce7-08de6e453cc0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:54:38.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUXQw/ALFIo3kFcEfoMQqN2RSkBKDpTPWVAfSSZI/PLfubCxmiRXk07LovkBxfIjQOT7sL5S1Y1o2MawB0E4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12105

On Tue, Feb 17, 2026 at 05:05:59PM +0900, Koichiro Den wrote:
> Support doorbell backends where the doorbell target is already exposed
> via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
> must be requested with specific flags.
>
> When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
> pre-exposed BAR window and skip programming a new inbound mapping. Also
> honor db_msg[].irq_flags when requesting the doorbell IRQ.
>
> Multiple doorbells may share the same Linux IRQ. Avoid duplicate
> request_irq() calls by requesting each unique virq once.
>
> This makes pci-epf-vntb work with platform-defined or embedded doorbell

Nit: Make pci-epf-vntb work with ...

> backends without exposing backend-specific details to the consumer
> layer.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v7:
>   - Deduplicate request_irq()/free_irq() calls based on virq (shared
>     IRQ) rather than doorbell type.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 61 ++++++++++++++++++-
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 52cf442ca1d9..b1e8414c4e43 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -134,6 +134,11 @@ struct epf_ntb {
>  	u16 vntb_vid;
>
>  	bool linkup;
> +
> +	/*
> +	 * True when doorbells are interrupt-driven (MSI or embedded), false
> +	 * when polled.
> +	 */
>  	bool msi_doorbell;
>  	u32 spad_size;
>
> @@ -517,6 +522,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	return 0;
>  }
>
> +static bool epf_ntb_db_irq_is_first(const struct pci_epf *epf, unsigned int idx)

epf_ntb_db_irq_is_duplicated() look better, below 'if' needn't !

Frank

> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < idx; i++)
> +		if (epf->db_msg[i].virq == epf->db_msg[idx].virq)
> +			return false;
> +
> +	return true;
> +}
> +
>  static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  					    struct pci_epf_bar *db_bar,
>  					    const struct pci_epc_features *epc_features,
> @@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	if (ret)
>  		return ret;
>
> +	/*
> +	 * The doorbell target may already be exposed by a platform-owned fixed
> +	 * BAR. In that case, we must reuse it and the requested db_bar must
> +	 * match.
> +	 */
> +	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
> +		ret = -EINVAL;
> +		goto err_free_doorbell;
> +	}
> +
>  	for (req = 0; req < ntb->db_count; req++) {
> +		/* Avoid requesting duplicate handlers */
> +		if (!epf_ntb_db_irq_is_first(epf, req))
> +			continue;
> +
>  		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> -				  0, "pci_epf_vntb_db", ntb);
> +				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
> +				  ntb);
>
>  		if (ret) {
>  			dev_err(&epf->dev,
> @@ -545,6 +576,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  		}
>  	}
>
> +	if (epf->db_msg[0].bar != NO_BAR) {
> +		for (i = 0; i < ntb->db_count; i++) {
> +			msg = &epf->db_msg[i].msg;
> +
> +			if (epf->db_msg[i].bar != barno) {
> +				ret = -EINVAL;
> +				goto err_free_irq;
> +			}
> +
> +			ntb->reg->db_data[i] = msg->data;
> +			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
> +		}
> +		goto out;
> +	}
> +
> +	/* Program inbound mapping for the doorbell */
>  	msg = &epf->db_msg[0].msg;
>
>  	high = 0;
> @@ -591,6 +638,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  		ntb->reg->db_offset[i] = offset;
>  	}
>
> +out:
>  	ntb->reg->db_entry_size = 0;
>
>  	ntb->msi_doorbell = true;
> @@ -598,9 +646,13 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	return 0;
>
>  err_free_irq:
> -	for (req--; req >= 0; req--)
> +	for (req--; req >= 0; req--) {
> +		if (!epf_ntb_db_irq_is_first(epf, req))
> +			continue;
>  		free_irq(epf->db_msg[req].virq, ntb);
> +	}
>
> +err_free_doorbell:
>  	pci_epf_free_doorbell(ntb->epf);
>  	return ret;
>  }
> @@ -666,8 +718,11 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>  	if (ntb->msi_doorbell) {
>  		int i;
>
> -		for (i = 0; i < ntb->db_count; i++)
> +		for (i = 0; i < ntb->db_count; i++) {
> +			if (!epf_ntb_db_irq_is_first(ntb->epf, i))
> +				continue;
>  			free_irq(ntb->epf->db_msg[i].virq, ntb);
> +		}
>  	}
>
>  	if (ntb->epf->db_msg)
> --
> 2.51.0
>
