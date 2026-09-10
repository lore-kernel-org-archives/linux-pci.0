Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69171FF7C7;
	Thu, 10 Sep 2026 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016219; cv=fail; b=G6fcCKSZ7oHWDOvvuisIBhs4+yi1YtvMtAshsLb9pmXBzoyDNJyOuaKDN9SV7jOBvAVdiuwQVmHKcrLQdzOTSWLgKi6Cf4ipxlc/xoTP0zm711J9iNtlaG0dDbrBMO/OdKeTru2SsAN+A/qDGYx9GeY8o9Cv0CMclKcfV5zJcdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016219; c=relaxed/simple;
	bh=uM2IUUl4bbtW9MZ8S7gKMY/V4gf+hLwHZqmvMltmhmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lV1MeGxZ63APUyRP/XSBP8T578sCPUFlIIXkDumEcnp1L4SpT4Ffc/ALI0/IP1Zo/A/nKcGpQ6795ylE0jSSuf4+64WMy+xsYvl2p0UmH6D8XRReJEZc2AFq6aYBHPLd+rxXc/FetzLJjAYErIBtOFZULaPhHw0Qsjhl+sV2Y78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=B5BXLPIH; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="B5BXLPIH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYSl7+L3kN2aVCoAmO+0eUwK5zDWMl2dbhVkq4ZEBJ74wnf/6WTqfxdA4zQ1FO1EDNrjvhm36Ziz1p44dPN9Lyjj1XRfwIFZOZfM3/YR8uuJO41b8Ov/t7aHvT9gnRjmoiIbkkdlajFXu+V/TpD7xwp5KhVglMWMMyFREJxgDXyUxTY/lt163DL06sLuv/kPBk68FJ8BZ95UHjLAp2DxAtZc6j+ENxEV/OATOZblfSg6QJ7aIMy0Ik/Iy+Klx9Fl4fP4b1mfuKTbIygsa+nTxeKBcyqVSFlMHMa1f2tNw17miqWdR6d46m+Y5teIVWMTIoaDTgjlBo2SRRBXgAtzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90KxtM0pCQp+RCVYS3WW8JrikFGPGLQA2l8tvaPRCBg=;
 b=w1SrSZReLSyABKsQxJXbHAZfIBGcM0vcQExi3uj8nW2kUUsa6B5VIMEtjNBVSyXmwTe/Onu90wjFPaDhhhfA7pdIMh8ezuvgZmhBjdqbLXVwJr9OcAUFLAYUQcoR8AzMvaiB6S0Eus3mYKFOiLWC32ng2JWdYXhvRO3ED55UT8jBB1k4wMOeQB+/6dH+lGi5VmSitbMx8/+Xi1pDUn0er/q/QwBTAVre+UxyP8TCkzITCKVezO49TPgJH3p0kOcYW61Qtju0NhgBMr9RB3JcRI/d6OVaCGRFYwb3aXMGfMgxqKGh5nb+pDDufbFm4kNyQuVo1kp+y7Sx38mAM0R5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90KxtM0pCQp+RCVYS3WW8JrikFGPGLQA2l8tvaPRCBg=;
 b=B5BXLPIH93kmFMBi8bLpyyXHYv4j6xf2lrbDK2f4VEGzvu004pSJP0hyNOgt+1T9ituVoQXvTLhGxR42U7qVv6xniT+pVB0IsI6vkfZ0EqQXVY4xeLYqRkuzwK6Uxx5iug35gK77bSX6L8cAVUeotx7M3/W8tW55S8hIMgGI63Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3760.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:23b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 04:56:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:56:54 +0000
Date: Thu, 10 Sep 2026 13:56:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Message-ID: <sbmyv6wgmdtow7rg4m7vkfpn42ts2xobqwvzjdh7japgyremyb@p5zmzskzcdvc>
References: <rmso2szdpfjy4qoqalhhpf3zxzn2te25m573qmwmpmoilk5jz2@arvvr4hdzbbj>
 <20260909160949.GA216221@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909160949.GA216221@bhelgaas>
