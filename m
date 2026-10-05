Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020084.outbound.protection.outlook.com [52.101.229.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B1214A84;
	Mon,  5 Oct 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220181; cv=fail; b=m0EHLwOPKsIAgPjZfvpZS/CKS6c67t74nBUOBi5f6WaJd9l2UaTxO/GPkDwnXph2iBbM047/QlxCZoDZ/RDbwBUycVb/uJv2KJVjA58BjAMnvLgUdGlHvHI/VM/xWrbF9ZpGTl2vxNvQpsOj48gy0eGZqQH+ynNOJiV/02jdnVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220181; c=relaxed/simple;
	bh=Xxgyzn0fVPBXIqbwsa5qZRrEJhvrQib6ceHKqivNb08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TlZiwQq/WWLH1h58ifnt91dAAl0l9jloSsTdUzlNMYFpjHyJ8/BdSbctrK6g55NlH423ZbxYrobAwhxOPjzZMulxDsiG13xtg8GMjDP4/vnV+MME6eUw0StzbjkHMzSRCClQDQTSNlw5d+IQx2RcKVA5gcy4oNv8AQ9uxfIgsb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YQG6W+qY; arc=fail smtp.client-ip=52.101.229.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YQG6W+qY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af7Ul7Jr4lJvI9X2++ND5bSjKg/kf/1kO1o/gGrlSZzPY8q7CYjHESDf2vAOLxpSCOfFUk43LLVaMrr3d1a5DE+C2jH10rtjIPvC6z4gPZVgMrPRDEKxmiDP9A6KoDMlhx/ci1RRwEEeQAJD9RzxpnUp4i0vMly2n07NFnMy9XaaVyr/ctvQVIvWd/rmpPF773KCnDQK5oglyy/I5n9HbXMBV5lVCx68FYp6cVGRHkulBx+L/QxwQDnX73G41wJRPviiTiWQeP7cpQLZmtIJAHMoLY4co3Utko5XFnzVvydF7gBKvRY9WKvMarB4yZAZ3PNGzNsiM8FmrmRpjyxK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvogN+cZgD0Ut7uGrC+sD1CHQA5FkhCUaTuoOpiDxDs=;
 b=SrMu3reqX4acksy5Sdu5eaPX6Kupn0IqP5jwqEKt6Xjf2mBQTOYJkbe5bOJzjsf6yBJL/NlTwg/1FInJ2KuW3FHGBabhGuAAYc1ZQYNH0eEm7N0ZkBttlBPU7wwkPSYJVVRmGmsyTPzUZ9TCCRR6TvIJjZxCqbXNsQNSlDmRDB+JBHmt45269TPDEOBlsbPcAnQM+B4MvnEj2jteg3WNMVGVgdXnevgrhThvSpHF+LaSxO61JbsfKpGXJu4F5fYHeOZKOzzlrwL4G4SOktw+wepLuRe7SymKDHkdlDbwAqKHGiGKOBHFFYlWzyI0rBbdH3QiEcrrMRFftt11Kw6MYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvogN+cZgD0Ut7uGrC+sD1CHQA5FkhCUaTuoOpiDxDs=;
 b=YQG6W+qYIFFNLmGIKlRMKdBVU63lR85jRxgJooWi7Q6H13OkuT/clOCse8MKAVzc81FJ138L4Bee5kF74zyvg7yfUuu1sZWwocvz9IMWWR7OP+R/GXwawswXSM4fbpFMlXC2Ii/XExTp9xnmO+Eo5gcnP3ZkCyXjxSyO4OnGFbc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB5578.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:18a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 17:09:36 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:09:36 +0000
Date: Tue, 6 Oct 2026 02:09:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] PCI: rcar-gen4: Route Root Port PME and
 bandwidth notifications
Message-ID: <b2hq2ucxaksk4rbq772kmb2zexuu5c5dtp7jpxl6bcxavhr3ux@exkiplvch3vi>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-15-den@valinux.co.jp>
 <9035b113-c53c-40a0-906f-0fe280d7d762@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9035b113-c53c-40a0-906f-0fe280d7d762@mailbox.org>
