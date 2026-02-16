Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021075.outbound.protection.outlook.com [40.107.74.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D32D060D;
	Mon, 16 Feb 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249711; cv=fail; b=O1ElmJCNckPRh1p+I89c1/Mo2WaxKcoCrpwfDhlAQ1kGJ7EjGWvlEbtPbP/RkCfQzyd0sresgrGz8HIrDFFSxA5l9tCIEnoustU5ApAT2RNoP5gvKnbM7XrobOi3msbdT6VFG+3LrNuIk4Pa6t7mDRkl99PW+NvitYNvLHD2Esk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249711; c=relaxed/simple;
	bh=RptgykM+dnTD9ucUhu9Mj2qVZaAcIH4CtnEC10l6hIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccmIUw3GQXKu3Z6wXEv6jq1jyFdbYyhb3IMK3qiPKtK93tR3ar2dDGSay0e2vRVJJNQNInOuM22rc4Bpn9BEgOl1UlUDyPuaPS93911J5PYnkt0a56e60hKqsCcfLpJT8vzU2Tocvlil3356ABZh2QN03a3jQtMd6bl7q5AfBec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=I9yJXCNm; arc=fail smtp.client-ip=40.107.74.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="I9yJXCNm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pzh1i+9NUA4yarKeDflhOkPxQIH/u0mThhqjc41gWEeao+Yn7+oNDwranvfgy6Xv038iPBFJPFyf+Fgt7WlZkG0B/t+j9CC0mOzK6/rBcOtydImzhZ7RJdg02sEVGbXYaFzm12pT4XPfUYK7vtosZ7sNJZi1XgNOtisJmdjbwvqGzKjpPN2VErus/DLokUwkxlhCSTyjzEN2MVe4rMdr6k1ah6Ae0CysX7Vcdm9Kh2hxmdXDMmtYZITVaVeEoXRe4Q08lxnZc4D5gRxDngQDk9xoCV78ntaz5KPA8hE2O6PPUfO6cKgNY2oc4D1k75XGp3oSBwttCAU5QW6+FI85GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuYuadGAAHS69l1TXWSvu5oW2O1WYBDkbZnCXp4PvQM=;
 b=LP5cwNZmGptXV5qR2CWdModbKGKzOQjtVP5jaL7Qzl7P58sZxhQveP8cwHWH9larhMMvbv/jKYZqAMJ9Qi7rJLve9fsfVL0fR0aIq+va52n2soMRYjGFyizJr0VmIJ+vG/z5OU5SEJwxcYmpuVtTYS2lTPRH0/R1OmyCyqXmD2Hy8A+pjwpjxO6hPMjUIdeMlcDOL5s14Gz1P0T5Mfyn9SxVuXfNHjLYo/JOw1FAVNpAZtzsjuewEYjSkvxgTA4QHhDNxGPzgEXO4358q2ldLimjS/BgBLxax5S0pgqhj2MbkuBD3MneOp5EbK+cFRHaG6P51xsY4pq9yS0SdhOylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuYuadGAAHS69l1TXWSvu5oW2O1WYBDkbZnCXp4PvQM=;
 b=I9yJXCNmVCgB0kNzmO0gsFbBdnKnh7U+Vtec2P141MZF5uXEmchHFFsG1z2huogjOAGaLzy2wgh3diWwAU3I18hB6mfCmu9OkSD0mYJAMj8+zPvNDaWPK9duyoiaUunliR5flADNCNsQrUo+TRqeAhxWg1MYGdScJhD2rsBRdEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB5338.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:384::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 13:48:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 13:48:25 +0000
Date: Mon, 16 Feb 2026 22:48:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Frank.Li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 0/4] PCI: endpoint: Doorbell-related fixes
Message-ID: <olx4pf7w7mxyo7i2fevietjthurogk6gfsvp7za75iz7ms3qsg@ytogyml4bipu>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <aZMEu0_kAsRKOncz@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZMEu0_kAsRKOncz@ryzen>
X-ClientProxiedBy: TY4PR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:372::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: e65d3379-be36-4740-cc9b-08de6d620ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VQmuN+iHlJI8n3skt2FOvhph1LAy++UMr5ACUwN4TPXepXySElCKwyFJY8EK?=
 =?us-ascii?Q?YxUmV+Gg8BG1LwWrysmbUVNrZ5pNF54xuRxh8kGsbS90E6wFDfYLDPEqvk+J?=
 =?us-ascii?Q?o9qaCMNgHHUQGDW6niGUVJZFVgcyuqoTQXihEnVMTXh/zw3i02ZkXlNuHDhn?=
 =?us-ascii?Q?/SZnwoHjECokPojOtBFfBFTVp0GwkU/I1m4Yl34+/MLSU4f6DprKi+aisL4u?=
 =?us-ascii?Q?DM+LUaXGDlaYaxwf2omBudifiXfWe/jUOhU5s55LFZ6y5LnQCWADnOygNA0v?=
 =?us-ascii?Q?8xcjdMEXr1ThI0iI/F6vmS+jMK/slLpPzv4bfWzXo3HZLHmY2l3ON/khwwyT?=
 =?us-ascii?Q?kHHGKgl2MbcGmBWzzBXIM0n06veU3EfHsUGi2WGNX/akYD5J/8fz9UYVH018?=
 =?us-ascii?Q?yQNRDzDtD6h2wKpODfl4XidY3CH5TiiG8EMiMML/RBScPDxBkcj3UtfLaJ79?=
 =?us-ascii?Q?CQx0uFPQPF1i9qFPouhiV3Olaa2WbonwIs5kaNCg6Sehz4vptCHJmOZgFkyG?=
 =?us-ascii?Q?uzuPMM4pSF9n3trnD3KBCi/Onr8n1Nm3/xrdGH/9rZ6UP1JdJ/yCufySgHgy?=
 =?us-ascii?Q?u9OmMJD7yvRaXItcNswjJzsI1yfLuuB2grhZyxZhdEkSRqMexY8koyp2AQbt?=
 =?us-ascii?Q?n8o2PIWkx+bYvTHJGRs+r1kKHozx327LbzklfrlVBQXYyn4H0k1QLQtxJ9aS?=
 =?us-ascii?Q?d/U2Dah46dZGvjp0/tjItoHJKhTy/wgcVHxmyubQ9yLts+YSV/8C4i2KKhIy?=
 =?us-ascii?Q?NhkLmvllUNuy9uQeT/EoaiY18YNsyODebszYiVQ/zYu3u7O5LQX92QfDHT4h?=
 =?us-ascii?Q?mhaWipsJMsqWu857wB2W/WVo7xmAdK5JAijCp1TpsAKBwHV6ICkMwxCF1ktV?=
 =?us-ascii?Q?HpjS4FaXEwp2/3cm4FVcMr4o/XFzoF+WBP7vwFsYiat5tCDGywRJSBDVBEk8?=
 =?us-ascii?Q?fQnsWO68W7nku8LRLlBKAsajt8Peh+k1UPzb/Cb17O3nyqzEtGxznvOF7zYh?=
 =?us-ascii?Q?ldCyYeX6EdabR6jgnvMtJXm5qNDsRHayMAP8eZyCPSxE+f72wtkvUeJjqnXN?=
 =?us-ascii?Q?sIHy3C79h/VXFaCC5bFHQdHJVdP33y8/39FHVPzhjlx4c2yTm4MzG2fTY8tE?=
 =?us-ascii?Q?uAogYtAokPGXOkkzh7oxz0gmvSix9sejcnTUoBCXOs/ZuSYpliYibzjNAY1X?=
 =?us-ascii?Q?qQ5hMtttN3aun/BZRbXQL8K8FpLlkRO4vHZwJSFVNJOnZDA413VqfpxOHfni?=
 =?us-ascii?Q?2FPfaR1Rl50j6hvtQI+zeyhrc+9Qpuf0tHPzP9FL3DbGnAp5Tse/8pOmOCmp?=
 =?us-ascii?Q?h4UIa/FgpTtOzwdOAxMfXTAPJCX2rJxsOwksNvORXbzGfw4Y5ra/89vqMe4a?=
 =?us-ascii?Q?Y9Guq12lR/n0RTRN1uu5QI8isbplAfsvAw+F6HVPayZ3ae2BwH5QAeDS8Zis?=
 =?us-ascii?Q?KuFQac5uaECI5Cmzj8rxNSEsKE0mb4MSAp+uOA3ABmfq1qATB2INxX1QarM4?=
 =?us-ascii?Q?wWO3a1JHVpoaBXuX2COV6vrQsZcpWiCHCiHu9i7aFxzlp0kWR4hqB4WN/FMY?=
 =?us-ascii?Q?hqzxkQKhrFlVuQPFM2xTt8tGw3n5cRghdgaMVgAX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1tsmB1hY5g2q2IsW0d49Z5g5tWGFM7mpG/Jn2cghzzcC1XHbK5GdO21p5KTj?=
 =?us-ascii?Q?zCvd+/PkbF/fn88kPd9UTebz+quqAs0OMfADir98HT+8PBDqNmg1umadQWx0?=
 =?us-ascii?Q?rya6SnEXU7LCSP5mVnAbeSGDNzNZeCGQuhy8FGtar1QJz3tY1uN+oeb86nOU?=
 =?us-ascii?Q?i3uJd4MB1qC62b2lqTPF2XAyntCii8YbM9zPlQyxcZZNay4wYQ4yFYSkrQ0N?=
 =?us-ascii?Q?riHOX2vmBRYFRhfUl9lOmGwaznkDdHsCVkTCrjiYW34Idny+Hq3fW4Tx9jo0?=
 =?us-ascii?Q?5mdUFm2YrSXgm3mOD2KCWu8xSLlT26tD6Ril4ikc+z0fWebwC5Johq9/48Id?=
 =?us-ascii?Q?yVgAxjSEF4abhy4AJxksjI9kqVhmRbDByTGF0luAbAQlABmvJdZHI19lbt5j?=
 =?us-ascii?Q?fDLg8tEObeDJGMYjBY8fOFdBSYYFtUd2efXi1KOlLpiVJCJrP/vDHZF95Fj1?=
 =?us-ascii?Q?R+MI/fH7+bpDXdj3AcKP07Rlkq3MifZoSCwqtYCkhsUmn6jK0xatOIHXIvvd?=
 =?us-ascii?Q?vJtlQUaiuQnl+NgHJwuVjnIr+6QJSR0hMstKvi8XGPMcHgmmUwUs0idDG9K6?=
 =?us-ascii?Q?NigMHEVDtHUx7rNfsJJkqLr7WgGA5ZhQ4XPItXQh72yn2+amzSrVWIcMyCHj?=
 =?us-ascii?Q?bqx1NWi1dbXVKvqCi0gg4K3PVy8lgaIIOzzPe8Mf5scWb8gc1c5IZ4iq2Hnk?=
 =?us-ascii?Q?D6EGi/dSM+RsLlNHpdwVC2VRjEEFPKf13pPUDzCAVM0fJ0rLSOtJ6WZXxKKj?=
 =?us-ascii?Q?hoJ2cRLzNH2XKPZNKG9Buv4IsXbq5YZy7j5LVh2YZpnyzfkqRniXGDVKbDRo?=
 =?us-ascii?Q?33VzZtaFFksBguyXUGrSX1jgZOhppXzB5WlV8tStH9peMNDCwN7Jh6RTOurJ?=
 =?us-ascii?Q?AlKUy8PJUBJI6vEShVf85sJJyHhRSCMSXA+WCu/LTB5GPtIueYxHm6iXWFgc?=
 =?us-ascii?Q?eEXS4DC+iwk5+Zku9zam1PbfMFmgxxbeGCCdRt6DdMzLsEswBgRv+mW9jzjt?=
 =?us-ascii?Q?GgvAAfXBe8Bq/8ttlT9TB/R1KgId2CNRLv7FSIW7UczpnIAopUowqSjCcTEc?=
 =?us-ascii?Q?zKF2+xggiUQzhDlBRMw2txtuSoRgtTP4cNdXzKCmgcVYIEHAX1GlPhi4Iruf?=
 =?us-ascii?Q?MKCwGVxkH6mMWoxNGQCcJ0+S0pDbLuy7JXAwv8SXSYL3w10OTjzVEhVUmPbW?=
 =?us-ascii?Q?ay341/QANjViuamrXUyQ/IH1pRc0NaeZhwgvIFAuFZglfS/QEPYsKWDMj2Um?=
 =?us-ascii?Q?o8Hcxj+LznhUOplDGqxx59jCrKUGMnjRRW0QnLfO+SiqwaALeCmSksHKIVgG?=
 =?us-ascii?Q?aGuqzqtiD2M02HJDTgRXC31uacWAdj7bg7vsBCs1XDLhHWV0bB8J0GeGS8c7?=
 =?us-ascii?Q?0b76JfIcxaQosNaNAFpn+4JH14zISkwOwtkPMpb5Cveo+GxrdeNfs1t3TiBq?=
 =?us-ascii?Q?8uVPpEUqOxVuUgPXJPYq9QudfyXyT8O9JWkiUGzEHhq2ljRHU2AvPmm5JTBL?=
 =?us-ascii?Q?5lFVr70A+Wnw+H5KWSXnLseunanrJSp1sAovpFuX/v/661Yche7hIG/mmzw5?=
 =?us-ascii?Q?rjqb6UyHXnjndOLgUO9oIcadazN86pdmLvSojWSwnvM9nTvEvPvPdabloEA3?=
 =?us-ascii?Q?xScjTEulODSn3XyR7CndB0jvDL0YtoGFNHBs4QZSDHQdAVgH0DC8VoGd1ras?=
 =?us-ascii?Q?xeFIPZmS12zLYuV78VwRLveILhXnKo+V7x64q7bUdH1sCiHKACn0G8ZETZ7n?=
 =?us-ascii?Q?5dlswnDVTUdkoPHuP2b+787Zkbf6oCoSTbDrVCPvnirU+VoKVDGD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e65d3379-be36-4740-cc9b-08de6d620ed3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 13:48:25.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cc/gFMrXpheXoqdOgx8j/nG/EigH9Zev5GYyrAlfZfe0ecBjQmoKaEot0Z5as0jTNV2NkwPbP30xY92CD9xV7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB5338

