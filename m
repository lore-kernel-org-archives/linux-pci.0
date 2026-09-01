Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE949F135;
	Tue,  1 Sep 2026 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788289262; cv=fail; b=ATKKqZMqZh+3v5YHBdNXXjV31fDzlPXN9x+xyWPjRnnxsppW7/2x4yRqFuwjlceMq6B/0Byq8ZWoH9gIakmpioKbTufT35S6qV1LEzDyHVSJHol0J3AwQ6VzI1A8VRxtuCCNkPdhfqvuyRhj9Bzvjf+Ho6GuCojXY6iePan0Vw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788289262; c=relaxed/simple;
	bh=ZBa74O59bkR1PXAN35QoLqxYFphyDCfox+rbNAwzAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdPk9Yx8KvyEvWvxfq6FPpdghKGTrQAcWMnTeJ5O5nzq62XLbb57urHTfLowE1qif+tXX7tS1poVf1hkxbf8qeJ8VTLApZ8CeYh8PVHA3Q0Gw/T1q4+mBa4tlDW2g0T4qEccT6pDDClt3C5ykJaJPIOFAgGMK2eaBPJjgs0+vvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BhB/8vjl; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BhB/8vjl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkcgDczULAe3uyn6kdXt8DZ1FhmftqALH5jyqEFd5UxexNTeHJolnW0wFz9VHwe3a7JZqf3jLMitYMzU0UnKmFQgwYUQfrtL9+yQGus622M0yTJzEl36cisqQ6MCemnpdvqwT9fo+Dlp21R+yp32mgbhJiDShr+atZ+1s9ZwLOXyTPgQuHcM9P5Jshlt29JqtlYomIX+0SZuAZ3Ep4OHdqPoCK2ccUAyPY5PFK8agFv2SGAbRJGAEXcT30HQnp/1ucRQeaQ+SBKUkJcdxEZKhf0IJ33JFu+d0snwqXKd8fnNh93xmuKAjetVyXEbIs5nUP6obN4eQNkjvn+j1ZWXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zVhkxphdHPVJMISM3/Q6fYaEi/wesF9b9zDBc22Kmc=;
 b=Ey5Z/ShJoqFQc4tsckKirw3Ht1qb5zqyjFIlho4/9wf8jgiM9qq2RJ1Hr+TFkIc7zRjJmJ+ndjwEx2muwMVF6zYuGTUN/j220J0tTNW8vDcTmfjzY6WXoR8hxxCM74jc3cajvD8Lz5cBWawh4j3aOmxD032QUS88Y9ooGJCUxQKDwsch7MtLqNq0zz/VQ6mNtm1qNORJVs2hmo8Z7pnLGJ9qyfvmnL1ACP59/bxXUIKC7cy135rvxXmhaoWTyYQOpwAT2AVagwEGgndIHpZwoJryWekDCdMrX8FjOXL1hogwvA8zLAI7MlBix5S3mZJ0+cc3/vIbl5ThY/mpnxrVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zVhkxphdHPVJMISM3/Q6fYaEi/wesF9b9zDBc22Kmc=;
 b=BhB/8vjlnb0JF9rqw7mzVTszU8Su3WrNfUxN/7LFujqFZ+IYOYldy7UlnW/FRG7wAu4YmbXTlGBkWmwlfKmK17AiaPoAw+gysY0xqW72L8xrGj56aOeCUMyLuDDIb5ZCCGOHNX7XY6/LmTLrjK+bvsbFhU9ZeOsS0qref3moReTBTSXZgtaBZelBUoOVx9TolZ9r898xONLmYBpNUPpBGBBcYbcwBzJaeJI7wOYr1r9PTT9QzOLb69VytZ8B1atgGFs2Oy+fQrHu7Uge+TlzfYtuRwT+m5a0UcWiGchvfavZF1q3ty6p5jqDgRnDWuQMqK+/w0rjZxil7bjzKYuynA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:00:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 19:00:53 +0000
Date: Tue, 1 Sep 2026 14:00:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] PCI: endpoint: pci-epf-vntb: Serialize virtual
 PCI bus scan
