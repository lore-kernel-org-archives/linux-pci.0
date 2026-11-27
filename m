Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795742869;
	b=AtF5peKf18tMW5/3bXonkmMIxxjA1Gpe2296VdqTekgBBUkeVo6PPP75yyN/oR3xV++y
	 01yUVTAUhJWEf0NejbZA4ZejHj7xv4ROGLcRu4lT7iVA+vjJLIUxQtDuatrIcYCYC5Sw3
	 eRGkFqyYQSHCz+xlkSfMLoljK49eIIh9zjZUGZhimsirHbeJRZR+6dnZot1KH3g+KgGbc
	 eo8isk/OhNrYCK0GuiVmR6wXICC/dT/7eHZk+UglBvQCA7STGHPrWZFVQsgVVzY0wx/MY
	 OzxF936Yk6z70txwwvyPwq933S6getxSFESHwy0wru3hFgVmy49lOPs5p5NQ3eS0etw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742869;
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
	bh=bltdQNYERjH7fKGmtsBOHrZrKEMZiiVHn7iqxPe1wx0=;
	b=OBX6KLFtlNgLpHyPN4t3ngcW0GlpgFRxEM9UyeMGUC1Np2ybJITP0z1sQDx+kRZaxwRE
	 VWZXts6RPtBL9qUf6t1QJ3W2HTPvGRxTnIqShADuRqr0wcqUMdHy9GVvxZW7v+vBLAML2
	 ydCHjOu6GWRoASPtJMR1EQ6FD2rEf22r/HTyS71vGFFhzHbj0O4nbANka3AfYqDlDGkHb
	 9UqTkoTeG7rXplFyM6wtM/WKJvv+gdFDHX/apxVdI/Omofo1pbtirU2Jzy2t55d/MTiP9
	 fAmirPNrnh4AhN7d5BTJMZmNuHNvloC9f7ZqmoDg7weZSlyyG6measZvLLuZtEKiFOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="uug2zap/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.139
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021139.outbound.protection.outlook.com [40.107.74.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BF606A31E;
	Fri, 27 Nov 2026 01:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 853BF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=uug2zap/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P29D3AVak22Y76dCiRsfPfb4oL0YKd+0J9pTkHC6b0NvP965eneUYJK9YLQ/RI723lt1jMGbs4Tbqv9SG8p89Pt9Rl9HMbbzSh8x///yTzbBbcwdaPafjAIFm9So8w2MotZl4bCplV54FTEjaR9q2ZADPGIjZ/ssXKxngYL/nePTEpeNO7Txf4GaLkhkAyzFrrjDjIdMHST58iu8Vzqsg40HXXHBBqQ19kmZcRXoSqftF98LAQVOmkU3TVOGWRDUKE9CRD6o3nHILx2rrao4nSiqWWY6pDWgo7ZQRbzrn6F1uFnPNnzwbMT/qv6MJUOdfYAoeJohp/WNbZ7oDK0luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bltdQNYERjH7fKGmtsBOHrZrKEMZiiVHn7iqxPe1wx0=;
 b=eMAy1jJZGBKxWjklsOuYKwqZjUt8K9MMB8lGn5Yrn9j6FM5Pf6mVYJByy0boZFPJYpOWvo/rgd7lMNhjpB8HAbKL6HXCVd+LJOhXaUsHZ06tdmruP7AHi55KRiCPebr7zFIXqCf5jalfVW3e3I7wxibCTPwt38Du4Vo9d8HryePrx5H2KTYE9CW1ZmFYbf703I9Rq8jTTu9iViBD1sS4LeHjN6u+994VmmJM8p3SCsg1lWAhnRlKREm3URWJMvqI59z9Z/OEIZsjrbwZU5cYNGUrtixINPKSfli5DpHRqVWmDSQHgUlWbF+Gpp41HdMLM24NamH50WnRjYG71icllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bltdQNYERjH7fKGmtsBOHrZrKEMZiiVHn7iqxPe1wx0=;
 b=uug2zap/eyr3WIrXBQJtcufL6ghZB0mZiDoE6jvbly5aR2iUTsoRyqzpaGchM1lnVqOrJgnZ0kswMrXbzdI1jCl1JX8f5vJIKlyJ8jUZWqvNpCwviXVKJmlpFzkcPZ+4fadQoylQ+QJf94bInbonhKbNu0RI/hgMWKT+gxC04BU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB7639.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 01:27:45 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 01:27:45 +0000
Date: Fri, 27 Nov 2026 10:27:43 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <Shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/17] arm64: dts: renesas: r8a779h0: Describe the
 PCIe AER interrupt
