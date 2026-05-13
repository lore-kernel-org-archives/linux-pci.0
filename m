Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544A3B388D;
	Wed, 13 May 2026 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698612; cv=fail; b=K8HTsKvj1FIGQK9Da/mZRRqJv9Eo7CoxYkS+g8PnSdJ/8nD07xhQn1JBDRzJsX8B+vrxkawHs8urTuDwKODwpUdO6KyoQ0zzdqmCRsA6y6+QFT3X53t7bZ8atfmiH29Rxwq8Cc8YkMBWxQEgQVQF8z0nBHM2dU2i0WiuSXO1gd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698612; c=relaxed/simple;
	bh=uZUQk+to0EuzCVg/Gt8nESSsAp/wZmD5LtB10QjNF20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qmr573I8aC4je97q4QF7+OWvM1aa7umVFCaQ1vMyonFzF8bTgMIPFkgLMBM0eE0hldUJTEphdIW1lBQIstsdEpyuednLJLUrzlwPm8SAUTeTlarKFj9KM7/+mjy3UOo9pYZlYlQ6bwAwVh36owYpdIA6B7gy/7RLM485GDcHpIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DAuvXILk; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DAuvXILk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wffHkazWBxfuFR4FBpNPdbjNIi3+iNO0z/194BtEH7xqG4lYm0/FbhPPa+jux70pscxknJCZDAroCFoc1VJb8LYRdy0IRLtqETocQX1erfIaS3mrhkWejeJd4uZCtlPBwe/Ihqt76HL0Rm+A8hDIHxEVj++upFeKmG8k6QDU3eYfTYH75BdDksIuP67FaYIJBaT9rRGRPZQOjFoop/TLkM++K83TDRX+J0G68RT4Iaioks+M/iTVlWg8bIrWG/HJyLahZKozP9DfH+LFpsA4owQSqymJYdSvQQfkoWpmrsB7T5Py4CyfUnBvkh9cu4z0wVOZ5nAoYu+s40yC2nQebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI2iBJGqVpcGMKH4bxx9pF7RLKSInrhDW7clVMXQCvA=;
 b=N94WuuHWnsgRbscxgAdhopBbplA+LOgb/ikX9SXoZmPwJzq9O5tUPdVWVd3l60SZ9XkgwitRGVPwDpgN7RVtdMEIR6hJxv4m667acwlzHCqIWkd4rvSOWIYE0BV2k/urzke8g8v+YpyC3PJqQd5GBlpsw4vBNXKpBrm6GbZpkeO6CvcKFGcmzlUFzqJbmK0eGWEr1zgZN/RxnjIJy9fBB3afllliwodCVpzbAnK84HgHiw/xFE16Dfp25HbHLjrC8CiSTiL3ua0C4HdENBp82tyFLYoT1C/feRJuYALemMPbHJZQQhNXTfRfNx8+4Mg8j79X0okAaMx1N0SAqEZAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI2iBJGqVpcGMKH4bxx9pF7RLKSInrhDW7clVMXQCvA=;
 b=DAuvXILkl0kFp8hKsm6yLofC+S58vk3Ufd3+NSavu3rmkdg53mmOB/fzi+VJJbPsETzPC4Im/O+/JFY1gGvPhdr47rJ9iAcqXEqq1HonC6qKg82UX1gtkJKe24BE8vwL7aXOI9Uwcbro/4nBnctmigpQttAQQnKzu2gE+YIOlrZlzET32dc9MYvcnIOReQUxLsJ3J/csXrlf1S80BErZR5VoXWEHTm8VSQtxfUKjf/6uJ64156+Uf3TB4USUcSn3Q+S22ym/lrh10e8sQszDe4nHmaUVkZq9g3JdiUgmYgNGdDZK48veUZLJiP8x8sOsbHomBVKh9uqH6D0XhIYZXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 18:56:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 18:56:47 +0000
Date: Wed, 13 May 2026 14:56:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH V14 00/12] pci-imx6: Add support for parsing the
 reset property in new Root Port binding
