Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794518809;
	b=so+dwCRCeavt9vAXXZVCjBBpYy3btOtwCyRrq6D40A1KgqbsxJ6FtTugsWz/1QGz/xFV
	 J787shOlyNilV84A7clUXJIl1v03I7wltBqLTm3GGuCYLcsVX4QJ2rrLuIFHrWj+uU+w1
	 DkMndWx8SS0QiAoS09m541YjDwgoU2ioguhYrCwogD8+MxW96jsYVUaAip37qokz4OePy
	 p7j0tu5qpgImCYAg+2sq+45lBbNBn/ezsHsq+CSf1kolMelx/iBj8SIMa6ZjqmHR1ls8n
	 IP4H8jCwDLprh/a11z8qYe5HuXS9pDsrB+QFP0T/FtwC6Nooh1KKiKv7QIXap0qMYSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518809;
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
	bh=orE7qvpN2XjJFULeAJZO0YbN7mgJRCQoWNEinSDj4R4=;
	b=RZGm5G7JCDvc4Vk++VJy7yld9mNjB0Hv5qbgIGQ8IbYiQ2Byci9+H5BaoSOeOM/GYgSS
	 D2TaPEXA5SMB4k+uHssObjMw3azJJhAPEd266AhoNPLhvAdNMxIfPkqleTgaL5bK9xPcr
	 LS+wEWtidZmKI9F2geB4MrJmt+u/AwqpB06y+9koSC3/TjDX7nwvZHMKzYCXENNNy8cMy
	 sIf18ZsNWFXRkK/7fcR7uT84egshGakoebggg9STsOZKv3VXTbVmvu+2icNKk6PW+DPPM
	 ixD2ugTuZW+iFrLIAj7aMk5FTC0lOB3ACrlD/UlwPMcutmB3wd2pbA5JxhcLWj7ggLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nkwH9Gt2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.50
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC4606A336;
	Thu, 12 Nov 2026 21:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00BC4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nkwH9Gt2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldv+tF0IL6/bk3lYlJ/dxJdZN4BHGda9BpBhiLM84LVe3xydcva1LurfjZEFzGAKqEBRVoPbYGmaVHCorUtVmIsUYmvU4bgTyIhSL4rpFI9JDwxpfI3R/djVlzE/On6aBGZODESx/43NRZ5uegvfC9jWxjZ2Gu+qbTMdhvvL4qBsm6ngsh5LMKkhnw+ZCSZa/rRklfWUqltsnJgLV+bmRLGIJNqpJJALHnMHXq2gFzaaEUUz6iVtmGNEmcyc5r698UrTjo4HnfmeE4Dd2qZZDhsJwWW0MgRvJoZNYJJTtAK35iu3SL3ycukvLWbwFrNitZ8OKNfzDUyIrNCN6sGutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orE7qvpN2XjJFULeAJZO0YbN7mgJRCQoWNEinSDj4R4=;
 b=vaAB52czKLetOgL5zsdCn/oL5t8U5iXuSdiprLeLziEHldya0O8f/Ck3HPdWf7cl8TEPAyxoDsqp0qJPXStQy1FzQLpRvksjnjmdiH6qGpt8suV3lme0vTuXlTpMDmP5JpiX46T91mYn7sDPfuWd7nLBa1GziNX+X5hRRu0j6peH/0w7Rwk8zlCEVUWm57si9yJO4ZVZdZY19Wm64HCWfkbtz+igtEb8JmdnZcjIL+NdOnTUknHt9rss9q/RYvYvgygm6YXD1NyuXE0ppmF0tya66T5ziGVOEEf41kLB0zci5ZOWA6hdWeY69ENkT7FjJIMKysYB8g030P4gCv7RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orE7qvpN2XjJFULeAJZO0YbN7mgJRCQoWNEinSDj4R4=;
 b=nkwH9Gt2S14XAfFnMTCD20kLDGRuvgEXN/aHBtqTkSzAuXmM4AA+0lSslAjVRXVaanQpVhvQvVvANmw4j7SPYnSj/zAYcu4LbO8eKeSPgjn/wD67l99pL+SETTr4fDSbYcHrvhC4f+xHus8NrQsbGpESrf59pW4F4S3IGkcYWMBP+xzc3maiKaKgfhRgUQRlxdT3wjUIs0UjBREa9hyx8I/xpNlnjWf2T/n57qUCpQK/FVc7XxsEq6wCZY/l0geU4XQjmKs1H6CwjWFGU5E5aMQtCIxOED1KEmDZoTZyGzHWbEQGTie9tcjyBp5w0/Wkcr+rBDmddmVXdw5a+Zlydg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVSPR04MB157375.eurprd04.prod.outlook.com (2603:10a6:150:71d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 21:26:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 21:26:46 +0000
Date: Thu, 12 Nov 2026 15:26:38 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 04/25] dmaengine: sdxi: Prepare function and sanitize
 MMIO state