Message-ID: <awjZ_w_nwgPD3Jes@z790sl>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-18-den@valinux.co.jp>
 <CAMuHMdWk9pZdJ+eh0dNHrZSMVDe84_rsvmrD=pC1Fjy9wEyp1Q@mail.gmail.com>
 <awhXFPlyc3vnmjtC@z790sl>
 <awi1WNQZ8jEGLQaS@shikoro>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awi1WNQZ8jEGLQaS@shikoro>
X-ClientProxiedBy: TYCPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 439291a8-de6a-4741-f765-08df4c25a396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|261009223027099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	13vV/ABk27SC2xXPlrDvaU9Tv7xGVWUz2/Vw0vBMFLW0YjY3aGQjZAkOu9ImqzmXlyz+0xLoRR8IybnhkSfsHSEvOFG8HgP2e8WZosuXs4LHoGN9a7TO39+u7gel2AO4+f6YTaq0IGAgLBC7SQSEh7fG1YF+L8HKYSZ4p0p4wmqd1X4zJkpqMuyhnix0cj5N6BC5sONt9figNxRiWnzQOJKWlYwIqFguUh8nHUbt9350edRhabLzRruEMxb/3mmsrvRHTs3tvdXGJV7lFxwQ/dHwuHERFGkbCNFXNkEmcJYmjrc1/7ZuKE4G1XN+w2VCYBh6qUVpGAv3B6ixaoNnvlOp3K3Q1yP/TlYc4RxE5nhG4Adw13vBNXfbpyor4ZEOwq16L4cY2d0i5WXYpfZqqv1k7Hf+xCmnvrUfmU1yphEPfsSpdlPHw5/wJFHqw/GbvDfXZUsxImeouOn0eq1svZlorERbdkwBtLXpdmbt6ffaCjbLShUwFBe3Zb4Mbxyx1uxPMlVwTie4pxx0x6Vsepm+KO6vRj8glN+YaF5HAY3n8yxQq+UuOINugrUsOHTFKvIwDFzSUfxsfRwp3wizG1r4oKdyTHLUu3QX9G0fwMn1iWSu47ZmLJQ6yvjul0q3reS4K+7BzH0utnLV+EDL/2UfaY5TjrTdIftD5SFS9AE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(261009223027099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?famZDMlIm1XmK6xlI2eX9RRaOSchCYrg1lcfLL/HnioXShQDEozzoAaX2DQF?=
 =?us-ascii?Q?hlDnCF1ghZjTqsej9SXRBqGbZOsg5em8eBIYN6EZtge09k1sD9FjBiYuYs1Y?=
 =?us-ascii?Q?06Otll64Q/g/YjZbDbzY47JlVzLvn1UVYPG+K6mwxkQ6n8nA4cmjTwV7N1Ix?=
 =?us-ascii?Q?J6q7X1sgPHoUkp3dGKNNhA5kBbNsrP85P66dlVrVvRxhLGB3OdTPC9AmPxtz?=
 =?us-ascii?Q?CW9IjvGmZSHF8TF4K+JCDal81KVthYkx6ez3UuP7hyN6ewolj2KHRNzyOL9o?=
 =?us-ascii?Q?96vYMXIa1I50fafVCUvBqB9cnMpaL+bCZ79r2bNCI5MmCQG3rb472A8+UKEh?=
 =?us-ascii?Q?rHUfOrbQRfM8QwB/5RBR7Qo9VLa6vTlmX2vAZNOiRGKrVm+iSCNIujEW7xbB?=
 =?us-ascii?Q?ELDCAlWgI+Hn1bRa25nfoCuQigiklUCNNPPtoz/BKgjwAGmSvsSsUxbMoBt+?=
 =?us-ascii?Q?T4OCkcZAgEhf/x3oR46Dg1fDp35OU7/QPpQkIxo6RnreUatFpMgbZsWivmOI?=
 =?us-ascii?Q?IGXe6VeBb6yt5uMbVBV8gZdg6thG+gT660S+ah96C7SMv4RlSmbC9cfYsb2N?=
 =?us-ascii?Q?b2fVnJd5cPvdaFrIcOtkKXXOF0tWamDquIrEc39urpS9x6mFIvHOxcDoYYI4?=
 =?us-ascii?Q?762I/VNQXmOO4GsK4iVDqslIjSTa1zcpScXnfJSIo9WFZLMCmW80IscTwijQ?=
 =?us-ascii?Q?I6fNDQ31d/5Rxqp3OMo+1MVd6ONrZiVkOwSe3ol7E1bqXMkev+YaEkDCl8aK?=
 =?us-ascii?Q?1q+k3zxfeRXdGSgWwsD0hT2fLKst7vqevVcbcgMZ4nMZbZqePA66ASxv+DSZ?=
 =?us-ascii?Q?kQPgzi8xxHtRYeBXCouyg8gt7lAAKGtD8TPplICSs+izeFra9AO42Nbl8vzr?=
 =?us-ascii?Q?NpzbnC0+cz9FrH+5uFwkbjBcvZ56q41w2O+Pd6dQHp3QeEUvjTUIpTHAXTfh?=
 =?us-ascii?Q?FwEIPKdgwCekkw8V8TmKa4Az5ikDc7NXKhNq375cGe7BBQ2gNNncGTiSFafs?=
 =?us-ascii?Q?uy7rSurU5TTpL7lUaVdtHcf1TcQppfOT/xv+5ssmn6QoKQRUEdipZ+2Mx6P+?=
 =?us-ascii?Q?oJXX4WBq0HNBD22AUaBJuLfvDhf13w771q+21VnA0vosKlsYnqwou4Ln0tIz?=
 =?us-ascii?Q?IFW6qfwJANYTlQ33/mzIXPglQwPTHjpRcPPnTB4tFcXxQmiJUJJF90TZ5NbV?=
 =?us-ascii?Q?fHSO4zTDAQprn+YG5w4uBv5fh3sEtOgLFVXDHnUYu6YngJhn9JKFJBYSLA8H?=
 =?us-ascii?Q?ryaAKnU4ZBF1G6dvZAd8K6PasAY+LXHTIgh0a7MtGdbhpRHD8rMANzXIh0yU?=
 =?us-ascii?Q?7GYgTuz+8SkY5dQPBl740ZlF//dWcCL6wkk36yFGE0j53cUZ8znujFpj6kVE?=
 =?us-ascii?Q?D4kS7H+nlw0EdTWgnoWrpYe4bGW9iHn36cYUHOfIUgsQgVsnPLGCZapWSw/S?=
 =?us-ascii?Q?ZKppwZbTUB0NxSEXzPUepGAj8WV2bYni7t848l30SvzzGfI4OeXqiBLkcCDL?=
 =?us-ascii?Q?CxwmMLhTT7wiiyGdji6sR/Fxr6NDiGN3OQHe16I4xlMyaGnlbYtdAofcnJuc?=
 =?us-ascii?Q?4WsHvjPsb/AbF9wwsE7QJujT8ULHJ1LkzcDJ/N0u2HoPtPZWsyEwf3BKnxne?=
 =?us-ascii?Q?yHbdYYT57i0N+fEiN/O3E+gj6JF8Vx3gyynoqgzNFGWmgB7JvSdC73Y3ftv8?=
 =?us-ascii?Q?d6aKQVGVAXhv1ZIBM43NVZo3PJtGj9qK7aiRbC4nqOPHGQYDP0EUMi4bA69X?=
 =?us-ascii?Q?fguvA74boEgJTXZxosRWPGSWEL00lyNk+NKCZWkUn7lxE9Q57lpA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 439291a8-de6a-4741-f765-08df4c25a396
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 01:27:45.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n9ljAD6RsBJVPlOf42ZwtrO+1Lq1EZyOPXhfjrBFt5MWZ0JBAQ+0M/PrsoGnhL05p83u9NofGLamgsuemvY6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7639

On Thu, Nov 26, 2026 at 11:40:28PM +0100, Wolfram Sang wrote:
> Hi Koichiro Den-san,
> 
> > Mani, mind if I ask whether the series still in your review queue (it looks so
> > on patchwork [1]), or whether there's no hope of it landing for some reason?
> 
> You added more people to CC and got no response. Maybe it is time to
> send out v6 now? Maybe this will get attention then... sometimes it is
> easier to talk over code.

Thanks. That sounds reasonable. I'll send v6 shortly. (TBH I already have a
local draft)
All the prereqs are in controller/dwc-rcar-gen4 now, so I'll rebase v6 onto that
branch. That should make the patch set easier to pick up.

Best regards,
Koichiro Den

> 
> Happy hacking,
> 
>    Wolfram
> 


