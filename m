Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515802;
	b=cTVmQQ1+q9f79v9LbOHsIxvbL3K0CW/jRuWs6c6nTY2zP6iXtTEq/AeBVHXozT/RyZOc
	 lQD0n7k2Ui/g7Gk3Ng9Wlvklm6roF5zi8dLv4aWblKxnZKdmja4h26aPnRk5xXfNO3HLX
	 IpJqtWaYVLixm9ZV0SpIMvgTMtkeznq8MwlVWCh3YhlszXRF+Bbw2vFo/igOO99EBEGDJ
	 8ZRJ2RXGjNDLiOoHNUj+K+ItNIDGo2Zkno01cpumsfJ2T1apiUUMo2TAxcuQWrsTbyfkU
	 H9XLyzHsMSzZ1+T3/aVN2cQUwhrqtTUUVtTncvyNbIdV/wDyB+ebJPwc14hPOEP1gLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515802;
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
	bh=HLygSldqrazNR7nErNE+CkiMUpATeacE7+/HdTH2jck=;
	b=H6yjLP1gmrtD1Xw3yItirWhcBxcUXi4nw49yOrUMpHlXR9gASxjc7cPW5uYBGYEX5JlL
	 YU4xZVUiBKPQSd5P+swjU8zhNdtlUYyvDBk/AWTpt8g58Irbix3Uhrhl+5U/XqF4FrUOi
	 Gpr/3bf7AByEzh86CGYbzIMNgV1rdoEq3dSBDuS6JdFx/nCUHt4EVrtgiy/jDBoRbpBP9
	 V/1V417iEGWaUOGTjFz3qklmhb7PJBDqexOHJqxKwnV+0hddB7fJ5+/DFpu5IVRREtk4V
	 lTnV1ZBVsCgnoIAXAL9GYH/5hxi8EuvZ2MEC1c4JhsYZ8wrtQqofvZ3fem3nRaQ5KMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rulMwm7K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.30
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94B606A31F;
	Tue, 20 Oct 2026 17:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E94B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rulMwm7K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naNDBxalh6ylcueNBXgPNrpMmWbyt/lIem4klHR2GgZkFWrrUhM/endf3prS9696K69iJmK9qPfBCJECXgkjAEu2flqKxaTjpURjMLKZxm9oyfdZS++Hq/InX9Vfc/glnXhtHkNJ9N1PTSl2nWF+RaH/OSNaHmzIUjhyxewPLyAAI+EDbx1M9MatWmrm4EW/45/BvZDW74YYjCpjTBPmwdqlGHSCA+nCZFsPJqohKim3sepgBB701Ey5MhGZTyM7x8teOWlcIL5bqmbzVOL4IXkDV8cyJO604JpPGUy0oboa3f56+iukXtNZZmlhnISaC2Y7+XftWwXyK8eExIuplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLygSldqrazNR7nErNE+CkiMUpATeacE7+/HdTH2jck=;
 b=oeZ17wW50cEH57ZrM1talWzPNsDfW4hVN6+gsZnzfVtbA9yThwfXeesvxYi+P2pnD0UaYbwm2an0dz/ENzUul5WIVpGQgnpmO3SRO7/fYRpjZPvtp+XdWxGTV1EDnhM+UHQsV0iErkY3lGhiVtIdqQscmCIgaCthjO8hzIfePi45VOPlCzmStP9icwnydiwSZnvjSfPJ8XbUI4qeyMW7LWuoa1I9GSqsEXpIAtIyNHf0H0FlcvGyKiep/kbBUGocZanJr5YVWNhZulbvhNYHhEpV7FvE4rxGvgglcy8npaqBRsiYir6J1gA6yNYGNd+Xcz4CyReE9fw66D6wHIy/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLygSldqrazNR7nErNE+CkiMUpATeacE7+/HdTH2jck=;
 b=rulMwm7KPrm5+8oMA2FN1Hs0Y+aRs1udVGNsBNb6As/e+p8V3meNfrNIb4Ac4J7HCWtT024yOz9A5occVrJqFW7ZZtsWisOoyVEnhh8YwgmXX7JJK8Bj4LFNid7Um9JEleHk0XWAmJQamXPpANlP1KODDVzUwvLWRXRsVxDB+uO+I1ETso1Xzp+HRLIbNUtrPH+YhOAXNZXEx/vm2DV9Nkqu8AuYHmqs1wYQfTWou0ZkbqfyT0s4mVFve144oTVfcbjknHbA3eko1LqLhpEeNjtmCO02H3Qg+tOeHSbrwgvJrykYy0MfdwNrHRmT6FMcEeZEhXoTB77XcjIv6hQH9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BESPR04MB687020.eurprd04.prod.outlook.com (2603:10a6:b10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 17:03:17 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 17:03:17 +0000
Date: Tue, 20 Oct 2026 12:03:05 -0500
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
Subject: Re: [PATCH v6 6/8] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Message-ID: <ateeydMZkyZcRDYl@SMW015318>
References: <20261020054948.1218370-1-den@valinux.co.jp>
 <20261020054948.1218370-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020054948.1218370-7-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BESPR04MB687020:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cad1a4-23d4-4cd5-4d2f-08df2ecc095c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ldnHC4s5Ljc6nexzOOX1j/1E4kel9Uuc8VK0EhWR0D6z2AxufA1xP5ttmxmgqPHBu01YHc5/SzjlVBmvd3O0JlZ50nk9n/s35XWrHSS20F+dqc1QxPkdbm7WcVvyzY9aXCFhZsW4R0ofxdpC/Bph72Sl/oAJC3+fUG15iCAJJif7CE/FJcKjZ2Ptf1kgmrJm/91drAHqrg74kPNfFhKKf86pmZT09WcDtfBcxUs7Y4DN5RJy1mnfJq8rJanbCb6QFPSBc+4J5HwvyJVinqGxFsggJDoWQei7Sb1k0OK5TBDOG+IUxUHICbvGXtGVHPqi/wVD/rRiaB8/v4PYtFdCxxANcnilMDf9T4eUoHti+9cdHLTbKF0+GRSJdhd/p9eykG75EIZ2VWaf9i6F4/OCRtT5g/T4bqHKGRND5ylyEMm4EZJtrUg3kZH1J5OUnia9zTv/bOTRCMtFxD50OIfbmuaJsJfnVN9bI1H0xiN0E9tamf2jl9G6ktknY8fAIkXK1KO/DcElonwiVF+grWvzswKjdM0P4MgPU7rKlRZkn8suqBCQf/tUQZ9yVZvJ3uLRHs/CKE8GYWxl1uMGCSs7VZVPF1tXZB71ppZildpYS7+NZVb/j6sry59fIFGRI2ZU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xg1i5FDBrmiVU/OuWj75OYR0/0hSK+KfbAXn1XmDCnYRJRGOKbZk1BlAFG5j?=
 =?us-ascii?Q?h4gOiLl+9Ga3IUFMxC0h9xfNfusuKM7H7LsGS4Bta/VwtVGZ71ZTqm6vwy+m?=
 =?us-ascii?Q?u+kPfRqjcOXDJPOIVGNHyyPmz7W82lYU9Aq6n62RnHi6ynICz23+LOGOE5jQ?=
 =?us-ascii?Q?kRGdm+YAcA8slS+RJ6QaNMGC5WPsUl5pQgrfn701WUPkZTBdxUNHEwl+FOro?=
 =?us-ascii?Q?wMz2YRRZW8A1aNnF9XdyFO7YgVIQJ4sgwuTGOXwgoOlXx69izJpB3Jpv/IIo?=
 =?us-ascii?Q?FAfgqUU512Qiz7UAdJbOtkT5jlKrQO2eQB0K+uNt7Cvud1Cv8TlkOTEGZBY9?=
 =?us-ascii?Q?PAHMmjtUS93C8Tp4/XyjIll26ygIXv85s/e1RFuY0cs8VON67Vsyz9C0DBO7?=
 =?us-ascii?Q?hPZRanyoDKKKuo1FFxB5tIl4h7QN86QQpkjBC9WxmUg5Ys/5qAIeOaOgckFJ?=
 =?us-ascii?Q?ulTKloOKRYlKH5Fa2/CGFlOcgeHQLu3paCTCk64poHWXSLV95SLO4tAg+u2O?=
 =?us-ascii?Q?7dk9ydo2aK1qpLr2mjXVLYVthXIlFewt8+ob9uuXFhYpcIeC7aHYV4DqQWfJ?=
 =?us-ascii?Q?UnIbU3BqKJybPhtPZa9lm/23RqdKEh0L8r7v+jnVSfdCXJ7XDefhDw5TtNVw?=
 =?us-ascii?Q?syRj+LD613qljARW3We/TMq/XbACmM8Bcv/HdU+LQH/Ps+oo6fXzhT3e4Zhh?=
 =?us-ascii?Q?GyT++Y067ObPPQ2ICWmLQtCY7WxCJ1Hd+iMr2ESGqA19cYKEzk2q6ff1EhAC?=
 =?us-ascii?Q?jStCCxvHJUEQUWY3Zgb4EdLIi0sTfzXaVbfbhRJHE+k7/LOqONLKzj3ZH5Se?=
 =?us-ascii?Q?XFuW+vzthrM+LyRxehrqkIQt/5aM7h2S4Q3fhNvmcHAjkqGqJb7CPf9EEpXA?=
 =?us-ascii?Q?MaBSTnrCcKBj5dDE9sMlFn4OnbZWjBOndwSVOzUX7a4ZiSOOdqOkffz/ilDn?=
 =?us-ascii?Q?VU6Z0ig1E84Lm77lkNufDST5gXrRw7Hj4UKyuYaaNOBmGulN9d1w+xbp7Zff?=
 =?us-ascii?Q?ivGpgMabfXN4IvqqDQ5R1FDUAA+4PuGYPyTbf9kr6DFCUraWl9DtjJ/l8ibt?=
 =?us-ascii?Q?4s9MsCksAXg7kZV/ug4hydyQpvN1G8xxmjCSxRCXE+GkNzNOND4XKkzUOFop?=
 =?us-ascii?Q?+SRzVYOoft95qQ3/SyTussOVD4KpLOzEo/Mu8FrH3DfaCS3siJBgLn3UX5g8?=
 =?us-ascii?Q?Eq/ZXSDehkOv3+Ayb51D64ACGWlESPRHrYR4tp93NEczAqjjTP0gBQ7vgR+a?=
 =?us-ascii?Q?2BzZIw79kSuniyOL4+fWdc5kYXMI5q3h/Lfsqh0/9VgYgJYPoZao+FYPxWlG?=
 =?us-ascii?Q?MZh1Q+L//qQ6wp1izUUmkPDeeBQ7pP8oEGGGCFn2mOyKJp6TjueHC1f7kbwL?=
 =?us-ascii?Q?WWsRPIWSDXXD9hJGaxP5KwTKlO4x1gR9KK7AD6mj6xrv9GW9Lk9jwQrcBvbJ?=
 =?us-ascii?Q?pHY20WNTszMBcwFwAkH56C1jDjieyxVFtJ87Kdt6DuXj1uIkvY1i0t/YUF11?=
 =?us-ascii?Q?LgqoQgZbSKL/lRRFp3LHgmVo6flJ+NYpbcDuj0hKkxSvN1mhScj/SvlEgRIT?=
 =?us-ascii?Q?yS7wbYaPZnSvogbZIsnfJ3rQ2TGAOMBK/d/s6H2ILy4OwIEcTebo6QFrppNO?=
 =?us-ascii?Q?qhgEaD/cWRh7UK0e9puhj0ZtvtWQwdRyTkFc/pIHB29evsj/zY7xoGePu8j9?=
 =?us-ascii?Q?ZhwyenAiaJRxt97eO5oT2TeHTX/y9tOdRc9ZW5BIeBhzhkqJfmu7hdaEDQWC?=
 =?us-ascii?Q?1DtsO/Rb5CLndfKMXNJ9a+1lUoxz1vuAZqvMWmj4WMghb5fOV5Cw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cad1a4-23d4-4cd5-4d2f-08df2ecc095c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:03:17.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uDsMWEspL1bagxRY7fIq8I8A4ej6joNL3am8czMc2FlHlHVDgdFLAUolrAMM1wDopXMp3olQ4VN7spKQw92xRBRZ7/VUQUH3Lrm7Pa+G0VllRFzC8LhAZSLhZeS3U8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB687020

On Tue, Oct 20, 2026 at 02:49:46PM +0900, Koichiro Den wrote:
> A vNTB PCI function can now expose endpoint-local DMA channels to its
> host. Decode the extension and register the advertised channels before
> the NTB device, so clients of that NTB device can use the DMA
> functionality in the same PCI function. Endpoints without the extension,
> or hosts without support for its DMA type or with no DMA IRQ available,
> continue without DMA.
>
> Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> and keep type-specific setup in local helpers. Support for another
> implementation can add a new case and its own helpers.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v5:
>   - Derive the control region and DMA extension offsets from
>     include/linux/pci-epf-ntb.h instead of hard-coding them. (Frank)
>   - Move shared-MW boundary handling to the BAR-sharing patch.
>   - Link to v5: https://lore.kernel.org/r/20261009045949.1109871-7-den@valinux.co.jp/
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 273 +++++++++++++++++++++++++++++++-
>  1 file changed, 267 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index ff92c2a61ce7..e0016128b95c 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/atomic.h>
>  #include <linux/delay.h>
> +#include <linux/dma/edma.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -18,6 +19,12 @@
>  /* Offsets into the control region, see include/linux/pci-epf-ntb.h. */
>  #define NTB_EPF_CTRL(field)	offsetof(struct epf_ntb_ctrl, field)
>
> +/* Private DMA wire extension produced by pci-epf-vntb. */
> +#define NTB_EPF_DMA(field)	(EPF_NTB_DMA_CTRL_OFFSET + \
> +				 offsetof(struct epf_ntb_dma_ctrl, field))
> +#define NTB_EPF_DMA_REGION(field)	\
> +	offsetof(struct epf_ntb_dma_region_ctrl, field)
> +
>  /*
>   * Legacy doorbell slot layout when paired with pci-epf-*ntb:
>   *
> @@ -71,6 +78,24 @@ struct ntb_epf_irq_ctx {
>  	unsigned int irq_no;
>  };
>
> +struct ntb_epf_dma_region {
> +	unsigned int bar;
> +	resource_size_t offset;
> +	resource_size_t size;
> +};
> +
> +struct ntb_epf_dw_edma {
> +	struct dw_edma_chip chip;
> +	struct ntb_epf_dma_region reg;
> +	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
> +};
> +
> +struct ntb_epf_dma {
> +	struct ntb_epf_dma_region submap;
> +	unsigned int nr_irqs;
> +	u32 type;
> +};
> +
>  struct ntb_epf_dev {
>  	struct ntb_dev ntb;
>  	struct device *dev;
> @@ -82,6 +107,8 @@ struct ntb_epf_dev {
>  	unsigned int mw_count;
>  	unsigned int spad_count;
>  	unsigned int db_count;
> +	struct ntb_epf_dma dma;
> +	struct ntb_epf_dw_edma dw_edma;
>
>  	void __iomem *ctrl_reg;
>  	void __iomem *db_reg;
> @@ -136,6 +163,213 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>  	return ret;
>  }
>
> +static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
> +				     bool optional,
> +				     struct ntb_epf_dma_region *region)
> +{
> +	void __iomem *reg = ndev->ctrl_reg + base;
> +	resource_size_t bar_len;
> +	u32 bar, offset, size;
> +
> +	bar = readl(reg + NTB_EPF_DMA_REGION(bar));
> +	offset = readl(reg + NTB_EPF_DMA_REGION(offset));
> +	size = readl(reg + NTB_EPF_DMA_REGION(size));
> +	region->bar = bar;
> +	region->offset = offset;
> +	region->size = size;
> +	if (!size)
> +		return optional && bar == U32_MAX && !offset;
> +	if (bar > BAR_5)
> +		return false;
> +
> +	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
> +	if (offset > bar_len || size > bar_len - offset)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* DW eDMA */
> +
> +static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
> +{
> +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> +	struct dw_edma_chip *chip = &edma->chip;
> +	u32 count, chan_offset, chan_size;
> +	unsigned int i;
> +
> +	chan_offset = offsetof(struct epf_ntb_dma_ctrl, chan);
> +	chan_size = sizeof(struct epf_ntb_dma_chan_ctrl);
> +	if (length < chan_offset + chan_size ||
> +	    (length - chan_offset) % chan_size)
> +		return -EINVAL;
> +
> +	count = (length - chan_offset) / chan_size;
> +	if (count > EDMA_MAX_RD_CH)
> +		return -EINVAL;
> +
> +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(reg), false,
> +				      &edma->reg) ||
> +	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
> +		return -EINVAL;
> +
> +	chip->mf = EDMA_MF_EDMA_UNROLL;
> +	chip->ll_rd_cnt = count;
> +	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
> +
> +	for (i = 0; i < count; i++) {
> +		u64 paddr;
> +
> +		if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(chan[i].desc),
> +					      false, &edma->ll[i]) ||
> +		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
> +			return -EINVAL;
> +
> +		paddr = readl(ndev->ctrl_reg +
> +			      NTB_EPF_DMA(chan[i].desc_addr_lo));
> +		paddr |= (u64)readl(ndev->ctrl_reg +
> +				    NTB_EPF_DMA(chan[i].desc_addr_hi)) << 32;
> +		if (paddr == U64_MAX)
> +			return -EINVAL;
> +
> +		chip->ll_region_rd[i].sz = edma->ll[i].size;
> +		chip->ll_region_rd[i].paddr = paddr;
> +	}
> +	ndev->dma.nr_irqs = count;
> +
> +	return 0;
> +}
> +
> +static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	struct ntb_epf_dev *ndev = dev_get_drvdata(dev);
> +
> +	/* DMA vectors follow the NTB link and doorbell vector block. */
> +	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
> +}
> +
> +static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
> +	.irq_vector = ntb_epf_dw_edma_irq_vector,
> +};
> +
> +static void __iomem *
> +ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
> +			   const struct ntb_epf_dma_region *region)
> +{
> +	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
> +}
> +
> +static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
> +{
> +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> +	struct dw_edma_chip *chip = &edma->chip;
> +	struct pci_dev *pdev = ndev->ntb.pdev;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Install BAR submaps before mapping the advertised DMA regions. */
> +	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_SETUP_DMA_BAR, 0);
> +	if (ret)
> +		return ret;
> +
> +	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
> +	if (IS_ERR(chip->reg_base))
> +		return PTR_ERR(chip->reg_base);
> +	for (i = 0; i < chip->ll_rd_cnt; i++) {
> +		chip->ll_region_rd[i].vaddr.io =
> +			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
> +		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
> +			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
> +	}
> +
> +	chip->dev = ndev->dev;
> +	chip->nr_irqs = ndev->dma.nr_irqs;
> +	chip->ops = &ntb_epf_dw_edma_ops;
> +	chip->flags = DW_EDMA_CHIP_PARTIAL;
> +
> +	return dw_edma_probe(chip);
> +}
> +
> +static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
> +{
> +	dw_edma_remove(&ndev->dw_edma.chip);
> +}
> +
> +/* Common endpoint DMA */
> +
> +static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
> +{
> +	u32 magic, type, spad_off;
> +	u16 revision, length;
> +	int ret;
> +
> +	/*
> +	 * Legacy endpoints place scratchpads where this extension would begin.
> +	 * Once the extension is present, malformed metadata is fatal.
> +	 */
> +	spad_off = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
> +	if (spad_off < EPF_NTB_DMA_CTRL_OFFSET + EPF_NTB_DMA_CTRL_COMMON_SIZE)
> +		return 0;
> +
> +	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA(magic));
> +	if (!magic)
> +		return 0;
> +	if (magic == U32_MAX)
> +		return -EIO;
> +	if (magic != EPF_NTB_DMA_MAGIC)
> +		return -EINVAL;
> +
> +	revision = readw(ndev->ctrl_reg + NTB_EPF_DMA(revision));
> +	length = readw(ndev->ctrl_reg + NTB_EPF_DMA(length));
> +	if (revision != EPF_NTB_DMA_REVISION ||
> +	    length < EPF_NTB_DMA_CTRL_COMMON_SIZE ||
> +	    spad_off < EPF_NTB_DMA_CTRL_OFFSET + length)
> +		return -EINVAL;
> +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(submap), true,
> +				      &ndev->dma.submap))
> +		return -EINVAL;
> +
> +	type = readl(ndev->ctrl_reg + NTB_EPF_DMA(type));
> +	if (type == U32_MAX)
> +		return -EIO;
> +
> +	switch (type) {
> +	case EPF_NTB_DMA_TYPE_DW_EDMA:
> +		if (!IS_REACHABLE(CONFIG_DW_EDMA))
> +			break;
> +		ret = ntb_epf_dw_edma_parse(ndev, length);
> +		if (!ret)
> +			ndev->dma.type = type;
> +		return ret;
> +	default:
> +		break;
> +	}
> +
> +	dev_warn(ndev->dev,
> +		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
> +		 type);
> +	return 0;
> +}
> +
> +static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
> +{
> +	switch (ndev->dma.type) {
> +	case EPF_NTB_DMA_TYPE_DW_EDMA:
> +		return ntb_epf_dw_edma_init(ndev);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
> +{
> +	switch (ndev->dma.type) {
> +	case EPF_NTB_DMA_TYPE_DW_EDMA:
> +		ntb_epf_dw_edma_deinit(ndev);
> +		break;
> +	}
> +}
> +
>  static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>  {
>  	struct device *dev = ndev->dev;
> @@ -347,16 +581,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  {
>  	struct pci_dev *pdev = ndev->ntb.pdev;
>  	struct device *dev = ndev->dev;
> +	unsigned int dma_max = ndev->dma.nr_irqs;
> +	unsigned int dma_min;
>  	u32 argument = EPF_NTB_MSIX_ENABLE;
> +	unsigned int ntb_irqs;
>  	int irq;
>  	int ret;
>  	int i;
>
> -	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> +	irq = pci_alloc_irq_vectors(pdev, msi_min,
> +				    msi_max + dma_max, PCI_IRQ_MSIX);
>  	if (irq < 0) {
>  		dev_dbg(dev, "Failed to get MSIX interrupts\n");
> -		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
> -					    PCI_IRQ_MSI);
> +		irq = pci_alloc_irq_vectors(pdev, msi_min,
> +					    msi_max + dma_max, PCI_IRQ_MSI);
>  		if (irq < 0) {
>  			dev_err(dev, "Failed to get MSI interrupts\n");
>  			return irq;
> @@ -364,8 +602,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  		argument &= ~EPF_NTB_MSIX_ENABLE;
>  	}
>
> -	ndev->db_count = irq - 1;
> -	for (i = 0; i < irq; i++) {
> +	dma_min = dma_max && irq > msi_min;
> +	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
> +	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
> +	ndev->dma.nr_irqs = irq - ntb_irqs;
> +	if (dma_max && !ndev->dma.nr_irqs) {
> +		dev_warn(dev,
> +			 "No IRQ available for endpoint DMA, continuing without DMA\n");
> +		ndev->dma.type = 0;
> +	}
> +	ndev->db_count = ntb_irqs - 1;
> +	for (i = 0; i < ntb_irqs; i++) {
>  		ndev->irq_ctx[i].ndev = ndev;
>  		ndev->irq_ctx[i].irq_no = i;
>  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> @@ -377,7 +624,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  	}
>
>  	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_DOORBELL,
> -				   argument | irq);
> +				   argument | ntb_irqs);
>  	if (ret) {
>  		dev_err(dev, "Failed to configure doorbell\n");
>  		goto err_free_irq;
> @@ -610,6 +857,11 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
>  		return -EINVAL;
>  	}
> +	ret = ntb_epf_dma_parse(ndev);
> +	if (ret) {
> +		dev_err(dev, "Invalid endpoint DMA layout\n");
> +		return ret;
> +	}
>
>  	/* One Link interrupt and rest doorbell interrupt */
>  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> @@ -760,6 +1012,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  		goto err_init_dev;
>  	}
>
> +	ret = ntb_epf_dma_init(ndev);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize endpoint DMA\n");
> +		goto err_dma_init;
> +	}
> +
>  	ret = ntb_register_device(&ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
> @@ -769,6 +1027,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  	return 0;
>
>  err_register_dev:
> +	ntb_epf_dma_deinit(ndev);
> +err_dma_init:
>  	ntb_epf_cleanup_isr(ndev);
>
>  err_init_dev:
> @@ -782,6 +1042,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
>  	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
>
>  	ntb_unregister_device(&ndev->ntb);
> +	ntb_epf_dma_deinit(ndev);
>  	ntb_epf_cleanup_isr(ndev);
>  	ntb_epf_deinit_pci(ndev);
>  }
> --
> 2.54.0
>
