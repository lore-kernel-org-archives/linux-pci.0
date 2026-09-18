Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FF3A5E67;
	Fri, 18 Sep 2026 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724734; cv=fail; b=VBfnOlPgwCmBr0yDPLSzSUGk4Dqm9i7QKnjeDAxB3ajMztD2Co7oWIHcUnxR1l+KkvHwGh1Ze2Bnte03U5KuUnm5HiY5sTkaKq9FN8QPukUmcFZHKW+GCtB6SNDhJg0DDqfc+BE410wsJM9py5XeKbHrpDfQDyPcGwGEiWvR0qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724734; c=relaxed/simple;
	bh=CmYTuijUPwbZ0tOyiIoYZBKq5pxAcp0+hqtAWGUUF3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A0eNB1ApvjDra4JMi56F2CzJEVa0FBWvFt2w1JSVyBoupPadY6IjwkxG1ArF80LyKPbrmQ4ztNFPi9wCfOWm/zHRExXILdB8YnFrkmQ1l5ZblxlyzkNGrLy5zQCwpVrHZMdLbD54pQfx8FAP1QeNAFqSmKIIra2xaYh+r3IUq+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SIbisdFP; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SIbisdFP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tefWw6aEzOsz1a8ggS5RH/zWMaUUfhMGxsOM1dQ3z7e0TiX0m1VH49M0ztj118Zv9MN1R+x13ZN9It9ErGe2s/3isZSytJ6Wtinw35T7xYsnwis/vdWWk2o9uX/a6rBAAhWOYqBXoGIhQtWnNE1HsWg0LxHcAnM+kBTHs59UrUmYDXAq3gzMdxIeHAB7vcQxxeLKt0pSU9WXDBugRsSkCp7o98YgZclz4IPch0my6P7gl0fCNrKdfBfljhRSmtp+DzJRF/A1LZOrDAqBqKxMpUVR/Rbij8XerKfqxt6LFh5hGWToP7I+PSE0lI8lxbKvbxjAyN8gs6Ti7yggLCPrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/NhxfWPYhZYGTiyK+yy4m7aFDzKbGXnS4aPm3j9xfI=;
 b=FCAxXlAvZiYhrVYARWcdtTyAwfd7fEToPbYadksXvGQmRbQjud1M/sOHve/rfaue8WfJdixxaVvn+UYFC8OeEHodSlrAzM21m5SfOqz7rMebrNmKOvFIcbjbuIqB4ExuXRrznSQMRaINmzY1/DEc6Kz+VPLmukyhEKeHixN/x2V+avSvuT0wPx4Lx7RZgIfzPLoOAsagHLwpbHVvJj97H1Bf+Ub2kx4JCRMJVOwO2b3NMu8GJFHhHnNIsiaKUz7rCyCQ/29Xqb7sLpvKwnCDzpwvg+6CkFzDz2RynHUb4c1uoO0ROBRQKwVgopEi9RpW8vZKbp4EJYkIKR57QpmCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/NhxfWPYhZYGTiyK+yy4m7aFDzKbGXnS4aPm3j9xfI=;
 b=SIbisdFPgAWryLq6WpTJ8xWrVof0nsR7DF2QPH8ARO1BiaTX7RYSEtB5wXOatOOkyicOwSrRwSkCNEM9vS29ojAL4mCukVwJh47HfVNji9Syv3hFQb9u8Rd6DN7gO6PYxVkiV3dtaPUUykoSp5Wj8zP/soGmmcoBwzDI27IqKo46ki0N6IDYOK2q4Oup0mTrAXmc+LOzRRwxf05yAugYxEfqbSjnDQiaFfBnHVWS99jTHTH/Bh1RRy36clWRQHO8C/ZClDWx07CGYgAUXJdchvKdwRLjCk01e/8bJSBXFPVuz4erJFIVJmfsb6WumL7RiNle+mB94trzr/d4lGp8HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by GV4PR04MB11893.eurprd04.prod.outlook.com (2603:10a6:150:2eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 09:45:26 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 09:45:25 +0000
Date: Fri, 18 Sep 2026 17:48:08 +0800
From: Sherry Sun <sherry.sun@oss.nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Rahul Samana <rahul.samana@oss.qualcomm.com>, Wei Deng <wei.deng@oss.qualcomm.com>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/5] Rework M.2 Bluetooth instantiation using the
 auxiliary bus
