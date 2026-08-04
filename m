Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021134.outbound.protection.outlook.com [40.107.74.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E475350A35
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807667; cv=fail; b=fV0dZzxR38nl7AeLXTkr/SUxGIUqF6kMUsDRpR25kG9v+/Vf4wwQWZGngEIOGAgnGmaHCD7MajiJxZyqoCh7FYWwTEP6wPMx3F5A8CPDouYuWnWavC3GPR4Wam8tjoqLu17iTSyLEYJvr8P66HJmm4D/aXBQ2Z1YJtduAy6zkqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807667; c=relaxed/simple;
	bh=HitzByGBKrkKaLKLi+/6smXv2wcohOSwB6JrQMW01uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRUc3W9TARq/gV/UsLOc0371/524uRAL1qB833X4exXm7swh2zwk4R2V9kONx18DAT4teUgZAVRFk32jcitjACtmz5PxcUiAQq8dEQGACVg/W4DShftW4otYNn9PD66yhDWER9//Tzosbet4cr3jSBneu8zzPFXa0fz0rVQTc40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ICESS+lf reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ICESS+lf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUyCCkUim6hZx7ZbyteHU+1+9c4B3rNSoecI5vZJDRdW4qJLuyJFhiQNDLXmlPC+X2KrLj8pHZSgr3nFK/ojvRH/q14+4WOW4TM13XZiTa5h/tT6/p5GECaDPmx4Aq7P4SO+cPhpZdMvezxxX5QMikKzwynXWzPmACQk2Lhio4P7j1KM/y8iyJFxnO8HMR/QinYySkKnlXf8qdcquxNYe+Qc2Vw78n/8Z2YKLMJQcKwiPins9NsAat1gyf4vhf7STnuIkZJbBGb7Sx4QxJZrtZHmHyqQtlDEc9vVwMUiq5ulYn0XStbAay9u8F3XDXnK0RSNjWDt14QFjGnz186UNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AnG8xZP3jbycUTCSQKmvBJU9ylX4BYKiEWnhWrWB9c=;
 b=MubMjfZctE920d/O36VkC+Ny3oeMBRmaofv2whwzOIJtwtqVzsmM/wlWC4r37WUODeytzE770HwqNPaPqpk/jMN4N1VXsDfGYa+OmYZZO07gqEDbhgJKFuMo/f9nDh3WHWhcKWyzJku4DZbkkVHSre3bGDGfzs3fovqnjGgjdbuAqsyVEUxdliAtSNAcIl1L4dspYvT23LOTnmSTjXkITNg4i5s08tkfw96gRbNwfC9FoymFfnRfY+ksI+ioHF4hHRVdfF89R4tZ7eRn+bOqEhab5jFrSM8L5FffEtgXzGywLBrAIaMU4cF3X/oonPKnbGmzsPFwxPojpnvSiq4TTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AnG8xZP3jbycUTCSQKmvBJU9ylX4BYKiEWnhWrWB9c=;
 b=ICESS+lfKl7hNxxgWXpuyXkT2+vSeqNg4Q+hHu48rJ1+KTnTe3LEZk5E54Uy2NF18W9rmQZGRY8Xbw7r3cNnx3MQGUgAeQt8JeBco6//LXgXtbOjn+4J1l+L1AI49JLciIoq2ABV46wzVh7Fx7JsFsjJ9tYqqWyc0CxuuiwjAd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2974.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:309::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 01:41:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 01:41:01 +0000
Date: Tue, 4 Aug 2026 10:41:00 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 04/11] PCI: endpoint: pci-epf-vntb: Implement MW group
 translation callbacks
Message-ID: <hkosyefqeihyinvzj7kc5lq4c3ox7t2kcmmprqkitziic4kpjc@tqbthc4hjl6y>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-5-den@valinux.co.jp>
 <20260803182528.750A91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803182528.750A91F000E9@smtp.kernel.org>
