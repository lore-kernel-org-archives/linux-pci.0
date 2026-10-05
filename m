Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021072.outbound.protection.outlook.com [40.107.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3930B50D;
	Mon,  5 Oct 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219912; cv=fail; b=JrCdCj3q+D/3FrIlhwi7UFDTAgAjFfYz5HZgfByfbjSZ/AAAtZOfL+2xgR0pvqzQYtTLy30XDienNueY0LeSNiOFB/UqNxQOqOY/rfTbeveKUqvtidgfo3/BHMkSmUN9tyWxlTs3vW61QZickNwsKCj4fvdEXVKtlhPnxb5A3gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219912; c=relaxed/simple;
	bh=FISGhnQrk7hEpSTXQr2EHlhR4cm+Q8FGnYD958aw/cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f1PBKYei5zWC91C3TqqqGiZILoRnxr8Lq0fdLqG/UC0bUC6lKtxykhkLZHPOGTovqWTRozEOytf67tLh/Pgm4xJ88QwL97U1wZhaMr9+CeqSTQvR4hwa3YvKkTcUWg+wJOkq28E3+uwM9F5UPeAwtcohreiPNAEdoQ8wTCYYB1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uTn1fnhj; arc=fail smtp.client-ip=40.107.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uTn1fnhj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pokyqyy0+EMAeb5GQq3MsMmBGN0ZDWYk3DsMlSrKGci79YzZ6Cg6g1AxsR0Xv5yxHmLC2MYZcfvDHJw2hQoRFJ4yt/2UALYzO72H+2YdmCskgGwkoC7Fjz0YhYDujifReFGIHCTAPLfr1BMMhPuOi3dCh6bbeH/sZlw6T7uH/rHAe+blBOxQoYwfhZkQ6MPSWl/WLS+Kk03tg3Ynn+PWlc+ODTq3u9tYiai1XrhWozzPaSPK9a6X29KUa4CB1vUeibwtHq7i1l00kML+SoVg3tWInf5csEWRfYvULAUgyRZ8TYWrfh6MlRGOPOLmJmuPyk/AXY8UwBR2s2nfAe2pJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+InXs4NZwxrvMK6JLaDIOoD3GWgtB6TGGJqaLAle2g=;
 b=iYuuArcJd5Uc1sysrdhGHQMN1JUexyDvdjULxiPRCLeY4bcitHnRzwTQKw/0mdNZ7jqW7Pxi9pjTHHetocJC+hL1NTHtRwvCscM99KKkXDPaMntv6snN7fMIH8ZyQp56A7/oyWCzv5FwOliWuujUlb0u02O5EaJ6/hVZCLGEmtKmM7Yv9KmfKic//N6NpDTeVODM7tNMavMGL1Iziqr8TosUZ+ZNsUwediqO9Xz1acvDhZxXHtzZCKjkeXRvsEkg2c0HviNbHixTcHtsgdYP56kHi4Vrb5KAvS7aqdpCFuY7Nuc/qa07NHXJY/1/utSHRZ2/jRWUWMPAa7SogZjpCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+InXs4NZwxrvMK6JLaDIOoD3GWgtB6TGGJqaLAle2g=;
 b=uTn1fnhjRE20RmabUOMrI1JWyFnKRBMrEcj819fxj+cXHyTOxjZJbAXQJ51uyEgTwJ3HKH8j1r6JpoffouT0kn08432S3nabbvg7iGJTDpeRvDhYKit6GENScJZkKoPBHmvV7jixcHaQxfep8ToN5i2WzjoEdEe8VrJ50X9LHkg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB5578.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:18a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 17:05:05 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:05:05 +0000
Date: Tue, 6 Oct 2026 02:05:03 +0900
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
Subject: Re: [PATCH v2 10/15] PCI: rcar-gen4: Take over the iMSI-RX interrupt
Message-ID: <bzonjl57inv2yr25bwn5nihjnrsxdswr44qom4raupdjtcwhao@333ri5yg6bil>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-11-den@valinux.co.jp>
 <da9c10df-63af-4cf8-ad3a-084dd249cf21@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9c10df-63af-4cf8-ad3a-084dd249cf21@mailbox.org>
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: b56dc865-78ec-4a2e-8427-08df2302cd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nD2Q3P7GsNc+ce5Z8wqA2p3bhEz+FS+UGrhQay9ejf0aFRaFugVqrhAuC5w8qHnIheeRuUwoUlba/H9OvI3wIO1DAPGoUmZwWkBZ4m2aF83X6t0Fa585i1+YTB9PRLc4SRm50kgl91Xh/bDpRSuXy6cNStkcv+unen1W/3qzsdB/mhZrDC5Stz8FltnblxdDBNsPCSIrFMqF2tqk7rjKZ6ebOG1eNVzi9f5skmjKjUJZ+Tuf0r5LvKPRZWL/Rtp5mZiRf6fxkz5JUsIpgG7qUo/3Mdkjr3BkYseQtSpzwQT1KAUHEl15gGUV/FJJJTkaTuhkEIJuLU4dyOh/kq0NvYqyUJkJAgYJ0FTxNzxB0zT2ERTi5upNjklX7zp/OHTvQu68JSSxY51fMLrWgRNhPf1mEGDYH26tEHDF0yiQclUOLWx3GOZYiGwe3SRo6tLOKHw2XRxadEVoGSTH1+8cK/9Gqfd2gfqxzR45WcGUtRfSMr+/vW0svQpZNDmsGI3d02Hs7jN00jj+kVNb5pf7L1twJhK8P1IgH1pwRAeovhSxmITCuinlzyLNNfGE+z/F0v91XvD0rUMUlY1PBNJW4319LJ9oB8hvkfaWw8erMou0YwvmFUBYZI9KotTeRRzx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVXP98IofAgBDQKFPOs2cmxA9ce9/28WfUciKrNvw3LYYtRnfajighp/g1op?=
 =?us-ascii?Q?1+cSaF3T7XSQp49ezNfyyvp9/az9iTgXA3xWo/lGzHqTr9l9MUYWRSF00eTY?=
 =?us-ascii?Q?DZcAgqmX5NyoTBwWjRDZOvJxnBH+x8bu0g7hRHqM+EyRpoXC0xCe2w3fgg59?=
 =?us-ascii?Q?mUcCEaFowUxW9uCIHk8OdsqqeOwirW73r1KNugObHJOtCF/M9Po80EhEwLnA?=
 =?us-ascii?Q?XAOSUMOtYj3wFWZe1xntBPxa/pC/aAOJaSvQht4D/Auk/Dkh77C+U7eV4DAa?=
 =?us-ascii?Q?yFTH/5A/bSy0twdfRL5Lw62Wr9L8qyaYeoSX7fVVupaP6qgCcZpqS40khuZ8?=
 =?us-ascii?Q?nlXuXFTw4/fAgIUON7BMe/cxOGhjkBmvARcNsbylggfk+6en17aX13/Z7dy2?=
 =?us-ascii?Q?PYUynXz3tTb0Rwsruh8Kf+0cOXjdCqsBKPUo49aIumX8Z46MVapb66LgzxWv?=
 =?us-ascii?Q?MSPQFad6gml4I1Le9g69GloAw0Um+S5caD//IhNQJOQjeeXvHGKwfHJKzYkq?=
 =?us-ascii?Q?+c3v5BaOH4Cx+p5R89WoBU3uyP7PUWOzk241NFDOBtX6bU80QPbCcrJZTk+6?=
 =?us-ascii?Q?ORXOoOrjPkYbfhUKW9yp7o5Npy+xHa8zFbwsv2nc8QaSXTvM41wDhTUkzW8h?=
 =?us-ascii?Q?PEXgeXxfI2c7pueVu3R2KYJPNQu+Do82uhQcF3c+C/zn8c12zs0s41LwTJD9?=
 =?us-ascii?Q?CHWnhvt6Q7HuE8njQMwavDPlLDlp6Z8MZwkm/EC1xaCE6UjPL9o4KJ4P1FEH?=
 =?us-ascii?Q?wv3xW7o4zokxVQ/497/e8zz0VFg/uy7brCxQp1jX/3PbiNFUiXEZ1HgEM69Q?=
 =?us-ascii?Q?rZMjRz+Az2TT30MzDhZA7RW+OV3pN8/Q4xJS2EMWbsUkloKpkbplO62wfamn?=
 =?us-ascii?Q?SAgoXJSbvFpO7xXUTwmS9F1wXntaoTwEz9kBnjgtlpyj4foELyv1kF8kWnN3?=
 =?us-ascii?Q?KnPZ3RX7+01an2WpN//ZxIUqgjEpSoDKcekGtbCQnu+uSShxLRm4x4rKb0kC?=
 =?us-ascii?Q?3pmJkuMZFm+aWgLSQxsEwfMq1HvyYVXqYWTBkOQr5u4lF8Y2pPof6BJN9S3M?=
 =?us-ascii?Q?l5bKwuzYduo0vv9E9RDz6qcKFXgv7JyDefEqz2oYNKI3NqaP3lTYdEn0CWQ+?=
 =?us-ascii?Q?A9DdInm5Vfn+W4i88WDRkiVCyihJzwxlg2Qpc88cLZ7/LsXQmQ6JOJM8qX1Q?=
 =?us-ascii?Q?2wnEqrUEyH5T0TCaEDKmr3tp8N+VPjeeRfLuHNuY90VWeCWXJibWIhVatDpb?=
 =?us-ascii?Q?SjAWe7FPVnoDMqOOTomtrBVZ8SwDg7DK/ABknwSyCcNU3Bde7ViJfIE3hf7S?=
 =?us-ascii?Q?PUVpBAoHITzMQa5EBhC2I0wZVbWSEwfCgGFL5E+jIEJj4NHHVjxBgKZY+/d2?=
 =?us-ascii?Q?QNhM3X0rnXllwKG3ROTLiSDJi5tb5rWOxK5M+K3JMgXSWSdDKv3YkeBBiyOV?=
 =?us-ascii?Q?6A01EXffQBtmDQsc6qsJTLFoUE4ZJMC2NV/AzycbqAU6Owh9M4hNI44S31iX?=
 =?us-ascii?Q?40OgpAomgwStJ6veX29gRLudLEeClk7w3ymMahdzC2dhUTNOwojedWaMy1Kh?=
 =?us-ascii?Q?QrmUkxkgApin0auJr0mirWef6UCF0fQDiETNeeqss68+OoqB7KKqRY7Z5bQ1?=
 =?us-ascii?Q?BW+Op1elUR6utZTbX5JGnkiup6hNLiHY8ly2ldyTb4oTxevgQThYNOf3HrEN?=
 =?us-ascii?Q?xw9X1LgU16ekm3pOe7Kdo6LAp4QZp5nEDRSe70Px7Le2XAz71pGXtulO9w9M?=
 =?us-ascii?Q?d9JcypnUHpQdNBplUAcF2zudQWXB7OQRGgDpNuNcuZMuUD+yIP4O?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b56dc865-78ec-4a2e-8427-08df2302cd78
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 17:05:05.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fJsAB/1Z4bXBk9FKLGgzu0vrZTD0ZhquEaHPHHez7H6YIFV7KqPBkHOJNyFQWNwC0m5nWqTPv8vWAjL3kAAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5578

On Sun, Oct 04, 2026 at 02:53:27AM +0200, Marek Vasut wrote:
> On 9/28/26 6:52 PM, Koichiro Den wrote:
> 
> [...]
> 
> > @@ -724,6 +773,9 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
> >   		rcar->reinit_pending = true;
> >   		rcar_gen4_pcie_app_irq_sync_locked(rcar);
> >   	}
> > +
> > +	/* The MSI status lives in DBI; keep the handler away during the reset. */
> 
> Would it make sense to add lockdep_assert_held(&rcar->reset_lock) here, to
> make it clear that this IRQ disable is protected by the reset lock ?

