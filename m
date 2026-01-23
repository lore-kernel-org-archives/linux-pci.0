Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDA30BF5C;
	Fri, 23 Jan 2026 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179879; cv=fail; b=VD6zrEF62KKitlDWvXq2eSNSCaebMme0O58GRpORIY/KHBFyVjyh3/8JOQjUDtEW9ihFXTjNMZq1K01fNsIPofDRBzVHy3TOfL5Bps8gHyV8SscBxwbNHsSJgVYatd+cGfZ+0v7XUl84jzEQVgrMS74dAK6uWUmeC9k1AAnwES4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179879; c=relaxed/simple;
	bh=KgTL5ErvCvPEsqymRaOCjE+Yrp/AzhraGnxCLsLSvWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A2Ov8qFqUO//YDUD3RRkNDb0sIH4KmOdxJulIta2dCzI4ylNMN8yU53xee5rUcHQnthz/7MhExmJkys6r4pIVpWZrjyZ3y3hoSGRDjOrmJzKKqVgghB4tOBvRFpvpx3jKJx/aTSkmODO95Tf28hCGDDm+ptXVf56RxH5TV87lAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=faQ4JeEf; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="faQ4JeEf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgR9G9Ql+xjETRa54OaJmtnZIyx/D/9TJI4/6J5sWVHZ6HyowgNKASAAMMppUK5ZVa183RgahHMufngqTvC4NKtF+j6IKrivBtc6I/rmq1sCLcgxYrNTajZgVoRNsftaQGLSKTOcz06JTduWAv2cjLsTJem0aDiBmNIM1BucByJ47Ofh1v6WE9cyyXumapeWJzHCZiPs1sCyi+jO8tyUu1fjOexIR9piK38CgqH7y6/eIc2i462oq2mnlwiQly9YaTBh4ZfOOfg13+l7/4/AOqA6cuorlxokDhyYnVrp3hfEUtzC3sNAVKjDmpppockpeTmfbOyM852NWVBPcitoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4zrCc6Sh1xmTe5E0qVv6iVK2pN2OYY8MuMxsBsRhHU=;
 b=A4o42j0b9knjZK8hnFk9L84eAH3RR11c8/RV6BhL1j4Ps081ub5yA7iUflnGPso+SldpOfUq/cBbI/+HabuH/qQDNRcjFGKu6+MRNEIq1QDrcHJvIkM5h0GLJIwZfi8fzwK2vx3qzW3OvFBHPRQ0IsH3eMM23rP2IoAPRD9UGIcgR2PgcN/509S3cTHi6RvEg9e2GRNXHkngUgnmOuf1+s4Oyx0kFcnwf66bVOf9q4frEIk6ebG4lu7joDoBi6veeXaqgxsBWUyDP8gVzba+28tphiktRVwxMKXbW0FwLar8dDgYzXw9H4LPK/T5i8u64BC6wh0nYbNi4fGxgZ8y2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4zrCc6Sh1xmTe5E0qVv6iVK2pN2OYY8MuMxsBsRhHU=;
 b=faQ4JeEfqPe+c+rkMkDtRHmomjYDE76TywDBS9uY+PIRliIfz758EdJg/Elmsp26xrIzZxLqdyIULREeVfa2yV45Ko/9iPCLMQV0PpABVzWTdT5jpO/JWEv0blvXa3pH/FqoKL/F8TFdAjR9bOnzI2BARrOS9Kt9z8Ims712qtsPhXuxKWRU+ShzQ2EgAjeuUxEjFnd2KloSAgzNqFoUUzse9rnDNHL7CYLIKdpFCVIFe4tcaOPcd+h0kI57mx5I84Vwo+N9B+yjC0r9YIiCo961v8KvSvYqgV0zbVR4jRKwYG1CgpvWyu17wK56A6HLTv0TmKuhejhGsoBpipDPDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 14:51:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 14:51:15 +0000