X-ClientProxiedBy: TYCP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3760:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4452f9-3c6f-4b21-adaf-08df0ef7ef74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|23010399003|4143699003|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	r6DlMRCHw822ceEn9DiJxniKMvNcXKTogqkM1u/HiWTKzNfjebjwYsfyR62BnJII/jU7R1zeN5g3uyFViagzU15AUTvsaCtL3vrJw+qQ9lrpqT77JKbqAaJrZdF2wc3BFdN6T5cDJYhbBr41xJWzOr2iAeu2UTWJUfCXdQiiAak/9l5h+1kbpJn0amDz2wgpeoB3TzB7k+Y3poGtMwdRQi7eqKF8r79qYexGruB+nw8AoBYQrhdzk+GFb1X0mON501HPu/aX8kUCLO4Z17KLfGURCih7bsEBWGugyqlRFE0Z5tqaUlXtt0VhnbB7RxsBgxFewsUpanke2ZwpBy365e4JJEqPCj0zRxdiVABqqlYgZCWBC0wfADNLjIjDQLj/vhIX587DiNnk2zkk8Tk4YAydHWebuGJ+5OD8XJ7mDzMp2L2qzo7fi64lKQZiHZVu5jp7YRe8FPAmf+evQV4REin6HE7HH4svxUMnm6iJaZV1c6B91CIlXcJBK+csZsvsZfVuOsgIKUrtZsbe22HjwTqXHzH87qaZ8wXDcI7op75Vtmxh0p6TLhChHHMVf/cV5YusNKQjJjMDUJYeAOZT+L4IVMgcLK+cnBW0VGKvlExzBq8si6M4Q+dW0tOmAZ6j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EhPhdcnuWNe3fSCukHcNPK1THSVc9dM+uZ8rcwOsbuPcgf42ANSh1AToNPX8?=
 =?us-ascii?Q?GO/7jsRpkpkgDlmV51p29Aq1Gadj6c2e+T92frV8abrXuQsw5rNT/drg7SQt?=
 =?us-ascii?Q?yMyfnD8dEx6TY8jvqbJx/Tx+GyQfxX2ncegHrDTxj7LHOB/ZiSmuTe+T74fT?=
 =?us-ascii?Q?3DYP8ne8BeXBm5xaCyuCeHSi4hei1B2+w7NstB2o1D8DNbJDc2Gn6CUuUgTK?=
 =?us-ascii?Q?HZj75DaRpY/5zLoj3gUVxtlaGlkJshnXxmwn0Fka7dVT1ZOMzJwHKBxPnv4a?=
 =?us-ascii?Q?XQLrGNQvy2TuDhnhN+u2k4B1gkqQZEEMiCm1z4G3kLrPdWxFD1dk3+EObOnO?=
 =?us-ascii?Q?aw3B1GVj3L+GP5b20h3r8SwOUzuCcZOeOtsIvGoYOjiaG/BuMu6kTy0bl3t/?=
 =?us-ascii?Q?8Kbv0q/v1TsqftBzdDLJ0ChsxKqDBRoF3iBSp8yhypw1SKoi8DOEqFNApe5I?=
 =?us-ascii?Q?Ij0KOewMB3XVd/bC8AZlujHIGkl0M7bV16onveYwnrhLTvBUyEEQLEmapa+4?=
 =?us-ascii?Q?QZ++8v6YUJEN1CsnHCg2F5M7zUywerL5u3UiVgmu02XU6vhi1FUbZZTKbWNi?=
 =?us-ascii?Q?KV2IHZi8D/cqN3iPoxsHiaU8BK1qGjwr78eQCR5oT7lEZhS/VLzCCg+HHflU?=
 =?us-ascii?Q?JH2+Ih9uyO7rrZhoGJwTq0gXwIqVI+W75yOc1UXCEZ4rux1L9J93bzCOnnrV?=
 =?us-ascii?Q?F0Qzn/cICV/VnScPlimI7ERQU/rK4IR5VeeoQCWmeJLmjv6Y5hruTGldor18?=
 =?us-ascii?Q?BWsVFzKuF8aTzZi2cKksOhmbVXxz71SOhF3Cu+tgIBcWiheJeZpEK8nR3mxA?=
 =?us-ascii?Q?B3VsFVQU+1fn5Q4gw4pSa+oQxm2Q4npbXu9txDgkZnNh85aB8GMYVb2c0pC4?=
 =?us-ascii?Q?xsVha/dtYWw+jW0m7v1YBwHQ9zy58lHBYfHWuvSyspx7aFgJQFO8xZ4dJqNQ?=
 =?us-ascii?Q?Egs+xxuBE0vZiiqLplfXCWJmMVTQaCneB/o5/PCIc70/tn97O5S2Xf7tDRcz?=
 =?us-ascii?Q?0DSwV9orJPBw/JGw+OZonJS6gnBuzPcjN8znTUEn6tZw/AjFjfh/I9Hk+BGy?=
 =?us-ascii?Q?1XiuwlmCSyVZOPx8FKei/qI8kC63cen80I94XjWQ8ctWATrmKpKu2n9A0kiy?=
 =?us-ascii?Q?PmYRDLofi+W2SJbp2QACQHfR+RAG0jmt0torH7jHLSf3urXilkeRO4SDFKuy?=
 =?us-ascii?Q?w3gqebfl1IYd9LtqdgtKPAVIZCWqxTLQZ5mnPEAtBSoeAbG1dsGnP2w+HV3y?=
 =?us-ascii?Q?TiLgjEPxumPpysVITfT98PzYqpLaM4tDe+u0c9TV4ZQsH1pikOAvDBWl1wCb?=
 =?us-ascii?Q?FgLhXnGsuGPoi2XDt7cSDbk3s4Macntr0yhpEqIULBaMU3wzE6K1rycX2TrI?=
 =?us-ascii?Q?7wrnl9bUwwyJkY6zlbyJUUJrRLIAgXZOFa0Ro/bgGQ8iEjUfb2pV2nu1wcn2?=
 =?us-ascii?Q?o/XY9XBn7fVSsePChJIuaK5FBYxtZWXxcmsrRC6nD/TZT6gAozFYgyB3934h?=
 =?us-ascii?Q?PT13R9OVJlcrytmqkO0qV6PtyJ/daZfndZBaugHRSPKCtcPmeneYg2OzRwap?=
 =?us-ascii?Q?E7uJkmVTpY4dD1l7oqd0s51OKvNvZSMWRkSYxfWosc4/3ei/NB4Ckh03U4MM?=
 =?us-ascii?Q?ZsiB26+n0dfxvubUCj7yJDPG3YARUK6WT9/bi0HaQK+9c6KoHFLv01u7AVPv?=
 =?us-ascii?Q?EkZyjdNhkTpd5gaNm69fS2jr/bbZS9Ef+vG7aAEcmEvDDnpgf+aRbk8qLVtN?=
 =?us-ascii?Q?APRaD5+tHEXwPnlC5A/+1NSxoxhBwj3PRjfJkESAxdnhoDstPMra?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4452f9-3c6f-4b21-adaf-08df0ef7ef74
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:56:54.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9Qkmue8o4ec36gWTGO2jwDeqTxKTACUpSAtAcUdTgqrIbD6x0CyNKWS3UfZGSoq9jPSo2pfqii/MltAtSVxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3760