On Mon, Feb 16, 2026 at 12:51:23PM +0100, Niklas Cassel wrote:
> On Mon, Feb 16, 2026 at 12:09:10AM +0900, Koichiro Den wrote:
> > Hi,
> > 
> > This is a small fix-only series related to the previous (v6)
> > doorbell-related series:
> > https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/
> > 
> > These patches address a few independent fixes in pci-epf-vntb,
> > pci-epf-test and pci-ep-msi:
> > 
> >   1/4 fixes IRQ unwind in MSI doorbell setup (pci-epf-vntb)
> >   2/4 adds a bounds check for doorbell BAR offset (pci-epf-test)
> >   3/4 avoids free_irq() if doorbell IRQ was not successfully requested
> >       (pci-epf-test)
> >   4/4 fixes error unwind and prevent double allocation in
> >       pci_epf_alloc_doorbell() (pci-ep-msi)
> > 
> > These fixes were originally intended to be included in the next revision
> > of the main series. However, doing so would have grown the v7 series to
> > around 15 patches, so I am posting them separately to keep the feature
> > series manageable.
> 
> I think it is a good idea to split out the doorbell fixes to its own series.
> 
> However, when splitting things out, it is getting a bit hard to track the
> most "up to date" thing to look at.
> 
> At least for me, it would be nice if you could create a patchwork account
> and then go in to:
> https://patchwork.kernel.org/project/linux-pci/list/?submitter=216987
> 
> And mark your older series (that now has a newer version) as "Superseded".
> 
> You've been doing a lot of nice work lately, but it seems like the PCI
> maintainers patchwork queue/backlog is quite large right now (7 long pages
> in patchwork).
> 
> 
> I think the chances are higher that your work will get picked up if you mark
> your old series as "Superseeded", because it keeps the PCI maintainers queue/
> backlog smaller. (So less chance that something will be overlooked/missed.)
> 
> (I do this myself too, because it seems to make things more likely to get
> picked up.)

Thanks a lot for the tip. I've just gone through my patches in Patchwork and
marked the older series as Superseded. It looks like someone had already cleaned
up most of them. Thank you to whoever did that.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
