Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6238552F;
	Thu, 26 Feb 2026 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075854; cv=fail; b=DhJXK70SLMZBsxW8/IunBgm4oxkW8FwQ13Czj43Z4JZF0Q0uKHyz+m0cN+cxHfryuXHHkBeDtjKPOqoXLxAZ/S4U4Wss+TLz3wdMEdLiierqZcf1hYsLh8w0MlHhX4+HbHM7KdM/xhmAit043dphi9VnVmTJu2J1QM3uDwczfJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075854; c=relaxed/simple;
	bh=v9QM9F6BW/vmzKbGw+1A/cyhsWtGkBCQKJXGPSfn1zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PdJ0OTlaa3UvIrUmvwBVQjjrJxqWfsFcNFYI7P++OBLKyoFLdJq7Iix+En+luMTbGqN7TmNC3um/cLBKTRzUQ3Tz9yi0KQCs1KN6E4gNpAHBqJaOEAh6L/yMrrM55JxTfKju9BGDBy/QrTnv+PbiurLSZHkh0eWDRQcfUZgyla8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pO/bLL67; arc=fail smtp.client-ip=52.101.229.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pO/bLL67"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY65vt0ocVFN2yIDEDkawNS2IuFP0FsqYmX9Im9SKTqjGgnopn9UEYF9lxl2C5CRTSUj9kkq18j02VOyOis/C7Ime+z5y6c4bfEmMjIiDW1FK2N2fPxy3GBc59lWC6kykM41KIXvqGRSnmRoKKR/OvEbloX15aIwdPy9fN9XHF3vkBjyl6fGhkBJei9kb7AneDPACCQn2vfdermydAq9E0gIu2P8gkZcCi5G8vgO/t9QnqiakrC/RtpvHvNYo9NM9SCFTayM1rNvW9AWE0ZcBAop459Q+kycAAOnnKbhwJbLpypkOUFzfIgxSBSyoVbWT3KpPdmNJZmzvGKtq8C9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzvEPg7bGOJD6e/BmcDQF/fm4LfIQ89yx3XdUs8i9DU=;
 b=CUG/UXxFz0B3023t8gV/Em+6ghgv4zjxfAF8me/W2Eu5+fNjlHWQ/CZEPJjiCPi9Dd/OhIww+TkXsJqXnN/jSTWYHI3xDmD/TALHsJmoup/0vPF4B3KmSYIUWE4jDSEW471pZ+cazM7lfC0Rnj9nd0I3tMiOQw8LfaRn2s6wmhrlpX//GzGP6Dz8YibT0aqtJ5PnH8BdNOgfXj6Tn2+FbGlihsBGRjUPVU7qIzoEzXDhwoQqMd46Jubm8p+JqRKnm3x1hW0sOnTANjyh5FblzkhLs/kkVuU118LBgIbXRcpk9N8vyuKRel4ZhDXLoiyE+3H/UBKKOwqTuOXjE4kRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzvEPg7bGOJD6e/BmcDQF/fm4LfIQ89yx3XdUs8i9DU=;
 b=pO/bLL674OWYCayiiuR1b6oyDoc63cu/jq5eU4kiR79o/h3rEd/+iUOtRXUC5nABXD7G2i0Aa9xeSQDtVPbw0PrLAhJpOV00BCNqRogNXHo4IkS5JgcHp8+AN62OKUajlcYvH9oUIZjB1Ra7wSzokpR0HwRW1atbGx9yySGJD6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1998.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 03:17:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:17:27 +0000
Date: Thu, 26 Feb 2026 12:17:25 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>, Frank.Li@nxp.com
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org, 
	allenbh@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] NTB: epf: Report 0-based doorbell vector via
 ntb_db_event()
Message-ID: <wzpew4y3o75nalmleswfptwhqriyp6la7eciampk7pmluhzynv@kjich4f7apkf>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-9-den@valinux.co.jp>
 <59969b55-8360-4ae7-8e46-69e55c1e74d5@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59969b55-8360-4ae7-8e46-69e55c1e74d5@intel.com>
