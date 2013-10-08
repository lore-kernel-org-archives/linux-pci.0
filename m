Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:45074 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751995Ab3JHGG4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 02:06:56 -0400
Date: Tue, 8 Oct 2013 11:36:43 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: designware: Make dw_pcie_rd_own_conf(), etc., static
Message-ID: <20131008060643.GA13048@pratyush-vbox>
References: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAErSpo6KauiOBXh3QOS9=6QC_bjQqTgiDtnCAo1eb0d=uKgo-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo6KauiOBXh3QOS9=6QC_bjQqTgiDtnCAo1eb0d=uKgo-A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 08, 2013 at 08:07:24AM +0800, Bjorn Helgaas wrote:
> On Mon, Oct 7, 2013 at 6:04 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > The following variables and functions are used only in pcie-designware.c,
> > so make them static:
> ...
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index c10e9ac..900e875 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -64,7 +64,7 @@
> >
> >  static struct hw_pci dw_pci;
> >
> > -unsigned long global_io_offset;
> > +static unsigned long global_io_offset;
> 
> While you're looking at this, I think "cfg_read()" and "cfg_write()"
> are too generic to be global symbols.  I don't know if it would make
> sense to rename them "dw_cfg_read()", pass around pointers in a
> structure or what.

In fact cfg_read, cfg_write & sys_to_pcie should go to common library,
as you will find similar function in other files too.

Regards
Pratyush

> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
