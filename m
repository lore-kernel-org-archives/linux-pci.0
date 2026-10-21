Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792601855;
	b=yn19S7CPwXL/tvAe5Z13bU+saTLtQpD52Chh1OgtbCxK/4nvhPtCoIFh3r8Q2X2JegKM
	 EHHSffXEWKtcYCjhBKhmg1pGuztuxeT9OnOw8nKc0/RmAOMrV95nT6akhZqjb7dLikfmT
	 myjNuQyHR3cI7vtR2oExgci0bBXLKpBJJ90AObiBD6AnFBqfiipwAKB8MHNPJc0/qODid
	 mri3oMQduoWc9teLu6H34aSZldu26By73gA1pDtOHjGSCcsnXaKUsfsLy32gDvZzg0veQ
	 i3b1Lts7P9gm6yNL0CqUOG6b7tIxnGcr11gZnzqPAQicCSVmB2u7Y+DnyBjiIfA4QVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601855;
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
	bh=RM/YX2wBTINfEb6574A63dtRObGC8PO2khkIHPP7D3M=;
	b=hmyfs17ERQi7wvE178Pk97tSIIuvkTzzJ2YZAtJw0q82NS1L8126nvqqLH5zF+S4KdaW
	 8Y9qlneK0OMdH0W+U/hBUikSZewTX7sYNSZdNX2DUuisk58M7z1+WUBKYdNu/qVcMGHaW
	 5+7C6rVZLvtEHA4VTnC55CvIudsnFXYhzyqpZjywHQYu4adi7moVkiV+jhkL+zYYjCi5t
	 eg0BqHaVLK1i1YRqW4GxMccLxSQlydskhS6cnL07/matLT3KXITR+3OVGGCkovGoTY92Q
	 tB/Qt1cjHcZJxjEZn/VVHFyk4ER3LcobvM2hfnHuYRU+WZWMmrCIG5yw+ZkfA4DKFYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=at05ZyJ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.140
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021140.outbound.protection.outlook.com [52.101.125.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC7606A319;
	Wed, 21 Oct 2026 16:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9BC7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=at05ZyJ3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdQJXZK6FYj3PahdMEctwWdpwxSYnStr00JgRFiI4o8IIqfsK+5VevFiQekZW72ph6AhYR6ABMPVoocK3bRiW9cO2fygHvGPHiihqardjajsCeyp/rcBAEEeRPTP/GiUewG/Q7z6WBkoOo5Y35HHt6oxmvuCZkhN8+E+Wm33QtWQAT/LijP9GBQzQHWAt9wcM7ei0U/n/Slzmj9At9UEgB30a6Mi0UALL9jOqJHHpIwfGHymFKS35PcW0K8nA9UNSdr8ypDdSNSL0OJmLdmzji11YkK1OvMGMH/ozXGz4JLSdB6jNE9B/zmv59/QMmEEKTHx1UPeHZQiJfeIXtQDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM/YX2wBTINfEb6574A63dtRObGC8PO2khkIHPP7D3M=;
 b=TC1KAUM5LNk76iunwu7COm94m1ikvxbjwWys5gFS/n2DGSXYqyjjvc3dGFsRXbDFA0ig49dOqapXYhSpEk66um0+Poy6UjVgcQTXQmkeKER8mfyjRzEudhENnz+97BpvGQVncfAF/CL+u06zn3KWthQeSAYB/CgYZX+bJN/u5F5L+pVfz3vw1ctEF7M2pNRdajYz67wgx/jzhTbk+Tspx/2pCJrPPCRXC+J1ie3OTU5wEWTCkA98hjqCBuuv7ZnDdWIt9RaQHtz3baDn2TGcgFKgeI5RoA0JjXzg3HIJXAcq97n3NH58n2TlOKe9CJJ6IT+471mNckw+uhbVgV3fZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM/YX2wBTINfEb6574A63dtRObGC8PO2khkIHPP7D3M=;
 b=at05ZyJ387nFGsCFY9iMKyyP6cxDB6QBC++GCNYARwWj1MBHupMrUfhCvPrlwjo831y2FYAjXfBJrBeSSJUv/H/9TdcP0i57sl8wIDVh+HN5HSFx4tQ54hgnTbr3LQ91wFpZs4jp2S78mu7RE2huTfkyQ4cupxS8xFs/jq5XC7w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB4206.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 16:57:31 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 16:57:31 +0000
Date: Thu, 22 Oct 2026 01:57:29 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a
 BAR
Message-ID: <eg2sbks43lnyvs7i6jtzqkhqkgpjalgynhkwi2c2pkpklrbekv@oiscofavvmxh>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-11-den@valinux.co.jp>
 <atjhPo42pjkA8vJK@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atjhPo42pjkA8vJK@SMW015318>
X-ClientProxiedBy: TY6PR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b422b5-c28f-47d9-ef91-08df2f946556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|261021123027099002|56012099006|4143699003|261009223027099003|10067099003|18002099003|6133799003|261021121427099002|22082099003|27256017;
X-Microsoft-Antispam-Message-Info:
	0kpFfXCyxuYShdYi4WsBcAP56HMIIebgm9XkSfhVTwKLMO2zPRd8t/0OI9IBA9ZkHnC43U8oLXoCm5TK0SL6m8YzSEo71HQN1t7YJUDKGFRMTBQEhp5UkkEIWF39I+HNOnoSplvDcyMh5OxZJI9Va4k9LmhPHHSuHNy58xXh/Q8jn36hATBsrjgE4MkezKOULJXyqTgzgNA7Y+XNmCjsYveFRxLpqgGsETccSf80AwubCXJstCo4Fh7C9FPGKLgTArMnCRcHGQUGKu7PJQ25OFQA727bgVmP4L2jK4IqSVAI1WS6sIwOYKq6/j3vGAKFjs3s6mVPROIkmC0JgfyFKtaY4ajRjj4QPW1hXOaGs0cKBBONRSld8lHCmtCWClM4HuvXqRCJmwgekoWjJFsEOLHnk0HUc/tGOsPS2divuKPloL0lpO7I7A05qkblBqcEbzxBh8vHEHcV2uSoIhls8pg+KJRDDzfoZsHystJgx9pBq0U6Xp8tLsAoLszQjrWLDEtJABCDawXmNiU0ZXqOShnMVtN6MGzEMIylvopmPo4piVHC4Yx+0wgrQO8dFWC94AHf+HdbRyPBnKypPXYtOwqwd1RWwM9GJnR/KkvOOl8Fr08w6xae7HaO0L8KT3qxaodXTvEhVw5Ftv4rJl7OQKYD3FhpKzMvi+aKMlT4VqjZdfZ0f2h/cIjivwBhV038q52dh3X+qfw+fXZnASAdLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(261021123027099002)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(6133799003)(261021121427099002)(22082099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3c7ilTxRLHeRdAUZ7fAd+s+q78W47VfAF1qqe5ltNRceXFPtbaINJsI6U7By?=
 =?us-ascii?Q?5SVPYrYp2DtAdzsgqG40IFjVV+Vy4+0Fr8lHiqlNa73aozpbOqo8NNzpIuDT?=
 =?us-ascii?Q?Tu9cVBVkdl63ndPEKfl9iKCx1YeqvJCBLXNMFbRSVVHFqCD/UBodqIHWNbls?=
 =?us-ascii?Q?WWcJ/IwYAnu4tODj2WAbvGufWKfu5YdFczaBw9DYS67GPAs50GT80bswvKsu?=
 =?us-ascii?Q?CvTnN6AkoNEH5KXPBv8GI10E/P0U9g1HJS/zsTmgfEoeKw2KHt4NJUenHx6k?=
 =?us-ascii?Q?CXg/S36+9oWc37pzpDSQ56uGWCvvMRUOjh0ZxP0CwvSAHORmATq0k43XKsg2?=
 =?us-ascii?Q?CK3x0DO6Xv3K4qAkIq40MoKKt96OOBBqBmzs6Q3LSAgDAdbgm6ZLLqrUjIG2?=
 =?us-ascii?Q?Y9Oyah0E+r/FpQq/xynaXXIClVMLo2YdkKi5NxZ8LoJkyz3EZF7kOfAdu/9z?=
 =?us-ascii?Q?Jdn8e0Vp2hk5WJzsNXsNbWbkWF1+hdO0VQDiaNKl2ysdNGnOyiTBP89v3/kX?=
 =?us-ascii?Q?XrrrFB2VGMVpOara6+HzVSrssVYNAbN/XKIauEesreeR9YTQzGDHumoLJfvf?=
 =?us-ascii?Q?CyYz518siJHz0jc2LSrhpthQ5LeQTwpqspp+331ddXcE8Fwca5GQeDk4ChlP?=
 =?us-ascii?Q?547m7/+dTr947Y/fKkNY5IPOtVE3t8qSeRhzSgYlzhfP3SfvFgtsvcYAq/Rp?=
 =?us-ascii?Q?xZy66vDBmPzW//vQAwN3mZgHVYA8aTq/iunhG8WJI35890VQFxRVwhlgKPMl?=
 =?us-ascii?Q?UMmJYdiWO5cWIQ7x0aeqQ0R2eATtrRDmvMesXQwrSpqvXQuc+som7/c699i0?=
 =?us-ascii?Q?Ey7nfcjz2XpBi2Wl4PxpPwTwTiC1AsIhB+ohNcJwH7LCKCcN/kAgWkISNd4i?=
 =?us-ascii?Q?+1E9uiXlpN+r4QbiwoJsNZMMKNaBZquuMAVSUxmrUjY5HvgVw3QqCHr9nYfy?=
 =?us-ascii?Q?ePd/2pKpVvL645ff0QbinFvlsqc6y1ukuH0QvjC3kfCMRkohai8ROAstfznY?=
 =?us-ascii?Q?jTB974x90aBJn4PXVKpHYiR1kM2rLcncVuaW4uzxbKutSGRDnCJejHmRsYU2?=
 =?us-ascii?Q?I15Dp5lcWJqMPH+Hsq5G1mixbPFar8uoKWVU6mzIqnPIzi7MLhD5RD3tIoeH?=
 =?us-ascii?Q?bJTUylpHVky+8qV967MOZeCoU8AGwSooLxDUPOuqoKq5lGpujz3dlU9RfCi3?=
 =?us-ascii?Q?sSkXeIpDe5MrvMLZfNeuP2kI8BhzjosRx7bB2+LEIPAhq1Q/9wyHnUqW4RjF?=
 =?us-ascii?Q?SGnh8Oobc/2z1QU3OkZOOrF3oWusjUE9ED7ifBOrKLIlNDynzIQc6zp5fMX0?=
 =?us-ascii?Q?ouxQK5xm81UUvVLKHRzHkKfJpjZRSbQh9t71cA0UaKJsF/vi6iWfUJ6BZtqd?=
 =?us-ascii?Q?9QX4pI6HYen2vb4SgfKBMH2BPVMkUhdBE5djkLoCbNWLZufPbTo51TrhID8N?=
 =?us-ascii?Q?E2lfwokYaII60ZwynOgUs52PECvd7htryN5cdSnSg1xzPi0aXEghoo1zxTFZ?=
 =?us-ascii?Q?7Lf5qf5doCGScqmdPyh7wHRAGOy13eOyHSjrhHBYAwBoNMXAUgpGJE7Cs/b0?=
 =?us-ascii?Q?DG3bWuFJHi9Z0cdGwDUmiZY80J6ZotwqtCXM+V+VAb8Eo/2i+qIuygdbI8Ui?=
 =?us-ascii?Q?Lny36QZnFadf1iYP8Yz12BRDDwsD2r7DSC3Jd9kESluMco3lOsEY063xVFqd?=
 =?us-ascii?Q?J5KfrooO+HE074NZ4r9nu/mUavq0GAQEjSjTaGVuQq1oGLEkqdnDCkIAPNQv?=
 =?us-ascii?Q?FCUmKA3ZaF8CMpfTxF/EHYZumUD+Xwa5zKO1SfduacuSzTpxQ0q7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b422b5-c28f-47d9-ef91-08df2f946556
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:57:31.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSNt/438MjHkXWDt/LsKC7o3jH5iEUlvrYWnpipPYjEH5Z9za48tITK8l4gmx+TaWfWjybA9m7gPTN6oFuF2xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4206

On Wed, Oct 21, 2026 at 10:58:54AM -0500, Frank Li wrote:
> On Wed, Oct 21, 2026 at 01:22:29PM +0900, Koichiro Den wrote:
> > A vNTB endpoint can place DMA resources after an MW in the same BAR.
> > Limit the MW to the advertised boundary so clients cannot overwrite
> > those resources.
> >
> > Advertise this support in LINK_UP, including when DMA is unavailable.
> > Older endpoints ignore the argument.
> 
> if ignore it, any side effect? Does host DMA side use wrong memory region,
> which actually is not mapped by EP?

None. This only advertises the host's support for MW/DMA BAR sharing.
Without DMA metadata from the EP, the host does not initialize endpoint DMA.

JFTR, this is the case I described in the cover letter, see [1] below:

  EP                              | Old host     | New host
  --------------------------------+--------------+----------
  Old                             | OK           | OK [1]
  New (dma_bar = -1)              | OK           | OK
  New (dedicated DMA BAR)         | OK           | OK
  New (shared MW/DMA BAR)         | Rejected     | OK

I've retested the [1] case with R-Car S4 just in case ...

Best regards,
Koichiro Den

> 
> Frank
> 
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v6:
> >   - Split from the BAR-sharing patch. (Frank)
> >   - Advertise MW/DMA BAR boundary support in LINK_UP.
> >
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 46 +++++++++++++++++++++++++++------
> >  1 file changed, 38 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index e0016128b95c..56185870cba9 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> >  	return ndev->barno_map[BAR_MW1 + idx];
> >  }
> >
> > +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> > +{
> > +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
> > +}
> > +
> > +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> > +{
> > +	resource_size_t end;
> > +
> > +	end = pci_resource_len(ndev->ntb.pdev, bar);
> > +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> > +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> > +		end = min(end, ndev->dma.submap.offset);
> > +
> > +	return end;
> > +}
> > +
> >  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > @@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
> >  		*size_align = 1;
> >
> >  	if (size_max)
> > -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> > +		*size_max = ntb_epf_mw_size(ndev, bar);
> >
> >  	return 0;
> >  }
> > @@ -524,7 +541,8 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
> >  	struct device *dev = ndev->dev;
> >  	int ret;
> >
> > -	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
> > +	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP,
> > +				   EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
> >  	if (ret) {
> >  		dev_err(dev, "Fail to enable link\n");
> >  		return ret;
> > @@ -707,7 +725,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
> >  	if (bar < 0)
> >  		return bar;
> >
> > -	mw_size = pci_resource_len(ntb->pdev, bar);
> > +	mw_size = ntb_epf_mw_size(ndev, bar);
> >
> >  	if (size > mw_size) {
> >  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> > @@ -739,21 +757,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> >  				    phys_addr_t *base, resource_size_t *size)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > -	u32 offset = 0;
> > +	resource_size_t offset;
> >  	int bar;
> >
> > -	if (idx == 0)
> > -		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
> > -
> >  	bar = ntb_epf_mw_to_bar(ndev, idx);
> >  	if (bar < 0)
> >  		return bar;
> >
> > +	offset = ntb_epf_mw_offset(ndev, idx);
> > +
> >  	if (base)
> >  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> >
> >  	if (size)
> > -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> > +		*size = ntb_epf_mw_size(ndev, bar) - offset;
> >
> >  	return 0;
> >  }
> > @@ -851,6 +868,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> >  {
> >  	struct device *dev = ndev->dev;
> >  	int ret;
> > +	int i;
> >
> >  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
> >  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> > @@ -862,6 +880,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> >  		dev_err(dev, "Invalid endpoint DMA layout\n");
> >  		return ret;
> >  	}
> > +	if (ndev->dma.submap.size) {
> > +		for (i = 0; i < ndev->mw_count; i++) {
> > +			int bar = ntb_epf_mw_to_bar(ndev, i);
> > +
> > +			if (bar == ndev->dma.submap.bar &&
> > +			    ntb_epf_mw_size(ndev, bar) <=
> > +			    ntb_epf_mw_offset(ndev, i)) {
> > +				dev_err(dev, "Invalid DMA/MW boundary\n");
> > +				return -EINVAL;
> > +			}
> > +		}
> > +	}
> >
> >  	/* One Link interrupt and rest doorbell interrupt */
> >  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> > --
> > 2.54.0
> >
