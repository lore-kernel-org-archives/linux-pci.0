Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021127.outbound.protection.outlook.com [52.101.125.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC17A13A;
	Tue, 17 Feb 2026 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771292354; cv=fail; b=Qc/2vb2M1LWussvWP0IZmTSErDKo7Wwr62sgLGdLsRr4eL30f55sxb/fNTnkyG6M6SePZB32igdnEP0bckzk9W9FjQ3O7VX0DO2TAnz+JXiflvoH3CaScEmpMMVXBwZsqpr34Kwk8gx757zfS26RkH9PRwc7Ax9sDFVO+pqmEXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771292354; c=relaxed/simple;
	bh=qsPWRtcmsJKQUTND4/2U4Kk+kKYpNGeqoj3/2d5S48I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hxjredOO7l+bJ09SyX7J88cAsvYcIrPwhxZn/B/mjaZWt6GeiSIZdkrFXrpNoT7ToDX/+Q3j0v/LMHn7zmxuDwWzpOn0EHj/OK51QjzPFnPxjfwepnxhDmRNLPirKJVoYk8lXo9AX5nVyNV5ozA7vOa2/wgICtCNHqEEAWZ4kyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NJEMSSzt; arc=fail smtp.client-ip=52.101.125.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NJEMSSzt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5XFj8Muln0GUFsqWqr0oGjmYUFfeVly9iVJxMqBhiDFI5Khm2UtQXNSWzSQLjXX5FyXY8c0x8IVoZOrozM5/bLM5F3klX0mFKXt0fT4Sw19ZRCqlNIAhQlGGlw39nNav06afBKPlwc4uyA/2Tedktl1q6NDL7Nnc9ctLibgBtUQpoU/OQidRYPnyz2x6hia4yPJdjPSeqMv9+TzsceFQt4hUjmbaB00SgjGR7YtXC2dKbNuozkTOFc3XxQpaCcFyrwhQvUBheGplAhzZt6mnqqozRr+8Mlr2DqZ1K/V82aWxVkPks15P6Ve8N5sR/dTSuved6kT4sSMPsA7zEldSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8ZKfe7PpUxteoITbeefg/uEzXwMhzH44KvNiwdMwto=;
 b=XNdBVRF3i7xdMT2XFzRhm9620CeDdUHtTBA+sWE2sUHIBy+IIZ4x6DvjxgoH32AvPdfT2wdG1LELvAXVJycMIpSvhm6mj51zVqKi6/70XxQmZ4gCkhgk+WFiNJYbtQKygv6Dpz21rjNhfnmY2riIS1JiLMQXFUAxIQ7KSvtT7MzEP8COPVBeupm07fXaZVMkMeKHALkZm1U8gixVPmXRqmj28clnm9SFLXOCTijEG7GIyQkz2AHR68v8m2I6vd2gCkRiFTQvwRFar56LSRXrDVP1eDQ5V0kVqzz0ht4xda3qzdwC1fB+DzysL4YU3Fp55BCi0yZQwXZlwjtoCOr8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8ZKfe7PpUxteoITbeefg/uEzXwMhzH44KvNiwdMwto=;
 b=NJEMSSztj1mp/kitgX8YykAFk7bbB8v9pVIewVXYUMSk/kwqduKLfXVjxoMnxf9fc3IwpWLMVhI2U10oFRfUkthr3r5rBBoP01aOMtP29Bb4CYk8wIJicyIO98xiTMWxaE7xX+wTLTpuasjaARED/7yi+3nCIuINh9MP1XDPfkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6903.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:412::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 01:39:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 01:39:06 +0000
Date: Tue, 17 Feb 2026 10:39:05 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, 
	kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	cassel@kernel.org, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 7/9] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
