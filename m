Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D03483BC6;
	Wed,  5 Aug 2026 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948973; cv=fail; b=JYn1BH+18e2WnWd/RHo9XbJM4eI4/+ouYvMeD8QxDtQMlVdzHWQMEAh0/yVjfBmn41QyC6CQVFwQzqXQlKRVNC9DmxapMWzW5uGiEmO0qelC9Ps3jwj9dgTyx9Os8FC5PTqC7RRiZYKHUDrVaV8EFFghee+TtjNWxufT7wAjKKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948973; c=relaxed/simple;
	bh=hHvU/H2a0KUkMm5BjjLj12FdQqP+/f/6KWOYWpyb/nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bCuMY+qO7TZmKtHD8NBVYYkZSNfOtRyn9MkXR6ezUdmi06IWwhg6uElN+wsauFj610JhU99ICS+mE/EIiZdqQaEI/+OoC355px6U3ddzPhaHXg86l4INd1n4S2wQfgpJojFxvCnIviUCAQPjEeJs0suLUrvfZ8UqwMzxk6Aal+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ASUqp0V6; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ASUqp0V6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WltEn9fq67m6T+OvbvXBghjBdU7vpZIlnGxfWzAm5bsTD6SU4yH6wb2xPqgPYvr207IovvxQm2NZZkLdvirQLa9ORMKRwmbdP0r9CDsHYOttjwrXL208jzicf7gGlOhO11JBt6fjovluXM7Z3gQbW9YgzSHo86ixdJPeUhggTHysicdPrMUk1rQc7fYe8MsEdGtUXQfzMmunjbumSV8+zbe41Myh0O5pR9REpzw2S3CufaSbgA+KLaI8lnjVpQYZ2ZOstFBkYl+tUKnoIisA/MM3pQKluC6hJpl2h5bc+2flgaWlI+SvuA9WuPXdW4LCYYqM6G8+pyKuMD0YeFR7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztyiqUBvS+FTGXV4id9KT0MrLmYK8eO5xmG+/lBRCLg=;
 b=I/XkXbsd3v5DTubouF2M3MrRtH933Ou0YjY1nWZNHCJ4DkLwyZwh24zdQZZxtHszaS0j/P9ac5noSRugJbFxopC7lrCxejIBhbVVIfyWLox2G+ApUQifvK4Gn2ug7X5ehuqioAivLWiREfGWdYQIqjOx/cIPoa07kP3pjhBP+w5SqB92m8hc6zoOrZ+uxRK8fPlu5GCtYlHZ2jtpoH6VKIWW2FSiceEEKB4vHfXaYX77kTUIYbn57o9B98ZdN9s+2GiBiE89st83j35ppBwH6VGuwdu/aGdaCsrR4dcUHpBrS3R0b+eLj/tOJ/I0vFs7sPi2hkiUm04lJPnz6NYpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztyiqUBvS+FTGXV4id9KT0MrLmYK8eO5xmG+/lBRCLg=;
 b=ASUqp0V60I+juQM+WWYWnDcaql3gcoB0NnhMxpuqerxnfq7HHMXWDBbimFjduZm5VEeuZQtf0sY/bGI6Du/N8krPbI2PcjqL0pJTw2vxzt7a38ECBBRtiqcbiIyK/Y8ekn7rdq9AY5InyGgKDK19g9Jquy7aSgmKOVpc6whb2UrUMhMTP254guimdCl2VJs3uDR7e2bYlzt9xyMqhcNEHgGsNiKB5t046whHEDC5NT3fgJtJ5JG9bRpQPwoy8ZcH3F/8kk5WObQV+HckIwN0QjnCidColeD3gTPnV9eC99CJCvnoPvKSwHhAKv5NuNO/ABnVKFvoiqWhYdNEgQyGGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:55:57 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:55:57 +0000
Date: Wed, 5 Aug 2026 13:55:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	sumit.semwal@linaro.org, christian.koenig@amd.com,
	pbonzini@redhat.com, seanjc@google.com, alex.williamson@redhat.com,
	dan.j.williams@intel.com, aik@amd.com, linux-coco@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, vivek.kasireddy@intel.com,
	yilun.xu@intel.com, linux-kernel@vger.kernel.org, lukas@wunner.de,
	yan.y.zhao@intel.com, daniel.vetter@ffwll.ch, leon@kernel.org,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	tao1.su@intel.com, linux-pci@vger.kernel.org, zhiw@nvidia.com,
	simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	kevin.tian@intel.com
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info
 for importers
