Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6737CD45
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956472; cv=fail; b=o+LZ5E+nB7FlTGn1N/gqd5Fs3BC5f4ATP66BJ9nZ8B0fKHac2UIX4KR96iMTDK6xzSQaznpW6x13jzLbx72Fo7Yhrp6856mAxDW+v46DE9INALz2kP0GJISt0xrmTa8adID21VWDCIlrdK264MseGYqf9JBWV5Q8lsV6cdPfx34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956472; c=relaxed/simple;
	bh=evpbpboSUD2GI5yS6PRDoWSI9nUuZF0F6B+JkqyTZrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FGP3OzOYmYL62V4/pknheamzijA/a9m8NbL4RwH6T3ba8PiDHAewGxvW8vIo9Hz6BiIuTzXJF5l5jDFRi7GW68KND7oQfhuFdXHNAQDFdk4XvaV3oXSrPhCSDpM6fjcMaFIqaDRTFDF0n0mLWiweMe49F7eKgdbgrKCQulOxrYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GmMKhRvJ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GmMKhRvJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4dmBQ463/ROVqxTeddx05x4ME3/6rxJaMZlckvOcVkvubwF+uf8CNQgob5wrZw2yNfGLGMmK6vuCS24Q4udzQcu0qPMAsgX3YNhNMj/n/eBgbCBoab40wkodGhJiYMz1n4MY4tanNHpU+Z/WNMhhyPJxhv8UwGfc2Zd96WvCc87IHkxnJJmMXEHbvh72aTPhuLwRdrTrzqfTUbx2aBC+/7A8Jmic9okxJjA67x8M17K02Oi6nvi5ncRaX9ilxBp4P4pRXAWPVnuQYWPP3mi72EEqsyCCncR8gB4vU3ZUKqBdjUwhjWCluMmKW/jYpoXk/8uQhR+OCEbsJeftzAALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0CMPiKW8q0EJfOf0+3Xp4ErQxZELUvP/MMcpR+NEB8=;
 b=YiMj2v3J1piDj9humPMco07mtm0rlvsW3bjJMczRQ29lugnaHk52fcpuwugaCIwVn7cp4I4KzzM0F5FZnSWj6xHX7sUnPn/jH3sK6jWaUVodvG4RDLu/WoGAewwDMVpl3XBQ4w6RIlMmm2SzFjGWnrV/dYl4JGQ6xGA2ZMjy8G41ePg7dEG7jRnaPAhgzqPshQvlemt4CfQtxroeVYSaxrVd2f1hk0Srew1kqlqx9O0PtkARX49thb0DFtJSrgPTtJR+YbKwLAN/icPTOiscxfHaUgptK06xyg3hht7muRzUN9hAbGHmRt9fhvG1bfRWiyUdh53UIDGaJWiP8S64+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0CMPiKW8q0EJfOf0+3Xp4ErQxZELUvP/MMcpR+NEB8=;
 b=GmMKhRvJ8gspJ33ONjtAE5rv8qUGWq8vDmIRl78T7YOD6Bq/2JlGR7nx7hSbcrxzyRPdya/2zvim+UW9hVYj2qjSYOa97EAJTj9QCRfPFNL1DL856Iae4T3hvntfL3mMZEglerHK6WSv5MKTzm41mIM6cHRWkUxqA99ak+Ntdlo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB2720.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:247::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 05:41:06 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 05:41:06 +0000
Date: Wed, 14 Oct 2026 14:41:05 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Message-ID: <lngkres6bp75exobxiohld275gawygrw3gm5p4wt57mupaa7d3@kv7g5jew5ooa>
References: <20260919172021.1055451-1-den@valinux.co.jp>
 <20260919173451.C177E1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260919173451.C177E1F000FF@smtp.kernel.org>
