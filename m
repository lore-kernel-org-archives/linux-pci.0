Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3023C4574;
	Mon,  8 Jun 2026 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942764; cv=fail; b=CByTzqNTxKU8yEPG6z39rT7U/nnn7JNg3Xmyk8cWbvnMyzfLirYboMq7A/f/gtvbfeoy3iX+oc+yZuuvTcWK9a4NRw+TPJxO3WNdZKOz7iODfGgCgoH4LwwTbFo/CiqlUDdE3tP/i3g0eaJjNo2sPZda0HH/Fqrtpnv9xPI2otI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942764; c=relaxed/simple;
	bh=0wYE0+ObWcy0BHORkk6R/rXqa8wgCgVNrUawTAhzixs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bpK01ekaAnOfrHwWR5By03ffoUBTE3zxDT2JVSnmiDfi4TMIn77Kr0qkY80MwAhwB29LhZafhAUd076tOkm6p+UOLbzmd/XbDGFoVEkIIGNlcf35tOMIdbKv+cE37S14LclNOHJ9yT6DzxbbWcykkbgBpbOJgcJDuiNXtekk5Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kn6IFVV2; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kn6IFVV2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr0uZqOH5RLRAiD5yZlYXB+EODCkoSpMhs41AYB4MlmV7butyEvjdDZNABDi380aG///aW3mFgjeEPgkC0Ont16dP8IMDL79PryLZ6GySMTCXNU4KUVOPzRZwzs40zZI82v8kT/YSdFf+cF0sI2ZMEKgRbn7uaEj2JAgQaoZ2BW951JrslwwUaQTmUsEqdws5ZKOb0g6twZCrRgCop1iWoeNmtK34n0bk/aBp2c5oH34x6I2Bc9eTs9FFnlkawkpxwyVcDuhkk3e9pQnCCfpJY1MyuEZvPFyPOKXY8ef2PNhbG9I3xVNuV05MBk+sbtOo9sMifuv+WZwJs//h0QeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5zHtme6RaqTYCQxZu5V8LHuH9mvVPTHjeBZ/akUFWo=;
 b=N+qdT4f9rgULf0PhU5IQrhodSoz9+jjyssf/il2bCoijDlLMOHxX/4beLAGd9JUT2x0B271S6bmbt7BMRKpRLVg/khx7I9G+CYUIf2P1UQOVGdLhJ4znxZSVhVmt8bbrFTarE5pCguSlt5aGw8iNX9sEFaC1FDRzPaVw7K0j83ubqUx2iZbRjN4Dy1MDGLfKrcBmNvmHlgj56H8DJTUCPq5DLBJwdGPNJvGwol2jDL1EhB2efQXm4971NAUD8Tbnk99Ikz1/E4LhuI9fsh150fmmTTPQh88xKmlD6QPxHeUq6jMaQpn5He0qzIRK/gCq3YiNuIwNMiBke67axncMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5zHtme6RaqTYCQxZu5V8LHuH9mvVPTHjeBZ/akUFWo=;
 b=Kn6IFVV29zAaEXhHqj+FORnThCOQ7K+zXqsR1WL5IDJcyjWeBinOzNZNgmeNHF+SHua2pZIr3wnsj9a6w8bMoBKI2Uf3we+LH3KUX2mWPrTPC2CvT9BKdQgNQahQBDXah8Kcj0m9Gb3G0Sl19RLPziie7SyZbC+7IU1MB7nBdTBkNLwWkd6ZE3BJtz3r9i4nnNBDGjtgZ5ljlfaFdk0r2OxhqqUMEqdgyhVUGHKca7CRCB5tNstoxTzFQ2wsy8cnHI9Jryxmth95fYJAVQcN1vJPtabLEff2DCsOBdw4DKeJMG6SBn6B8n+hJB2W2x6dZJme/thL9Bghbjce3NR60A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 18:19:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 18:19:08 +0000
Date: Mon, 8 Jun 2026 15:19:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
Message-ID: <20260608181906.GP1962447@nvidia.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-10-dmatlack@google.com>
 <aiaoc6Y6qeF_5Wn9@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiaoc6Y6qeF_5Wn9@google.com>
