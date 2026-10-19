Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021080.outbound.protection.outlook.com [40.107.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA43876B7;
	Mon, 19 Oct 2026 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378877; cv=fail; b=DHPeifaE7XdjaMuuRy7HbySosaPT5XvtJkfv/JV6WwUOf5R/JfqKrPDhwldzIrmHKMm41KkEYu5Ws8sFYY6gMYmYwQ8ooEiG2UuVt4bvgulBL0BQDiGPcOmYWbwEzBL2hgo7CspJurrmAomFIhVV4jzsCNeUdoEvbr7rgnjTRN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378877; c=relaxed/simple;
	bh=2YRrBn80mHY6WWMHIouoxYQ5g+WZObZvaIbRdXbJh5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I4Yak6hHRLIvkBjIJwDymmY6F1a8wVYX2JMJQwBj+27acTLqQsYq36cJmZmSQFfniS6cbc822/2rJe/q1fP5/38JZpeSo9HGOuIo3a3SyYtmja8DHXUOaZedcz7R8OoMZ2ORGul/FtTvCX7Ur5eBI5sribgPiTzs51c7c7QHiB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cs+XQat0; arc=fail smtp.client-ip=40.107.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cs+XQat0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTWu387rnkbdXtjmsLBQSobAQ/VHgxFD/3U2iF2KQ/oGweyDNFKwgqOoJE9YyScd8rWd31MzAiYKU9Efk2z+kdzXx2WX5ZNDYzz9zGRxdRoOmZYhtMVrc04G3juTsxfzsvdVUDItu/2f6SCkbB1n/gYpDZrUaRFnh29d1y8ML6fJjbeGBsZl8MsvtpH54rbXReXam4cRtB04vsUvVbnAtIsRAtKoUofW9Bm9yG9xa9zrdyaWTBTNWjfCCkYWNLcACggi7dKwpUpQj6wu6Q4lX8SFDtqFlRfhoJ6sDJdj/Y951vpzPuxuYJytAFzkBdAsgRjqMB2Cvg//1rXOBViarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhaBHqbdoYFQoullv2RCUzQDEyccekqlaK/3YCzeWf0=;
 b=EZL3RBm6/mKhFHVb7bdpFbUKowBxsNX+RSwyFuIyVnKWI71gTHHN6qGpxPkSqp6+WihTRKEY1NzSCQ8Ys3+UKAcH9TJ4kYd/gVmL9ghf78uahRbzzRCqnCa7TBuFA02a1r5YrZOdfRYIwAL4+BarzMAYdf32jh54dVUT2EHehcm4ZpcvDpFqze/395vmgvc0jD3GbOWe5WTpWU46rS4Hvak2Zav8Hvr/TzB8ltDKB8Xl1bwhxPL6l+O25MjtXgsofR4Unbr/Y1Albk1x87+BOPJOMFG332rDiazdHMjs9cAI7A9RK7ZYAH27NE00Alqxy4Jo/I9wPEM0BHmie4iCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhaBHqbdoYFQoullv2RCUzQDEyccekqlaK/3YCzeWf0=;
 b=cs+XQat0otgiBQkpujfNH6g2WUVSGwhPWgHQp/VPcoRLCAvW2Nymh9s3Y/CEznTTlb6tIbW/LhmyXufS+KCtCb9hkMxJBN5GDL+vITxwH0LKMXhVRqKbnD570Upf5jHNzguuiJmNgc4mnpK8iuVfQjkTCdB6viilahXR6Myn5uw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB1785.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 03:01:12 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 03:01:12 +0000
Date: Mon, 19 Oct 2026 12:01:10 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/18] PCI: rcar-gen4: Add Root Port reset support
Message-ID: <57zypillvon2jsw6ayckcuyhkhmv5kehh7rpxox33dzg2lfkqt@4zqkgpwxob7b>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-10-den@valinux.co.jp>
 <072cccd1-8fd4-41e5-a64c-3cc4dc0dee07@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072cccd1-8fd4-41e5-a64c-3cc4dc0dee07@mailbox.org>
