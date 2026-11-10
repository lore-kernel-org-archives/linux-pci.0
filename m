Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.125.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794325211;
	b=KlDNkJhLLdEJb8LxiUFD5v/PQ4FCcCMjSZeI2uByBE9QJf81yKjPJP0qUC0hFf+iYs89
	 CGBzbeOLC8H2F8euXMRhBvpt4fL8RffGHQ/vPvOGXViK0J3WLEOHWHsrkcDaDYWiCC92i
	 SpHr8lWIGJrKttfoV/jBNIINE7vHhG1QLkPvv0Ofvz9BfMgxXqRx3s85TnRrDOwhV3fCU
	 lgPJIvgLMkV7qfITFrlOwix2aCb3uqjXAbERWEHSuk2ekktEBwoBzlAHWCSqtKnbAB0uA
	 SnOvpMelywBNkKdbEV7BPRJmprQ1ybb9vApJNnOIjl1CFA6UC/KwsVmCVu6kOX8/IRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325211;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GugCPs66RgcqiaCXFfVUII7DOIhyw7VOu8pUy+p1cYE=;
	b=LCqSv38r9lvrK9Q4haP6Mpr4JFsKWcqZJSWWeHd6VI+EfUKz99ooP90xV149avMooz7C
	 bNjNgGhiYfffc4Jrs4efneVBQzRYIA8UsdPuXq7lG/cZ5oAQe9g+q47QJNe0ezMBPPYGQ
	 Ic0tAfUbt2RPbdhb5VO++Hw32bZ3I6eca6ka8OOt8PwGXtb2/UlwdS0+SD4EOg9NdEp9k
	 nKNRCgIZlqRFho2NFHcCfPPkp65S+F5SBP1x55PZxCRyC/uvhZx6WihXMC7wNP3K89Ark
	 c8Gse7aEKAUrqwa7a14k8KoTduT4np/sis8S5GWVDb8caXXwAH8kn3kYzkrSWaOpVWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=fail reason="signature verification failed" header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="T7XJF0/y";
	arc=fail smtp.remote-ip=52.101.125.98
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021098.outbound.protection.outlook.com [52.101.125.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A5606A326
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 15:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA0A5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=T7XJF0/y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avn9J8TGqD1qtJE4QYhdeqhzZnHMUDx/L6jxgFyDlHiXsdKehZUEpX4IKvR0+z/zOn8tW6afQDCWOL8pBOkkXKXT4RnUBU+PkjIMnxfG/r1vuHzabHuaEDdsu10ce7ixtbWP9tFnypDvtLPY4cG04ryq9iaIcQqqRlIM9XKK4ndco6210oeJ9jd/Ewq2IesN12bZcrIttDmhz8DFYFNvBp4BirS86u2csEG852FVIXarPp5Ygkq6+vqWZvJUU2tm2IgYJqVx5acttJ5X0oGleZZp38fqzG4vVk8cLXQJNLhhF75I8l6hlCvJw6FfRIxrmMYNTWuYqyYHf/zxtWYkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wFQFLKGGxyfe7lA2gfUPPY74W960WBBrztV4sh+gn4=;
 b=NTWyQrxwMYApI0ZDjk+vWpC5dREWaF3L5Khv2Tkt/I2OG3PwQjCLrr2VFOkWnzb2X6Btp/u1rdjRM6LqIlD2aU6IyFEfClUSQlmcg56FGhOUnXhaN74/1eSQB6+PjvM90es1UsaSIapvNr1E7+Hc0h1Ra40CsY/1N2c+J4uWFqb+6pi8xCPWt68c/DDTHcp+AeYMOwx6h2uaJTW3mWHDRKSB9cakc0QnQDTGVg9gqR4wfrOdaVI9P0zNGY26tyYm0b0Sal7o4vOleGsvYredqSWDDSL/sBytejSUNwCcvMxo22zTabuAW8ROnWpzo2aQ1K5QnUtqYE7c0ql+qEkekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wFQFLKGGxyfe7lA2gfUPPY74W960WBBrztV4sh+gn4=;
 b=T7XJF0/y8+njQ8HPEfPUAF3EA+9lILXLyqPIdZ+fr//wlShnuyeqijb5yZYxUgd+9e0tfK02omnwxFdRC8zppKVt7VDjsGL2DxhOGI6sCCGD6ugdXZmjNIDEn3mrQxEteRvvqSOBSwekAxYfRhwvtqTfSDbYRRGqf2e/ap2VfoM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3186.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:40:07 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:40:07 +0000
Date: Wed, 11 Nov 2026 00:40:05 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev, Frank Li <Frank.Li@kernel.org>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v9 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Message-ID: <3qbu2n7k5smmthlfklarhwo5t6qtimu4ddrqymv5b4r7jdsfiw@hy3kj2ft2q63>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-10-den@valinux.co.jp>
 <sashiko-outbox-206684@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-206684@kernel.org>
X-ClientProxiedBy: TY6P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3186:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2ebcbe-f459-465c-675b-08df3f40e56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|1800799024|4143699003|56012099006|22082099003|18002099003|6133799003|10067099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261026135527099003|261028144727099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ddgglL1OaCpZ//iOOlh14xPGLncyoVV+hHOF8++V0sAT6ORr5CpGklTt9n9mKE97NUk1PT6MgDmSLsQ1nTGFln1su30Q8o2ZWsIf/7QC7Fq9mvqDwPZf2An2tYym929rXRTZQDL9S+WhZ8bMx/YtgpTkwF+mpYlXZWFNo6wCpqKj/KoMek0m3VK+khlnlt5vx/x62iimecQXlwa9hiZu4PXsZH53DcGim7z5fRfdNjx3Lx0AqFwogLTbAK7GKlrbRXQNWsEO56CEb1aJWZswkmH5V8hzTFpi2K1kOE+tiNu3+SGta/j+xlml0U+JgXKIvlpyx/uSTa6rekLJKJctH/gCJtXZH38of8DF3w7mWXT1eGaVX2W0bZERc7csT4W6FOQj8x5LuykeUmAOtII6h3TdoD3Eq8euYDjGKbPXHf3nYj3N6jhQvDpFn7EdKk17bkT8wl4GuBjxdT1CPgjExA9f5f+Qz9rDyeQKdwyBfskjuu7IDkeofZBDt+WWScuvPXWNpHYtQZB8nx2QNfbhMRU/L2JKKcWgK1Pw6jZWS7XQTiJTDihB3cTzginpIUZOCRKEUEzqtT7UDq90r2CYgeg61BEWeVaolx+nXpT9Icc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261026135527099003)(261028144727099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?1RyiAx0L/yhN0qoz6d3UuLg4AXjVfzuxG2u2jif4GBuf+/3W0jv7EZ38VB?=
 =?iso-8859-1?Q?AuMWs3iVj9JVVuv0FeAMcaog7B50isHe8WBqluu9QVNFxXpGYHi8UMmHAE?=
 =?iso-8859-1?Q?iMkntbKEc9GFmpuyPFPMbOqSrQ0PwfasKN5BqSMP+FdeZ5YJ9byljo9i+G?=
 =?iso-8859-1?Q?bh04YKAIQrwsCpD6WB3mGe3iMQjd3pnobhiHEV6mCwRc6oAVM7r2egFWHS?=
 =?iso-8859-1?Q?mV/qiO/Cjj8q9GbWCR7HxlgOdbeGH7h5eGtL0wh2ox36oYeCbg80M+40ef?=
 =?iso-8859-1?Q?KFfsT7jL3Hpa3pLeK9cwq+mjAMA/qWOhniczE2dJnge6QX3gx7FNPLcnAg?=
 =?iso-8859-1?Q?Sto4IKyTqDw8mA9viLi4jt7suPMQpUFh+eEa0zrvTxTh5eeFVooq+WPD4D?=
 =?iso-8859-1?Q?hLaEIZ8Z/d4Vk58SC1njYMHRzpCARRE2q+LMe7W72hSQQD9U+0tNV+jcSc?=
 =?iso-8859-1?Q?4qkhgQm8va3RvIZldcnMOZs8cQsfdtAL2Gur5FcsklCu+a+Q9cuo+1l+oT?=
 =?iso-8859-1?Q?541rmWTqJT67+4gaDRSrAFzyJYVHN2Q5LZaIy4/6LPTca8RZnMUwLQZCmh?=
 =?iso-8859-1?Q?XlQ9McBbV+ETiZpstUU2Se5tz5YuOm5e3XZfTjH9oVkDeHUhBN/cOovYvC?=
 =?iso-8859-1?Q?WAiiZXqf4kAeeYFdjE4Lfs8osEJ1PVfuL6i///yB+nHhdAmlTdRSskFXSe?=
 =?iso-8859-1?Q?T/Iy3JiG9gF0CmJSFWum0nYH/wvFKK9QQyy+KUlfE4J4ZnKqnCL/eWvE04?=
 =?iso-8859-1?Q?hNRf6MyL343Ba5GA3IlWWvm1CTEl5FKRovK2bZoytwCjBYiCc+VK+d18KZ?=
 =?iso-8859-1?Q?+3/zalM0SBb4yd8fyrcuUMnVjxbUUV1x0UnaET00fjq0D38ldDUaajKRK+?=
 =?iso-8859-1?Q?Z3E6A4TCy6/aawTzjtbXaAPnKmuLUlKfS4xlO8WT7dKMyMtc8vmty1wnK9?=
 =?iso-8859-1?Q?VCA1x8QTPTdpTwGCBfvpNDsTvXfO5JiANZMgmF/CVHTrjzAf/0cgY7pqVq?=
 =?iso-8859-1?Q?syiDTX+JEVEUroV4ZJt2/2CYnO0Cf/nOH6hUPscMEXTi+PHq7vm5wZg1L4?=
 =?iso-8859-1?Q?AdcgSCSLR4jgUeFzbFM354yv08vADkNq6T3jDalqDqZCINROaTbgpr5zU/?=
 =?iso-8859-1?Q?3HkmcfjqDt3mbYjl0LoZg97POa1UrfKAd+s8QExX7WUSm/xUW0hOxeeH0D?=
 =?iso-8859-1?Q?VkSxq+IDBIdnszqyWgNY5dLo/I7BTtn9gvuylt+qdPe3xvlRsk9P8rE0JI?=
 =?iso-8859-1?Q?quqmsqW2GthXTlc+XQYelqPtntK79RonoHMV5ojAerXLmWiqzOWDcK8gnl?=
 =?iso-8859-1?Q?eQjg7VKVMOQanA+7piPJ3gWklx1ltkqjIBw+07DJoHeXWIZkfESfWNAHFN?=
 =?iso-8859-1?Q?e5t/wugo6pQ3nhR1AXORA9oNChJO5VWp/f1f7+5HFEN8mMa1qaM3hcD/nR?=
 =?iso-8859-1?Q?C+zT+dPWpxXmqNNvSsgx2MJP/0eDEdDp1gxMeB54YVaiBH/E8ousLozHNw?=
 =?iso-8859-1?Q?RnWAZN6Hr6M6a64jT0Ah6UHVW/2USQZu5lu2rnHcuUHto+HqgVV2epgryF?=
 =?iso-8859-1?Q?ZP2CiYiXzhWNRRbLnr2qPGP74cCOYbQh8bv9UxEE3BlYykdkp0rqcPt6hp?=
 =?iso-8859-1?Q?1UcZbDc+jau6N6Frhr4htUqRYrpWpFM3JguOtVVUtnXAwwEzAkH0pmf/V7?=
 =?iso-8859-1?Q?IEw/MWZKFXCmQ9NWDX/jsx3ABSsio8sI/w5+IX7lxhWSJba6ZGLa4QlZmB?=
 =?iso-8859-1?Q?WbnJFAT/7zM380guVzhvDHOMf6XumfapZP2J2pNmdXZ+f3mi76QGp/u9V3?=
 =?iso-8859-1?Q?lG8qQ6hB+q8DCuYrP5T8ceHxnubhL395SiNgO4CAnwqOkqQaR4Kn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2ebcbe-f459-465c-675b-08df3f40e56f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:07.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /37X+w6aiXlhueCAqn7rMgl/5rPreA3KRUz8CSW4OY0wKM7IEydq5sPxi/ui1kEg1oLYNLU42NZ2D3beeFWqMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3186

On Tue, Nov 10, 2026 at 08:58:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] NTB: ntb_hw_epf: DMA IRQ reservation conflicts with vNTB tail
>   doorbell vector
> --
> 
> commit f7a63c5c0603979fdb93290006c7e19909b1a6bf
> Author: Koichiro Den <den@valinux.co.jp>
> 
> NTB: ntb_hw_epf: Discover vNTB-embedded DMA
> 
> This commit decodes the vNTB endpoint-local DMA extension in ntb_hw_epf
> and registers advertised DW eDMA channels before registering the NTB
> device.
> 
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index ff92c2a61ce7d..e0016128b95c0 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> 
> [ ... ]
> 
> > @@ -347,16 +581,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> >  {
> >  	struct pci_dev *pdev = ndev->ntb.pdev;
> >  	struct device *dev = ndev->dev;
> > +	unsigned int dma_max = ndev->dma.nr_irqs;
> > +	unsigned int dma_min;
> >  	u32 argument = EPF_NTB_MSIX_ENABLE;
> > +	unsigned int ntb_irqs;
> >  	int irq;
> >  	int ret;
> >  	int i;
> >  
> > -	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> > +	irq = pci_alloc_irq_vectors(pdev, msi_min,
> > +				    msi_max + dma_max, PCI_IRQ_MSIX);
> >  	if (irq < 0) {
> >  		dev_dbg(dev, "Failed to get MSIX interrupts\n");
> > -		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
> > -					    PCI_IRQ_MSI);
> > +		irq = pci_alloc_irq_vectors(pdev, msi_min,
> > +					    msi_max + dma_max, PCI_IRQ_MSI);
> >  		if (irq < 0) {
> >  			dev_err(dev, "Failed to get MSI interrupts\n");
> >  			return irq;
> > @@ -364,8 +602,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> >  		argument &= ~EPF_NTB_MSIX_ENABLE;
> >  	}
> >  
> > -	ndev->db_count = irq - 1;
> > -	for (i = 0; i < irq; i++) {
> > +	dma_min = dma_max && irq > msi_min;
> > +	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
> > +	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
> > +	ndev->dma.nr_irqs = irq - ntb_irqs;
> > +	if (dma_max && !ndev->dma.nr_irqs) {
> > +		dev_warn(dev,
> > +			 "No IRQ available for endpoint DMA, continuing without DMA\n");
> > +		ndev->dma.type = 0;
> > +	}
> > +	ndev->db_count = ntb_irqs - 1;
> > +	for (i = 0; i < ntb_irqs; i++) {
> >  		ndev->irq_ctx[i].ndev = ndev;
> >  		ndev->irq_ctx[i].irq_no = i;
> >  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> > @@ -377,7 +624,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> >  	}
> >  
> >  	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_DOORBELL,
> > -				   argument | irq);
> > +				   argument | ntb_irqs);
> 
> [Severity: Medium]
> Does reserving tail vectors for DMA here conflict with the endpoint's
> last doorbell vector?
> 
> In MSI-X mode, pci-epf-vntb sets the MSI-X table size to ntb->db_count
> (at most 32), so pci_alloc_irq_vectors() returns irq = ntb->db_count <=
> msi_max.  When irq > msi_min, dma_min is 1, which sets ntb_irqs =
> ntb->db_count - 1 and assigns 0-based vector ntb->db_count - 1 to
> dw_edma via ntb_epf_dw_edma_irq_vector().  However, pci-epf-vntb ignores
> the vector count in argument:
> 
> drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_cmd_handler() {
> 	case EPF_NTB_COMMAND_CONFIGURE_DOORBELL:
> 		...
> 		ntb->peer_msix = argument & EPF_NTB_MSIX_ENABLE;
> 		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
> 		break;
> }
> 
> Because vntb_epf_db_valid_mask() still exposes all ntb->db_count - 2
> doorbells on the endpoint, ringing doorbell bit ntb->db_count - 3 raises
> vector ntb->db_count - 1 on the host, routing the doorbell interrupt to
> dw_edma instead of ntb_epf_vec_isr().  The mismatched
> ntb_db_valid_mask() between host and endpoint also causes
> ntb_transport_probe() to compute a different qp_count on each side when
> mw_count >= ntb->db_count - 3, preventing the transport link from coming
> up.