X-ClientProxiedBy: YT4P288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e23ff4c-bd7f-43d6-59b2-08dec58a6e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0Sl6ou0t25oBe3u7vvSVwfieqDymPwci6XJEtmbYgCo1zNUTJNXc2i+QlETyIZkfgn+BRzCcP8f4NjNOOlMtohqYSlfqhCSEkhNJhNfH9U6LQQ9X0S7pkgLcBvkh2pn90uOOLU0nw8vizCqQw+Z9jBSjbwAqOUwGMDpmNDI+GIp1UhqqLTM5oknSHXGDZyEOxAE4+yKh1LbtCk7LzPugxVGQq3p0qIEiALLM9/g/TstAlfJULCqCr2PLNb/Olsv+/YaSBBD1rBSB0FlrfcFtGAitEDCwqq2IzUBkNQozx2bpJaDOvlfXsdMxYh+v2hWxIP+yHYYthWfq3sB1j2rrcnl7asrU/HkrMzXR6lfCcBFiJcXuqPGIXznaxm5JpXJyQvU0eqL/SD3SmgHhUR6bfFi3yQ/kntyAjmMB2wtiXOqS0pqemHB306q3AhG001chNIlY6sF25+9eTjkMLrUc+AeacYYkakxDFMasIRz72IxoPFwkF1U+jBY0p06dNd9hWoC9JIZlIXpQ+edy0GQUUG2fywlkYg+uxj4/IuHWlBLqaD6VypQSwBiAujfZG7HgvwHLOLNwvynLpfUWLahD7R6ydl+jpXiOX0uSKIe/+VU3LBvYPr5IrC4oQa3KyVt1NmSgT9KhwXFa/I76GWsx6lg3CaBBflIqnSm6tTJF8LXqLLv2BKQk6MPnbzZP4KHG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1xDz0d7vqnXBKt75xRurnWm7F0FjObO77Upc/ykXLVb64oKlBGvmxI2fQm/5?=
 =?us-ascii?Q?HOxT+mdGvimBa/iA2mH+aOEPFeqHlT7WJWa1cTHPMY0D2bu0UTcYQAA3jc2U?=
 =?us-ascii?Q?0gegpCQbHtjpCk0aeSdvY+xPNywSccfrKDqFGOI7MO+YMB7a0FTgsTRnzrSq?=
 =?us-ascii?Q?pbzsntq07jP5KimKGDqO1SWt6aoR/DU2JNb8zX2lHiLr1oxH1Zyw4+lAR0ls?=
 =?us-ascii?Q?AtpGxe2kimJG/nRCbm9ymDu6r5nChZ51LHPWr/6e6bxtZEpnxbrDu1gOSryd?=
 =?us-ascii?Q?WPhb+ND9skLKfQqtnZB4Jca5HABWhszrnVzq7+QpEg+czdSZegQmGQpQ8SV8?=
 =?us-ascii?Q?ejxb1ya64sHSqCYdvxl3aLj7tJ0gMyaP2D2iAnI4sZrtCvTaXr4cRV6dF7j0?=
 =?us-ascii?Q?5GDT8xVFN3ZcSRUUpioxfVu44/lOKfMaEl91U7o+W3r9vsfdRGqCCjtVI4v2?=
 =?us-ascii?Q?CN6iH8m0HmK3c9c1v97gEjGZ2h0Tc7cDjY2mLKZaDhKg1NYaz3Ek+2PO+2sO?=
 =?us-ascii?Q?TET6CgcfZoOj/cUNVSPVS9B5iD326OoAE4z8wPAJFdp+26ZmoJ4HaLjwd8RV?=
 =?us-ascii?Q?/kIJ4ZDqC30oWZEoe1oNoj2/+FN7KANggsxXXuw2IkpJMSSPQJ3vEXqslgkM?=
 =?us-ascii?Q?Mx9RzuIkUvJXuctMkZLUstQgXQmaHTA2sFzQrrML/0qDRKXb6JHehTVtRSiX?=
 =?us-ascii?Q?CgFyhbaqN1truodClHvC2b/9VG/ScSMuqm6crXhQ5v+Qolrftg2+eAh7Vl73?=
 =?us-ascii?Q?MxK+GXJ7ntkzeR8fdkNomk9jUs3qzUjPdtnzH3iiu1TiKjXSjj17srV1bbH9?=
 =?us-ascii?Q?X6BuKw5OdTADawtLnug63A6GJaCLltw9tWy99etgDWAkhHSOaA2TM42ohbJ0?=
 =?us-ascii?Q?w2oaF2Z0V/NHWBrT3ehdZ3312jg7BNFGQkdsVg3bfXALMUXVhOPY/M33E0xH?=
 =?us-ascii?Q?aLdyrvN/ET92WIP9A6Agbpcsh8O5plANUREARv0MJlpeTr8Ep7XSb1C61A3T?=
 =?us-ascii?Q?4pi/lbTY0Zcm2kw3WYP4j6BcFpYpV+f7lC45h+l6K9I2PZ4W7FfF8ejMBL9B?=
 =?us-ascii?Q?COyPxwdPln2ioZ5rO07+8dnn3DfJjyQhFm6gZF5nuqs3TzDur79DNGD/3vjJ?=
 =?us-ascii?Q?bIZ2pmcZaN8+zR3J1UqJWloSE/zya52cGaSzH5Pva6Q6iZbNL0oZbhPO72dX?=
 =?us-ascii?Q?jwF9vIq6F+800vD+n11sFk2jgasf/p60ksscUxkhljCIq9k99SQ4mC0RYm8p?=
 =?us-ascii?Q?L5Fp1xMRhv0jakmsMnhHEKK0Zvz8OdqG7WAZeUELjDtOG47KLdR929RojpOS?=
 =?us-ascii?Q?Dgb/nLaEZ5HRwlLSkfS3ax8K4QhZK12rlOt1Va2SdsARNFFvYAxWRKy7d/Yq?=
 =?us-ascii?Q?llE+Wf2yxc9KmNKE/wTtjQU+9xQhQqJsHUVPA3C28MfNQANaG4gheV3tEaGO?=
 =?us-ascii?Q?HOQYF0Jp+9iseXlXtp1XTdi/MQJPMwKBpllOV0dbO1pmDh746TEGeV5A/gj5?=
 =?us-ascii?Q?9Zu6aSaQhwRgH962bDMPP0pkpEtlmXacTNrE/7VzQ0J/NwoX1Ct4rpHIj99j?=
 =?us-ascii?Q?yiZoSGwstVTrWgo3bs677FqwPFSrjvBfgYACGxF0uWKWXUrUDXflI0Jc2cOr?=
 =?us-ascii?Q?awjI+fujmDO2KmKiitUjxCz0mr30OFlS25PcmkYQRvmKFsaGmjFHwUR+CiWY?=
 =?us-ascii?Q?bDfT/8StuuNPqlubHIMrL6F56gKJuH5nX7+og5uo/R97rDIz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e23ff4c-bd7f-43d6-59b2-08dec58a6e01
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:19:07.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGjkI7HI4/aSdRCMRnFAGzhNtco1GPvgHbPRp9qesI0FIqqdDdqJOG9UcDC+iS9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211

