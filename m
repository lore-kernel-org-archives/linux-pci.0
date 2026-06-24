Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020096.outbound.protection.outlook.com [52.101.229.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63366228CB0;
	Wed, 24 Jun 2026 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264952; cv=fail; b=GwLkdF8E+2S8LV2v8EK8cULoE/TX4mkfkitLIgF8Puid7VlMiodLgW7vogodTt27tNIVflIrOky9y9LOSFWGH6NHkbkd3g2mBvsUqloXmLdnuLbCJ7MFC/ad0G6G6Fn/gHvk08KJVlk03vPyU96jj2bSgvpnDaJDLqiZcYZo0Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264952; c=relaxed/simple;
	bh=snTmq9xLEJ1dzYeOMcOpuwAiXIHxBFdfbNgknWwVT5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NrpPu1VBUn82IX46r9d0XDIMhOxru7a9OMtisyrYopiv69YWKslEOyuzChnweXuEmoUBgwR28lmBHJR8ltqX1X4cwVjSLU/ARlJ0aoBvGeQ0J9Y2M85YCrh5xiAx4l9iVABr7xpXGWT6fF4/60yHy5iC8+JA4lyedkRR2AKdQ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=S6sW32NO; arc=fail smtp.client-ip=52.101.229.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="S6sW32NO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4GknsNbUKSeRZvGbJhAwztVNwqMfyp9eIuPz60jrob0dJeNsyhxtMmHgDWbnyI1WphVgQNU4zywLfdfGLN9tXXlWETbzbzAC0/HS3PlWmVUlHUm7hM+6OUifLLDXX/ZBZvKP/ajSjMWuA3GpCu2zcGYz6yBjWMFCMscRLBDM/ILKKljW3BKgRvAVF730lu0qhu1H6YqOY5rQaxp5MyVDjnZIeBTY/C741QYPrZUptgs8ZO2xSIjhHv4ByYbaO1Bo8GRud+/Fh3DgAOnmWIN44FRfSsvuDiJ2HaH/JAgVy0gmU3dUb5L/LWkPREAWY7t1Ve+tTfq38nf52GLokobSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gl8uQ0ey2qyYgOHBzHtEtsGELYqMCyVWHb7Q105Txlk=;
 b=D9ajWnHtAZa+txGOS517PugZNSdmwkGSd9zI9Y+HAByqEdZQIsyu7qGWf/UzB4ZJdKUIKUyRSRaQQj8UrQHJZanrY/OZ/vXk77O18LQzQ3wZyobz2iyFj3x/nVyc+yCli2DQ2Wt2wO7NMxgmU51SqxRTuL9PpvxXSmMuS1lG+lnDqT0ZEkhgMXCf0MR/BVdwifiQoDBqjTcVlanIEzaDRFGkhzLNdkdnznZyP5XGfrVy2Hu6bo0YnyKM93g0ubVfUwUd2tsSRpDwbH3e93p+948qybzI1DD+mXEGpYir3y1Ypx/Po/KHEz87On8b+t3akgCTIBdnbAdYKwq5gkVmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl8uQ0ey2qyYgOHBzHtEtsGELYqMCyVWHb7Q105Txlk=;
 b=S6sW32NOpKbnhgNq/7RiSjkog80W2a0tlso7hrK6HniSOSj6daR9M5gFXqWxmLsMjwPqsGzn8JYo7aoBb0vm6Eraylf+nj9HSEq1uG7Row5bkor0d/WaRG97I8EwS0n10CT0gK3kShjLYAZHr4z3Pt0CnoVk3DLrDVi2I4naZfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2920.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 01:35:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 01:35:45 +0000
Date: Wed, 24 Jun 2026 10:35:43 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v4 12/12] NTB: epf: Implement db_vector_count/mask for
 doorbells
Message-ID: <zo4ujr5n2rdlkhnssq4b23bbeobz3yyuugchghkszyifw4dj2w@5qsvn5vhdedj>
References: <20260513024923.451765-13-den@valinux.co.jp>
 <20260623163134.GA813775@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623163134.GA813775@bhelgaas>
