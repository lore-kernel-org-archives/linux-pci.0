Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0476279329;
	Thu, 14 May 2026 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785060; cv=fail; b=fE6Z57/atXQ1ngV+IkzvnlEsWMG82lMP/gNwzxOJ4NzDsbSfoXPgsXheXraTGR4w0VGF+8HKihzeMcCVUOsrXWsb0cDs0e80cPYopa32LoZrUbOMYRbQJtxP9lTNH1mB/QgzxniShI7oiladNqYhm6pRnMi5I7pddXSGuIyXbE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785060; c=relaxed/simple;
	bh=dYYgUdfVqw/aZcIRpg6N8opcGNZWfjIa0klpJifHxX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cMYcv2n5JYdr/OfVeA49utXIExqnaAM9088ASk+Dme3lWUGHHn/IuSXBnqEDgoHvPXm4XrxC8jOBblbqwWDdxkLkgcOC93NxYIiHyTg3BuErrFz1QBU2Sqy2uEmzhzGOe6pxOeskFcbDyM17+gLRk32dy60nbeFzQQJ9rR4eDWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iav9OI1v; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iav9OI1v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBMmpQJvuNYxmwXrh5Nz1dix5L3xcK0yEUtIGPPuN3/Qf1XqXxEsAh7TkpQOs8ptj5+20ptp5yLoKIiUi8sKWcufN7jKO2hr4w+xMKL0bBW2kTz69ESvHoSVYE08pPCxBnODDW+2LXV2Fp75w4Omp3fjrJ15t463CJH50GgutW6JJ8PvmbE+XQBQ6ipirSgchmN8u/YOYdj3DYC9HjoygjzcHDgc2r1RxOP9e40Xs7+npFe94WstV641sHTabOSDSnpboYeWl6Fnr//kQ35Atg9M8IulK0qAKDU/usugkpUpIljt33+rJCLhSbiP4d6rzLKv1xHrtuHDNhajVea4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCLRE+p8+Q6v0P9i0Gv4IupRd/naIgOYSEc9gaNhVUw=;
 b=JRDSSLaNFxr0tocR8oDdgBDOIt/x0QubCt4eU8jZDsJFoxWr1qYBVciMG6Apiwilx4JIrvTZra15O2WUy6sIjOLSr0xpHbfyp1WeKESIooi6Ia52StnBg0BM4Vyk5bZlKV14tzwqSvRt/oWUUTto7anhXrQhwCg0hGXpLN1W0qnDvlFMlF/EHwAnfMdtdaxaFM2WLi0SVN77V0eI+NeKmnQnKjxh/omNOy583Im13ao/2rWId+T5iv1vK2a8frkYubd4QL0FUdNuTx6HX+DoOHku2KReQt/c6ljerjpGhqcE7l+HHvDpcqQDUARvkl7zoK3Q8Wjv7KWnUfW+MQNTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCLRE+p8+Q6v0P9i0Gv4IupRd/naIgOYSEc9gaNhVUw=;
 b=Iav9OI1vTuuQ7CT410xbvtERJqWni5h3NrVSrsC0zwuzsxbsZct+KXWCD/KrNxtSdVRPrVw9aHdBheClJOURijqNDLQkum38tKFm/67VtbCAC4z3D9lLVUR+Z4HxXtXxlaT2QHQ2Vf/+RA12V0hPSJSsc2raakvbInM/YHjXnDnlABSJhRRNTMAQdmzWyozA4yWGuAZgerlBAmL05MerKpD3SuFiQdlLx6wT76Yon9PK3aL+xtloh1UBl0QFZzubE9qhQviAehVZB9UeOEYK6VCE9VkrzhIz/k8KItevdumPRVcGGss8g01acvWFBZGb+8U/apDXIGVlPZiQCYlKOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 14 May
 2026 18:57:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 18:57:36 +0000
Date: Thu, 14 May 2026 14:57:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v4 05/12] PCI: endpoint: pci-epf-vntb: Guard configfs
 writes after EPC attach
Message-ID: <agYbGKfndwQnVvcA@lizhi-Precision-Tower-5810>
References: <20260513024923.451765-1-den@valinux.co.jp>
 <20260513024923.451765-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513024923.451765-6-den@valinux.co.jp>