On Wed, Sep 09, 2026 at 11:09:49AM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 09, 2026 at 01:53:53PM +0900, Koichiro Den wrote:
> > On Tue, Sep 08, 2026 at 09:23:11PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 09, 2026 at 11:01:48AM +0900, Koichiro Den wrote:
> > > > On Tue, Sep 08, 2026 at 11:53:15AM -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> > > > > > vntb_epf_mw_set_trans() programs the memory-window BAR through
> > > > > > pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> > > > > > lands on the wrong function whenever the vNTB EPF is bound to anything
> > > > > > but PF0. The other BAR programming sites in the vNTB driver already pass
> > > > > > the EPF's own numbers.
> > > > > > 
> > > > > > Pass the EPF's own func_no/vfunc_no here as well.
> > > > > 
> > > > > We're referring to these as "PF" and "VF" in the subject and "physical
> > > > > endpoint function" and "virtual endpoint function" in the
> > > > > pci_epc_set_bar() kernel-doc, but I don't think these have anything to
> > > > > do with the SR-IOV PF and VF concepts, do they?
> > > > 
> > > > Not in the specific case that motivated this series. But AFAICT, the EPC API
> > > > uses the same (func_no, vfunc_no) pair to cover both ordinary functions and
> > > > SR-IOV PFs/VFs scenarios. With vfunc_no == 0, func_no can identify either an
> > > > ordinary function or an SR-IOV PF. A non-zero vfunc_no identifies a VF
> > > > associated with the PF selected by func_no.
> > > 
> > > Now I'm even more confused :)
> > > 
> > > Are you saying that a non-zero vfunc_no always identifies an SR-IOV
> > > VF?  And there's some dependency on that?  I don't any mention of
> > > "iov" in drivers/pci/endpoint/.
> > 
> > Yes, that is my understanding of the current in-tree implementation. You're
> > right that drivers/pci/endpoint/ itself contains no explicit reference to
> > SR-IOV. E.g. pci_epf_add_vepf() just calls it a "virtual EP function".
> > So my saying was kind of assumptive, but I still think the same because:
> > 
> > - The support was introduced for SR-IOV:
> >   https://lore.kernel.org/r/20210819123343.1951-1-kishon@ti.com/
> > 
> > - The core rejects a non-zero vfunc_no unless the EPC provides max_vfs, and
> >   Cadence is the only in-tree EPC driver I found that does so. For example,
> >   cdns_pcie_ep_set_bar() calls cdns_pcie_get_fn_from_vfn(), which uses the
> >   SR-IOV First VF Offset and VF Stride for a non-zero vfn.
> 
> Thanks, that's helpful.  I still have to work hard to change my point
> of view from host-side drivers to endpoint drivers operating on the
> other end of the link.  The fact that there are several interfaces
> that need (func_no, vfunc_no) suggests that callers really do need to
> understand what's going on, and maybe we should try to connect the
> kernel-doc and abbreviations more closely with PCIe spec terms.
> 
> E.g., if "physical EP function" and "virtual EP function" refer to
> SR-IOV PF and VF, maybe we should word them as "endpoint PF" or
> "endpoint VF" (or "EP PF", "EP VF" for short).  If