X-ClientProxiedBy: TYWP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB2720:EE_
X-MS-Office365-Filtering-Correlation-Id: 948d103a-5266-43b3-f814-08df29b5bdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|23010399003|56012099006|5023799004|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6Pej9e9PPYxjJM4bHR7aQmuYeIlqk4l5qFnAAlFI+aI3KTkdZIvDpNPt5gXmBxkDma/OwZbNAqOSoAWBEDe6+YQr7AkXnmmSiyqnSkvBi3RuCNQaxoB9SILuzRS0dj6tCuTqdm59vQ6Qm0idFF20NqS7sKUdy+fOdQSoLzS1HDO9x7nQQYfhbZCFvT38uKKa4x37B2iUpqYy0ESo3Mnmyut5rvnSRAch1AFNzGTJT+9oHkbNNPwR1aeheAx3zukh57FxjuV5e47udTDw2flwOBIeCT10JURWrEGKEBivRkBt9pIvROeW1nHYpDm3qfEtumE+Ssr3rbcRFPNmD2XAjV3PhmbCEVleXBSwPq6PD73b4kRvRowv+EvNU8LqVyt2YnLqUdxH1oR9aIfQBjOk9jg94TzbZXUeHzUxe0Owl697v5VU150woDEwjY6Py6hfmbX65A1f2+RfeSBDlLpqD73R7SpfiJJOUlx8v6nSnW9ghzg4pdZYj4olW7F/5z4LqYmBffa94ANJ+sCC6mJlrH3U6DXkFpRK3Zpxmsm7EIlmQl/W66vTSF21iDdjETc8nIl0D2uSto5ezBqz9MfsEi5PUYcweMEKYrF89iOGlyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(23010399003)(56012099006)(5023799004)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?J1P+eWffLSIPYnMkj/k0VcKfK29ItWA24i9xDbq87T0o7x2A3KNJf/eyQV?=
 =?iso-8859-1?Q?6JlsIjDzHy6sSmYQqO52UcKHCQg/gvmSFUGZ5P5l81TXBJLFF/YGffsnnm?=
 =?iso-8859-1?Q?vM6NOYT0AwUVrE5PJhS+tiCVtkKI2dqiOpZWCN08Br9KchZYfZMbuAiErR?=
 =?iso-8859-1?Q?eSJjjC05/q9YwbrbupkJ4hdNWaOyy3/6lG4f++BTGyF/AGOmiDMDEyHc8h?=
 =?iso-8859-1?Q?SXyOwjyXAU6RTkLBV7B7cOq0jHNYiffjq6bFJKYaHagwnybgZxNFveDLMY?=
 =?iso-8859-1?Q?sBPh0lPiEOnT6dgYwfVl/+aAYjKtkn3OBh13taqMgAcU8wwhjm3RcF2sH+?=
 =?iso-8859-1?Q?WWWjEc34UYNobU0WOvLWfqd8P6UR/ItwCoyoJ8t0eooFnSHCzss3/9d48w?=
 =?iso-8859-1?Q?qzPEwK559bzGTIirUqeQBVS2N46qkKB29VA3YEsgJFxdrFElctTULcjFd+?=
 =?iso-8859-1?Q?DHOmx1lzDxG9MxEjjNPKfWjhHEFzLQzQ3fYe5p0Ujg/LmnEOIiyMXTrvl7?=
 =?iso-8859-1?Q?NneLToYOn5OUtIOOA8uKImiCDPcXLlc674LECkarGXOKgJMvXq4HJInR9A?=
 =?iso-8859-1?Q?J8/uLxOE6DDsLzQPxhAoZQyfxom0tyivv+zETrhl9u/OAkUKS7OEgSMVPn?=
 =?iso-8859-1?Q?VUIG3vZAHt+VAoEj5bOPLNCXnN7sp9UMJK7HdQnGH1rSGqj2aQdnIFvYaJ?=
 =?iso-8859-1?Q?e85JpgrpiX4WXgeOYcyMJSQOvhZOZBIP3WcX+rFclFGHb7IaDsNDGkZ7Nj?=
 =?iso-8859-1?Q?78eczaNaXc6JF/4KQAA2ZM58D63ribR7kZkaEerJbt5uyxcHKYedLHJmpd?=
 =?iso-8859-1?Q?QrCw8ZNQsFLabpgAXq6S8ffQM1pfYvRSXC88q2KvkZpUX1hegJmcbUYGld?=
 =?iso-8859-1?Q?9Q5O3rMdHWE8qaf+NOd8Z4Crjf48MPh2YUG3T8WN+PnqWzeETKLEXc4QLB?=
 =?iso-8859-1?Q?V1mlZm2TEdcl0bA/xOsagWcXyIDlX5XKX3FzkFiLM5LouC6ra6j333b8d4?=
 =?iso-8859-1?Q?0R2Or+TDK17jdO3JdzpI2osUwB+Gz3wzH1q9xc5fRiVocvsO7hY9BKHWLD?=
 =?iso-8859-1?Q?iPwefLhdBVJzADeBTX62U05YpP0Hye+cNA00VAu5p4iuw5n7kVcbkL/rTz?=
 =?iso-8859-1?Q?ndTgml53HEOdi3rz3NRlWUvTMwnorrwBcIjTpQ9dF9O4WppO9zgPgzFVEa?=
 =?iso-8859-1?Q?arXHLZWyQL8QHqBDPSF3cmERQDmJXzfIOQehWI/UXvHkuOVuhXEirrILkW?=
 =?iso-8859-1?Q?W+D4l2SNR6m91bnjOURUJX3vz1EM5S/hYHSpuv6jwDvlKwrKRO+yj8LrkK?=
 =?iso-8859-1?Q?sTQNxJrJyfkX7URZCvzxsz0Y/JM2wCrDUpV8oAb/1hjnfnyOrRaAPK+g5F?=
 =?iso-8859-1?Q?htZrFMKRqixYDV+ks+Jz6KH8HjAlsQ/EVoxpGouodh8VRsjLqYVFf1Elda?=
 =?iso-8859-1?Q?aOfMx62ePi6Al8yUQFCWPhTDLNJvFcQrxpuB2dyM87HMV9wef/WGm8vqsg?=
 =?iso-8859-1?Q?jNUyjEya1kqWlS/imh0zPHZCluJ5+ukmqiuxcsvj3g82ZeR9R1e2HA5Ejv?=
 =?iso-8859-1?Q?49MXYJWcl5XOEb9WV4DN37O/EMoKHKbp7KuKpGDHSsNo49c7Iv3az2Sxsa?=
 =?iso-8859-1?Q?k+xcobmdQBFebOJP3I78I7MiZtxIlixfi6pSvn1c5yu0LsI6HGOtq8juc+?=
 =?iso-8859-1?Q?TiPuln+VrBB2nobnPxum3kFMlndood/T+c+gdq4b0pBzh2cD6ojWdaKS0O?=
 =?iso-8859-1?Q?Ol+wssX24ZW3M2tHk7BefomPT+bJp0L3VK9rwPc2bPuHomZL1dWZxkvqb7?=
 =?iso-8859-1?Q?j/FgNkPMu6gmIlx6qIagdnXfkh77c4+GCkylpTITj0qTdWe0rg9g?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 948d103a-5266-43b3-f814-08df29b5bdcf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:41:06.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/++1PJTBlBCHqKW3x9YqKLI/+ISagP1oepZtF2awUcIGO1RC1QirZQaezbZtmTiw8aFhJrxndlSFD7D1A0OLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2720

