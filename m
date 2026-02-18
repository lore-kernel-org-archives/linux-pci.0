Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22C289367
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430433; cv=fail; b=oA/zixEQZXDNSaB074zS9FScMCLsX+xlYQkWEDH/M1yRyvqWEEhgDoQm6h2I+w3evEoaFnfvsYXEaPE00Nosfr4qi4VhIRZD7k0QX58Zqk8XCF9NA0CYXkArIWYl6k35pzgKMYgtL5CQtdr3SJRR7HCuU0cuJCBbCIfpXIna8ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430433; c=relaxed/simple;
	bh=ScT7DJy8BWSDUawKSzA7qWqq4j28hTiO8u7Z7XEJIB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1Nd1antHIdJOS00Dt8VKW10/RA0OLh732yYaFSvwEYR5zXHeU+2iYwB7IqEgd/tHWUa2OHVPnJVZ0gHvqJT7B+cvkmzmci82Y/4GCL7t4IUHlPsSklBfSJjYXenCpl00D8kigdGf+9C1WmzVWm1NX/X4OSRSddwZVvBEsc1BMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bcP3OC65; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bcP3OC65"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSHVftpoXZr4r3gEy5hngPnIgmUOcAn+kHc0wF9xhrOap5ICL6S9S5SJAxN49E3uVY2dc8RvSYi4Vn5n0CmleUu6drrKOJdL5AChMIQnQLGGtGKUFygCGO09WJftu1Km4nfkoLjS0rHgAclU7OpZwgRnonyjKe+dik1u54PpSfzHxwoicOEU3dr/HOhKXZoJKP90uHwNLl//TdcsoCB2LgnkYuro9i4zS/BGBxrBgGn8Hs9hGYEIlFwS/HtB/rW8lCmZ65fgibQmvJtbi6hUXRhqbfRoS9ygYoSu/4ZX6Y6ZLlERa38w1o7Ghxkt6aaPb4cPE+cphH9u01c2uIJ+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN58ZrvhcNIfelKKsgKVO7Y6AUaTi08B75sdjRUQJdg=;
 b=MBGPjBg4k1NkQOxLwZ3UMuMwHxiI/HXop8YmBUFglIu3Vxzx+fdVBdM7tPUB4ICYfAiMeHYV5yuUxYj2CFAKa+9jlmx5p/3uM9eB8WGJUJ6O6bz+3XgPVv3QpXGDXeBULqweLmUHXEkqTgQBGXJNw6BI2fo4eN0jqGRdX8L7Rm8x70QqUxr5M+PWhDjjteBTsLke+wXl7mopOgFkMNNgWDYkgqHbEefHjseMz5MrktUSdYXycrb1M5SfVzYB/3EJto5S+mKIIg1XfMMIxUai4HSIul2h8LUSmPEOg/fTJOgMw0e2Lh73QvX/jiu9TNHGZ9rG7QLV+ZBcptnhatu2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN58ZrvhcNIfelKKsgKVO7Y6AUaTi08B75sdjRUQJdg=;
 b=bcP3OC655tUCR/mV/ggPDf6zDFeHjxPGbaU+k4xu80vaLZMrGmSRjRgP0qsJYbj4kLnZFj4RXblFHtTxL8DjVjfimbtJsVNNDVXxvypCsZixK7bBLdxmD5FSkz+bzCXwX3yr64B4958Uqq5ZhpuudRYoS3AzK9ELy/xgSbIgZyhmU6/R/vqvigQzFkXz6G750iUr8BSkMOKWe0j2ZvfQxwQVo0RvoalZ37aiIcLH2IKd0Z7oERWRfNSBNhyvEeJw5t5Y14LJXNsbriZsUl5TZfWdXhLyGsGBJFxd2ugzA/VD8NKjhDuYe1IlR/E2VWmbv20ZJnYgRXipD2VPrGhFHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11350.eurprd04.prod.outlook.com (2603:10a6:150:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:00:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:00:26 +0000
Date: Wed, 18 Feb 2026 11:00:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Message-ID: <aZXiEWmNEdCfXse2@lizhi-Precision-Tower-5810>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-18-cassel@kernel.org>
 <aZTzn-R6f9acu-2J@lizhi-Precision-Tower-5810>
 <aZWXzzul8xRaDQgm@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZWXzzul8xRaDQgm@ryzen>
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11350:EE_
X-MS-Office365-Filtering-Correlation-Id: 97efeeab-977b-4b76-5de4-08de6f06d485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1WF63+HZUe5UOeu7/PJ+08+wmMc7th00Kah32g+T66mCs4UmAYgx8c93Mml?=
 =?us-ascii?Q?LWVpuxG6WIPbOJmFoc+6g1h0uXZVEj9HdMPQmN8nKzE8wGWMw+IpxU/RGqQE?=
 =?us-ascii?Q?Awm6OyAeTCb8TocJdAbkf7rvIfRAe7QuwH3dRJg0czSqeXG5gYLdSOI4nkxB?=
 =?us-ascii?Q?vV10fAqvQFDm3BYMOULiwuBG4YS4v+XSieG1XEawx+fCcEJfUDDJiT/czIl3?=
 =?us-ascii?Q?mn/nRNFK5a5Yo4vCc7Ns24GkHVDYK1NmG5bE/rJkClkXenpWyOV9F6XzFBNK?=
 =?us-ascii?Q?yRBnaz4y6Vg5mp1BOCc2zEeRNq8U82YXDBEiKZqw0PTfXtpXrB7TPwab7ozC?=
 =?us-ascii?Q?TOHEivGTk1u0j7FgPmQQ2nv2EE6rJv/i3+C88k3bS/pKUjhrIBb9eem71i/B?=
 =?us-ascii?Q?MMrK5K8VcoTaB/OCS4U9haAEzLe4qmCbvcLp++lO6EBqm/tlqluZqdDnwT9+?=
 =?us-ascii?Q?DhbLm5P4mxb+9hv1qd4cBe20XS9oq18Chn2VmEl3eNVCS1BoVVvy0LTpnwHI?=
 =?us-ascii?Q?DEp2nHUyYuGnqwT3KjJmiQQ7BlPo+EnWJEXZfvxtFN4qZvEU++O38cm7kaj4?=
 =?us-ascii?Q?BA+w55r9oZBW0LLllM2SKSKKGiQeldGOTXAQpXSe4GPVLwF/OcUgtl3s8cbL?=
 =?us-ascii?Q?YyLCsGvpRCxr42cA7XukOUEbu5Tau4gxwJ40QLXlvkCul2nWaeD8ZZKJhamZ?=
 =?us-ascii?Q?e4Y8u/nkKS4Ej+vpYXHBCN3Ahun+D5fo+G13rPRtCwnaxhRgIoF+w6F9PSwP?=
 =?us-ascii?Q?hWj4q7r6HBuPX/ZUA5ykFCVNSv8RcxTDoQYOBBY6Qhdmfa4OnuzTCy9p1hrk?=
 =?us-ascii?Q?jlnIAkd0T8aN4s8T+nAeSHcQkUVqdtea4MtlnGAyJkpdA4WQliUzZf4+cyhW?=
 =?us-ascii?Q?nYblm+8hJE0OC/pFt9U/b/q/UJ6NdObZNe1+0xHa2iByMBk2izGyltb84SGp?=
 =?us-ascii?Q?xEIfZOZt9rt8Cq3Ls2I9gxuEAUd0x5k6Cwk8n1qa2s9muyctrQxIJzer59Tt?=
 =?us-ascii?Q?WST6TX/nKmcjWpXitDjYMRwF031YSlm+t0UJFTV9IteAwZkkiF/Ub/atlFiw?=
 =?us-ascii?Q?3vjmZfym8JdiKfavAucaFPgB6yJfvIqkU5PO+a/auLx3m56AGb5S7G7FsDew?=
 =?us-ascii?Q?pnQRLF6FXQ3Gkzqlias7md3UV+GtOLga2p6ZIL6S15hSsZxexojhrcP4tIMz?=
 =?us-ascii?Q?hKut/jcygb8xnDWnAQyO7uj+UZKjdV3+ezqdPznR8HV+zUISbyoWCnqhk4Jg?=
 =?us-ascii?Q?NZokjrSwolC1r/7tb1yAZPhxzYK9Yvb83+4u9momU3ZYXOSIkUN3uAQzFyeS?=
 =?us-ascii?Q?RCzeG6Q715AsQpNTRMtTxz0iykq6c3KLSOuzUkB9EGuR4YIzw/rL+fI6910r?=
 =?us-ascii?Q?VBjZXQ6WBvOaubn9CRgDExiYQKjys7grQF9PBClKKKcqPZx3F2X1cHaNYacv?=
 =?us-ascii?Q?koJnnMpMvJ0Fd7+zaaq35P9mKUFl7AtKI9KAKJRgH9EEUh7ApeExp8aXjBpp?=
 =?us-ascii?Q?tshOoH4N4gnEj0g5eATwHdsDkOyitDzzsIgMUbBM9fhjFAENo4dQ2/ZMXPon?=
 =?us-ascii?Q?W8+zD5ITMaNUqmK9SfY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IhHD3ert0MGorJt9njPqw+H9JpoOJ1uIPw/rPdVBdAmxA6ku+m/uTfFmvzIF?=
 =?us-ascii?Q?Kj5eerjBvcJtl5C0wPS0+zuke55LsBer6qUi/X+p3txkqQFmt5+FFZzbCHLa?=
 =?us-ascii?Q?EREsQOMZUNqNQHu6KL+X3R7r03gnTSBkSMn7oGQ19X+/jwkNJP5PZSEmbQel?=
 =?us-ascii?Q?xR4OF03DWSXtMT4hFzzTKhqXMX700xBpA35ox6YBV5w92M/Ckrysh56j5Jjt?=
 =?us-ascii?Q?IeVE2yQFkE4eW2sh5UhNoTy4x32R3/pwYTnysgaPUJkgXURpISC59nNqEL+c?=
 =?us-ascii?Q?/Od3S6Pww5YOv6BgBj8vq5p8rEjz3F08LYY+nm/wl9ex5/fS1wXqOHyv9ak6?=
 =?us-ascii?Q?FkUffTLsbClwblp2ksyuGBlHxEjTeO6WXdyE8voXLAXzALuHfLxZUNSMrNsc?=
 =?us-ascii?Q?GvoJAInk3gD2RI1mBgdCxTrBPezrjKE+MCP3VrFN78oUpimMLhqTnDNkbuN0?=
 =?us-ascii?Q?E2dGMp9QUvZTv80wKoaYfJz6KpXSn55pyQtrAehgxAVHpO11Lz2tHyz1dbuv?=
 =?us-ascii?Q?4a6/JKS7bEjGz6+B100yWYgjdvbROQFwBxh5gsFfx+8fSVwGJUa7fpf3bb1C?=
 =?us-ascii?Q?VRY1Tgi83FVUOu1DXHqMU62tMWOqA1eEm0OgBTfoKW/gRO9ADEo/eZAowArr?=
 =?us-ascii?Q?kKJr93lPIHzTIA/ep2t8SV+y8TDNarNt8PxCOp+R5lmn6Enbmk0orjhXsPIn?=
 =?us-ascii?Q?eK8Lowp79sfI8B+I7seowS/lj8C2PS0yC6hVTCyXngLUr1PQP2XROCF3rXK6?=
 =?us-ascii?Q?4Buch6Xk7yr6BAcU3d7Zhe7KzNnyIcIWba6kePhBLi4tqH+RHDrMTEHuoSCf?=
 =?us-ascii?Q?dQgRM/iH5BQ8gjjUBL5iZkSeMmYJ107Yk319LO0VbyKQ4oC3g7WfW0+eOrE/?=
 =?us-ascii?Q?Pq25sHbJdTWpDkWq5xQXkuUpKADJ7UI8siXVdpnHul/NiMpa7nL+tPUjAc7B?=
 =?us-ascii?Q?or2ea/zyTvJB8LCLgphve6IHw//g05BzITIoVr437Hcq3NgMaq9F+PGuxESm?=
 =?us-ascii?Q?cTPMLpr4cLQZvkT0kk7+BclOz7nCEf5xt1DjwwvaxEtW56yTY7WRLJkDWd/h?=
 =?us-ascii?Q?VhbWj9Zx638JBF9Uzo3eudf4HHf30WPEEm8nDNbwCa5rsuhFs8jFaaTPIeaO?=
 =?us-ascii?Q?/2whweJ2VAq8Yk+TNghxRFtTl8kznccS8K31OzfVSkhipok9ha0iRUlCV/kr?=
 =?us-ascii?Q?PoeRJj8HX8yC1FyRmS0BbmZlqnaHBw2y0nmswLT861yIyeJk8O073vP8HquA?=
 =?us-ascii?Q?AX4v2ZnI/V67e3GgeyWzCFY+/F/49h71cQkwXTy1ucqzXGtyCHa2OgWh40VF?=
 =?us-ascii?Q?l5rcECRcEt6owR5J/YGJYsr/iA7Qibps9LjAhql0SUnI37koLcig5b3+024b?=
 =?us-ascii?Q?B/F/Ik4i/VqYguM5iQzEt1DXEUnMbbCCEvUBt/gU9bKQHdRoSEbcOfp6EWjI?=
 =?us-ascii?Q?Tp6MvPZabWEicois8TSehr9ZyO/NZYutgCLEOgh2fLPNu8irABjzsD8dcN/d?=
 =?us-ascii?Q?/vqWrVnE33BVmn1K/TxhTNqNYJ7ro5LO+OIDS/uWVBac1+9fUbXzX8ySmC4z?=
 =?us-ascii?Q?ItzZMpPjS+G9nkPt9OTAmF8htkJ+UW58BXdtmb8hTtzRRekwk0WLEFeZTBlo?=
 =?us-ascii?Q?vGx2RS/UaYskeUQQRQsTmVt2mHWnO6Yqy5PkkO/E+AeVWf4g2gxCngR+LUJd?=
 =?us-ascii?Q?cKx1hQes1rahlKq4CQxBlp3AErqEsZPTSzdPgL89vFuyafw7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97efeeab-977b-4b76-5de4-08de6f06d485
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:00:26.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zu9uIZz3WNsvJ/cxAp+3yrzBTi9DQkaGrDzSt1sHZRWMU0sLzLiFYRA8CNV6Qsxxl4cF8QyDCgsqhEAI6mXkCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11350

On Wed, Feb 18, 2026 at 11:43:27AM +0100, Niklas Cassel wrote:
> On Tue, Feb 17, 2026 at 06:02:55PM -0500, Frank Li wrote:
> > On Tue, Feb 17, 2026 at 10:27:13PM +0100, Niklas Cassel wrote:
> > > Advertise reserved BARs as reserved in the Capabilities register,
> > > such that the host side driver will be able to skip reserved BARs.
> > >
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 24 +++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 0cb7af0919dc..4c7e42fe5d8e 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -64,6 +64,12 @@
> > >  #define CAP_MSIX			BIT(2)
> > >  #define CAP_INTX			BIT(3)
> > >  #define CAP_SUBRANGE_MAPPING		BIT(4)
> > > +#define CAP_BAR0_RESERVED		BIT(5)
> > > +#define CAP_BAR1_RESERVED		BIT(6)
> > > +#define CAP_BAR2_RESERVED		BIT(7)
> > > +#define CAP_BAR3_RESERVED		BIT(8)
> > > +#define CAP_BAR4_RESERVED		BIT(9)
> > > +#define CAP_BAR5_RESERVED		BIT(10)
> > >
> > >  #define PCI_EPF_TEST_BAR_SUBRANGE_NSUB	2
> > >
> > > @@ -1106,6 +1112,24 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
> > >  	    epf_test->epc_features->subrange_mapping)
> > >  		caps |= CAP_SUBRANGE_MAPPING;
> > >
> > > +	if (epf_test->epc_features->bar[BAR_0].type == BAR_RESERVED)
> > > +		caps |= CAP_BAR0_RESERVED;
> >
> > Is it BAR_DISABLE? suppose BAR_RESERVED redefine as hardware MMIO mapped
> > bar
>
>
> A BAR that is defined as BAR_DISABLE will always be disabled by the EPC
> driver, so the host side driver will not see the BAR in the first place.
>
> If you try to run pci_endpoint_test against a disabled BAR, the size will
> be zero, and pci_endpoint_test will return -ENODATA:
> https://github.com/torvalds/linux/blob/v6.19/drivers/misc/pci_endpoint_test.c#L300-L302
>
> and the pci_endpoint selftest will print SKIP for that test case.
>
>
> BAR_RESERVED is describing a BAR that has hardware backed resources, e.g. eDMA
> registers, iATU registers, MSI-X table. These BARs are never disabled by an
> EPC driver by default. See the kdoc for these enum values here:
> https://lore.kernel.org/linux-pci/20260217212707.2450423-15-cassel@kernel.org/
>
>
> Thus, we need to tell pci_endpoint_test that these reserved BARs (which are
> not disabled) has to be skipped, because if we perfrom READ/WRITE tests
> against these BARs, bad things will happen. E.g. if you write to a BAR that
> exposes iATU registers, you will clear/overwrite the current inbound addresss
> translation configured by the endpoint.

I see. it actually means skip bar test. is CAP_SKIP_BAR<n>_TEST better?

Frank
>
>
> Kind regards,
> Niklas