X-ClientProxiedBy: TY4PR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:405:372::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2920:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a44996-7b01-4cfe-ec07-08ded190e904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|23010399003|22082099003|18002099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QJ76RhhE1Qo+GxFEdOB+d7x8rAFVAMWBUuEzePX6EQUqrpzIPBKDMzpsYufRgzxGBBHj1wo8YkYmRwtd2HegOAdHsxGjNM4SeIdcQBgY9eq8pqF+znJRrl9DP5YrdeEYN4QdxJ5SdSGLoHCE0lHDjC5HXaTnTwP033Xy4pfYvMRicefjqVPExUdRTERLgapvIVTO9psdEEH9AAXmnjEQ4iJG89lt4xb7+RTi73zIimqoq6957w9K979c2F/XTD2cf72rXsqVifI9tz1ibemxGAxQMAgUvz2oD8ePTk6Fjvd8dLgIAXcxPQBymXHKlIkt4L8E0wyxtI21BD9Jw78iy9VWTBzGdrNKd+VjHL+ZOqXKxcHo6XfzjlOlHp9XdC5YxQo2hnVb5G+NQUvg/Xc9cnR8SmckKLNkd/doJFynH8m7qJ4D1zsun98d1BcWfvDijhWfAQ/ptlCnPW+43JNYwygdpFrXZbaOn01WCEBwBF9jGxpsji/Csj+r+1wHC7FjWO6jS6LiFImYwa0q33ytjopLyCW3jUl/ouyORRiUSpad2X4f1lF5giFFjsn+aUQva3Jo5758k9COZx+5R6byyuW94TljngO/uMYE6UceUgCENRPGSpl4KoEpaCJENav5pH5wsbBe27JM1Zq+Gk1ahJkJkKMbwRwKhz0qSaJToRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CCzXCyA0d+kDRZpFiUsHhQsvvNgO+np/GeZzJXasX38qzLlGQ0pn3r1R0Rjy?=
 =?us-ascii?Q?kdJFBMUC7HpTHy6PyRf+i67poWDF/yObvN4ihSR+3fUcOiKhPj/jxx+/EdS1?=
 =?us-ascii?Q?CynzDJOIRP1dZVSAbSPDW6drJhGcTQcKgKsHI8/OVdDIR1G7IiDGTkfmah0i?=
 =?us-ascii?Q?IXx+UzAAjMJ13Fv7w++jb1y7C4CHiTEBdjowR/K91Yj1uzNOd6Uz3DEs0Cf0?=
 =?us-ascii?Q?3GxevB/e1ZGjB8Nlii5knUBwwX+hrn1R48ITFGYT2QTk2aiPPCHavz3kye8a?=
 =?us-ascii?Q?eCk5HhZxgUBd1MzqzySO+z/Go/xboO5tgyTzNB8Z0pQrBIabEkXxXjxo370D?=
 =?us-ascii?Q?PVF5XfKSuo+epczCS4IBa2KU7qKUWdZtvFTYb6neTu+Y/QR/l2ojNAVwiUE3?=
 =?us-ascii?Q?5J4nluS14xsa9R1tnNOQ+6GaT6fu7Tlj9pLYhQyF0kxEm6nqOn0BEhL9/zRC?=
 =?us-ascii?Q?eOpn8X0EiSC3BtCupTm+a1rmtt3UHa0JnPcEXrRrXJ8LhHe7FBlBq3z63ikq?=
 =?us-ascii?Q?Var3Yn7vITMJ+WI8u42i3tYnuf8oKgGY4WY3JAPVvNZC43Drea3kSvqMGWTf?=
 =?us-ascii?Q?QVqBA6p1g4un+EdHeX5Pl2eKvIKbB9/LJSGNMiODRWQnOmwhJOwfuK9kn6BL?=
 =?us-ascii?Q?xfJ7x0m0RGyLGE07LOShCedoEwEgnvws7KRS1YrDBg0Upc/zQfvMgV4xgsUK?=
 =?us-ascii?Q?71HgtSqfxqclDE09SwQU4FZj4f57ZxWlP8XbptrJyKNb8Q3zbSNkBTHelALL?=
 =?us-ascii?Q?vauVMcl4Y0o1AwPrZSJu3dTjlFi7JxZiPvtiKffvwVDzQe8pWfGleXwHrSca?=
 =?us-ascii?Q?gf5LkdCVMpstVxyDIqiWxRtNdQ4/J+SPKEDqYA5ADCEnnAauS7gT3bSLdZ/x?=
 =?us-ascii?Q?RuRoiMGxkCAsDEfR/P+7gMURYj2M/ncHaN/ByrGPKXmhamFPaRmAzsSBAsBe?=
 =?us-ascii?Q?MvGCSatgaKZQEpqUYYwfEwUpyaYaGgqRlYUqslNYGsnWxL9wR0XH6RGPLVGQ?=
 =?us-ascii?Q?eeOKdeowoajiI49UmFF05/Cl5ExeAcIkkNADkBEWfXAQLFyJC1OBxPi/iJrM?=
 =?us-ascii?Q?BOUi50rdDoVfUuWMWszINq+QHiHBFi5RRCidBUVyntE5oXAY/GZmEqlEk9pP?=
 =?us-ascii?Q?tYlXN0LFs0j9VIQ6PWdXkmjImlWn7kXMMHvLsO2pL9bVcYWStmsZCJkS62us?=
 =?us-ascii?Q?X5e4Ep+3dmWrsYngtJ/ADxKentoueuz8+a3MH00UMitG1KmLxGL/hWpfIlM9?=
 =?us-ascii?Q?81TPOl6ZZRZ96GG3mMnrZi9EUMZVK0vAn4vlq9VL2X75mx2UAEiKoOJU2WJQ?=
 =?us-ascii?Q?/BZvIk3ZGDk0KJGVNF6XO1IQnbbPLk279cFUb2QsO19DNeukDUeNWTpXV6Iy?=
 =?us-ascii?Q?75aK5dwFasWwgzf8fOkKEXaqFfnNX3lX9ubpPhCrexDi0DvCgU7G+Q0SfOZT?=
 =?us-ascii?Q?CRW/+ChrKe68Sr3g91S8AkfTq7RovaYdkAHUyYCDROeSSQK+1v5VKO0a06CV?=
 =?us-ascii?Q?kNs/HeAy7Nnyx0WqhcgUb99WlpTtw1sUmDvpMQ7257+2A4ota6aYJhvcCNfP?=
 =?us-ascii?Q?mlLka7VG3CNfTKBTClWTqs4+wPCOPi9eHeORSvH2rkx9dBi9Utr0u5RVSV3d?=
 =?us-ascii?Q?YF2HbNf7OWQaeRZPEEwy46G5yB5a2TNRhNP8H89x5Kb1GjajkX/+eK11kjlK?=
 =?us-ascii?Q?yJNjIT5A4V+hOO+R7XKGj3djAKT3Jbsh5YLuWP+5a7mPpLVjhQmqP2OC7VYf?=
 =?us-ascii?Q?V1TPnBiUy1PKqml1/uEehn0PIiQY0urW+lmU5zDEq+h+p+tXdypO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a44996-7b01-4cfe-ec07-08ded190e904
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 01:35:44.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9ZXdRTf3sdtxmV/yZpye/DuY/8LjeG0SBXMjTylTJRDrwJFKLGMAhSCx8pynNFk963YnQILyUEOdkhGFDIiWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2920

