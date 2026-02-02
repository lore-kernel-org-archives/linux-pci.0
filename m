Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021129.outbound.protection.outlook.com [40.107.74.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED02E92C3;
	Mon,  2 Feb 2026 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770011982; cv=fail; b=l7ouFlxORcgOzLRcODi3dPYV51e3gNd9UFLJ5YVnk0RVWSiYrqf+rjsu/SpKP3dYv7ZxmKW3JZZaJnCiNM03doqeAl82ZG7pFQaF2W2fM1MorbuRy38PChK1NMC9xP0QKsPkZtUkk8G89jJ2O2PZmvw4+HDoP2LHhJxFyVEvFiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770011982; c=relaxed/simple;
	bh=yZu52v4rAjIguFFFACzVqYH9Id1iBbCZk22/p0MpyOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MVN4TPStpUYvtTOjNpx9ai031FSDiJGtdq/2xOQAwSp3TVUahS7tg4C+YyJW1JLcJD6eKCxpazmT2BE+RMCIGyQXS0AdMss4fUFSAf214pZaGFVzUWAqN2z4ve8In2WXmCuLKP4SZtGKoHtJR7Gyhthhkt+V309PFkh15hrbhwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VwL1O/1f; arc=fail smtp.client-ip=40.107.74.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VwL1O/1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+YrcTiZKU/5jkPF5nKJrnKhIU0nuxCgDHeWh02UbmjY5yHREiNKmttmrMbwOfWuh62TxHVIoM+qfXnAqrnhod9AQu80YnhuHJ0Edm/0Zqwx1UeV+kmgmixDCAiZWm2iEC8ZFThTtN7b7Fdrp7w2vIkxTNWJIVXysZ9BxHM6jl3cX9e1s0h5fdXSO541LPCnSidjExD5nB/pQDyhrjCToPNRS96tgtysIhPQ1uSBfCDl/2DaFd2qVYx2Yfi7Y4TNq9I9bw2StmlUF0pL8gono0yyym5Fepehlet8AQoIys5E19Zt8Yt3wYxDPuGuL/V01vjWbWZY2pLrC60wm9VtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q408gfvPoQJExWC0P4ZeeGIPsdYvdWjqETBVtPZRwak=;
 b=wTd+tDaquZobtQpQVBTcy1TQlnaajPiFCzfGaWCxIBL+aWwUp8lFfTqvkVdsAapnct8G0mmF0A789GpUoxFYkhrZiYj6pBPKPhP7AvJegI9jvykN3iji+4hJK0bdMy9thFz1nrDwR+meEePYb7cnzA63FPRx54uz3sk/r+WiUHmUfz+QB9J4PAK429mM/8nzDV7N3i6mWSGxrQW3fDAaNP2e6hgoumVemw87gmsFiH8tB7kB3UucTTBlvsamMRYb7EOGbh+M27dcHSUdrAPefzxBY31FQ7iQXYIzvoRtNffz5LjszNjE5Kqg9e6M+k6yPlFk0QCr2ll+h6z/fB7Q5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q408gfvPoQJExWC0P4ZeeGIPsdYvdWjqETBVtPZRwak=;
 b=VwL1O/1f9CslcYp4W9RAsttNjNtLlOYuz7TmVQ7Rd75+1WeoZ+E8Q5lY3fkG+e8zkmbtxNpsmwzwX+BjhzH1BaFus2jzn5OKsrw2LD/FyXUxRhd16QCXvz1+YWQxrQPjGGq+SMTj5cHm6aMORDwHhELzbWW+6V3AuRzdD+s80mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2169.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:176::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 05:59:37 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9564.013; Mon, 2 Feb 2026
 05:59:37 +0000
Date: Mon, 2 Feb 2026 14:59:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	robh@kernel.org, Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: Document pci_epc_set_bar() caller
 ownership and lifetime rules
Message-ID: <sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-4-den@valinux.co.jp>
 <aX4y3txKcYmb-kE3@fedora>
 <4erlj426nvmilwfdq5e63ojiqecomcpj35nvmiyw2p5mvifwlt@yspmfxrzmxei>
 <aX_HfpBoQX4j7mag@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX_HfpBoQX4j7mag@ryzen>
X-ClientProxiedBy: TYCP286CA0183.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9643204b-d0c8-4bc2-fe0b-08de62203ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXVYMjtae2KIegkg362HmBtVVX+It3lQisOAvRioLBNHvT63oLE2WnPxS0ma?=
 =?us-ascii?Q?8KDht+H14L5D67vtT2x2oG0IWg41Mi158dX2SEQsZCjtZJPULvLtPQhJKIFe?=
 =?us-ascii?Q?X3myvb5hJYb8tNAdtqMQUSk350/poE2X9X1WKzlEgVHVDYnQMIS3e4hqUZzh?=
 =?us-ascii?Q?jV4m250fZ2k2M1oY5j6+leNBFpHaY2oVTdjXxF9X/D37j7HL4tE+RvYUhCMG?=
 =?us-ascii?Q?jF1Sn8X3F8InaOzT1POnTSfW96SB6ld5EPOcZgc9qjB2nxhrGC2CwacB+F5B?=
 =?us-ascii?Q?d8TgpfRlaUE5/Czb0IiN3UD8IaNHjidNHhyXoLred1u2cdEt2CRMPYilQ5aw?=
 =?us-ascii?Q?2iCEndyZij00WHwEuWeAQneTAzKh/wXFYxrnhWdp9R9KKQXvBuuCWOn05LVa?=
 =?us-ascii?Q?T2DbVRp8KQWZa3JeeGl1HSBD5+pFag+rYpa0rw2Zp3vOqoJxCWK9glB6Dqdn?=
 =?us-ascii?Q?eaPaEIvIIacWEOLoG/Wa6ehR/TnmGer/YXEvZ0S7Zp8dj6r1Y8xWZJiUN2t2?=
 =?us-ascii?Q?mczJy0TQjQUTOKPS6YqMRkq6Yld2CYdUT2BEVRfT9+VKTu3lZVxWgbWqgGCi?=
 =?us-ascii?Q?E3BV4MV09KrteCB8w6Vteow8557ggzCPYESwoBlNn8/2+uVJkSU02WM11LP8?=
 =?us-ascii?Q?MOORPfw/zffCCCRJcNzCHXkAC8q1y8WVnQ0PVQa/Z0LfCK9JIPvxN/Us0nrP?=
 =?us-ascii?Q?NtbES937lXBSZ1ZINX3oMdYnLpeJ73TpsSRo0L+Ho59OSPzNVsTWknfxacvK?=
 =?us-ascii?Q?3NdNtbzOzGwAjNJcyEj0ghMIbO4oaGF1aN7GhIgHaFMAbp9zugco7AP6YInn?=
 =?us-ascii?Q?ZrOw5Y4hvHkIlxsFyU+dKyOM1Zk2Zl2z9H0w2+LrODES06hIl3MbfSCrg9wt?=
 =?us-ascii?Q?NBoiQik20oJriwdGhSvAykvWfP/sKLhz5prUV0kM/ov/7LLPUVPNZ7N8Hgcr?=
 =?us-ascii?Q?ojrnZgdQJGO05CzpmwjeUh7TO1Ei74+F/u7OQ8uIVXoVE5/YWo3P4u1OnTqU?=
 =?us-ascii?Q?n2EfotZdi4KfIKi3FxaxWzUsC5BMP2msXjlF3sVbw2QW1KA/u27rcH6/L3VY?=
 =?us-ascii?Q?HRO7hPqeHDHBmIX9ITDYT2jj+eoByoVHiK8/QY7P23VbGlRfxsfuokZhFd0l?=
 =?us-ascii?Q?YKaATYltTosgva6hdC6q5W/xRp/P4zwGKUPbRtCqBu1QtqvKwwefsIXL+G5u?=
 =?us-ascii?Q?DvQHgg7eHz7YVsIa1CUVqEjfN4MAKEnnyGDCP/2vY7azhWxFaAfVM3DWG6gW?=
 =?us-ascii?Q?MH6An+5c6N869L3OsGbyIaYodLgq3wXRSSN+nr/RSPbQM/T2rhQ/jqlAGb4m?=
 =?us-ascii?Q?e6VTVIdTRC1FEyr6IFiv34MU0G5d3Hp1ltbUc/7H12pT1iCR86RI2fmQCBIK?=
 =?us-ascii?Q?tjYre+E4iGcvCMen8joodXYlsYqoWfL2zejWTU6OqJgeW1Nom1CrjHDtXiG8?=
 =?us-ascii?Q?lDdH4g2XeeuF9jQpwCU153UOReL57bIneTYojhZoPxt+jcUd3NvOezZx5ZAl?=
 =?us-ascii?Q?Cqu8L1sC35dVUuI/Do38QjzWNQ+QmN6j9Hec?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1W1G0zxoUplqqO+aYPrRDKLBJGxuO7mOCk6rfUItyX7o8RdvmB6XVH4uCuSO?=
 =?us-ascii?Q?saOYna/lx3hqy2Fl9OozxE6z0YOK2xg2I+o17fydcg4aTCsgGK3jyc2qsLkj?=
 =?us-ascii?Q?P/wUy/okXDLd6m8/cGhLVBlNCETXwXHtHxwT9EMXo/wvDSbAHThmSS1PykfM?=
 =?us-ascii?Q?exBL52kooSFJ0NTpub1W13mwv5HlJhNY4cIt5lNIPE6pTRoVZTdColDDoAIP?=
 =?us-ascii?Q?KQ4owFKGAskm7QfxUTcT37bb96ZwDhUhRKXkCkUVO8xDx4l3I3D1GhW6Swqa?=
 =?us-ascii?Q?bleS8zncZS9yFj5LzdvN29APSmrQEM4q4LIs2H3x1utM8/jWY9o64mxZNGjx?=
 =?us-ascii?Q?eYRqx2zA38FQhmkEHof2JyUFHc2mvsEYRTjd7mmHQjBHUYVT1aTqF4JfY6nd?=
 =?us-ascii?Q?uW5ZYAOauWB7MTWj9OxpY9DcdRH+IFsr4xZzT31IUX1Vxyh3bqGkV//wnmt3?=
 =?us-ascii?Q?aZPbQ91yhsM8CY79n6hjyUYBpM+4AL7YvnpOcVqD+AY/bw+1TBnrzm0thnas?=
 =?us-ascii?Q?C01jExn3Cjkx73WAyUsUmezjPqGxyF3OHRxEEnirY5ZYU44YY7H7cu3jkwKB?=
 =?us-ascii?Q?/Bwz3oHsMJ8i7PqYZ0GaLq/MfjYA+D1ZW+IsFRB51CYFC3efodE+Gn0nz6uJ?=
 =?us-ascii?Q?6Gju48Z3KIZuzHsSyO8cYlGk9rsVcks+pO7km2doW+lmXVyx1l7XKWDJg96E?=
 =?us-ascii?Q?WNxdu0yn6ucgqyAN1VfZDgjLsja87uHgLQHPkJXHtUHCK862urhgHqt/DYxb?=
 =?us-ascii?Q?39PV/lE/eOtr8YNWILcec20uD4QdDeo13dlfY/nAwStJ/0MSiU1MQs4krB7y?=
 =?us-ascii?Q?qZhu+M4pZa6rdAidW1Dhzxndv3Ilqy7pGYO0Q/pweuJ+yUVC86YRiD6uNf6f?=
 =?us-ascii?Q?YpoxZvE3ftu7TT+jcrZBMCc3fh8fs0uzdDJ1A8IaHM0bs+MQ4XqhQ7rJRNEi?=
 =?us-ascii?Q?zf+MxDlmdorDHsLOvn306TAGdqF+YUbipHaSwJrmCOUo+tXU1YfuGr7T8O/9?=
 =?us-ascii?Q?LrZ8wLkTTSTSnBYInqXy/kyWUkDRo6L9ivFqYWMUDFM6QNfd5DSwM0ljKP8s?=
 =?us-ascii?Q?BJm87iNzP5tpb7SbLmpc750KNgqlzEr5MKgosAxsVXWqgUyxNk+sAOSNflZt?=
 =?us-ascii?Q?NExgjd2Z8d57wdI3Lu2Zd8YY+e29uRHCQyAF4wZ3ri3NtGKtyfs5Y6Ao6Mmj?=
 =?us-ascii?Q?iX44k9lDjEaPOimoEEPy8z4L5dyeKh4WHSN1aoFfU5JX271QW4I8PJ/a2ZfB?=
 =?us-ascii?Q?wvW/YBRNY3J3sX9nLiWa6P7LjvEK7ebkZf23E6l4wMAeTa7h4lxEBqcQipTz?=
 =?us-ascii?Q?2W4WrQNBQmSA4tsMJLJV96t/vUQNgV54AWZKQNvhRMnTreyP0d3TXOoG2Apa?=
 =?us-ascii?Q?Uf5C4RWOkB15kEo9pq9sHoohSDPgg1OvohuHJ0SrZ6zrgw+6+1eU2vE8ZH+E?=
 =?us-ascii?Q?rIO2GqTP0XVoCuhoSba6WoraP3iwKzMt3oWOtbI6svBbIzvwSwMcsKwdLP9O?=
 =?us-ascii?Q?Fjhvyzv+LRTAU5vtdlho/wtyq+Kg5H1SnByhR7YFUFsvWyZE5O9DH1xvZ9aI?=
 =?us-ascii?Q?sUAzzFI/iKzyojTNA2BlGSCBapcT2t4l5NqCGbcjaXoc/eoCw+XFylKYwC4q?=
 =?us-ascii?Q?gvYVRMRDgaLlmAqFn7RuOoFuIYHOQ7+Fe7fiLpDgcKCPOc0GksQ0jxlAjeHL?=
 =?us-ascii?Q?fZDAy7mCPSLNh7/MkU2cQajVB2D3FVQeY8gcTdCbjfPRU0v7+aBaKnOxQaQ/?=
 =?us-ascii?Q?WoE3XPd8YaBZb/FOcrNLS0rfcxB7BAvUo9HFmNmXeueZBz6kXe+x?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9643204b-d0c8-4bc2-fe0b-08de62203ef6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 05:59:36.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xv9ZcKr/ZMvXbrNcXQ7wBC0TThRhCVLYMJVmBCcnmwh5Xdj8GM9tYdBXwmUI3fXdy27/cJtZROch/Nw0Y7wqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2169

On Sun, Feb 01, 2026 at 10:37:02PM +0100, Niklas Cassel wrote:
> On Mon, Feb 02, 2026 at 12:45:52AM +0900, Koichiro Den wrote:
> > For example, epf-vntb initializes BARs via pci_epc_set_bar() with phys_addr
> > = 0 [1], and later updates the same ntb->epf->bar[barno] fields in-place
> > and calls pci_epc_set_bar() again [2] via the .mw_set_trans callback:
> > 
> >   [1] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/endpoint/functions/pci-epf-vntb.c#L710
> >   [2] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/endpoint/functions/pci-epf-vntb.c#L1288
> > 
> > So, if [PATCH 3/3] is the contract we can agree on, then I think epf-vntb
> > would likely need an adjustment to follow that contract (i.e. avoid
> > mutating the descriptor that might still be referenced by the EPC, and
> > instead switch to a different instance when updating). In that sense, the
> > code alone seems not always to speak for itself at the moment, and having
> > the agreement documented would still be valuable for future EPF
> > implementations.
> 
> You are absolutely right!
> 
> 
> The pci-epf-test code that uses a difference instance was made by:
> 
> commit eff0c286aa916221a69126a43eee7c218d6f4011
> Author: Frank Li <Frank.Li@nxp.com>
> Date:   Thu Jul 10 15:13:52 2025 -0400
> 
>     PCI: endpoint: pci-epf-test: Add doorbell test support
> 
> 
> The pci-epf-vntb code that uses the same instance was made by:
> 
> commit e35f56bb03304abc92c928b641af41ca372966bb
> Author: Frank Li <Frank.Li@nxp.com>
> Date:   Tue Feb 22 10:23:54 2022 -0600
> 
>     PCI: endpoint: Support NTB transfer between RC and EP
> 
> 
> 
> The dynamically update inbound address support in the DWC driver itself
> was made by:
> 
> commit 4284c88fff0efc4e418abb53d78e02dc4f099d6c
> Author: Frank Li <Frank.Li@nxp.com>
> Date:   Tue Feb 22 10:23:52 2022 -0600
> 
>     PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address
> 
> 
> 
> I don't know why Frank chose to use the same API in two different ways.
> Perhaps because in pci-epf-test.c he needed to be able to restore the
> BAR to the original state when calling DISABLE_DOORBELL, but in vntb
> there was no need to "restore" to the original state.
> 
> 
> So, perhaps we should allow in place updates after all...
> Frank, thoughts?
> 
> 
> Considering that struct pci_epf_bar lives in struct pci_epf, I think my
> previous idea of doing a kmemdup, seems wrong...
> 

I don't think it's inherently wrong. I think it really comes down to what
contract we want pci_epc_set_bar() to imply.

When I saw your earlier comment:
https://lore.kernel.org/all/aX019VTWjMlPX8qp@fedora/
I hastily assumed you were implicitly suggesting that there are some
outliers (such as epf-vntb), which led me to think we should document a
single "legit" way to use the API. In hindsight, I read too much into it,
there doesn't seem to be a clearly established contract today.

One subtlety if we decide to treat in-place updates as supported: the
existing dynamic update compatibility check in dwc [3] becomes officially
best-effort, because ep->epf_bar[bar] and the passed-in epf_bar may point
to the same object (so comparing against the previous state is not
reliable). In other words, changing barno/size/flags via in-place updates
would be caller misuse, but the driver cannot always detect it.

  [3] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L368

That said, this seems to be already effectively best-effort on mainline
today where in-place updates are being done, so I don't think we need to
rush fixing this part immediately.

> I think you are right that in place updates do make sense in one way...
> even if it can mean that the current safe guards can by bypassed..
> 
> However, if you modify the struct pci_epf_bar in an incompatible way,
> before calling set_bar() or clear_bar(), it is your own fault...
> 
> 
> Considering that pci-epf-vntb does in place updates... we probably should
> allow in place updates as well... As you suggested a few days ago:
> https://lore.kernel.org/linux-pci/q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf/
> 
> I'm sorry for changing my mind. I did not know that there were any
> EPF driver that already did in place updates...
> 
> I did look at how pci-epf-vntb handled doorbells, but it called either:
> epf_ntb_db_bar_init_msi_doorbell() or uses polling, but in either case
> it never seemed to call set_bar() twice (at least not to set the doorbell),
> so as far as saw, it did not do in place updates.
> 
> Considering that we probably want to support in place updates after all...
> 
> I guess we probably only need patch 1/3 in this series, plus another
> patch that makes sure that we call dw_pcie_ep_clear_ib_maps() unconditionally?
> 
> I still don't like that dw_pcie_ep_clear_ib_maps() will be called
> unconditionally, but I don't see any other way to support in place updates...
> 
> I'm sorry for making you waste time. I did miss that even though pci-epf-vntb
> does not do in place updates of doorbell BAR, it does so for the other BARs.

No worries at all, and thanks for digging through the history with me.
At this point, I think there are still two reasonable options (to
summarize):

X). Treat the existing in-tree callers (including in-place update) as valid
    usage (i.e. apply [4]).

    [4] https://lore.kernel.org/linux-pci/q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf/

    In this case, the downside noted in [4] remains: if a BAR reprogramming
    attempt fails (especially for the long-standing epf-vntb's BAR Match ->
    BAR Match transition case), the previously programmed inbound mapping
    will already have been torn down. This behavior change is inherent in
    making the teardown unconditional. I think this is acceptable because
    if the caller is passing incompatible/invalid parameters, things are
    already going off the rails anyway, and the call site that receives the
    error should never actively use the BAR for any real transactions.

    Separately, if we treat in-place updates as supported, some of the
    existing compatibility checks (e.g. barno/size/flags) become inherently
    best-effort, because the previous state may no longer be observable by
    the driver. Addressing that would require additional follow-up work
    (e.g. with doing a kmemdup and holding the snapshot), but this is a
    pre-existing issue, so there is no need to rush fixing this.

Y). Define a stricter API usage contract, document it, and then adjust all
    the caller sides later (i.e. apply this v2 series).

    The downside here is that struct pci_epf embeds the struct pci_epf_bar
    array, so tightening the contract and fixing existing users would
    likely be awkward.

Personally, I'm inclined towards (X) at the moment, mainly because there
doesn't seem to be a firm, shared understanding of the API contract today.
Later, we can do follow-up work for the existing behaviour, which is
already present on mainline.

If you still agree with (X), I'll send v2 with splitting [4] into two-patch
series, with an explanation above the unconditional
dw_pcie_ep_clear_ib_maps().

Thank you again for the time and the discussion,
Koichiro

> 
> 
> Kind regards,
> Niklas
