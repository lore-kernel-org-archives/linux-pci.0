Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792598045;
	b=sJWDL2gSI1rX1xNJdinsS6Vcwe/Qx2jN/dMcadxiw54sgeENEDpcwDJ04V5n8qDgeemR
	 5LExM647UkBc8VqSRGBFlXd43QyDAu6+BdJfcunIw1bLZfYujH/HMXsaV0pxEt7oo6DAE
	 UzisJZ/QRf9G05p4xnNEVuR0U3HzxUW3IoxQ90hPWtvrNvXKnWCuRny3I3tDnMAM4PRbb
	 lNloR47zMnCAlOqRv07HNGT2FRJZcLTOp05WrP6XMbZqzpYkXEWde/07IQ2q1P1Ub5XW5
	 nkx4XqIuq35HQF7xuNqwXG/TRub0ouzfAPLr30H6nFQfpeLmS61642UgmlEmWX6JJbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598045;
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
	bh=G1R2h2vH7/TnqNkkOl2llhpWcf6kwx6QPmBdoo/x2zA=;
	b=fyYhhnkTyqCTRvKRMW2Et5jiYa3U/DWx6hvR1P+AOSk2DgVWsR5evJ/ihXYUXpIucbFl
	 FOJr7RzRJy+3RgTK5xX81pV8EQdvIK07eyH1plVVItic4CEhb0ErVntWRK8Ce9+PQHgEl
	 PeLWdurD50/9LEVJHiS3BuJ72ISOcWC+Y6SGzjSZGOByBApWZb25nkmckWTpPZ0Er8L6H
	 firfrXaxMLh3fYaVMsXte18QWrzdvHjNoy3L5V0g3H+ruQvlfIRTl0JQ+Z7wQxEqTz5w2
	 LyblDuWHE0FM4ybAxnON6XjpT4SycIbV4xXjUWf8l9ht+KKqHia8s19+h1UIMI7ejYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aXDytekf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.18
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3C606A33B;
	Wed, 21 Oct 2026 15:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D3C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aXDytekf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZXr2Dyg79Y+ni8uJZcynDa/44Lkkq+6lRXtVChtYWPJj1gPdiQSfP4RNeNNTkCdT0NbvYfQsGLCFGme/78kHZ5E41mLOvvecasVGhqlsjntpoH8f7BSaIAGh5/rTVlQcyp8SlR7vbjDTslkZOd4fnl8Dz5LAVuOmD33alPRYhP/ZzJCk8p5mRR8ByAW60fmo0hiZ1YFFWlJp8gwZSU8xPoc0BgzCSKpka5ZDCpPdylJTVcmg+X2pzikWQniI6cdd8qFV3AAWss9l9GFw9xjCAWYRcmgdUwXXJwha9e9tuzW4UbqmKrAkzrrCDcl9FetHh7iAm8ZbvhgJnTl21ozWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1R2h2vH7/TnqNkkOl2llhpWcf6kwx6QPmBdoo/x2zA=;
 b=tZOJPYlCEKYFzwF4RhRkXGC3xisA9yLCYQRS6bf5lnpyUc+7O+5eGpz+cT24fd7pI/I339NMBGgA/cWyDtMLbz72XS0w5gXtrrKZ2Rli6YpRezx3eLuGXgqaoD6MobBp7eqO9YyujClOMdBmQKKQslvmU8pN4fl9/41TzV/ZUxdFSnVoZT2VWxEETDs0vv1iL972P30lQNP/hHy2XbcF9IDoUAj4UH/2A8qAQ1wZVHHNTRSJDf2Mymf0WWMShow28EuEUuysu19QXnLxhxQGBeuHHb0S21h+S41kj40UKwnO1l3g+JwmmekpXlcDsFuLF8h/O1CbiaBCKo9jSgiABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1R2h2vH7/TnqNkkOl2llhpWcf6kwx6QPmBdoo/x2zA=;
 b=aXDytekfyXiC96IdKOsLnm/oZXyP1N6FIaJ11LDdSaFHrYy9buG5g6WynuV1bFiMsBj5kyFg4VvnOzZ+JpOorr/AI2wgl4UtleVCKgJgsU8NSs++dF8iAhQHYx24uTUTqnoTq1mNLlVWPQs2t2vKoTOpk7vdzEvgsnMwMUiIXxmpv52RLU71PIgKpCoCBFLg8JSJk41oQnEgau4rQqjGJtPRtiMOzYGZWdl/GGPKaobrz/ivU1tPmxquroN7zmdXDzUzajoHyePj5xtVBwSR1KjpwoT06ieELT0SMfeULP6+og/dP6T9GIABZBzYFkCAoAxthsgn7XTc2y3CJicuuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:54:02 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:54:01 +0000