X-ClientProxiedBy: TYCP286CA0204.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1998:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa14cc2-f85e-4f7b-760f-08de74e59170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	cVQS2ZNg0yECLiBqKi4llfllPkA7dWM5XhZ8jJ7LtvJIM3s1JycuJYndem1FR1y08157/Q8rqBBX4K94vTl8Z/BUrLDJii1fvCaDzHQjiyCUpaEOC5fn2jZjljNJ2EvSCa2lngalNfPKUF54o5Lz18Kq+kDw/5RbAkw7uig23kBOtBaap9lfgZJrXVtuY1A7F1YyPLvF/XlIs8wz7YVtKlkzGeWDXas9uKyxV4u9lk4DDmoKQeS/k/nsUzJkWFXhTxwgAQEnVC+31iExFPmZIe3B2z9OAH7p/uDLDe+j4ZqqDo0uUJX1B1UBiVENx6P02v3RGnrjmlFntc352nD9DXK4x0HQr2WMQONQCxhjvc9oQ9+P8zGMUc9BQFmZevKoAFtp9EfhhHISPe0Vv/Urj6Vz3oDsB8J6FfhPKbhGV2jyvVh2ULdzmrwMJBEU3L1EqiL0xSCSXIi17OuDtgDlgOqSAIdUKM+NOUAXzQTUbK0c5cx+oQU1Mm9xO63fGD6QjAcNYa4NRkOremTEb/cnnSUbdvAYe9ni74rDKQZshXByKXUuK1r/K1dCT1DOY+hz1L9YEQqUXn/LobCqrnD8n9IfuSTypxz5Ii48yKx4rRsZV+Q75s6TppOt5/ALUrFxTcHcXEt5KWqeBbF8J8Dbb1CILOhCM9iBhH6ZroAUXWuaFko/Q37SajShpI0Yu8nKfl1y+AEDK7c702bqQ7rn0zo42CLWVuV4IGY2jg+7W+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6UFcQ7mvihnStvw9bnwJd2QjoDeYBG/NjGGK0uonS6V9uG44RCzUsl2Pslo?=
 =?us-ascii?Q?4z1qcaY7IaJ/xISreOHcFSJtjYf6bSeOy+eMkZkSdOtP3EWZ91vKwNTHX8jk?=
 =?us-ascii?Q?RBOthCm7ABFhSXiHqR2KigcnqoWAsNLrt9wLZEqJFcCZJAEDlBSjweQzn63p?=
 =?us-ascii?Q?Dh3FZshZBTnOBTjHz01YF9DFFIcV2rokUfYx3j/BEPlsJxHjQbskbm/CJC/u?=
 =?us-ascii?Q?gE1VWFAtjnvgUj3Pskj+3ZCZY9grspnx6vRS97RsCqlU/xtB9sTvinnQTY30?=
 =?us-ascii?Q?t2Ocqa8PO6LWwZ1yZ/xYhrkbrLTrBNSS+0CLdZ8zqZj4tgWUXq2KOecWTgNP?=
 =?us-ascii?Q?iUiTBqMt29iD8MewNewS9ulOX7aw8G4lfMQVbVIRb7+puh3u7Zg7sYcCOqVL?=
 =?us-ascii?Q?S85kvRWuXvLZZVdw6iErrSna8ieFpbFLs34D9+DX9eG8AVodzB531T8IjMsQ?=
 =?us-ascii?Q?eIiIFU/Evj1pW0kiuibYdQNx0nLIJljfKLQTlMtvAcUHj+gdGJ08u3IRrlYC?=
 =?us-ascii?Q?0TWrruCuGY2vap717xFPmg1Rl+YxVBu47y2mKxrprZsa0n5nMuWBpDgXDjEN?=
 =?us-ascii?Q?IJHLL7pg1KkIBTDEk+WOaiYBB9d/4ZLAURKq0Q5uXXwaNIv9RrlQHbTsNm+d?=
 =?us-ascii?Q?SriAPulbdTvbKKsxeiDtb67b3g7YkU6XqKwMF/GLjr8lbRaI26VXYfnDLXEI?=
 =?us-ascii?Q?4qIYzsiHA+iQH6DKD7Zcigq3xpl8G5WTX4pXIDA9msaEVHbye3hOKLOCyThH?=
 =?us-ascii?Q?6wmjF7yU9N0VkK3/GqOYUidd+fKSK4EWgxyJw1Qrl0X6zNpuL5ejY+TriozD?=
 =?us-ascii?Q?r16UZTke5Xbll9rLaNVyzMnicNTdocY8oP4QozC9WfGJqh3Ab5cmg8ad53+y?=
 =?us-ascii?Q?+UZyuxIU3wcjGCkbCj4iXRHDl9+b0A0cQmhvEOUNQtxKYtI60ahuSklroXM9?=
 =?us-ascii?Q?nElBA/sJzblUCKgNCkEMlMGeHi8xsHR0VlUd7P3EIH4T697VkgDEtOxWd8qc?=
 =?us-ascii?Q?bk58mW86aLdG2PP1EIPaTBlFpnFhQwyCoq8hocj8m6XVJlQXDB7szJ2LctjX?=
 =?us-ascii?Q?rvnayjV4r3DzX42Qyt8M8vS/cuQHHjK0cVLcCl9ZcGHr3KHrvxcLCCgeKNQC?=
 =?us-ascii?Q?oTXKU2UrxrVGJXYIIDrSFsq032NfwlkeTlIUcbM9H0Kr0bZ/B8UqTPU7UDzO?=
 =?us-ascii?Q?DKGc2fN8Kg2+pHpU4TxcRs5gGyDQH+HWH37p/HAildL1PT3I/i4K33QPfe1/?=
 =?us-ascii?Q?RAUYoEBaJGpwjEywkAic3BF2qARBECwIiQT3DGB4P0muVzmOkOiTrcE9PgrO?=
 =?us-ascii?Q?Ddp+rm31PDN4z1+nWbwgVVsTApre5o8OkaeepTNpuBT1A7PjrPXaN7a5Nuts?=
 =?us-ascii?Q?Gjuq1ZU9Z4ci6Y54kK7Vxq+6CgdJd/TsMf4pN27CPaQeWtptCepA+zZVQ7TN?=
 =?us-ascii?Q?vn3zZfm8K9GCsKPykQd5XaxJlcN5nTREudTFtB2KYgWiWP6f8SOW9iMOGt9W?=
 =?us-ascii?Q?i8EbuBDllzVD/S8OZZfUis/bzcfkvvU+Jjinjn0n1gN/+7xFV0bm5LptZgVr?=
 =?us-ascii?Q?ChGSEaAMvQpsyKinT9e3LgEH65I6W33UxUnLE+o8vYOWiZ/RhQeXZGH5UGC6?=
 =?us-ascii?Q?IK76SC9RO6+0c51Cxo766K1BgjJnT1b/705UMpPgBrFVUto7R6tKzNjk1tT7?=
 =?us-ascii?Q?nD5AvS/s+Wtua+laIKfbC9Ot0buxZR0OerNfbRcQzPLw2LPAFZnDtVuL60cM?=
 =?us-ascii?Q?z6G986oxbgHFmid8vptwj8jVpvVg2LgaLU/KezTC/78tVDoyzAwP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa14cc2-f85e-4f7b-760f-08de74e59170
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:17:27.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9gO3vELdfx2GSvLgqfQxoYXXeiWP25ml0YtV4jUA40kztoCiCi5a0W7m//LHM7kKMI0bJsuP/NL8X4YTEi1Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1998

