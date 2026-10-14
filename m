Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07451812D;
	Wed, 14 Oct 2026 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990401; cv=fail; b=uDSAyw1hRzdpTZLZ6jh7ggDwtyp/hepTy1QOAmzlrSB7zevfMrvmcbJ6lZkR1xy27cqs+g23LOLVsjVyZCPFO8LEHNRBPEP970JZRLhNMN402Rf93XG3u66b/Y+zPiM7saTyjyXLTF965illfUpYPeMJ2xa1jq2X3PqR6g8rCMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990401; c=relaxed/simple;
	bh=M6l1E1aVe9xAUAFkcxuZBnIQJc3ypbdubjqg3k37U2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q825cJwPvSvLDqaNcGs3aV65AkrQwkI6hUDQd1GyeNoyfyrD5gaDJp2tE235LF1a/zlchD0sTaVJgb9D+h5/RU75eR+0WFTYb+NcLDIl4/As+QUBlwbO80gYYBgLmym9DRNQui8TxOvzKbYwriJMmrz4k9RxbICKTIYboa81AZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PujyN0oe; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PujyN0oe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYZI3V9IBvtkNSkti5xCLbhu0oMIQ6utE1HOaITZYAPXSHRWVklYRgLcFDspwqScULiQ83kCQwHelV+vO4T4bfJTm4QtxNH/b52ZxDXuym0lTs7G4Mu1g7FPV6f1uib2Y3cRxLDh07fGBG9NH+Di+/o8K9Gx+J/oETKIHeg9dhrQ/db4nWObXhY7c0nAI9C1XAZ2raYEIgw5HBJe9w3W5xUqXs0YO2dmFxVHsrOJptrWccAnl0chUFdZfvMHSIDN0wicwcSegNNIpRxlqpKjqK90Ks5R7/AQqBNY7xPfhkr+2Rss6WTWJ3oi1PlgHA89bj6/bVJCg7OavtWwp1NHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2xwvzc5nrtfbOQzNtld7adK/xxtT5Ooj0UAMA8X/ho=;
 b=NEaMKpzxRZYbBqb4/VOrssfaAWa2sV748/9OyhL4Vha322y33jqLYxbWNGEbLq5LTmtnEOLUMtC+TLnpElubmewrneHQt9dBEuaYF9PyXotPR7JjcxLQaq6sKCW7J8f0BJKX3jjJPCUTu521RfjLy8aZuNuzI1VQqlSfkKHbMVrsmZ8xFiVt9wFWxa24b+YyRlfpbvf1eCIQKpEqwfdqO3dW/Vdx6U7CuzNGeYpUQx9/2P4F9PvBwSvYeG5a+h3PgB9F8wdDZBF5JQ62lThnBPsD1/nCDcafhDK5t54ZxVYorhhHP3FDv5QdqePoDIQ62at1gHkbFTH9fTmB9zjTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2xwvzc5nrtfbOQzNtld7adK/xxtT5Ooj0UAMA8X/ho=;
 b=PujyN0oeE7FHD6Sdq2VA4ZF6CtwNBphsHKqqrNQveOxvQg8Zf8jyaJMqFKSbAGIxP6hI0GK31C8+r5oJUYMsjdw1FZUrODLw2+NEnxgrvXH1/CwWW6zrtfs8gXP6uGGAjyBxPsZ4ZcAJDqoALPypPvgeADSJlrXRtinUj32nC0Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY1P286MB3156.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:31d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 15:06:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:06:35 +0000
Date: Thu, 15 Oct 2026 00:06:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Message-ID: <x53diijgm6cqfjc5rlihi5q2q54nxdbgvs5u3cfxg5zfdo5w4z@hayq2svzwfes>
References: <20261014053256.2378817-1-den@valinux.co.jp>
 <as-UJX1jD8ZFiBxk@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-UJX1jD8ZFiBxk@SMW015318>