Message-ID: <aq0IfMrMISvQUwbv@shlinux88>
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|GV4PR04MB11893:EE_
X-MS-Office365-Filtering-Correlation-Id: 757c3e92-7c8f-460d-ca27-08df156990ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|19092799006|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iepk4WcBxbXlf6+8VKYga2f1nnAOeNxugM69VdkJfEkewYR4nmZXr6Q1C6Yqucqc+gR6U9h4p2Q0Ve5MOZW+jBydeJuDIYCZRq5zDRJDDxSnlJ8L9mwLyw5jpyIZcbzSn5OuVAACZb5BQlxlgz9Gq/69xY8jNC44JNVYZuIFgz2jx6k/OtgBiHzhvlkGn2/IZX5w1QDnB7OFDqUKSXeM6rShxkIOj5H+sJGRAuOPZyoGrR83Nh6YUAzxkgPJLANa2hPEAWiOHjwATVG/z2Vew2fi4rCN0784wRKR/fwUrXwyOksXdaPx5xl9VIcBXUP1IwK+9xH3y3nnRmkQD2jqgLrBTBs2A+pJFUczFW6TdWcuM9CJb24HfdoF6byj44J110ryb6LyXV0bHzP2rAO2p5M4zcagkRZXhj22sGOaCAsovlWq4X6Z4d3iJkZyL+TUj9+GZH/TvZFfL37LA+laBNRWkEg1W7ddm2386OYjgiHujL3bTjfaX5vZGS0eZiYDRCprGIhi6bDMDa0tto0Kn1NixP5KjyyR+BjjGopBdRAV6FMydXUxJxF9fY6KXblHadStlNsKlhJOYJZ09Xw+f5k6OY3AA+g4S/RmokHgdnuI2Z3/0qG70YHsH85kmmo1xCCRKlxL31QvutcVoJoAr9a83mKryeMtzcBKSnmm4ZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(19092799006)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHRIMXVKa205d2RLc3RZVW16R1gxWW5VOTljVW15UW4xQVljMUNocE5nUUQr?=
 =?utf-8?B?eS8wN1pDai9EUmRBYngrOUQ1N2pjVXlHdUoxMHQ2YkJrelUxQU9YRGQ1MUdk?=
 =?utf-8?B?emRoamIrQjhEczE0SmxhQ2J3ZTVhMHp3R3RPTDdDenM5MDVXc2l0MXNIK3Zh?=
 =?utf-8?B?bXQyWEF3QzMzS0FTck1IdFMwSGVnaHV0eEdYSDA4eWFjeUY0d0pyS0NyUzhP?=
 =?utf-8?B?TVdjWm5OTEFPc0kwU3YzTk93MTRmeG13RU1YMTkzY0JoSXA1ZkpIa2xlY1A1?=
 =?utf-8?B?RTY0cGticHp3ZzFOVTVPS0UvUjZmZGE5eDIzZXkwTzZJS3phUjR1RnVUK01m?=
 =?utf-8?B?b3Vmd0lnRHEvVUdpejhaRCttVGhMam5FQUJiRlRoM1NadHV5MndOWndlTHUz?=
 =?utf-8?B?VDRqWkREVWw2UjVSY3prcm9tcDFjYkxlMTZpZy92akZMRnVJWXF0WGdVWU44?=
 =?utf-8?B?dkZGSXM4ZkRzeWhUQVhlelVWMHpjSm40Rk9aVFdVTGlibmUwR0x2SVo0RDdT?=
 =?utf-8?B?QzZ0VXJpREQ5cWNNMFZnSnpLVmRXMmZyUnBUU0JXbTF0ZFNramF4blpBampi?=
 =?utf-8?B?bjl2TDdabWpyQjA4MjFIZkhWOU51U3hRVFByUDEvL3ZHaEJrYTV6Q0VmNFQ5?=
 =?utf-8?B?djA3NzJGeEZUSEV4M1Vud3NvZTd5Y1JGRUhmNUZkK28xVldhazAvNk1lUThT?=
 =?utf-8?B?Zi9DTUtZQTlKaUhBNEh1Qlg1U05LVnRmWkRKYjczbm1sQWR5MlZ3OVJmU1VE?=
 =?utf-8?B?cy95K2NheUZ6eUhtNlhyQXBMMTRvM2FOdnQrcFFJQUJhbjNCSHFQU3BKNmYw?=
 =?utf-8?B?SG9EWDJmaTlwUzZMQ3Q1cmNNaS9uc1RPelZDQk5ZTnpzbXZEYUZ1aEorczZ5?=
 =?utf-8?B?RC9GVFFjZ1AxaWJhR3lmQ3FoMnFtaTFrV1loMmhmbmdkS0ZZcU12VmtGR3ZR?=
 =?utf-8?B?bjB0R1NqRERsK1VlUzFwdkllOFdxcDZCNkJ3TDh0ZG4zdzlFcWIyaGI5RG1W?=
 =?utf-8?B?NE1FRFIzcE5Ub29TOVFYWjBzNEVTWHhKY0pncDNaVFNsUEo0MjViSjFYOGlo?=
 =?utf-8?B?V1ltNVQzS1FkUFhaK1RVQmNGWGV5SEFpTmhyZE5iNnZXYkZja0F2OVlqNEtW?=
 =?utf-8?B?WVIxMDY0RXhaekwySS9NYVdUWkpvb1JCbkdvN1VLL2xDSG8zSmw3V1pnVnd0?=
 =?utf-8?B?RE5ZWWRXWGZuVGxWaE5GWEw3K0M2MUZ0UHMzSDBPM3F5ZGZxbUR4dHd4WEI4?=
 =?utf-8?B?NG82TGhnKzZMK280eGdKUnNZdUd1YmlyLzhCT3ZSVENlcmVFc3dFVlFkeFBX?=
 =?utf-8?B?V2s1MWo0MUtEamhFa3JKMkRkRGZOYTQ5MGdybnZJZkIyQWRldVBteVJBZkFl?=
 =?utf-8?B?RGZJMlRGVVppL0p2K0VReWVpeEg5YkpXRjlDbVNxUXV4WVpWbUZZdDlCWWJz?=
 =?utf-8?B?dVVuVDJEc2VkdUpTSVJFOW81Z2FmN2xJcFFXUHIzNWsxakowb3RhMUVSTkgr?=
 =?utf-8?B?b3J1eWZ3UUdUWnIreHpvQS9iOEJXZFJXcFVrVVFQenc3cmVENU10OTJDM3JP?=
 =?utf-8?B?V0c4V1hLS3NjQzUrQ2U4LzN1bTRORFRJOTJCQXpST2FXNkVhcnR3VUN5dXp1?=
 =?utf-8?B?S2dva3pwMVNjbmloeXhBNnh0T0FBWlA1NCtualk2M2YzZW9qTlI1R2xUeHlp?=
 =?utf-8?B?MUtvSnRKN25XYjRlTU1EUkVYT0hDQUVNV3Jmb3hNTHVqVUdrSmlJd1A4SHg3?=
 =?utf-8?B?K1JsR2Q2WlhEODJwcjNoQlZNUURJWGJoOGJPRklVZHZvTGN3L0lWZjJCUklO?=
 =?utf-8?B?NXFhSUdUZTlURm1SVHRlejBrVCtJTTFvc0tVcWMxZ282aGVaUTNabVhBZXlp?=
 =?utf-8?B?cEJzeHErTnlpajFNN1cyMlFDVHJVWUN0Mzc4TG1jWTdwNFNaN3FUUlV5VUlx?=
 =?utf-8?B?U3d3a0poclE2UVNHSG92Q2dsTmthdnE2cFprbE5nUHBCZmhjWk04SHZPRGJs?=
 =?utf-8?B?RUNHdEJGeEh1OFlWZjJWcG9rTHd4bVZ0VWF2VmNrczNGTFlKZks0cmVCVkZw?=
 =?utf-8?B?TFdnbVNNN3FNQ28zQzhjcExUQ0dRY3pLeE9WVXgxOUNzOFRVMnZsZVdzeGRH?=
 =?utf-8?B?Rk93WjFKWjRtVGphM3pFUzkvQ1JzWEJyTjkzdkRHZUZUT0NnYlRoMGlVb0hT?=
 =?utf-8?B?VVVCb0ZneG1OU3FmVUlqa3FyVTZ0MmhpaE93NU5ab2QrT25FOE05SjBuVzg3?=
 =?utf-8?B?UVd0Q0MzRHZkZlYxNUlMNUFsVVdpbGJZL2ZVMzZpTG92dGx3SWhoSnRRdFc4?=
 =?utf-8?B?R0thZVdBZ0Z6QzZEQ3FQVTdtVlROSU5KRHBBU0RDUGFVSWJxeks2dnV0VzNt?=
 =?utf-8?Q?PO46fl69R6v+SqUEUKBChLm56tehvZSud/C6L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757c3e92-7c8f-460d-ca27-08df156990ad
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:45:25.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNaaaIHHPwYR5p5cCTcEqOQPanJ+rQygQgyR1zox8eTs6qMV3bg2+f7wVwL7zmc3fmBOGxn4yQ7I9vs47f9guy7LJFSlsHdiLa9vbuqFPCpy9Rvm8FLrMAQLI2xvz4KJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11893

