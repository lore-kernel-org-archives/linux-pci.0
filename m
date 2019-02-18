Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAB8C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 00:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7B12184E
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 00:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfBRAmt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:42:49 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:12133 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727584AbfBRAmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Feb 2019 19:42:49 -0500
X-UUID: 68d9ec609ee24b9d9ff104f97ead9701-20190218
X-UUID: 68d9ec609ee24b9d9ff104f97ead9701-20190218
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1175317232; Mon, 18 Feb 2019 08:42:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 08:42:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 18 Feb 2019 08:42:36 +0800
Message-ID: <1550450556.4980.71.camel@mhfsdcap03>
Subject: Re: [pci:pci/portdrv 1/1] drivers/pci/pcie/portdrv_pci.c:187:9:
 sparse: warning: Initializer entry defined twice
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     kbuild test robot <lkp@intel.com>, <kbuild-all@01.org>,
        <linux-pci@vger.kernel.org>
Date:   Mon, 18 Feb 2019 08:42:36 +0800
In-Reply-To: <20190215200045.GS96272@google.com>
References: <201902151544.kWECyQ24%fengguang.wu@intel.com>
         <1550218723.4980.69.camel@mhfsdcap03> <20190215200045.GS96272@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-02-15 at 14:00 -0600, Bjorn Helgaas wrote:
> On Fri, Feb 15, 2019 at 04:18:43PM +0800, Honghui Zhang wrote:
> > On Fri, 2019-02-15 at 15:34 +0800, kbuild test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/portdrv
> > > head:   b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa
> > > commit: b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa [1/1] PCI/portdrv: Support PCIe services on subtractive decode bridges
> > > reproduce:
> > >         # apt-get install sparse
> > >         git checkout b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa
> > >         make ARCH=x86_64 allmodconfig
> > >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> drivers/pci/pcie/portdrv_pci.c:187:9: sparse: warning: Initializer entry defined twice
> > >    drivers/pci/pcie/portdrv_pci.c:189:9: sparse:   also defined here
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > > 
> > >    drivers/pci/pcie/portdrv_pci.c:187:9: sparse: warning: Initializer entry defined twice
> > > >> drivers/pci/pcie/portdrv_pci.c:189:9: sparse:   also defined here
> > > 
> > > vim +187 drivers/pci/pcie/portdrv_pci.c
> > > 
> > > ^1da177e Linus Torvalds 2005-04-16  181  
> > > ^1da177e Linus Torvalds 2005-04-16  182  /*
> > > ^1da177e Linus Torvalds 2005-04-16  183   * LINUX Device Driver Model
> > > ^1da177e Linus Torvalds 2005-04-16  184   */
> > > ^1da177e Linus Torvalds 2005-04-16  185  static const struct pci_device_id port_pci_ids[] = { {
> > > ^1da177e Linus Torvalds 2005-04-16  186  	/* handle any PCI-Express port */
> > > ^1da177e Linus Torvalds 2005-04-16 @187  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> > > b4f663e3 Honghui Zhang  2019-02-14  188  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
> > > b4f663e3 Honghui Zhang  2019-02-14 @189  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0),
> > > ^1da177e Linus Torvalds 2005-04-16  190  	}, { /* end: all zeroes */ }
> > > ^1da177e Linus Torvalds 2005-04-16  191  };
> > > ^1da177e Linus Torvalds 2005-04-16  192  
> > > 
> > Hi, Bjorn,
> > Do you think drop this one, and I send a new version is a good idea? Or
> > will you re-consider the first version patch?
> 
> The problem was just missing braces.  I replaced it with the following
> patches:

Oh, my mistake, thanks very much for pointing this out and fix it.

Thanks.
> 
> commit c89f7f98c971e0cabc819b6c0fe6bf509287b7e0
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Feb 15 13:49:18 2019 -0600
> 
>     PCI/portdrv: Use conventional Device ID table formatting
>     
>     The pci_device_id table was technically correct, but unusually formatted,
>     which made adding entries error-prone.  Change the format so it's obvious
>     how to add entries.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 0acca3596807..a289e734b9a4 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -182,10 +182,10 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>  /*
>   * LINUX Device Driver Model
>   */
> -static const struct pci_device_id port_pci_ids[] = { {
> +static const struct pci_device_id port_pci_ids[] = {
>  	/* handle any PCI-Express port */
> -	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> -	}, { /* end: all zeroes */ }
> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
> +	{ },
>  };
>  
>  static const struct pci_error_handlers pcie_portdrv_err_handler = {
> 
> commit f0cfecea8d1e8e0cd5d5053f9452b3a450f49eb5
> Author: Honghui Zhang <honghui.zhang@mediatek.com>
> Date:   Thu Feb 14 13:21:17 2019 +0800
> 
>     PCI/portdrv: Support PCIe services on subtractive decode bridges
>     
>     The Class Code for subtractive decode PCI-to-PCI bridge is 060401h; add an
>     entry to make portdrv support this type of bridge.  This allows use of PCIe
>     services on subtractive decode ports.
>     
>     Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
>     [bhelgaas: add braces surrounding entry]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index a289e734b9a4..99d2abe88d0b 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -185,6 +185,8 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>  static const struct pci_device_id port_pci_ids[] = {
>  	/* handle any PCI-Express port */
>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
> +	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
>  	{ },
>  };
>  


