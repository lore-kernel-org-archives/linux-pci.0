Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021129.outbound.protection.outlook.com [52.101.125.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DB374E7F;
	Thu, 24 Sep 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266550; cv=fail; b=DHUqMVGfcPIkVAi9EZr4ADZAeAxrAerMk+CqChHThqcbVYFbOLoxknp9Id4cBG8YRgjrVJvHoRxNGQrHdrODilkHEO7OYxHt2JvSE2+78iy5U8czmV5O4lJo3nyVhxrm3FI5yYjAVvHBPGPbeP4dD9beZWTQZVooi6Eg8euDitk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266550; c=relaxed/simple;
	bh=7NmNaYmmwxO8vHZLMeizwPGOGLFLn3YBMl1dQnocMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gePvzxFKvqB0YvVmvXd57dA3FJ53mF2+u/O3Culv1e/WP8jXQS/8lmwMWxaiRc9qh0jyKH/SWf1cAlAHH2oeTeXX7Z1IozyuGUvhM2rv6Y0fI61aTeLF9WgCTgoGWVSao19A0OsjxNsNU/8Sm9kICBedX03N9RiBiTW39z9NXfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ne+CU+mt; arc=fail smtp.client-ip=52.101.125.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ne+CU+mt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYceYZWhzUJT86beo8kIMcY9zYr/zlIwhCxfJxu8dZjoojnWpyJxPZcU8BXH3Z62nL4WbOyYuUzHByKmjXokczVxa1lOpS25FkEoUn6QpeSowCa+14mKZt3TI9P7ca8/Q7rfrfYTAnlm5ZSTdlBMR87Kbq3dm6buXy2jTwcv2lC4C4Gn5lAObRlpeNeCRLuvNaSo9lA9DoFeVkpEWK4dzGhedmbO3jPuOsOJu2bUMnmuHUN+1D+nI5QkYgzPO8O4vj/AHYPSTMSWwBBzRj37Ma8Zq7kYxPNiIXZZMWJdTltQy5novCsik0CxvHoXMJQxZH7FQKvEVNN9NPXhQMQQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyFWC67RLK8tMMnz1rOWNKPFbN3GYAHUwGQdBYRK9OY=;
 b=Wu5fIFBN+2ZpYIm0RTxlvU+42uS02fBBbdFjD/7VXF3KQS0TS8YnL2aaDdlWVDALEh4riJMJMjveGIgyRDOV9cCiz3d/UbwuUqRcYnmJmqOXrxTTCgy6grVaoo0PaUsaJrzFiuylY7w5ld3N1jzBywOfYFzkdfTjnxi5DEnqCk3VnRFQLfg7HF9zzTaZ9nQH3sz9e/WOJAwOCkQGCtOAWqIep3d/HESYikFL94I/w1Kb5NWVZFJZ77f0sl+jz2YABrBPaxaq/2W+FUcaamgwhXlEB1vEyiAeF8Q2/uWIEU3lCgpgagcUYGb047174xkkIPd+gyb5YxILzwpcrLZrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyFWC67RLK8tMMnz1rOWNKPFbN3GYAHUwGQdBYRK9OY=;
 b=Ne+CU+mtCY2+JL6bt12lCXbuGJl1bDyRaUhfDDmVNYak3tRiM46bdLX2+dVXxWT4ub2YVoRpgu9ALg4xpACd4FeZbm4YD5Gi3r9Ujv8fvX/84cIqT3/Z9UdrVUZt/+qEnFisR5+x1nwcUpuyJQutMiJJSlr7ul2APX4954T/vEM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB1782.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:170::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 16:15:45 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 16:15:44 +0000
Date: Fri, 25 Sep 2026 01:15:43 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] PCI: rcar-gen4: Recover the Root Port on link down
Message-ID: <jbekhkl7ywblowemhmm4nhzzvg6bk6vpfciaebwvxe7nitfisc@3hbnpq6uz2rw>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-8-den@valinux.co.jp>
 <e9a60e4a-95ac-4e49-a16d-a8eca2196d4a@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9a60e4a-95ac-4e49-a16d-a8eca2196d4a@mailbox.org>
