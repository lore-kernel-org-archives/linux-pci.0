Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794591414;
	b=M3DywfEJ1qUiWOVpOJnFSp3sMXIV6SX454J7GQMTJXF4/GcExkk2xj3v9/aqOLt4HZu5
	 1x5GSUoVDcCnmwNFMfJuyuONzXoFll9Oezxgd0iDleTdVZ7ettZV++C+AnazQ5ewSVD5+
	 o6Zuc41DP038GuSqS/U4yy7PoiGSqmWudfWUZgQfZeEWRQBvbuaSah+JSkF0RDFrPqilI
	 WimZOP+Jw7fyKF8/0r+lJI6TM+RRHDaX3HV/Cn+UKxjudVFDt+ZZ/2+vomkz7khyPeLw7
	 ss04UWBlzNafeZVbDQDZj1dZnvl3OAq+ZPzxW5h+9k/oB1ugTnf5VI7BsDr/e512Xrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591414;
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
	bh=syWUmI0E2Dqy66dOvFidLP1nbfIfm3hkzafWmQSDZVw=;
	b=zlA06Vf5gDkLxodpR/yzB02QOj3OyAoF6v5G+R8EQ0LCRYQHYV4PB1LjgwHBDVaGKBxR
	 uzwZOmF5VLrpPSGU0zb8S2KlBgLMk/rMdhJ4d4Y6r1C73f/XPRfISc/mdJg9io6Kb49l5
	 ugNKqhiQ9VLePS+9nThv6nyfKtu6pxenyfFdycC1yATbWnku0F5fejaJb2Z+hYxZAdKv8
	 O9as/N2FiNXdiCbNbSDywhgS0TZLp1CsyXoLUcHAMT/nh2q8ZtR55PGxPX+ZC3yqDvQxp
	 hv9Ge34cB3VJC3dLQtNDh6Oer/D7UYEbC05iphJUvIqf/5XjgfOwXYMeKmN0NzTAwgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HvZpbkfc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.10
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E196079D6B;
	Fri, 13 Nov 2026 17:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E196079D6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HvZpbkfc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyQdzUW8xlNC9pgb9lMz4E6SsHCGgARp47S5a7SUEZkvXVMiOmiVMUjEh2I6sFPCHp3rDdJGlgeyasL4UvC9gp2Gv3dUNiPxU9+wyjK9bBq6mM3VcPHI5rSIwasjcqlj/7pLLzXSUtR1lXNzQef9K68F23fuazBxlaO/4H2DqgDpVhJtGIDeNhZVrQ1urHyre1Equz1S6CJEq0PLj2ah6N6hTX59SSXfh1jkXHfcZzwNCOZYuqXcTsKqy9Nhfg7iSXVehb84SW0ZJjHELIe9Zu+QU2k5auUPBVXzH1zCrfgUflqxx9YWU9l7bBQv2NUG/+0RF48IKwe5h645oKAW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syWUmI0E2Dqy66dOvFidLP1nbfIfm3hkzafWmQSDZVw=;
 b=hoRh2hRDKIijmMP3diOPm+ApC4AHMBM3qyWvqKVZm+0tEyLOQmTVPuPeqUDfwnpwhE0eROkkbXqbv4Fk6C5klB4dcIg8SJwENVQo7QDYSO9ndkFyQTtJ081KtYzCIqnMBLFOakgC3N+uCzKcMYGDjobfWk/m7GEa694+CGGXTeHa+IspWyMQzmdUk70WnsHSr8u+L16d7DsxWRgfn5XPfsfZOc068DStSLsdJ54oXLcMMHR2KJ4Q03DcTH7kOxP4DwmgQrsDJi3eitYo5GUaEbEq/H21ji2AcxLPBIPoPoNyBSHspBuqR23TFWSgwITpAOKsuUpS6qi0K6FGy9ZDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syWUmI0E2Dqy66dOvFidLP1nbfIfm3hkzafWmQSDZVw=;
 b=HvZpbkfcz1nSxNJr3Ul+lsbqTPP98cUAo67jVtsFjld6xr+vLTmf9fvaLAPpm0Sc8cx02RailTejyQ3SFkv7MW8jsvsDFLZwCo21XJ2iLAppVdyMp8uTKSZRhL49fJzO/6f2mCcwki1kVZ+pdZK0TCTUZWrZshuAyr8uMAA9/eVI1MJ7rLDHRvtiT+yDpHdID9psG94JmqyqwNy5ONfswDFQpDq+9LdCVl0mE1fM2R71vLfkPdxidygEPsaNVKEvDuyyd2bIx2IROYFxWbE6dbqVq5m48PpYqITYIBNq/9CFKK+Iiu8zGLJCfm4md9GJb9ZDm5Ps/pw3IgW6SlUZfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB830997.eurprd04.prod.outlook.com (2603:10a6:800:364::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:36:49 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:36:49 +0000
Date: Fri, 13 Nov 2026 12:36:41 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 24/25] dmaengine: sdxi: MSI/MSI-X vector allocation
 and mapping