I personally agree. That sounds reasonable and would help clarify things.

> "pci_epf_add_vepf()" adds an SR-IOV VF, maybe "pci_epf_add_vf()" would
> be descriptive enough.  We already know we're on the endpoint because
> of "epf", so we probably don't need another hint in "vepf", which
> includes a "pf" that doesn't mean SR-IOV PF.

True. But I'd also like to hear what the PCI EP maintainers think about this.

Best regards,
Koichiro

> 
> > > > > I don't have a better naming suggestion, but this is slightly
> > > > > confusing.
> > > > 
> > > > Perhaps a better subject might be:
> > > > 
> > > >   PCI: endpoint: pci-epf-vntb: Pass (func_no, vfunc_no) when programming BARs
> > > > 
> > > > Best regards,
> > > > Koichiro
> > > > 
> > > > > 
> > > > > > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > > ---
> > > > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > index c3caec927d74..fba65abfb6b2 100644
> > > > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > @@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> > > > > >  	epf_bar->barno = barno;
> > > > > >  	epf_bar->size = size;
> > > > > >  
> > > > > > -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> > > > > > +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > > > > > +			      ntb->epf->vfunc_no, epf_bar);
> > > > > >  	if (ret) {
> > > > > >  		dev_err(dev, "failure set mw trans\n");
> > > > > >  		return ret;
> > > > > > -- 
> > > > > > 2.51.0
> > > > > > 
