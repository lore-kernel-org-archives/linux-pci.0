Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96568195B1A;
	Thu, 15 Oct 2026 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029953; cv=fail; b=fVAY2AaEDmYJcMm4pzoOBYAv6wNjvEt1nUXR8kA0FJczUh7fst9I3JWyZ/aNUwHGI240ysbXUyf0lASf8INlFljKZg0LHhzFGU+rK4zVO4YdzBsdY6BOMlFELT3NH8vU7hcdvd50s6gP8GuNBxL23W8n1HLP96auTm54/f+Bu5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029953; c=relaxed/simple;
	bh=RxkOLXxFePeBEnLjg8N176FvOjbJsU7telTPrQs6z3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bsZVYxUXVXPKchayhsGA/4h/zacRCBmuv6XyrsojSPWROmuqj7lalXxNOietSpXIlqI4rQDO+zmnaqM/jFmuXr1s19Tn8vINMiCCFUqCJq0dFEGzSXuSvU064BLbG1VI1CPX5+9JGPwVOI/JrDnk88rt+1RDrv9piP6CDQKemn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lyiXSMhj; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lyiXSMhj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I78hmPsnk22q0agW3hY4ZJPRD1qddOfLBNl7wybeCZHMio6OpIbjK/rusL4dYlDhJ09Xxaunyp2IAS7Zf93X1PktAfSN+M+0Cfn9+8/r7sQr6avpwCd/QSbT+Go6RmkPdg1zFbfcfxcboBt29aXlkK9eGUOgUyrjuHydv5oH6PzaPGzPccu2PUv/IaV2OR1u9EaRxRwy1FEJGF1I8kYUeUgWZ8GFCNygqgamSNm62pz4u8IZoYh3VafY/YPzugxRLTK/te3SHFJWhV4GL0B3fS09NHX88hmX/XytBwFT/Y0f3tzDSPlB7ZBgzvcfdw/HQ1mdQqRpw3BANv0IsCyncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwxXMhGxtGXsPnBn6WV5ecMQlAfQuze3lwgj83SSmsE=;
 b=ADfLsCo/tuhQAfDOqHjlrwrE6h29sWskZYSlEubupYGASAjNcrAP7cROSVXobS3kRctJTts8BXmnVXM3LyzrGtK51liuy6ajbS0MWyQzdnNU4WP0a87sbT2hJvyFWqKp4OMCNrs+rJrkV3eFur+D3ZF5/F+llqIwfxeAYdaC2E5ufWneZe1cMqG3mwRrEftX5FwB7xBZZfrbS+NGcdG/y/8xbXUqtsRjESZovrhKJDqXWEuXywxjFofCFHoRVz5lUEU9tL39ihS1FkSQ9OMcRdi4S4pYCfF2GMgjDS76OVLSO3kdRYKrg9066cLPAjcZwLpNvuTv195eRMCpXkjp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwxXMhGxtGXsPnBn6WV5ecMQlAfQuze3lwgj83SSmsE=;
 b=lyiXSMhj1ybRnmtDSCLrAeIZkD0G46rEg0KCj+5e11vdb67kyHWWBPsDuGEBcGBzNoVBoeR85WABVh/GeCtlOgnb20uH3aM1siv7tnU5k2K4L6bisvWbN8I201YzMlobrtouJBtliudkY+5SrP6fvHxeC9Eyili0D6rKM/K26dMFaMSZqmZjfIVVLkiJK08zpqZ85gnafI8xXt6/9hNLY97Tb5a9d+707yUrMD8aHjsCY3V8R/3It3042gDm0fwfXlNqQTUrhs0tktJCM7c4BX0reZolTQ+D+Bcm8Q5fFVhJVWtptkrnz31a0j0qm3irQxUjj2CPKVYuMmIMampHmg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11022.eurprd04.prod.outlook.com (2603:10a6:800:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 02:05:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 02:05:46 +0000
Date: Wed, 14 Oct 2026 21:05:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] PCI: endpoint: pci-epf-vntb: Use a local epf
 pointer in interrupt setup
Message-ID: <atA07xp8Rn-8s3mC@SMW015318>
References: <20261015014402.2976188-1-den@valinux.co.jp>
 <20261015014402.2976188-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015014402.2976188-2-den@valinux.co.jp>
