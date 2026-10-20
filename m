Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792480866;
	b=L//fo7Tl12uMB0RpWV1to834CrbU1s+nE3Y6djz9WsUjejRRJAzmKwMY7S3YwkDZ1i/P
	 DAdFiJqjy5CNQxLdvXGHkcCUTHyF+NCxm5r2nOps/VY4nxPNLWp3blPe3hb2r+A7IPlfw
	 8hXYBOVJ9j5w7s5SEMEjMGnz1330AcujP+60eObUpGLGTPQQTpTgZyuhiJr+Iogzab1tY
	 2RxfkVf7XS8SaGQBZai6BIop/r3h/R5X9HtG0BZ2sMgnYoJy+BM+JykbHLp+DERPgyPMP
	 SquOs5e+pDcJ4R81nkNaIPGSzS5bnpVT9ooj6ItVqIS0IxXxcQrgVugawM62eWM8CPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480866;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=G/UdPE85iztkxLoLbaUn3jkfERgqjNxc7fwVNf24qRE=;
	b=DoRMa9DpCNdgMWOdT93ZXBhEVouLJ+AcmwLV14NSm9lUcU3LUAenVUrbBF8S9IqKGWUp
	 trjF0cuWMfBmjQE6Nmy0Y3lpye+FkCfCiIHuCKfDTqYJJij3+H7VnQIsXzV+cT9FCatpZ
	 9RlGdRvWVAJt4qtApSn2mqdplRm2G7f29eIyHoqpVr5vgu+Jc9gGaLZ/XNExZaW6XH/fc
	 LgHk3Gh0PdW7y9Trv7QPQReUHwjYyZMY7esOaQSd3ni9e8l6zDQx2/J7UHE1Uns13BJVH
	 dhYVaJ+e31p9ngd2RX2y/hxKK0R5C/sSJb1WG/QORd98+MCPho9YbfTNMTNgzIKFujw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="l6cHKPm/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.101
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020101.outbound.protection.outlook.com [52.101.228.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D59606A31C;
	Tue, 20 Oct 2026 07:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D59606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=l6cHKPm/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHPYya3GGM2x/lGb3rz3DwNK3GYEeO8Y/lIoK5gJ8nsKpYmBeQJXIhUsaD4DsocObWqPEwtC+9JcwjstfMEIUTbQHUuxIb5J2Isa+mF01x+h1V/Ie6OYkX+xZDC6OSJk7W/iBbk5s/owsjRYxXvmf8qAPsuV6footeD9/3EOZIf8pGu//sAfbHJ/uzx8eaZxPUTehhwnPUs2+w2DbYNaxGLsXApmCl+Ayu2zCPz63wanfuTkekOMW4NqfjRkV2KlWP5tHXMAfl219009HKmmA2zoHXOsOJGEA0E7KCtLDVtnpLOWT+lKNhB8SXaW1rbUnLf/vSZcYp9R88EQyLZawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/UdPE85iztkxLoLbaUn3jkfERgqjNxc7fwVNf24qRE=;
 b=oJK51fFWLS7F+xfxVDO7ucNSdE5KpmZbjiUtBHeIT5MJBDlCf1GRB2IUsAqFVWxq3CKwxOQYSZsv2YN9rSLKTdqbdZhPVsj3Ahg0nolY8mTHZqh2vXDveysVdr1SEiRy73Fp+w9QaCG3fWdGGe13KAW2q32TNbVhzBJKgeuFuC+Gp25i5uyy3xDidYqg1BsP4aNN7JfHAhklKYp8bSNuNXCwnOmUe+nLJFrZnUuKpYXzgCC1WmudWMx1L7Xn21nalXkKSAHlQUeDAqIEpEnkFmZMRj7Vg5o0pTqu9MFwheswqG//okIH2NA+ED7axPctXTPcG4zVneyASH1ppYp+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/UdPE85iztkxLoLbaUn3jkfERgqjNxc7fwVNf24qRE=;
 b=l6cHKPm/rIsJcSHKfnwaSsx5LcS56bqD2xAyc+OOLTw0VvZYVCQMhJYP4spdYKhsKdRamrH9RyG4ncCurwFfz/rr/VsgS9FJUujnGvw9aycV+Xhi3G1FssdlqfeiZT8lfDHbsY1AO8tAxBWBgiQf9/o+8xQInAQZErPgu+WKu6Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB8018.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 07:21:03 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 07:21:03 +0000
Date: Tue, 20 Oct 2026 16:21:00 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/17] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
Message-ID: <h44swpyuxytt4htvyq2ighz6gqjozn3hcllbaf37ropstnxl5b@hydn6jfdes4l>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-11-den@valinux.co.jp>
 <5f982595-f3b1-4d64-8b14-ad38dac2b3a1@rock-chips.com>
 <ghdrvrjbozm32y3o5m5vw6tl4l2tcep4ok4i6vtcvgbsbnb662@7katihdy32nl>
 <55944278-6103-48e9-a664-c423a3a1ac7d@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55944278-6103-48e9-a664-c423a3a1ac7d@rock-chips.com>