X-ClientProxiedBy: SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ac34cc-eb0a-4405-4979-08deb1eaa9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|19092799006|38350700014|22082099003|56012099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	T9HSJuE8LvvStdNTw1rg4x1s5toB82905LPdZqT5CXgILnRA0tstrtrffCk1a3Y888PRC3D/B0Yli9YgJOy2TytOA3LZY5aB4yZpyX409FIb12n8GNk7QBHtcHyS3x4n6Bq7aqP8BYrAyJBvnDnBqpCn5tqtb7VaTsXG8NB4klr4RtKRdXAnJiuYioCvtRfHtsSiEdCOae2R4tVIDLv1ozl+0mxaFWDE5PAQpQE4nqCiAMZRATCqYfNn7RISogh+QpnU2Cwg13xVCB1x28pQAVyk8JhS/F6ZiBOObODvn+MKGnnwCjw5wOsaquFUdyn6WI0y7vJRc1+qmOQx6fI+fMmBv8vtc2ba7RnKzVCDd5FrG7NeTFeDHt8shbaHtk09ps9z6yUFjEiJBHafUpdL3AXwsh6MP4IWN8DmEMNIqNojPKBrNpxhOeZCNpjaoUOg1rbZLI/38v08NYWWev5cCimGlU9Fwwa0YiKWMPWwe6HZLV66iHlIcijRkyJ+FfmXSEp/RFtWxIOtt3oeW17WjW042+vdR5VmbrXkX+mlbTVjsUILocNvKXRCZPDxFpSXnopqqgyHV25tFkmjsgRL9DC7t3ee138eDx056CcmxvGa16JM2bVeKe6x4EXD6LzchggR4HzNN6+U0uXMWsww09cseRRpLxul35B9iieSyrs/7Kl4shEDLPh0iyMbLDLCTKaCf0WVh4fjqC0LLIzIR191rv1+ET2avPV4XRQParm1MRmgmrl3TYxKbPMdFOcg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(19092799006)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pTYYyYbPur7X+sk6Xtz1k2/nWQkO9PrV4MYwl+R5OrHOKP8Ei+fKap/w2CoR?=
 =?us-ascii?Q?YkBXSqhS2Xn4ZAs80TlvuZ5E5Wl3KGVNzGEsLUjOgfhZqdcU+riRlXnLosB2?=
 =?us-ascii?Q?Zp8m7p2db4pt2OVcnkyD7/qL9hQ7EcnfiMksIeKgCKPKeEBs0n7kfl6juYDP?=
 =?us-ascii?Q?BctncjgbnK6WAngf8/xxHNl748JbXwOKGM4aGOxeaqhH7djMoq72Tk2MpA9o?=
 =?us-ascii?Q?sEeqasDKe3WoXvjsNjzSQNBRXaFy5Atga8iVyKigXHgZ4OgNtSyPIyTjKnnT?=
 =?us-ascii?Q?RfSWfwG4qo+xoOiT2rzyQEK7qUMuqOlhy6AFPvKkJ7qcX+oGmxWMowMf5IE6?=
 =?us-ascii?Q?2na0i2pmnUY4c22uScQq0gV0veuTyB2M5hxPyCD3zf/ULBcv6VeTtsimCPMI?=
 =?us-ascii?Q?h7YRy0L+6mVMjPqyIyIReACBqi8BEO+3v++xvphTCuW64yRCxDjLoDGJ0VGl?=
 =?us-ascii?Q?H1gidCDSsyIF6kgEml6d/ZiUUfGAsi6fmGdpQdZyi83J0FK0GxQhCRbP15rY?=
 =?us-ascii?Q?kLoM3cWSOtpngAFqjg/oyIaKh6kONk5YvYCeoBjETLu+Hf+kA/Pdtw3RsM2J?=
 =?us-ascii?Q?PMw1l5ndkd3WJuRP39zODBsyOjXDOP6l+IcH2PiDbCJIIilsbNivAL0Dx6Bs?=
 =?us-ascii?Q?meXNIlZSiRu9fX14kbefa1iRhn8TBNMDTBOpJxcy/Avjf5Yr3HV/A7okKgzd?=
 =?us-ascii?Q?PFoGONmFhkD+ISlZHC+cvc0Vyjne03BUumxVU1kNAWiUx737d8bf2LeIAHC+?=
 =?us-ascii?Q?+LtmlQ/dKYn60QKhO/GRDn1bV06Rzxwbe0/dmo789Qat/drkr/eqcMof3/ZL?=
 =?us-ascii?Q?upHpFBSNBKLaNskB7wstzECvHTgf/zEDGgjjo6JtAQTmAbDV8BHrP74hBhgW?=
 =?us-ascii?Q?0l9v2RifFpPqMyHeC8bMM7sFw7JkFIzaoCWikcwoQdB5Ivule+zDXqcA3h0G?=
 =?us-ascii?Q?ccTFOJepWFIpuAR+W3VHUAMmQpyr5ajghcTiMMdTOrjhwW5ekeh65XkYqxgP?=
 =?us-ascii?Q?soPq717cnJrxIXBTzzDwApMFDBWbEIvOsurCluxKaiStQNvIfBtKYHeOtZ/B?=
 =?us-ascii?Q?LtNksRFgbijDAZyYmGtNDBZMUP3FIQGkPidVq9J1k0LXVCrhgJbzE+N+gAz0?=
 =?us-ascii?Q?I/nkFqIClTiKCcpXtiIOusmgOI2lbCJgVvuG+5CBHHctIQO11jExLxPvK9YU?=
 =?us-ascii?Q?kjvkxIZebkGpAe/ldBm7jVEdzIQoTpjd4zeVUGKGZjQ8qtymwrToYgafcP9z?=
 =?us-ascii?Q?vMqGvzKtO2Hcgqz0hWPM54reBxu+OA/tWPIrQYVPi1uqmmmcLL92mX16UiTp?=
 =?us-ascii?Q?4PD8wwkCuQAKJudkmmy4Mv1dIu352BSNafdKE3ID+FrkkS3kJtqgTgO4tpNI?=
 =?us-ascii?Q?u1gWnIu9We1CHMuraxtw5FwRd6STGLjzEpbEzt5I7/1FShMh+XInJ04AsHph?=
 =?us-ascii?Q?613iPx8o5dtd4k5TxLE0ofGWpGOXSA7mgfGsRGd/PZkKDAJZJ2Zrm0xWWI3A?=
 =?us-ascii?Q?A/7VqzGpfPDPNNX2Anhi4F2zig9kkeY8yjSDbVNqDWb7oDUQkJfLyGIdQHPA?=
 =?us-ascii?Q?STesfmsjlf0MJFL6VlQKqGa5O0voTiX3x0b1GMZK5SD5bnSSh7qXkXC/ZT2x?=
 =?us-ascii?Q?5XFB6NzpDYzttVlKUXsdzKWGy96xCDuR7+5JdQbhr1X0aHoa5LLHIIGXvaH0?=
 =?us-ascii?Q?sdhrlEznF7x9GfeUo0BUZJQfqfPIW8AaSN8J1qn4OBCUYq9d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ac34cc-eb0a-4405-4979-08deb1eaa9a4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 18:57:36.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jw/V/5+jcJWfdZklJ+si2BXKmwoTHAb58DJ6wh63DwiLj7fnjgUEoV0B4AMSh5Rt0jjwTu3WMEVQscqx9LnpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