The reset_lock is going away in v3, per my reply at:
https://lore.kernel.org/r/eivzz4zumuu32zrycw6wpt3orzk2dvlzuvj34krmbhjf7a3a6u@ccvu2nkupzid/
These helpers are reached from reset_root_port(), which the core serializes as I
wrote in the above link, and from .init()/.deinit() during probe/remove and
suspend/resume, where no reset can be in flight. Sorry for the noise.

> 
> > +	disable_irq(rcar->msi_irq);
> >   }
> >   static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
> > @@ -733,6 +785,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
> >   		rcar->reinit_pending = !recovered;
> >   		rcar_gen4_pcie_app_irq_sync_locked(rcar);
> >   	}
> > +
> 
> Would it make sense to add lockdep_assert_held(&rcar->reset_lock) here, to
> make it clear that this IRQ enable is protected by the reset lock ?

ditto.

> 
> > +	enable_irq(rcar->msi_irq);
> >   }
> >   /*
> > @@ -804,11 +858,17 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> >   	ret = rcar_gen4_pcie_host_setup(pp);
> >   	if (ret)
> > -		goto err;
> > +		goto err_deinit;
> > +
> > +	ret = rcar_gen4_pcie_msi_irq_init(rcar);
> 
> Would it make sense to acquire the IRQ a bit earlier, so you could avoid
> rcar_gen4_pcie_host_perst_assert(pp, true); in the fail path ?
> 
> I think if the MSI acquisition fails, perst signal would pulse (rapid
> sequence of deassert and assert), and that could be avoided.

Good point, thanks. I agree that such a pulse is possible.

However, if we simply move the request earlier within .init(), before
deasserting PERST#, request_irq() would enable the line right away before the
controller is configured, and since .init()/.deinit() are also reused for
suspend/resume, keeping the request in .init() means freeing and re-requesting
the IRQ on every sleep cycle.

So for v3, I'm planning to move the request out of .init() entirely and into
probe, using IRQF_NO_AUTOEN. That way:
- The request happens before touching clocks, resets or PERST#, so a failure
  bails out before the hardware is touched.
- .init() only needs to enable the IRQ once the controller is set up, which
  cannot fail.
- The registration stays intact across suspend/resume, so .deinit() simply
  disables the IRQ and .init() re-enables it.

.. That said, this may well be what you had in mind in the first place. If so,
apologies for the detour.

> 
> > +	if (ret)
> > +		goto err_assert_perst;
> >   	return 0;
> > -err:
> > +err_assert_perst:
> > +	rcar_gen4_pcie_host_perst_assert(pp, true);
> > +err_deinit:
> >   	rcar->drvdata->deinit(rcar);
> >   	return ret;
> >   }
> > @@ -818,6 +878,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
> >   	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> >   	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > +	/* Stop the handler before asserting reset and disabling the clocks. */
> > +	free_irq(rcar->msi_irq, rcar);
> > +
> >   	rcar_gen4_pcie_host_perst_assert(pp, true);
> >   	rcar->drvdata->deinit(rcar);
> Shouldn't the IRQ be released only after reset is asserted and clock are
> stopped , otherwise it might accidentally fire and cause unhandled IRQ event
> ?

That would be a concern with a shared line, where the remaining handlers would
see spurious interrupts. This one is requested exclusively, so free_irq()
removes the last action and shuts the line down, ie. it is masked at the GIC
from then on, and nothing the controller does afterwards reaches a handler.

The order matters the other way round. The handler reads the APP status and, for
MSIs, DBI, so it must not run once the reset is asserted and the clocks are off,
or it would hang. That is why the handler is stopped first.

With the v3 plan above this becomes: .deinit() calls disable_irq(), which also
waits for a running handler to finish, before asserting the reset (again fine
because the line is ours alone), and the registration itself is released by
devres at driver detach, ie. only after the controller is down. I believe both
concerns will be eliminated by that design in v3.

Best regards,
Koichiro Den
