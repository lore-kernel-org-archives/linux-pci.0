Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95C38737D;
	Mon,  2 Feb 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054179; cv=fail; b=jGGQGAuRl1wEcevX+rPNpK+A4EWNnchc86beZBILiSE5dXLbZpZozv87/Zc6GYe2fDlQ2s2lFuRXPSnEoR2IKZyz6ozl6or+mJXwyPB5vEQp5TqaujvsXQ7rLC84UeDRGL9u6iw4UKpu8li/HjerDOGLiSLZK6nqphJCEF8ibYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054179; c=relaxed/simple;
	bh=0bQ6mnfbm0/wwaCdaSNnEA9YLmCJIswtJrl2pBNjmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p8CdbHubys36YDou6jcQc49RBJJfEjCLxK3rZs8OElPKDS9dlb0ZmPqPhtV99MMOyXmnCQcoIbnSFQ6JPZ0AARpZlo/7Y4Oj9ey+hHPVoOgUN7Txz8r5ktOH6FN9BKGdXVCbq0EJN93ygN6y2IH9dFTd0ffdyZK534CQysI90O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jUfkpABl; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jUfkpABl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqPhXIVJ1/c5Ln13wEbPmYAacLR+RBZBIwjnHbmg5tfTw4m/nZdYwveMjuiRo/ZIzkVkc84dZzbcXgzviUIAus3eZAaf1baHvGEZilIiE6yOvUB0CQyecoRNhxZgnPjnvqB3w1iK1nhrBHze/xWNAREE9x52T2IFEe5yXdf2SE4AoOBkpQgZ8nQkmVxEYDoUsT3JqJIfRJ3rqQ87+eFKxm2Z/nuquOqvfdEJ7kvAhsvJpzr+Bxep7g6pNWBbgB6BQol9dSP2m74ksoN0SG0FpQ/WPOlvTp+oyDlTPmIM4OVRMkF+O69FuHU75Z34FMqLIyCUeZCLWeuEJZcx3BDTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GvcEoMpgHHwieYZ5c4rjWF8pM1s9RgiAJya0dg+Fv8=;
 b=xWw6HiTtpXKvxyVjMzWt7a+EU1FSCTjBaJnZjNKqPcXY6NSLfT8s67Pqc3DMjJXahZ7fGR91x/OJo3RykCQ40A/40qouEK2ITTUfiQjIQakVCspk14VKTGJ1akcrk8rkeFC6/WdxEoWmh2jDnU/4oceXGq3NUKdrybhkLJVPJs4sYA1lXfljI8PwV8e/VdC4fmzixUXTDYsLbuG6gdRRw1gn5UiB0sp622drV4kXB47QZvZJUXh6yFUs8QaDn5gK2rj9VMQ0bJBKU1De8lVE46NGzE47O3c2mZkWL+lOd4ZnQloHZ9OaI3aHKoHQz1LsHM5SAa9IFg0j/oqODVq4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GvcEoMpgHHwieYZ5c4rjWF8pM1s9RgiAJya0dg+Fv8=;
 b=jUfkpABly6O2JP64o6nca+rH59r8VXMPkHQW73wJ3yKy8D0SLOD0O9wuz+58cEJGjPQ/RzTqzVAehluPtMbO3UqFdCF2Ivpqt54gLjO/VINJwo2DQuyo5+cCMz68pMUiNLsj/Ou0Xgcjl3E0/BwscMdSB7LfaYWwAkkuiN+D4CWEXw71bm0dMQPAtzn/RCMNBLnUc9pS4ED77czJ1wD1bfhIjVYQ3bEK0zE8kN5xK1BuSBSXy4tqljMdB+mGhbW46si39JKvbWq8Uyttavi+Djz5QKDb/UWrdSoQEba2GmSwI633OHMLLfeB4KbrzQSI4UzzVOnUdeUOiupnkSSTbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB11005.eurprd04.prod.outlook.com (2603:10a6:10:587::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Mon, 2 Feb
 2026 17:42:55 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 17:42:54 +0000
Date: Mon, 2 Feb 2026 12:42:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: s32g: Fix ports parsing
Message-ID: <aYDiFpGT5hEDDFhV@lizhi-Precision-Tower-5810>
References: <20260202151050.1446165-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202151050.1446165-1-vincent.guittot@linaro.org>
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB11005:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a43ba88-b257-4d07-4230-08de62827ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1gvt+UErzRSW8fpm4Glv0OcD8Q1RxH6lSachRN55BRJapBeAc12Lnwy9tAt?=
 =?us-ascii?Q?Ek17JdWw8LwxWdHJ6ZfN/ieNBH/TZizsIBe/aXcVo+YPHJ27lGooZlkvgcHI?=
 =?us-ascii?Q?9hAEbkkbuLy4B3dcSYI25FrfrF7+GSAfXavVtPXs6am7lfxCqmyuhebDVMrg?=
 =?us-ascii?Q?tSoedyBaQPeelfVq0g+XQjRTBVLpxh40Wd6JW1KJJqiolH8jlN+UsimpXvtv?=
 =?us-ascii?Q?1EDNgeWOFwxTl4mUz3u/3fJWF8dJFkH/9swHTnoaNSw7gl5WeOvGCmddA/94?=
 =?us-ascii?Q?Q4aoTYVi8htN6FsPZHlFAamvwKA+saRPkM8quHVbSEymjo4tohvvr5Dh5hEx?=
 =?us-ascii?Q?xXGDyuJCKHOAZdOs+zz/ijXJmLAbMPtUAsiS19zOWlE2+yFYa2EMfS9lyY4i?=
 =?us-ascii?Q?iZiMak/z/9hwnzqWhIsttFIXn/SbUTXW0VZ/oVIU6tJ/xBK+2umxhHj+vbP1?=
 =?us-ascii?Q?GKLbLJVaynMuvLAb5ymfwDeXddI/jE2FLHQ9+nEehYraoyxwuJT0kVzIIr/M?=
 =?us-ascii?Q?vogUj44JrqJynq3pqrWFFGX2rLZbTn9yXwGWjzD2aI8WBQsQpCxzzY/gXuYJ?=
 =?us-ascii?Q?FkhluDiCl16yY8i87vrXQ6/OhlOOInVoVYmO9LRDHOvLL6LaLDubLymwdVUk?=
 =?us-ascii?Q?tD8twmmd7t/IJLr/C90XE8329pAppnprEgyGUpUD46s27UhSKblVrXas1Qnr?=
 =?us-ascii?Q?djZld+RwEgFVEBAcFlj1uigTx4Qn35o4YoQ7m6Jr0+AzmSnnZwkqCIGGZCfE?=
 =?us-ascii?Q?iiYACs7tQC9HND/xKJEnYfQpqaJNatO4kzUILrw09CuXy9abN+aBpjyBsBIA?=
 =?us-ascii?Q?MLEmaC6Eyz+ZshfmTcAfj1B1Dd/wbP5oFn9cJUSULVvPzk3dom9M789XjO5I?=
 =?us-ascii?Q?tUA409mYs5pT/6Hk9HP4ZQLsY/fhkEsYyetPD6xgXEqVC8yCetyWJ6N6UvMC?=
 =?us-ascii?Q?fD9d1yXUxMygIU5LQtsHgu4ckuPX+89Cj3l2Yi6+Rbi6sBZHrHbwiIQYxq15?=
 =?us-ascii?Q?Y5S5mbJaVqZanKnYTxNe/l9gtgPwRtMKrp6wWFbNZ3F1HTkfPhte6RHa4792?=
 =?us-ascii?Q?YOvcB7+UxR+mciYMPlYhSdCdKhIR8YiU07tuaQXb+1JJfQFwo5iZnwt4/7gd?=
 =?us-ascii?Q?GK0DPkgyPmMXB2jomqaUgC3bc/DoYkJQyr86mbOvRH8lgjH6ZURgq4pLA/78?=
 =?us-ascii?Q?bx/ev3S/xUIZ3x3eKXv+cZzth1cGEyfR8FYUcIJpRCD7tmN6JOUpnBLjFhR6?=
 =?us-ascii?Q?VWRD/h6Z/U1Ml+IUh7e4T3a5EYwUGULNm8o6YCCf2kehtHR9Y8/rp+LqCxH1?=
 =?us-ascii?Q?irV1oZmQcMZCUmzHSSOGk/Jmgxaa06k6KBZH3GMpWJmlSRnMA6dqDBzM5m/o?=
 =?us-ascii?Q?tQElmexFKNdVdn3uzgH9gsjmLBc5eFn/1UKiyXgT1nUpwq+tgHVzvBiG/ktX?=
 =?us-ascii?Q?P0dl9/x3P9mcEhOYY0K7Mv2qaAC8IImEMo4BtXpgUXJDYuBXmmlSbsGWhJ4H?=
 =?us-ascii?Q?ZCAh6zz8h2cSFibWmu4Q7EX57EGmZUocm1sTDqcgCPbJ+KmCehavQspiUyED?=
 =?us-ascii?Q?2AbUwkf1VcUMJCpOczfuXOmZvoRCQ2EzAitOrT2tCb5J3BHmq//WDyWRF8ay?=
 =?us-ascii?Q?7kKvHHtxQAzn+JIe8Qxjt8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HhZpSLpyowAkhEca7hqV3s/3jAZWiF5bVqcArTM0darudYga/nageqi+twtQ?=
 =?us-ascii?Q?pkvpPy6b6EJozuf9VxSAY46mranLb8vIU2Bq2WqmQHFLjlEibvnL7br5HQ2T?=
 =?us-ascii?Q?Clw28XWjo6rLste+QLZq675kMJ+mDS8BKLZ6mx2w0hqfpqQ8gEv6Sld2dX4z?=
 =?us-ascii?Q?A/XBZD/+wDp6PQlRLEbczYTHkLQeoEh0m/Glhw/JEBmexE71nfSlCYtv0giY?=
 =?us-ascii?Q?muNpylveiQefgxYiCYXSrcRCpSE3wTeDZ80J622cRC4Ed+WtbIgnaQpXJcoP?=
 =?us-ascii?Q?ExaGak2z1JzpTVCta3hDDlolqASqUZoCOepBr5kll79O0H+XK/2c7l/X5zVT?=
 =?us-ascii?Q?MZleOGrLL5x0H5DYchoVVwGytrhr6PqVehct4PS3G6BIWVDw8dfz6CLhMmdc?=
 =?us-ascii?Q?tlXW8vgOcL2+Se5egF5rbb8SnbkS0cEv90NemhfxYo3/7iNDoS0nAhb8Rcj/?=
 =?us-ascii?Q?vTlw7APQkjkkcDwiohAO92ksVcwKCtF0QUd1tUMcI7aQKhSFcFM2AGmvrLsw?=
 =?us-ascii?Q?MX1cAdN5Q1jZeJjRhOocMAcFw1AqCvBoPCPKL8OEm2dL69HfxHHcY4tcIrp0?=
 =?us-ascii?Q?uxndczjfIWP4QWEmz3vLul/kI6yEWPD2T6sSXJaMcmo2O3jHE3fiUNgIJ8d6?=
 =?us-ascii?Q?YhU0ruibcfwQm1UoNGztgC78AZf8v13rYYAX1uRVNj6laCnjU5YvtQQLMkhs?=
 =?us-ascii?Q?RPpafgAX007nNCETg96NAD7U+r0na7WWkGYGvKHvpOxJMpaOlfbXkpBJJm1o?=
 =?us-ascii?Q?J1O/3Jdx+saMJzd5YYDfjInqYjarBGWlc6ctpUYHkB+gVK57MLCtJxR3WaVU?=
 =?us-ascii?Q?SG1gszTZbB0FxSrk8DB8BVpNRpTWUXw43VFo5z7nx7MBsViWHcVdH41ojOg+?=
 =?us-ascii?Q?fNc/LChzRUqvPS3ig1lvaXt/+mgm+AzbD9OWQhLFYmQrSEFnyWR9A3+dCBdU?=
 =?us-ascii?Q?H0q1Spnk7eDy+JzQ2EdoXqG9ETYQOFEt59OuKXkXyqc7Gga1I1PMh2fl4Iax?=
 =?us-ascii?Q?/07JkWR93GNUrhDms5F4Dd97zsgeF9yfJttd8tSPCC3fkNFTwjoz1qLXOXvD?=
 =?us-ascii?Q?rXvVaR9rz7V1ErQkMT9PaSRTnAoLQUkqWWPRgbriV1bru6LEK0eh0187rHUj?=
 =?us-ascii?Q?wWDijxtgGo1QPR6Dy8ZHbusPi7owef2pg/GuFx294zLMqA2IDBxuBkMfrVMG?=
 =?us-ascii?Q?NSQ3qBWRhgd65qKluaTP0tuYeY3/FJgYrbsWyPSweLya8zpAL/NAUpzFH1C9?=
 =?us-ascii?Q?E1/IXzXGnG10wnZtukJHm6gh2ilJSUxANRp1/mCloVPc8MpaaWAr4X3vTCwe?=
 =?us-ascii?Q?pCKpgsqv9uoq3STWCF+/EegxI1RInx91NOlPTlLSIOnWzUvKWHof79XNCfww?=
 =?us-ascii?Q?PB1pOBsCLKgJ2WBxzPWEh6w4tfjTlLHAvbIbyovuCCjWHXgFnKIzFdrHHzRS?=
 =?us-ascii?Q?0uS2L+HaqKKMidxliJ2Pl3eaUtsix92DVOVA+oecdJTOI6oBstAj1i9IFh7O?=
 =?us-ascii?Q?7B9+Ez96MYsUjmtTeNnwjG9t1HG8RySFfpIyb6QgPOiv3PwOzNTXGxiX9CBx?=
 =?us-ascii?Q?s1EfYHug+ADGwQzKySmpfGIQDL3WBzjl86AVh3z9UtMbBRO2XRhfO6r40T6E?=
 =?us-ascii?Q?TxXKFwb3xCTynxtOgeECSrbui/m4Wp6D5jLY1vh1qYf8udM8wS8+e5FQuza8?=
 =?us-ascii?Q?amtsY/veCMw6K97p0yNAGUijXGSTEuxSt36NrN636DloHf24?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a43ba88-b257-4d07-4230-08de62827ebf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:42:54.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkSwVXqRraPUnddQdZAI9xHDuagZ2wNqsl2WLjZTFfr2PSNexxBwssGWj1KvWhZ2gyg8hPqHpk0tEfb9VSTtFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11005

On Mon, Feb 02, 2026 at 04:10:50PM +0100, Vincent Guittot wrote:
> No error return is missing after the loop resulting in removing the
> ports from the list.
>
> Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> Change since v1:
> - handle correctly the case when there is no child port
>
>  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> index 47745749f75c..b3ec38099fa3 100644
> --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> @@ -282,12 +282,12 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
>
>  		ret = s32g_pcie_parse_port(s32g_pp, of_port);
>  		if (ret)
> -			goto err_port;
> +			break;
>  	}
>
> -err_port:
> -	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> -		list_del(&port->list);

break and goto is logical equal here. So only need below if (ret).

Frank

> +	if (ret)
> +		list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> +			list_del(&port->list);
>
>  	return ret;
>  }
> --
> 2.43.0
>