On Wed, May 13, 2026 at 11:49:16AM +0900, Koichiro Den wrote:
> db_count controls how many doorbell slots are allocated and exposed. It is
> also used by the doorbell mask helpers. After an EPC has been attached,
> changing it from configfs can leave runtime paths using a different count
> than the one used to set up the doorbell resources.
>
> Reject db_count writes after EPC attach, and reject values outside
> MIN_DB_COUNT..MAX_DB_COUNT before attach. Now that MIN_DB_COUNT documents
> the usable doorbell floor, use it in the store path too.
>
> While at it, apply the same after-attach guard to the other vNTB configfs
> knobs. BAR choices, spad_count, memory-window counts and sizes, and the
> virtual PCI IDs are also consumed during bind, so changing them later at
> runtime is meaningless and unsafe.
>
> Return -EOPNOTSUPP for after-attach writes. The value itself may be valid,
> but changing it in that state is not supported.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v3:
>   - New patch.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 41 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 818ae5999976..524355a8b4be 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1020,6 +1020,11 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  	epf_ntb_config_sspad_bar_clear(ntb);
>  }
>
> +static bool epf_ntb_epc_attached(struct epf_ntb *ntb)
> +{
> +	return ntb->epf->epc || ntb->epf->sec_epc;
> +}
> +
>  #define EPF_NTB_R(_name)						\
>  static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
>  				      char *page)			\
> @@ -1039,6 +1044,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	u32 val;							\
>  	int ret;							\
>  									\
> +	if (epf_ntb_epc_attached(ntb))					\
> +		return -EOPNOTSUPP;					\
> +									\
>  	ret = kstrtou32(page, 0, &val);					\
>  	if (ret)							\
>  		return ret;						\
> @@ -1081,6 +1089,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	u64 val;							\
>  	int ret;							\
>  									\
> +	if (epf_ntb_epc_attached(ntb))					\
> +		return -EOPNOTSUPP;					\
> +									\
>  	ret = kstrtou64(page, 0, &val);					\
>  	if (ret)							\
>  		return ret;						\
> @@ -1119,6 +1130,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  		int val;						\
>  		int ret;						\
>  									\
> +		if (epf_ntb_epc_attached(ntb))				\
> +			return -EOPNOTSUPP;				\
> +									\
>  		ret = kstrtoint(page, 0, &val);				\
>  		if (ret)						\
>  			return ret;					\
> @@ -1139,6 +1153,9 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
>  	u32 val;
>  	int ret;
>
> +	if (epf_ntb_epc_attached(ntb))
> +		return -EOPNOTSUPP;
> +
>  	ret = kstrtou32(page, 0, &val);
>  	if (ret)
>  		return ret;
> @@ -1151,10 +1168,32 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
>  	return len;
>  }
>
> +static ssize_t epf_ntb_db_count_store(struct config_item *item,
> +				      const char *page, size_t len)
> +{
> +	struct config_group *group = to_config_group(item);
> +	struct epf_ntb *ntb = to_epf_ntb(group);
> +	u32 val;
> +	int ret;
> +
> +	if (epf_ntb_epc_attached(ntb))
> +		return -EOPNOTSUPP;
> +
> +	ret = kstrtou32(page, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val < MIN_DB_COUNT || val > MAX_DB_COUNT)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(ntb->db_count, val);
> +
> +	return len;
> +}
> +
>  EPF_NTB_R(spad_count)
>  EPF_NTB_W(spad_count)
>  EPF_NTB_R(db_count)
> -EPF_NTB_W(db_count)
>  EPF_NTB_R(num_mws)
>  EPF_NTB_R(vbus_number)
>  EPF_NTB_W(vbus_number)
> --
> 2.51.0
>