Message-ID: <avdKqanb3y0Bf9So@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-24-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-24-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS1PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:8:23e::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB830997:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e40294-ff44-4637-4536-08df41acb297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|19092799006|10067099003|261102123227099003|11063799006|4143699003|56012099006|5023799004|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261102130727099003|261021121427099003|261009223027099003|261013131602099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HFs0JDq+jVz63LqJvOfv8sN8h/wUMEVjdS9Lc0j8Vp5tQYvvtRngs0K086tlxBgm4XbYvXXqZHoY38i/NxRXeRfpLFXPjW8tdztX+gE5GeJ3AmbxquEyXvGobQ5/8eGUzp3L/52KD/qgui/afInrqzBnEAAUccTUoeRSTRnudhV59h0RrVVp0LijUk1kGaNZJDft0UOLWYPqYqAEaQc/pYofkAW+Yvdn+TdhPqdeHxCBqwDyXXwD2oymaICTylmyNVSM2MVgt66wjq4vbIM8hNg3jjpWeJ0kwq70WmX7llflrxXdDPa3WRIyAZjV5X89Xfsdm7XzLgF7ba6zr2t4owabBih8f+rSWt6jjlW3jud6AkaXifsoGndZLhJ1z8CIg1AgFijRepmFtTosNYMwGuG4yfQzs/kNnWLXy28td4Rs5sDe58cSbZUyM8Ef5t8nJ66qdfk9OYF0d88sfetd50JQNYuwDQ7s+uAeiXpezpJkACkhpiOYiiz/K/V/HxbU5MMZmwGZvyWccQvFG3V0CQBnEoY8pSY69qMsB7Dn+jcEkb6B7pf5GSPDMgGveiYJROLVfUxmwIPk+TEmjeuB9jZelpZwMyOT9/9JhdfWMlTw5Cv5Gt9wxkwLN9mRjzzVelGBF+t8hYzplPybpTxnr+dasoSuWUv9vDS0Awh9Uf8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(19092799006)(10067099003)(261102123227099003)(11063799006)(4143699003)(56012099006)(5023799004)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261102130727099003)(261021121427099003)(261009223027099003)(261013131602099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6mkr3NGqGj3FoUlBfRy+byHzekOQysYJh5R6W7gh8soh/rOEPUdvH8XQkIAy?=
 =?us-ascii?Q?r7VdoqdoL6cFE5IAORmAFWzEG1CyCB7/PtpLCXYE560qBJKOv9kBCyV1x9sU?=
 =?us-ascii?Q?617KnNVIV++xnPgBd9XaSUI0kqhQizDGctTBwqD6XC+DY18f0RYh7q0JVlFh?=
 =?us-ascii?Q?5JM4wYCc1TCHPSVTiAEE8WPG12wROuhP41JAhFoq92T5x6hNLM8iSvpFrCfu?=
 =?us-ascii?Q?3EOsTkJu68Adof8ExTMIi9BiV96c8bqgkR+JX4Fn21C0n9k6ICtGDBFk4JGt?=
 =?us-ascii?Q?1GjuDZok7nn1UMwsXyXaBRQZfTQ0Xh20y3dsEzKefDV/zRAM0S3yB8JY6fOq?=
 =?us-ascii?Q?Sstk3A1n27apDjkl54o8DERsSaBW+O5zA0cmuWVyxJfa+gEkwCoZTrnbeK9n?=
 =?us-ascii?Q?qlnk/54qJT2HHamsRvH3xlS1IkRf2cjgc/60GmL6TL+Ib7iKkCWkzEiQLThm?=
 =?us-ascii?Q?x8CnLwiPy2oXjz2MPKFLAe++eM3Vnk+1fhe9rqNcQPXOpJ8jBF15yDrQSm3L?=
 =?us-ascii?Q?IFG9a0WkF171545D/zIO8NaQFsFiDTc9g1CCIuFyki4/uknK7Tkr5c9MHoxq?=
 =?us-ascii?Q?4bqjYj97Pp1JADtdyACnrQ8gR5G2ijVtuJXXFPgMEBWQos3JSyDxWusICrXy?=
 =?us-ascii?Q?5xKmHE6PtaT0JPwDCg52kbQCASOhXL3hpVmfFKhXYZP4qgYgdJH6xjD2kEpi?=
 =?us-ascii?Q?EZ1uHBwA3uCzSPE8EAjw0X3xFTln5efiRjcdDIgaLyvJeDNNBaBAvhvk/bAX?=
 =?us-ascii?Q?HhwjlYPdqWbxCx2M1m2KWbKuscRlvIpY0nlHNp9mZU1jOl16/wc5r1+PEYkt?=
 =?us-ascii?Q?mpeD0Bd2EaFtArNz2sCiaNaavmJqOJNPsZ1txty3SFaGRujtwYMdBBIKh9/A?=
 =?us-ascii?Q?UH2I73Lh2dOW1lgJ1LjaggXSk/LK6+VIRdoMmgmiM9MW8tF5lfAFakx6WGef?=
 =?us-ascii?Q?n6Ls5uaNzLdlmLJd8KBHgdTZLmHwiaRXmSdBCh+40aZcqwMvmqwl/Qr7VEfx?=
 =?us-ascii?Q?vI8e2yLYGnNOIH5j/R5EKTkNdmttF26/Y8KJf0SX2lebs8OtayaVm2U3KUmN?=
 =?us-ascii?Q?E4bXnSGdrIlOcq5wMXPCKDRAlT9C/LDIip4zc6WD/fq1YmtMErumFz3giltj?=
 =?us-ascii?Q?vfkMpAd2POwi/w1HThP/vPuPQHgW6iEMDEDX5JyDzxvluSYwP3s10oQJV1XL?=
 =?us-ascii?Q?A0ylsEF6UVz8kEvWioJ4tYx4D5ZBeenOCAEfrA9zBJ6R/EN/QK6K+WKtp3Ba?=
 =?us-ascii?Q?LLcvJvg4wPhRFOQcobqk3wwuPCl9HvZD4mLjSkRN34nbAACoKB0vC2DwlMu4?=
 =?us-ascii?Q?m5Oxm00CoPpcHCBvmafQAKGi3CyRszqdbuPOyEnMKvDoTZqAbhlpt5MENhbN?=
 =?us-ascii?Q?CYiVXm2iBbQ4i3RJjVd7WRpbPc4Qz8ClooxIqCxyz0mZqXzjWgZpuBM/uWZl?=
 =?us-ascii?Q?+vClnX9T+ssqtE5knFIsF22rqhEfDFysX0ZlQr9OenrzxkxPXr0X5WSt0oQ5?=
 =?us-ascii?Q?Z1A2ywvxWYD0wzVAVh9a0H9D6SpzjINh2zX/z6EAWds6DI4OBU3jAim5IS0L?=
 =?us-ascii?Q?kY2ZPhEhmDQLEsYxfXUwX0suMryHXwkS2pTN0M6sRk4XhP8QY+Kp/gY9P3mk?=
 =?us-ascii?Q?65bR+95GACtMhAxbCdvM3ktFDgl9NGyi8djCQbPKPbvRQkl5/E7ydlSsyk1K?=
 =?us-ascii?Q?bcPzBwZUjzLDe8gyAsU5RIwu+RosiF54y11Zy6ntOaCYcL4pyxLdOr5pH07V?=
 =?us-ascii?Q?5PxNrNDo9qXcVh3Lx2X6FK5gfFnWVBZIsCFaRekydfdGwfxtPJgl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e40294-ff44-4637-4536-08df41acb297
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:36:49.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/dw4V6G80bVSxuGlsihUvBMpEOcRduST8WpBbkMEZvzFKiqN8S69O08ZJ++7u6fT+vpE9znVdVJLMxnVIU65Oz03AiqxmGlmGp1k3I9jf3wrXYigtbPuSvRilfypAte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB830997

On Tue, Nov 03, 2026 at 08:50:05PM -0600, Nathan Lynch wrote:
> Request MSI/MSI-X vectors for the error log interrupt and up to one
> interrupt per supported client context. Reserve vector 0 for the error log
> and track the remaining allocated vectors with an IDA.
>
> Introduce sdxi_alloc_vector() and sdxi_free_vector() which are thin
> wrappers around the IDA that tracks the allocated vector range.
>
> Introduce sdxi_vector_to_irq() which invokes a new get_irq() bus op to
> translate the device-relative index to the Linux IRQ number for use
> with request_irq() etc. For PCI this dispatches to pci_irq_vector().
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/device.c |  3 +++
>  drivers/dma/sdxi/pci.c    | 30 ++++++++++++++++++++++++++-
>  drivers/dma/sdxi/sdxi.h   | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 8786be71d3e3..30c4e687cedf 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -11,6 +11,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
>  #include <linux/export.h>
> +#include <linux/idr.h>
>  #include <linux/iopoll.h>
>  #include <linux/jiffies.h>
>  #include <linux/limits.h>
> @@ -437,6 +438,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>
>  	sdxi->dev = dev;
>  	sdxi->bus_ops = ops;
> +	ida_init(&sdxi->vectors);
>  	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
>  	dev_set_drvdata(dev, sdxi);
>
> @@ -459,6 +461,7 @@ void sdxi_unregister(struct device *dev)
>  	/* Stop/reset is best effort if the hardware cannot be quiesced. */
>  	sdxi_dev_stop(sdxi);
>  	sdxi_client_cxts_exit(sdxi);
> +	ida_destroy(&sdxi->vectors);
>  }
>  EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
>
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> index d196ab5cf6f1..ef978ca22db1 100644
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c
> @@ -31,8 +31,9 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
>  {
>  	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>  	struct device *dev = &pdev->dev;
> +	u32 cap1_max_cxt;
>  	u64 cap1;
> -	int ret;
> +	int vecs, ret;
>
>  	ret = pcim_enable_device(pdev);
>  	if (ret)
> @@ -63,6 +64,27 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
>  	sdxi->has_mailbox = pdev->is_virtfn ||
>  		pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
>
> +	/*
> +	 * Allocate the minimum required set of vectors plus one for
> +	 * each client context supported by the function.
> +	 *
> +	 * pci_alloc_irq_vectors() handles calling pci_free_irq_vectors()
> +	 * automatically despite not being called pcim_*. See
> +	 * pci_setup_msi_context().
> +	 */
> +	cap1_max_cxt = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT,
> +				 sdxi_read64(sdxi, SDXI_MMIO_CAP1));
> +	vecs = pci_alloc_irq_vectors(pdev, SDXI_MIN_VECTORS,
> +				     SDXI_MIN_VECTORS + cap1_max_cxt,
> +				     PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (vecs < 0)
> +		return dev_err_probe(dev, vecs,
> +				     "failed to allocate MSIs (max_cxt=%u)\n",
> +				     cap1_max_cxt);
> +
> +	sdxi->nr_vectors = vecs;
> +	dev_dbg(sdxi->dev, "allocated %u vectors\n", sdxi->nr_vectors);
> +
>  	pci_set_master(pdev);
>  	return 0;
>  }
> @@ -86,9 +108,15 @@ static int sdxi_pci_reset(struct sdxi_dev *sdxi)
>  	return err;
>  }
>
> +static int sdxi_pci_get_irq(struct sdxi_dev *sdxi, unsigned int nr)
> +{
> +	return pci_irq_vector(sdxi_to_pci_dev(sdxi), nr);
> +}
> +
>  static const struct sdxi_bus_ops sdxi_pci_ops = {
>  	.init = sdxi_pci_init,
>  	.reset = sdxi_pci_reset,
> +	.get_irq = sdxi_pci_get_irq,
>  };
>
>  static int sdxi_pci_probe(struct pci_dev *pdev,
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index aaa43eab00b3..07044d837d9a 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -8,8 +8,10 @@
>  #ifndef DMA_SDXI_H
>  #define DMA_SDXI_H
>
> +#include <linux/bug.h>
>  #include <linux/compiler_types.h>
>  #include <linux/dev_printk.h>
> +#include <linux/idr.h>
>  #include <linux/io.h>
>  #include <linux/types.h>
>  #include <linux/xarray.h>
> @@ -25,6 +27,18 @@
>  #define L1_CXT_CTRL_PTR_SHIFT		6
>  #define L1_CXT_AKEY_PTR_SHIFT		12
>
> +enum {
> +	/* Reserve vector 0 for the error log interrupt. */
> +	SDXI_ERROR_VECTOR = 0,
> +
> +	/*
> +	 * Request at least one vector to account for the error log
> +	 * interrupt. Increment this if the driver gains more
> +	 * dedicated interrupts (e.g. one for the admin context).
> +	 */
> +	SDXI_MIN_VECTORS = 1,
> +};
> +
>  struct sdxi_dev;
>
>  /**
> @@ -41,6 +55,10 @@ struct sdxi_bus_ops {
>  	 * @reset: Bus-specific recovery when the native stop sequence fails.
>  	 */
>  	int (*reset)(struct sdxi_dev *sdxi);
> +	/**
> +	 * @get_irq: Map device interrupt index to Linux IRQ number.
> +	 */
> +	int (*get_irq)(struct sdxi_dev *sdxi, unsigned int index);
>  };
>
>  struct sdxi_dev {
> @@ -61,6 +79,9 @@ struct sdxi_dev {
>
>  	struct dma_pool *cxt_ctl_pool;
>
> +	unsigned int nr_vectors;
> +	struct ida vectors;
> +
>  	struct sdxi_cxt *admin_cxt;
>  	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
>
> @@ -69,6 +90,38 @@ struct sdxi_dev {
>  	const struct sdxi_bus_ops *bus_ops;
>  };
>
> +/**
> + * sdxi_alloc_vector() - Allocate an interrupt vector.
> + *
> + * A vector that will have the same lifetime as the device does not
> + * need to be released explicitly. Otherwise the vector must be
> + * released with sdxi_free_vector().
> + */
> +static inline int sdxi_alloc_vector(struct sdxi_dev *sdxi)
> +{
> +	return ida_alloc_range(&sdxi->vectors, SDXI_MIN_VECTORS,
> +			       sdxi->nr_vectors - 1, GFP_KERNEL);
> +}
> +
> +/**
> + * sdxi_free_vector() - Release a previously allocated index.
> + */
> +static inline void sdxi_free_vector(struct sdxi_dev *sdxi, unsigned int nr)
> +{
> +	ida_free(&sdxi->vectors, nr);
> +}
> +
> +/**
> + * sdxi_vector_to_irq() - Translate an allocated interrupt vector to
> + *                        Linux IRQ number suitable for passing to
> + *                        request_irq() et al.
> + */
> +static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int nr)
> +{
> +	WARN_ON_ONCE(!ida_exists(&sdxi->vectors, nr));
> +	return sdxi->bus_ops->get_irq(sdxi, nr);
> +}
> +
>  int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
>  void sdxi_unregister(struct device *dev);
>
>
> --
> 2.56.0
>
