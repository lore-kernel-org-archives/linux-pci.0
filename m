Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8A3E6DCA;
	Mon, 31 Aug 2026 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177665; cv=fail; b=NQFWZG4Gqs/ILoRkQYdUZs4e+ghhqZBfG+FAsv8U9KVOWEa4+TjFD1m5DgPghGRPRmNGrCOcHXD9csxv+2lI8LnZNSew456PSUbfLa6rQ1ntm9FMwNTjvoGu4MNxqM0sWmNu5XpXRiEKa1QkmRJlC50bUa4pDDsQyM5+YFUvBTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177665; c=relaxed/simple;
	bh=/qjrLW8xjHhnjSrLu9Iwu/isblZT2pi7b4JRwQSczzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uD8uajNwFCk8j6AK7tgbe9WW4McAjyb5VfVwYW2+MxHn8Ex04T1ATiN6F0xMYNxe0B891fqOAAr5HNRxNd6HFfHmOK6HMdCoQeMjj6d02bchhu/lSjCw5tawIC11GQVfaLZaKSS6TqEI8U1o3JkDf9edmo0eKb2TxIFiehDc60Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NARTzsKN; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NARTzsKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfG1dFD5iRU4O+GFZUs0Rd3tlxZBf+kxq5/Gi4WPXBP2NAHv+wCeyNCu5HgF/AfPFRMbHI6TGxJXWNHNPI/RT3cLFkoE2zvrG+JKxHmAGiZDCJX6gpD18Z/mzLGLgmgw7CgNuCyErT9Vf//Pqcn+roK98d7bQEa1L8kUlad2LBc3FJwHD6EFS3pBL5Es1wJCkVglJMvLb25FTyKcr6LwzruNk+wAS++jV1VZ7Kx5FsM3V6r4EalRv/XDJy8I81X+vhCtCKSBgTkq7Oz1zIuJ6i/wm8GYtyTXsA8I2/UlzgbX8QNnHZeTzAZPP3GIPqMXWnBWKHe296fRQRO6FK7jHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgfKeGfTp4uPr53HHs7lc45jZNlwpNQI2qlg9cgZ8ko=;
 b=FImgsZjmQgD+20PSWWUXKNuP9yJyTzyRLyxuwj//zI+06k01Z/baerhqPHHYF2Y6wruwuMeVEJ14yHj9LzVOASZM4zntKkVs17kBpZQ3cuJO0ZKm8RZyaEz3ziqnAu3+tyTi7XiqN5uWPsqNC0vny7g1dABFqapwoSjRlT+PtM74pyI8f66r6uA6Erc7JVOLNTb4Y0R/vDsf8JXXE2cLDARJWGrjUzO88PCX1WYX7FA5U65p7VJpLuCtIJ/pvx4pn6r7an2zDoG0Y1zwigRRQxsap14kXCU0QEmM9aPD//IARNtfsdNX4dmmQ4qa7y3X0Ah9jw0XKehrZ4smnlG2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgfKeGfTp4uPr53HHs7lc45jZNlwpNQI2qlg9cgZ8ko=;
 b=NARTzsKNziVWr9OqM2QhUpMPMqfoGihecunPETtv3GpEx/yuclaPOnEx/rc3qqn/Xg7K1yL/i9luE1iKpXhISUIQREQzypQSxpDorT1VbR8gBVXzjfi3Om7vLwoTDtb7mVkIMF9tMe+WDvwzSLqaVW/3sch4oGKRQCmuDI62bsT+DWK2Hm0HhvKz3pOwyvqnZer5NWiigJXrwSLihFsVdjs75ueg+bXhqSCommrNlq663WpDbOG/ypE0elhjIy66XgZdp/YYab36zfyin6GmrAn0B6o+pIriM9ka/234e+fKcu1mmQW8XbzvL1cXUXfCdeOP+8Zij6KZ0oP0yJsTOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:00:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:00:57 +0000
Date: Mon, 31 Aug 2026 09:00:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v4 00/18] PCI/P2PDMA: Fix ACS egress control handling
Message-ID: <20260831120056.GE4157646@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <178761377033.3197084.14418777457559555376.b4-review@b4>
 <20260830090223.GC24140@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830090223.GC24140@unreal>