On Mon, Jun 08, 2026 at 11:33:07AM +0000, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:07PM +0000, David Matlack wrote:
> > Inherit the ARI Forwarding Enable on preserved bridges and update
> > pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> > the preserved devices on the bridge's secondary bus can be identified
> > with the same expanded 8-bit function number after a Live Update.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c | 18 ++++++++++++++++++
> >  drivers/pci/liveupdate.h |  6 ++++++
> >  drivers/pci/pci.c        |  8 +++++++-
> >  3 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index a93b7ef065f2..701276ef6cfb 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -128,6 +128,10 @@
> >   *    way after Live Update and ensures that IOMMU groups do not change. Note
> >   *    that a device will use its inherited ACS flags for the lifetime of its
> >   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> > + *
> > + *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
> > + *    preserved devices to ensure that all preserved devices on the bridge's
> > + *    secondary bus are addressable after the Live Update.
> >   */
> >  
> >  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> > @@ -756,6 +760,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
> >  	return 0;
> >  }
> >  
> > +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > +{
> > +	u16 val;
> > +
> > +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +	if (!dev->liveupdate.incoming)
> > +		return -EINVAL;
> > +
> > +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> 
> Again, I might be thinking out loud here, but since these are
> hot-pluggable devices, with some FW / SW running on them, I'm a little
> worried while assuming the HW registers can be trusted across a kexec.
> 
> Say, if the bridge experiences a reset (e.g. link drop etc) during the
> kexec blackout, the PCI_EXP_DEVCTL2 register could revert to its default
> state, meaning the ARI bit will be 0.

This does seem like something to be concerned about, but realistically
I think if you get a PCIe error I'm not sure the incoming kernel is
equipped to handle it at all :\

Just resuming the driver is going to fail too, I don't know how VFIO
can learn and forward the event, and so on..

But maybe it is worth being a little more defensive here

Jason