On Tue, Jun 23, 2026 at 11:31:34AM -0500, Bjorn Helgaas wrote:
> On Wed, May 13, 2026 at 11:49:23AM +0900, Koichiro Den wrote:
> > Implement .db_vector_count and .db_vector_mask so ntb core/clients can
> > map doorbell events to per-vector work.
> > 
> > Report vectors as 0..(db_count - 2) (skipping the unused slot) and return
> > BIT_ULL(db_vector) for the corresponding doorbell bit. Use
> > ntb_epf_db_vector_count() for bounds checks in ntb_epf_db_vector_mask(), so
> > the same lower-bound guard is applied before building the bitmask.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v3:
> >   - Reuse ntb_epf_db_vector_count() from ntb_epf_db_vector_mask() for bounds.
> >   - Return 0 when db_count is below NTB_EPF_MIN_DB_COUNT.
> >   - Drop Reviewed-by tags due to the changes.
> > 
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index 10618e462229..af5755472842 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -434,6 +434,36 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
> >  	return ntb_ndev(ntb)->db_valid_mask;
> >  }
> >  
> > +static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
> > +{
> > +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > +	unsigned int db_count = ndev->db_count;
> > +
> > +	/*
> > +	 * db_count includes an extra skipped slot due to the legacy
> > +	 * doorbell layout. Expose only the real doorbell vectors.
> > +	 */
> > +	if (db_count < NTB_EPF_MIN_DB_COUNT)
> > +		return 0;
> > +
> > +	return db_count - 1;
> > +}
> > +
> > +static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> > +{
> > +	int nr_vec;
> > +
> > +	/*
> > +	 * db_count includes one skipped slot in the legacy layout. Valid
> > +	 * doorbell vectors are therefore [0 .. (db_count - 2)].
> > +	 */
> > +	nr_vec = ntb_epf_db_vector_count(ntb);
> > +	if (db_vector < 0 || db_vector >= nr_vec)
> > +		return 0;
> > +
> > +	return BIT_ULL(db_vector);
> 

Hi Bjorn,

> This all ends up looking slightly different from pci-epf-vntb.c, and
> it's not obvious whether the differences are essential or superfluous.

I don't think there is an actual bug here.

The thing is that "db_count" has meant slightly different things in
pci-epf-vntb.c and ntb_hw_epf.c since their introduction.

In pci-epf-vntb.c, db_count is the total number including the link slot and the
historically unused/skipped slot. It is also exposed via configfs, so changing
that meaning now would affect existing users' configfs settings.

So vntb_epf_db_vector_count() subtracts EPF_IRQ_DB_START because the NTB core
should only see the usable doorbell vectors via .db_vector_count().

> 
> pci-epf-vntb.c:
> 
>   enum EPF_IRQ_DB_START                           # value 2
>   #define MIN_DB_COUNT  (EPF_IRQ_DB_START + 1)    # value 3
> 
>   vntb_epf_db_vector_count() comment says "db_count is total number of
>   doorbell slots exposed to peer, including reserved ones".  But it
>   returns "db_count - EPF_IRQ_DB_START", which suggests that the
>   reserves slots are not exposed?
> 
>   vntb_epf_db_vector_count() comment lists two reserved slots
> 
>   vntb_epf_db_vector_count() returns "db_count - EPF_IRQ_DB_START"
> 
>   vntb_epf_db_vector_mask() comment mentions "two reserved slots"
> 
> ntb_hw_epf.c:
> 
>   enum EPF_IRQ_DB_START                # value 2
>   #define NTB_EPF_MIN_DB_COUNT  3      # value 3, not based on EPF_IRQ_DB_START
> 
>   ntb_epf_db_vector_count() comment says "expose only real doorbell
>   vectors".  I guess this *excludes* the reserved ones?

Yes.

> 
>   ntb_epf_db_vector_count() comment mentions "an extra skipped slot"
>   but apparently actually accounts for *two* slots
>   (NTB_EPF_MIN_DB_COUNT==3)
> 
>   ntb_epf_db_vector_count() returns "db_count - 1"   # should it be -2?

This is intentionally -1.

ntb_hw_epf sets "ndev->db_count = irq - 1" where the "-1" accounts for the link
slot. That goes back to the initial ntb_hw_epf support commit 812ce2f8d14ea. So
the number of usable doorbell vectors is "db_count - 1", subtracting the
remaining unused/skipped slot.

> 
>   ntb_epf_db_vector_mask() comment mentions "one skipped slot"
> 
> I don't want to change anything during the v7.2 merge window, but if
> there are any actual bugs here, they could be fixed after v7.2-rc1.
> If there are no bugs but this could be clarified to reduce confusion,
> we could do that for v7.3.

If preferred, I can send a follow-up patch that adds comments to make the
distinction clearer.

Best regards,
Koichiro