Date: Wed, 21 Oct 2026 10:53:51 -0500
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
Subject: Re: [PATCH v7 08/10] NTB: ntb_hw_epf: Use the shared NTB control
 layout
Message-ID: <atjgD2O1CoZm8o-Z@SMW015318>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021042229.2280937-9-den@valinux.co.jp>
X-ClientProxiedBy: DS7PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 5395a3e6-f8a4-4d3c-d4da-08df2f8b8681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|19092799006|11063799006|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HIO4MUNofRyyl9tO7hNiPByBm3dLPX6T7odBfSaH5HiiZcmrMDm2H2Fb4ygVq/MSwtBcGgXB5QGoYtHmbWyhTOJ6+3w9T0fu5xEerUSKBW9q/mwk2liIjHdxdSDXOTUokwxgujwzJYPCciEnw139RkIruL4nzhioiDQzrSXNcSiNKK+nIyEPn7WaXZ5TppQbHO95asU13AHriveTTC0rTntGrMUqGcSVg/ekvFYjg4RkN6pXxJsq3p/6aGqvN09jKxg4aDBJALEDqCkJmRwp4dY2RtG93WG9YySv8jYMjy+jGUEsjTBldoAzmZMyMnL2FjWUnr8ED5UfosGoLkbpfyCSlQal3sd28y8N/Kznn7Ky4Vz9xXp6ngwuhFNwqte7370WXPjuwnaJYAHl1LwcooFxoUE26v/Hup3ZkLzKPKrvaVcIt66wEPMYwjZhvv4dVU9ouRlnW9Ok538/d5HkrW8gbuDJDEkwBT7Rh0SYHuwO1Pd2ZnnIlPRzvPT3wP8jhGnnZaHj6rjnVilI69cQTNlo6njtwG8qMxCCmq7KJA/XKibWsRo8tXp0BVyYmsvKX8h80/gHQngzPHl+QXFtzXaXQ0AJXwf626P/pk/jziMtGDOEQII/MywHymLN2XbK+gLd96ebKhPE75R3TBXYTF9wWkQZzW4vLHNbDaeAezU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(19092799006)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MpKqflzbummawcqo6xPsYphFkBMcQTcoGZEG+xg5YqxaDXyo0hFqL0dS9JGQ?=
 =?us-ascii?Q?XqoE1Ky0+ZAMPBjLU1AGfExTuWvH18hgnf0l4XNVHge+Ue9EQNRMRR/E53kx?=
 =?us-ascii?Q?MSSctg2z5P6TLtnmQXWZSP2W0F7JUEYy9PehVQ0lLrrIVGaJtO2krn07UTiE?=
 =?us-ascii?Q?h4dA5uJxi2GvkVfZXCci0p5gHOoHMFpGjws0yH7+4TGB93wK7D04eaTwi8E+?=
 =?us-ascii?Q?JcfDtSkAaK6p/FvAiW5HESz1V90mTfcIOx6hO+rxMIEKk9qKN0j2v5xJPqeK?=
 =?us-ascii?Q?mmgBPWTwhBk2NKnpeFeA6bxk16QJIXyraPmCZOvMou7oAJqIn3/o1L2GY34J?=
 =?us-ascii?Q?qPQTknS0gKZUsOXAC5W3+Zh107XyljgRR7CGgBjrDTwY5NWa/RswAYcX5Wpb?=
 =?us-ascii?Q?XZGjD9d5GgrXeMYcp0ooKqI9/BJKSlbEiWVJIq95ezx3PvN19+noQ4ZygwM+?=
 =?us-ascii?Q?imCQXCUkqUr2PLXeM+GfMjBZLs29QKiECGrf6rHDcjLH+jaPf21rgOt6DKoe?=
 =?us-ascii?Q?R0h7Wwv2irEN1gnxgFI/q51jLAX3QmSaYDMax/wWIVFYPfmu/ZinZKyfiKj+?=
 =?us-ascii?Q?X6rP5+RGKhvsbKiJM4pox2a9X0BWNRp2jI/B+vN5QpRN7JqB8ywYdrkD9NV7?=
 =?us-ascii?Q?Q+qHLPMwzcdrfp7IbRRaqfUCv5BQPDrDOK6eCG1YilFOLRMzK+SUhZvaolbA?=
 =?us-ascii?Q?SwIz68GauZnHRgiJQYn+hGTrJA4ZQtzkcowgNTkQhamubV8AKzFmS9SqFWj5?=
 =?us-ascii?Q?YKwGJLmKdZuZGymx9LRi4UnGvBO4EK8VDoj6NC7yw2cXyHmPwfBQX1FM+/E5?=
 =?us-ascii?Q?549L2dBdc4Yr56TQOQd4KYRu4AtpDr5Mh1IkXfXVM4C15FpfWkRlRwjZtlTK?=
 =?us-ascii?Q?P+mW7Os2HYpUmU7rHuD11DXv/8Uucn/rLoUCbcmi/nmtdldF5e3FJmMb3+O8?=
 =?us-ascii?Q?XwQ9i94QD3CXWe9F2N2inco9MSQB2+bl5VRHDgjSCjYOlLI2hsxgLqMA0Tku?=
 =?us-ascii?Q?Bt5tslPOv7iwWnrq9mlfOx7igoCxfF7d1bOp9xiTI8fC8kIXZzpeYowJy2ri?=
 =?us-ascii?Q?hvOa4SCzl5m7bGQGvoYDV15MWW9Bk+LCxLoMnsZjEIJhR1COnchZ/4SEWYoX?=
 =?us-ascii?Q?kuWlUdnwxNeaUo1DXlaHPorstWBznODLn0wfDmqkrd13nx3N4xDGryGy1kjH?=
 =?us-ascii?Q?03EFb5Ji6l0NMShe73Emq0flAkmADeS/xalhh/tLSf6peTihaXMaj2kr1QEs?=
 =?us-ascii?Q?y38IJ2ZF2G9bXFv9Jb+A6ntgC50wPe5rQu2BvG2Aw3yhNcSQAn3Kgbcesa8U?=
 =?us-ascii?Q?c5Qm8e9R5GbU9rI6zHCbzY9XhrjqTDESDthqBsF+nwIuatMtYo9lXCZUpCH5?=
 =?us-ascii?Q?J2red54AKdFOPWNi0p+hMe24ba2Kfr0d2KPcPDB5s5kAIUY+WyhG/M+q/Bio?=
 =?us-ascii?Q?IIuzwNLWtLYhlVBETxk8peWfa00TWAq3KdZS7X6BiT2TFKANcA0ySeXrF4Kh?=
 =?us-ascii?Q?VhBRxYqmgcVqg9+gXzcUwDQ+byUBWih3DFmKSVPT7QXX4+K0iBJDJWx8ye82?=
 =?us-ascii?Q?sBE0yP4zTUMUPve0I48CB0BY2zrlnO2eFxpJy7tOnhmDZns9h37tMipXlxzA?=
 =?us-ascii?Q?yf55FeuvAJ8hMPe43H0zxIQMucily1OLx9rxmwa8DGP7LjH8MNuPALUSyXU4?=
 =?us-ascii?Q?a9TbP4p8NRIH1T+k9SdQ7YYAKpLNjWnq3TN9Jc+bKHgD47ydmjxiRsk948DX?=
 =?us-ascii?Q?0cNDDQRGuvkPb4TqhO8e/1AMd/3+/oq7ENDtnC8wubGItvhumhBs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5395a3e6-f8a4-4d3c-d4da-08df2f8b8681
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:54:01.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF5kaPOHrp6zRjF+td/8WfyK8J55Spi43c9MKGD059x58kqd43VRq2Qn8PGtX6crJ702dqkknpZaRXlkyVkI3Dk6pKwvqTyVsgzxjiyZcGwoFV+IdNlfIp1qd/Tzc0WS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953

