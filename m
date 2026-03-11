Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED471359A93;
	Wed, 11 Mar 2026 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244064; cv=fail; b=GPeLna2WQlYMJM9u5zPhkhuAVaVSuOWEFnMW8g98I8tLpw/lRD1sgXqfBBMqMD785YXFFJGTTSNJjUr/faLVMu6hceRPTbMXE2YJHtsKxcpDgN+E5I7tMhS0HFRyrk9jj7WYhuZouvMd952gMN8CANqsY00+7nqKHESSUR29LS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244064; c=relaxed/simple;
	bh=mdxP9CIDaHskl+GpWIJehEmovWaOhRJOyGz4L5M40wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajoodrfo1wQpw42x2Kfg6B0iuFIar0IkFVdU/0QyHql4eYtFRZm+76HHagILKSAIP/sQkIzwFaVLl67gwDPcodrIHVkz5N2e/Wjj4mqcGov3pdaj638sj+EaiI52FRDA2P7EAElukE6LnSmaNXaQNbfSyusM/89Q5LSvbZrqeVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mckTJ6j4; arc=fail smtp.client-ip=40.107.130.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mckTJ6j4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPRDnKewo7Hm+PaFSlGkjeVSL+ymH43Dup2lBgmTPGB1R52i/8VvRhv/Q9N/u9zZvYTGKp3CZvydgrbUBWR06K5lUYFeKzETrIveV6UopRJY8c827HiHLgTGRHwUGA4awzwDuojaI7qSSottMPhJn73QzRS8NFNuRSNOe2jpig4zh/j3QTLEwAP1FUPc5idCe5DdWOTQJyQcpf0RD/oXkRqaQHIf51eKGUBQTNJNAi5izDGon02FSCCqEUVSwTYkXceOyWaBGEtS2irNF8WbN9oggrcqyu1kD6vhm8c7gfTKs6juMfWNUsTM123B4oJ5ofrtLhDPrgbSrE39GeEn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z7XxPLIRUzvJ5LGamwjtt+ZYSAU6QUt/qot+dsMTUI=;
 b=qHiIzRyKmiGpTGLH893N4CxUzRzz2FVwk69mHkhWSJHYrlUamUhppoZO1SuyuqjEgQRlHD8LL4RsMGXADXVOlSTwT7RLhqSH8ww1PuRUoO7hG7Nakcs6aGE6DIWDBz0kg8KMn5W/hHlrOoOqQqk93HPNjAQXu8urC+HGRdWZoNvx060UPo7bjS4YnW26cd/bvhgXUC38Wq5gNwZlUI8JRvjUBmL+8x9eMXc0j3eLbOGkRlRzJrLzXBm5t6XHu8Nx73oruz+7GRO7aVLKOksVE5I3TGIJzfvp4n0esExuiz+APatyrUpe5BBVbr1sziNEz7yDdUzfb9Qy1y+b/g19uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z7XxPLIRUzvJ5LGamwjtt+ZYSAU6QUt/qot+dsMTUI=;
 b=mckTJ6j4CcglOH54C5/+/qa0zfS6fBlTRfWuvGFj+DtdMxDJAoVpaQcBMp3xpSiEFp7s4+8YLvYof2PWNQcLK0Kk/1P+sYp3GCgWsH+MIGAyCE7ogR5fHFcguOmUrTjg9ImV2Zuz6Rj/XLKnpFDE1e9VikKwFc8hP+3PWfg7MghbpqYkuJW146D0kpi/5c09a5lIEPsL5E26StCkv87FadGQUes5JuhDeoTJTbrhj9WCOdqh+3KbUcCiiXE0kxjG5yDhTGIwDozDrz+zBm3+WyCoe49enfJnKzBCn6SfTPjKPYHGVK1gYbNrpRoCPpvm1njeOdBxmQ6RD1d/ywci7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 15:47:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Wed, 11 Mar 2026
 15:47:39 +0000