On Wed, Feb 25, 2026 at 09:59:46AM -0700, Dave Jiang wrote:
> 
> 
> On 2/24/26 6:34 AM, Koichiro Den wrote:
> > ntb_db_event() expects the vector number to be relative to the first
> > doorbell vector starting at 0.
> > 
> > Vector 0 is reserved for link events in the EPF driver, so doorbells
> > start at vector 1. However, both supported peers (ntb_hw_epf with
> > pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
> > started doorbells at vector 2.
> > 
> > Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
> > If irq_no == 1 is ever observed, treat it as DB#0 and emit a warning, as
> > this would indicate an unexpected change in the slot layout.
> > 
> > Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index ee499eaed4f3..00956ab2fbf5 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -333,10 +333,15 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
> >  	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
> >  	ndev->db_val = irq_no + 1;
> >  
> > -	if (irq_no == 0)
> > +	if (irq_no == 0) {
> >  		ntb_link_event(&ndev->ntb);
> > -	else
> > -		ntb_db_event(&ndev->ntb, irq_no);
> > +	} else if (irq_no == 1) {
> 
> Given that 0 and 1 have specific meanings, maybe create a enum with appropriate naming to make it more clear. Maybe something like this or however you want to name them:
> 
> enum EPF_IRQ_SLOT {
> 	EPF_IRQ_LINK = 0,
> 	EPF_IRQ_RESERVED_DB,
> 	EPF_IRQ_DB_START,
> };

Thanks for the suggestion, that sounds reasonable. I'd be happy to use the enum
names as proposed.

Frank, I'd like to introduce the same kind of enum in Patch 3 to eliminate
0/1/2 magic numbers for clarity and consistency. Please let me know if you have
a different view.

If you agree, I'll adjust vNTB part accordingly, and keep your Reviewed-by tags
if you're ok with that.

Thanks,
Koichiro

> > +		dev_warn_ratelimited(ndev->dev,
> > +				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
> > +		ntb_db_event(&ndev->ntb, 0);
> > +	} else {
> > +		ntb_db_event(&ndev->ntb, irq_no - 2);
> 
> And then here you can do
> ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
> 
> > +	}
> >  
> >  	return IRQ_HANDLED;
> >  }
> 
> 
