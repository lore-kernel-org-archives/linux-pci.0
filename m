Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247B3191BB
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406229; cv=fail; b=JPNBDaECDWJiaok4P3P0YK8BG1ymL//5WnaMFUyYzHAIpxspfC4ZTHJoKm9L0hBGHjtR1mjDiilpEd1HjOo5SEJwjQDf6r4L8utIoqZOz1pknBFiTLsvECnivn4Ye/VpijzPvlRaITyNMuGcEKORbN9JDVY0KRefAF2bG2ZnF0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406229; c=relaxed/simple;
	bh=vckmA/ayCUYtlHPXASUrLgfhjI4Ypp6JzLQKWIs7l+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dsd9ov0h33dqTjkcH2YvGsBRk9JZhbupPS4h9EhhsIsnpBk+yYPfFu1vWiM0OLD655GmgZDDEr4YWRZVYi/xnc3SK+C/1Upv0pWGctjeTbo6/LK4C22dHL6jfIR9vz9K1koaqz2cotiXXeA7vtaIpI7H+OT2Wx07kAxvU7OaJGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lXUtO4x6; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lXUtO4x6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot3i4UqKqlOtOXwGns4upE2Niwa4ug6t8xLjGF8LIhmHsx+Gc4k+9NlPM6n6i1axsggsRmKNTZKJBhFmTKllK0B091YoW4AbQNWnRZMq9ezH+dzmCpT4Nai7uvrhLNritSMEuFhzHG+Czc2PTmXcrrU0bdi+e660kjZzI/etUmC9ikhV460PgZwkWLfy7VVNB1afu9TYUl56cGlZC3qBuNq83EroBuf+st0EonmIydjJbpb/I5lGvpoZVsk7jy1z5nNTnIIulZ2BFyVugpbOEJUMcRNyi7l+Oet9EAWInw62LKDdU9mlDryZIgyjZdgO3910r+pJY+ek7mPtuhC8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgLJIh2AcEdHlcdLwt/Eg+ur5hya9bBWvcOpEB0fpaI=;
 b=xncvPm1HvfPCz8bPNO5lAYK3PBRFWY3ZTQVJTffzhSXMOk9jql2PyQa5DXFCdvTfiNDb13xnC2pZSHdkw7j5UzyYHSVFq7FqA+TxuWinAUOSL0milRIDyOVxniWzHBBKZruB3oKkGoIdO3QHC40+5CH0sFRJCjf6XpmJ4hNfe6I/D7yfYzg7mzM44qvTrWBpajPpNqdJdPRrh6L64a54IE25x8jRgfCWIrbiUU1jycxOePOWMF3P24ey3p5zep3tXiWN6mdxTdQfTZVehS5sCYqpXJnUEa47S6ONzu70ORJ9a5LKIYp7rfujyw2wVUgVydvTFGXTr9m9d9nwWjPB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgLJIh2AcEdHlcdLwt/Eg+ur5hya9bBWvcOpEB0fpaI=;
 b=lXUtO4x6jXHHJG8Sct3ZA2LZ/3k1L4vH0uyMdkdcCxILvfCUE/doo2V6D6TwK+rigM8gDk7gBecRzWpl2ug0JiJRDABiEf5+mpkNcd96SAJK0sqWL9CdIvFRU0ZFrhwKkU2YxZ/83quP04wSeOahNFlFvWahWqAd24sEY1RDCnsLalCZZSG8H2lgsK+MnMNd6nQ/OC2TecS+IWei4rZL45O+sq3IraIpI8KafjvhcNdskOrHiPjpxLXZ/XDE3p+OfpdNuWELc+LJTYlHzhRttlxKqL/fDDtrID1Etc1cMS0JwwCjRZfxa5crYsbxjC43ssmowQ19ZsLXFfXnsf7PPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6899.eurprd04.prod.outlook.com (2603:10a6:208:183::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 06:10:25 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 06:10:24 +0000
Date: Fri, 17 Apr 2026 02:10:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI/MSI: Add Devres managed IRQ vectors allocation
Message-ID: <aeHOyYJR2GRRP4fY@lizhi-Precision-Tower-5810>
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
 <1776392767-83668-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1776392767-83668-2-git-send-email-shawn.lin@rock-chips.com>
X-ClientProxiedBy: SA0PR11CA0118.namprd11.prod.outlook.com
 (2603:10b6:806:d1::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: d8636191-1cf9-4f8e-9667-08de9c48037b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|19092799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	sKlq2399IJg6WmoDq+N7DgPEpAexQIkQ4PLulG+i/3MGDZYnMFQ/nKAnC1zxq1lpeRld7YYYo0Dhz+vPfV0N1AKnLU7YOq2TYjCzR8EAZLTrLNVBjucpIsdAF/AUgE8f8EaySTB09D/ZyZD54T1FYJmuxYQIWl/8bOWTP4MKY20RjjFktLAUlgAW9UnnUMXUe4KuFUlBodwrcsYBAgVkXrKshabaXrPHPz+3XG1AJRE8c/1gH1bfq0HogwSL0ThaNXumyGSzVhHR8qIh1HQ0WgeUaxAIxW+7rQsIIKjAONLHk90XRcewPauwboAB5uVWEePD5TOs7v+CTWmnDoAOIfCJu5jlgXbBiL43MXzpy2ggtFqw/IpdVe59E+px1NQnokFQXcdMEd3cjZCtFY1XpWbKAkp1ZzrXWNQYjZrf+KVLg8tSg1TDOz2k0Rzp7duXozQ89bjAyibksRdlB+r2fzUPiY567MeLDobvtbmrMpyHIAEJer3j56124ta9czKUG+iLaCyFChEblgnl3zxs9mq7TKBBGv8QX61uzGrfaAJ14C8ZkDE5PF6cAZaC/LfjLvizTycSm8At8ZLEa12iUBORb52RF65BEPeJfb8h/cg05Ol53WyeeJwJCY5h8gB9/Qk/3MP1w6huSVPkAOJEkwRks9bt5NDWNw/sC+7iRO5uLSWhURPwRls+iHG3rg9wmsiZD1xiZYHzUXjnrYo25V1jZov7+ygXgtXBrSmZ8iMgxOQ3yDO1FmItUwF6ZB1TlOI5DLyfM9mOFpUuol4my99SvcVeAAOcIWhH9cV9a18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EyUiaqr+/+0tQReEldf4ESUqOK03bvP5M5b/X7bJ+cRjsj0zSTu78cnV+Nna?=
 =?us-ascii?Q?cAIkAN1Qt9T5+VzP0QM9lj2VBWoJ2w2m0chtx5CWEulxa4nU8yKftd5CjaTq?=
 =?us-ascii?Q?JVfDFoioklOL6WuseH+pMCkjAhb8n+MdsAl5ZWKluW/uGqlxIXQChCWpin80?=
 =?us-ascii?Q?j+IzuGI5Rsfi5BeSMKrPzUmzzk8OZ/JjUorT4pKs3TtzjFTY5UWpwHNm0dlV?=
 =?us-ascii?Q?S3U1R2k+2e4s8/7nDet3TIQS58aZ3jTJXL96v3KDeOoyvLu5+VF4CqQxmMQ4?=
 =?us-ascii?Q?ntuFCfhiwcsrhrM6rNuTZgRlPmqIN6cAGtxxZSlHyELmUn+YBw3oWZJUTFQk?=
 =?us-ascii?Q?2LaSQdv2sArNMCWrng4BY3iAXfMj0KrC8UCDCGlOC/x9ah7pWPX8TBURx30/?=
 =?us-ascii?Q?48Q3tdyqZo27K1cLPzCYdIY1cg9MHv4cd2gTNOwgJLGTBmAKo5LkCs+nZVH1?=
 =?us-ascii?Q?yhc7ZDm/5oSugnZ78w+rSeXbe7UoKUZc2eOhAAVspqJWcmmSVIDleQnAcLnG?=
 =?us-ascii?Q?BJGiVm1QUVwJw1k/vyPSFKgq3knG6YFU2uAU/zC6RS/e2nwAcmQz9gwUsQFu?=
 =?us-ascii?Q?IUbTC8Eu01kIT430aknsG4ATsbyxB5LDuIN3DaePvjrFHoQ+WCWE5dIhQHRo?=
 =?us-ascii?Q?CNFjoUmDO/BzYo8938AzzU1f9gztMk7d5C+kUcWEL9odHSabxBlePZywgeZd?=
 =?us-ascii?Q?I/jXluza2HsqO3ILZ9QiNPPTa904dBuwnZilIrt6AVauAs9Y1gfys+zqyp9S?=
 =?us-ascii?Q?uxr9cGu/R31+MNbWfdT/84B7zP4Gfdu8NHJEtRh/OkaLFHI5XQhqx4L7d3XQ?=
 =?us-ascii?Q?spTJDfthyvvHibT0u3BVj/GrUz1AFzJP74XE4uiX5Kyo2WeVl3n7Nx6P6Sgp?=
 =?us-ascii?Q?L9MefqnJ2dlFZQ3dpAbXpnggZEfzD8s2AGdvBWwj79Tpehcw/zuTlN75okys?=
 =?us-ascii?Q?ZXgyEBVl7Dio5+MZhz6LxiJrfjiLmhOxd4Td5e724fdMLY+m0dmRFCF8C/+P?=
 =?us-ascii?Q?UHkuNy4LE3H5jde6mtLeBgBaPBunysbl5YluX0aAWmd5J4kk55gjUyAPkx9n?=
 =?us-ascii?Q?zZb72aoGrbmjmrQGbLFME9D+ZhFgof2mIEe88oBIAKa+HxG2idDrQZmOEYOD?=
 =?us-ascii?Q?ZagS2E2jR0jITn6RRlDWJYGVgiKFfUokKY6fdyl2SB5doWAmistOWhc2rr3L?=
 =?us-ascii?Q?OoiCqVhDVwRmhLH62A8rsCOZUEhm3O/kk5bmCsMADrgLjc7SKzdV0RQNNYOv?=
 =?us-ascii?Q?BBYSg0t7DELSdnyacSnAJlK2lDng2ZaJtG6ef3EemocSVRsWTHjAqZb5y3X0?=
 =?us-ascii?Q?xhJjcHczqB2cOcpWzG09XNUqAPezrRTb7ZveZwU1Mil8X5ExV8/40op1vnoC?=
 =?us-ascii?Q?PXUKv1o2EM0qh7XOgKrKzk9Xjwu4DnHjQS5bxX4mvm4/kUsO1vect2Q8u0Nm?=
 =?us-ascii?Q?2yfveG6TAzrHmjGcc3e26FUMRti8E8P27aEySHtudXtUvP9Gu98QaZCtdYOf?=
 =?us-ascii?Q?s+xoUm9uQMAf2NSG/muLm6yttAcz6HsEO3hzAi0nnk8tTcL5pJuMJPdnegWB?=
 =?us-ascii?Q?+XGVgu8iYAD3AL8pO3SqMoraPW8vRInLiIi8RouW0OmvBaR1O7i2hOMetne7?=
 =?us-ascii?Q?qo0Qogvh6YC6SWwEVStJhFiU7kP3xMtZuUmQct81lITGEJIZfHfsUBeeEA38?=
 =?us-ascii?Q?DZmZ7wH1F1nnn2DjZ37fU/kUWdd5BtKNQ2g6QsqJgy8K0FNT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8636191-1cf9-4f8e-9667-08de9c48037b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 06:10:24.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYnJS4oN0bbGXxExF3W5qacTbDZB7zWmLGLciXbz2qDzEQLHYU8MI+/Ino8Z/paE5hcoPr8BxiqLd340JA2FzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6899

On Fri, Apr 17, 2026 at 10:26:05AM +0800, Shawn Lin wrote:
> pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are created for
> pci device drivers which rely on the devres machinery to help cleanup the IRQ
> vectors.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v2: None
>
>  drivers/pci/msi/api.c | 26 ++++++++++++++++++++++++++
>  include/linux/pci.h   | 22 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
...
> +/**
> + * pcim_alloc_irq_vectors_affinity() - devres managed pci_alloc_irq_vectors_affinity()
> + * Interrupt vectors are automatically freed by the devres machinery
> + */
> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> +				   unsigned int max_vecs, unsigned int flags,
> +				   struct irq_affinity *affd)
> +{
> +	dev->is_msi_managed = true;
> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> +					      flags, affd);

any side effect if pci_alloc_irq_vectors_affinity() return fail and
is_msi_managed keep true.

Frank
>