On Tue, Sep 15, 2026 at 04:24:01PM +0200, Manivannan Sadhasivam wrote:
>Hi,
>
>This series reworks the PCIe M.2 Bluetooth instantiation using the auxiliary
>bus.
>
>The Bluetooth interface of the QCA2066, WCN6855, WCN7850 and NXP 88W8987
>M.2 modules is accessed over UART, but the modules show up at runtime over
>PCIe and are not described in firmware like devicetree. To make the serdev
>bus match the Bluetooth driver, the power sequencing driver was creating a
>devicetree node at runtime using an of_changeset. But, creating a node just for
>driver matching is not recommended as per Krzysztof [1].
>
>So this series reworks the instantiation to use the auxiliary bus instead. The
>power sequencing driver still allocates the UART serdev, but now hands it over
>through an auxiliary device along with the power sequencing target. So this
>series adds auxiliary driver support to hci_qca and btnxpuart drivers binding to
>this device and brings up the controller over the existing UART transport.
>Finally, it drops the serdev based M.2 code from both BT drivers.
>
>Dependency
>==========
>
>This series depends on Monza series from Loic [2] and reuses its
>pwrseq_is_controllable() API.
>
>[1] https://lore.kernel.org/linux-pci/768142f0-2638-41f3-a34f-dc80bb99eb7f@kernel.org
>[2] https://lore.kernel.org/all/20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com
>