X-ClientProxiedBy: TY4P301CA0101.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB1785:EE_
X-MS-Office365-Filtering-Correlation-Id: e91d792f-a651-4676-9975-08df2d8d3b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|4143699003|5023799004|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ws6PaugekGbisAC0Qi9Apg1zlUWtFuBcYW6MspqRtGoj/EaDX3KUOnfMQND5U4FSREvsYERKlHNRfsqWYlVvtpgZPULV/CNwCvr1pV8nNUScYlKj1JV7Ohi7Rcn1MNakwiUhRoGzhdGPmPoDanKBhhRGsMgKOa1h9CSWouBhH/XecHQ/acWRdddJLYidmIO0eomJtAYoj3ZF3nJaCAfvaifmvVHCNzgehPj5s/+JEhLUVg74xFtT2jqQO6YqJtxpaT1USyLzbAVOWKbFUD4nLR4hlGHGn3IhfWmqVYvtJeKhBh6XvkD9giHsGruTCPyiBVGU3PcO8grVRxX6BTMCO5mhd45RD/j+tBMfOIL8Km638dE/LlNdOc9ZfpflaGBEP6FPgrNEgfUpgLi6iLb/JMo7EFFFUrIBrU/lEduRFDti+/0XfMiDay+yivOuj48SuRd0RN/pMTf5tfHyoiOCrDcjZsG/MaSfl5umIE8nqypfS9xDA0JquSJGYnjNTX/51VylaXsAXJCN9FgDDI/bUNW8K9zbHhZtPAAT70EGyyeFHPA1VCEFvSHFnAQhSQdw5wLKPRvV6zVTHICrqUdkVMWLtUyHhUzyf9kX8FS/IZzOlphIH4Gor0tzJ0znOZb5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(4143699003)(5023799004)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zk9u/vNigN1MVrKMPqjkuib1BWS/o4TA0wQtY5qW55MfFbnULru8QoKzJw7d?=
 =?us-ascii?Q?ecJORbFNiQTlAht4X8Y1yusp7PQOybVSjirCaUYra0Ylzucl1AMsyo+aw0HV?=
 =?us-ascii?Q?uDjRyntmDNCZKhEKlsCoixB8HvfZ+8kLdxouU2VSFDQjugfq4gJFV2blDcas?=
 =?us-ascii?Q?0jb4MxBdu5hVh6T9f2GI342si9KbWZf0hIrMfxgCEzYL4md9jnyU2R9b0wkS?=
 =?us-ascii?Q?l0gFpypLMHEviiBGt1YkhVgPHp12ETWLxxS8Ga9rWDek44w3vQlzM5E6t/5c?=
 =?us-ascii?Q?kl63uXSTurok07aFSRk/9wJhRCo790j75RDdYPkOYYppatWH0a/XL9O2ds7H?=
 =?us-ascii?Q?3BZOB0WtNiAbOdo1K/eBlONDsJ6WWKSy6Tg8HE54w5AwJNFKgk8k0OrROjVr?=
 =?us-ascii?Q?49Vd61bp8io+KkHC2Z5CujQLaJWf9yQOLkalGHrhOpp0VX2r3YCkln4WbAtZ?=
 =?us-ascii?Q?EWIDA21msVRps2GF+ucsYc4/N1YXJQWHD8bHnIKJmGHPAEVuLo+kU4flwwgj?=
 =?us-ascii?Q?8oeLis/EC2jm9gYYdhhvglx8/1b8hYzATh524WcBb32rgr515MSaRXEJ+EjC?=
 =?us-ascii?Q?mhxxmf77ORAabgp6nYEPsjy39SvFFVHe2K3fdVYDrxF42T53ogo0IR9SRFLA?=
 =?us-ascii?Q?LlDkFjTeDVYaOKXzehmeXRWU5ksXZJlESEeezbKBXUT9rb2l3bKjpeXGghuV?=
 =?us-ascii?Q?Y9j/DH4zTTYO4ZsUhWXbdOPsRXGE0C4gOg+9zxVEF0mC2hdP3wvwx0D5gK65?=
 =?us-ascii?Q?NSHvmKO6VU6JJJ39dRLNxpI8AKBHAvczWw54FEqYgp+35sz+uosxQQzDwJI9?=
 =?us-ascii?Q?+GmsB9usBBmERsud85caDMeFZ1z5rFK/uhX/XJPtTCopfVstifKWs8iiActy?=
 =?us-ascii?Q?4tDwJQnhQ1CXla3GxR0KVJv0smbBkZs+kbauyG92jHVIa26mLgZJiRkG6svF?=
 =?us-ascii?Q?un8Tg9xB+PZSaVaYJVGTvhT6Zo+TbQaMSiTkn4CrF4Cy+LfwuqQM8p0CmQmu?=
 =?us-ascii?Q?Pb0WM9Dl+ZemvEOctwctvbEPMCpJNbHRGz0+Pu5HUKhCtrE2wiFB3I0T9Gfr?=
 =?us-ascii?Q?KVsVITRAkTb/h/JgSwvFVn7tRSSyQnNt42sT3Cx4BhbufPD04WYcPJ+Vs4k+?=
 =?us-ascii?Q?OHWsj5Pki3vM4416YqtniwfBAvxrcBybvKlT26IgTwtCWjM+b7//vfdct5/p?=
 =?us-ascii?Q?DMP2+M8Z8J7GncL4f501DtpJU+6e+dXh8GozFFdmQfQuwx/grsUay7sBUxZR?=
 =?us-ascii?Q?3VqKIqfp6sEv0WPhu7CHgZdz9jQ7mIQg2JMoEY+21E2Ew4EkbDzizX6+SdqX?=
 =?us-ascii?Q?9VzFd5mOKN+Wn4nXKpDGOyeWDg0nm1fGQpo4PaYV0EgrMBBMX87nRcB0w+WH?=
 =?us-ascii?Q?LiqPSRHyKORCt/uTden89QXW/T+r43MadjZRxQ8Ib9EzSOkxAm7/9o+Cwkyq?=
 =?us-ascii?Q?u8x6sp9xw2Gu87YbcthM7bUQeX7aGDZG94V9ELossCCng9IPr/8nlbIM0d9f?=
 =?us-ascii?Q?SqQ8ucrFPucucZQQZsmR4ZvrPBcrM3PJ0bbSqHfuwl9UYkhFXEfv6Ov3zakK?=
 =?us-ascii?Q?z3NKdKESB/dynqMJDQAmTAa/Z0qpWmguFvn2FSG2VTOBSWRdMTUREYIkn3aM?=
 =?us-ascii?Q?Ht51etahKJe53PpEYaXbk3LDgQoQGUK4FStsttD4IQbjOhSHwft9sIiDiovh?=
 =?us-ascii?Q?pOXskS7bHZvokj7ow+97JzaMGiwQXZKVTBIbXoktfAjSOt+yQ2DIh2lqdwDF?=
 =?us-ascii?Q?9Gn1o40gunmWufLZQs6Dmu0sjnLGzp7zf0vMJwhBiCZUe28S9Ave?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e91d792f-a651-4676-9975-08df2d8d3b73
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 03:01:12.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBYE6sbsfnj8A4BvrtVoxq2PcUgOo1C2Do8Ghl4wHfQ7vXY/cTHDTZ1aOdfMr8XrI2cG0b9yiMvOlUiiqrtq9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1785