Message-ID: <6yjsrg55aqnxvdotyhjalx5uwytizjxsh3xk44smdm3f46zyc6@zwk25sgezz5n>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-8-den@valinux.co.jp>
 <aZNCgkddVkDbtO_c@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZNCgkddVkDbtO_c@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 2570a7f0-057b-4b17-2337-08de6dc556f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iq91L6MvPvTQed0ZW+AEBEpZzWcJ8ElE/J2XMVBUOsopE73FcTbcN0SThT+A?=
 =?us-ascii?Q?8VbiW8KWRk5Dfi0f0rBz150MuLfYi9i+OG3c7NtV74T0p7AOpRzhnWUJmbLF?=
 =?us-ascii?Q?ZfbuIlX7CxchXdeJ1uqP/gH3QCZj3I+43SWs/wQIzd8QEx6+D07bdUzohwiF?=
 =?us-ascii?Q?DV5YBWh0jbkXB8bH/7HgNxb6qClbk5kwNSBxdOnTdefmkYlpBnv3HyXU0eDf?=
 =?us-ascii?Q?jUGMlxs59IfUi9ObM7SIxEKRe7p02b1FRG5ryIW+SlK5Ch2PHjyESINfxlPo?=
 =?us-ascii?Q?BrpL9Hze3MK7m8fmQeocQt+1dwctF22bUE5IAGlj+NjRzfswTuI/f7uAbAjm?=
 =?us-ascii?Q?kJKrN23kx6FPPtyWUywYTF7tsPtzSw9QzaJ2fJaBBEfYQqdvENS/7Nvfzqsp?=
 =?us-ascii?Q?ppX/H4mdmJxqdpB88jGIzZfj0eh+vv7mFWCWsPkzPVQmXe5mIQ39BBA6Kp62?=
 =?us-ascii?Q?m7OFQECs2rO1+yuHXpuQzYTRDnhXJXZinsUX4nRPrT+TBRAd+TblV1x2pmm6?=
 =?us-ascii?Q?bqpejdsTQSIloTY7QvDKDF8aGwjPLPDMNP52azmEC+gESHH7RqRgYpA2bf3o?=
 =?us-ascii?Q?ZMMyTukVtbMWt86mZGcwvYSHf4KhvW+fKynzbJLCaqQG8f/lwO6IS3suRaXG?=
 =?us-ascii?Q?Ax6SU2m8eF5vgydf16N5TR6FjZOJuzx6/jg7XoiXw43kGEQzQak12pDNjblX?=
 =?us-ascii?Q?bs6hPI7PUFsTlQn28afc2vf8UqVh3DfuVUOfhBr87jXU7hnNA1gYATeUFkws?=
 =?us-ascii?Q?bjlOuXOHLU+6xXR6EiKuq9n9pZEVh7fL8ypbtsl9MIeIbdxsPL6QFyLmz7Cc?=
 =?us-ascii?Q?iK6RABtl+1pMfq63Rm03QiOW2NPP/BeVBxIp/7qWqtUkoUqWauLsEbJ1wESV?=
 =?us-ascii?Q?tGXpl7qdADXVv6orU2xVTIOtwB9brQ1ZC+B4QrmmyPd4KgwnY1tNNHL4BLxD?=
 =?us-ascii?Q?uE4vCqdD4I765BedoWyDQeTLiSQVMsuTdXjEhILcNM1us4FMEU5dvIxV/Wcw?=
 =?us-ascii?Q?rdwa6D6kguiFMoJltYnAdt+XSdiU3mHlsaHBX7Zdlwbm/QEeifHj9CRaFvjF?=
 =?us-ascii?Q?WcC/uRn4DqLY0K/Wk/4TeBJJNjTjhVB7jxdZAYH2U6V2XYDXuQOhVFHANizC?=
 =?us-ascii?Q?Vv90o8X09FW1hSycWH/za5mnengSIx4ilo3/UwbV8PuOul9XlVl7eBWfci7l?=
 =?us-ascii?Q?JFnU+CXoiaJYKhOZLUjWN+hOlCaohXW8j6sJnx9y5Bv0FCXAr+zUX0gnh3LM?=
 =?us-ascii?Q?+2aDzdgzGhll81sdFRLDxVLVoccp3gkL+7hfOudg4W0L730353DBFBCBx5kn?=
 =?us-ascii?Q?NhzUaC8x7AzLolGnHGXV+jVDvRR7uZB1P2jyQeHhB4Wgc2OABWdLz8pCo3Ne?=
 =?us-ascii?Q?euJNiY/KNuk8qMYv6c4Xrc8NCTnNxAe4euZr/jWW1oRg7TVJEbsVV5C9vPSA?=
 =?us-ascii?Q?HjDCnH1nmAC75PNV2k9vCg7j9mPRQwrS/z5kFtMFXpExj9Hh5kap2ehAC6Qh?=
 =?us-ascii?Q?h/+HDpu50wS5F7UGYfJ8fPW6LmIeiq5ZWsDxWeVP8OMiVbebfhCS1hwaE4mX?=
 =?us-ascii?Q?pm79V1vnLqiBYO+lEPM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxJsVtxjtAHqtcIj4Wb+s472/b5Tot8iAA/9z+exseozT4wUkp+rviKyue5b?=
 =?us-ascii?Q?Y0p90aVESH+TbENFJXdRNsx0/z/WHcbeCbDzuMcuhZl6QyZSBePDI1zU04WK?=
 =?us-ascii?Q?NhxYlZ/CiostsTECIdw7IcKnCTYo2lWN7lV8Z2SY1iuIMEjgFrFr+Sk/rekh?=
 =?us-ascii?Q?IWU6yKSKsZD+IVsNPtoAbPvLOvfVkKeme/kn9F1gpyJAhhB9Ak6lysH4EaaL?=
 =?us-ascii?Q?NUd8l7+A4nCi/juIKPF/WN144kwt7tvO9MGCyKUjIGDujvE9oESOZoiVwrGV?=
 =?us-ascii?Q?Fg9qAFMV06F2Ch0Tu0iZgTo94vCTtJoPJeqs0Mqwg8NX/yhTrMJtMA1jHxaV?=
 =?us-ascii?Q?4hzIlbDhhgVtt07mdY2+ui6eJr9sHvPVk3QRMu1zytjrXH5Bn/3t3NDp6P26?=
 =?us-ascii?Q?ymV7LMe9a8qzEC7QWLOEWeyi1t+TW49M/XlDiPK1IZTwthLKdAGQUeM6iAo+?=
 =?us-ascii?Q?FKrx1lyEBOvpGQNViL1h5iHzq9zkJXKfFzmPfBXYixKTj3II6cxWe4jzcvj0?=
 =?us-ascii?Q?tsn1lWHngO+IKMAe8QdCEdtVqdf8EiU21YPWrswND90U3pXyv2/ybWs+aK4v?=
 =?us-ascii?Q?mSBVHIyud4Q1tu9FTP7thToHMKXhQUxgQNPNgTAfRnW8Aes3Ay1FCSH5d9ei?=
 =?us-ascii?Q?VHyImvTpDY0DS3txM5yHOF5m63CJ6TdtNavGocpIlLhmFMUGo9kNbz14cesg?=
 =?us-ascii?Q?VU50RSHXdugNWcOx/llfl7YR/O1DbfBeB4/xW+WlbX7vzIqvfIyEems88N4A?=
 =?us-ascii?Q?80VVFGD1x68qUO0x0NgF0FeZGkIE78n1YnG6pBSs2a18/j+2mTOTJAJ0agaX?=
 =?us-ascii?Q?rfZ3B9xFB5kg2aZ0RyTspYEfNtsx+6FXk6yA44lgEPZkqbJ8yub0JLao2T8v?=
 =?us-ascii?Q?yCudwrmuzMN4JanveuTHFaLk6gwcUgX/uFKnAtyCBsSYbAyJZS5Dtctmm/Bk?=
 =?us-ascii?Q?q3kVW/AjDMqSRGHgGi2mdtUPK+fGQARFVy2LcLbQIc6faQSi7IBquAMd1jYi?=
 =?us-ascii?Q?BpoAAp3jllJ1zrf1DWPPKo5Z2o9HY2sbj4W9s5yI3gjMX58QoqPv75pQXIX5?=
 =?us-ascii?Q?S48NQne6KR3Qe5/z2Bt4oJP2jeP+b8WYsE6oKu010fgWH6deM/xo/DIkgVJK?=
 =?us-ascii?Q?TzQLmvdYjOQN1yMSG0VnYyNIej4XFuu22/1S5iON9MOiGkqFHO+ET6ORu4st?=
 =?us-ascii?Q?vG3ha8SsqkjARWzdIo/7Ep9Zl+I4kERXkZBf17N9brTPIIhIGNcMIJxGoyHn?=
 =?us-ascii?Q?wg9XkG0giIgO9DvwhrNFgSUBATmmOvuwS8x2+1KBSp7aJdLYfpaVXaPMeoYE?=
 =?us-ascii?Q?M5mdZXrjXDjvaNt8NIwr3plvN11SaWr1Up+TmP6LCywL5DDAusGZYZLptSAG?=
 =?us-ascii?Q?2howjUFiV7SJ1XKde5z0AcRKzz0J1KHDSpJpweXY6RFFqO6aTVpBUP6m+56D?=
 =?us-ascii?Q?/QvzIRTtQ3MUzVD3xW22qIZrrKe9ZzsrfdD/Tiv/CrxVqXUHKBUeWzFS0ZXM?=
 =?us-ascii?Q?fSGBdRpp83B9sInvg7bvnEhAw183/BmVg2d2dDTyqhL8zBcGs57NtRjx1zer?=
 =?us-ascii?Q?t3f/bjQ/rJLTTItmsqF3vwrJ+yUUWDKl/I+iOCUG6dAX8pmuE472QcIbTFV5?=
 =?us-ascii?Q?Z9uSQoIXhERn0IseN0xf7aglwC+UC4dGsq1jNuhQJBXVW0AgfInoDlncb07J?=
 =?us-ascii?Q?kmAuCTJ+RCUJ7xG5TSMPCD1qHmXTE30pIoS0oeiSFoOZHoofvfHR7z8dUnTd?=
 =?us-ascii?Q?9BVNj+7byF6NfXEY7AIToA6ah4QAa8b0ekEXFIrgSnJdJVrrAk1M?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2570a7f0-057b-4b17-2337-08de6dc556f1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 01:39:06.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvkGuWspdSVoPVKdNG4n+YqwRP12jmPaw4OPqt8nfh5i/PAx9CClYoOmcHPc06Du7elfdIlxuEgEjYb+/YzOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6903