X-ClientProxiedBy: JH0PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY6P286MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 58709208-873f-48e1-06c9-08df2e7ab2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|10070799003|18002099003|22082099003|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	28zPf6zWEXnAt6sIaCXjjYiVj8GYLrtyQif1mLuYl+zQKrIIqTovGynlmlCDG2PKBlAf6a+JLr2wckBoudIl9GKX6t5uatFFSbnBKWzbsLjyMRiQEuP/1Rtcgo1ANn7LF0iN0abEg/11/fRkOnQuv4ciy9tzHgS8C9pCWVuza7DWpO8xnD+wTRKaNwgRihpHFwQddeORBmy7xwK4LL0d6J0iO8fr/DgWnByND9Eh+ipMNl8P/5K0EuW9XdviAb4cPaIHF2k3cUfnm3N2kGaREx/cyKDotBZB8MQTsqiF0+0ZH/WHY0MmJd/NLjvS0gvyOHMN5HNhvsm5LXsgh7lgJM6Nl26NxbEsWgV7MUyw6MShGAhlrmBQROAwWsdz6Mqanvs76VLKrsx+RJOkXvgAx8DYyK4b9m+SzZvrTfgoHWnI3V9r7OvVjiu032HNG+8gz3i8LRhuYTGCgRkaLMXVw6CKSDzdpTWJPZnsaIcuu+RblK+ZfRaH8VlN/jL423JYH1nJaBu0xsMCgZC6REP1bIbmNhBt+PbwuN87ECYSA6FxpYlxffs4mnkKu7a3UK2FQV0n5Kn52Fk9dtFRKopI4rfnqUe4DKMAtOxHggDkzglIL3Na62mf/ZlWxsqNyLWNDsvcvx0dAN7z6RUamjVM9veC59AjHm9djr+GS8w37x8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10070799003)(18002099003)(22082099003)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2tsYWVjM1IzTnhpSGkyM1Y2dlNGUldDbWswSW1RbEcrdXRtd0R3aElJVjl3?=
 =?utf-8?B?eHBUTTkyb1hNZkpJNWhoS3RDWmx4RytUOXcyc3Z5Tlk3YnIvUmI4aXM2RUZi?=
 =?utf-8?B?TVJMZEtyNDdwUkxpWUxrZVNWNUlqN0U3Zm1ZWGNlbmNMN1RRcTNZdXc4VFY1?=
 =?utf-8?B?S2tlYVhPSWV3eW9ycEZBNDFPZVMrTGdWOUFPeEJ1aU9QMHlPQmtKeHRyN3No?=
 =?utf-8?B?YXI1Tkg5aWlnNTNPWmxVYU04T3lnNEFUaXpEeHRMWUJWYjg5WitBVDQwY2R4?=
 =?utf-8?B?WXRtbjlFckg5UWFjbThDMnlKbVNNb3dtNnpWT2NxQjh3MHVCYzR6SUQ2a3NQ?=
 =?utf-8?B?cldTWXgzZmNFS2pIZDNxS1ZyNzVieG0zdWVYa1N0VEhJOVY4dE1LRzducUVX?=
 =?utf-8?B?U1hqdmd6MDdDL1hMdlFzcXl4OE43THhNcXlLRVNOSG1VMTZDeFBMVTREbWVn?=
 =?utf-8?B?UDN2QlVZcklYNEpXNWFGd0RjVjUzMjJGMFZ1UDRLRUc5SVVMTXRWV0g5aGxz?=
 =?utf-8?B?cWxpQkJCcGV1aEUzSHFBWm5veE5UZWcrbFJqbkhhSkYwMEc5ZzNmdTFrODhm?=
 =?utf-8?B?bTYrMlR3UTQwR25nVFA5WGJKdGtCMC9DYXUrcUFEeFdIMm5uM0NPOGVUdUZG?=
 =?utf-8?B?dE1JdmlBOVJwRDkrcjBKd0pNZkloWVhhZjlBUmlwLzBGVnh6bDI4dTRDV2Fr?=
 =?utf-8?B?VEpML0pDUmpZMUtpbnFwTWxrM0s5cGl6SjU3MjlJYmtYa3EvbjRuS0hSTVJB?=
 =?utf-8?B?dFQ4em9EeFZXaEF6MXdaeU1tU3dDV3oxYXZua1pkZVllT0JYZDlhVFVBaVB3?=
 =?utf-8?B?aWVNUmVSNmRXUHhsRkpZUHhYL0plTHFZcE9YTzFxVnFuM0wrVXRMdXQwM0xr?=
 =?utf-8?B?eXdzalNHYzB5VUxrL1oxRzFFSXdzNUNCZXlJRlJTZTBlNlh6b1VkdzRUSTFt?=
 =?utf-8?B?bkZmaVQvU2lhK29LOFRVM0FpQ1hlWUMxd3M3b3hNd0VnTVgrbkpKOE9hZWRZ?=
 =?utf-8?B?UmZybVJYT0QwV1FuYkpYUG9XaDVHMC84N0t0ekF5emlzZkp0ZVRmdXN4V0E4?=
 =?utf-8?B?dEZQREJlNTZZYnFvcXVnaDRYZm8yWVd1Z3V0elJ3dGd3M1B4c2JzL0U3cEZy?=
 =?utf-8?B?dEFJd3VXQURlYmpaZHVOUkpuZmZzQWdaM2JNSkJHcXhleUFJcnZ3TitlUU5R?=
 =?utf-8?B?SjVXRExTdzZqbVFuaVpRWC9CdmI4blRsMFQrNmVkNlZtVURzU1hYOWkwa0ps?=
 =?utf-8?B?V0d0RnZ3bG12Y050elhIY1B4YWcrWXlxUDQ4S0VXTitrd2RIT3dYSXh0bDFV?=
 =?utf-8?B?TFVVVFV4TkdOMlN2Sis4ejc3M2VsY2hNOEVINCtJRE02NmMydU00elVQRFA4?=
 =?utf-8?B?bk1kM0tiYm1nSGVRVzRuUTByb2wvTWhTdUVkY3FFbDAzSHg3bGZ1bCtiaW5D?=
 =?utf-8?B?WmNJNG4yc2locWx4Tnc5bEJSQThHWTVPTXY0RjM2OUx3bkZXUlRXVW5BaXBG?=
 =?utf-8?B?SkpicUFVejJpUTkxQ2tNZVhHa2tLWlc0Y0E5TXlmUEVORjU2eU5wU3BlalFL?=
 =?utf-8?B?M2xCeUVITWpvc24zdkcyQXR5dm11RFpHcncvQnVHWW1vVXJoKzZXakZ1WTlM?=
 =?utf-8?B?Q0pjSnJnTUhmZm5FeHZUZ1JTUWswTXkvb0NROUtRM1Nlb0w3T3A3NzNReEps?=
 =?utf-8?B?MVkyUHJrdFNFZUlnTjR5UWM4TEI0bzU1a0J1ZHBiSEZnaHR2MnVPUTNLTjAy?=
 =?utf-8?B?Vnc2NVQ4NGU0YUhQSldrRnFtSEd1VVhacm1uaVdJb09nRGRZVDF3UisxRm1w?=
 =?utf-8?B?V3NGNm04SEYrUGJTTXpMZndCbENUVnk0VDNpZnhKaVM5MjZGblE4ZU16NHpH?=
 =?utf-8?B?YWdDYmxTZUJVRHNlUmtrWkQ2dms5NnpCZVRTVE9FeVJRODk4R3Z2VjYyb1F3?=
 =?utf-8?B?L0ppUld6YkJHd0VIVWdtWUxhaEVYS2g3YzZ4OU5EblBqZUN0SVcwcWQ1N0Jw?=
 =?utf-8?B?L0ZOOHl2OTV1SFc3ank4N0pvQUVWT3JDZ3hCbThlZ2c3dXkzbFJhOXA3dUtv?=
 =?utf-8?B?V2pQa2VJU0NmNzlUMnlVUURKcXY3NXVvRVR4eGdEQ1ovOGw0NXEyK2JGdFZP?=
 =?utf-8?B?UHRDOE9KQzRZeWs3cTV5L1YrbEZITWEwZ0VOb0FkeHptNzhDWEhaNmlsT0xj?=
 =?utf-8?B?dW9RcFdWbE1rLzIxUnhhcjgxMkJFVHFSblBZWE9jZDFKc0crQ1lVOWFqK3N0?=
 =?utf-8?B?RndHNm1LeVRRaVozT0o1Skc5WDk5WUF4ZzV5NDFNbEp0Qnllb3J3bHpMbDFs?=
 =?utf-8?B?OVpFZ3RKRjNFUGhGWVVTSXNlSzNXRXZtOWZGem41dUd0NGY5d0JTTlBHWVpn?=
 =?utf-8?Q?VJXoGnyHy+828p/C5Zm/CswST38dNWOqmrYpn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 58709208-873f-48e1-06c9-08df2e7ab2c9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:21:03.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85Ha5/GVAuNXyMKi1WmsUaDWLJAXLxLkxr4eBmYQ0qItLZ6188MThZPi/MLoji8ja0Q8HPwUF2skKSG1bPPo9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB8018

