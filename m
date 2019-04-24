Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84EFC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 08:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69EE218DA
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZfTpEXof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfDXINi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:13:38 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:58970 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbfDXINh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 04:13:37 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 45C85C0B56;
        Wed, 24 Apr 2019 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556093615; bh=EgTH6WMMvIfMWdafDFAx1G59mvxCH+vG9GKmDsll5uI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZfTpEXofT8EME6EbYQ7WXDvRGUf1xyxwN6QoOiZJFSwTogwfCKxGBxQBpQh17FFCG
         7GAk4Cy3CXX2NdkyrjYglGKEOioDYkzk0axFttcplDIiBs+BpAkLFAWcUGXjEtDFfA
         lVoULIy2+DLNb1Wx68lv8HcE8iZh+O5io5vCPVERkkeWUP+z83fQFDFDLAk/sX3lBY
         aRKuwfFXfK3y665a14bSEXBeFKXh6iR31lE4QCIk8FaDOGr1oTH9+ouI/alyIXn52d
         VLYxW+r8pwIHjqRsEymUwCVr6tUwjU3bPE4WbhobPObgA2MqmuoOindxwkfyjnY+sk
         fj0qYzmUFttnw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 659DEA0066;
        Wed, 24 Apr 2019 08:13:34 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 24 Apr 2019 01:13:32 -0700
Received: from DE02WEMBXA.internal.synopsys.com ([fe80::a014:7216:77d:d55c])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 24 Apr 2019 10:13:32 +0200
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>
CC:     "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: RE: [PATCH V5 05/16] PCI: dwc: Move config space capability search
 API
Thread-Topic: [PATCH V5 05/16] PCI: dwc: Move config space capability search
 API
Thread-Index: AQHU+l2MevhF5SDfOUW7gQnVyY4x0aZK9lGg
Date:   Wed, 24 Apr 2019 08:13:31 +0000
Message-ID: <305100E33629484CBB767107E4246BBB0A230666@de02wembxa.internal.synopsys.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-6-vidyas@nvidia.com>
In-Reply-To: <20190424052004.6270-6-vidyas@nvidia.com>
Accept-Language: pt-PT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWQ2ZmZlODkyLTY2NjgtMTFlOS05ODdkLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxkNmZmZTg5NC02NjY4LTExZTktOTg3ZC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjUxNjAiIHQ9IjEzMjAwNTY3MjA5MTQx?=
 =?us-ascii?Q?NzY5MCIgaD0iSW1KaENpOEJmdTNGMWg3aXJFTHUvelBnRjZjPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?YWZGaVpkZnJVQVlzN3g5Y2xXcjdnaXp2SDF5VmF2dUFPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFGdGJCcHdBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhB?=
 =?us-ascii?Q?RzBBY3dCMUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZEFC?=
 =?us-ascii?Q?ekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?us-ascii?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QjFBRzBBWXdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVp3QjBBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhB?=
 =?us-ascii?Q?ZEFCeUFHRUFhUUJ1QUdrQWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFi?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZB?=
 =?us-ascii?Q?SEVBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWlFCZkFIUUFaUUJ5QUcw?=
 =?us-ascii?Q?QVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhZQVp3QmZBR3NBWlFC?=
 =?us-ascii?Q?NUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
x-originating-ip: [10.107.25.131]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 6:19:53, Vidya Sagar <vidyas@nvidia.com> wrote:

> Move PCIe config space capability search API to common DesignWare file
> as this can be used by both host and ep mode codes.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes from [v4]:
> * Removed redundant APIs in pcie-designware-ep.c file after moving them
>   to pcie-designware.c file based on Bjorn's comments.
>=20
> Changes from [v3]:
> * Rebased to linux-next top of the tree
>=20
> Changes from [v2]:
> * None
>=20
> Changes from [v1]:
> * Removed dw_pcie_find_next_ext_capability() API from here and made a
>   separate patch for that
>=20
>  .../pci/controller/dwc/pcie-designware-ep.c   | 37 +-----------------
>  drivers/pci/controller/dwc/pcie-designware.c  | 39 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  3 files changed, 43 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 2bf5a35c0570..65f479250087 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -40,39 +40,6 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pc=
i_barno bar)
>  	__dw_pcie_ep_reset_bar(pci, bar, 0);
>  }
> =20
> -static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
> -			      u8 cap)
> -{
> -	u8 cap_id, next_cap_ptr;
> -	u16 reg;
> -
> -	if (!cap_ptr)
> -		return 0;
> -
> -	reg =3D dw_pcie_readw_dbi(pci, cap_ptr);
> -	cap_id =3D (reg & 0x00ff);
> -
> -	if (cap_id > PCI_CAP_ID_MAX)
> -		return 0;
> -
> -	if (cap_id =3D=3D cap)
> -		return cap_ptr;
> -
> -	next_cap_ptr =3D (reg & 0xff00) >> 8;
> -	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
> -}
> -
> -static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
> -{
> -	u8 next_cap_ptr;
> -	u16 reg;
> -
> -	reg =3D dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
> -	next_cap_ptr =3D (reg & 0x00ff);
> -
> -	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
> -}
> -
>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>  				   struct pci_epf_header *hdr)
>  {
> @@ -612,9 +579,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
>  		return -ENOMEM;
>  	}
> -	ep->msi_cap =3D dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
> +	ep->msi_cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> =20
> -	ep->msix_cap =3D dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
> +	ep->msix_cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
> =20
>  	offset =3D dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>  	if (offset) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 8e0081ccf83b..ed21e861df82 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -20,6 +20,45 @@
>  #define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
>  #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
> =20
> +/*
> + * These APIs are different from standard pci_find_*capability() APIs in=
 the
> + * sense that former can only be used post device enumeration as they re=
quire
> + * 'struct pci_dev *' pointer whereas these APIs require 'struct dw_pcie=
 *'
> + * pointer and can be used before link up also.
> + */
> +static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
> +				  u8 cap)
> +{
> +	u8 cap_id, next_cap_ptr;
> +	u16 reg;
> +
> +	if (!cap_ptr)
> +		return 0;
> +
> +	reg =3D dw_pcie_readw_dbi(pci, cap_ptr);
> +	cap_id =3D (reg & 0x00ff);
> +
> +	if (cap_id > PCI_CAP_ID_MAX)
> +		return 0;
> +
> +	if (cap_id =3D=3D cap)
> +		return cap_ptr;
> +
> +	next_cap_ptr =3D (reg & 0xff00) >> 8;
> +	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> +}
> +
> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> +{
> +	u8 next_cap_ptr;
> +	u16 reg;
> +
> +	reg =3D dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
> +	next_cap_ptr =3D (reg & 0x00ff);
> +
> +	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> +}
> +
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
>  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 9ee98ced1ef6..35160b4ce929 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -248,6 +248,8 @@ struct dw_pcie {
>  #define to_dw_pcie_from_ep(endpoint)   \
>  		container_of((endpoint), struct dw_pcie, ep)
> =20
> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> +

Can you remove this extra line space?

>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> =20
> --=20
> 2.17.1


