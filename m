Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020092.outbound.protection.outlook.com [52.101.228.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD12874F8;
	Tue, 12 May 2026 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562105; cv=fail; b=dYO7xoaEGK97ob+UNQWDh3KTuhr/3xWP+m7eIbYI49ekev+K3+xRkU4Dh4kaZLbs+X1Eh2sjW3VcoZc6tGiH3rNSjmFAivUWehEMIeIYGwHTKrSSfKPDNyTl4kPPe3JHeJHYWCRxdUmU3bBTNQfccq8WCkFcSFNM1OQHCE+pZ/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562105; c=relaxed/simple;
	bh=CnAooqVXEdNwj2/CF+/r4V3ZDRh8AO7H6/hUIokHWFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvhyQ5NmU/F1BS5eX3imFzDlQUUhlxsjTOK7vSfYm9PerOgK8MDib9NQJI4SV3Bt8YsIm7kdESwp7G33cQNhIHG6cgPgSWPGGOn3uRP0sMN/wvmSE1reVlantjl0WFHC5BAHBp0adYIo8NUtNy+Zm5jGobM3RkrHPFb6hwfGZiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=G9gN3bmv; arc=fail smtp.client-ip=52.101.228.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="G9gN3bmv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAcKBZVHISefvtqzMureyqTaQGsQ6xGwk34Qm3aw+jqRBBpyr2wl6hKrtUpUwA7x1ea6Vw4iKm6afQZ5dgrkVRzNrHjQyCeSZw9WjX5Xm2msu7iAXKJmwe6BVUYd+Ic5+SLkvaT1Yrh8beWwefmfuwTsn+3kyQT4KOuYEwUbBl80265poe3JAxmEPiKZWYgylT5hR2a91V+3Rcfulp+Oqv+Pm870UCyfQBhDyQmlB9VXAwC3vs34kapypDzxxfvOqnpAvcFi9+RlSz12PBv6e4uMPFuLpaTZwtTpk8GjzqdQgvlAKezLtdfNuWAPCz/gIOLjlelvpJjPVC6kHqo8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL0RCn9QNVF1WeBe78f4FRY2mHkAKdVU4FPjs8C2n7o=;
 b=QAANqAZ4aXYtyTvzS7pl9bGfqAbNvjO1bcg6KGLi4HK6EZ94U7tWloROb8xyz/kyAoM9N5VX1Q5us0EqQK2YyK6QFKPyMfaN1AGMoBGYGkmsJMW8J6jyXXat0OhPeXV1UHqeED5HwKuKc8WUXBCLE4lETMhNmqLpf2ZWpRwnHIVTNy+Hhw9ZSjT23lyNcYZjxdNL+79zDg/q/RLtaHK+p5yF+371ihZ0agxMTzdEISYX+uASD2Edju9dNT9TMqwBMdi6jqqQyEkSUr5Tq+ccPqO+U1nTVF8gstSKt9CDcVkKuNGAfuadNyMiOjh8fa55i+VHGyXi9sGeMM3JDVhS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL0RCn9QNVF1WeBe78f4FRY2mHkAKdVU4FPjs8C2n7o=;
 b=G9gN3bmv8RYJHz09/cDZ0ArsNu0uC+82vq4QlMATGvjYbQHAYE7GnHt3A/T+d2bz4ehTFJSrGsKzwj/MegzEx+vV+4/OIYywiVFARYQmeSYsp0q47Fmxdm7vXP1NYJDyXcubfdqVR48WYUr8S8+DZbGmlbdq6dCekcO6BdU794k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7378.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:362::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 05:01:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Tue, 12 May 2026
 05:01:39 +0000
Date: Tue, 12 May 2026 14:01:37 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	ntb@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Frank.li@nxp.com
Subject: Re: [PATCH 1/2] PCI: endpoint: pci-epf-vntb: Add check to detect
 'db_count' value of 0
Message-ID: <tt77vygc2pbyrnogt5wdx6zt4n4rh3a7ga2pna7kp5cdkqr6oz@nbrfn7zjpyjb>
References: <20260407124421.282766-1-mani@kernel.org>
 <20260407124421.282766-2-mani@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407124421.282766-2-mani@kernel.org>
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ffa6b4-7538-4aab-729e-08deafe38d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cd8NiOVu9G+6gZSNX81ht2LB0g5LV9UEqIbxZGPUqbeMFmv8PFxdN25OmJnJ6uKvB4LfhLRFkw48hL9Z+gLu4jKfJ9lplrVEPIGCOMHPXeStJU3EJhbCf71KxeHknOKH/x/ubiblQUvxZqJZ35mjrpaBaIUyMK/vUVnm96f0wW9pguuBbSoalWrG3F+QcQgdARv0tQ4SUwX9k/1LzQUBPSha1x6WSH9vrZ/JuyB2APh9KQOMG4hIKR7+C7srmIQn8a5peZod2S2IzRkjQZlNaM8z8zueTm92yoymjdH2l1LlVN/bMfRfQHbUKto8Vk6kahhYLsf9+dtIe4mC/00GW0mwh43uwltzm+ai93MvlS2CeRfm+Gmuq/5FO+Ou6KVZKmGq9ydqxSaO/Zah0YdGZNTUxopRU1G3yvy1RaAj/2HycGflJvGQISmyhWNMYTYa2W7jlDCU6/p53eBcHI046pDTtwJysHf3vOqxLBZlXlQlOxpI/UdCcGUkqZYmPNsmfVWRzNmaJ7vEGBVrESxD2hU1GFqXTt7sezhAMNxakwjewXipkUcd9rW5LZ2XOxWBVCTssdiSovZHdHS7+n4FWkREJjH00b98mgr+PQdVIf5XaE8o0KkbVafKHsOfsOJghvm1WXjnFK0NnbOYg7VNUWRf2CosUiRo9Q/ypt92fhUr4xMnrjTcLH0O/oOD09FI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uuxv1AoOySd/giOhGwqK399lgJHBQTldTjhjZMoe+l7Y1SNV+yM8YjlETwn5?=
 =?us-ascii?Q?ntNVtqK4VYrXmHMz2wP5q0jBMwqgfog+f+/n44aGc/2k8tV20o76ngzU5HfV?=
 =?us-ascii?Q?NvOWXCF+eBj1L1nRtG1+jOsQUs7+QkqdmHvzreWOxkQHd6VqODbY8Vnr1L/a?=
 =?us-ascii?Q?87eJgOGzSw9CzgBKHBPL5Y19fBGGBxE3Q2JgCtg2MnFhMLvacEH/frV99aMB?=
 =?us-ascii?Q?VUBcrxKWpBgso5WVXMB5eDhUAKl+ssHL430aUcuecn0m9J+gPbp5Qlik4KgH?=
 =?us-ascii?Q?jnzwtt04y3yWoPpvo9fFb3EHsthhE/vOcC5ZLU9rkHrG7u0RwayiGgrbKCrM?=
 =?us-ascii?Q?QZ5pURiIAK6ojHJy1ibWWnMhUdGyxU1zlgqX2kVhhjg9jJSibx8qC/wSJ7P1?=
 =?us-ascii?Q?u8baeP+hExUNKIB7jBWYAPA9kjfOkPWR8u9vlAftkh0P6wO5OUIJng65EDoS?=
 =?us-ascii?Q?qKUdiURpS3ceOkkLrl8KmTnEEQVZlTDV1W6/YrGSkMumrei8nltWyYOjrC5z?=
 =?us-ascii?Q?tcQ9ffoUTgL9nPzFoiVTVMbI/dIYbp1am3uNPpqQ5L5YRpK4w1Bie3TJHt79?=
 =?us-ascii?Q?sBOydVb2KiJxHpg7iw0VXB55h0Is/WI7H6y4VgM3tyvlTY7H+VFfwHz7OcK2?=
 =?us-ascii?Q?pAEnd3D+sEu/Du/r9bNxnLd0nuCzsvMJUB2jDbj6aiF1Xo7I7D7p7kA/k+iv?=
 =?us-ascii?Q?Po3MrSATEOfnQ4hrvpMItm3vyIXZotGqDhiDmhuTm8PNz8F0KWlcLK02BmjB?=
 =?us-ascii?Q?Jg183bIzkDkg/uaU/FUDybJD0CotD5Zx2YMEFpxKVjKDo9xbJXeGxcSscrVB?=
 =?us-ascii?Q?86hPSHFAYopAk+RgKst51n5Gi+oyBd8Sgkh58DjF9/FzXP21N3K5/cDIDuSH?=
 =?us-ascii?Q?BBfskhQE+9VkEzAFPcC9O34me1yc0t8cC0JGR5p/YE/J+c3HlxukfXsOOCw/?=
 =?us-ascii?Q?Sd3E3wpN6Yvc+o4i0wxErWsO4Du4RQt5jZiUIPXzjMZqKIdfgIeK47Br8rFP?=
 =?us-ascii?Q?p6xMztXtqJu+QWW3u3zjTtgooXtjPJ9wbROzZM3QpEdjv/a0QitZoyFBiOfg?=
 =?us-ascii?Q?WFDABNuOl9fCPHVSJJhL4v7i91JnHP6ZF0V6+mJcaV15DJ2s2buhmylMzF7A?=
 =?us-ascii?Q?M4sJvuoEPS1FCzjEAr0vBSMzLHR+qNb/Q76EgU+frmx/x3tnCEDLu8yq+TGg?=
 =?us-ascii?Q?qvU2hVx8xD5AY+Oll3xEFB0l3aPhNdWzbsRNufHOTQ3w0hvjwOqTOfc/S7z4?=
 =?us-ascii?Q?i5tV/9bSaKZIvMz+PY1mhXSP9FGa2AHoEGQSiPSyy3v5xOvVmAbOvcFyDWeB?=
 =?us-ascii?Q?q21U6KYzONKxAVumkoUw5R2TUXXcKyc9y1vLnkuNcFxO9Zn6VUWOKoHnbFN4?=
 =?us-ascii?Q?oS99ugSz2YesuVNb3VSZXQEBtae7HMimEC6ov+MDj/brcrwxk3xmNJ6fy2E7?=
 =?us-ascii?Q?LbZk4Rujx1zQLylztY+TwRvP0b2HHq+vmOgLlo04hp7ZPxwcHl4ZoF7PDOQ8?=
 =?us-ascii?Q?7h+ZcwgxbIYoEvd+2KldEab0IPxF+OVte9W3IiXMBdiy1Dfh7aC5dgQ1Z8uW?=
 =?us-ascii?Q?ivr/rThj+g0P/GET4KXTFVZAX2KKnuzhR2sSPfcUR+0apev94fLawWLsHn0J?=
 =?us-ascii?Q?VKdYaATIXYaNp3k4Jy6P8GwP2q1Xg4fe24+uwsy5Crp0Th0fqtFTvzF9mCop?=
 =?us-ascii?Q?QIZUWhiHka45UYeqDCl8Vql42pDUq3lof68sa85XZx/3Rr5fVfbRfm5L9V1J?=
 =?us-ascii?Q?BqqmQAEFyhnAcHEV5munlCnbosc/Uo6BPeXw90bsdSJzQIXj3Lpx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ffa6b4-7538-4aab-729e-08deafe38d07
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:01:39.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4QTdAtE/wWMXHPmPdmuEQuBaUHY3Yx7ReAhvLfbLhsGViFWwcB1j0Xeb1gLv1pM1RAtbCvT9lJLE9VqHGrOmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7378

On Tue, Apr 07, 2026 at 06:14:20PM +0530, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> epf_ntb::db_count value should be within 1 to MAX_DB_COUNT. Current code
> only checks for the upper bound, while the lower bound is unchecked. This
> can cause a lot of issues in the driver if the user passes 'db_count' as 0.
> 
> So add a check for 0 also. While at it, remove the redundant 'db_count'
> assignment.
> 
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

I noticed this one is still floating around. In case one more R-b helps:

Reviewed-by: Koichiro Den <den@valinux.co.jp>

P.S. For pci-epf-vntb, I think ntb->db_count needs to be at least 3 in practice
for doorbells to be useful, because of the link event slot (#0) and a
historically skipped slot (#1). Still, as a standalone fix, this patch looks
good to me.

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 2256c3062b1a..3d30aa4dbb84 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -483,7 +483,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
>  	struct device *dev;
> -	u32 db_count;
>  	int ret;
>  
>  	dev = &ntb->epf->dev;
> @@ -495,14 +494,12 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  		return -EINVAL;
>  	}
>  
> -	db_count = ntb->db_count;
> -	if (db_count > MAX_DB_COUNT) {
> -		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
> +	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
> +		dev_err(dev, "DB count %d out of range (1 - %d)\n",
> +			ntb->db_count, MAX_DB_COUNT);
>  		return -EINVAL;
>  	}
>  
> -	ntb->db_count = db_count;
> -
>  	if (epc_features->msi_capable) {
>  		ret = pci_epc_set_msi(ntb->epf->epc,
>  				      ntb->epf->func_no,
> -- 
> 2.51.0
> 