For the NXP 88W8987 M.2 module related changes:
Tested-by: Sherry Sun <sherry.sun@nxp.com>

Best Regards
Sherry Sun

>Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>---
>Manivannan Sadhasivam (5):
>      Bluetooth: hci_qca: Add auxiliary driver for PCIe M.2 modules
>      Bluetooth: btnxpuart: Add auxiliary driver for PCIe M.2 modules
>      power: sequencing: pcie-m2: Create auxiliary device for the M.2 BT interface
>      Bluetooth: hci_qca: Drop serdev based M.2 power sequencing code
>      Bluetooth: btnxpuart: Drop serdev based M.2 power sequencing code
>
> MAINTAINERS                               |   1 +
> drivers/bluetooth/Kconfig                 |   2 +
> drivers/bluetooth/btnxpuart.c             | 193 +++++++++++++++++++-----------
> drivers/bluetooth/hci_qca.c               | 138 +++++++++++++++------
> drivers/power/sequencing/Kconfig          |   2 +-
> drivers/power/sequencing/pwrseq-pcie-m2.c | 137 +++++++++++----------
> include/linux/pwrseq/pcie-m2-bt.h         |  38 ++++++
> 7 files changed, 343 insertions(+), 168 deletions(-)
>---
>base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
>change-id: 20260806-pci-m2-bt-rework-78dc2c926f00
>prerequisite-message-id: 20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com
>prerequisite-patch-id: c4e777757ca9358cc4dd35e23738cd7dc1ead1a0
>prerequisite-patch-id: 09600595c2e80b12eda3aae39af192847d0f03d0
>prerequisite-patch-id: afe88432c4d459e9094c0e6dd31ebeab6c9f2f08
>prerequisite-patch-id: 60fd7b13447ccad7546fa8e5b5609d8f133f788f
>prerequisite-patch-id: 61dcbe55fdb6f33a3229c197f16a678785aa16d8
>prerequisite-patch-id: 14099e5c573d7c41b899c3f9bb9126aa23f1553e
>prerequisite-patch-id: 647ee15b77671054b4bb012afa9ba8694b6c86c5
>prerequisite-patch-id: c3a774cae81a6fad287731a38f1b76c7e8babc4c
>prerequisite-patch-id: 18b0fa62060a1a2c96e76051944d692699035572
>prerequisite-patch-id: df02ab167976ac1f0d5a38c78e559a7372b16c1f
>prerequisite-patch-id: 3f2dddd108677252a539cdb1eb661912836289ca
>
>Best regards,
>--
>மணிவண்ணன் சதாசிவம்
>