X-ClientProxiedBy: TYCPR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY1P286MB3156:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8613ae-5fba-4dca-9468-08df2a04bd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|376014|366016|6133799003|10067099003|22082099003|18002099003|5023799004|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1J9NDPDTQNKiGa4cesjdc9WKHWaxSragFLyCv1WKy429fU18T+gbFTlKsQ0ItNKoD23dTA6+KIho0+ylgMM7KRzGV4zy9ChTwB37iZI+sm8vqrGIXaAy0vo2hBgaUfQExwWTJbu+7vzGgoWYx8o4dkup0zrTnjGO8/9NilGNrXVXn6HWuUoOdWbdnRLC7wpj/wSL0pg7uwgS8tf/AXEVGAkVJGrBEqSmoBGKmNrgMX+n1fb7pPNbIBUHjE8GnaDAFix8CyTcaKGL6RiNrbuni9GRwvEdijOkZZRXkrWPE5gTphQ45LNry7T2/XtubbWATS9geiWQO2gQbzg9ky1ksHaW3uv4aSa7Bq+xrnEOUw3rWm3t330bwLE+29KTKn0RNmRQyQdkTOT6Nj8eJJ0GkX2pWiMubXFsaEBbWrLoQMRaV8JWmirS8DCwSn6yeVlmEZ1DVQ+znOvApwPVyqsXfsaPWne5g2VGUc1DUueoaXxtKkBWOy0AtKf0r72nJVKy6Zc/fdzyg4tyJ4F6pKO4pTl58GbR5wjGlL7Ol+5cBHvUzacmGsWDVYxEr4NtmuApIyBDQajBllSXd4fynOwg6+p6tOMX/sN9ogb5LeckhycF1Hh0CGh1RlAPgaBtilmc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(5023799004)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f37b5pQrpxNhvFoJBKq0eFY4conKPqkXtFxam7/enJCqM/O+ITwtIw7fQXz+?=
 =?us-ascii?Q?7f21swM3OZ7rCT0OGuw/ahr2vfVRlk+JD7Y0ycF+Oyl/uJUXz+4fz4WM4GwF?=
 =?us-ascii?Q?heo2lrjIC1EQqSDXgpg5gLWUa9mnknqjOGCqgVPAND/pT0ZroWkJwvQVJa/C?=
 =?us-ascii?Q?OpNmZxUjy6sombLD+2fNAQvcD5zHNvWU9mso/DcgEWYc2JBaVFeeurxDEQ8M?=
 =?us-ascii?Q?X1r4CFS61xR3krGMktLWDBBQuLKEbk1KL2JdYkcxx3M6tX5SC6eIWvzXEiBZ?=
 =?us-ascii?Q?nFc4WI8n433PaR0VxNLqDV1adKXraBpFwMI+WtoqnSgWO90Dh9rJEwW5G6Lf?=
 =?us-ascii?Q?vYjcj+igfJEqRLbTUSLUlxIK8t0Rd7cIwLYnKdedydDmRQ1fip0on+knwCTi?=
 =?us-ascii?Q?efasQVAnBsLEOlqsZM7gpyqvMWKA9bx3VzANTr8NdrE/z1e3n1Dz5ClmHcJT?=
 =?us-ascii?Q?tod3SkEgWnrv6KReM1BYyLdCoTeHhPEzqtGsBhnp7qQXzksMZJNFm+TEYqXf?=
 =?us-ascii?Q?yIpIQ4BUIyH4ocR2+4sr4iEQsHySpABjsnSl6b1SpNUWX6HGNnhtWMPzTocj?=
 =?us-ascii?Q?N5AKQhTkVfj/pbDvX8KnUuVieNSwwvdye01j6bbnaylMJs12sinIPRFPVOnO?=
 =?us-ascii?Q?qaO3HFURM8siHNapUS5jr0Gg0Y2zeWfuh1dZKVO5FFF+H8EYwtqD2y7l2jI4?=
 =?us-ascii?Q?/hBWMQXJeKug/s/CDsaRTVK1Ws/97okqMibVh5l3OmZs8WKOIC7MgHyCU5s8?=
 =?us-ascii?Q?yAIB0Ne1rhJclkbS6jhI+zz80cAWsFBaEIHOGX9VQC8AwypOp0japIfm2fct?=
 =?us-ascii?Q?abfWjio7URRGtTpKg3Km3jibzFTfteNBeFlfpLFhlmC5lBTokJP3d8YoxW4f?=
 =?us-ascii?Q?dWbWlgZhmux2Iczc9j5biavaRUrRNHiuV6DmE6DzhrGNzVdQyCEljLLaeKTb?=
 =?us-ascii?Q?QqaE5QLRxTPOemA3dX39vcOGt2mdc29ItOk1WKXEmZu6Mvh1LQlRRFukfWFo?=
 =?us-ascii?Q?HxfdbNX97ZFaV+LuOIKVzw58WE0b+X0t7g3Kq6bjkRWggnC499KB2/7URvOI?=
 =?us-ascii?Q?cSCnaPEyqQ+JNaBDrv/IABMRTcXLxQhvxVml65KuRM4TbDbg5LwTfBH9wHeM?=
 =?us-ascii?Q?5i1LhRJeinI4+H1/woJityUBTXYgSDP0jg8egWEXSeb55zCnHMeD82SUXXTg?=
 =?us-ascii?Q?NdaIGHEIHXS5W57EHsKD/5EejzlrsVbvdpGVUCy0NRRhtZz6K4xQwy8Fh7pA?=
 =?us-ascii?Q?/GzaYiHsLgeKTlQ7iKMVRsfjlb0aQcTM5SvqVOiH63/TegR6QfQ+LwxzYVsU?=
 =?us-ascii?Q?lR7U9xkC6YybvmNYDZD6uEAqkoZJJvVWrNDET4Flv9WmTnmFNgFw+ZaVaWfX?=
 =?us-ascii?Q?+aliz2JC9Hk56FuS8YRSbb4/W2EduzOzjAW6TDPKtNv43JlZ0hNXJULurXCg?=
 =?us-ascii?Q?yIKvEULpkl35+9d5YRcSguciys0p0gYm1tqzqMQ+GilLe6KP/Gjph+3jANA5?=
 =?us-ascii?Q?NKM+hK8z1zp1QEkT2FXj9iI8EpENUnFfjaQMHBFnS/w7MBgx67nccjMVqyj2?=
 =?us-ascii?Q?hQRwtQt5vy3QkKVYXKNXdmdoPGge3jqjprqPib5W0EjL6l2+SDEs9izocXIE?=
 =?us-ascii?Q?6uy0i7vZ6pHjgE+b7E79ztk/sf9I42TDv4nbvcoJ/L2vYDk/rEs7mU5h1BSh?=
 =?us-ascii?Q?1cnR0zkslflPbyvYj64v3w6VqvKtyLRwfKkxsEgnl4qPgI6CrEnMArFL63n7?=
 =?us-ascii?Q?Xa0UefXm+2fYIqQYrptSRuCMizutj1H5c2dTpWrVHvBwkZJELc2O?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8613ae-5fba-4dca-9468-08df2a04bd48
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:06:35.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+A8pHnC93KGSz03jbxfxyta2rtAELompE9HMkiMNkW6LRhl1/jSFEmPPtLuiPyL9IWZ7eIUX/WOQfeQNbCpeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3156