On Tue, Oct 20, 2026 at 03:00:36PM +0800, Shawn Lin wrote:
> 在 2026/10/20 星期二 14:41, Koichiro Den 写道:
> > On Tue, Oct 20, 2026 at 11:54:18AM +0800, Shawn Lin wrote:
> > > Hi Koichiro
> > > 
> > > 在 2026/10/20 星期二 11:10, Koichiro Den 写道:
> > > > dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
> > > > .deinit() callback. For a core-owned parent interrupt,
> > > > dw_pcie_free_msi() removes the chained handler right before the domain.
> > > > A glue driver that owns the parent interrupt and demultiplexes the MSIs
> > > > itself through dw_handle_msi_irq() can only stop its handler in
> > > > .deinit(), after the domain is gone, so a late interrupt can still
> > > > dispatch into the freed domain.
> > > > 
> > > 
> > > I think you need a rebase anyway since there are two patches touching
> > > MSI irq naming stuff in pci-tree's next branch and will probably
> > > show up in tommorow's linux-next.
> > 
> > Hi Shawn, thanks for the heads-up! And thanks for the review.
> > 
> > > 
> > > ...
> > > 
> > > > +static void dw_pcie_free_msi_domain(struct dw_pcie_rp *pp)
> > > > +{
> > > >    	irq_domain_remove(pp->irq_domain);
> > > > +	pp->irq_domain = NULL;
> > > > +}
> > > > +
> > > > +void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	dw_pcie_remove_msi_handlers(pp);
> > > > +	dw_pcie_free_msi_domain(pp);
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
> > > 
> > > 
> > > dw_pcie_free_msi() now calls freeing irq_domain unconditionally:
> > > 
> > > The problem is that pcie-qcom.c uses the ECAM init path, which does not
> > > go through dw_pcie_host_init(), and registers its own devres action,
> > > see:
> > > drivers/pci/controller/dwc/pcie-qcom.c:2034
> > >       return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
> > > 
> > > drivers/pci/controller/dwc/pcie-qcom.c:1995
> > >       static void qcom_pci_free_msi(void *ptr)
> > >       {
> > >              struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
> > > 
> > >              if (pp && pp->use_imsi_rx)
> > >                      dw_pcie_free_msi(pp);
> > >       }
> > > 
> > > This leads to the following sequence:
> > > 
> > >    1. dw_pcie_host_init() succeeds and pp->irq_domain is created;
> > >    2. the driver is removed or probe fails, dw_pcie_host_deinit() calls
> > >       dw_pcie_free_msi_domain() and sets pp->irq_domain to NULL;
> > >    3. the devres action qcom_pci_free_msi() still holds the same pp and
> > >       calls dw_pcie_free_msi(), which enters dw_pcie_free_msi_domain()
> > >       again;
> > 
> > I'm a bit confused. Steps 1 and 2 here seem to describe the regular DWC path,
> > but the devres action in step 3 looks like it's only registered in the
> > firmware-managed ECAM path. I don't see where that path would call
> > dw_pcie_host_deinit(). Am I missing something?
> > 
> 
> My apologies for any confusion my earlier response may have caused. I
> brought up qcom merely as an example of a driver managing the MSI IRQ
> lifecycle with its own devres action, with a remove path that can go
> through dw_pcie_host_deinit(). For such combinations the safe check I
> suggested would matter, I intended this as a defensive improvement, not
> necessarily implying a bug exists now.