Date: Fri, 23 Jan 2026 10:51:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
Message-ID: <20260123145113.GA1134360@nvidia.com>
References: <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393ADC9C367C4A6F8032A02DC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393ADC9C367C4A6F8032A02DC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: MN2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:208:239::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: cc27e4d4-19d7-438a-7a64-08de5a8edb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ie92Iwe2m7hN0hP786+LSVgqN9/57NaJ1oGZtbg/O9DeUWVZh1ZvZtnhrpG9?=
 =?us-ascii?Q?3h/NhsZmdMuXbG8gFcLf6KHcx6rRBqJk3x+mY8WdCg2tkuJTU3lcCViyLaWw?=
 =?us-ascii?Q?6YRD6qxu5oFIwhdemLi8pDwVNK7puxGHZM7MpwCQPW+aPgCQwuMK2iydcVJT?=
 =?us-ascii?Q?jejHSiugtns/rsO5bF94BBz4Fu/Snc9OMSAh/gHkHr0vrK04x8+SluXChVJy?=
 =?us-ascii?Q?bdvbvSke15bfLzRznZWDNK3Izd61fM3zBjQzAgBI1jFVmb2ny+58hKd8OOVl?=
 =?us-ascii?Q?4KAWPByhwltklOcXgc36c1T8l8oxUmy0ZFRXn9Ue1a/dcW/UgXpafYHfuWYp?=
 =?us-ascii?Q?8uVN0DTpXxJkRb0UmKR4CSIHpTdbETZzz/EjDBKz0402BtUojaDBhzscF7aH?=
 =?us-ascii?Q?j32mvLLu/KuXWTOVZlsXZ5BHbEfRhiOSL5jSjq2I8iBLtgIyiK1xbMDG/EZw?=
 =?us-ascii?Q?MoAE4l3tSlbs+71SFo8AcDCgxLTx397DWGJ5+MMeL7IzPBcWtssSZL+N2IMp?=
 =?us-ascii?Q?QnKxHsGiG2bMHuy/oBqyrfZ0YpM1HGtSRLC/QxEh7a7gOnvLeHlGRgQK/3Aw?=
 =?us-ascii?Q?nRfGlU4XfFE9sSf6iLrmGfJZ4+IbMqwv7xu9jMRY5y9NJdaWvykcX5TDJ3rH?=
 =?us-ascii?Q?/Ob19yiByyanxknGEwLsHrGzN6WwzZX2K8SMMenLCBKK98o5h1m2V12ZsMvS?=
 =?us-ascii?Q?6c152yEK5hZocs8N6gTVRO5E09oUpqnYUt3g7QxARmYuLLqkMmfWrEzjA1Kp?=
 =?us-ascii?Q?I+AQw8I8sWXLHgwspYItRF6IhnB8muoOqAHOKtN+yjrmLRKrA3GMAvmAU+iB?=
 =?us-ascii?Q?MWn9MukBIcX99eIkj0/0D6oXQ5lAUht/1oSf3I9011yQ+py4Orcn1JNlA4pm?=
 =?us-ascii?Q?ZfgD1ssMPwbxXGjef9ynwjHloYG9iFX1hAcnMWv9v0PAM0U9yX8z26ucBjoI?=
 =?us-ascii?Q?hJjsvzFTHFf5eogQ+enOOOejF1hREz6ReCgOlFlisqs7g5NWJG1JsuyC4nSl?=
 =?us-ascii?Q?UJ9+J1KFNP17Jwq4cOfU6b1Dn1V9kLSWVH+zRJzNdB/E7s6np7rPqwWql8sq?=
 =?us-ascii?Q?/0hjnTklHyykqq+g97qRAbezyu3WNO7CXhJHG/VKhjBS8TbJM+khPVx1eW38?=
 =?us-ascii?Q?851fJ1ymwf2LwJUnR3kYOmi/AwWEDAHwC/Wssk6LGuce0uveuIll0H2Kv9GF?=
 =?us-ascii?Q?KCZDV/q0FcLXd4aBiQjD+i4szsh/ZM8fbpsLz2osJWdxeO1jf/5BhpqvEyMs?=
 =?us-ascii?Q?Bcz5kkBXpbuOUPI1gcZn/Eq4+nhMi8Pdgmwj6nZY6sgcN8RUvBmBAclWsFkr?=
 =?us-ascii?Q?8AhuDGGjhD95aDMNOyrvH8FmNnpAUvpDXeTzAHDjZ6Ue75ggsmBXNievN7+H?=
 =?us-ascii?Q?taXQKkP5o6ciem7f9aLYDtTD3hokoukgWqAHYM8fVQSV9aVjFMkWr4FN+idY?=
 =?us-ascii?Q?21WNFyKPloEmWqDEXTu8ouqlLu/q0GE+w5snMFni49PGfrH6EAvg/SFrLoeu?=
 =?us-ascii?Q?8i8VLNKmal46zD/Fh52j3K9OuDndG9oAveNl2gzxlJVGUZF7k7IOfvY0aC1V?=
 =?us-ascii?Q?0ngLG+wjT1mHegZcLW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1GoG5L9zsx6JWYQcLbqdQqRyq6iqJtQfSCiJu/xkh4IpNrZ4gUcRIhDtOYb?=
 =?us-ascii?Q?2Yjef0maWpiPD82u8qj8yHR4KJGl+e1SPwSUklhLyUCUPEZJlKmXbJESxTGo?=
 =?us-ascii?Q?5bQCQetx/UXmTL45mppsE6KUuGXmMiP3xhO36zJ6yV3cSJUwRATYxR+ACav2?=
 =?us-ascii?Q?34pQyjr01ogWJkIUHCOhZOD+4TQ3PicU66ebBM6ZCw+a3OCazj1RJ/c2ZMfl?=
 =?us-ascii?Q?I5u3U3zBhBCHfC4ZCreAnRgJzIpAqDLkjjjNj+TFV4eirIgnmtS8FQGllnSD?=
 =?us-ascii?Q?kuang3qi3tLtpT/cuuMhIFNmSEHsjGLf8PzXwlnKHKRB4Hy/UtqKJMG9NLnb?=
 =?us-ascii?Q?JnQ55nGOcCRX0Gxa2xDb/4I72Du8Jkh+draIRApcnLmaaI0sL7KsUJXfQ7XF?=
 =?us-ascii?Q?UgpdAbibD35MFzXm0zJv9jcRoHvKbigEloRw+kEt0aSpGYaDgzEHENLZg4l9?=
 =?us-ascii?Q?QLaxQcY9ltQiBOrUbEBYa3DUDchTjr8Klxx0fP1QteBH6KtJvLLfTBVwL7zq?=
 =?us-ascii?Q?CaJPFGy5jUaX1UDgtOByMIWjnjUYgwHVEHXN+X76oGtO0W2fWUgApTxLbL7v?=
 =?us-ascii?Q?2AMmawKWrtwXomRT7XhoyyJed5199TvnAqu/n9Cu8wSJvb9jtVvdeaexSJso?=
 =?us-ascii?Q?KNNn4JZCm99f+Y/jy8Gssd3Q3dsCzDdWF11mhFd6vT8vmKyeWydnHSidn6rU?=
 =?us-ascii?Q?vEJhiMj3gEkGBl9vZ710L6Uc0RO1E+QLr/8LlSeVYEK/pl5vlWNF1AJXRd/b?=
 =?us-ascii?Q?8jEtST4Rxqml6tvD/QOJO90qSW4ao+WvOJPtarTfEhoyhldvnWjdS3mvazlR?=
 =?us-ascii?Q?Tv3plImdVaNzHxQCPC8CPuiQljYXeu9MHoedXC/GmK2Nc4zC7C/zWNRJ3qKQ?=
 =?us-ascii?Q?pvGIMt9cTWWxDfRaPW/7T6c0Qm61mzXwV6EArXeJ69OO0U3vwvNA6KC4Ejmi?=
 =?us-ascii?Q?juIpG4gp7xrZRIjHefW3QpNiRRIKbWbsLzejitwYUb8N7dfGbjw0+Z5iyklj?=
 =?us-ascii?Q?O0tDYfCPd3aMLYXG5xcTQ8Q70Or4TX4o3vZsieO3HL0UWEVbcjyZwPod1obp?=
 =?us-ascii?Q?g/q6UAC5alzZbmoyw0+yZisuJiRYuPYLiPlWQB0cHZpMAmgu9sPVkMDRZhQM?=
 =?us-ascii?Q?TPVDdx/fuBSC+U5IoxFBoJOdc3YXfnUfWEYNN/+M9luRzsQq1i1BEvXg3aUz?=
 =?us-ascii?Q?21essnggnEncnDbNW5gImYz2jBDWaN1gf0I+3PbxkoNyu1o18STnn33NqZUL?=
 =?us-ascii?Q?SFoAmaxWhZ1Q07sT7A5p2WWdibMWOtETvTFvyrCTHCQ0WMKlx4a72zaWsmk+?=
 =?us-ascii?Q?ssgfoPie8hBU0BZTJlPGRdugYGYFcN1qdfbl/0Up7VK+q8u6PMs5rgdez9Iz?=
 =?us-ascii?Q?yhm6yEJmBBzUGaQvzR/dkWApynyAeIlVmVOBeSQ4uMYKVS5uAZehxt04zazC?=
 =?us-ascii?Q?x///zuwJEDLE0SEFXMHwUI8CpBlNbKDdJgXU9JUHbJx71Z81ooAcepH+5YAV?=
 =?us-ascii?Q?jLamwOUHEo+IuV1dV5qrkXfIEhSSWYa23dVQZisZP/UgtmAYPpS43Xg9kqTm?=
 =?us-ascii?Q?5lF+pG4DW+4PIyPfAvgu43iW88um/MEXqSYADfs6it76cgVzlwqWIqfaY/k3?=
 =?us-ascii?Q?5A+uYpDDgX5YJg3KcHiq7xPhQHF9zYhjJnsd1vwtUGx3+FOfvDRV9TSScIgg?=
 =?us-ascii?Q?SWYwpGmf3piXlgRwODqWnzyEIDtIJPAnw2kxztovBQkFU+gmjLOBl+wadb7B?=
 =?us-ascii?Q?GKVZ1GCnnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc27e4d4-19d7-438a-7a64-08de5a8edb84
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:51:15.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3FMv8nbsRaDeuV3rUYMbb2B14ZI2P++TD9ncipynDRaoKsxkxQxlevJXBmwjGHy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8