On Wed, Oct 14, 2026 at 09:39:33AM -0500, Frank Li wrote:
> On Wed, Oct 14, 2026 at 02:32:56PM +0900, Koichiro Den wrote:
> > ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
> > result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
> > configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.
> > When MSI-X is selected, the host does not program MSI, so raising it can
> > issue a write to an invalid address. This was observed as IOMMU faults
> > on the RC, with no doorbell interrupts delivered.
> >
> > Configure MSI-X when supported and use the selected type for peer
> > doorbells. Allocate the MSI-X Table and PBA in the config BAR and
> > configure db_count entries. Use this EPF-owned layout even if the EPC
> > has fixed, hardware-owned Table/PBA regions, as pci-epf-test and
> > nvmet-pci-epf already do.
> >
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v3:
> >   - Reject MSI/MSI-X requests unsupported by the EPC. (Sashiko)
> >   - Link to v3: https://lore.kernel.org/r/20260919172021.1055451-1-den@valinux.co.jp/
> >
> > Changes in v3:
> >   - Split out the vNTB MSI-X fix and use an EPF-owned layout. (Niklas)
> >     Niklas and I both hit an issue with hardware-owned MSI-X on RK3588:
> >     https://lore.kernel.org/r/mmcripxdekhktnn73ikylthajkdnincwu7p2nelcpcqzexpf22@rrmmzr6hfvzf/
> >   - Link to v2: https://lore.kernel.org/r/20260830151948.3547577-4-den@valinux.co.jp/
> >
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 63 ++++++++++++++-----
> >  1 file changed, 47 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 07ba338732d4..c30a73c537a0 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -148,6 +148,7 @@ struct epf_ntb {
> >  	u16 vntb_vid;
> >
> >  	bool linkup;
> > +	bool peer_msix;
> >
> >  	/*
> >  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> > @@ -155,6 +156,7 @@ struct epf_ntb {
> >  	 */
> >  	bool msi_doorbell;
> >  	u32 spad_size;
> > +	u32 msix_table_offset;
> >
> >  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
> >
> > @@ -276,6 +278,7 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
> >   */
> >  static void epf_ntb_cmd_handler(struct work_struct *work)
> >  {
> > +	const struct pci_epc_features *epc_features;
> >  	struct epf_ntb_ctrl *ctrl;
> >  	u32 command, argument;
> >  	struct epf_ntb *ntb;
> > @@ -308,6 +311,15 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >
> >  	switch (command) {
> >  	case COMMAND_CONFIGURE_DOORBELL:
> > +		epc_features = pci_epc_get_features(ntb->epf->epc,
> > +						    ntb->epf->func_no,
> > +						    ntb->epf->vfunc_no);
> > +		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
> > +		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
> > +			ctrl->command_status = COMMAND_STATUS_ERROR;
> > +			break;
> > +		}
> > +		ntb->peer_msix = argument & MSIX_ENABLE;
> >  		ctrl->command_status = COMMAND_STATUS_OK;
> >  		break;
> >  	case COMMAND_TEARDOWN_DOORBELL:
> > @@ -451,8 +463,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
> >   * @ntb: NTB device that facilitates communication between HOST and VHOST
> >   *
> >   * Allocate the Local Memory mentioned in the above diagram. The size of
> > - * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
> > - * is obtained from "spad-count" configfs entry.
> > + * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
> > + * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
> > + * from "spad-count" configfs entry.
> >   *
> >   * Returns: Zero for success, or an error code in case of failure
> >   */
> > @@ -473,6 +486,12 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
> >  	spad_count = ntb->spad_count;
> >
> >  	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
> > +	if (epc_features->msix_capable) {
> > +		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
> > +		ctrl_size = ntb->msix_table_offset +
> > +			    ntb->db_count * PCI_MSIX_ENTRY_SIZE +
> > +			    BITS_TO_U64(ntb->db_count) * sizeof(u64);
> > +	}
> >  	spad_size = 2 * spad_count * sizeof(u32);
> >
> >  	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
> > @@ -513,12 +532,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
> >  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
> >  {
> >  	const struct pci_epc_features *epc_features;
> > +	struct pci_epf *epf = ntb->epf;
> >  	struct device *dev;
> >  	int ret;
> >
> > -	dev = &ntb->epf->dev;
> > +	dev = &epf->dev;
> >
> > -	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
> > +	epc_features = pci_epc_get_features(epf->epc, epf->func_no,
> > +					    epf->vfunc_no);
> >
> >  	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
> >  		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
> > @@ -532,16 +553,24 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
> >  	}
> >
> >  	if (epc_features->msi_capable) {
> > -		ret = pci_epc_set_msi(ntb->epf->epc,
> > -				      ntb->epf->func_no,
> > -				      ntb->epf->vfunc_no,
> > -				      16);
> > +		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);
> >  		if (ret) {
> >  			dev_err(dev, "MSI configuration failed\n");
> >  			return ret;
> >  		}
> >  	}
> 
> This part belong code cleanup by local variable epf. Can you move this
> part to prepare patch? Or pci_epc_set_msix() use ntb->epf->epc, then
> replace all after this patch.

I remember Bjorn mentioning this clean-up somewhere, and I thought this patch
was a good chance to do that. But yeah, it makes sense to split out the
clean-up.

> 
> >
> > +	if (epc_features->msix_capable) {
> > +		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
> > +				       ntb->db_count,
> > +				       ntb->epf_ntb_bar[BAR_CONFIG],
> > +				       ntb->msix_table_offset);
> > +		if (ret) {
> > +			dev_err(dev, "MSI-X configuration failed\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	return 0;
> >  }
> >
> > @@ -1529,6 +1558,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
> >  	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
> >  	struct pci_epf *epf = ntb->epf;
> >  	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
> > +	unsigned int irq_type;
> >  	u8 func_no, vfunc_no;
> >  	unsigned int db_bit;
> >  	u32 interrupt_num;
> > @@ -1540,6 +1570,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
> >
> >  	func_no = epf->func_no;
> >  	vfunc_no = epf->vfunc_no;
> > +	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
> >
> >  	/*
> >  	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> > @@ -1553,16 +1584,16 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
> >
> >  		while (db_bits) {
> >  			/*
> > -			 * pci_epc_raise_irq() for MSI expects a 1-based
> > -			 * interrupt number. The first usable doorbell starts
> > -			 * at EPF_IRQ_DB_START in the legacy slot layout.
> > +			 * pci_epc_raise_irq() expects a 1-based interrupt
> > +			 * number for MSI and MSI-X. The first usable doorbell
> > +			 * starts at EPF_IRQ_DB_START in the legacy slot layout.
> >  			 *
> >  			 * Legacy mapping (kept for compatibility):
> >  			 *
> > -			 *   MSI #1 : link event (reserved)
> > -			 *   MSI #2 : unused (historical offset)
> > -			 *   MSI #3 : doorbell bit 0 (DB#0)
> > -			 *   MSI #4 : doorbell bit 1 (DB#1)
> > +			 *   IRQ #1 : link event (reserved)
> > +			 *   IRQ #2 : unused (historical offset)
> > +			 *   IRQ #3 : doorbell bit 0 (DB#0)
> > +			 *   IRQ #4 : doorbell bit 1 (DB#1)
> >  			 *   ...
> 
> Needn't update these comments,  the key information is #n, there are not
> big difference between MSI and IRQ.

I guess your point is to keep the diff small. Otherwise, I would also be fine
with s/MSI/MSI(-X)/. I don't have a strong opinion here, so I'll leave the
labels unchanged. I'll send v5.

Thanks for the review!

Best regards,
Koichiro Den

> 
> Frank
> 
> >  			 *
> >  			 * Do not change this mapping to avoid breaking
> > @@ -1573,7 +1604,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
> >  			db_bits &= ~BIT_ULL(db_bit);
> >
> >  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> > -						PCI_IRQ_MSI, interrupt_num);
> > +						irq_type, interrupt_num);
> >  			if (ret)
> >  				dev_err(&epf->dev,
> >  					"Failed to raise IRQ for interrupt_num %u: %d\n",
> >
> > base-commit: 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932
> > --
> > 2.54.0
> >
