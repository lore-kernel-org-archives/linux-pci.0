Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020143.outbound.protection.outlook.com [52.101.228.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6730AAC9;
	Tue, 27 Jan 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485310; cv=fail; b=C026G498gBQxpWk2PeUXu/QrBoI6aI6S8O0JF9hPuoLs5AaZYCl+iBUgyyRILePF0PkVckRGiWuTopn5LweukZAkrgWcIPhYXULWTeVOHDCpEzkFlROcn3M3v4ZPntGianVzd4uC1vBkap42R60z9Kwzghm5BjlzFF9bGijALmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485310; c=relaxed/simple;
	bh=KuEkl24TCqY/wAJfaz4I3qV7jBnSZDmEx4nVAWvLG2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BzqeeUOL9Xzxr+COyHfBedKO3RH5bnnKwyVOgXGUzODOvSTuigYiU8bNZx76BVtUD/RlJcYgDijl9iEr6xZZdsy5aqyJuLGlMEyZLGbjDWVFEZOg8Ezdw+TyBvw2Pmn0u4KIcYMvIldOtV9rIlMK37IAsDnY9ISixDUXT4yko+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EaOC9l4W; arc=fail smtp.client-ip=52.101.228.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EaOC9l4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCge7ma3UJ0ysyN6tB4es9PBGzTMavI5XT/CItViZ+3AZn32Dj36yZOCqTx8aGCThWNX/HffR14+Vx3O7HsuhPCfGwu7RH35B8MTm+nysvH3CaFO9rAcXuJzBvh4GlHxGmaECbsH8pj9AIxjfxh/ZUL88p7sqMfoej5wVtf2VT4XLuvOPbfdbIbbElX3q6FP13UA3RdQqATNKj81Rvrcv6e9xKODxeV/hzQEuiZUMlGeNOOX3hrObzIUJ6J33HzmlDZTQg1U0ayJ09pUvcoTHsrmvflPMVzM79IZsTLCtuMPKIb0tDgB7SZUphZnQAjvu3Wfhn7hjBO38vUl6+5POQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ1LaLtXEQ54B5oSM40psWMLr9lBlvIGn+AxBrYP6GU=;
 b=kB7H9CU/V0BganuAKw7eIy/vewnx1HelTPCHQkp5j2VF++sKK/sbih+nZGEuIF2akjJXuvx4/CtPWKDzYMkJsNZoFvaVwMS842EbtFFww+n9tP+2Vh3Hgg2u/sdet4sTrojUcgXW3d3N/PlH3LDJifYVpSQuz66bFtaX2x3D/KbY34FklTYr2iBOUN6faklnGxNjLoH4KA74JXE7MwHeHFPyv+bm3CYd5UpVM8l3nkLdGrhbP3j9Cxx8+K4aMPJcoTgiaS9TtRcRpcWFPPJS9394SVnud1MzQ/qzwFf8+fUYFyC1y1nzKfdymdjej/d/ltdI/Vq/ALL6VzyfbTUaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ1LaLtXEQ54B5oSM40psWMLr9lBlvIGn+AxBrYP6GU=;
 b=EaOC9l4WwWtWrzBenTPOlacDP2l341l2kfwKXA0ECo8mfKrVdTKdqBogyQk2FVLmYQKiXblyjrBkHaR3zGddRmm82O830I68sAfG8Tj/b/AV5CKEG8GBw8uriewjV49T9AzoYHZnCWbbN1we0oKcEGNVD8trEqcb/VWNRa93eGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6346.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 03:41:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:41:45 +0000
Date: Tue, 27 Jan 2026 12:41:45 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
Message-ID: <csrj7tywe54yigtwhvw2cj733vzggs3z7mkhbgtfkmc6ir7yyr@mrtmpfpmwauu>
References: <20260126071550.3233631-1-den@valinux.co.jp>
 <x4cilkxvg5ccqqx244ttxgh2kgj7x6bf2e35suwguels5yiqxc@ij53hgrert7j>
 <aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 34312f72-5426-4169-7fe0-08de5d55fe83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K7xdxj/n9WXF1rbHx1Jm8jHK7sVIYKns16AdwtKUKeXAQgEDdL3TzU6IpJ7p?=
 =?us-ascii?Q?vviZq7rzIp7WoVbPrHOysI3lwYBuM66AfRNH2fjvyfE6EzAqd4VceQEP918Q?=
 =?us-ascii?Q?RTfY6OqkD8Zzn7H7Os0xjp5B6UeiUkRlb3T8vbLqAw+DrpmRNm/BsCPix3jW?=
 =?us-ascii?Q?F8Wm/+s2o5bZJNPZLfJtbq2zWuaw/lQuIgI0QnNedtENjHz858HzY6l3XBWJ?=
 =?us-ascii?Q?vSvwKzkty7cC9w5bZZb0Qst5Wsh5yuyJRI+CoLcm5kiGVWYbVB1QIe1qT/N1?=
 =?us-ascii?Q?iZsyeOD2p1Ls9TBbhju0tKX39l5S6prCHVXqcmkTkt+ssH+gONgoWDjp1SZH?=
 =?us-ascii?Q?q6CgsgNZ7pICBS+nu/V/RcfKrqWmrJn+lga7t1dle1ZgTnEOusOyShNMOqZl?=
 =?us-ascii?Q?o6UGO663dLW/OPcjBQmjeDoEChxieuzql946MGgjpSQEn/+xKDGuQCtWMRn8?=
 =?us-ascii?Q?WuChJhv1Zf/ElzE4Ikf1REob11yQ+C5c7PUUd2CCfig4LKOnJrC19bqGB9aK?=
 =?us-ascii?Q?D2obXIByF83+Gp9bqydUI3YLVOg609UAujWBvlugSXUqxU7722grWaStB1B2?=
 =?us-ascii?Q?4Cx6dClc7Ry2Iv7CM8KMxGpLoVdvisOmRnq0BBksFKxVgQqV8oIEg9oQ9lSr?=
 =?us-ascii?Q?mAGop2p/yAW9EEDn7T3uF1W1VuyenlHOmSIRKJpAv7SMKbKbXUJxU0rmL+7p?=
 =?us-ascii?Q?EhPpUpVtFO9CcrsCiO8+AAwciNhhNnIWNHtru2YWZQsdV8cEswr0kLF4FmEv?=
 =?us-ascii?Q?wQnwwONMSM3+eh4TY3pA0qyF4p7YFdU+hxYUGiZa8wIXY9fdYzYNHjaPidk4?=
 =?us-ascii?Q?BdS2phy4lP/2YM5DYu7i7JwAVYfgRw+SkyF8rQ1UK53aFQlfphL6PMVRkr4V?=
 =?us-ascii?Q?e4shCBeLkESgZptIqGstE4cximujzUubeVNlJ1TeItDh2oC+mKC7a87xKT62?=
 =?us-ascii?Q?frFZ/QfBr2xONSG0ZxX3fZHu7G/BR1anGJ7+jzGyTEnKQjL5V6Rwc+hbRl+e?=
 =?us-ascii?Q?uU/xLN4u0ujXD9NTkNSDfNTqtKITli6E8iC5PvBBRVtS3y6DJSt+XS4Kbd68?=
 =?us-ascii?Q?cghhY9rMCHhPCNX6lqU06iH97fT0MXkMI+DZGfYDQDu7cPVtCx0pcSbtOKPg?=
 =?us-ascii?Q?itgsk26Y1yC0sPFneKSrLEjPOKDl9/1dZHnYSXct3+mklgYkpORAdoGBPB5v?=
 =?us-ascii?Q?nOKRVIg5G44IZ3DbfzRoR7dd5RdTTgEGTA7ey7+RAnxGyBPNY9vY8uQ8AUuz?=
 =?us-ascii?Q?gudju2TAiwYKjzrOWP/+R2BJeg3QgcazXu05KcVxokbz+Nv7h5i9Km/jqvkq?=
 =?us-ascii?Q?48elLby47oLHJ26fZbYRjzeLMREFJLypUBl2Zgp4BwFZz1SAfIG9lmVmbNJ4?=
 =?us-ascii?Q?/8THyPjJ7h08Vc7f9qvOqcCZ9j1ELOBcYXK5iO2Ext90p7Jzwb6bUbO8aCwi?=
 =?us-ascii?Q?aJ7jb1+GGqxD4sQRdJo6/HEUyRGwrC0xZ+e2ytEB3NKpcErZZVFkRSX15FNa?=
 =?us-ascii?Q?VYNnLvKorsSV7ck1jA4R+e0Tx1PzDN0myjhrOC4oeZ6E6nKCwateQNIFTm8Z?=
 =?us-ascii?Q?PpQT8KWrdeHyShmsGeChYWvwrnK1vT9Uce5ROSug3Yz03I95tTMStJzoj3P4?=
 =?us-ascii?Q?XaTffQ8va7abpDPGa/18/1U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rX14TK3jPFdTLfyuSGE+XrpzJPGANSw9wcrPDwhbAFpQsRcGphycPKwEIcFk?=
 =?us-ascii?Q?1eUOX3Ew8vjvrDVrZsFZppabFo3LCB/g8ihGVVUFbFvKsSYRfKXbuKs64gMe?=
 =?us-ascii?Q?lGiZjlAkTmLiWbhpBhOt/NspP46gbUf0vvYGHXB1vwEurpkVSwGLw/Pp56hL?=
 =?us-ascii?Q?5FOI9zxncfOB9XGbWb284nATSlmbUYf8mo7Wdkk47LG5es7MtuYBxvNXzfz5?=
 =?us-ascii?Q?jpacR0lwR3zujYG4xyxO+RgLfDPZtRVGdzW9CB077EJlMWeGLc6uLd02DdTB?=
 =?us-ascii?Q?d1xkptjA+nqMZm4owoFWPAYR3fQtWtGD27krTkHwhSkXYjJJsLiSRCDI4rXP?=
 =?us-ascii?Q?2WP2AE8E9OQTbhtLjWvwennGCl1IPAmZLF0+udMtQVPr6sQXp5SSgwyR74Z6?=
 =?us-ascii?Q?OjqiDKl0qIU3te9e8xfiFzFc1CVsD7kC7RPNKdWPEO61oTGlqVAWZfEzFNHn?=
 =?us-ascii?Q?AvuLVI7zfAwqpuP3ky53pH+86gY5+E6qID7ntt2w2XmRAAXPsGvXXQ9MxAIa?=
 =?us-ascii?Q?jZF4o8iEcehMIodu7zmeEKyAL0mqpx1bJDOVNaPvncgSSUvY+yz5T5BAYSjX?=
 =?us-ascii?Q?AgZ+rKVnwUdHCW6Xxk2CKRFQXRg2K7Lfqe1TqO3Die0JjIk2OrSSbuWCX2HM?=
 =?us-ascii?Q?65mzV+zXYq+x5ZcweBaJR66XWQPf1wkVJh7IzUrtLQsf/ql/0b3zEsGurEj8?=
 =?us-ascii?Q?mUN5LkprsYYstr8J4b5WUByAYqXiDmEexMPCUf5G3imfc0S72lbyxPQWN59T?=
 =?us-ascii?Q?k7G/0EHM1jpjyuau8aE51CTxFF63ZyaFOcOHS9uqBOuaT+xOD1h4getsWt0I?=
 =?us-ascii?Q?F0ZhCZS3BYPt/3OkZew94d495q+fbEJUu1/vHlDojGE8DIrpk82TzYBrHO0q?=
 =?us-ascii?Q?nw3coJ7zFs+oeUrNQ6g2Y7pDtj0LsX5F1MLwHjU2CpSzC2bvTu0KK7tJcn1W?=
 =?us-ascii?Q?1oRGmoq+LDAofc2KX3kggqfOz/1/jJS706q5f6T2wv33NFMKMul3f5lAaDZD?=
 =?us-ascii?Q?DfJBnCxvtEENFsU43mZqetEZiWB+jt0EXAkH79WrRk/HVuv/gSzs3EFoHQxa?=
 =?us-ascii?Q?0+fDUWdis8mZAEHDQY5ppZgXnVIRzdHV0JfNYqehkXlGDPvc463tJTs1Nl2X?=
 =?us-ascii?Q?BgFOVzk54EQPr+ZomSmB0Bf8DazLC8IbYzgqILG1Z8pdQrrE3g2qTppCzAT2?=
 =?us-ascii?Q?EesxjpvpVfoQ+/qSvyvnFMw5q0m20MyrwltOshywejsXpEQAgfatDe4VmpR1?=
 =?us-ascii?Q?Al1DVQJ1j2xYooaqptAZY7pNPHioAnWjPjCICFKHrX/sNkCl2mMq9C5nq2Ss?=
 =?us-ascii?Q?sI4HC2jK3TXVD390OCG9ws+iOe/hOCgV4hJLMUSw0Laka8htdFsya7JnlDBv?=
 =?us-ascii?Q?CLgWlufI1qUXhIosgn0h+HZEsWaVOPlfkob3U8N3C3Q/A9sIjhvg9BXYmhYB?=
 =?us-ascii?Q?7YTJjhCwiLBFCLgHNbYMyvV67JQGrImekkgoJkFvK60OCSDunbTuncm6qdrs?=
 =?us-ascii?Q?yV3LlqLBdW+cxwyua8X5E15OogKX6vaU1ETQ6GhTKQUcj0UM4U6BnLbiKmyp?=
 =?us-ascii?Q?5MGOe5cFSU5cZg2Rw5e9heeRnZkok4rOYsvw6xCL9LM21TpLbLTLnnPsFuNj?=
 =?us-ascii?Q?9mYbOJEiRhDHexeK2E+D5gsBgIq0U8/bYIvCAYIlzqRiUPoyLDGGFPSx9at7?=
 =?us-ascii?Q?5HLBUhlWzdel1klFMinrIn6X0lhkehko4s9JmHIJW/QLvzcmOYcqK1s0SSAB?=
 =?us-ascii?Q?V6TcR0UzAANkrcJjmA8tp19UpYuuhCZwcmN5BR59J9V5YWbp2QWe?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 34312f72-5426-4169-7fe0-08de5d55fe83
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:41:45.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnLjRdJVD/XDTgAH4ApFT7YSJmWTBF8R7NXYslYfYaRHWxhQ+oGZ7YB+blEZ+MGfXCKh9JCMSiSheNqxqCzj6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6346

On Mon, Jan 26, 2026 at 12:47:51PM -0500, Frank Li wrote:
> On Mon, Jan 26, 2026 at 04:55:58PM +0900, Koichiro Den wrote:
> > On Mon, Jan 26, 2026 at 04:15:48PM +0900, Koichiro Den wrote:
> > > This series adds small, query-only helper APIs to the DesignWare PCIe
> > > endpoint controller driver to expose resources of an integrated
> > > DesignWare eDMA instance. Specifically, it allows querying:
> > >
> > >   - the physical base address and size of the integrated eDMA register
> > >     aperture, and
> > >   - the per-channel linked-list (LL) region base and size, keyed by
> > >     transfer direction and hardware channel identifier.
> > >
> > > The motivation is that some DesignWare PCIe endpoint platforms integrate
> > > an eDMA engine that can be driven either locally by the endpoint or
> > > remotely by the host. Remote eDMA use cases (e.g. [1]) need to expose
> > > the eDMA register block and LL regions to the host through PCIe BARs,
> > > while still allowing the endpoint to boot with a standard EP settings,
> > > without DT changes to hide the eDMA instance from the endpoint itself.
> > >
> > > The hardware channel identifier used by the LL-region helper can be
> > > obtained via dma_get_slave_caps().hw_id, introduced by a dmaengine
> > > series posted separately.
> >
> > For reference, the series has been submitted here:
> >
> >   [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
> >   https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
> 
> It'd better post together. It needs API user.

Thanks for the comment. I've sent v2, please see:
https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/

Koichiro

> 
> Frank
> >
> > Kind regards,
> > Koichiro
> >
> > >
> > > [1] [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
> > >     https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/
> > >
> > > Developed on PCI controller/dwc:
> > >   commit 0ecd890e3cf5 ("PCI: dwc: Rename dw_pcie_rp::has_msi_ctrl to
> > >                         dw_pcie_rp::use_imsi_rx for clarity")
> > >
> > > Kind regards,
> > >
> > > Koichiro Den (2):
> > >   PCI: dwc: Add helper to query integrated dw-edma register window
> > >   PCI: dwc: Add helper to query integrated dw-edma linked-list region
> > >
> > >  MAINTAINERS                                  |  2 +-
> > >  drivers/pci/controller/dwc/pcie-designware.c | 74 ++++++++++++++++++++
> > >  drivers/pci/controller/dwc/pcie-designware.h |  2 +
> > >  include/linux/pcie-dwc-edma.h                | 72 +++++++++++++++++++
> > >  4 files changed, 149 insertions(+), 1 deletion(-)
> > >  create mode 100644 include/linux/pcie-dwc-edma.h
> > >
> > > --
> > > 2.51.0
> > >