On Fri, Jan 23, 2026 at 09:49:43AM +0800, Wei Wang wrote:
> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
> isolation. On devices that support the PCI_ACS_ECAP capability, the
> controls are required to be enabled properly:
> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>   upstream I/O requests.
> - ACS DSP and USP Memory Target Access Control needs to be set with
>   Request Redirect or Request Blocking to ensure the Downstream and
>   and Upstream Port memory resource ranges are not accessed by upstream
>   memory requests.
> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>   areas that lies within a Switch's Upstream Port memory apertures but not
>   within any Downstream Port memory apertures get redirected.
> 
> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
> support, pci_acs_enabled() skips checking for the capability and logs a
> warning to indicate that isolation may be incomplete.

That's every existing system, please don't do that.

The issue with ECAP is the way PCI SIG re-defined what Linux has been
doing forever as unsafe.

Jason

> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/pci/pci.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c4cf835ec8ba..ff974ced90aa 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3527,6 +3527,56 @@ void pci_configure_ari(struct pci_dev *dev)
>  	}
>  }
>  
> +static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> +		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
> +{
> +	struct pci_dev *usp_pdev = pci_upstream_bridge(pdev);
> +	u16 mask = PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR;
> +
> +	/*
> +	 * For ACS DSP/USP Memory Target Access Control, either Request
> +	 * Redirect or Request Blocking must be enabled to enforce isolation.
> +	 * According to PCIe spec 6.2, the DSP Memory Target Access is
> +	 * applicable to both Root Ports and Switch Upstream Ports that have
> +	 * applicable Memory BAR space to protect. So if the device does not
> +	 * have a Memory BAR, it skips the check.
> +	 */

This doesn't make sense, the special cases PCI sig clarified only have
to do with switches that have MMIO on their USP/DSP and a case where
the DSP aperture isn't covered by all the USPs.

These tests shouldn't be done outside a usp/dsp context.

You can look at what I drafted earlier here:

https://lore.kernel.org/all/0-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com/

Jason