Date: Wed, 11 Mar 2026 11:47:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 02/13] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <abGOlFxj0yK53tRO@lizhi-Precision-Tower-5810>
References: <20260310015426.365675-3-sherry.sun@nxp.com>
 <20260310182854.2226939-1-Frank.Li@nxp.com>
 <GV2PR04MB121020F9D89A4025C6C59535E9247A@GV2PR04MB12102.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB121020F9D89A4025C6C59535E9247A@GV2PR04MB12102.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SA0PR11CA0136.namprd11.prod.outlook.com
 (2603:10b6:806:131::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bef427-0dba-4b19-fe02-08de7f858643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w3Uhze3SJrqqO+u+TF7LbPzjHiG3GKLUWvVFiY8Cww2byy9SEob76pqyRBK/v4ffKTRcz4qIpo77vH0ZHotWF1p1XvVMFO3x7O9ADsThxmqlTuyD2NQNVciEb15DlOREd586T7KYCW9YnfrxB49Jbei/MHPcWj0bTPMF2kySMFUUgWE3yuKcGT+mU2LbBWLWdR/VRYMNjJOyHK1bDEH4T+HYatFzQEEhnXIKQOatBsGPCO7S69WB8CBE6i+iOi1hhamx8ML7W23mBhhE4SWKE3Sax2BYffQEV4jf/PfX4svVYWFbb8Lf6ECH+1tzrkdb4yVkQab7OmicvaiJr6gD1lt3dLyH59RE8LUMjtaga0sM2e4zGnDHQhk8dxkQXJJFlA/eydlPpxQpZcS94ANtC1wvVaj9bsFvqa7mL9rUT7PEKW0ISaT5S8LwkEreNr+uXLyd3ij8SaYb7Bt5R9m/4d5RqU5euJegSgkGMzceg1tolPwy/U1Lz1RhAelhD5mYeMjIcv6VRN5CJkBAaL8yj5Z5nVgf/sUH1vABL7lmR6ZQhpddN9GhKr9RjIRnFdQTqxNZtzv9qaxPSuoy7YYf4f5zExK+8OII+hxPg2oLPgCMUJ60NvtHXUqLjScP7QapzLzx6qfaZwlPRl6eBAUBi7HmZLz47eFKzdxWMl5ZNQbZwU57xjWbEvnjT6SOUFhgGBlaqY3qbctL57g9F/z+LSqRS//Ei2+zOYvVWIG5/6NYrkuQeEgxVG8afyP/dKz3hyy85Amoddxc12HGDUcq01rObT7rgFEOU8cy1wvMibA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmdEadonrpJSA7r01RzGIWp5RapWzeuzMgZrys7e6BwwwDTgutW2GxrDzvV8?=
 =?us-ascii?Q?SeTs77occhKu4g0TXx4VNVZXWA2R5S0TBxI/RG6o9p3d+rAcrQeirkvgs7xp?=
 =?us-ascii?Q?9vDK7PAdP/NrHJPgBAELyv64JuxUjMM4SdJyKAmFUFEtHfCXUv5r8qNbn+33?=
 =?us-ascii?Q?48Z2ooMse+ApIAWwFN9wdDWuZOH49atrULPOzVx05x6g2yzUCPC8+yIEQADu?=
 =?us-ascii?Q?oruAr/U524cFZQWbC5GsQ0WOCRCFx6SZV6lMZbfEOCKv4zZ2pi8frNUGpW0W?=
 =?us-ascii?Q?zt/l2pA4uvl2KvrHfaU3ZJNakgfA2LmOqFEgw0I4wdRfwL0kbZVsah4SniL7?=
 =?us-ascii?Q?FVq4AFszI/SWoUP8Angw4FrtDv9ogHsaI3A76EFy5mVXj8aXVx1ZppjLUTQ1?=
 =?us-ascii?Q?NXtKDKWeAIM7rVDuiDUNwHbHu4X91h3He76fXNe/yKNNMiE6qZeLVHO7qtDt?=
 =?us-ascii?Q?AZZPJitWl6wJIbmKFlNWxdE5DbOKBfAaTQ77B6gadxwWs8q13xSSs+5L/77V?=
 =?us-ascii?Q?VCyKFVPllt9OU7ajbp7dTDJnQifZ/ujVBslP54MstNBNhuym4PP9H3fd1v8u?=
 =?us-ascii?Q?MneaydVLzRmeiYRj/PdwqBEnLIXLL92CKSwE/PxkgEr3wuwu4A4fvhMumySg?=
 =?us-ascii?Q?oqWfGmV3whsCbaChFbnRkUDV8EpGfeo9eGWZmSriIMz98dKia7aPqni6YsPk?=
 =?us-ascii?Q?HF9he9hz90xfZD0PD7GQVe+B1OHxtZgdFQU+UhmYc64vfPW/sD8QUXImw5OQ?=
 =?us-ascii?Q?2XWJR12rK5KebPv1oEscBr98xvm+MphhW9kkk9oO92w0y5JCc/5r/xT+erUC?=
 =?us-ascii?Q?0yif0ouHSMg+pRUIMUobftHRUeZtYv8mwj0m63+nHGjhH6ZI+j8S3BgIjoI/?=
 =?us-ascii?Q?mrbfshutespyreirQeWVNcDIvxbcXlT6/8jHvDQHSY3nad9Duj1yX9bADyyM?=
 =?us-ascii?Q?KLck+6D5QneETaykXTB59yAdcLIvb1+1/AHRXwNm9Xk7pLh2zeuUQRqB7Acu?=
 =?us-ascii?Q?A4e9Mu3fC1k+yf5vT2fLUirBPDJ+/hKONhLhtW9jogwt121AiizQ7gw1zL0W?=
 =?us-ascii?Q?ETi80bO2z8xEHO2oj4JZ66poGQLE2KiYzW5XaAGFxhEX0CcqbMv31sMk0Npv?=
 =?us-ascii?Q?uo/4qyNlucDVIaJppYAmaWoSlvXZDU06Vl8kpHAUO8pGSQdKm8y9JRkMwna9?=
 =?us-ascii?Q?OfYkmXjpiXMzRWrxfMbtf2Fey8zHPvOlQl6/vMCFOZ9xmrG+/tCYWQ5J++BU?=
 =?us-ascii?Q?fczPD2O/iSZMBxX8jUcwy6lColkVxrTu4Xw6xZWxUreJrb8bjHGNKzp6whex?=
 =?us-ascii?Q?nNK/iDgZFmisE8Rx1u3URrpZz5HE0+V8cwszPcWzckBWSjzihf8Gkz86i8H8?=
 =?us-ascii?Q?CrjKIGmj2Wfaa8itVDlWBrbF9HOjb3R9jMsSVrWWDRHQxQ6r2AEkSGjpjWkH?=
 =?us-ascii?Q?68zfTJzxHGvg3rcJLWJlFP0sTav7O3QaE6iZDkJYocN/mpa8ppgsNc/bPq1l?=
 =?us-ascii?Q?KNpn8p2VfHNLetLlV5elUGZKY9yWdStN36PzQYBGCDNwkhErNT+hcehj38Rh?=
 =?us-ascii?Q?rRgyW8nPpiMF0rHRE1catu/n1f6dHUxKiWAlLDHLwRK+55m5+/F+yJKGJbyr?=
 =?us-ascii?Q?eMWkVw8UCJ88uNNhHwGIKMwjRDoqwrKdU45HcBxTTSlzGioDFIKFtZgjW5Pb?=
 =?us-ascii?Q?++2TvMhDclWZjmKGtzVl7BlRN2tHhIbX3XYl0piJ6CN/bh43?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bef427-0dba-4b19-fe02-08de7f858643
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:47:39.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+HjUAj5R2UJPeO7xipqWQl6nX+2qzFQqlU80i2aO0g/AtSHPi/qMabRT0sdRsDnEEbVAk1nNksfZ1o8Kprd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

On Wed, Mar 11, 2026 at 10:03:01AM +0000, Sherry Sun wrote:
> > From: Frank Li (AI-BOT) <frank.li@nxp.com>
> >
> > > +int pci_host_common_parse_ports(struct device *dev, struct
> > > +pci_host_bridge *bridge) {
> > > +	int ret = -ENOENT;
> > > +
> > > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > > +		if (!of_node_is_type(of_port, "pci"))
> > > +			continue;
> > > +		ret = pci_host_common_parse_port(dev, bridge, of_port);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> >
> > AI: Returning -ENOENT when no ports are found may be unexpected by
> > callers.
> > Consider whether this should return 0 (success, zero ports parsed) or if callers
> > must explicitly handle -ENOENT. Document the semantics clearly.
> >
>
> Returning -ENOENT when no ports are found is intentional and aligns with the
> design requirements for this use case. This pattern is common in the kernel where
> parsing functions return -ENOENT when expected nodes/properties are missing.
>
> 1. -ENOENT semantically means  "the expected entity was not found", which accurately
>     reflects the situation when no Root Port nodes exist in the device tree.
> 2. The callers of this function need to distinguish between:
>    - Success with ports found (return 0)
>    - No ports found in DT (-ENOENT) - this may be a DT configuration issue, for controllers
>      where ports are optional, they can explicitly check for -ENOENT and treat it as non-fatal.
>    - Actual parsing errors (other negative error codes like -ENOMEM, -EPROBE_DEFER)

I think no ports under bridge should treat as 0. otherwise it may broken
other platform, which dt have not added child node yet.

Frank

>
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > > bccc7a4bdd79..9cc3f4ebb370 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -647,6 +647,7 @@ static void pci_release_host_bridge_dev(struct
> > > device *dev)
> > >
> > >  	pci_free_resource_list(&bridge->windows);
> > >  	pci_free_resource_list(&bridge->dma_ranges);
> > > +	pci_free_resource_list(&bridge->ports);
> >
> > AI: pci_free_resource_list() expects struct resource_entry nodes. The ports list
> > contains struct pci_host_port nodes. This will corrupt memory or crash. Use
> > list_for_each_entry_safe() with proper cleanup, or define a dedicated
> > pci_free_host_ports() function.
>
> Yes, thanks for catching this, pci_free_resource_list() expects struct resource_entry
> nodes and cannot be used for struct pci_host_port nodes.
> I will add back the cleanup function pci_host_common_delete_ports() in earlier version
> patchset to properly handles the ports list.
>
> Best regards,
> Sherry
