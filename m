Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCA3DB30E;
	Mon,  1 Jun 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327190; cv=fail; b=K0maodd7o0N+ZR5cB7DKcVMcTU5aOO9lxdY1fGLPCYO6mDEJ/59a+b22GBCWyAbdyE01IAk0jh30cM6Pnj/nc6vLehb99aEQDUv6yh1rbpxYAqxzKOLSJGSb1go2CzKRn4sW8idAeBB1K5ceSnmYY4QH/2O2Tf3fWY2PtdUwmKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327190; c=relaxed/simple;
	bh=Op5px9PyfxUiVENmGC7XzsH03BPl4zvDfQt/pVzjRlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srbfi9bXQdHV49UWAB+lmP/yWbYsJeB7rqrqP3yzjvPDyb6cAhStsyU46X/JqE4oU8avJUfhyl8UgHMGCX/fZru7mGT8ctdMo+ESImnxAMUHI89UMBGH5gv7yqvBO0l7Z8G2CChsCeGBfDrZwpXEPa9nYKy5mvP8lOGtFY1Hbkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HxAKJdyz; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HxAKJdyz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slmq4KWm08YWgJN480mX7sci09mHnXcSWuj+x78d9NN4t/oVPzzD2DBLVt74Ii4Oo/jqbVknNcVcvgmhNKdKpG+h5i8a3Ib9u+SHzj73uBJVTz3xWostMfE5hiSghm8kCandls4SEnJI1bEk2FQhOwYhYKNDQbbAlhAliu1CwfspsAjPVeXBD1jTw+zzhFJzhp8wzbNBJn8xWcCkewaHLRPjdON3jmZeWtGLBmDqhKF2WM+f3uYMs+exmrsGa4hRDumH7GMtR7aQfMKmGIj0vlr901yz4q5gmJWP6J+2CwN7ctNXIww5iqQyVRvY1A5wBjPj1gRhRxAyo2McyoPdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1etm8en4GWdbh/YzCETPYWp+z2nzzuuJBZwYek7Hn2U=;
 b=ej1R5+TOtB3FhJ+e6xkUUquRCYiVapndalwroSqgtBkuPWmfjg7Rh+T2fx/tR9gz4a53tNh9MtCBAC/IWiyj7xXRz9RBUhawPyrb4wq4DyyJE1Ue0/sJ9uA6YfT4NwpoxfwMhse573+Db25RwNLhCzrakm5HRCYtFFVWHzjcisamoMjMGbOtPPQfEJ0SupPbCPQOWxwoNLJfhEIa4fcoOmdKq7hcb6cqY6zA1EX3FJZnx6F2X7KugRyxr1g8iBkrHwFek1wv5A5URvm37ajdB/KzE8kLJf1P3d70CYa6iFpA/HADfvDKSX2uihkd2iWAAYZEj4UCFR5sDy7wfVgLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1etm8en4GWdbh/YzCETPYWp+z2nzzuuJBZwYek7Hn2U=;
 b=HxAKJdyzqbxB00kHcitEbZqXEESZz5MxObmWafQprNSUNJD6vhLF567WnG0Q4xvKT3KYC0uWNUj3f8qy1YDn+8BqbeGL2pE4fTOrTcUIdCaXJmQkJ97iKHWchtvzAwg5pZ2IeMySFK3dRwwdGJN7xUceHRimHUw+2tCsQFo4IImPs0PlscsvqKRFH5Ztdn9G+gB/rmVcjbMxubfoLF2Mw6DI86HNE+xxopplqh2W+ax56wWMqf1Rofk50nLI1qZw8hLmPpSWccty4MJhaspZ8WhABGxhtScY342HE3hFrWugDTveo3PaQjuQvt3gPd4nWxLvfs8ayxCi28jPzgxcsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB12143.eurprd04.prod.outlook.com (2603:10a6:20b:744::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 15:19:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 15:19:38 +0000
From: Frank.Li@oss.nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Sherry Sun <sherry.sun@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH V14 00/12] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Mon,  1 Jun 2026 11:19:30 -0400
Message-ID: <178032715479.3978899.9154220521965066495.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB12143:EE_
X-MS-Office365-Filtering-Correlation-Id: 580f0118-f93c-43d8-d9be-08debff13250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|921020|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ex/htieCqU5PIj+Q8kHicnzGOmdDKAOE0ojMQgheDT//y18tRjxueQgFP11fJ3AEZAkTmthabkrdKUnVnWTPvITRIlYTrYiCkuuSUqT5Vbuq7aNG6uC6E9AfVa6R7ZzI0SqYref2fEhaOiPGD0cq7Sh8Dzp8HweCCMYFvy0qbm/fssLWhbrGS6ti4OSFiXL+BFwD3a1nHHlWBZp2QW3zPVigyK7TsrpyuAkBVa/NVirUdkZbqTSnkbs3XgWkngS/YjyNKTh1iN3sukMiwIV/QuSwD73xxkZhS9BUEAjlrpU7atB3nc3EZtCYvbRiIsj5cZkJD3r/CC7wgGyIogQiXC9wCrkENdTUiR300P/YTIzE5pQQ1wnCO+0ZfhI+hdm1joMR7nDdIeBnbSJ/AWm4X5yg/jzgP9CZ7roMMnoFwNGRPpBlOkQ2W9QbGKNYPfQ80fEz55knkk1oCqWXA67scgF6vxoG2OriAL5U5etqttriP6d+ONMFwYrNnvl8G9h2y3UiSkoCoCypXIAKa+NMr8dYXB5MMUOsFTCPzTy/gOIJpJFjvc95WXcrBmnAxLhHLlp1gIR9YO2bD4TWQu8Y3s+jajfD11lCunSetxgqn5gO8zkxEpsKSCCTWVrTSHUz/0q5s/T8v9E8WbpXPenN8+OkZnhrn+c/gdi0BnbPQe8BIRGYhtEEf57c+5JlRwBeFnB7s4ceOVSJ8b7m4L0xbc+yzb1SzqJWZnuY0Qd1ulU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWRJUmhZcXFkZ2NVQ0lkSUtyMmpGZjJxNnJJZ2JSQjViOXpGUlVvdHJaMUp1?=
 =?utf-8?B?ZTNOMy8zcCtEWDBjR0dqK2NOL09oeEFPYVpQZlhOOGZYbHB4UDVVYzUrME81?=
 =?utf-8?B?blMvMUkwUkFIV3AvZ3ZxV21LeTM3V1VxQThTWWFVRnRCcjVUREdlNFhMbWtO?=
 =?utf-8?B?eG5GcW82VlVBd3RnclIxV01lR3V3cUc4MkRZa3ROSm9abXkzTmxrWDVLM0Ry?=
 =?utf-8?B?YUY4WkhYQW4rZDhxclhuS2Z6a1NFZ2VpWllzYmtheUNjQTc3dnBFWWRaRmMv?=
 =?utf-8?B?ZG5JazA5UVNtWnk3UnhRT1NKWkNlUGl3TzlnS2ZZN0JSdlNnbHk4SWNLT1Zp?=
 =?utf-8?B?RlJVNWNDeXpmTXk4L1hjZ04wWkR1YnRUeDFrL1JjTndMb3JqTHc0VjBha1Rt?=
 =?utf-8?B?RnNTWE1YZTJwb1NQRmVrSWhIcTBwanc2MHNGV2xKOVVXZlpYN05RY0F5bkVt?=
 =?utf-8?B?VlVmUUdtN0R1S2dyaFhMQm4rS3hEd2ZkbFJrWGR3ZUJzMEswdkRpK0VMYTVK?=
 =?utf-8?B?MDVZVVZFVWZRYUFhUFRiNGxDQ2hLMnVoNzJpa0JPRGc3WHo0WmlPaCs2UlA1?=
 =?utf-8?B?K0Y1M3hYd2JoZlZ0SitPVFFLSUVLbXFPN0s2UzIwOXlWNkRmZ3kwOXpMZFZM?=
 =?utf-8?B?cmtweWtmcXJmMmNCMUVnNXZOcXdDZS9LWk0rWHFOWGViWEsrTXJOOUFOUGlB?=
 =?utf-8?B?cVMvK3JmZVdIaENKa1dpM0lIUW4ySTl1dC9NQ05BSExkcTBSMVFlQzZxekFa?=
 =?utf-8?B?djZCYXdWNTFvSzNsNjdBZmV3TUJnZVNkc2NyK1RHLzluSjQvV29ZVm5DOXdn?=
 =?utf-8?B?SXA1djdBYlBsSDEwS014NFNSZHliRUFFaDE3VSt2aG5TWUdFNzV3d0djVUZC?=
 =?utf-8?B?aHdTdFBnVEVCeXJiTjFILytMNnlJZS92QThWZGhYS1k5VnJFUnpXK1BpS1Rn?=
 =?utf-8?B?R1NscEFYZE9zT3FJYUZNVEFRM2ZYd0lNdUhFY3pRYkVnL3FzNk1BVU5NclMx?=
 =?utf-8?B?MktRUExVQWRQejNWTG83OVpqVk8rL3lVYlArRjFScDdHOFdxbUVKNnhVWmpw?=
 =?utf-8?B?NjZDcS9hL082WHk3MUVIN3JvSVhKMEQyRHFBQ3BtYm5LSE9lZ1RSRVNXMnU0?=
 =?utf-8?B?bUltcnlObE5EK3JZTzM1ZDBSWms3NVZqTFJhNldIUVlhWC91aFZuZUFlS1lX?=
 =?utf-8?B?bkNwL3FXakZGeHpUK0IrSXVWMWc5WmVHNGRsOWNnUmdnMDQ1VWVLRUkzamQ5?=
 =?utf-8?B?UjdJZUNFQW55Z3VUOWFXSUtibEVGNXM5LzJvVjA1SnZhZUNqaDJjZ3VRZmRY?=
 =?utf-8?B?aDBzZGQ1dWtSYU5ubGREMWFQbXNQeUs0S29pdlRDYWVMeFRXWjVHYzVZYWFy?=
 =?utf-8?B?QVlZcVdXbERtSGFvVmhtVENkaUx4ODNlMUdNZURLVFhPMjAyWnZGOWFDUEIw?=
 =?utf-8?B?UmxyRVdBY0pGY3BTNTAzMGUxamV2SDlXTUMxWURZdHhLczNwa013RXFlMDVZ?=
 =?utf-8?B?MUxsSThKcDlWQW5DRkl2aXg2WEdRNHVlTVdnMjJ5aUkxTU9pcGVuY3cyOVlI?=
 =?utf-8?B?MStSNE1YSzRVaWhQeHpXV3lUUGNUZ0pGVDZlTzh6Uy90M2JwVm5heURBYUtt?=
 =?utf-8?B?TXNrakQ3THJIK3Z6alNiSzNjc1ZIUGxxNThDby9YWUVFYWo5UHlNWkVpSW1u?=
 =?utf-8?B?VlV6ektudS96dld4Qk9uY1ZjNzdZR2NYWGpTOFJwSUNRNWoyZS9uRyszT0ln?=
 =?utf-8?B?UGFQRFltcGJBK3k1VVRxdytIVjMwVDF2UVdKN3BCMnlrL09xR0J0eEo0cWdq?=
 =?utf-8?B?Mmk3QVpoOVE3S1BWZGgrYUdVYUxtaGpaL3ZCVTNFbFZ4VWNraWxVZXlVcEtE?=
 =?utf-8?B?c0xCbW11bTRneWRnaGg3VmN4OGlENkdsUXRtWkNhUHRlOVUvbG5EVW5qRjhq?=
 =?utf-8?B?M3gwSEt6RGQ4L0UyVzJjdWFGNEtsS3VQSmpzVlluU2RXZG1kNDRBdDhDeFp2?=
 =?utf-8?B?Z3BpUUpUVEVHazBqYXBYYmJsYkxZUzVlaFVhdjFNTWdtOGJwSVdVYmxKdk9W?=
 =?utf-8?B?K01kczlGT2x1NWhyQUYrekFJbTNBRjNXQ2dZWEpiRTNDd2pNMlNSZ2IwaXZI?=
 =?utf-8?B?UkZaVlhpVkVhclBQcnBzKzlUdXkrd2FjQXVETTBHUnR4cmFlZ0NKbUdZVE5r?=
 =?utf-8?B?VE1XakFsOTY1NlpKR3hCSG9ZTzArY2ppM3RGM0t2d09LRjRqOEZJSWNvbmpQ?=
 =?utf-8?B?ZjJaRTZHK01uUVFSUW54NWxiWmdJdm0zNXVPVG1vNjBDT0JTd0pHT3RESC8w?=
 =?utf-8?B?bUdtR0M4N2pEU2dxbkNnRk5tRUdYQzdNUDdZRytnRGhHZ1J4SG13WTg0dlhI?=
 =?utf-8?Q?GCkNmmHsno6lYv86LcACqi5O1DGBJiAT5U2RH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580f0118-f93c-43d8-d9be-08debff13250
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 15:19:38.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bErgjCcsUvNwMOldNCsCD1PbYjLBW1dxf1xvRAUJtbfTf9ECx9789MAPrgu2pePDqlfziT/nb73MNEENFqiJnr3nAmDK0LY//y4zDl4dHDQNlyVhCq/sV++OURB7GmA9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12143

From: Frank Li <Frank.Li@nxp.com>


On Wed, 22 Apr 2026 17:35:37 +0800, Sherry Sun wrote:
> This patch set adds support for parsing the reset property in new Root Port
> binding in pci-imx6 driver, similar to the implementation in the qcom pcie
> driver[1].
> 
> Also introduce generic helper functions to parse Root Port device tree
> nodes and extract common properties like reset GPIOs. This allows multiple
> PCI host controller drivers to share the same parsing logic.
> 
> [...]

Applied, thanks!

[08/12] arm64: dts: imx8mm: Add Root Port node and PERST property
        commit: 99a2249e2ac51680eb6c314e7c50dada030614fc
[09/12] arm64: dts: imx8mp: Add Root Port node and PERST property
        commit: 34f8f8aa932cb7f7e625dfb0fc32a944f8f1cef3
[10/12] arm64: dts: imx8mq: Add Root Port node and PERST property
        commit: c1c74c6df0c4dfbdf10de14ef22d559682eee542
[11/12] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
        commit: f0920daf45f7f619a34cd433b85d33b67fa1dd6f
[12/12] arm64: dts: imx95: Add Root Port node and PERST property
        commit: 83c22f27115f1800d447ebc1401f9af08075fda8

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