On Wed, Oct 21, 2026 at 01:22:27PM +0900, Koichiro Den wrote:
> Currently, ntb_hw_epf.c duplicates the endpoint control layout with
> hard-coded register offsets.
>
> Use the shared struct and macros in pci-epf-ntb.h and derive offsets
> with offsetof().
>
> No functional changes.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v6:
>   - Split the host conversion out of the shared-header patch. (Frank)
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 95 ++++++++++++---------------------
>  1 file changed, 35 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index c47607d4f8a7..ff92c2a61ce7 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -8,41 +8,15 @@
>
>  #include <linux/atomic.h>
>  #include <linux/delay.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pci-epf-ntb.h>
>  #include <linux/slab.h>
>  #include <linux/ntb.h>
>
> -#define NTB_EPF_COMMAND		0x0
> -#define CMD_CONFIGURE_DOORBELL	1
> -#define CMD_TEARDOWN_DOORBELL	2
> -#define CMD_CONFIGURE_MW	3
> -#define CMD_TEARDOWN_MW		4
> -#define CMD_LINK_UP		5
> -#define CMD_LINK_DOWN		6
> -
> -#define NTB_EPF_ARGUMENT	0x4
> -#define MSIX_ENABLE		BIT(16)
> -
> -#define NTB_EPF_CMD_STATUS	0x8
> -#define COMMAND_STATUS_OK	1
> -#define COMMAND_STATUS_ERROR	2
> -
> -#define NTB_EPF_LINK_STATUS	0x0A
> -#define LINK_STATUS_UP		BIT(0)
> -
> -#define NTB_EPF_TOPOLOGY	0x0C
> -#define NTB_EPF_LOWER_ADDR	0x10
> -#define NTB_EPF_UPPER_ADDR	0x14
> -#define NTB_EPF_LOWER_SIZE	0x18
> -#define NTB_EPF_UPPER_SIZE	0x1C
> -#define NTB_EPF_MW_COUNT	0x20
> -#define NTB_EPF_MW1_OFFSET	0x24
> -#define NTB_EPF_SPAD_OFFSET	0x28
> -#define NTB_EPF_SPAD_COUNT	0x2C
> -#define NTB_EPF_DB_ENTRY_SIZE	0x30
> -#define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
> -#define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
> +/* Offsets into the control region, see include/linux/pci-epf-ntb.h. */
> +#define NTB_EPF_CTRL(field)	offsetof(struct epf_ntb_ctrl, field)
>
>  /*
>   * Legacy doorbell slot layout when paired with pci-epf-*ntb:
> @@ -132,20 +106,20 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>  	u32 status;
>
>  	mutex_lock(&ndev->cmd_lock);
> -	writel(argument, ndev->ctrl_reg + NTB_EPF_ARGUMENT);
> -	writel(command, ndev->ctrl_reg + NTB_EPF_COMMAND);
> +	writel(argument, ndev->ctrl_reg + NTB_EPF_CTRL(argument));
> +	writel(command, ndev->ctrl_reg + NTB_EPF_CTRL(command));
>
>  	timeout = ktime_add_ms(ktime_get(), NTB_EPF_COMMAND_TIMEOUT);
>  	while (1) {
>  		timedout = ktime_after(ktime_get(), timeout);
> -		status = readw(ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
> +		status = readw(ndev->ctrl_reg + NTB_EPF_CTRL(command_status));
>
> -		if (status == COMMAND_STATUS_ERROR) {
> +		if (status == EPF_NTB_COMMAND_STATUS_ERROR) {
>  			ret = -EINVAL;
>  			break;
>  		}
>
> -		if (status == COMMAND_STATUS_OK)
> +		if (status == EPF_NTB_COMMAND_STATUS_OK)
>  			break;
>
>  		if (WARN_ON(timedout)) {
> @@ -156,7 +130,7 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>  		usleep_range(5, 10);
>  	}
>
> -	writew(0, ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
> +	writew(0, ndev->ctrl_reg + NTB_EPF_CTRL(command_status));
>  	mutex_unlock(&ndev->cmd_lock);
>
>  	return ret;
> @@ -224,9 +198,9 @@ static u64 ntb_epf_link_is_up(struct ntb_dev *ntb,
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  	u32 status;
>
> -	status = readw(ndev->ctrl_reg + NTB_EPF_LINK_STATUS);
> +	status = readw(ndev->ctrl_reg + NTB_EPF_CTRL(link_status));
>
> -	return status & LINK_STATUS_UP;
> +	return status & EPF_NTB_LINK_STATUS_UP;
>  }
>
>  static u32 ntb_epf_spad_read(struct ntb_dev *ntb, int idx)
> @@ -240,7 +214,7 @@ static u32 ntb_epf_spad_read(struct ntb_dev *ntb, int idx)
>  		return 0;
>  	}
>
> -	offset = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> +	offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
>  	offset += (idx << 2);
>
>  	return readl(ndev->ctrl_reg + offset);
> @@ -258,7 +232,7 @@ static int ntb_epf_spad_write(struct ntb_dev *ntb,
>  		return -EINVAL;
>  	}
>
> -	offset = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> +	offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
>  	offset += (idx << 2);
>  	writel(val, ndev->ctrl_reg + offset);
>
> @@ -316,7 +290,7 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
>  	struct device *dev = ndev->dev;
>  	int ret;
>
> -	ret = ntb_epf_send_command(ndev, CMD_LINK_UP, 0);
> +	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
>  	if (ret) {
>  		dev_err(dev, "Fail to enable link\n");
>  		return ret;
> @@ -331,7 +305,7 @@ static int ntb_epf_link_disable(struct ntb_dev *ntb)
>  	struct device *dev = ndev->dev;
>  	int ret;
>
> -	ret = ntb_epf_send_command(ndev, CMD_LINK_DOWN, 0);
> +	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_DOWN, 0);
>  	if (ret) {
>  		dev_err(dev, "Fail to disable link\n");
>  		return ret;
> @@ -373,7 +347,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  {
>  	struct pci_dev *pdev = ndev->ntb.pdev;
>  	struct device *dev = ndev->dev;
> -	u32 argument = MSIX_ENABLE;
> +	u32 argument = EPF_NTB_MSIX_ENABLE;
>  	int irq;
>  	int ret;
>  	int i;
> @@ -387,7 +361,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  			dev_err(dev, "Failed to get MSI interrupts\n");
>  			return irq;
>  		}
> -		argument &= ~MSIX_ENABLE;
> +		argument &= ~EPF_NTB_MSIX_ENABLE;
>  	}
>
>  	ndev->db_count = irq - 1;
> @@ -402,7 +376,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  		}
>  	}
>
> -	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
> +	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_DOORBELL,
>  				   argument | irq);
>  	if (ret) {
>  		dev_err(dev, "Failed to configure doorbell\n");
> @@ -494,11 +468,9 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  		return -EINVAL;
>  	}
>
> -	writel(lower_32_bits(addr), ndev->ctrl_reg + NTB_EPF_LOWER_ADDR);
> -	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
> -	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
> -	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
> -	ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
> +	lo_hi_writeq(addr, ndev->ctrl_reg + NTB_EPF_CTRL(addr));
> +	lo_hi_writeq(size, ndev->ctrl_reg + NTB_EPF_CTRL(size));
> +	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_MW, idx);
>
>  	return 0;
>  }
> @@ -509,7 +481,7 @@ static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
>  	struct device *dev = ndev->dev;
>  	int ret = 0;
>
> -	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
> +	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_TEARDOWN_MW, idx);
>  	if (ret)
>  		dev_err(dev, "Failed to teardown memory window\n");
>
> @@ -524,7 +496,7 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  	int bar;
>
>  	if (idx == 0)
> -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> +		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
>
>  	bar = ntb_epf_mw_to_bar(ndev, idx);
>  	if (bar < 0)
> @@ -562,10 +534,12 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>  		return -EINVAL;
>  	}
>
> -	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_DB_ENTRY_SIZE);
> +	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_CTRL(db_entry_size));
>
> -	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
> -	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
> +	db_data = readl(ndev->ctrl_reg +
> +			NTB_EPF_CTRL(db_data[interrupt_num]));
> +	db_offset = readl(ndev->ctrl_reg +
> +			  NTB_EPF_CTRL(db_offset[interrupt_num]));
>  	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
>  	       db_offset);
>
> @@ -631,7 +605,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	struct device *dev = ndev->dev;
>  	int ret;
>
> -	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> +	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
>  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
>  		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
>  		return -EINVAL;
> @@ -650,7 +624,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	 * doorbell layout, hence -1.
>  	 */
>  	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
> -	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> +	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_count));
>
>  	return 0;
>  }
> @@ -702,8 +676,8 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>  			goto err_pci_regions;
>  		}
>  	} else {
> -		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> -		spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> +		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_count));
> +		spad_off = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
>  		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
>  	}
>
> @@ -743,7 +717,8 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
>  	struct pci_dev *pdev = ndev->ntb.pdev;
>  	int i;
>
> -	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
> +	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_TEARDOWN_DOORBELL,
> +			     ndev->db_count + 1);
>
>  	for (i = 0; i < ndev->db_count + 1; i++)
>  		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
> --
> 2.54.0
>