X-ClientProxiedBy: TY4P286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2974:EE_
X-MS-Office365-Filtering-Correlation-Id: b71866d9-caaa-4026-ff8f-08def1c970c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|366016|56012099006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RkLObWNQuQH00lI4kstn7l6VUhWPZin3RoME0Ofs4tGcyTy3KIBMTlHbBOlKTIEylmYu4p0cXpinpsU/BbxRkERqHKPT8SuoL2BAHbbtBIkOE4S4+09pFCizT+EdAs1gSF1pgXQe5NUd7Ca+F+RSRJt61QH6plQ6vPNlFaOkj2DhsEsg2rpW2rjdqyZNxtb48+/1d23MP2AFHgTsbqUcnmJIJnxdqTCYEf6cvtiSVfFKsjiI9KiSbnoh9yK7QebE0MH+657vRVKmoioMtsR30uai5MqLlCMTlsmXffjz4BozSOKEUWQwIw5B5Wix9A8RObmJGjcQg042qW8L4Dw5r+/z4kLUmlPIQMZFRvWD/uF87LVcEk885t6bLttZU3t66jXVxQ+yMzH2EY+M3JW+qqajpIFPw9OtaVr0YJfyoXP2z+VLsDoDsO8rGqpGCYEPngG9vIJMwwOsZpgENiJDmEcM9wlHAcMyuIU+XqOF49hEh9w7TstIv540fY1XVV5i9YUexYvA0GktQvmWwnDwqmzV7qA3QTeYHW6oGlfXdvXFPIAWTM/e20+LHUguCsDBjyn/Z05zFzRudDU3GkNMFhrXNLKAn+Ewg2T6Qi/vI2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?EpP1r/YBW3w4rHo4ur0MGWyrsTNxsdoirDM8T8fKAqxr4W9uLe1uKr7rEX?=
 =?iso-8859-1?Q?GCRlEhVeryFeztQtDC/Lt3oPibFNhOtaS+JVfCa5n2v9wXTRXXEz/ikFB7?=
 =?iso-8859-1?Q?eMC/32nwERHEATbs43ZJsupkx2nx2QwHx/O+/quofKuDwCfCNt6ZIvNRYQ?=
 =?iso-8859-1?Q?H/U9CE1znqQCoF/ET1IDblzIw/ScBcKxMWvKF6xER/oViC93mTkwzHdBBt?=
 =?iso-8859-1?Q?2QGJaogQ1zWfO6CcWO4vr0B+a80seHdM0X/NEyTLYjlCDbmsbabJopJhzv?=
 =?iso-8859-1?Q?j+5wSY9AUyii25CT0y0LyCIKzMnsi5l2XjQ9UmTkIcFbQgb3h/f+Ye0s3u?=
 =?iso-8859-1?Q?oZ/5Ob6Qg8USP5ZueM7CMzyuTChXpsvryADs/g9OZXFbznmx7jWGO9wkBw?=
 =?iso-8859-1?Q?TU9DN/xsuu8uWHbmMx+OES3mu2MC4dJrH0T4WPeslA9whAlBSxmixvE4UF?=
 =?iso-8859-1?Q?3/yKqOG+/7yLMhrgSd20O7nCjn2wDr5BRKKJn3jCCxH+QTkNeXLWU9QUuf?=
 =?iso-8859-1?Q?BCxxvrpG9TQmTTW0H/sEG+xiBLRVd9Rdzm2grZqHvCorvhgBSGFFC+k2HP?=
 =?iso-8859-1?Q?AaYjuoHorUxCQDCvbGTrJKA5Sa9qKexNDsCV0spfXHMQ5lb2CKH9Jn/gm4?=
 =?iso-8859-1?Q?XJNcSqjHTLxAVOKo9hcDc3qlE24bCW9Sx5hM9JzEQ45cKs5JP/ky1x/o+n?=
 =?iso-8859-1?Q?6m3r53oJawT1Eu7T8ogScTmtq2rENPpUF3AF5KPE29L5ZMSUdRWECYO73u?=
 =?iso-8859-1?Q?n9N81S7H4wSfVjuRUP/31ERr+zOfIBGOdLjdH5q6T1TKiDTU2bX+prQnqy?=
 =?iso-8859-1?Q?aNawdf8m4TCXnpm/QRH7YG3GR6PyXcOW0yTsix3LKmWXiIMsrMW5jZk6U2?=
 =?iso-8859-1?Q?/O3gVGBzL+gDFC2fjtNdzhCmftTo63yfjzdlrrkdw8PuIkiU4dOUzAFtGl?=
 =?iso-8859-1?Q?gSpAIu1UqW2iwgE+ypGkH5Pb4WmbHaT8FzgSUY8FDCIiaFjln/T3dGxYaM?=
 =?iso-8859-1?Q?UKakZ2QZhDtsMn1E997fGc3GgO3u8rJEI0lUuZ5UtQpxLaHksXx0hpA1V3?=
 =?iso-8859-1?Q?17ohXr6lkHZzqKb6aUKt1GVy1mIf92BxTB2IF+OYFWVbTX9daAgAQNy0gz?=
 =?iso-8859-1?Q?BXHM4raxnk5c5o3180vJ1nqfpLz0rvIMz6wQk7Trvy2VDLWitjL1G4ueNJ?=
 =?iso-8859-1?Q?5wUkP+fDvKFnGPOCtpIXG2WXie+NQSBu6GVyiqXCH3i26v/WPJxYckbsgY?=
 =?iso-8859-1?Q?BKzF4AcOsI4RDNafwKRBN4d5fklB63c4JpVmIkHydOEw2E9S0iVe8M44fx?=
 =?iso-8859-1?Q?9jNppM97qOhTWJTOcud/jP8pJ0asCABpnec8xzTX8RTSRI1KU8CSRy0yXC?=
 =?iso-8859-1?Q?bQVdaxr3hz3Ms4/15P3z4am91m83mLXQfbzyv0P0IEkpMhToC/9QEhGa5P?=
 =?iso-8859-1?Q?5VJW2Sk7fzXbjPiM4uC/x8keMjwaYsyuzpS1IOfh9WszUz4n0sgFdDsQ1F?=
 =?iso-8859-1?Q?ypMtwsMh8FQi3En1bclwZSOv+feczu14T8qVoM3eGyp3MrAKfbq1Bg80j2?=
 =?iso-8859-1?Q?Wu5fyklmehAMBerMnS7X5kJJACf8wforLmIQjdIT6eWhJ+6TCi2G3/NnYA?=
 =?iso-8859-1?Q?Z62PppQ84PPAcPFT9zRfxgPEwMXGsNZRI1B+0d6ZhThm3zpJ98wfA4fk41?=
 =?iso-8859-1?Q?z20fCGCaXCpZE3Yqr1kVqZJT+c0BkpmzYKtAPwIczGbduFCN8bugGp9Lnv?=
 =?iso-8859-1?Q?DcOk46yEwt3UxHTUrwS5W37Ta/3cygnJ2y/nNRrUSE3rq1W3rgFpkPlcLB?=
 =?iso-8859-1?Q?UgFjzB30OI9pnKmBEXUi+4+jIGV2WKXapn3t2qmI/5qocAgpK9KE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b71866d9-caaa-4026-ff8f-08def1c970c4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 01:41:01.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qt6zaydldPWMjaavbXyCNsJ527fAwlsfrVzSuY9tOqYkk0XtRnv45NHaitk9cLKK9B4ASxyGAfoRS/YApr4bkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2974

