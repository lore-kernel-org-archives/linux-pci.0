Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08581862;
	Mon, 29 Jun 2026 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760047; cv=fail; b=h2BPQnFW/ecT3Q4AbAekhXvIJjYd2WF0bX91zLtWP14iIu+YKjJjGnNBIGOO+3damWODGAcM2FR1aEnfssD91foSCJBwUoKv7PxHXMD+DGtN59C0selcMb3CSo96/4qIFEXnJXj5sCQzxYiUCxlTUhJZrjvrx9R+k91lBkEKzIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760047; c=relaxed/simple;
	bh=fp2TWLWB949YbaVBxdfqdR+59V8iJ38OXHsDfP6GYqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nCmBX74O6WT+XzglhZI67fWHyN8UrlVRN30lRTosdTaL5KWQ290raZ612L+7ENd0tgfKisTgUBWWympZ8BO2OmW635GzTMl6rQxncQxVCD+oC0/CsaXuphDf1fVHwVM6cDyCos9TsCcQULZHMDS5gnnT3+tLXCZEB7YwgyCdl2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lVD7/Qoj; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lVD7/Qoj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4robPzXWMe5QwX/4gq8fzl6POZWwZ7Rz3hquzC6wJ9DZdXl1WSx42T1JYO3LsaCDBCaS9FZH5EG2k/Oh8Nro5Krj1GhA10lZDB7lhgMTx6CCfS5zsikh228tu80kMlDOu5PA6H7DMWmhEcR4I5SDc16QpQsmja6LE07gqJz9w/2qHzfSle6E/OwKsdXz0wRKWwdf3XV08WJzOGfh9i1jQ3oLMZyPEI43a1nhRJo7deeSD/L31RHjlJ4FzTGXibfTGsCJvw0McRt9Sgj2h+DhvL7pk5ag627kLQNtwoxUjR0GB+Fy4omdgPBzCr3/VKNzWiM4yUVgR7MfBEPcE/mRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjCY7dve9ERHmw7JYe/xgQTS7jrBzuo0v6sKVVaO/dI=;
 b=A4eON1ZMbnpQnoAI9NMtVAcP25fP8V4XbSg0RQC570G5OxunZUz5G5G5o6X/BZdH6EUk6n7C0+2lOwJzide5WIiLyV6zMwRJEgPYLRY9frqtKvZlRP17u8ymB7R5RjQdQISwKAuSjt6ZfAC2kbNQ2vTjYFRg5aMOmLgrSk7tIHo5qcUlP09gLEDEtE5nHWhGbf173JoiBGx0Vgkm3fvILRegENOyf+gNaJCI3oyN75o/KXe1jFfK5ibBCwJ3X9u8BjKpugSvSlSmU23CmxSDSlOPh3/ZForD0qXGM0sAV2U6tjjIohei8DmPowiUci55UdinPVTVYYikGs+OR5DYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjCY7dve9ERHmw7JYe/xgQTS7jrBzuo0v6sKVVaO/dI=;
 b=lVD7/QojO/ZYP3u773+7xJ1ps/cxM4+vZxi87cc3I1jq55869a0STelH+CgJmGowXgNBG0am9q1QHXlkcyFe4fFn33lJaEghv9WUb/GDO/RaqmZKny+VJhsLVKEyUFkEyK+cOE6PEkA0y8fvrssWfEvcnGp//iL25muZTsuNbH6/dSKNCcbZyxaGQHLYXS/K0VUEcKxkWpGmeZUUv1ARPiMVXQ3eIE4HQGROHTll+cWD0eLc8TAkC82zr008qMfnpYIvkD9LDLa38qWI+FLnfae1UoO7jxwe6WnnaUizRajua1qnS6ZBOegtkCKCJt6w6u8DA8t+6Ninbg+OKGF9aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 19:07:23 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 29 Jun 2026
 19:07:23 +0000