X-ClientProxiedBy: DS1PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:8:233::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11022:EE_
X-MS-Office365-Filtering-Correlation-Id: a1af3a02-4f7c-4d40-7e11-08df2a60d30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|23010399003|56012099006|261009223027099003|11063799006|5023799004|4143699003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Hn5YgVipdJkMVWHvfJvXJ1yD4eY5ZYfXm4/zCcmqb4Pv1JL9ZO77HTp7fbINHjmoyd8c/mTQYm6kZ/7NDl30s8Jo8px5A8kRwMTKhQDh3SwgOkxxUukIvTOa0Pwhh89pgCX8YQzeOgfqSKPGUWWZ3VhhVQQ29mdeU6OpHm163l28B0HhDJg8aM9XDU8wc5aI1n/pzTpFypTFKHzXT+fqAXDHyEH/pBPVDMHW1CYcrjXFOh7aYvEX7XAZuNo7hYKV4Mj6rtBQIOoyLlLiSLnG/W9ReXh4Ni+em1DFgmlqJhH6C6HrWsoOFc+H8gwQbCOOIJJiOOkEUNSEM0Mg0duPv1PIp/yHchD0BSYgjZdhJWRdqb/j8p8ZEDqaxFHWind7hlllkjeBXoHibBkwMG/7Qad+RthopKbTVxQWO06UAQbIe5HMpL+dGFNk0ReQVizQQT5tfVGlDl0zFlNj91R8lDDStRwyAxnZjKugMSpGSjoeV+u5xX7dIPCiwEx9kFSyCwwBJMKW01FDUfPxFH8okpUNrSN3MUGleowb3lx9KudTYTJn0caRkOmVg0HjAGKYUy9tokxAgUHZDq+vTEw8V+x6MKygxMgAMlzaP79XPiaXizlZEvAgQVwpOXqLkUXHpb5s//sjOxaOvDPlddt8K3IH3V6ICBLaFYEgjvYoD7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(23010399003)(56012099006)(261009223027099003)(11063799006)(5023799004)(4143699003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SozDnlVbPEzrNs56RCTkeYLDOfZF2JznIthYng4p9B2kgcEeIMc6Xgt1O2SL?=
 =?us-ascii?Q?pfuMjjgzzsTRlMpKlqQ3WPtemmFK7aLiujJxshmX0IkQU3Tgji5NvR34kue7?=
 =?us-ascii?Q?6DbqZRrNveDj0jkaRaDViV1Qs1y7XsHsa7WcTKkgYaxOTpoJhgkzagrXrQ2h?=
 =?us-ascii?Q?MuGOaa8a2nyMmQbXGvVKLwNT4WPLDG/+nBqeYREtalZJVxr/kO17ucDfr9TC?=
 =?us-ascii?Q?agwZikiHnsP+0mInIhbdIP+FhhxDvhFha379+EDphJBI/fGAG2a7hVnWBM7u?=
 =?us-ascii?Q?GgfqeF38cfVINMnM8I5f6Gf3EvfKPox/36UOYK08SVyDNsVAlgxsLUlRyAd4?=
 =?us-ascii?Q?EQ26CnS/LuGnsiVBSs/9v3k6FAZYJ0CzsMfCGJhkrmPogZbWVHy+Fy+zbta0?=
 =?us-ascii?Q?oF97JvFa9AHEJdqytIHkxVNVCjNSGGROFz93bvyQFvii0IHkvDeBPVq387bg?=
 =?us-ascii?Q?+Fb7kO3lMKIFsboXrYhIL+pg1aPHjD6+jpOvaAnKjJHjNSPWi54VWfAuDwOl?=
 =?us-ascii?Q?FzzBAQ2Nw/5VXtYreVt+b1gMJIHigOe2j8za3qzY0fD564BXpEnW8Qh+lLhb?=
 =?us-ascii?Q?CyH+JO+JhQT07H4NjGJAXF24HxOM4PyYy8WApkPocb7juAUOXALSITjNBLwh?=
 =?us-ascii?Q?m454Pp4+jEbIEm2XRTXvZJz+kRn9NFJeGYpMU9ANC0J6yEab29Hc4iL1TRj9?=
 =?us-ascii?Q?lHeNf2D+5WXWj8068nqjClrXahBkexi+hs4JIvuANq5wGg9sUyDI27boGbDx?=
 =?us-ascii?Q?IEDp4JyBCBMCQBXRnMPnsmIEP678Ax/5FuHsNSVR+Y1HLUHYN2zVvvCLs/Om?=
 =?us-ascii?Q?MvqxABWq+ihUSkqOD53ZYSKOS2k2mNZZoiu8o/05yQuqjyepmBuafp4dYaBt?=
 =?us-ascii?Q?cakCSyqlsiA3sFUU7oQmQ1pLVtNwkEK3qTHcBBqhlQzg3RV6qXtR5yimO0Mc?=
 =?us-ascii?Q?ooXMYdlmS2NKuCTCvAsd9KDhSBaig1B/bFhzHTgzZ54J+Mn+g8fnoBgKiHp6?=
 =?us-ascii?Q?hDu/2f2pKErOWzAfdtNa5DLwvLFW+fuKPElappCLfqGFVciC5h0O6VSXlkfs?=
 =?us-ascii?Q?LGUojdNx7gIIlUDWQyNLDtP4GLen1YpaexEEgaVlcBx1quOvWRELykiMOqKu?=
 =?us-ascii?Q?iMEHhs3dayp37qy3y2tqfcWdC1Uf8jMBVpER3dgcg/7LeSusBVDVWvi3KbOo?=
 =?us-ascii?Q?bMMshBixotFFIH3DLYF4rbCVyRcQe2c8p5Iemb64nHs4ZwNHe2asrXalOfut?=
 =?us-ascii?Q?IedZ/oMUXnEaA+zA4vv8z7QHJsy2KnKvWWLP0n7G3BacdOK6u868qHa/Msbi?=
 =?us-ascii?Q?ueM/aOMUYa5AeeaMxq6haK8b2wLiouUbM45aNLeWAxn0l4eKOfPZ9ZyMUvg1?=
 =?us-ascii?Q?JdMfJj2o0Vppy/0JAIy+PbAFHN4bjEupwGXGxNjSwLCs1K3OvDkrFnHvMfT5?=
 =?us-ascii?Q?KeYKOtqa77LTCpbzv0UybLK9JIfMgLCaPETPQIuCz5sx29vPWwjRLnTsKMRT?=
 =?us-ascii?Q?3UZ2oLjXn/nb4YAJnKUVBvAcrX6R+bYVKF+/8ojyXVvGF5i6IoJCXbOFuvE9?=
 =?us-ascii?Q?XAOxH7J7BnQvXNxz7VpJZJOMXdDDiwm1wUp4RiOZFDyNFPpAMDctCMVBcxLL?=
 =?us-ascii?Q?pYa/17ExBsHeV6DsJ5vKyX/d4nxwXRdapKBpsnZFyPAEy9D4HOiH5Fc+RHcx?=
 =?us-ascii?Q?ub0NaTDZ7miNMsu09Ii7lBY5qiWU95tn+hHe2H1PVdUBH8ONaqFy0YCbLJbg?=
 =?us-ascii?Q?q//ouCpyES/p6dkrgTd1H/t7ZLWfed4OCrmoR0+2DZBrIWXMHWLU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1af3a02-4f7c-4d40-7e11-08df2a60d30e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 02:05:45.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lqy2Dd1cdpA//be+pVRmrFI+7rx149JDwKP+y5V4JVPrEwy75MnHdXv9vJI6KEPnZdG+8bDfVd/qeObr4HXtfqgGYaNJNBt87+LL7nXSx+o9BTHDfKC344lzE0c7lKdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11022

On Thu, Oct 15, 2026 at 10:44:01AM +0900, Koichiro Den wrote:
> Use a local epf pointer in epf_ntb_configure_interrupt() to shorten the
> repeated ntb->epf accesses.
>
> No functional changes.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v4:
>   - New patch. (Frank)
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index a11f9260ee86..d74402ea10bf 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -545,12 +545,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> +	struct pci_epf *epf = ntb->epf;
>  	struct device *dev;
>  	int ret;
>
> -	dev = &ntb->epf->dev;
> +	dev = &epf->dev;
>
> -	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
> +	epc_features = pci_epc_get_features(epf->epc, epf->func_no,
> +					    epf->vfunc_no);
>
>  	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
>  		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
> @@ -564,10 +566,7 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	}
>
>  	if (epc_features->msi_capable) {
> -		ret = pci_epc_set_msi(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      16);
> +		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);
>  		if (ret) {
>  			dev_err(dev, "MSI configuration failed\n");
>  			return ret;
> --
> 2.54.0
>