On Mon, Aug 03, 2026 at 06:25:28PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] DMA Use-After-Free due to `vntb_epf_mw_clear_trans_group()` and `vntb_epf_mw_clear_trans()` returning success (0) without actually disabling the inbound hardware translations.

To be clear, vntb_epf_mw_clear_trans_group() is intentionally left as a no-op,
matching the existing the existing vntb_epf_mw_clear_trans() behavior. This
series does not try to fix that pre-existing limitation.
See the "About existing inbound MW clear behavior" note in the cover letter.

Koichiro

> - [High] The `vntb_epf_mw_set_trans()` function incorrectly hardcodes `func_no` and `vfunc_no` to 0 when invoking `pci_epc_set_bar()`, whereas other EPF APIs (including the newly added group API) correctly use the endpoint's configured function numbers.
> - [High] The `vntb_pci_driver` structure is missing a `.remove` callback, causing NTB device leaks and use-after-free conditions when the endpoint function is unbound.
> --
> 
> --- Patch [4]: [PATCH 04/11] PCI: endpoint: pci-epf-vntb: Implement MW group translation callbacks ---
> commit 419429d9534b2c856c11cb4a4a4107e84a87fe8e
> Author: Koichiro Den <den@valinux.co.jp>
> 
> PCI: endpoint: pci-epf-vntb: Implement MW group translation callbacks
> 
> All RC-to-EP MWs in a packed group share one inbound BAR. Setting each
> MW separately would keep replacing that BAR and could expose a partial
> group. Add group callbacks that program the shared BAR once for the
> complete backing range.
> 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index f22459e5a8c69..0c72b907c2896 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1622,6 +1622,31 @@ static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
> >  	return 0;
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while looking at this context,
> I noticed that the existing vntb_epf_mw_set_trans() hardcodes the function
> numbers to 0:
> 
> drivers/pci/endpoint/functions/pci-epf-vntb.c:vntb_epf_mw_set_trans() {
>     ...
> 	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
>     ...
> }
> 
> Does this incorrectly configure the BAR for function 0 when the virtual NTB
> device is bound to a non-zero endpoint function or virtual function?
> 
> If the device is configured via configfs with a non-zero function, could this
> lead to silent failures in memory window translation or corrupt the ATU
> configuration of function 0?
> 
> > +
> > +static int
> > +vntb_epf_mw_set_trans_group(struct ntb_dev *ndev, int pidx, int widx,
> > +			    dma_addr_t addr, resource_size_t size)
> > +{
> [ ... ]
> > +	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > +			       ntb->epf->vfunc_no, epf_bar);
> > +}
> > +
> > +static int vntb_epf_mw_clear_trans_group(struct ntb_dev *ndev, int pidx,
> > +					 int widx)
> > +{
> > +	return 0;
> > +}
> 
> [Severity: Critical]
> This is a pre-existing issue perpetuated here by the new group API, but does
> returning 0 without actually disabling the inbound hardware translations create a
> DMA use-after-free window?
> 
> When an NTB client unmaps a memory window group and frees the backing memory,
> the hardware BAR mapping will remain active.
> 
> If the local host frees this memory, won't the endpoint hardware continue
> translating incoming PCIe accesses to the freed physical address, allowing a
> remote peer to access arbitrary new allocations on the endpoint?
> 
> [Severity: High]
> This is another pre-existing issue, but I noticed the vntb_pci_driver structure
> is missing a .remove callback:
> 
> drivers/pci/endpoint/functions/pci-epf-vntb.c:
> static struct pci_driver vntb_pci_driver = {
> 	.name           = "pci-vntb",
> 	.id_table       = pci_vntb_table,
> 	.probe          = pci_vntb_probe,
> };
> 
> Without a .remove callback, ntb_unregister_device() is never called when the
> EPF device is unbound via configfs.
> 
> Does this cause NTB device leaks and driver state use-after-free?
> 
> If the endpoint function is unbound, won't the NTB clients remain active and
> bound to a device whose backing EPF structures, DMA masks, and hardware
> mappings have been destroyed?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260803180439.1963864-1-den@valinux.co.jp?part=4
