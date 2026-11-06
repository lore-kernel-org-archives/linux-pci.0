Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793960399;
	b=t/TkXOtn823y7BhqELbufTkJ5gl1tfR6sGmSKdBUhbyDpQAhB+vS0YLBjiHADFXwMiWr
	 9M4rScILOXq0QF2JBEdqhTfZEIco5NOZQbWaftkrDjDwLhshyWajGpvflRT4WsqMxrf4u
	 NqrNUBiFu5QDP7jtMIrd3/4XtMW9YXObpbjc6JwsRhnOBkBsEUlBmMsW3bSroN+JJBVdE
	 8CDreMok6CACkfizluswo+LYp1EjOTn+OfrUYrfo9CsDNLb+siP9+bSTTeJkao1JaLXKP
	 Xfp2Yxcd1y0eYFa0Wn/PNliPj+CX7xmdyZuo9ens28Y4Gp2xNjGKkR6c0DEdnMf2ChQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960399;
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
	bh=4HW4kwbdI0BpSYNXs1GN275i278SiMpDLVTJe3IVSrc=;
	b=fWtovHunADaMvheMu/IT29XnPCcj+Svm+q/RKVN75YkJpjenzs9LTgzl6iQayRCq07X7
	 28/7ZJr3xwDM9kqv3dD5gotySx7EK39Ci/H834R0j7CXQXfXjqIQ5ZGhTkb5sJ2ya3tkb
	 QCHQrHSfMhbzM69f3m9uFihh4qiT72ToMwec+jgrJIWDwtLLfIiCW1BqX8vQYbfhY0fPp
	 r4wPxqbEXiK+IXwNNznMmo0usN3TzAdsQcVzFSHLMBFF6wj6Wka+afzc8vcrhInRA5IXV
	 zQPd1TswsXoye3zsGUD+nUOk9kKQVAZ5iWFE2M5hWPld+14kzxAlcHVJMRBMNSYTxCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c00QrA85;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.67
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF1606D804;
	Fri,  6 Nov 2026 10:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBF1606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c00QrA85
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nL16RGsoXghSrlPnbqp6hqjziVCjW8LyLFbikkClOFt63mDtDLJLP8LphcAKr8t33V4SbvUEmW2hM7AaZPOzf0KDm6UxGr0jpwh8sTE3b6a840IvYKy/hR+VsiHwBQL+kO8+X1s0cUEUlZnRmSSt30PZgzDUeoKrYPbPv6q5i9AenJwLETO+OyO7nlWrdbOJjg8hgdQ2WeGNy8JhInBpDBFvUh4SgytN6WFuyCYWyBE2bEKB7sZiN3XnWqau8cP/1Fxz4jXpxe1HzxFdtayGzmmmN1o5rtv1UuEQPB3JVR974nQaYCXIRg/ogUB3OsFDwDs6X1WuvAITq/hgF5tSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HW4kwbdI0BpSYNXs1GN275i278SiMpDLVTJe3IVSrc=;
 b=TjX2Xp6ej7dNR9F/0JOSBm1eZiKcweoDXEb86ndhibajSQibO35bQFj6dB4OnvgBxxR2By1CfQy58WMTcgurbHs7f6oDnvFCpzSlHnbAAFQe46mrnyxYBr68ES0Aylp5xlSYOIuaL+XZgFdeNfzHxX24PsYGZrSFNtzr80ymJ9MAC+RJ4yg0UmlSgmdQ4PaoKAjq3sDmYG1XiD4o+Iot0W0i5hA+z8XcBP/fCEM8QT1/9MyApl0T0yM84dcb71cP7wdIsp2VivjbHTu3hy/PTvtovrytok8R+EL3hFds/37lGdc7WAjgaHojeM/k7T39el8fAbEZkavM9lv0aWTtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HW4kwbdI0BpSYNXs1GN275i278SiMpDLVTJe3IVSrc=;
 b=c00QrA85Zug/gASOsqY7YDoeV1Rr3mu+p53FATmG3zGI3kGHj1FwoI1U6J5r4Le+lafsahd6UVrdJu21Pgmpif8l+ynpxCAt11AA+WjvaPOLT9cI1VWjPjy9BzFWe5c+unEDPDjkzxjskRtz7xuYZu95C0Hk2IiLQHtgOpHh5gu8sDBaUuBJbpjKh8NqcvVwZCbNecdlUnRBKCc/1EnhkQo31Oy0tgJTn4+3PSr0/2BLjjsCDrjcy6/9KukVPausmg4fS714+kmMA3CIES9ylv9YDy/r2rx96eXpfvTpYQPg3v0b7UhoDFEhKw9vtYCqZ8c828UJ5I/vJjHJVPTT6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 10:19:50 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 10:19:50 +0000