Yes, correct.

To summarize, the impact:
- ntb_transport: qp_count mismatch only if mw_count >= db_count - 3,
  i.e. db_count 5..7 by default (vNTB has at most 4 MWs).
  Larger is fine (e.g. 32 with 4 or 8 QPs).
- Other NTB clients: top doorbell rung by the EP can be lost.

TBH, taking the last vector was a deliberate shortcut (EP untouched)
for simplicity's sake, but the EP still exposes the doorbell, so the
two sides disagree on the doorbell count.

I thought that was acceptable as a first implementation: in practice
only a few QPs are needed, so setting 'db_count' large enough (via
configfs) avoids the problem, and I wanted to keep the implementation as
simple as possible at this point. But now that Sashiko has flagged it as
an issue, I think it is better to rework it (?). Assuming so:

v10 plan in my mind: shared DMA IRQ on slot 1 instead of the last vector.

  - Slot 1 has historically been unused, i.e. no kernel has ever used it
    for link/doorbell events, see commit 84af8a5f5ef2 ("NTB: epf:
    Document legacy doorbell slot offset in ntb_epf_peer_db_set()").

  - With this approach,
    * It can be a host-side-only change in patch 9 (plus a howto wording
      update maybe). The simplicity is kept.
    * EP behaviour, wire format, compat matrix (see the cover letter)
      unchanged. Slot 1 goes to DMA only if the EP advertises the DMA
      extension.
    * Host doorbells same as without DMA.
    * No spare vector needed, as it just uses the skipped vector.

  - I don't think this makes it hard to support multiple DMA IRQs later:
    * v9 gets at most one DMA vector from vNTB too.
    * More vectors would need the endpoint to provide extra ones and to
      advertise them, i.e. a wire format extension, whichever layout we
      pick now. Once that exists, keeping slot 1 as vector 0 and
      returning the advertised ones for the rest from .irq_vector() is
      easy.
    * Completion already runs in per-channel work since commit
      35de39e4511f ("dmaengine: dw-edma: Defer channel IRQ handling to
      workqueue"), done for SoCs with a single fixed SPI for the EP-side
      eDMA. One shared host vector is much the same, so I expect no
      performance-driven need for more any time soon.

If no objections, I'll send v10 with this (in a few days).

Frank: you already gave R-b to patch 9 as is. If you'd rather keep the
v9 scheme, please let me know.

Best regards,
Koichiro Den

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261110082459.1798763-1-den@valinux.co.jp?part=9