On Sat, Sep 19, 2026 at 05:34:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pci: epf-vntb: missing msix_capable check leads to remote DoS

Thanks for the catch. IMO this is a fair concern, and the check is
straight-forward. I've respun and added it in v4:
https://lore.kernel.org/r/20261014053256.2378817-1-den@valinux.co.jp/

Best regards,
Koichiro

> --
> 
> commit f3657c59adbc44294a8ce54de921ee0a386471b0
> Author: Koichiro Den <den@valinux.co.jp>
> Subject: PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
> 
> This commit modifies the vNTB endpoint function to configure MSI-X when
> supported by the hardware and uses the selected type for peer doorbells.
> It allocates the MSI-X Table and PBA in the config BAR and configures
> db_count entries.
> 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> 
> [ ... ]
> 
> > @@ -308,6 +310,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  
> >  	switch (command) {
> >  	case COMMAND_CONFIGURE_DOORBELL:
> > +		ntb->peer_msix = argument & MSIX_ENABLE;
> 
> [Severity: High]
> Does this allow the remote host to unconditionally enable MSI-X locally?
> 
> Since this takes the MSIX_ENABLE flag directly from the remote host's 
> argument, could it bypass the local endpoint's hardware capabilities check 
> for epc_features->msix_capable?
> 
> >  		ctrl->command_status = COMMAND_STATUS_OK;
> >  		break;
> >  	case COMMAND_TEARDOWN_DOORBELL:
> 
> [ ... ]
> 
> > @@ -1540,6 +1561,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
> >  
> >  	func_no = epf->func_no;
> >  	vfunc_no = epf->vfunc_no;
> > +	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
> >  
> >  	/*
> >  	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> 
> [ ... ]
> 
> > @@ -1573,7 +1595,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
> >  			db_bits &= ~BIT_ULL(db_bit);
> >  
> >  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> > -						PCI_IRQ_MSI, interrupt_num);
> > +						irq_type, interrupt_num);
> 
> [Severity: High]
> Can this cause a crash in the endpoint controller driver if MSI-X is not
> actually supported locally?
> 
> If the remote host requests MSI-X but the local endpoint does not support
> it, pci_epc_set_msix() will never be called to initialize the local MSI-X
> table.
> 
> When vntb_epf_peer_db_work() later calls pci_epc_raise_irq() with
> PCI_IRQ_MSIX based on the unvalidated ntb->peer_msix flag, will
> the underlying controller drivers (like DesignWare) attempt to read
> uninitialized hardware BIR and table offsets? Could this result in
> dereferencing a NULL or out-of-bounds ep_func->epf_bar[bir]?
> 
> >  			if (ret)
> >  				dev_err(&epf->dev,
> >  					"Failed to raise IRQ for interrupt_num %u: %d\n",
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260919172021.1055451-1-den@valinux.co.jp?part=1
