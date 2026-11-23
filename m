Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795450127;
	b=PYuCDIvz1M40BJ24Fcc8GPx62VdPcSUisE4eEeQYVrQ1eBDV7mnguW+hZhGKc+7ggm+c
	 l62baAGTk9dq/P+ybiqwsDNr5fq+vl8erGpSOs1UNTiu2TBAtgb8y3mP/4dyn9NZMMEHV
	 3GXKmnJ29BTfHM/QlEvPOndD8x+/fYewfljbWvKyBXUXXq0tsVL+8s+VOqT6D8UpNmfON
	 awvflLVJ6P6mlUrMufpiyKE2tq7+ZL0TSrV6dNNXEjup4SWINjo69PXqMpO4syHWt7P52
	 sPJ4bBeSbD7lOWC/ekznGuptKwTzk4l7UBdqO5lHr9U9+2HcE2fdzwtVIJm8tNI73RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450127;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=y9446LSnlbSZLHwiCNV64/GuXhpiOkltrfYv2QR1bE8=;
	b=s8+yqTdYSBhoRheeko9/AXHKSITZZiYyORbkXoD+rv7j5lAln+IPRGSEpBF/FSRTXTpm
	 LolFl3hnye81+q6Hz/HUgUZn+9iwojplxPVIkZTG8xrwkBbN5B0GjHgM7I2wrW4eFJgvp
	 Wq26H+LUIEIgHQfoqKXZlXz6JiLTAmlWS0MDzzepGit3uaYEzrJm3j458qoP07kcNrP8x
	 jekPeffAVIqMY4BMlRNSvk74kQJmk9hvY4a0zRQt4ucSVtDnOo8YMnnS/9LPQy64525eo
	 w8p1K5ObUXRpEa1a+EdpW8B4c5BLPxJxRYxeHpx0G7mQf3IJaPbG1hrpSs5vI/+UFeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Z5y1LNY0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.67
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78A606A31E;
	Mon, 23 Nov 2026 16:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D78A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Z5y1LNY0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXW0uZ3X9RyL1I/Zoq9zpyot+niyc3N8V+T8U7ZnW1SAL7lZhtzuf6CsRMAolu67+YMXsTy+BSyNtVxWauUXyIxOL2Jw1yWNG2qcW74+ZNjUNnfdJKZd6ZjhoxhZ+qigTxMalv5les2X+UhrM6ApReNxb6jbAMwN0exb91d/c4lL6wdcLgzXyXVpXtTqkyQ848NQG8TtuVu8VdAAHINwMIDbGblxPyqOn4lrrApClQjoCopAiEG8rGsynZWcGhi1MI5dsU8DLEWtmJnr9nVebOZzm09Mg6aDIFNX4UOjw9GQwd8qQV6NrEJkR+5TfvbEMUzDHD72IM89t0AKgKgzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9446LSnlbSZLHwiCNV64/GuXhpiOkltrfYv2QR1bE8=;
 b=t5BMk92ljU34y9HIdugWm2lQZe8SBA21RaUDRvRrz7WBrzOfel6vjQ5OuU6FVkv09vPzvCaEFEwe2QRvpHeCTDKjcu1bq0EF5Z2V8/HAbtQJ4kQloBWetyJQsqcihYc9s6YOAj64wyARndPSNTQJ5fp5DugDDNfcKflS6bM1zUv+pM0jVNRMqe8gCxLeAjFWzHvYXdeiXGrmHfNHeUSdq2qZLfmn8qEmOhE6SgsBN6K9aCDB5RCaoJQQcCKoWkts7QfplVMiStgTPVJp1CjLsHzgZKG6rRh6O/YtnOJ+wlYysGR6psbKGAgvujvVYgoy76ISMs6P71i+85JqJBcVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9446LSnlbSZLHwiCNV64/GuXhpiOkltrfYv2QR1bE8=;
 b=Z5y1LNY0XKEQHaEXMr5nRYpEXwMYB1TUXLXKO7H6DDCPmO/To9GbDcEQD388wMxB7eeI+ZvegVxDfsOQTSuqSndK9WUWPwY75Fz83+WZrW0YBCphoM4dtjbsc/6VqJPLL3G4bL6+uk5gOudnqWreh7WfucJJW7QZMJ+t7Xluo0nGOs4IvxU3UMFfh2kLxQwAQlZW0KXl5aJmLgTALN7hW7M7iUJVE8ISA0WYxguexkX2uU7igXvNLWJtjWEKRUm4ED/2/rxcn3YXiFR1b2PUwFM5RjxrVbPp9c1W5MlbvUGjYf61EjBDrnvduGYCryA2tq6VaJQC3u06PmuNCA47LQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10379.eurprd04.prod.outlook.com (2603:10a6:150:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:08:42 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:08:39 +0000
Date: Mon, 23 Nov 2026 10:08:29 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Use dev_err_probe() when parsing Root Port
 nodes
Message-ID: <awRk_Q6ygEzDCFhm@SMW015318>
References: <20261123124110.563397-1-stefan.ghetu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123124110.563397-1-stefan.ghetu@nxp.com>
X-ClientProxiedBy: PH7PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:510:339::9) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10379:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bc43cc-97a2-4e1b-ef21-08df497c0953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|7416014|22082099003|18002099003|261009223027099003|10067099003|11063799006|56012099006|261102123227099003|261026140227099003|261022075727099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	JvWpABZrqjEpTiIF1s4w7F7ICQrv7Or9dqHDonRRuIJx4GT5QJAlMhVMm5Skg3K6El7VAE++rFWBJs9OpKa+5NdocARlTN2JjVqu000Bryf1uWSpPWBz+weOnyYM8QYH/6tVBWbCe7c34VPpedXxPAC/6VtkpeF0y80kijkZMrff03BNdSbXHf4dnwDyuJq4x4ua1Fbed9E41Gaw+fmM4D8HRyq3MRGHS3Kt8mVh8+ZM1C+kr3UEKnxYm9mUMk3zxep8EnpTrytpyW63NIE206XbBb7FC0iAfm4+bZfOG1n6W6GhuhuIyZy4TrJ2PSO7okJ5pb/42WwRVUHFDBypajFpFVO+XINv5gwLLNIBS9BQ1XYKOmWMjgAwbabHvG/x1uZuaentHC9TV84E3XG/mJ1iNt5tIU5Y4uAPvcOv3iC+B8eCbw7vajAPALP4b4oDjXyvCJIa7d3+O+GjZHG6Txoc4aokG7FDPecQuAP+AiSzqNYTLV+Td48tw2dmOPHsh7+8D93qa5ecADtrU3cwEgxtLiEHEw4T2Mj9TPiAgpbh2asEVgHhNrHnMeQJs0JUShReXdaysU75jZYjh0h/MB4MIEil5iDGvXKw/+vVYeUaLaqdCOlyymToyIocAH4MpEHqLVxyQ2ACOml5rR6FqPaUsPU4SpJXv/QOMJfOerA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(7416014)(22082099003)(18002099003)(261009223027099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261022075727099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Di072ZqQu5Db9HWD0kyc63Meuw7NiDeZYq7nlKlDa12FWUApTpqtQ9gZS1z?=
 =?us-ascii?Q?GPOvcgDpVQRfMVuPJSupS95s36mXNvAIiNznNHyi1a3yh5/14oocX/TPkyop?=
 =?us-ascii?Q?PjYA5wDV9p+mD8i745QxBR64a1SmFhzaGEf5mLqGqK9yJ0YpXI2q6Lu7vMj4?=
 =?us-ascii?Q?jZwtcXWhHt1jNzzFlGWVFxIiP2rBETtMVqP1G1bDaiNjkrcLtL6sNMtYBZvS?=
 =?us-ascii?Q?hEqNTmrhWfEv2/mrbqvr+Vg9umy2d82MMhp+0Fh4aw0TwsHbtRLRB83/2ONF?=
 =?us-ascii?Q?hdCVVF/g4RfN191FpfUXyWJ3ozHB7tIT71gP7Om0eKUQLkG5qY06VMttMA/h?=
 =?us-ascii?Q?UbL5PWfAue+guV775XfmzAOpouQZFpjSw58DcZIrn20Nlu9fyafnGsu/KEq+?=
 =?us-ascii?Q?YSoNC+IIM8ojy+xeZUZ8X6bFh7qLO8HY4QDQ0UpeOuFhXlgcPvkfHXlBJk+/?=
 =?us-ascii?Q?Rj/Sp8uozPwKCCbiYRxFK/ns5UYfv8hs93kuGxMGrHcXEcFq/dhAGjXXXyPO?=
 =?us-ascii?Q?5tPMiq2IJ8RV5WrpRUBQ0KWq9QIFARXvUNfDDKpuSOuLeERXXwpkPKMg2hhq?=
 =?us-ascii?Q?EUI5USEVUIsot/JO+TcelG9aj+V0RdIwR7gqDOT+pLEH5YyCAvcdgJqj0ZVu?=
 =?us-ascii?Q?Hn+ufX/7HhIG5LNVhOSXhzBRwwYZFlvvZd6ieBaPC8H5nLqdiGNh3WmaOYR8?=
 =?us-ascii?Q?EyT43+nnmVD1blbOYCgB4Dd5S942qsbzHhPm0ZTEUidNSxTCd8jB388smdel?=
 =?us-ascii?Q?lOCUfT9PM6PW+hEjOQ3OW6GHJ5K+ZPgNP8Hk/PGqMqBgbpIflxIRrHmpMkXi?=
 =?us-ascii?Q?pxXyIoJpZlmyYCH3i8oSpipDJ340Qd6oxLUj4nSMcjGOWSOyFuYpoa6Mo+Cm?=
 =?us-ascii?Q?TG0FEtbC4WSOl7aHycK3GOAxLzteYqOfGRQcqNYA3bSUAgZGWbSVcTqGSGQp?=
 =?us-ascii?Q?APuYZ60Bm/nRp+SRZPfgHKIUMbY8Vemf1Lpz4LHTebDwEUGhmm3hLogKMSUb?=
 =?us-ascii?Q?4x5Jq68I3yexvkxGOn08ZwOAUX3ZJuv6k1ExW8neOEv5OqCYVln0d4hWrZdY?=
 =?us-ascii?Q?bEt8Spk8086LGcIvgAy6ziN+jUhIebcdJOu2s0VovWveI+iUpgueC/sUKtSY?=
 =?us-ascii?Q?agyBsYvoT5t6QHC7UhUZ9Jm1nHMXsB1THKRrEbz968eWTboto35iR0ptlFr8?=
 =?us-ascii?Q?PSIpVInYZemezZDmPR1+U1+o1AZXYSGihZNz07ZGNeU8Jv1v2wYsaZYvg+b3?=
 =?us-ascii?Q?3IK0cB6HOjNCMWSj25Q1zpV9CTBKTHaYrUL+R+Dcn6LGzLOmbPCp3kGqGSch?=
 =?us-ascii?Q?C3eY5MJq/0dA3JFS/7niBfdOv8Nq6VMtIKOzmkS/mXkTAaqa5kHVCPPdAZZF?=
 =?us-ascii?Q?puhd13WF+yibBrw/ZxrPmT252FHuu0adgiAQYN9rxfSEMD63xflMYOpb8tJD?=
 =?us-ascii?Q?Kk7zuwvM87eBagRrS2rdcX8V1+qsbCn/XzNNNILTjySjIS6yrv6xwBmaauH+?=
 =?us-ascii?Q?NTZa1cWYSzLZGKX+kCnx1hs6Tbhx/ztKwfnk1h8dGbEUq5G3JGgmLMFO3V9J?=
 =?us-ascii?Q?yZ7G6gP9+K6G6TioEuoe08/eM4jNXWjiS7a1bqzEIaGKrHe+uLYpHQxk/tOB?=
 =?us-ascii?Q?yUU3VnHgBBVwH1ke7ruHXL3p2VRVQVf52kXJwaeU0BLnJEStVYV9owABZ4lY?=
 =?us-ascii?Q?bi49Cl6r/UWsV07oMxthxuD+TciP5Ik3eWwzdOYNFFVM+JK2piC9kJG3U4f1?=
 =?us-ascii?Q?QSt3Lzxh0p9q0FXrSWo/Lm1vLeTmV72lvxD5dzID6JFOA5T1NvbJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bc43cc-97a2-4e1b-ef21-08df497c0953
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:08:39.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXBnDb53yWgsFaEq5lqw9mwFlTo9RaWJxQiVuy2PrM6Ay0+wd1w8+fYzSjJLL5T2LtyPlQCeK6AvNvZt9iqCuAQNI4AyzxiR2k+EFXctZsmXD1puweik8W6G1h6fnBkH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10379

On Mon, Nov 23, 2026 at 02:41:10PM +0200, Stefan Ghetu wrote:
> pci_host_common_parse_ports() returns -EPROBE_DEFER when the PERST#
> GPIO of a Root Port node is provided by a GPIO controller that has not
> probed yet, e.g. an I2C GPIO expander. imx_pcie_host_init() logs this
> at error level on every probe attempt:
>
>   imx6q-pcie 4c300000.pcie: Failed to parse Root Port nodes: -517
>
> Probe deferral is expected and not an error, but these messages flood
> the kernel log during boot on boards like the i.MX95 19x19 EVK.
>
> Use dev_err_probe() so that deferral is only recorded as the deferred
> probe reason, while other errors are still reported.
>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 865438ffde879..2a7f09630d14c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1395,10 +1395,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (bridge && list_empty(&bridge->ports)) {
>  		/* Parse Root Port nodes if present */
>  		ret = pci_host_common_parse_ports(dev, bridge);
> -		if (ret) {
> -			dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to parse Root Port nodes\n");
>
>  		/* Fall back to legacy binding for DT backwards compatibility */
>  		if (!imx_pcie_perst_found(bridge)) {
>
> base-commit: 7bf2db752515a9020b310984ae3bce1089cfdf20
> --
> 2.53.0
>
>
