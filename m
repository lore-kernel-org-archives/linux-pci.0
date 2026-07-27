Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DDC397E81;
	Mon, 27 Jul 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181229; cv=fail; b=kLaDPZ+rRQjUKJ+kfEdABgP3Zb4lnjtqZ1OSd9OOfPiJlQiEtlYb5/C8eIiDebgaP2UenkOyJy4/FEawpC2EYJvtmGjxUeZ1B3jJKC78oIo7g7TChcdUFK1gjK0uOxCU5GQ+Xer+1C7VUgB73mRVJUS6M3NFJBUIghcjQm+BsQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181229; c=relaxed/simple;
	bh=gDjQCSl8aTwxAmTXfgUnqFu0bsllBJ2fRsF8vTkzR44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEKo1TBq8pv1iwNFOesSWfypAr4zKx9FM6gj6BU1h+KeuA9ZVNVijVFuGnt/Dk6fwZDAm6Ux9Nmj31YRnI4wncFS/sNMuQq3ydrzAICDD4iMzDmw7bxkgGtQP0sNXcZCjDuK/gzGjiTrW2wXucOmT2104ab3K1e/IkPD1gh1i/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BKvWQhh6; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BKvWQhh6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FN7KSMM2MZG0XVrcap/w3wBX76arwBRzFh9LnAMYy/ox8DPbiEvn6pTtuiIOXZK1P/15AUPuGafHJgR3gmFxPZEQDbmM/r9RaC/6hz4A3QaKN1ON1M2K/CrG0VlJpZ5AzY5Xi1edI3TFqwGFNIuVu9hcy2NgUMm3Ghkp/Aum8tJ1dsOZ275DCWcVsEmt26ueW0j8T7sHX965O0r7C0MmvTqwA8dtnA+QHDr9plKSKEyDRbK36Ud0X3+bIFADWwsfLeRDXQ/XPoxk3+fMqFjEFqQmOltrHDt3lF2RD9Q/hlEuR6frdL40Jy8dGRkXDO81PDQA+MIcIe96A2ZQj+gIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA4w/k4WRnSMeDu6b0R/mf41zFB/U5jCLqT/I6jKXNs=;
 b=VkcrXFD71rkKbFEf8T37vO2esDu1l4fwN/Y/vOJNI1prHB94jgO2yCyePa8KFZoYm01uesKZCp6DGbsl3J60WV9Qj62lsfQhjkUs6om3t3b3S41x3uhN8jYUk88o9CX6sxkth8CfoJi2TdFwJVrdDHi2XLzr4Eh0NCrj3VO4hrbp4cG+Cmthg6/imhSO+QieMpsuCRDh1iRKYJOK9w0VkSN5PWnvHZLT9ns0BZ20REPP1OT8uwwivHgsLbiiEluuFBx5SIKM30N0QC/E5aCqudhbtYzeFjk5/wFQeB9l8Tjh4ZnQ36R3lo/RA1RT2Mvn/yvJo0Re2muzFR6FcueRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA4w/k4WRnSMeDu6b0R/mf41zFB/U5jCLqT/I6jKXNs=;
 b=BKvWQhh6d6+EXvXxxKZGBXqdrxhhkMm1LVGO3YhiAj18risB2InUtMDpKndXwTnpHabgZ+N9BbrH9+F45srigVg2NKmZEdKC+zuWXXfvJ8jA2YrcSaItv0msI4qpU+0XNEHSnZk3Le1gD8zjsTla+A4P+BcDYZoKyN/SwWojwLwg8gXe8XxxyMiFU4Div61/nhnw/M+H71HXNI0VaYaHziETntVPIUhsEuxdQRuDHR7ifO6d5i5OqfgNx39TJl2jI12esly37H/9JP8vxAx71W8gurvIeXjqB2rHIRGXLf3DaR4poad7ZK80oUi5S1GxPKt6M6Ce75qiYwQOwZoWBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB7572.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:40:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 19:40:24 +0000