Message-ID: <agTJZWGkAOAt78w7@lizhi-Precision-Tower-5810>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
 <177859052375.25787.11297345759999790209.b4-ty@b4>
 <VI0PR04MB121148EDDDA11C03C57EB4D3B92062@VI0PR04MB12114.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR04MB121148EDDDA11C03C57EB4D3B92062@VI0PR04MB12114.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: c91eb589-4bb8-47f2-6695-08deb121620d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|11063799003|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ryt5HdATPfOIG0UNLRtb6fI1f+uIKZA5kmHyq8HqHWCWHQpooRndi2sUo8G2S9YQera6CsjsqNQopABQGyta10HqgLcllFVWvvjxlFZxTuABfhNzeU9+LanB8scRNOYGd7dn6mST66ohEB6SyAj9nXzI3Y2OkSytHDpFEFqdO8e5tNfJVVdVDUQHFhmMbzUyJ3TG2/80PMa/KoOzcvOjCmVISpJ1r5w07A2jsIlRsqsUjz4J5WUZhNAQtgjQcVXCQauWXPlDDfpmhCnGb+3te8dZs6+/q6FLiillkAyW9u4SbBtawSgpmoJ69IswC2cC4Wg5C7C/rt02MtP67AwJwK7kFsVFT91MjI6DuDS0on1kHefIAIYwWjqTiusooeWAF/fGtA7F1ftP8Fu6UJ5JGiCxpyh0yXgGyvf8jgXaC5y3hoYqXqq+addNMiKq0slim0f6bidtn8ESMmkmR6xRecWmxz9KF2OZf3LjGAqwNJfqe0gCvFcSrISl0UWZ01bEZ/f5fRqaJVe1AQYPKfbp4FJ7rkJsn7WWeN0jl03TrF47QVuWSFTRa5Y+hf2bofx8ph2s2/8eXu00wXJBI99RnPqGpJL5UEYoBHNzi4i3QJaviPgRk+9T3/JkpeipLBlkIqmfg0vDFUFahzJVXt98/fH08rAngUTmYoLcy8LOwkgGZTbYGtg9wgTgLlkXQo94X8vvc9+rZiRQpRGrpoqj4ChohgN5L3E2B//o+pNU0V/XvBZHjMhzk74ZR8YToGEo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(11063799003)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrdE0+OxVGd21y1etTgLBw/GHe/FGkiKTKDBe3yoVmWHxrGKixfqwDtA9cJR?=
 =?us-ascii?Q?W0u+HmBDMLnno50pTsWgKNPrKy9l3HF4BbzRbnxUmSO39guqxsDZjyXI8Mi0?=
 =?us-ascii?Q?a+2icYjzRwI7a4l3+ZdJrmNCjiR35XX6F0htcEh84cf1egGx5hVOTv6YYE34?=
 =?us-ascii?Q?Ba5xWJBLj0w65weAqwskV3K9wtIVSa7f9oQIgOkTArF2+An7H9PA+5anHqQ7?=
 =?us-ascii?Q?jQdn0fRPTe6bH2SZ27CrTS3+4yc4jixiEAQU6pwvmp5whVyz6De7hE8W26rU?=
 =?us-ascii?Q?9CUcClRClVKnZsdDH04ERWkYcaYem5L426eiyre43mDu6/DTYJ3wPrgRlDGc?=
 =?us-ascii?Q?dU3ftcaynhH0xw5CSahgU37vLh10rXwAv6hWOEF0qUjfoG+LaD4tRWYkPwYh?=
 =?us-ascii?Q?r1Uc/sFtym7KCTeT0BeP4CbyONSt6GaBcm1CQy0i5TAQmGNhW7WXjTGybXOZ?=
 =?us-ascii?Q?A7iv+IjYGormRh8dtnvqwPARbCv7X5ETJtg5q2I3VF4YhgCzftdB/5YfVTl8?=
 =?us-ascii?Q?0Ljjkcc0G3wkIfYl67E4AizbXVJDp6dIZCK8vYx1PHC2so+XEO0CgV+gv/Yr?=
 =?us-ascii?Q?WB+dBghJXRNe+8M4jjlAOHIEESslLZNWyOn1nbmi2DFozOGKB9E7+LQS2VVH?=
 =?us-ascii?Q?9QkAPi4DFKjgrUODa/7Nnx4aYBRbIUh164Xdb7EYXJc719I3mk3vb0PhsObP?=
 =?us-ascii?Q?TRRISqq1/gFMmmEkGHWX29Hm4b9pC7cW5y8JrOm0q1xU8+RF4m7JIK586MN6?=
 =?us-ascii?Q?SqJqFvEGsi0Ns0Ka39rZ7Q0eVT8h4bUl1mMPDGrl/clTYLWh2q0ceM4RbzMH?=
 =?us-ascii?Q?ZW1MVddjzjJehL72rnQABcN5oqKiRZiJdztS01wjX+I0nmsWkT5fdayQ0z/1?=
 =?us-ascii?Q?V+2OxUmABWbcK/Ch7l0PE3BYY7xV+31a7XV27DTyoWVrIVqXBM6Z8eg6BX3s?=
 =?us-ascii?Q?waqtsX/Csr4KsivxectoZ9l0EIQWEgb3XTwokccG+DHb/zkUNGqpkT3EvojZ?=
 =?us-ascii?Q?6UoU+6xG4PKGNuKUx/1mcI+DYtmaSVcNKQVatEu9JDtEgjZPjYjCqdqOeb3B?=
 =?us-ascii?Q?Bvv4bZYm5WEYpGVaVkZSPcqsBdZnv9aTMsHuZwQAAfa9Loyjg8bFUOyiAEY7?=
 =?us-ascii?Q?ztjTUQiTFeQzrRxit5HrXRP1ZTynPC3AtiiqCZ8hSJcZ8Jb36KMsfUpPzj5U?=
 =?us-ascii?Q?Arnw8gvPAeuqV5U5MBrE8lR3Kmy6F9x0xg7aJEeNM2yHu5hbqCVDSnWGCSu5?=
 =?us-ascii?Q?CVaGdoT1zHwHJ/MEoFBXpfRdSpEMB/an3cfhOy51Zwq+K2zskXc1xJeAYU2U?=
 =?us-ascii?Q?50cEGzS4CWV44Dn4hFSTNh3f6GlRzSeXsJ9JlmQZ8JrJn2G4vrls3csDyz3J?=
 =?us-ascii?Q?Izk8swIz5LBwwDgGXX1e5DLSSLFt70ySTSL3UNXUmzHg0IKPlTFMQZkh0nbK?=
 =?us-ascii?Q?932gAvGNyzk6kfDSHx/EkMwG41RgLxmYzzoJ8iO52ZgkpEuV+//qos/Z/Mmv?=
 =?us-ascii?Q?bLyJLS5kgq3WPx8NO4itBR95CVAtK6RwenIVGjjjadqn6BPdVezOsJ/dkAX6?=
 =?us-ascii?Q?iaf2tY8ziAJPpqN2mFCq9shM5/r79+QEqlry698i3I8taArizPr/jh3jmthO?=
 =?us-ascii?Q?l1CVAqsifMvQmCwTOntzgy7+gQe8RSuNLuuMBmnY/sIZbwiy7BKUrl3ZiqT+?=
 =?us-ascii?Q?hq5O/uQB5tVT3HUvUunFpBsomOBK1Q7u1sXg26ayq8b6pdHq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91eb589-4bb8-47f2-6695-08deb121620d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 18:56:47.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hyjwji0FOtF47toZP4DNtRtJglwHewtNn31XhcSjBv5I5oasi0Qjw6jrjFYuE6YHx9AdrpjkRTLkQDj2J7hIzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031