Oh I see. I personally agree, and it's quite a cheap check, but I'm not sure
what the maintainers of this file think about defensive programming here.

+Cc: Mani

Mani, I'd appreciate your thoughts on this.

Thanks for the review!

Best regards,
Koichiro Den

> 
> > Best regards,
> > Koichiro Den
> > 
> > >    4. irq_domain_remove(NULL) dereferences a NULL pointer and the kernel
> > >       crashes.
> > > 
> > > 
> > > So I suggest you to add a safe check if (!pp->irq_domain) before doing
> > > that.
> > > 
> > > 
> > > > @@ -633,7 +643,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > >    	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
> > > >    	if (ret)
> > > > -		goto err_free_msi;
> > > > +		goto err_deinit_host;
> > > >    	/*
> > > >    	 * Allocate the resource for MSG TLP before programming the iATU
> > > > @@ -649,7 +659,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > >    	ret = dw_pcie_edma_detect(pci);
> > > >    	if (ret)
> > > > -		goto err_free_msi;
> > > > +		goto err_deinit_host;
> > > >    	ret = dw_pcie_setup_rc(pp);
> > > >    	if (ret)
> > > > @@ -686,14 +696,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > >    err_remove_edma:
> > > >    	dw_pcie_edma_remove(pci);
> > > > -err_free_msi:
> > > > -	if (pp->use_imsi_rx)
> > > > -		dw_pcie_free_msi(pp);
> > > > -
> > > >    err_deinit_host:
> > > > +	if (pp->use_imsi_rx && pp->irq_domain)
> > > > +		dw_pcie_remove_msi_handlers(pp);
> > > > +
> > > >    	if (pp->ops->deinit)
> > > >    		pp->ops->deinit(pp);
> > > > +	if (pp->use_imsi_rx && pp->irq_domain)
> > > > +		dw_pcie_free_msi_domain(pp);
> > > > +
> > > >    err_free_ecam:
> > > >    	if (pp->cfg)
> > > >    		pci_ecam_free(pp->cfg);
> > > > @@ -718,11 +730,14 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
> > > >    	dw_pcie_edma_remove(pci);
> > > >    	if (pp->use_imsi_rx)
> > > > -		dw_pcie_free_msi(pp);
> > > > +		dw_pcie_remove_msi_handlers(pp);
> > > >    	if (pp->ops->deinit)
> > > >    		pp->ops->deinit(pp);
> > > > +	if (pp->use_imsi_rx)
> > > > +		dw_pcie_free_msi_domain(pp);
> > > > +
> > > >    	if (pp->cfg)
> > > >    		pci_ecam_free(pp->cfg);
> > > >    }
> > > 
> > 
> 