Message-ID: <20260805165555.GS27883@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com>
 <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <20260712221934.GF674038@nvidia.com>
 <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
 <amcdueQI1voXWPQb@yilunxu-OptiPlex-7050>
 <CAEvNRgGYc0B1YyhDhS0Khfm3N85hbkYGMTfDLiXYn+WHTLF2EQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgGYc0B1YyhDhS0Khfm3N85hbkYGMTfDLiXYn+WHTLF2EQ@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::9) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fef8939-f1d4-4a09-078b-08def3126b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fgMPtVqs8ci0WUh+0ACY0JU70K8duBwns0mbRKSQNaGvOFU6mFfHnMvkaNdIHasUdYAYuxrNzAUvaXC+/vicB8pB93Ne5ox9Em0xONN1N14vit6rD0B9JIIpMm4vvdxB0ngXhVDG4R8clRkXTuOPkawMjanYRxYcVGRUwXb1zcFLIpiMoCOVPf3xUwhK32qD4vtH80jqYqSpoqtyca4Ec0HJsmGl630tc9jcNunr9ICmZd/b1EwXJpUxZVGgAPGlKF5zwtkOLtpOeIeeuETXivGWbarLInVKE3HPsT++K7+x0uYhF7B2zh0iGtf8LfDVW+6zEJSwkR2N0Ksyl+ERU942vMwKCBVBRkb0sSgc+yUTJksIOokwk1Yfzar5NPUCNWrCBScz1nkFEvOZqQyvf1mL9JouUAx8DLHmR4j9zWJyDvDmnRg5KY4sGRuxdY5cuEJDje/wm/DfBZ85AJArZfXbw1PYYm8teo1pw/vxegjfQMQSoHjpiYlPL49j/EcaYuFyiDaOb+6pqtFreVKH8Y3eTEIwZU+CWs+6EvpWKajtXImK1MRJZcWgd1leVqAV0eJqBwzeO9l5AE8bczRGDkMQHDMd6yn4JOf3Vc02V+L9PTmBAEhBX9R4ApaDBqdh/Z450jXXgZTn0i5Tc3DyGkRz+xxTnBsnoMmcg0LOmB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3tWiKhrTuqJFgpVA6pTqisXfOvIRGXRj7JXgXsqSvMpxh9FCGYEmzqihjkE?=
 =?us-ascii?Q?asURO2vUwMekchFzxSQ2mEzXoBO8BrVBKbyr3rDvldkCZ3RqbunVliwA+XQl?=
 =?us-ascii?Q?P20uha1py1VbBn2NBW2rTsDsfDdS5qQGdrVXGrrO3uobboI8Hhb4b+NasOBx?=
 =?us-ascii?Q?wLdp3tIGEiWEUqCrMn8qRPgRM5L2Gk2Kl+iWhWjF6XdnPntyJc6aMhCHGVFc?=
 =?us-ascii?Q?IWxYV6KGWJRYF1NBNWsJ5fxqUESWU/Lo4vTabA0K7Y3PMCyLfp3CVWc5v8gc?=
 =?us-ascii?Q?8w55rECvseD1FJJvAMbjgDAKsmTlVLQNj7x1OE2JiqXhbfViHWop7F6wPUPQ?=
 =?us-ascii?Q?J/yuI0hzyAUR2fOxND9+6Yz1OSnfTOKpdUhCncURbW3RFj6n+7khquGhNeLX?=
 =?us-ascii?Q?cfStSEkzmfNk6DOl5GVI1KBdVtCvoULmvnnbuk4JTD0HeeiR2T4ajx7UQBKe?=
 =?us-ascii?Q?505q1Bqacsery2zeWOsTVgT6HBCj3d3ueW7tsCQkB7LaJ/sws3KeMKLxbubg?=
 =?us-ascii?Q?slRd/G3XL13zfavV7dPVB2aMNyALoqKf6gUPRhJxQr07d9vy3pDh9yqM++Uz?=
 =?us-ascii?Q?RhDeL5BlFXM5jLBJKKltPppCMg1YuZbIejPhsWlhvmLXvVX2onYs1BjukK+J?=
 =?us-ascii?Q?b+J0nDH52sFGQrVe6XJaVweFogFVDDN21lRD3x36lZtmnWa9+T/Jf0yuJ1Zh?=
 =?us-ascii?Q?JP5/lYovwu1S4Hyo+kSnfWZHFyoAGIwxYsBIhUD7erohfuyRyAOCK7Zq9MRL?=
 =?us-ascii?Q?qtbbfikyW3ne+o8xnSc5FrojTYa7hatZtGc4zQZnHbFkijHZDBNF87Txvsbq?=
 =?us-ascii?Q?wsDINH8qagqMSEX1dxuaIyCyusd8z5jAj4+nin8Ntvd0gcJIPl1Jshx8qEIz?=
 =?us-ascii?Q?hrAptV8ZFzxjVxW7nYXYELyCGrLeOBabzpjYzFoCRBw24tAjlrHxH9tHVCOC?=
 =?us-ascii?Q?RuO4n9ErLUdf3BP/8inl32XmnVlXsxfzn7NonPWljDk+BPPePOv7JEiBvsEy?=
 =?us-ascii?Q?oeQ0v17WuwCQ/WRI9NGeKflXCT3/jU0fpxvB8RJGSENWcUmWK8n4K1+m3zAh?=
 =?us-ascii?Q?xDWZ0Iaycto8mLOFkNVYihCXYmp1gWCZqIqzP2qucnHQP8IhyXB/cPpTMO2S?=
 =?us-ascii?Q?Ggn9iVOhcci8Av+2HaGfjBU7kyOwJBpPKtzYsoSpzUiWSiQwWH5DneP9TXGg?=
 =?us-ascii?Q?ya+jTW10B47FmwYRfsv7EF4Ks73nMxX1Wqd6xQ1hWnwcDxD/V62hpjZeegR/?=
 =?us-ascii?Q?CbU2lHjCgR5ybHSyzBk/7LCQyGMQMwgCCgUOGFkJMZWD9/ihUd/cd9sCcuuJ?=
 =?us-ascii?Q?YpDPTOCBu+HtgGnsCqTMcPEiVizujl1XkvxbUV9YrHX2tv5Ls4msQyRHl/St?=
 =?us-ascii?Q?4MMRyUryb5yixhfCCIJPosMD8egBNUY6PlaTJpScI2AfaHGMEXMIMibHqO+m?=
 =?us-ascii?Q?vrkhjiTTJkGr0EEqqq6gI8WlmDxovgachy0j+IZct2//S+BUCpQPNQvuIxqN?=
 =?us-ascii?Q?h9LRyq55SQ7X8tYo8ODmDh7yXs2atGCS0hvseEWG1QHQAD8cqip1P79veoBW?=
 =?us-ascii?Q?AqB4E6Q/a94N0hAbWwuIVqkgHwsK7svAx8wXihMdxpqffg7gRFvBUApd8dKf?=
 =?us-ascii?Q?iLv6s5va/C32PXKmu9cJCJRLuBfLnoiInPTD6SwVkBrQS1o03jgLviZZswOj?=
 =?us-ascii?Q?px275rTAV1XDsqEbOWST8ZrG9J08+xqlffgoXlO+3ZGHkws4BmJwL9hZBxnm?=
 =?us-ascii?Q?8+OZSiopmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fef8939-f1d4-4a09-078b-08def3126b3f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:55:56.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRC9gFRqujEIHdNQO3FTdZmFtWt39eJggTZD47h1amzYr6BXbjPrzz2xtJvt516J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

On Mon, Jul 27, 2026 at 11:53:55AM -0700, Ackerley Tng wrote:
> Hope you also had a chance to look at [1] that David Woodhouse is
> working on :)
> 
> [1] https://lore.kernel.org/all/1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org/

Heh, that's awfully DMABUF like :)

So, if that happens then sure we can probably create a VFIO exporter
for it as well along side the DMABUF exporter Matt is working on and
that should handle the shared/private steps intel needs

Jason
