Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7753081C2;
	Mon,  2 Feb 2026 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061579; cv=fail; b=CWfLLPdaMGYGHsWUYRPtx/sqshwRNCLX+ymnptV/GcGvNsK67fYj63BmX2HjA+EVQ2BOUHQ2KZkvF4a2WlkuITu9BF00+mZU95snKsZ5Md4its48B4KSBiL2PUV0ijxdEDcpY3OJm5aeuhqzYsEygN1yhiUzgzRj0V+wcU1lJy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061579; c=relaxed/simple;
	bh=5w7p9pgAsxvwl4Z3dJNPX/Grd6EXgIwPQG3MR6ldgNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aAfh6K5BwTRtSYocoMIiJjChk2cV7bWr48MN4NIh2mHpd+xFxUq485YDAwB2AWupdO/hAvHLEI0zPT60ES8MPC/4QODSX0nsyjGv+q7MxkyJKyDI+rqy3246UsMk3lAqQlZABNyqbNxel8TxRwVC0eizz4c4ANMfiZ9HgPNl37Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BWWTGbZF; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BWWTGbZF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+QltG9SjhnKjTJT4Xqc/Re726nHf84j9RbncOxYgB1SSbnkZasCAVFDp5/9F3SQMDNQi33kkOOuXHX88RswGYiC8TwgTnfzMWSKZ30Z8g0snZ1SZVktca6CYa6aOQadLZlcK/3vpVUVU1o39VpiQ1qbKIUxGq8xkujsuHa2VcoGgF9HOQJvrOq/6N46Fg0qgu1TuxcAGFqacG6Fkx4jac6xjOQOeZk7LPP16N8VQtyVHYeapyac5zZ4LyEXfTDp6a75Cr/hp1xQAhkzVPR9RumzN+788N8oDNyu6VXCzxpc5AnDzeaCCdPaPsMHdx7HxWniRLcWTwdCPixWL3YCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbS7/PkeHHh5XYRztVTzgx+wTaQ6MglpyrnOgzQABA4=;
 b=h8ZOfs5x80gSXj0kj8mFkW7hROGLS7F8hvXRdSre/dsHysytvJExZs/eW6sY6+x6F5TV4xp1Y4qsR4CjbiBK10+zRfdCoZNkUuuIoa0m1QN1yMPCkYJXhakAYm01o2wc7k+bDloNonzHvrd0MdWIUvEZG0JJqqvDEyLDWna/WtwfbhJm59+r7M4abV50Pdg4qjTzKt8cJ9lCYdjL+Guwxae0SCNJJ3kZALguJ5ZN66YFDHs+Icd4nMHn5FjZdWqtWdW+TdxYx7CMP1tTp+i5n9FG3UxIxfuKeXzPo21Z6ZHb4wcSJwPo5SLfuytgbazKQUsDGGv6/clZQUEpX0eTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbS7/PkeHHh5XYRztVTzgx+wTaQ6MglpyrnOgzQABA4=;
 b=BWWTGbZFCvdU63h15Xy3R04qtV79Ly0oO8BtCMyao0vmmaehd2krctCLkGQOl0j5LjHzqwpF7uEWUpI9V0YaSKyAwAS4UGvSGHYyEwZHCsNA1PFYa7m09CwklseQGOPV/SyN9szfIo4o9OWuaGJZn6uhnxy2Xzc7c2PR+IEJVn0GWGanR4i+cQ02BBgcturJviYnAeLha9plJyL/imP/8edec6/SnE+hM0s1ax/yp7uLp+2TtULE3ZptbOtRG9ALKoZiICoxAWbqzSzLvIgHr+fqugtwCGNGFAh/CWVu5zEQcGcJCM2U6CCry/V/hhs4mLGXV0i1KB+ya8rMXKS6nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 19:46:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 19:46:15 +0000