On Sat, Oct 17, 2026 at 02:46:32PM +0200, Marek Vasut wrote:
> On 10/15/26 5:30 AM, Koichiro Den wrote:
> 
> [...]
> 
> > +static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
> > +{
> > +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> > +
> > +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
> > +}
> > +
> >   static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
> >   {
> >   	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> >   	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > +	unsigned long flags;
> >   	u32 val;
> >   	int ret;
> > @@ -543,12 +589,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
> >   	}
> >   	/* Configure MSI interrupt signal */
> > -	val = readl(rcar->base + PCIEINTSTS0EN);
> > -	if (pci_msi_enabled())
> > -		val |= MSI_CTRL_INT;
> > -	else
> > -		val &= ~MSI_CTRL_INT;
> > -	writel(val, rcar->base + PCIEINTSTS0EN);
> > +	rcar_gen4_pcie_app_irq_sync(rcar);
> >   	return 0;
> > @@ -563,9 +604,11 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
> >   	writel(0, rcar->base + AXIINTCCONT);
> >   	/* Deconfigure MSI interrupt signal */
> > +	raw_spin_lock_irqsave(&rcar->app_lock, flags);
> 
> This is only a small nitpick. I wonder if you could use the same
> scoped_guard() {} call here instead of the raw_spin_lock_irqsave() and
> raw_spin_unlock_irqrestore() pair?
> 
> scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
> 
> >   	val = readl(rcar->base + PCIEINTSTS0EN);
> >   	val &= ~MSI_CTRL_INT;
> >   	writel(val, rcar->base + PCIEINTSTS0EN);
> 
> }

Yeah, actually I've been always wondering whether to ask you and the other
maintainers about the guard/scoped_guard policy in this driver, or PCI
contreoller drivers more broadly. I'm not aware of any documented PCI-specific
policy, while netdev as an example, has some guidance on this.

In v2, Sashiko flagged the mix of goto-based cleanup and guard():
https://lore.kernel.org/r/20260928170317.B0B331F000FF@smtp.kernel.org/
so I switched that part to explicit locking in v3/v4.

Would you consider an explicit scoped_guard() block (instead of guard()) at the
end of the function OK, even though the function still uses goto? Or, maybe I
should have just ignored the feedback from Sashiko, and guard() would have been
fine here too?

Since I need to respin anyway:
https://lore.kernel.org/r/bi3rvyqpdu4iq6pfyrqvx7eplyim6gmg2ijal67mpateobmtlq@gec7zewfm76r/
I'm thinking of replacing the lock/unlock pair with scoped_guard() as you suggest.

Thanks for the review!

Best regards,
Koichiro Den

> 
> > +	raw_spin_unlock_irqrestore(&rcar->app_lock, flags);
> >   	return ret;
> >   }
> 
> Either way, this patch is
> 
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thank you !