On Mon, Feb 16, 2026 at 11:14:58AM -0500, Frank Li wrote:
> On Mon, Feb 16, 2026 at 01:38:45AM +0900, Koichiro Den wrote:
> > Support doorbell backends where the doorbell target is already exposed
> > via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
> > must be requested with specific flags.
> >
> > When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
> > pre-exposed BAR window and skip programming a new inbound mapping. Also
> > honor db_msg[].irq_flags when requesting the doorbell IRQ.
> >
> > For embedded doorbells (e.g. interrupt-emulation), multiple doorbells
> > may share a single address/data pair and a single Linux IRQ. Avoid
> > requesting duplicate handlers by requesting only one IRQ in that case.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 57 +++++++++++++++++--
> >  1 file changed, 52 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 20efa27325f1..39ba4d6b7d8d 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -134,6 +134,11 @@ struct epf_ntb {
> >  	u16 vntb_vid;
> >
> >  	bool linkup;
> > +
> > +	/*
> > +	 * True when doorbells are interrupt-driven (MSI or embedded), false
> > +	 * when polled.
> > +	 */
> >  	bool msi_doorbell;
> >  	u32 spad_size;
> >
> > @@ -523,7 +528,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  					    enum pci_barno barno)
> >  {
> >  	struct pci_epf *epf = ntb->epf;
> > -	unsigned int req;
> > +	unsigned int req, cnt;
> >  	dma_addr_t low, high;
> >  	struct msi_msg *msg;
> >  	size_t sz;
> > @@ -534,9 +539,29 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  	if (ret)
> >  		return ret;
> >
> > -	for (req = 0; req < ntb->db_count; req++) {
> > +	/*
> > +	 * The doorbell target may already be exposed by a platform-owned fixed
> > +	 * BAR. In that case, we must reuse it and the requested db_bar must
> > +	 * match.
> > +	 */
> > +	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
> > +		ret = -EINVAL;
> > +		goto err_free_doorbell;
> > +	}
> > +
> > +	/*
> > +	 * For PCI_EPF_DOORBELL_EMBEDDED, the backend may provide a single MMIO
> > +	 * address/data pair and a single Linux IRQ even if multiple doorbells
> > +	 * were requested. Avoid requesting duplicate handlers in that case.
> > +	 */
> > +	cnt = ntb->db_count;
> > +	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_EMBEDDED)
> > +		cnt = 1;
> 
> Most SoC combine all DMA channel to one irqs. But it should be not
> neccessary for SoC design. It is possible each DMA channel have dedicate
> irq number. I suggest check irq, instead of type.