Date: Mon, 2 Feb 2026 14:46:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: s32g: Fix ports parsing
Message-ID: <aYD+/iTSF8ikTLIY@lizhi-Precision-Tower-5810>
References: <20260202151050.1446165-1-vincent.guittot@linaro.org>
 <aYDiFpGT5hEDDFhV@lizhi-Precision-Tower-5810>
 <CAKfTPtDjad7aowTQ3UJPi5Qqgzf3q8J=kASa-t3YM4zfjUv3-w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDjad7aowTQ3UJPi5Qqgzf3q8J=kASa-t3YM4zfjUv3-w@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: a6365920-8fd0-4746-b2e8-08de6293b9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bIi2lfgEUjB5x5yFZig32dV2JaGzLplb2Ik3dt290vYcPkZkD6v9eZp3S+Zd?=
 =?us-ascii?Q?0dcCZSEd84c5HqxBsIJnCKdTY3vXbd1uD/tvOaZ+n3qWghejyVMImH30BedS?=
 =?us-ascii?Q?y9ZFFoYwJPc/26Puz5XKPyykYK7erSa/avJKsp5nYEMlocWO6H0p2AV8n4v3?=
 =?us-ascii?Q?YrOJ/dOR4sHbTeSGViSIaYSeYRpsFcxJ8OwmskK9ss4NvAkt2f230roiI8y+?=
 =?us-ascii?Q?wK38/+DW2kDrc6izrWZTIaeRhEdhB38CICIfaxFGEjV6Y8IjgsYVH10Wz4aQ?=
 =?us-ascii?Q?dnsOg3c3v0qslgtR23/6+SqwbPbuqZ7CQ+QxzC5OLW/Tdt7jSG1IQqkQNhGd?=
 =?us-ascii?Q?4j2YhKUvD6W6XC8gHiHjEdpWTx/S4xLHdVzDpBzEBSDNLsWG6Nt2WwlsjoN3?=
 =?us-ascii?Q?sJIgYIwQeJAHookuL3pfApUNhtWT9OkTzgjNw9wMQHoOFY+LRqpOZ7bFs5oA?=
 =?us-ascii?Q?alzlHyPMTFfVpRu9qlI0ssFOzyGZhjmEjZo2jgaRfyQKcpKnAui3kP6xDF9c?=
 =?us-ascii?Q?Py6/Jqj8R6zUFYnfq7jrSjBzZr3qKYiUHYqVowYcO1CvQAo0TThv3mMZgjtH?=
 =?us-ascii?Q?w6d27s2qocpvr2L5OFyYiV8urbssnx00JLvcK7lON5aXfVYevF39NJ7tb9bf?=
 =?us-ascii?Q?8IYkNZOqBFFFII7TGyRfOoTy5ugAJGJwO/qZw1rnlKP46M89BLTEEGAbxZ+8?=
 =?us-ascii?Q?SplEjOfXFz7feSHaeZnRVwHXLNT3s5Su3CQT5/qVpecicIhng/dPI3mET9Hz?=
 =?us-ascii?Q?Mf9HEMp1XyGZJc1PJFMiGinfjcN438GwJtXDkyZ2j9MUsqM520jAMQCQ5RpZ?=
 =?us-ascii?Q?ek0miCqB0zO+km2HA+s2RoViRXidMw+fsnPaEfN9158vBU2bcIcD7hq8lQzY?=
 =?us-ascii?Q?BHU2ExciNF21i7sKuVfK1KX39GvwucRS6secyst/OiRC5UyfYs7wzWRODCEl?=
 =?us-ascii?Q?hFBHiUR5x4UW2oXMlHJ/P8OzDli2w81LN1a++86RKti/XQ9dao/WDy6yFOM1?=
 =?us-ascii?Q?jktGkrTgimY6mBGQ7LygiA+k4JCFDjJ/E+4AqqgfjJCy5/DfN3aJHs4WD5FP?=
 =?us-ascii?Q?AfGnXhiugkbMi6sgjGm26v/QRmInDJrc/duym1XbSMkmEW9Um4yz1Dmpvmub?=
 =?us-ascii?Q?eumJu0VK+PyCHqNT5NH5O59YpZLxqg0PlP54QuXnTX84LQBugpUxu4xrYxA0?=
 =?us-ascii?Q?rA1Js9/Kvu4XaqUozypouoZuFJTycv5cpH+bdNcd78FXzVDs9VkqEvI3qbEw?=
 =?us-ascii?Q?3O9DOCbaYlS84fpZryCqIZHexOhYKbVN0f9sF6s+q8T4LWyWol0Bmz2c8qXI?=
 =?us-ascii?Q?7hBo7PrAINGV0SSz57uu0WgtyHKbdzsk8cd3j+ZoW56kwCzhBmFFCb8DhqrU?=
 =?us-ascii?Q?iwfuuFwCfMS3LY1cpT+BoNESoE8rhIhQEssAyeY3u2Z/FKjnpEch/MzlCoPK?=
 =?us-ascii?Q?JdHncLXkTK75Pm7vB1lcT98WyBxLbVj4z7RYSbs6aKNvaPP4rzD3JwggAXzN?=
 =?us-ascii?Q?ur+jZ65MiLaykUsS54k+sioeZkChIxA4jiOkTlNSA9HdSUSc4KfNh6YZlJIb?=
 =?us-ascii?Q?6rR4OOoF9o6bfl+dSAK/uaK8s0SZqh5hV1N/eyUzf+OI7pmdaLwaFoVJEdQ0?=
 =?us-ascii?Q?B0bFPbazA1Mg1ystrVH3x8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NDzzEZnaVxrsqx0mNoNTNfeaD05ydAIDCgY4CKqYU9ZCSo4BwG+oOALrcIPU?=
 =?us-ascii?Q?j14o9pC2sQlMwFuGWYKAuVaWH5I9PIJZyaPA3W01InecNCwEQjxACeZkVOF6?=
 =?us-ascii?Q?LftIaieYyg0hFgVOEV+16C4WVD2E4kuSUaS6sVLYUktDwlE1tUHjSbq6iInU?=
 =?us-ascii?Q?sp8vnXdddpMEKdGXkQ1JxCdcDufJLcWMQ3f7AExoCFYDD4omuf9as9PIEZym?=
 =?us-ascii?Q?fRuonnr5cK51WXsxXDg9bCbZ9OKfCyji5DhdVKXBqgAhDCe9w1t/2F2kt9sI?=
 =?us-ascii?Q?JTTcgxKxbsrbIPWkMdDcxKqEW2Shaf6Ow7cjBMROHpTsQsELOskpsTrPGiVj?=
 =?us-ascii?Q?L8V5w89p73oQsn2AfV3J7uzJgPIO7i2t0VVW0tzc7kgo2ZH6HlYGotfSwzt9?=
 =?us-ascii?Q?PMd4LfGni6XDRzCmfIauphpf2VsGx0GZLHtMvBi6zF+ufeTIMnzM3aMJmEtH?=
 =?us-ascii?Q?xuGWLvDtcILkQ0UAPSwIRhZhImYOl/AFPzfwVj2yG+vlG6Z6ydUqd27Bmd7+?=
 =?us-ascii?Q?+acyvoADLs1O8FKgya8bmgKQMVeTQQwK5EnHosoXcZQ46mwkEie6LMSoMo0e?=
 =?us-ascii?Q?9aH9gVLVuq1PZWn9lzpFzs28vIg1B5w9T9aH3eI1BfFQAWQ418CkYoYV29oY?=
 =?us-ascii?Q?zvThJXcieODwCliDaADEogDZtJVoOd19vUUqpsRN/HsdRANDNzp03lZ+r4aQ?=
 =?us-ascii?Q?RMV0XxCMx3jDMr4n0rQzKVQiSwNfybffNGITicKrGtIIVTPfy7ZBgikluZvI?=
 =?us-ascii?Q?c/hXLiDVqWMbi8J8Gc5hfCBQeNDKg2RzFA7hSeqUBgpzEJwPMNEIQEpsnRs7?=
 =?us-ascii?Q?rfEj7Vhupxy4TJ+aaA2BzGuVzYZIGq2ezFpY30aBR7R6SMcrfv6Rh8hplJPM?=
 =?us-ascii?Q?sGCnHzyv3i5dHmG/vKcDM8vpL0fNrz/8YDEAJGZHcrkb+wc/g97bwt+HUuHN?=
 =?us-ascii?Q?3MCkgLBZmmJNBddZBvvtu5u2MWdmttL422QIJZip+2iXx4h2Fk1L7EwD6dxs?=
 =?us-ascii?Q?/w5KkldEjMmJUnihtvF0WRcbd+GwZb3TpZShzCGE5IXdz613cYRUOEZBJ+ZX?=
 =?us-ascii?Q?1VNaz2wIrEM6GqI+kCFZ+c9Fqcj3H0niVABVq+yldX4M3eFx23JrsLw8ce7m?=
 =?us-ascii?Q?y3a+m5WsexPDUQR17DTjHwCE1NIhNS01ZS7SfV4bEsg09V1Tok+h0l9veYQm?=
 =?us-ascii?Q?ZMF73Selh3cSfzVd+T7237suh2vqz0balTQBYMqi2ib/l3xJNRkOZelclcwj?=
 =?us-ascii?Q?zTbxSn8Qq1NOD4p0rbrbP8uZtX7ysDxDFyj10iYcejT8kH1YkUiFLBU7KIiD?=
 =?us-ascii?Q?yJptTCjqezoxmwd+vU9aZOZbbfHGGl7Rr/KWnTxbzz5jQVPyRqxz0dF9bqtC?=
 =?us-ascii?Q?JihQE638HWQXb1rLrkJ6m39DNIEM42U/RjOrRJvFaM7KDipe2OtsNnbd1jXZ?=
 =?us-ascii?Q?bacmKSj5awlKNfsuTRj9fAEStFoEJAlyhMP6x75W/Y5fJHrkTUr3E5LnTT8/?=
 =?us-ascii?Q?beEMoKhnUDKmuCdTBVWrgrqajvPGBs+JmmsTYgqEeXBpoK17tkg6WN4mYmgP?=
 =?us-ascii?Q?f40tMCHaHDB+xCqCMGvyeTtDkA/lk3tPrccmFGf54rE7yZEMsFmm9MNMNuiZ?=
 =?us-ascii?Q?9/zuWkagFkUNzQZkWD45ao6JP2JgCuaiybrS7XJ0UMJ91UzBvPkltcjRHnBP?=
 =?us-ascii?Q?y6SElYCqe+1dI0ci6FgU5taKE6ZoIek0+SwAVu5Dc2wathyes/nzch0N2gLC?=
 =?us-ascii?Q?GObe3m1hYg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6365920-8fd0-4746-b2e8-08de6293b9b0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 19:46:15.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pq43ILuAuxEBt7t3zaP3LzHRHf12GfaesTFBZQJkxrtSLY6UxW0rPnU/wIDzAWXqyEWVPyk6/wjq1io52lTX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

On Mon, Feb 02, 2026 at 08:23:30PM +0100, Vincent Guittot wrote:
> On Mon, 2 Feb 2026 at 18:42, Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Mon, Feb 02, 2026 at 04:10:50PM +0100, Vincent Guittot wrote:
> > > No error return is missing after the loop resulting in removing the
> > > ports from the list.
> > >
> > > Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >
> > > Change since v1:
> > > - handle correctly the case when there is no child port
> > >
> > >  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > index 47745749f75c..b3ec38099fa3 100644
> > > --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > @@ -282,12 +282,12 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
> > >
> > >               ret = s32g_pcie_parse_port(s32g_pp, of_port);
> > >               if (ret)
> > > -                     goto err_port;
> > > +                     break;
> > >       }
> > >
> > > -err_port:
> > > -     list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > > -             list_del(&port->list);
> >
> > break and goto is logical equal here. So only need below if (ret).
>
> Yes it's similar that why I removed it, the goto becomes useless and
> make code less readable

But don't suggest change in this fixes patch, which should focus on the
key part.

Frank

>
> >
> > Frank
> >
> > > +     if (ret)
> > > +             list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > > +                     list_del(&port->list);
> > >
> > >       return ret;
> > >  }
> > > --
> > > 2.43.0
> > >
