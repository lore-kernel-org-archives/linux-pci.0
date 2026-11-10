Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.125.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794321671;
	b=SZ/SM5GjH/jSmpWzf7RIpDyk2uY0oTPlQBNX5uUVFZbYz4LUG3iRfWyQhJRqSme045A4
	 gO156RsnALzQCf7UryvT4ckdyFh6EmQpsrIanENV9eNI7F8QjshdZuee/H+1jPJKP00fR
	 5lGZiLgq17r9Mx8XDZ5XLsXzFpb2YZcvDuNsLRUxb6KoYkUFO02dQgh1G223unn+wTb9U
	 aWWBE3qDk+xrNo7B00M/QYToSziD5Qgf13rOFqSo+ViTElPcDyks5YdwN+P4IfA1JH0m7
	 vIowAfUhTjrE1iscIGBkOz5iJMsT1zpwMLmZSBF57ZhGYn7gAJBdmvXkMw/48gpl27Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321671;
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
	bh=4u+6mnf0rMlk2TmNYtGbVsQH0Lg5KUqLGK0cBTIrr+c=;
	b=XWl57RiRaI9gSEY+ZPglpjHrR4v4EJTtNgUEMeYKFImJBtkgS4Xr0gOtLpz/rfhc8/8J
	 J/k/+qu8qRiacfXxZ3KKRpD5tHkP14XdBy6DKIUs89HBMkT53vijx4qC5arYMTJFNVPb5
	 QB5CVJyuRJbqua+Lt/NgtHDMzUxiJEu7UIkaEhE90+H2O+816WcCy0HNY3F3OPIZsNbq4
	 3O7C6Ilv63vsOiC+dHtA6P6aG5hdVq1bQMKPi8+kRfnDasz87z4rmpEsOs3nkZaRmOZDA
	 wycreZ1Y20UVqpffW2uVWr79UGoae7JK76P2EIdWGei8CBCFucarVwx8hu+kJFd3VNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=fail reason="signature verification failed" header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=bKzxNCqd;
	arc=fail smtp.remote-ip=52.101.125.91
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021091.outbound.protection.outlook.com [52.101.125.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D060A261D
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 14:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E77D060A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=bKzxNCqd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6f9GbqLnHSxkiwLoTfaN8ykvrrckeicO+TqY4AdwWeQQhzOBGm4sNU9BuN4+cMDBu5xI4LnfmmPsEFFPodgEj/hauQbCBJe4p+DgtNkI+IkYrlrmDEq3O936ZAxa6clPA8m6KwiSRi+AU4ips5Q46sgQy1Pma75NKGMlrruq4QGIpLmkCxqT0/zalOFRwruVGuYP3WwkCwwHzfAcywEGbbP7Y1FCRwx2Npb61p8h7B/DbFnibHZ8v2W6QD+Gx5g6f5D+PFHZIRbd1P75YtNfMTZFpJOfW34A6VHkaE0V5W/xjIjMupo8GofMzRrMgeJ04PaTMHgnGLc7FX6z4dmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4kN03c0BviLeJpKvOYWaxXrVCWalbUMbas2jQwACr0=;
 b=rUe154o6IQdJYd9NJcr6/ayYYzygTbCB0j81OACMJp0Q32zY1PiTYK7xSB5aZk48Ue0YPMGbzfVSs7nEKs3Ju2QJHDU/CHP3eRYR8FTta4BANURiUby25faSq167vijwny1/t+MCfbDMremrPVCcFTbKmo3gN8XdKHZNuFbZ6Yp+9kQeZWj+0ngGJh+H5oR0SqALJLRtrm+9KYwCFj+kdGEQj4W2oHHLwnvJdh1CmXxfJumMJuXyFRDAjCCtK9yVnxF8tUuGnoDnsC7ToRVHErE0czOUc6qK/1mqmofRsTGY/+Af6PCPK79inx3ogXFSnS33COY8NVmC+XtKRrFE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4kN03c0BviLeJpKvOYWaxXrVCWalbUMbas2jQwACr0=;
 b=bKzxNCqdqXJoJskPSDaQlaDdOVixZc4BhWGdzgIRSPYSYydEKafnFzS9XLDAH12mXKJAvsAyx6P7pXSN+4c/iKKesXP44VE8n1x14siA3S5oQv5rj9l3W/Bs7K2deszCnpSuHHmMNIqSkBHqlAmDYLsp/VxUzW7BpvWgRDqbB8Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3355.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:208::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:41:07 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:41:07 +0000
Date: Tue, 10 Nov 2026 23:41:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v9 02/10] PCI: dwc: Expose endpoint DMA resources
Message-ID: <7oprd6ogta7kycd6edlpbpay3ayuvneviwy2lgjpgukucrscqm@oyi7mwbl7yfu>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-3-den@valinux.co.jp>
 <sashiko-outbox-206666@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-206666@kernel.org>
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB3355:EE_
X-MS-Office365-Filtering-Correlation-Id: 013ceffc-1d3a-4ac3-edee-08df3f38a769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|6133799003|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261026135527099003|261021121427099003|261022105027099003|261022075727099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aCLZIzVx9QWpsGFVZvcb88zN4bN1HFSipkv0PZQV0o7ukjKtWSsANnThzu3uC8Xes7DA3B1I7K47BycJHc2UiPi4Ij2PTa5/itMEKKLV9QKSDGFgLybqYfxpGBimiF07zd5sLGCZHr/65vA1QxsEptdwitOoQ3NCYyiLtJTYLFNMHYTVHaUDrvimx9MKwuNhhgDcFuzf/P+OOveRLHjzNKguWo3wUd4koWm/rpLtozMfy3+LxTMEqIpgN6Hpb0Ri/CTM8L9PjubFYROrOFsRFbVF9WnKKmc9Ecd1F8zZi0N27wNBa6HRGFc9/FM4jA5QnS4e2nD2W8XyXFaT2UEGU4eeC4EM8BQynQ+wpFCM078OGYBieCnV6rgafgwsfeGRnhh1gvNABVKGM2DpAnrseCnQt1+A6TSXB5MfwjZCg8COKT3ZhoQh4vgDczOTGCecATJHXFblgkCZRcDLjnVfZNBGzd7pOuGHCnIR3UlX87DXG+BGfO1Tf7dUHK2scHOeePb1nt3Y68FMSPPeZVtB1Xp2WkbnxUH9eJx1qXpVmGgcI2FfTke3e3GGN530rjs0A0ijG1rnq2/crjlOMk1tlezgOuRVPvTmbHpA2p3yqZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(6133799003)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261026135527099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?64lWbqUOV11eaBUU/PzZUi1pH/kYYKFmZ/EAF8PjESwgeQGq078sqSYf0W?=
 =?iso-8859-1?Q?l3CAYtPnXSJWXMGKYJvh8QyOYDVdpEVQ9S5z++YPSCrBdAHDDVtXgTvKjW?=
 =?iso-8859-1?Q?DBvpcYGCwCLucMpiiIrWVZOjtQp69Y59TPLa0DpRhwZOeWoqDnbg6t1aKj?=
 =?iso-8859-1?Q?HfS/R7SDJsPOf8Ob0wZ25pO3PXBF7IsMsbU9XTYnkLIHdjuDalvN8uQTew?=
 =?iso-8859-1?Q?oBUQK7qS2bozjUbKRwvjR2TyoFKfXGJJ/F2dsIvKnJU5YGnwcjGlkEMxGP?=
 =?iso-8859-1?Q?hPojbPd35YXMu8No77/z2V66zktpTKkIriLBwYRnWi4qRDjt6FfWYwjpy6?=
 =?iso-8859-1?Q?FXL+gQudSVb8bL113EOEtoJSuQN5cR5BjERra1ZK5b/tG+ONhAlc5Tconv?=
 =?iso-8859-1?Q?/a49AMZ8Xr2OnrNBYqewYv+IL7ManJelAG4Rfw4StUw/taKRPzIXeH+4F1?=
 =?iso-8859-1?Q?12PgLWhfUCsFALWoWBhPy2YghRjJlVyqtCdOsPgZNOvqIdr+VcLsw75e8P?=
 =?iso-8859-1?Q?5/48jKH/OXeNy6Et2gWcD9YtBpReK807bpWYdkvwZY4Hd/rtXtWh0p3B9x?=
 =?iso-8859-1?Q?DmF+sN6Bg4N3vClbWOJOMOeegNISlYFfwt4/4e0AbicdaYTiO4E9Hf5mCc?=
 =?iso-8859-1?Q?Np7PKzZa8O1YzZogf+prQR+8jIG/K4fVuggF9JokfuEb/uigox57RkgE7k?=
 =?iso-8859-1?Q?xvUbp/SQEStYZ0gN4vt5B4gS1Is+8b1b9bshVWU+jzEbF9K7mvII0+C8vy?=
 =?iso-8859-1?Q?FBZZ5g1nnM7G+FzFN8wjj1TnN5wXoJ7mqFgUtzbfI0kCA/t70whtNBlBsX?=
 =?iso-8859-1?Q?8NmvZxNZhf5UvkEWf9JLVfeHrqT8KO9LSTg4tw8q1LVV1VnAgyv2MNjZSd?=
 =?iso-8859-1?Q?xwgoukyUHkuXBs8rYHf0f+/dT6o4C8Luf2halJl4enmSAoyj1F9Q+1Um2m?=
 =?iso-8859-1?Q?Wf91yiVFyU4OsOBp0vaUkFJ0K6Xc5CaSRmP18QFx6ukXa5XM8RCDli5uMt?=
 =?iso-8859-1?Q?Bl8EGdwy/ACntm9miIikTv4Yyr4Mc3y753mOHmhfNQeT31ARuO4e9sKlka?=
 =?iso-8859-1?Q?V08BVlunNYSOmvNTwifrOqTq4htyB9bTzpyS4UdY9GivDTjB13USmefjkS?=
 =?iso-8859-1?Q?8nBO06d4Kmj23o+AfL3lreNQhMXRvMuojuK6R3Kzjg+R6FAucrktX4cW7K?=
 =?iso-8859-1?Q?Rpcugdks/9zZlKZmWvml/vAn7s9IwkdCOYOJPk7r4Z2gbXRU/F8hhzVdX6?=
 =?iso-8859-1?Q?8SxyuOXeP37kaPEeqgoUVrwe6CpDQZIod8jLwxkTWSvDw2fcxI2SVbFf97?=
 =?iso-8859-1?Q?Exyc+HKwbKr0MaQzyn6v00cexY0KH7f5MPAN+SPXAyWC6gh5seGn2K6FFc?=
 =?iso-8859-1?Q?lcB7Ab65CEXBFquqxGI+cB+h9DXcFC5moD/Z1Ii38omD/XjIWC3JlroAXP?=
 =?iso-8859-1?Q?n6wKdfXtHanO/X/p3DlJLXXa779dRTGkq06QuEiJmTrFvDHMMyim50cd1S?=
 =?iso-8859-1?Q?sYKtEi86kBPp/Q7UBA51jQau/862CUeE/ke8Q966USVLbucXqb9SGOJ76Q?=
 =?iso-8859-1?Q?MluqQHHNsQuKKJNewssVsT3184OLq7PstYceARoNiUSgCTSMOdj9j5yk7X?=
 =?iso-8859-1?Q?FZogQIESqYH+WKJkkjVTpahZMyMgWubVOFNxV+Uc2nXGX0mDLz8H0PZFSr?=
 =?iso-8859-1?Q?GAFF5GukRFFqY93wmoPJWQ9pvNrTBHpHe0Jtcvptu2bBs59+G8roDWRG1B?=
 =?iso-8859-1?Q?8KkVMTfby9LQWNAFScXB1iaLAcLOeVpBJDBdSWWHM4V9SU3jelsnIEJZez?=
 =?iso-8859-1?Q?VrBMd4517dTHqymYFPIbTLFjW6lLUBRsqYAl7EmrZYFuTOXFvMQ7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 013ceffc-1d3a-4ac3-edee-08df3f38a769
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:41:07.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NePnl/+N41IeyYENCww18HiVJn2KFUBiFpi7vycXSxD/c5bLLA5H2QA6T5gtNZLix8MdWItZW7LeTbK9mzclAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3355