X-ClientProxiedBy: TY6P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5770a4-ee62-43ec-7ebc-08df23036ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S0503SHkHt8XXDfsJt+xR9KjOOmnm765TOt246Er/V/t0butZ8H2QlApHlCpcxcBQexUF1PBotbaFluBvobT+D+/2NFALck9kOwcdxYEiZxsslOVESlBCSg6JtLkCFcl9WBBB3Sh4w5lcyNp031OJ7mf8zjwLzUF97dJGwHAGBQ7hcYQg8YVGEdiGO2lfnuwz7/xk4WtV+CAr+euwXjJirXLP9tN/kSj0M/y9fpv5UOxccuQGYwRkxh3aHa5xftGHv3BpNAWuPxfe+nxbMKcS3W+cjFmJtcUnxmsmuRexlX9xTL1UavBUf5b9YkH6vG/YKMPPXsB3sZ0rZZ5Dd+8/z4WCJR6TWp8q4qIGO5xbA/Dk0LozdNkUle0lswoZGQVOgiCWFG0vix+2215a498wrl2lETCWnIBk4vKALKFMVMqsZZIPfIXb5o8h+qFqkYBKvpL5Kcs0PwoXiJKZhV+JIfrQU7XYU+6zHjwLDyRxjBWkx6k2+PPq2DpizsmBj/IsswmuL1JKubYk1khtd3iwIziiGT+GaUILfNBbG1B0ydYWx2T6KE5LA+6utORstFAbGHwBfiDO5Y35vfeOtJ6ZRQEeeSz2zOo9jWYHDW9WdO9G9tW3PAafmqDQxk9sLJJpCC3ZhgShcBLYLmne0fQj1YlZohLxjX+tiFjSboUT0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s+06w5XflzXlyKiVisqFKWPGO51j1cu0A0Mp3HAlf5CMoBNi5KCHG6D0mIoe?=
 =?us-ascii?Q?0s9T52nT8UbQPfAzfWlyvIt7GTZUZKyOBV2jfQKWpaFlS7Izd4ztsq4jqnSH?=
 =?us-ascii?Q?Asv7vbY5jP2YGMOz4z3X3ESYPgmI5h+WxmHKzQ5w4URcUjLukc070WP2gzHb?=
 =?us-ascii?Q?+dyBKkXySUoFihrDn5QoawO4AiizsvnuKVqCDYKAv0s0zsVz7iLUTIhhhekt?=
 =?us-ascii?Q?yQdwYMfeW6nw6hYEOfa4Y1qV0EWe1BsN90hJkphUSfqVm/3Id85ZqqGEhx3O?=
 =?us-ascii?Q?UPLNPUWOd6ABSTDSSUmLNFEifkVGHmgTRJMB6M9sYFTUDVT7dSSDgj3jipPP?=
 =?us-ascii?Q?fGCT3CnZQ/+uKVk1SqGtw5w1lg2Jm3StunsF/71MSjvGBB2M/5U2fzUCJf/k?=
 =?us-ascii?Q?hkuNHUo2ZKzZ4d5AaiF6PsGG7lsPDQ9aoj88TA/0MH5kuHIhyHgA+1TcXlvj?=
 =?us-ascii?Q?0LHLXFTKBBV2eABBIb+wyrt5U/YTNS0EODfvg4ubOGzS97HImCGp05amYyAJ?=
 =?us-ascii?Q?VPVxx+Q2CuUZF4y6CY2pElvIVDIZmkQEKDqSgmSfjFI/IaoBHInIsKWo8fn8?=
 =?us-ascii?Q?+4gXvSonPf+dnwi53S1NsZN3vBmALjIkZ0ejJBzWphk9KI7/TkZwtPXlPfFM?=
 =?us-ascii?Q?czwiC14W9ld4xFx44XtzMgnqT2Js4mloB92wQlvVsrBMh+A74bYFFBJwIECL?=
 =?us-ascii?Q?ECGBEf02uTqKzChxrf3nfnEBGFUIHZnuYGKTc8hUxvyEf6LmpJgIlRyo+OUM?=
 =?us-ascii?Q?UEIPLfum4w1tzoGEbJLzSBtHJeGWqr9gvPGbgUWQhcHDr0OUGGqikHCYtIyw?=
 =?us-ascii?Q?eTXrlMpaRSK4AQr1OnVQ7Qgu3h2lBvALFCdBdldahrHeUa45Vgsrbx94Mb1m?=
 =?us-ascii?Q?CCpm5kTxxJO0mXIxVPw915PPMKeYbyRPrvLbc9bMKfWQy/pDh0riu5XewscZ?=
 =?us-ascii?Q?etqSAvFNnEhaqsyIi9hMak/6v+cAoEfQU6Azw5WobnHPzM71JNFPGZd9nMUO?=
 =?us-ascii?Q?AQEwkjSZSsJ8ddYoxslyr08dRVBMFZWGAdE46I08WeSRW5YajtmG3AefXNSR?=
 =?us-ascii?Q?46/rPrZ3gi38pEkP8T39q5kTSsJLhSzbQ/6OHbzPsgpBIXJ6eQiOwUIMXKXo?=
 =?us-ascii?Q?6WyKvM1XDRAmOanujL2gpEwpa0nN/cjOGzfZ2v6chQvrTDV0cAL+yJZqHc4s?=
 =?us-ascii?Q?eHgJE7K9YyV5ZIISHOhBIB+xNgvFive3OGcl0dKPLZBOzBLtLZRrq0dmp7/N?=
 =?us-ascii?Q?ZxBC/wXSr02DDwr7Exe2JVOG9c85TLKkQ4oL388cpDlNgZmoLdkEwVPmI+wO?=
 =?us-ascii?Q?hNWhWLglTLjvxj9Tz9Yb07nxbelnJqK9PuttIYgEVAc0T4Y7byDAXjsvp1K4?=
 =?us-ascii?Q?+PtqYetWnxl9KbPqSp7i0BZgtq5xuM5EwJL4vlt4H7sAWhChJZ02YfOL6BYk?=
 =?us-ascii?Q?pdGbrlZfaphyytj2QU9EyCL1DQ8j1+SIaPJHdlwo1QOape+xE6VnJOo2lSCY?=
 =?us-ascii?Q?OU8+Z5uW0tDReNODwisH4+7TsNwVX4bOcQEr0BWOfdeFP03Q5R81l/nonIFP?=
 =?us-ascii?Q?XUCcnsOEom2qPf0iPCPC3y26/65O3ry6x3C+eQ3I38DMry/RyY8i9HiPvVi/?=
 =?us-ascii?Q?D4FVZl13ePCUtt/HiiGkqmIGc7lJPZFE7k8DUydHM7pFihIGzZQ9H3T7zFuk?=
 =?us-ascii?Q?251kPpTUFb+3Q3ZrP1x8QwGyMUZMTo4WbPJ+7JIlYlR9o1W8hJIl/TNdQLmf?=
 =?us-ascii?Q?W++7x1c8hU0j1nLYUCYM2EkSL6Km+qTt2SGsgEbSkps0RztHbT7p?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5770a4-ee62-43ec-7ebc-08df23036ec9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 17:09:36.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FPZXwBHg0aL89V4ONe/CrlHqvaZ5/R39WjNh4Fz1Yuv1BbkgfoXim1N8gmloy6xfbSFrxZvBcOhdPFTzQYGBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5578