Message-ID: <apcg3J8kzvQFDFld@SMW015318>
References: <20260901063238.631166-1-den@valinux.co.jp>
 <20260901063238.631166-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901063238.631166-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7P221CA0080.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f75299-d326-46bb-c70c-08df085b58c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|7416014|376014|6133799003|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	bN5erQ8IJsHEgTFkatFMXj6a5FpSM61QZxsvdIOb2jhMIVXywiK+RscPOY3WC/sb1FKK3pVw1l+bYA2hoGvbfsAVyCzOTntHtzbyoMD1ug3CT/xn8lpLTXJpUe8w6orKb/aISkJ4GEb3OafOPfDlz38b2n7sTeTtet2vFaKHp90W10j056QpdZXYRpenmql7QTvL51V0BQ0XUBkHCNvYriHUyytlMQJjlbkMFDRby3ZuHS8yU32kcyFfHpjHgU2LHOIhqe6n7p3ajQp1lnyQkRYkUi/q96afw6Tyw2XLUikmOxsMREsibsqxccToTOsTRbgPMNVQaCYU8TV34Pom36chFuhUgG5/LEQdnnn/o5MYAkhFDy9NmGBd583X0zNtv20gmirAGUc4mEFIL//11LE68WtmK/+7q/PDuYKhdQgujSp2xFuwJAflGOvYPUufXI+v7edEWH9jGZGX6Jz7Op0wIoapuGAdSLTlkoOFNFHCryQxXDbv+4yfyXJpIV1UWOdKoM2EysydO2hv0/u3N0oNvacD07tBelVB0TryRGEEX/Y/HUOiDSNxoMdqXNbgOR1Ycjak0A87ZfDlERi8zYCSl56hmpa4tFMmtO6lNFaUJNs+I2uaQSUWfyuj568Yhm/zlb4ObFSlg9A1FEGS3TKzBYydPZkxPQ2WnZV1dvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(7416014)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEkVrEg1r0KDiralrDLvuSi5DGB19WFUkSzx/zejqCmf7toOnXg5FJNnLuYL?=
 =?us-ascii?Q?6d3JMUOCs20ZAnQ+8vM1RRY1YRDhoIr10tI9fqgCayqLLCFItk0LpGtQXROo?=
 =?us-ascii?Q?BIvfb5n1TPh1qRa7a+oK102IddZVYMApMQWBWX50fRwrywhoplZ0R9mS/GGA?=
 =?us-ascii?Q?ge61tio9104TOHrWXSOyJT0cvKr1qPd7yUyEr21vITNX/E+5tnuRl+f6C6xk?=
 =?us-ascii?Q?v+Yh54s+2yukA6EkdGtdFnr2aOJJeeGn14U/R1qXtwFCOv7lzin/OWFYxc57?=
 =?us-ascii?Q?sS2YMrB2eKZ3agSjbRQFLEXsfdnuzB1cw/jF9aIEsIFBMuL1NRgzcYeoT9Wp?=
 =?us-ascii?Q?UMiBPP/ZK+zq3+04aO6jHforBHL7Vq4DaSIyerFAjkZpFbM5629Oksjea7M6?=
 =?us-ascii?Q?fGZIOAMtET4wGh8yem9cGH6kVFa6fqUvFjHD4/dny1ets+/fRJgY68UZTMwJ?=
 =?us-ascii?Q?kEm9e97WN5KZrsP+EJpb3V0JecqVikk2u72eX+R74mqqFD2xZr5EUjkhbIEW?=
 =?us-ascii?Q?scaNJXJhUlxHLxm2lgUORQKAs1L1Uj+685A1i33dNzlZeGYtm3he+gExgElb?=
 =?us-ascii?Q?g757e9HMuZg/iNLJ0ofekffZvdCWOVgDcsiACPHUAhLvRntf4v6WrWgzonq8?=
 =?us-ascii?Q?eY7vofSdxJvZrOtOJhpQCXPweBwptKafmxx4AuHCr6A3W4+t/32C22WIkgGm?=
 =?us-ascii?Q?RACpV+/liDbaTTra7SRUOfni0SWQH91h5KTbsXYup+lSX4FIyDxpx3+AhiIh?=
 =?us-ascii?Q?cBNlywuibg+DBxdY0q+rf4Dl+LMOPZis8zpzyhzFDIihTMIIu93JNlivQppV?=
 =?us-ascii?Q?fdMarOPuN+yHMtRReY8ltudQLTknshlpo+Dq/6jYelHQroyQfyZw5Ib+rTqC?=
 =?us-ascii?Q?SDqGs2eU5fJzHv2xEfMGl/0lP1yCEBZpB8amUO6YkLfHnljmBFx3SxX4OzpF?=
 =?us-ascii?Q?z8PDekvVYL03f0D6aG27+gYeM8uUrNU81VOQAeVcaWFbn3bN8rkqfXPGT0+t?=
 =?us-ascii?Q?LMol/omTuBzuoeFay4yE12Lts8PYx6SsbmImLWsk12g+fMtYuV4VGMnNSg1B?=
 =?us-ascii?Q?KsXM30MAqurzqvKoXNar8aPWZHNHMH4vMqKQgPQmxDUEltR4xsdtRMT/29Jq?=
 =?us-ascii?Q?wziDrqIwhxn2swh+Y5EMhfh3aj7fT/Kt0dNz+8Aqe3OijAgX6QanUnsNCwhP?=
 =?us-ascii?Q?lDIVl5G8jbADL8zVVruFsDJL6fE0nzLeMOukhJLidSzFCiZscQUwXhOAtB/K?=
 =?us-ascii?Q?vdISbYUnqGTv7S1wtPPx9lfIclzXWfQ7tb0bptU34GUGg3AtniD1BRwBcWdV?=
 =?us-ascii?Q?dZWpkWNi7hSNSnESMR5G8xLG1mJsC8fim++6KFt/O5M0Vu9SfedtjOv7uKKf?=
 =?us-ascii?Q?yIQYmVbgEUGxVhNPaka3PUoimhjdDRvzb0Rlou3+efZKdVFCXTzFlDz8hqhy?=
 =?us-ascii?Q?x1aQu+tWw2C1HV/MEy1skAlAK/Z0JxkPpOL333+QkeG3HIHDlKTX4pk/QlDS?=
 =?us-ascii?Q?rLE/dzAMdO5DhtrE4Ts542y4hCDk6lSbCl2w9x2pHNwWkeiEOOaIsw+9cpwf?=
 =?us-ascii?Q?xNLBBbfKqCe2tUG5H4M+Jz3PSfT5f/Jcs4MGRVdSU3Fq2MzDLFqv6kC8ArpQ?=
 =?us-ascii?Q?RDNUhwQomvnHvALY26hkaUUv2+tHgFtkMHKsoBXyp/nf6yJiugZNRfEtUWPi?=
 =?us-ascii?Q?cwAajpg8sLEaTe9x3cFrgMXlEX6W5LTyOdCYIZIHvaotiV0F7oPa1HUh1o0Y?=
 =?us-ascii?Q?gMbsmFlC2RuaR9tMj52trVhGq7PAFmC3doS6Mtf8rtrvMadkaDs0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f75299-d326-46bb-c70c-08df085b58c2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:00:53.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxnxn6xamsS4r8G+gDEPRjCJGZO8NReozTSyDJ6kaB0dPO/ZgDJFrdsmAZqT55OceQ0LYzY1EuZF9I6qj9Kc93yurLXsZ299cVUN1el0MgYdImp3hUDHIQTGUmGjihSZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919

On Tue, Sep 01, 2026 at 03:32:37PM +0900, Koichiro Den wrote:
> The virtual PCI bus is scanned without holding the PCI rescan/remove
> lock. This can race with other PCI topology changes.
>
> Hold the lock across the bus scan and device addition.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Link: https://lore.kernel.org/r/3tgrcel5fl55ulf3zjya4fkz4t2ms7iwwjif5rnzn2rafsydd6@i4e5etm7uqvz/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

It is okay for now, I suggest define cleanup by use guard() in future.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
>   - New patch based on Mani's review of v5 patch 4.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c3caec927d74..412e8cc6fb1d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1332,14 +1332,19 @@ static int vpci_scan_bus(void *sysdata)
>  	struct pci_bus *vpci_bus;
>  	struct epf_ntb *ndev = sysdata;
>
> +	pci_lock_rescan_remove();
> +
>  	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
>  	if (!vpci_bus) {
>  		pr_err("create pci bus failed\n");
> +		pci_unlock_rescan_remove();
>  		return -EINVAL;
>  	}
>
>  	pci_bus_add_devices(vpci_bus);
>
> +	pci_unlock_rescan_remove();
> +
>  	return 0;
>  }
>
> --
> 2.51.0
>