Message-ID: <avYvDpY8R6fbSjjf@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-4-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-4-3668ccc7aab8@amd.com>
X-ClientProxiedBy: AS9PR04CA0140.eurprd04.prod.outlook.com
 (2603:10a6:20b:48a::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVSPR04MB157375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba91c6c-462c-46ce-b4e7-08df4103a75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|3023799007|5023799004|56012099006|10067099003|4143699003|261102123227099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	rTws5xajvbIO7R4GnfaSn+SGtJEX3FM0PFpMsc7c79UYsHzb+pfk9JRvhzxoeYOcdY9qILvb1k+kp/w1bipm01CpBqGZISAs4ImRK8SPbJUdkD44NamUzOcYKTZ6rPz+UffGQa0+I002S7+AK8xP1Z1fnX43TFHQrgj3T8D1wYLlE28H1wwkLvavGJ1wbr9xvhpo0PW7AVcElovw4l2onGjQcnSGG9OZF8xntOdevFupLS5O2ABBZrsgWpyw6YdMj1qgr87ZJKd+uu3Ro49gIHQD26m3Rs05rMWcfCmrD2LtewrKIbAl7gcZ9FO4T5BFOhEadpQjC70pMEEHSB+ocjQU6Spq+vMaJ1u3o5tV4FKm3BTyTc4h2POXD2Fd6EHThqR0rHf2kY4ImiGBYBU+MFTtAsjos1EvCydiXTbUI1pXoZ0h7tJjqhhcK/EoLXrXBK09ZpxmA6NdGUBo5iv/QycqzYIJK0TsX70L7Xg+1Udkt10KaAeACi/AcfyZ5k9ra8Os3jeMNadycWckgVy56SRitbwe0JLbRec/1i5xjc49ntCYQUzcQ8ON9lOoF6MFsYV3hY1HUNGhAq1XDh7aYJUBxs3RjRe0YvHaG/RY8dXRnzOtaqGZt6P3I8pAvSoANlNb9N7cGFKMvjTBx01MiZqmtsBCNN+j16BmHY9Usag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(3023799007)(5023799004)(56012099006)(10067099003)(4143699003)(261102123227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HhRrG4jFuUXr/F+ki4s/18DK7tvvgbTwrxfri7tPmgfs7QaYEGrg8lw4KewV?=
 =?us-ascii?Q?935hctLXRm2Kn2aaPGvr0DcH2mQyigXmWGgCOAZ1+nNctTJG/WB/wAwLCkUt?=
 =?us-ascii?Q?FdQ1vXnvtKtOwLJ4MPDCbYWRRD6jtbFIdwMUwg0VeaOWL79XFQc7ixz6DLCy?=
 =?us-ascii?Q?V7vwZm8IlWY+Dw2UpO4Z0Iln/2y/MQABoPkXJopEJoXii64j/c+2E/Zk8Yf5?=
 =?us-ascii?Q?NQq963BA8GgaDx6cBSUI4lmK8qPOJAdO66glvMZop8oqwlmFDuxZmXDsGyud?=
 =?us-ascii?Q?Pg+Ew19YYZLQ+iwHRMW4+TGlzGR8wF5r0Phy4BgH0Rll8axrjLFe3Sb9yiCl?=
 =?us-ascii?Q?qm6MGmI9/YPMn3DusVBcyYbEqnq9hl1V53YIs20quQWwpI6DWLPaQo4rUNt+?=
 =?us-ascii?Q?Qpyyx/gCQW793r9imOqzbMynVp21hkySx/dVJqO0WQhm95R8fRPpmyt+Ad93?=
 =?us-ascii?Q?Jxa86qjautzqzv5IaucZtH8U+vJXs6NXtPwnsq9e4eng89F3iahDWYwi3qGu?=
 =?us-ascii?Q?9GPoNgCFKVEONYjchobkrG/TIes70ZglrSbSBJLycWzBJnejS0UepU1xudXI?=
 =?us-ascii?Q?NXgkz2nSsUG+olKlSQO1GOS19+y9clCga85Nb1K2dapdC6cnBMtUnsCSdfZG?=
 =?us-ascii?Q?sKlIVVDuJ5eTOWDsLHLgKD2Z2GCMYhHXBwhe5EfJgqEGBKS1SHsbz9gsTvIg?=
 =?us-ascii?Q?WE28fnlyoj6FjpgVuVzwfseaAdBJ/LMlucH6+OIbZJUqVGi3ECBsZy4UWkqU?=
 =?us-ascii?Q?LKl+gSpuClCmvQE8TxNJs2A6phCFiXkQwnishIN111B4GOfMWz2hg+Rr7cnC?=
 =?us-ascii?Q?cHGzODuKUNEK2Traloz1KO4U/FN76rAhMEpsXfQRvgY96nP/M9ZnbjeiE4cn?=
 =?us-ascii?Q?G0/wma/24fOPuDfpYPs1uU4U2TW5WTCEYL/RsIIzIZmFFz9RU5+pPc2EDAUV?=
 =?us-ascii?Q?S3dGGWpsvMo4rTcu2rRu/FlPCVBUcovvUSWVVonre92FOvoAFAQ3R0Qc7NTG?=
 =?us-ascii?Q?L374pM/DymhmlEtzmHQx9+lphKbYngUSqGs+Yzh2959W69Nulwcs5YSTeWiC?=
 =?us-ascii?Q?qydL/r+pZbaKcqi2gYjJwbGRBknfm1751Q6hNgeY2NvLrORxaGehqZYjlBk6?=
 =?us-ascii?Q?RUv4oGToxN5rSs4ATyLOgcqPMFBGxjMhArMIzKGJC0wQWygj2Cy6trxyQFK+?=
 =?us-ascii?Q?NAQmvz4+S/haqyURSdB0AFmfLCJIjT3E37clVDk+S1hhReDyK9PShcPF5IcR?=
 =?us-ascii?Q?uQEJkaivE7kbxkl3FgfmmPFe9A4kDd7LBipwva+YKxZzkL0MnQ0ByaBaWrjk?=
 =?us-ascii?Q?iNduUkfTRuzlgMt+Kq4pe/GrTHTlgupWKthl3i4lq0QnyoyGDr8ENtubgdbT?=
 =?us-ascii?Q?HAEl7tlmOV8G+OMphuGbm1Ma/2Ovfat9B+1wclVJKsNHkE04Py6W9/FGMo3W?=
 =?us-ascii?Q?Wpi9bZ9hvxGrvuJe6BMorLRz6KadU0uGviI+RKT6QGEt7Dtf/QPt+vxKBney?=
 =?us-ascii?Q?aaIsUE3naJIFH+GsxS92Dpkei5pZ+WSxJMFehVwRO1penYwaYRwNYB6FDcPs?=
 =?us-ascii?Q?YhiMsLtOikktSwQoRzPyj9qwnmrjOm0QiZiBnmtylsBCzVWPVaZVQdY73PZy?=
 =?us-ascii?Q?z38FcNPOH4zj+TDFO90SNS9FylBRIUmUhKUXTW25V26/YBL1lOZcU5I8NbKw?=
 =?us-ascii?Q?eSIZDSsT5HsbVd/CmBfSrVKq+fP+gLsJKQEqkdAFRWV45RgiaRBBtRUDbmr7?=
 =?us-ascii?Q?IMP/5v5amkjds+uzzsSZ0LIgKeeK2Mhvctvzdjr00Bl4jVmlHJ8d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba91c6c-462c-46ce-b4e7-08df4103a75d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 21:26:46.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mo/FG0Tw2l6LnZi+f3UVpCfRAXIiGYW6CUgtdGWXDYFuEGIZqRFjwjSd3xyXNZy314IiQLe+XFggdbQLYJDKwDMXQuixlzYIVLg4xI8F7KFODFlSPwnqafSO65bqQ6uA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVSPR04MB157375

On Tue, Nov 03, 2026 at 08:49:45PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Recover an inherited function state using bounded native stop/reset
> transitions and a PCI function reset that saves and restores PCI
> configuration. Use the locked reset API because probe and removal hold
> the device lock. If reset fails, disable bus mastering and wait
> for pending transactions as a best-effort fallback.
>
> Disable inherited error logging before stop commands can provoke errors.
> After stopping, sanitize writable configuration in Chapter 9 order:
> preserve the function group ID, clear PASID and interrupt enables,
> restore CTL2 reset limits with operation groups disabled, discard stale
> context and supported RKey tables, and clear error-log state. Disable
> mailbox interrupts only on functions with SR-IOV mailbox support.
>
> Keep mailbox commands and peer-owned payloads untouched. Status cleanup
> uses the specified write-one-to-clear semantics. Invoke preparation
> before feature configuration or publishing new DMA control structures.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
...
> +
> +/* Drive the function to GSV_STOP from any state. */
> +static int sdxi_dev_stop(struct sdxi_dev *sdxi)
> +{
> +	unsigned long stepped_from = 0;
> +	enum sdxi_fn_gsv gsv;
> +
> +	/*
> +	 * Each step must reach a state we have not already stepped from.
> +	 * The table admits no cycles, so revisiting one means the device
> +	 * is not behaving as specified.
> +	 */
> +	for (gsv = sdxi_dev_gsv(sdxi); gsv != SDXI_GSV_STOP; ) {
> +		const struct gsv_stop_step *step;
> +		enum sdxi_fn_gsv from = gsv;
> +
> +		if ((size_t)gsv >= ARRAY_SIZE(gsv_stop_steps))
> +			break;
> +		if (stepped_from & BIT(gsv))
> +			break;
> +		stepped_from |= BIT(gsv);

BIT_ULL()?

Frank