X-ClientProxiedBy: TYCPR01CA0207.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB1782:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b6153c-b40b-4f80-6d6e-08df1a57162b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|23010399003|7416014|376014|4143699003|56012099006|10067099003|5023799004|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rajA4p0+WnDZ9tSl5XJXTiyB7cskvY19Lz0E2WYn8PFt/xumRyMCXMoKvJlZqfMGu1O0osr8p4fFgxrQC0mZdX6uexKQbnCUVylvOi8ZE/HtNANNgjpFr8jeGB/KLLKU0oLXn4Agy0jNjkO4EpHaIj/8e1l+GfWHXG0VIYkJYTp545cNnm42TwCFeDL3yhqpiyC0Nt8TqXH9+NHkrvPzzp3Pq8OLUkP2q5H5LtNmqIZ2JSk9SwEeorN7afqRoAA6jofLv2zcK/VKWGn77hBf3e96DwbpEZBAPYsyslvBMmYj1jvRLZATVGyL6N3FypnVEHYabXutgEtiynzC6eaZgRZ23+o/koL2umVOc+3BUkxP4PEJmhIFq1Dx+7uS1Ln0ZM7zY5oKSBbuF8r/DzfKvsPxXdoVzFCuLGWTGO416sDaoKuhKz1l96TOBmPGcQw69SKnpsILrEjffbUY7nq7IR9tT+Jr7HieEZnaPoZ4eYK3i643f2XaeVTbdSrP6Eje0DikD2Qb/QTOcnGSg9jcYNb+07FwHPJwQlJmgTjuIwcAHahPxpM04vKK8rRhuZ4PzXw3vcQcRaSf4/giimoqU52+smZUvdG9ceNwgOkAwW0EONg3ifykFVAZy4Xig7G7T6SaEH3O4ZXTm4+Tk5jtvSZDSGdiVTgaRM9Sz93nSAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(7416014)(376014)(4143699003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZF6E9khpaj/DijKF3vlDUAqcNcGWfroE+u44qGHKS9Zgo8XI3AaP9qgf9B1?=
 =?us-ascii?Q?EYCOQ+zXBfnDsnMICN18v/vD4znPAuWRmFi8UCVSSDZ8/ENxVpOe6+pANqry?=
 =?us-ascii?Q?6MIKkfyYOCDB83Lsnu/GSdQ/+zU94XL2GxScawVgrQB3HBvhxbLzMxvQRJUL?=
 =?us-ascii?Q?IeWZB0Vw5dPrP0Q9V9njOX9SQwY9Kqt2U1McO7+s5FGr81LvRHIMZHAQoOcB?=
 =?us-ascii?Q?QM5Kf3qUvSX4or4sGJe+BIA8UBFWTqS29th3wGBoS27iyg7LDAw96YQMNpxf?=
 =?us-ascii?Q?dtIS5OGjlu4/nn1qF58CoM2cZHvdlK1vZIGOYGAzES3k3lJx79IuIfDRRRVz?=
 =?us-ascii?Q?M5cyeL9FCDI+COPpv3AdYPvlK9WkW0Bm/hoaZ8+mR8HYHmdxa6DGmX3IM+/I?=
 =?us-ascii?Q?6BWabwMvUi5lt8C0cJ6792EvZJmGCIgH0Qi7S87+ytzzKw1STfKx3dYuRgGD?=
 =?us-ascii?Q?C2D+4x/YQaSLWgaeBX4RYszME3NwA8Loiqhj2ssQV2HcuwGDMrsoQYUs6gZy?=
 =?us-ascii?Q?bjfAB6IjHrKZGuH+eJ9ffgwPL6KgFqBCYRa08zdk1broJ47RdtnFoCRoZ6e5?=
 =?us-ascii?Q?CHy88l3/3R97/TY6j0DHPzDPys5NfXRKGtzp3inc5E0RqvX1ldto63wgKOU9?=
 =?us-ascii?Q?4lGb/cxNokM6hFTf+9E9W7yNj2sHTE79VizA7Ms8G55GOTytBz/b70VlEgK8?=
 =?us-ascii?Q?6fb+2cv1r+PQJC6/vP9x+uiE9OkyM1ti71xtoSZFumEi7LCKDN0p0eKH9OCv?=
 =?us-ascii?Q?W6zQQI/NA9DT6Zc7mJbeM1zh6OH06ba0fC9itcftm72Og3y/GXjOPENtbF/v?=
 =?us-ascii?Q?hxelFiHWI5KHgxR6dcJPOkZOdnDo+3PwdszDYyBdu1lcq2UGWObZ0uWGQBhW?=
 =?us-ascii?Q?msBMyDouZbxvOQWYofWJlD0UH/erpVBXmO9mlDI2/7fE3I1QnEcnWaDnO9PL?=
 =?us-ascii?Q?yV6n5K/WEVhfxkrhc+Odn0sRRDy7zF5E7glL94/vPs2WNG6wWdc2e4frTezb?=
 =?us-ascii?Q?g2FDv7be2lSEdGRXiZ7yPAITgtqNKJmd1AtdRbUphXwZpixsJEpxWNNoEyyn?=
 =?us-ascii?Q?TjZGgY/KPR2qxYLidyFHP30pQHHP1dBKXJ0I1ss1O/2d9lP4bc+LIS1ma+zL?=
 =?us-ascii?Q?KlVvH7/0ollp7TlHXqTmwslE2u9dM0Lqt3xT8oAJkCn5NhDwdAxP9FH3aRiB?=
 =?us-ascii?Q?CBrA0BLW4zoe500WqpvSX3nLvobMOVR+MPkeCdhFsJM7KwvQoDlRDpiy0Nnc?=
 =?us-ascii?Q?zFkiLekCF4IdFpuR9w7olFp62tbwgSGa4jzv4SfeFk1ZmvZmzSpYGQO3zf/j?=
 =?us-ascii?Q?WLnXPwIgm2qPg774TUdOEp40as8F8gvhVV7PkzHH2iYbn+UXVhzk+ixpMrbv?=
 =?us-ascii?Q?kcoC77lVnr0mDarVHG7uMcLtcPH15APq4CNynn7DRyjwHziYCetW1Fht2AgI?=
 =?us-ascii?Q?iZlZ3loyEhHLxO3cJJ81n5HCz1Vzw9Sz1f2jIJrqolQXVzjUeeXY5DcMAyIB?=
 =?us-ascii?Q?ozQWyNyWeWc8703g55vGocC0lzRlAtMwSrlGQ/M1iPmdDTVujHQn/hYZB/ls?=
 =?us-ascii?Q?ul6nyPA/RI9YIu/Q0dO7/2rjN2h2do7AAliINQZsFMVcYEAyzyQIGwm70BDy?=
 =?us-ascii?Q?qFgnTF5+gHhdr+UUIzADJNa28fk5HhTdiaB2y7WAK6jnrSo1V71YWSfq4U1F?=
 =?us-ascii?Q?v0eUS67sRRzWdxhM1Dgl+95IlsomHpEpCAruxetFsJB5AFEi5ZfvmP3m0Z7r?=
 =?us-ascii?Q?EQ1E/9bSfiANL2ehv0JQac3lAirsrxiJFy5yS2c9j1DN60u8H3Ex?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b6153c-b40b-4f80-6d6e-08df1a57162b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:15:44.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9LbJb4TpJ2e5wgzoW6WLmSmhc9O83IK95Yb69JrWxglbXIHwGaX+Ah5vt5JhkqEJ38ruj/2L9K7HvesLcUcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1782

On Tue, Sep 22, 2026 at 11:44:02PM +0200, Marek Vasut wrote:
> On 9/18/26 5:20 AM, Koichiro Den wrote:
> > On R-Car, intreq_pcim_sub carries both the integrated MSI receiver and
> > the controller's reset requests (smlh_req_rst_not, link_req_rst_not), so
> > the generic DesignWare chained handler reads the MSI status from DBI as
> > soon as the link goes down. On R-Car S4 that is a hazard: DBI accesses
> > issued within a few hundred microseconds of an unexpected link down do
> > not complete and hang the host. In testing, the first Root Port config
> > read after powering off the link partner hung unless delayed by ~300 us.
> 
> Out of curiosity, do they trigger SError, and does the firmware (TFA)
> trap/fix those up in EL3?

I haven't confirmed whether those DBI accesses trigger an SError.
The BL31 on the Spider I'm using should be based on rcar-s4_v2.5 [1] from the
Spider BSP (as I haven't updated it). I just checked that this version also sets
HANDLE_EA_EL3_FIRST=1, plus plat_ea_handler() is empty. So IIUC an SError would
be taken to EL3, and the normal path would return to the kernel without fixing
the underlying error.

And, regardless of whether it's a synchronous abort or an SError:
- There was no crash report (via report_unhandled_exception) on the console.
- Once that DBI access in the small window hangs, it never recovers,
  whereas adding udelay(300) before the access avoids the hang. So I
  doubt it's just retrying the same access after a transient synchronous
  abort as well (though I can't rule it out).

[1] https://github.com/renesas-rcar/arm-trusted-firmware/tree/rcar-s4_v2.5

> 
> > Use the pre-MSI callback to check the APP reset status before DBI is
> > touched. When a reset request is latched, mask the sources, ack the
> > request and schedule recovery work. The work calls
> > pci_host_handle_link_down(), which runs the AER-style recovery and
> > resets the controller through reset_root_port(). If the reset fails, the
> > sources stay masked so nothing touches the unrecovered controller.
> > 
> > Only unmasked status bits are handled and pending latches are cleared
> > when re-arming, so requests recorded during probe or the reset itself do
> > not trigger another recovery. Teardown only disables link-down
> > detection: MSI delivery has to keep working while devices are removed.
> > 
> > When iMSI-RX is not used (external MSI controller or pci=nomsi), the
> > DesignWare core does not request intreq_pcim_sub, so request it in the
> > driver.
> 
> Would it make sense to request the line unconditionally, to simplify the
> driver(s) ?

Yes. The pcie-rcar-gen4 can set pp->msi_irq[0] = -ENODEV just like spear13xx,
dra7xx and keembay for the same reason. That also removes the need for adding
.pre_msi_irq addition in patch 4. Some other adjustments might be needed, but I
believe that is the right and clean direction. I will respin with that in mind.

Thanks for the review, that helps a lot!

Best regards,
Koichiro Den

> 
> I also have to wonder, is this specific to R-Car or could it be this is a
> generic property of the DWC controller and this should go into the DWC core
> ?
> 
> Thank you for your help !