Date: Mon, 29 Jun 2026 15:07:15 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: (subset) [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and
 update device trees
Message-ID: <akLCY21tQ6o-f43V@lizhi-Precision-Tower-5810>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
 <178274988899.2274593.17371952702316181859.b4-ty@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178274988899.2274593.17371952702316181859.b4-ty@b4>
X-ClientProxiedBy: SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f2ff88-cdef-4ee6-0c01-08ded611a6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|366016|23010399003|4143699003|18002099003|11063799006|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	cmwxDWSJJGdwa5AKxsP+tWsDlY8wssx6nzGfIYvTjliM3GgPyreiMgzd2p/MI+EM4+mqfDN4rNKq9YckaH4aKO/IOOENmWZpfziYsIUE8+1Be4i/NmWZ99P2CVjoaXzm14OWMaBEC5x9aWcIEBe/XZYnMbOvkpGRuVublkLlBSpKNdSqFiKYXzAtO4E1bk9sMv363xcesao4GZdxUoXeQ0hsisJG256+GnB1SP/SvJ6U3YMN3GcJsmWfyzAyJXtRE4sJroRYjaV2QZYdx4sd2x96Wr0n0ZKfJK+87qLHRPL6PwZXcvpMR+EgsztPhJnfx22faJnQF/WRBDrN2F13Se9be7JRE+aZaNJcOz1aN+NMpGXSFrhC/Go6DTls701EqDjk4eYyxDH+KY4d6yYRvnUhe0YtWoDfG78FSZE5b1sWFf5hBVZc3yD0HE/AjDXmBWZ82iJCL2cXfTkeUEmM7ItmboEMY0VgGyywAF1UPC9C6AEHoB/dTltANOP5XJmC7l71xKqYnhO3VZJ22r2/nETPbfJUNzfT/p7iVXU07GZjemV0BYs3QKDoTJStlyY2Sz/WFSG3kW39wvXfMZ39h6GRyevEjxP2iTizhHfmdCMJikor9aks7RBkbO3QXYAk7q5jca/XaCcwKoj54SyEnhakP4jng6cH++uTMBsDmff1h6OubyL1kfDioeSC9zdnK2Tp5MQSccFewipzmHhxMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(23010399003)(4143699003)(18002099003)(11063799006)(22082099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YL1qHUkfdx2JR1Ex5Js0nvGVhl3l3gKiPUpvTdM3h+bhwhf4ZXAm3zgg7z2c?=
 =?us-ascii?Q?9YDQE8CIwS76fsuT1bQIyKa/6lU0JKWzbn3jkbBiPTxU1jplDrqRvVbO/9m3?=
 =?us-ascii?Q?B8vnxUzxSN4D2r8GW0cbcZ7sxS1aI0GjIoMS1bpXnY2Rjb5u1MA6RoxwzJYY?=
 =?us-ascii?Q?srAWNZjMuKW7o05fEcxeLykv0ndwhS6q4P4+zaO0pzvvkCjOowx8gzeCxYGW?=
 =?us-ascii?Q?BTkLKfJjHjjJ3PPWxvCtQrUVFUlEQX/cUrwln9Xk+72z4ipFfi2/YT1XQsdI?=
 =?us-ascii?Q?QtneFUKSZwf9G0UkbWT9Pw+2fnShCkH7CJZ4a7bv/W7Z88ew4bVqab8DhUsc?=
 =?us-ascii?Q?eyJ9sNfiSs0luseLRITVnNNvAH6rgmJVqkCEJM0+CjOhm+5Hf2QPtG1qrO/3?=
 =?us-ascii?Q?X0C1+sXHLDQ0zX9oJyhRGQS72ZhB9G2gYMe3bdm034kw9aQSUxflEvqUGgCU?=
 =?us-ascii?Q?+NVr9j55hKQevuk1xFKiFF5Hdj3gs0hGrZ6LO3CpvXfRUjk2wWiQpOOJnjFU?=
 =?us-ascii?Q?MemuH4In0oB/LiLgLYbZnByL8JQ50e/zwzu2llp4OJKrKIWSMkLBCiQhpVPO?=
 =?us-ascii?Q?mjgqFu5rJFFiU0FXwFdjCY/OXw4fSoEDgor4IIwEvXhSIW+89s4glz0/3ltg?=
 =?us-ascii?Q?Hjb8RPkm5tjFpOzjT4MABTzSbds8MaLwpyyD/YbAdPYbESrZLjzQcdR9UsAX?=
 =?us-ascii?Q?PLg4XFK2rwRWtngsKayPVtDyOGKnh97Zc4NOhvysdP6wrQJ5Iqcx2vegC9Sl?=
 =?us-ascii?Q?pp6KGEqXBDG7hGEMf6g5QHg5jWOXmoKLmASiyEmC2uPEZ/mOM7pjYp4552xQ?=
 =?us-ascii?Q?g+yNVR7Pha8oO9U0uYP+3R/Ld9CfBAyCxYm9fSS7BeSAtTndHXeXeKZfY+PV?=
 =?us-ascii?Q?SQIqdaEB+6T7flAUBlnjU/kDHevd94ma/vXS9MKDTmUn5kQK3gioPhqxHdft?=
 =?us-ascii?Q?jNIkiZoNN9DK4dOYLCUU2n8F/KIkOxbmahxIbr1QuDEbJ0YyGjppYqrrZKHH?=
 =?us-ascii?Q?6odj6rZegN7DoxX94iF2bapp5M2ayVE/RvqRUYB8wbkbsOy6cZ1FDaEi1lmR?=
 =?us-ascii?Q?RgjIsYSVdc6ToOqTmSKG9TIIbxqGZBdFxv8cjD4A/ebmnvi15Gidvax+GETk?=
 =?us-ascii?Q?y2HVGCLJsL+FaQJAOWRPE7cbSaqwvK2hXf8ltOR82F40QCdQr9sStSUjnDBJ?=
 =?us-ascii?Q?Fvso/XJyt23HNS0LY1Kij3KfSZ5bL7BGbQ50XYkDg1/hqK04LH0r8DSuga6F?=
 =?us-ascii?Q?Ek8sIqEYdhHo5xgmFApAPp7cumk5HDT3mhd2CINzQ/fXXYzepvKHzyPpAR8S?=
 =?us-ascii?Q?jWQprTLvXGTwm356j4ueEUaICyuje3Qqjd+ylOHIJZPWiUT8UmmGkWSTeL5Y?=
 =?us-ascii?Q?caQCLHsGsAyllczwjdO7jXSA/y/Y96eYSj3xvJBTwPJvb+gNlGCidD1jU1LC?=
 =?us-ascii?Q?4/qn34yteLloPs37vpIVjXeStwr3K/sr8E4eItVSTCslziOEwA06onVzuOlu?=
 =?us-ascii?Q?Ig6aukrg4OwDS8AiQfsAw4ay4tcvUsD5ZS+tfLbGP0QY8gTxP/tTnu47CmeL?=
 =?us-ascii?Q?tb07QvTnJIlpeQtqQoQjPUEhBUYFijonjRwj3pSKBTv+nYM02WOU2YZjOxvX?=
 =?us-ascii?Q?IaORqurBnaMYLJc9jk0k3Ej92WEljHWI1C4L+r0ED7U1hNj1OgFOkEB8ZL5p?=
 =?us-ascii?Q?ZVRU6om/msgw5H+qGQq+0kRtiOoDTV0Fcc1FRvSAQQaqaTxJ5JYlhnrV4FzU?=
 =?us-ascii?Q?g9w1WsDfOYfAab0qDKgjr+0cXMG6T8Mcu6EMa6aiTKlm2u7MxL6+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f2ff88-cdef-4ee6-0c01-08ded611a6a2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 19:07:23.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 981uYMIca1YPDjLL2DEuPe94oXwUG70RUWVSw34mQH73uAgbi0Vxk+541HJ0V/4eXoPutLYcpoc+bNZjyQuBXAqk1CIbv6nzDkypTUBtC3eus/wReB6GQGeiKUrM/Gly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329

On Mon, Jun 29, 2026 at 12:18:15PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
>
> On Wed, 20 May 2026 16:48:56 +0800, Sherry Sun (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > This series integrates the PCI pwrctrl framework into the pci-imx6
> > driver and updates i.MX EVK board device trees to support it.
> >
> > Patches 2-8 update device trees for i.MX EVK boards which maintained
> > by NXP to move power supply properties from the PCIe controller node
> > to the Root Port child node, which is required for pwrctrl framework.
> > Affected boards:
> > - i.MX6Q/DL SABRESD
> > - i.MX6SX SDB
> > - i.MX8MM EVK
> > - i.MX8MP EVK
> > - i.MX8MQ EVK
> > - i.MX8DXL/QM/QXP EVK
> > - i.MX95 15x15/19x19 EVK
> >
> > [...]
>
> Applied, thanks!
>
> [2/8] arm: dts: imx6qdl-sabresd: Move power supply property to Root Port node
>       commit: 6ae623838bba6b1d7dab2164bd12a166eae670b7
> [3/8] arm: dts: imx6sx-sdb: Move power supply property to Root Port node
>       commit: 090ca78c5f5b8b475d51d729a7b79c5b7d8bbc47

Patches dropped since CHECK_DTBS warnings.

Frank

>
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