Date: Fri, 6 Nov 2026 18:19:44 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, jgg@nvidia.com, 
	aneesh.kumar@kernel.org, aik@amd.com, yilun.xu@linux.intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, bhelgaas@google.com, smadhavan@nvidia.com, 
	ilpo.jarvinen@linux.intel.com, Smita.KoralahalliChannabasappa@amd.com, 
	andriy.shevchenko@linux.intel.com, linux-coco@lists.linux.dev, terry.bowman@amd.com, 
	nik.borisov@suse.com, brads@mainlining.org, lukas@wunner.de, rrichter@amd.com, 
	gourry@gourry.net
Subject: Re: [RFC PATCH v2 5/5] cxl: Invalidate cached coherent range when
 Normalized Addressing is detected
Message-ID: <au2o823gktor19qu@MWDK4CY14F>
References: <20261105152909.53452-1-ankita@nvidia.com>
 <20261105152909.53452-6-ankita@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105152909.53452-6-ankita@nvidia.com>
X-ClientProxiedBy: SI3PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: f32e25d4-8c29-4947-9fd2-08df3bef7d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261102130727099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	k8hes3JX/4rjA1aa3Z2+fMgRSH2IOu9Y3ILB3ELkdKn1J0a29cCt6gOOCD0KSZIZ59ef9hqXQ5SBQ0ZqKRgltnO23gyhw0fwwQF650VVIX+4cLPnDl7k3Jx/9arowywjL1nFMlY+HsPSkaLMeu+LUZ56KrCkpbJlhF3yTwdkGPduXMwo1MXYeAettTHu6OGMm6s9BZyz0G4n7LvcfWcp0O49xEIwODCvM5SDLXYSI81i7KapEeiXQePyZAt5TGMftD6tdYpYJsXEDneDv9B4IBiy8lHT2TUGhMgzbHu67vmWfVNdfkipfYQG7VhKJxGQfQNZFUu/Z2oV2whQCH+bjq4GdgDDrI79955nkEKT9WI/J/PgYr7tfaBb5NnEi83Oskq3SVAGrOrpSsCdue2mRfK0UQMyiBXuwT33ZFaAK1v7MWaJZESlWscefgWZPMIAzu1SDXYwi9fdOY/97WdrnivvrRIy4nHAE+e/YIPBL1ko3iCHx3zadKCehQJkVYTOqo+2IL/03w7TWcZb3FmVMpHvFitgBF6Gv59JxlDwqHYJU14bpOM0ECJnhJKRVnLbYw+F5stzo4tnXJETBNMmhvFvVh8xTOZONjRmgvQMjVJ4k0D9UZ4TECbhRID2DAt06n5tIYoivh8FOQeji+cMNzic/nQVtNrNKQFvXau9qMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261102130727099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IpYMvektnwm3bEi0YhWSomVoVLproqMisfB7K+Sir9Z8IbITbHZRDVZOtPzN?=
 =?us-ascii?Q?dPFpLiE07Qvq3RghJv7l6KsHJgEGAMW5eNqzZY5lIc8ggw63YZ65gWsK0Eim?=
 =?us-ascii?Q?zYv9elwwLGQuUzlKNMAv7N7sHLJqy0+0KNzvbyd1y83I1DkDE5MCi8+btvWA?=
 =?us-ascii?Q?cCB6E66CcqUe1j30YwxjC612rHNW9Cn49QDQG3NqDAE0rAOBxokG661mYHUm?=
 =?us-ascii?Q?3NLjxIuUqjNIAeiN6uL+v7jNkHyRb9pZZmelGQiFdbo2gxlF3kaXXTpvlyd3?=
 =?us-ascii?Q?5accD2apSA+/xIwrryv1rK+2NartFpE2AjJ7Z+R8pMTFulcm2/BJjPAU12ft?=
 =?us-ascii?Q?oyfHqVhFBYmH6JmS8dN6fQVjemuWhOL2jIa1T8xS1Fq+Kk8VU6g3GjK3AsJN?=
 =?us-ascii?Q?JW9ISQOs6wE2RqVAesC2BBu3L/6XCyqnHOXJzJdhLvg/y2kbOp/07fANLz0P?=
 =?us-ascii?Q?A2hiCa2r1CBcerxn2pR4Ox4rKrzlkAGbNxswZCg0k+yr2qOwH63vlavmb51O?=
 =?us-ascii?Q?oT8JPEMSRjnCFoyGOG71S52qVKAAAF3TAIKa2M/N7xn9+bTIzIpEaS3vBz5R?=
 =?us-ascii?Q?lNtoLA9bW6ZHUj41lqoXkJp+/uEKQQzmDrGrLusrM+D5DKdLyjdubSIDzLi4?=
 =?us-ascii?Q?B8EH/IPzZUeLZXS21C/5XGSA6DdMYUQODWXg7EBDexw6aiNoVg5ospJYwqox?=
 =?us-ascii?Q?NzA8OiVAMABUglDl+Ab35Jcgj4BQkWmQOWN9aIGIvWI24GXUhlYx1Yv/51fq?=
 =?us-ascii?Q?aAp4YDsUzCuLwx70zlxVLHEdDUxddJ3qJQptxv4ujQA8TTwOrE3JhAOUd+n7?=
 =?us-ascii?Q?G46WebX9/e62q9DXankN4BJ/50PqzrdDBpsF14TfStLIh88/uEl5GtqecZl/?=
 =?us-ascii?Q?BdkycpB9QC7w2bI3iVIBl4mUKP+LNKHczFy/I9DhtzNsuLH5x8HdZWPlHZ9m?=
 =?us-ascii?Q?5ri8QbqLvWNvIbGba+MnK7VFZR+qgK23i733gbHgxtMe4MMYwGrsO/7Klew0?=
 =?us-ascii?Q?uPr8rLcS7pfNg08qRXHrM3y1WqTrtW2G9bP0cAm921ObpBxVs2RAWHS7W8ZP?=
 =?us-ascii?Q?llCquQKKLHlSfwT7YSK+kHPSIUS+QhH2StypLd6rEB43hPv7+OUfqSj51LGG?=
 =?us-ascii?Q?8IHy94QObL3XA3KQuDsmSLdNub9ScWekWtWcNkiq1tG4Nski4JzKjn3RlaL6?=
 =?us-ascii?Q?HW2WZdjD4N02xfhujaK7ssmJ5xTYPGOE0BkdUXBwxbqkuSzN9ResYad8u2aF?=
 =?us-ascii?Q?z7Q0p+KHpodUMRJ2/axgfUrXk0liKUXhN0iEOs28+JngI3a1jaFpGI9aP2sC?=
 =?us-ascii?Q?OBjwu5tCDCmfd1HxP4OlHQJA44nICFmuCSF+77/+eE4Cg/1yzBBanKLBApsa?=
 =?us-ascii?Q?5lX0vyDtYsfeUzYRY9rOKKuqo2jl5MZ788mGLbGTeMh01mu7GfBFCA8bag01?=
 =?us-ascii?Q?Ao3HxxwxRzQT3h/JQdsn1GApYp+qHGl7gHAm2d6jnAG47B27cwhXyDgl1xzu?=
 =?us-ascii?Q?2v5nbEkkZbfFJ7DiGOhI9I2CCv+yJEezfGgMe9fnCIoTUhEdJbRA5QEboPzD?=
 =?us-ascii?Q?AyYZqL1YbKVrDGmxaUja3RhyvHlMn754d36rYqxHVHk1BG7oL6KnMPkU4fi7?=
 =?us-ascii?Q?GOewRBpiC4DFgqwX1PIt+pLjEClhIt9Tyuk+8hC9FtcP25euFhUXLsZG73p8?=
 =?us-ascii?Q?ltp+AmPyhis2+uCEzg2FtDQ/rAQUU6uSdJR67A4AzG6N9eL0ugd3FKWxEVDx?=
 =?us-ascii?Q?fXFAVgFKWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32e25d4-8c29-4947-9fd2-08df3bef7d5c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:19:50.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HuHna+3u7a6FeoVEc0FPmIISg0wBPxDyQrxpVIkZuuctESGV+d0libHJo0mBPGdug254Wz4XRQhOk7TpSpQ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