X-ClientProxiedBy: YT4PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: b07178cd-2d90-4665-b04c-08df0757848d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ocNuoLT6ZiDS4TI692Gb2vhkroFtBC17UYQVTqw79YlBxzQDRC9m8j9tqKtaByNZ6NOmcbZDolwso2U1XbS2pjb+BtWVJhCbyHvNTofVQ3MBqYdSvW4NCRwPeCvJkVenEetuXbHYMCHP2NGXYlLmtBqji7jS3iIPVGwp0ybln6WfB/nomJ0F+DQ2Y7tWcF5A9rh1KTj6VCycN1/oMb+7svfYgW6sohQiWJc2gJuZ4jvSOW19rew8K2JiOvOTQXvP20pZ+pb9iuqsYIdVkPL5It8zxtJ3+6zyxMRER0QDmzeqUxIBY4FQDVALh5Ja/boBPirgqcxuxmDZPKL7ugPTURSSvh6PiFEg2MpbvTOtS1bV/pAXczMUgeLXRha+mGoWwaBf622E2a1BeFFYTlt1s76FT+Rpr2ASQaCQbnEfq/Cx7XqIGfDaCArDQYc8Ed9s5m0CaLJvKMvtPSUzQfhhj6lz9vqerr8FsfhLuJhEoGEV4WqRyFEIBnxSdnqEWiOGT6ZZIVoMqbpjoRqfOAewrfZZnlC+8x0/bNDK/MP2WRLXoP/RseyrI1sny2KobaNwUVNexXmm3IBrn3xUGDFY9qiRWX9xp13RRp0zoi88xZjcwrPO7PbK/QOWoyTfpUChTGMupH+MVk6633Fa4dAchs0dTKcgwInqhpBqUAbuM/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HlEit6OZNKYYIuLoNZHw9vz9S4ZHJUKwjErCuUhX3PI7nh7xDwAM9pRKCpIp?=
 =?us-ascii?Q?UraM2TBn6mZA0W8QOgoYjqYaGjeh4hssXOJ22jIwt6fcWCrH/8/XBK+vKki/?=
 =?us-ascii?Q?LjStoAuk31iKyaDgbVdU1j5kk2iKV9JpadYcdkezujHMaBGMGHLGXrEcifsB?=
 =?us-ascii?Q?m1GfTkx0GQuL4UeF+zApCZPLz8HG6sOgCZB2KT1jdmcnOQbT5oiyUreXsdjG?=
 =?us-ascii?Q?5hr3E1mK3S33KaJQDOvLSki8vIOxehSNwSa1yWYbPeJFmJbvgQZBeUo/1g2V?=
 =?us-ascii?Q?tkEVcq/8RGD87B7vnafirrexVUS9kvaipO22UNGM0QTxNBxP3uayqmQn/vU/?=
 =?us-ascii?Q?OMRM7czl1IhY0rTKbKS9n4F2VVksWdeMlHAoweh7llkWqJrtHBpZlYrr3yf+?=
 =?us-ascii?Q?lytGr9VqGr2fOPr4kDH5xrOBTSO1N7kb8jNXw+WMIPRkl5AXP7UyPz+86taM?=
 =?us-ascii?Q?UbeXEaHkQxXaZ6L/GBf8z/PZAzAtyiq0i0eh2qoEzoKo3Gg9GdRZ7tl97wMG?=
 =?us-ascii?Q?U2G6pCQfeQg93X/qW49dbzMnQL3ntknBRXgWWns+bBhRM875Ts+RJUPtdyL5?=
 =?us-ascii?Q?A9zFg7Gy5eaxRn2NhLi+WcgzsV2GeWiuW55/S8rElJ7ocadnWDg4UsPPL23f?=
 =?us-ascii?Q?sYhFZ0XVs425JknXe89qH1o3FmzKtxhLj0ep04S7nqR0ruj3p1DuLQltxOR4?=
 =?us-ascii?Q?wRkl6ABOgd+/L7OEeRw/hALio741+VxqrKZRu34P1x7uCceqCUnY/W3g/P6b?=
 =?us-ascii?Q?RRTrIbaoSslIVJjBkFjlXJRNQdQ2/yr8jg3wLRF0kUY5UItIWbKKynB4SxIk?=
 =?us-ascii?Q?2Fsh0sbwwzH2Jjir7polRsS8UQV+mA/zoXEF2QdeQXp6mNzKzFhMo18PCPui?=
 =?us-ascii?Q?9AJo+MNWBNLI/iH9BTWPxGQo6Id7mVDw/zpJcXE8bsb/Mbr0n2hP/DD2Kvol?=
 =?us-ascii?Q?tRwoWICE341kORn7RtN25TnjghtrinXoT1qMyNNiXi9fiUxsAVx39V49+FHk?=
 =?us-ascii?Q?P41b35dmAtHfwkp0jSdZx3U0zASVEnZrz56hMRJA/DIafbJnC4wv3re3HzZ+?=
 =?us-ascii?Q?Y2R/QL9XwqglMEi2L2gEsQiFr3V3gGnSFlHev/awWrmTFtKS8+xTiP5B5SBo?=
 =?us-ascii?Q?rCacRlkcdfDXZMCYhqfMp3xyp3jYm+pxd9QDEHXikSVin75tltYpzvZSFgEn?=
 =?us-ascii?Q?gpdZXFtQZ/mM1LCtUmJPXiWFfAYt9Ippuc3zHQcUOqR9KHmzdLtw+WJw95ns?=
 =?us-ascii?Q?D9WfqpGO6FHUo0TEHGjHyqxUq6Rpx0C8rx33cbn1dx06r0PsbCaaNVcDdPNk?=
 =?us-ascii?Q?hB9XEKFm6hbLHjoag/hG0azInrqWdgqrUWgC/pK89WhUwt+L/z6tL3Bebty0?=
 =?us-ascii?Q?LcaJ5PDOlMHOxcZj5Tk3znHLzPlD20Jrevtwc868eHzfLQAjhDF1tVDbX7E3?=
 =?us-ascii?Q?rt6YtMfP+xSCgnW4KHYECyBN9LN3z7l04IY/n7z2hhOCpCeebKanRnplGPir?=
 =?us-ascii?Q?dc7N/GTJT5I9kw9BIOq5YQQbmk8whb8tHLx4HmgmRytp9XPOpTR0QYrkHFKA?=
 =?us-ascii?Q?cr7JQj3Kk4PQsYPGNe9acII/ddz7dN5JzvR0Ch4vFhyhZfu3TO5JKXJZ7+on?=
 =?us-ascii?Q?wFmTvvl8GVvdCErYMPqGdBF3mO94YVmt62gBYY3EvMrGm7MO+D7v3QO0v87c?=
 =?us-ascii?Q?9h3p4vxjSAo0qn0fOxYBOWRSFwpnb7+1La1EYsSOQRPVu87J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07178cd-2d90-4665-b04c-08df0757848d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:00:57.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nePDKOxOShp+xA49A/IUJTlo3j4cSDhyFitrJ5bt7Bggcd+Ge2Sg6OpvrrGJzSOL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

On Sun, Aug 30, 2026 at 12:02:23PM +0300, Leon Romanovsky wrote:
> > I don't know how the driver facing API should work, but at least real
> > devices have options to use ATS or not, use RO or not, and can make
> > use of information from the P2P subsytem to make the right choice.
> 
> Do you see a function like mlx5_umem_needs_ats() being implemented as part of
> the PCI P2P logic?
> https://lore.kernel.org/all/4-v1-bd147097458e+ede-umem_dmabuf_jgg@nvidia.com/

Maybe someday, virtualization makes it hard since the information
needed gets wiped away, but lets start by imagining bare metal working
right.

Ideally	if the P2P route requires ATS then the driver should know and
it should setup ATS. Similarly if it doesn't then it shouldn't. The
only way to know is to evaluate the paths through the ACS controls to
figure what works.

Jason
