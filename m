Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4FCC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D977B20674
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LQnHvpDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfDPNnJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:43:09 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:35592 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfDPNnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 09:43:09 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id AFC7610C1019;
        Tue, 16 Apr 2019 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555422188; bh=sTIsGtY/7jzWK4wBDoxPpuQVdSHqUfH/XUnutKB2l7M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LQnHvpDm4p+1yovxc0131GQ/CV8yvGX4adLVE56P+ylMvQL++FDo6CYkouucU994j
         fkFu70tf+0eNpjpLCeywpVjXvjZICC8YsybtUlQFc5cEpAJjrcD0PiNorvWZirUvDX
         ljwzPRb5rbG0alijeibzKQj34MxoieW5viCPuUmGn9XGROV4XZRqIcp2CpRHuFLQuN
         vM4UoMk+92g2vzFER+jf8A8ZKVRmfF+6FXGIw/BxDnmgVDp9fKWCOR5HSHoUA2Ls6j
         CvIWybO4i74dCDoV4x47wQhY8RAAV6cleI/WUlWAL0I97zLOwC+N1gcSw8s7g4FJUi
         /7xiQ/kc/PuoA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 732B6A005A;
        Tue, 16 Apr 2019 13:43:08 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Apr 2019 06:43:07 -0700
Received: from DE02WEMBXA.internal.synopsys.com ([fe80::a014:7216:77d:d55c])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 16 Apr 2019 15:43:07 +0200
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: RE: [PATCH 2/2] PCI: dwc: Export APIs to support .remove()
 implementation
Thread-Topic: [PATCH 2/2] PCI: dwc: Export APIs to support .remove()
 implementation
Thread-Index: AQHU6uDUR7xXwQdAhE+dc4S79C4wm6Y+3dOQ
Date:   Tue, 16 Apr 2019 13:43:06 +0000
Message-ID: <305100E33629484CBB767107E4246BBB0A22B66D@de02wembxa.internal.synopsys.com>
References: <1554380425-29215-1-git-send-email-vidyas@nvidia.com>
 <1554380425-29215-3-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1554380425-29215-3-git-send-email-vidyas@nvidia.com>
Accept-Language: pt-PT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLThlNzNhOGZhLTYwNGQtMTFlOS05ODdkLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw4ZTczYThmYy02MDRkLTExZTktOTg3ZC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjYyNDkiIHQ9IjEzMTk5ODk1Nzg0MDIw?=
 =?us-ascii?Q?MzY0MiIgaD0iMmw2QkdQTXFDODljWGlUQkZOR2hxUHlza0dnPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?NmY4bFFXdlRVQWZOdzIycGpjdkhSODNEYmFtTnk4ZEVPQUFBQUFBQUFBQUFB?=
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

On Thu, Apr 4, 2019 at 13:20:24, Vidya Sagar <vidyas@nvidia.com> wrote:

> Export all configuration space access APIs and also other APIs to
> support host controller drivers of Designware core based

s/Designware/DesignWare

> implementations while adding support for .remove() hook to build their
> respective drivers as modules
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c |  4 +++
>  drivers/pci/controller/dwc/pcie-designware.c      | 38 +++++++++++++++++=
++++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 35 ++++-------------=
----
>  3 files changed, 48 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index d7881490282d..2a5332e5ccfa 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -333,6 +333,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
>  			    upper_32_bits(msi_target));
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
> =20
>  int dw_pcie_host_init(struct pcie_port *pp)
>  {
> @@ -515,6 +516,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		dw_pcie_free_msi(pp);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_host_init);
> =20
>  void dw_pcie_host_deinit(struct pcie_port *pp)
>  {
> @@ -522,6 +524,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
>  	pci_remove_root_bus(pp->root_bus);
>  	dw_pcie_free_msi(pp);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
> =20
>  static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bu=
s *bus,
>  				     u32 devfn, int where, int size, u32 *val,
> @@ -731,3 +734,4 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val |=3D PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 31f6331ca46f..f98e2f284ae1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -40,6 +40,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val=
)
> =20
>  	return PCIBIOS_SUCCESSFUL;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_read);
> =20
>  int dw_pcie_write(void __iomem *addr, int size, u32 val)
>  {
> @@ -57,6 +58,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val=
)
> =20
>  	return PCIBIOS_SUCCESSFUL;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_write);
> =20
>  u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
>  		       size_t size)
> @@ -89,6 +91,42 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __i=
omem *base, u32 reg,
>  		dev_err(pci->dev, "Write DBI address failed\n");
>  }
> =20
> +void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> +{
> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_writel_dbi);
> +
> +u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
> +{
> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_readl_dbi);
> +
> +void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
> +{
> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_writew_dbi);
> +
> +u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
> +{
> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_readw_dbi);
> +
> +void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
> +{
> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_writeb_dbi);
> +
> +u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
> +{
> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_readb_dbi);
> +
>  static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 r=
eg)
>  {
>  	u32 offset =3D PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index ea8d1caf11c5..86df36701a37 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -265,35 +265,12 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int i=
ndex,
>  			 enum dw_pcie_region_type type);
>  void dw_pcie_setup(struct dw_pcie *pci);
> =20
> -static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 =
val)
> -{
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
> -}
> -
> -static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
> -{
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
> -}
> -
> -static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 =
val)
> -{
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
> -}
> -
> -static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
> -{
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
> -}
> -
> -static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 v=
al)
> -{
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
> -}
> -
> -static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
> -{
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
> -}
> +void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
> +u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg);
> +void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val);
> +u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg);
> +void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val);
> +u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg);
> =20
>  static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32=
 val)
>  {
> --=20
> 2.7.4

Seems harmless. After word replacement, ack for the whole patch:

Acked-by: Gustavo Pimentel=20
<gustavo.pimentel@synopsys.com>

Thanks
Gustavo=20
Pimentel