On Thu, Nov 05, 2026 at 03:29:09PM +0800, Ankit Agrawal wrote:
> In case of Normalized addressing, the HDM decoders report DPA instead
> of HPA. Determine such case and ensure the pdev->coh_resource[] do not
> cache it.
> 
> CXL_DECODER_F_NORMALIZED_ADDRESSING is only set on a decoder once the
> endpoint is assembled into a region in cxl_prm_setup_root(). This is
> well after the HDM decoders are snapshotted and populated in
> pdev->coh_resource[]. So the DPA would be populated in the
> pdev->coh_resource.
> 
> Add pci_cxl_hdm_coh_invalidate() and call it later when the normalized
> addressing is identified to clear the cached value.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/cxl/core/atl.c      |  6 ++++++
>  drivers/cxl/core/core.h     |  9 +++++++++
>  drivers/cxl/core/resource.c | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> index 07ce7c50c47a..2bf4d73fd02f 100644
> --- a/drivers/cxl/core/atl.c
> +++ b/drivers/cxl/core/atl.c
> @@ -175,6 +175,12 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
>  	cxld->config.flags |= CXL_DECODER_F_LOCK;
>  	cxld->config.flags |= CXL_DECODER_F_NORMALIZED_ADDRESSING;
>  
> +	/*
> +	 * The PCI-core snapshot of this decoder was taken before the flag was
> +	 * known. Invalidate it so a DPA is never exposed as a coherent HPA.
> +	 */
> +	pci_cxl_hdm_coh_invalidate(pci_dev, cxld->config.id);
> +
>  	ctx->hpa_range = hpa_range;
>  	ctx->interleave_ways = ways;
>  	ctx->interleave_granularity = gran;
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1aabbbb4ae5e..97d27a27ab67 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -139,6 +139,15 @@ struct cxl_rwsem {
>  
>  extern struct cxl_rwsem cxl_rwsem;
>  
> +#ifdef CONFIG_CXL_RESET
> +void pci_cxl_hdm_coh_invalidate(struct pci_dev *pdev, int decoder_id);
> +#else
> +static inline void pci_cxl_hdm_coh_invalidate(struct pci_dev *pdev,
> +					      int decoder_id)
> +{
> +}
> +#endif
> +
>  void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
>  int cxld_await_commit(void __iomem *hdm, int id);
>  
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index d837f8e952a9..d0774926da2d 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -527,6 +527,38 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>  	kfree(info);
>  }
>  
> +/*
> + * A decoder is found to use Normalized Addressing only once the endpoint is
> + * assembled into a region, after the snapshot. Record the flag in the cached
> + * settings and drop the coherent range so a DPA is never reported as an HPA.
> + */
> +void pci_cxl_hdm_coh_invalidate(struct pci_dev *pdev, int decoder_id)
> +{
> +	struct cxl_hdm_info *info;
> +	struct resource *res;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info || decoder_id < 0 || decoder_id >= info->decoder_count)
> +		return;
> +
> +	info->settings[decoder_id].config.flags |=
> +		CXL_DECODER_F_NORMALIZED_ADDRESSING;
> +
> +	if (decoder_id >= PCI_CXL_MAX_COHERENT_RANGES)
> +		return;
> +
> +	res = &pdev->coh_resource[decoder_id];
> +	if (!res->flags)
> +		return;
> +
> +	pci_warn(pdev, "CXL coherent range: decoder%d uses Normalized Addressing, dropping %pR\n",
> +		 decoder_id, res);
> +	if (res->parent)
> +		remove_resource(res);
> +	memset(res, 0, sizeof(*res));
> +}
> +
>  static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
>  						 int bar,
>  						 resource_size_t offset,
> -- 
> 2.53.0
>

Hi Ankit,

Maybe we need to export the function for cxl_core ?
with the following x86_64 config, the build fails at modpost:

CONFIG_CXL_BUS=m
CONFIG_CXL_RESET=y
CONFIG_CXL_ATL=y

ERROR: modpost: drivers/cxl/core/cxl_core.ko: symbol 'pci_cxl_hdm_coh_invalidate' undefined!

Maybe we need this "EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_coh_invalidate, "cxl_core");"

Best regards,
Richard Cheng.
 
