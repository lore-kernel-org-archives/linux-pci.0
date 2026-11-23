Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795427559;
	b=t3h9WahfEZa5yaO1p4PX5j4TTSmdNlaK9RNm7UQzzQXUmvsDQfHX7qwIymEo1WlnVyVB
	 YbAReRrUXSxxTBy+NOspKHilzDSL17GyWqDPvgARdIofV49qUE6Zcyg4csVvQxVo7woNl
	 n6I7Yp4Xc8mb5lu+I6kJjmZAa1aDxPYSVXxjSe3TYT7xUTrYgU1z43cpzo2l7fFzQNhQX
	 cHQiBOgFcai2tIBiQnr7wooJnf+lMHX5LoWHjMpw1D+QKGvtWeMeoV3BRVzYKSIweUN2O
	 wogW0U+bXh+oaEAsnXlo1oz4d1JbOessXtEpyxDYjTFFnINkjZhuQnHtlYp+3B3c80g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427559;
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
	bh=lMMUO+QDnrRuV1tnG9JLulKsn9gn6QPnjETDwI5o6vw=;
	b=jIhJqasbBq02AP7RJl3fH4tRnXVsaDY+smpGKRK38+TlicM8I8mt1zWep9g3XGkyhRAH
	 xnYU+8n055t1XeOvrv1iynJO1M7XTjT5B8Dbq1TnWTHIBn2fzuDiYTjt+YdTXYPZzzZha
	 GhIqT2OELDlL21dcP5G4pWNKXgYCRWYXNyh7ZLKHgW66ZjoiCHRG76duSnFgU6y71GX5r
	 sJjfBX42fRFhwrDl0GXNWu/S9OubOyuCDkQG+hNoLfp2gn5Eue5N4gaVgX5jyPdoXXpcd
	 2d9su0slx0SM2hSfTIgiIKLAsK0AyvDcGJJUdQ/Z4fluc8w2HFh5ubZBRowPf8Zq6Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mhkwV0pc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.35
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792FA606A31A;
	Mon, 23 Nov 2026 09:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mhkwV0pc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKPxU3EI3LNqySUs7IAdzbRflKMkGVYAd1Tb65+fdnsxf2Y1CkM+D34K3ZdeybA28nf+HOpLCUSHOMNecRyNWbG7xjNpJygGQxHQmwCwdzdLPkpl8xguBFwcuhInMRK76bv5T+ZIhXkNA1ht7uU0sxhiM96R/4LPNkanCfi9DxXkNARLX3MnCGOkWhyTVG6s6pN8uVWaWZ2oJynWc6FcdXFsVgS3Q0D4+kCeLTlMYL/zvBQHVGzEYSBRdZgaBzrMLyrIxsSmjh6dP2Xfn8lj6/FihbZJcwkCZQOKKpW9he22/fz4aCbi8ENgbaExiuW0QLAPBXjEP/T8IboIn42qTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMMUO+QDnrRuV1tnG9JLulKsn9gn6QPnjETDwI5o6vw=;
 b=jl2jXpTXxc8XaIc2XCl7E+iJLwpe5Vzv7H6CdnrN4n24QsebX/wp6/mjmIHbLlGyl4qtNPorI47u0/dYBCx4MP/2wJuv4/Z6MszSYTig1rJ40WKQ4LNfezoWYeK49baOf4xNlu6GRi09qcS20CUn16ptU/1FRxWakSgW+WuloQ9ECBAE/5sNDBPOWof+KK5YioWWRMkoGUPUZh0iJsws2Dp53XM2Ic7NjbjlzWm0ufkS9tu5eyAb2F9Q+J8LmSD2Tv3j8ligJCYwXdN2n/ij8jy2UCdTl+KzNrTsqGPhFYAC+inzEkCr2lpNSdhbFdsMbuXYHC8/XQomuIu9KXd6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMMUO+QDnrRuV1tnG9JLulKsn9gn6QPnjETDwI5o6vw=;
 b=mhkwV0pc7MlbN16aHfAY0Pq6ThBuuWTnvq2zc49tOMOoeE5WQWvcFC1fMod6fHGTM4CvKh+iFBsuEUP0Ji2bleGhdsphAELMbCaAqLbKT0qCPeqBD9VF3tG5kPrzH37XyneZfK9W1ubJRAfCYb0t76tYE4NKHjLBUynJ1O5GgT/E/gQbMBW0jmmmo4rbwsOmpjKzfyJGQl43oEccU8AzASpBPohpBnp7IDLAT6rkpuRHr3Ee0tRjDTBPU8VhmW/W2lRSdy928fkIVMbyZ1NDew6PhVo48IyMB+Qf+5bmcCa2hXRt240BBoVT25Z2GrZCPJktdudJReNoevgqC4kgpg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB903269.namprd12.prod.outlook.com
 (2603:10b6:408:40f::22) by SJ2PR12MB8927.namprd12.prod.outlook.com
 (2603:10b6:a03:547::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 09:52:33 +0000
Received: from LV2PR12MB903269.namprd12.prod.outlook.com
 ([fe80::29c8:652e:e2b0:4dd1]) by LV2PR12MB903269.namprd12.prod.outlook.com
 ([fe80::29c8:652e:e2b0:4dd1%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:52:32 +0000
Date: Mon, 23 Nov 2026 17:52:25 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, helgaas@google.com, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, tglx@kernel.org, wangruikang@iscas.ac.cn, alifm@linux.ibm.com, 
	shawn.lin@rock-chips.com, lihaoxiang@isrc.iscas.ac.cn, 18255117159@163.com, 
	xiangzao@linux.alibaba.com, vidyas@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	newtonl@nvidia.com, kristinc@nvidia.com, 
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v3 1/2] PCI/MSI: Skip MSI/MSI-X restoration when config
 space is inaccessible
Message-ID: <awQJGfWYyqYCmL09@MWDK4CY14F>
References: <av_8-NLyjXUQC0lK@MWDK4CY14F>
 <20261120163909.GA878361@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120163909.GA878361@bhelgaas>
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To LV2PR12MB903269.namprd12.prod.outlook.com
 (2603:10b6:408:40f::22)
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
X-MS-TrafficTypeDiagnostic: LV2PR12MB903269:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af4a2ab-b773-4919-83d8-08df49477e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022113327099003|261022075727099003|261022105027099003|261028144727099003|11063799006|4143699003|5023799004|56012099006|10067099003|18002099003|22082099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wCz75BQ/L52MjxFzkVn55DMVMqojvqa+lzEcoTuoRESKiEBBY+O0i+PYTclfq/LS/q/+jz8RnmKTDB9xwGN2w9YEUr5jkt4yjXtJkB2K24aOQTeAjpFtt3nXI+zL5kDwYkVo+nDqkeCQo70RxDJpyoLzRiciYo5h26kW9vvYfbLkCWCt5tOq+dZiLbta+l8oexWSQPWVqgaARAl/ZBSE+L7betNlDPznBpnx/JkvQna/KOWM3H+n+CJnE7UDeBTdTXB3JpcaBREOSXUd42OuQ5mXUlHBwcdW/a1ypvsp+Jwq1P1Lvqb8hLTqH9MqW7KFMeffEQah640GRWYqbr5CAn8qSn53AGoPfJ+1E0v9lcEsw67Ezx2Eed/efy6mnvDxlb3dikdYRny5qOVmSbCZSIQOW1kWRm7l8zHITLtwoHa5nmy0k98qMS7yVO1VEJursaA6nHOYCOX2K8us3vEIWZActA7l7Lvs67GneE8JOrJSiI83KluUI01ojFT35d7n4z3a0xagVRNsFsNH7RIfJnADl8DsHVou85Erd7a2ao/tKrUewmueCLqaDvxaAi99A/rEnJnf/sWboy2xDvsdo5+MifyZQ+yB4L70ec8FgkSWM+L0Y7hIVAPczIW3CbBuOJuqvJt4InKWXYLA9bOS+JuVJ11gSQA0B/mTjdJvd7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB903269.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022113327099003)(261022075727099003)(261022105027099003)(261028144727099003)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PkzDjxFNju/V7QnLQreuYL0az0RA4GHPH+AZfyc0rcT5WoA4TfvY60v42D+A?=
 =?us-ascii?Q?EyIsbOzG5C7QvRJZjUkyzNCoVzkzIkbVADJ78/daCzlcxJ4c0Zin7jj5rjAL?=
 =?us-ascii?Q?K5xEylC3Chu6Wu2K7atddnz0UbHcYYNFoCTnYdmvgxXact1Cv6Vbau7m57+j?=
 =?us-ascii?Q?xBN+arhHg+pEmssdfy4a3RGeANrzdI3vzGSFsaC9Q00hzXoUkD0DAORPk8Ya?=
 =?us-ascii?Q?FeyPa38r2qECgEMIJJaSMftNSMlH8KvBdeOrZiPQ+nZjLqMbQqlqyRNbNX3U?=
 =?us-ascii?Q?ecM3DyZA6kP0yhMpXqgF+VcFaM5utewfiL2afYg9cgvpnRPFtjpUjuoSkUM0?=
 =?us-ascii?Q?PBli/xus1gXl1m6XBcCTyL7UOZQONkVYQbAPKrYwsMUaMzb930wrtZAR6VfP?=
 =?us-ascii?Q?7oSIxfbh2mJ6HXFSdoAXpls88g8CYO4Gy2hEbN94TF41SvzP6YngTyyMH2id?=
 =?us-ascii?Q?YFljQ0JG9mByv417I9Ok620ZU54sYY4Mj30stvzoPLa1aQWdwJKOzsrhoATm?=
 =?us-ascii?Q?Hjo77U0F/oag0mYdaWsLeAZlI7/nq9xSoWJLar0QJ43NiH9b5dD2QXZCM5uM?=
 =?us-ascii?Q?dpVbganmm5GOOvm4UoMjR4vNM4HNKmoyYH7DmmiWEw4YRXzlHARPereGyXi6?=
 =?us-ascii?Q?+XfZq/Qot/C6yONfZU8CL1T01NFM/dbgpAAK/H1EvfGxq397dOUHJsYfD/mE?=
 =?us-ascii?Q?dA5BQXMdrMg/DesOZmbSNzks2AoTlCZAsYt8XCrg7HZexlXB53q2wPR8EyIi?=
 =?us-ascii?Q?WeUK5kypIR/OZ/pWqvqPX3pYcptAityDIUIPbsF3pSesYOyPRatw0c4cu6SY?=
 =?us-ascii?Q?ldrDU2/jhVGZ8EyUeKhpr2mDG9b7pd0us8p7U+AnVp7BqFoptKH6yJqWEN94?=
 =?us-ascii?Q?rdICSf/0oTDsOa/PrZnQQ55xLMaV57v7awztCX8B4YCMbtx5O9HqGC771ccd?=
 =?us-ascii?Q?TAJSBoAIQasQff8umZWCsYMctR97HpxLjNYXB24LK/HG678/lEpP8BuwvgCL?=
 =?us-ascii?Q?7QZOnpZdWHxaydB25xavSehDg74IAPakp7pR2sY2Enob93CriHJ99/n4/Zn7?=
 =?us-ascii?Q?Hn9b5jcTJ+a/zJ03VFVUnNDfzzf++CV2MpUb6r1Zv+v901dqxe44UTOYI94Y?=
 =?us-ascii?Q?/kp3K1Psp9VWybPPHYtLBKz0Z8kvA5CwCXZcmQYGwTAB0PFlSGXPyvWyzbyq?=
 =?us-ascii?Q?pUTuqfT+PHYXTmRiq6SLethjtapIEtNItvSKPdn1qn7C9keqPQ+yx8J+pv4b?=
 =?us-ascii?Q?yJ7JY+YW/QavqeP/WGeU3wxBtFEbDsviQPmG79jp/9Xu68OMzLsZq03ygrz0?=
 =?us-ascii?Q?BGhNBQjoWoE/5Y+mB92mZpIidCA8yU5RrB71PeSK84Mnjo84aAwEPl2HzJ2h?=
 =?us-ascii?Q?Nt+vf85CPACxPJnmh8oMfvFDifBoTkoRjf5YN+Z6yQBTD9IFkWankdSj4m0E?=
 =?us-ascii?Q?9ZYlPo4PPwZuZ/xxujoUQAAAUlIO7sROCOtclA9SrOdX/trQqyAUg9esctTE?=
 =?us-ascii?Q?UIBpKBxFxEDMO/5EphnkviQgocmqmfpbyegwN3KAl0JKsrGwyp6cAI4betwj?=
 =?us-ascii?Q?SDrvEayUEvidP3rJveHX8DTeIahOgkH72u/jJT9TYqyuDuBbAQ4ml/j5eIQH?=
 =?us-ascii?Q?RxELnk+dJTBaYvwFZl7EEXhLV2nvm2KJ3aR53cQsQU+cXq3ohj9gAqH5WctS?=
 =?us-ascii?Q?porWGZPJyhN697xRA99TFUlhXmaKNqeWaIoyOey8qjdv1xZdKMIssjudVDdE?=
 =?us-ascii?Q?pNrF9rJFwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af4a2ab-b773-4919-83d8-08df49477e13
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB903269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:52:32.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Syez3odP38BQl9aFzzF7thTzqvBqa1033vHSpyts16cVwqwKAUYhYLCTWBlMQfeQMPnxWOFyxlXDm/0Cxllutw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

On Fri, Nov 20, 2026 at 10:39:09AM +0800, Bjorn Helgaas wrote:
> [+cc Ben, Alex]
> 
> On Fri, Nov 20, 2026 at 04:09:13PM +0800, Richard Cheng wrote:
> > On Mon, Nov 16, 2026 at 01:09:39PM +0800, Bjorn Helgaas wrote:
> > > On Mon, Nov 16, 2026 at 02:52:28PM +0800, Richard Cheng wrote:
> > > > PCI state restoration runs even when a reset fails. If the device's
> > > > config space remains inaccessible, MSI-X restoration still writes the
> > > > MSI-X table. The table lives in device memory space, and these MMIO
> > > > accesses can trigger additional errors, including DPC.
> > > > 
> > > > MSI is programmed entirely through config space, so it doesn't issue
> > > > such MMIO accesses. Restoring it is still pointless when config space is
> > > > inaccessible: reads return all ones and the restore path writes back
> > > > values derived from them.
> > > > 
> > > > Check whether config space of pci device is accessible or not at the
> > > > start of both MSI and MSI-X path, after msi_enabled/msix_enabled test
> > > > and before any config access, and skip the restoration if the device is
> > > > inaccessible.
> > > > Make the helper non-static and declare it in pci.h so the MSI code can
> > > > use it, too.
> > > > 
> > > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > > > ---
> > > > Changelog:
> > > > 
> > > > v2 -> v3:
> > > > - Cover MSI restoration path as well (Farhan)
> > > > - Use pci_dev_config_accessible() instead of open-coding the check, and
> > > >   make it non-static (Farhan)
> > > > - Move the check before any config space access in the restore
> > > >   functions (Farhan)
> > > > - The return value of the PCI Command read is no longer checked, since
> > > >   the helper only tests for an all-ones value.
> > > > - Update the subject and commit message accordingly
> > > > ---
> > > >  drivers/pci/msi/msi.c | 6 ++++++
> > > >  drivers/pci/pci.c     | 2 +-
> > > >  drivers/pci/pci.h     | 1 +
> > > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > > index 8a0133a6a286..2865f73f5ead 100644
> > > > --- a/drivers/pci/msi/msi.c
> > > > +++ b/drivers/pci/msi/msi.c
> > > > @@ -524,6 +524,9 @@ void __pci_restore_msi_state(struct pci_dev *dev)
> > > >  	if (!dev->msi_enabled)
> > > >  		return;
> > > >  
> > > > +	if (!pci_dev_config_accessible(dev, "restore MSI state"))
> > > > +		return;
> > > 
> > > Sigh.  I hate the fact that pci_dev_config_accessible() is
> > > proliferating even though it's obviously racy.  Maybe it's the best we
> > > can do, but I just feel like we're digging this hole deeper.
> > >
> > Hmm I agree this is racy even though we're holding the device lock
> > throughout the reset/restore process.
> > 
> > I assume you mean something like a separate sources DPC happened and
> > make the device inaccessible , some scenario like that ?
> 
> Yes.  A PCI device can stop responding at any time, e.g., it got
> physically removed from a slot, a cable was removed, its internal
> firmware crashed, power failed, etc.
> 
> > > Also, this is called in the pci_restore_state() path, which is full of
> > > other things that also write to config space and will also fail in
> > > this situation.
> > 
> > Actually I was trying to cover the whole pci_restore_state() in v1 [1],
> > and Benjamin raise the concern about the drivers may depen on PCI state
> > having been restored by the time reset_done() runs.
> 
> I think you're referring specifically to Ben's comment [2] that driver
> .reset_done() handlers expect that pci_restore_state() has already
> been completed, and your "[PATCH 3/4] PCI: Skip state restoration when
> configuration is inaccessible" patch calls .reset_done() without any
> restoration if the device was inaccessible:
> 
>   static void pci_dev_restore(struct pci_dev *dev)
>   {
>         const struct pci_error_handlers *err_handler =
>                         dev->driver ? dev->driver->err_handler : NULL;
> 
>  -      pci_restore_state(dev);
>  +      /* MSI-X restoration may access device MMIO. */
>  +      if (pci_dev_config_accessible(dev, "restore state"))
>  +              pci_restore_state(dev);
> 
>         /*
>          * dev->driver->err_handler->reset_done() is protected against
>          * races with ->remove() by the device lock, which must be held by
>          * the caller.
>          */
>         if (err_handler && err_handler->reset_done)
>                 err_handler->reset_done(dev);
> 
> I think Ben is absolutely right that .reset_done() handlers expect the
> device to be accessible and config state to have been restored, and I
> don't think it's reasonable to expect every driver's .reset_done() to
> handle that generic problem.
> 
> I think pci_restore_state() needs to return failure and callers need
> to figure out how to deal with that.  There are a lot of callers, so
> it's messy, but we should recognize that it can fail.
>

Hi Bjorn,

Thanks for the suggestion, that makes sense.
I'm thinking the following for v4 since I got a clearer picture now.

- Drop MSI/MSI-X specific check and make pci_restore_state() return errno,
  check whether the device is accessible at the top so we can cover all
  capabilities
- Keep calling .reset_done(), and return the restore failure from
  pci_reset_function(), etc. Driver that touch the device in .reset_done()
  need their own check

I am thinking about for .reset_done(), since the core can't just skip it,
like you said the drivers part can be messy, maybe changing signature to

void (*reset_done)(struct pci_dev *dev, int status);

Passing the status from driver side to PCI core and let the core handle it
generically will be more elegant ?

Once we decide the approach I can send v4.

Best regards,
Richard Cheng.

 
> > What my bug actually hit was MSI-X table write triggered DPC, I can't
> > justify for all kinds of driver, so I limited the scope.
> > 
> > If you think a broader check in pci_dev_restore() is a better place to
> > handle this, I'm happy to give a deeper research and revisit it.
> > 
> > Best regards,
> > Richard Cheng.
> > 
> > [1]: https://lore.kernel.org/all/20260929020405.9724-1-icheng@nvidia.com/
> 
> [2] https://lore.kernel.org/all/8a19d63c-db9a-40ab-a811-5d761252638f@amd.com/
> 
> > > >  	entry = irq_get_msi_desc(dev->irq);
> > > >  
> > > >  	pci_intx_for_msi(dev, 0);
> > > > @@ -877,6 +880,9 @@ void __pci_restore_msix_state(struct pci_dev *dev)
> > > >  	if (!dev->msix_enabled)
> > > >  		return;
> > > >  
> > > > +	if (!pci_dev_config_accessible(dev, "restore MSI-X state"))
> > > > +		return;
> > > > +
> > > >  	/* route the table */
> > > >  	pci_intx_for_msi(dev, 0);
> > > >  	pci_msix_clear_and_set_ctrl(dev, 0,
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 7c6f2aba8144..671ffe4da1c8 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -714,7 +714,7 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> > > >  
> > > > -static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> > > > +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> > > >  {
> > > >  	u32 val;
> > > >  
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index 77efa4c5c960..98dd3dbd5edb 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -240,6 +240,7 @@ enum pci_mmap_api {
> > > >  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
> > > >  		  enum pci_mmap_api mmap_api);
> > > >  
> > > > +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg);
> > > >  bool pci_reset_supported(struct pci_dev *dev);
> > > >  void pci_init_reset_methods(struct pci_dev *dev);
> > > >  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> > > > -- 
> > > > 2.43.0
> > > > 
> > > 