From: Frank.Li@oss.nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	hongxing.zhu@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/3] Add root port reset to support link recovery
Date: Mon, 27 Jul 2026 15:40:16 -0400
Message-ID: <178518121000.2655075.16464997188368531394.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:510:33d::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae4406c-882a-4c99-102f-08deec16e707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|19092799006|1800799024|921020|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7SrxJag2354QVLyq3bZWJrjcSLO37vy6u+yByqTBLuPDsoRaWszJNSZa4Rf0UvTzzFLT7kmG8ECXJ/V436qv7UczHyXxBNrZxw3SY44Wt2VxPzKrQ0nWalMLmtKIDLS5rS0mWTmPkS9Y5XtvFWX0lH4RemIi4sdt9FhoMzjh05KJbbQOVn7PRJoWp2kl30TVHclv1lNU/5Axps2vVT/6PjHmxyVRguEj/NvSQ1+oHzFrSrMhsZbhNP3XhAvi+FLXmMw8HVnXXlTG0dmsDwESG8NTD1EDDq55PpNDUEr/RDETRcX9DrT8AmuKcSEY7f6qtxLgqVk3CkYf8xAPavh4LPOkPUJkjRemDe4sONjocpwCrdLw10GXbniUF3mSezolGw+I2rAnLoOmg6JKqVFmfZCwzj5t1875lItHcB0Oui5r8kIa7pxoR+Z5/LqDCltZgMl1XIJj9bt+8/0MthGuhC0oROnALAZ4VCIyf19MjWSw9ga+XS0P3tkUA+XLZHrTGindxw09XDn+2tJ5cxaTi+P/szws4GEyKFIApk89JNxzjzSDEZnsw1PDLOiRck9C9snm5NdoPC4RI0GFyddqI1Zlw3JHWQziw8UWQWlDUxWQmkLlJhtbtffbyvToWOQKI3HZiUlIMzJ0iXGfTtGeT+J+wbEpyRTuMTXHRirGuyERvrebdj1xqobg8p6u01SmY7Wa7vt2s515vC2FxNNDuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(19092799006)(1800799024)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnFiVXRQWkw5Wk1Nc29DZmIvSURDV0RGNERXNWdNTHVjeGNaVlg1a0YyYVpy?=
 =?utf-8?B?M0doa0NxbWVGUlFPWllXU3d2bDFSOEE3WThEZENKZ1NyYVpOdUc0cWhUZXM2?=
 =?utf-8?B?Nk9TYWlLayt3b05IK3h5K0t5ZVdtVXlZSEJrM0dSZUdBUXJUKzBueGVGVzVs?=
 =?utf-8?B?aVNHb3pEUHRGZjQra2VIYWlIT1NzcHhha2VMMmZ6YjJSOFc0dkJhb2NFTEJW?=
 =?utf-8?B?bFFZSWJacEtYTms3ZWFUMUhiU0dFeUtJakl5OFNNcUUxRm5QTmptb3pYbGNr?=
 =?utf-8?B?YlFYaEtBYXRzVmJrei94eWJzYm1nUUZnZkZWZ0ZiWEU1bjRpWHVaZVhydWxk?=
 =?utf-8?B?OUVCbXV1MDBMQ0hZZ1E2SEVCT0tueWNpM0JNTDdoeGFPOHZXanVvcnBwNjZS?=
 =?utf-8?B?OWFXcUt3YXNSUzE1d29zdWF6elErUHhxb2hVQzBlZUxnYkEwOEthWHkrUlJC?=
 =?utf-8?B?eG1Od3poeXlreHhiK25VUjkxRXhlSGdyNU1hZ2RkSy9VVzR5bjkra3JKYmJ2?=
 =?utf-8?B?eFh4bHQrQzE0d2RENXl0S0VZeHY0Y2N6S25rM05CamgyTDEyK0JkZE5PR2Ju?=
 =?utf-8?B?RFhJQ1NKWFgwdEd5a3Q2UkRGZENxY0YwUndNRlZUVG56b2VZNXlBODhBb2Vk?=
 =?utf-8?B?M0NBaUd3dVlmWndycXkwMnJrbEErdnY5REhpTW1BQnJYN3pjU0FrdGxzV3lJ?=
 =?utf-8?B?Yk1rQ0g1QTZYNmtIOG9wM0ZGWWRmUEpCNlNRNkhnSklaUGl3OVd5ZE43UUZB?=
 =?utf-8?B?aUhWTnJqMTFBcFlYZm9NRjhnaHBWaGQxT3pVQm1abk9MQXJGSlI5YXlwTXVl?=
 =?utf-8?B?cEEvQnphajY1OVZQWGFEWjJtdWJLWmtDQXNnYzBRbzdBblpPL2p0RWF3VnY2?=
 =?utf-8?B?TTRxYzQ0aGJPLzl2WElUSTJFaXYrdHY5UmQ2eE9qOGVQUWduTFV2UXI4aTU0?=
 =?utf-8?B?TjlNWldBWE9Ma1VrN0N5TGR3QlhKZEFXdTNkKzNMVWxiVmprVFlnRStZY1RY?=
 =?utf-8?B?K2ZwSnBCTEN4a2ZFRmNRYzJVczJNM3Q3UEhpTE82SkwwcnVXMGgvc1U0T2p6?=
 =?utf-8?B?bnY1ZThyY1ZFU3h3aWc5QUtIOTZtWWNGZHpNNU9YV2xlemNGcktTcEhFTlBt?=
 =?utf-8?B?ZXplQmx0bUlYUEZvdFVnMGU3ZHo4Sk1kUGRhclhNaUVHZnd6VXUwQy9qR0hP?=
 =?utf-8?B?ZktqbVNzelZLdjFOTUExb3hJbDFlc0RnalJhQ2w3NG91dWg4bmowZlJiYzkr?=
 =?utf-8?B?cGxHT0Uxdkl5aHI1K1RMU1ZNbGV5bXBiemttaENVbEhONHpPTmtrNTZEV1hz?=
 =?utf-8?B?WitzTGQxRlhWRTlBTmVESkltM1RJV3NRazlSdW9mYkRQZGxUQnZtS3V3MzM5?=
 =?utf-8?B?aGlwUUhpclBMYWIvQXA4UTU0WDZSWkNuWUxwbkdWVm1oL2M1RGlVSExFZHU1?=
 =?utf-8?B?Vi9oTHRmdGZ1azBoWnRlb2o0aTNVTVF1YndDb3FOMkowWko5VGlVZWlRTk43?=
 =?utf-8?B?OWdNR1RWUWQ5bSs5aVBUZFJlVE56R054NzdqMXFmTlRoTUQzWHF5bkE0bmZs?=
 =?utf-8?B?YzBsbithNE9EZjNLQ2lZOWNSQVdCdGxMVlYycGNWTXhOVGRxL25EY3kvU0F4?=
 =?utf-8?B?VjhOM3pFekhRckNqaUlzOGRuUVhKUlZHMFhLbTkxeXVPL0M0ck1BdiszRjZC?=
 =?utf-8?B?Ni9hb3dFZjlMcHlDZTY5V1ZVUXlIUitkeDhLYm5EUWY4Ti91RmYrbWN5TU1w?=
 =?utf-8?B?bkJYVit3dnlGQ3VaNTBJVnp0c3JaUWcxSEhUUi90NGpGRFdFNFc3NXJ6bHU0?=
 =?utf-8?B?L0lHQjBwaXNFdG5aeURkeE5FdFhDTmlTN05IMjhRRjlqRU5EMTJ0bzYxekNs?=
 =?utf-8?B?alVoVXlnb2k4TWZQeVlJQkxwRzlpMkFESElEZklKNGU0ODVxSk0ydXJ2Qk9Y?=
 =?utf-8?B?UTdKcERQZW1DNkRQYWswWkM5ZGhJSmdRZlZ2NEN0eGZRUzMyTUEzS1lDY3R5?=
 =?utf-8?B?SXVtWVltNzhELzlCRnkvdzJQVVVwYzQ5K2RPbW1teHhLVmdSM1M0ZWR3M05l?=
 =?utf-8?B?dXNNVjlXSzVYNWNtZjU2Y2gweE9JLzhSNVMvek5wakUrOHgxMEdzY1VGczF0?=
 =?utf-8?B?a0ZCUHRTeVdhYzdwbTVsQWoyZmJSRGpQZDBvV3Fwc1VJVE93SU43Znl1dis5?=
 =?utf-8?B?UzltaGduREhvb3ZpanB3SksxcG42aE5VdzUxajhMaCtXU2VoZ3ZKQ0tCcko2?=
 =?utf-8?B?TGEzWnlOb3gzV3B5aDJKemdjdURwVHE2elZwd2lIK2R2Vk9FWFc1bm5WdzIx?=
 =?utf-8?B?eWJZUTZOVFJicURyWHdBNVJVSkZYV3FiazdVN2Q2L3M4WW5iT2tTVHYwSzFh?=
 =?utf-8?Q?vVaf4pXSPOKSzCXre2fukYGy52Gc9+C0V1SRl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae4406c-882a-4c99-102f-08deec16e707
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:40:24.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlPbUgdVyA4A3xDeO/yICWxABLGyDwGyqZlVqA9n8+oC0jYn6YpXPcXVPaqB7+ALrhvA5QzkkGAUe0rBFROyf0ZZ2M34oGEukKIoQuJGJzJG0T/FLMxEFnZCjcvfmfeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7572

From: Frank Li <Frank.Li@nxp.com>


On Thu, 18 Jun 2026 17:20:57 +0800, hongxing.zhu@oss.nxp.com wrote:
> Based on the following patch-set[1] issued by Mani.
> Add support for resetting the Root Port for i.MX PCIe to enable link recovery.
> 
> [1] [PATCH v8 0/5] PCI: Add support for resetting the Root Ports in a platform specific way
> 
> PCIe links can go down due to various unexpected circumstances. This patch series
> adds root port reset support for link recovery on i.MX PCIe controllers when the
> optional "intr" interrupt is present.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: imx95: Add dma, intr, aer and pme interrupts for PCIe
      commit: eba4724641990bd9975ca10ababe726b6143f0b6

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