On Wed, May 13, 2026 at 02:01:57AM +0000, Sherry Sun wrote:
> > Subject: Re: (subset) [PATCH V14 00/12] pci-imx6: Add support for parsing the
> > reset property in new Root Port binding
> >
> >
> > On Wed, 22 Apr 2026 17:35:37 +0800, Sherry Sun wrote:
> > > This patch set adds support for parsing the reset property in new Root
> > > Port binding in pci-imx6 driver, similar to the implementation in the
> > > qcom pcie driver[1].
> > >
> > > Also introduce generic helper functions to parse Root Port device tree
> > > nodes and extract common properties like reset GPIOs. This allows
> > > multiple PCI host controller drivers to share the same parsing logic.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [01/12] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
> >         commit: 556c5f7aa06d3e8119d35f40b6602d3a547cef9e
> > [02/12] PCI: host-generic: Add common helpers for parsing Root Port
> > properties
> >         commit: 6cfd1e2fae1bbaa9258794ba9f3128afb752245c
> > [03/12] PCI: imx6: Assert PERST# before enabling regulators
> >         commit: 97eacf72d1754eeff8624114074929606fc3f2bb
> > [04/12] PCI: imx6: Add support for parsing the reset property in new Root
> > Port binding
> >         commit: 40b7f61a1a4d7fd18188f3f87e15ff5a90ce1d31
> >
>
> Hi Frank,
> Can you please help pick the remaining imx dts patches, thanks!

Thanks for reminder, please wait for few days to let it appeared linux-next.

Frank
>
> Best Regards
> Sherry