Sounds reasonable. I was trying to keep the code minimal, but your suggestion
makes it more future-proof and avoids exposing PCI_EPF_DOORBELL_EMBEDDED details
to this consumer layer. I'll adjust this part accordingly.

THanks for the review,
Koichiro

> 
> Frank
> > +
> > +	for (req = 0; req < cnt; req++) {
> >  		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> > -				  0, "pci_epf_vntb_db", ntb);
> > +				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
> > +				  ntb);
> >
> >  		if (ret) {
> >  			dev_err(&epf->dev,
> > @@ -546,6 +571,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  		}
> >  	}
> >
> > +	if (epf->db_msg[0].bar != NO_BAR) {
> > +		for (i = 0; i < ntb->db_count; i++) {
> > +			msg = &epf->db_msg[i].msg;
> > +
> > +			if (epf->db_msg[i].bar != barno) {
> > +				ret = -EINVAL;
> > +				goto err_free_irq;
> > +			}
> > +
> > +			ntb->reg->db_data[i] = msg->data;
> > +			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
> > +		}
> > +		goto out;
> > +	}
> > +
> > +	/* Program inbound mapping for the doorbell */
> >  	msg = &epf->db_msg[0].msg;
> >
> >  	high = 0;
> > @@ -592,6 +633,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  		ntb->reg->db_offset[i] = offset;
> >  	}
> >
> > +out:
> >  	ntb->reg->db_entry_size = 0;
> >
> >  	ntb->msi_doorbell = true;
> > @@ -602,6 +644,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  	while (req)
> >  		free_irq(epf->db_msg[--req].virq, ntb);
> >
> > +err_free_doorbell:
> >  	pci_epf_free_doorbell(ntb->epf);
> >  	return ret;
> >  }
> > @@ -665,9 +708,13 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> >  	enum pci_barno barno;
> >
> >  	if (ntb->msi_doorbell) {
> > -		int i;
> > +		unsigned int cnt = ntb->db_count;
> > +		unsigned int i;
> >
> > -		for (i = 0; i < ntb->db_count; i++)
> > +		if (ntb->epf->db_msg[0].type == PCI_EPF_DOORBELL_EMBEDDED)
> > +			cnt = 1;
> > +
> > +		for (i = 0; i < cnt; i++)
> >  			free_irq(ntb->epf->db_msg[i].virq, ntb);
> >  	}
> >
> > --
> > 2.51.0
> >