On Tue, Nov 10, 2026 at 08:50:12AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] PCI: dwc: stale edma->dw in dw_pcie_ep_get_aux_resources()
>   after eDMA removal
> --
> 
> commit 2170b2570701b4b321fbbb9a308f0eed9f7a8dda
> Author: Koichiro Den <den@valinux.co.jp>
> 
> PCI: dwc: Expose endpoint DMA resources
> 
> This commit exposes the endpoint-integrated eDMA register window and
> linked-list memory through the EPC auxiliary resource API, gated on the
> local dw-edma device being registered.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 630ba172280c2..7166ec7f212bd 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -858,6 +858,15 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
> >  	return NULL;
> >  }
> >  
> > +static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
> > +{
> > +	/*
> > +	 * The DWC endpoint databook says it is not possible to assign the
> > +	 * DMA/HDMA registers to any Virtual Function.
> > +	 */
> > +	return vfunc_no ? -EOPNOTSUPP : 0;
> > +}
> > +
> >  static int
> >  dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
> >  				   u8 vfunc_no)
> > @@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
> >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	struct dw_edma_chip *edma = &pci->edma;
> > +	u16 ll_wr_cnt, ll_rd_cnt;
> > +	int count = 0;
> > +	int ret;
> >  
> >  	if (!pci->edma_reg_size)
> >  		return 0;
> >  
> > -	if (edma->db_offset == ~0)
> > +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!edma->dw)
> >  		return 0;
> 
> [Severity: Medium]
> Can edma->dw remain a non-NULL stale pointer here (and in
> dw_pcie_ep_get_aux_resources()) after the local dw-edma device is removed?
> 
> dw_edma_probe() sets chip->dw = dw, but when the device is torn down via
> dw_pcie_edma_remove() -> dw_edma_remove() (for example, on the
> err_remove_edma error path in dw_pcie_ep_init_registers() or during a
> PERST# reset in dw_pcie_ep_cleanup()), neither function clears chip->dw.
> While dw_edma_emul_irq_free() resets db_offset to ~0, the
> PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_DESC_MEM resources only check
> !edma->dw and !edma->cfg_non_ll, so callers will still receive DMA control
> and linked-list resources for an unregistered dw-edma device.

Same issue as on v8:
https://lore.kernel.org/linux-pci/sashiko-outbox-181198@kernel.org/
and as I said there, I don't think it needs to block this series.
I've sent a small patch to the dmaengine list:
https://lore.kernel.org/dmaengine/20261110082433.1798391-1-den@valinux.co.jp/

Best regards,
Koichiro Den

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261110082459.1798763-1-den@valinux.co.jp?part=2