On Sun, Oct 04, 2026 at 06:40:20AM +0200, Marek Vasut wrote:
> On 9/28/26 6:52 PM, Koichiro Den wrote:
> 
> [...]
> 
> > @@ -753,12 +766,12 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
> >   	status = readl(rcar->base + PCIEINTSTS0) &
> >   		 readl(rcar->base + PCIEINTSTS0EN);
> > -	if (!(status & MSI_CTRL_INT))
> > -		return IRQ_NONE;
> > +	if (status & MSI_CTRL_INT)
> > +		dw_handle_msi_irq(&rcar->dw.pp);
> > +	if (status & RP_SUB_MASK)
> > +		rcar_gen4_pcie_rp_irq_dispatch(rcar);
> > -	dw_handle_msi_irq(&rcar->dw.pp);
> > -
> > -	return IRQ_HANDLED;
> > +	return status & (MSI_CTRL_INT | RP_SUB_MASK) ? IRQ_HANDLED : IRQ_NONE;
> 
> Only a small nitpick, please don't use the ternary operator, readability
> suffers, please do:
> 
> "
> if (status & (MSI_CTRL_INT | RP_SUB_MASK))
>   return IRQ_HANDLED;
> 
> return IRQ_NONE;
> "

Will update in v3. Thanks for the review!

Best regards,
Koichiro Den

> 
> with that fixed,
> 
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thank you !
