Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34467 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbHELwH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2015 07:52:07 -0400
Received: by wicne3 with SMTP id ne3so1307256wic.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2015 04:52:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150805092533.GC6092@arm.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com> <20150805092318.GB6092@arm.com> <20150805092533.GC6092@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 5 Aug 2015 06:51:47 -0500
Message-ID: <CAErSpo5g0VGeQeHArys+h_6eQuQnV+dH+bHBaLmJC1EdA-q4Hw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
To: Will Deacon <will.deacon@arm.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 5, 2015 at 4:25 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Aug 05, 2015 at 10:23:18AM +0100, Will Deacon wrote:
>> That said, I just tried to build this and it fails to compile the x-gene
>> PCI host driver. Fixup below.
>
> Wait, there's more!

Thanks!  I fixed these two and updated pci/enumeration.  But the 0-day
build also found this:

commit: cc44fbb49d995ad2348d530300abf7877105094f [4/13] ARM/PCI,
designware, xilinx: Use pci_scan_root_bus_msi()
   drivers/built-in.o: In function `dw_msi_setup_irq':
>> :(.text+0x2a3c8): undefined reference to `pci_write_msi_msg'

I don't see the problem there yet, and I'm going on vacation until
Monday, so I won't be able to do anything with this until then.

Bjorn


> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 514f41b86c49..8ab3bd098424 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -506,7 +506,7 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port)
>  {
>         struct device_node *msi_node;
>
> -       msi_node = of_parse_phandle(port->dev.of_node, "msi-parent", 0);
> +       msi_node = of_parse_phandle(port->dev->of_node, "msi-parent", 0);
>         if (!msi_node)
>                 return -ENODEV;
>
> @@ -515,7 +515,7 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port)
>                 return -ENODEV;
>
>         of_node_put(msi_node);
> -       port->msi->dev = &port->dev;
> +       port->msi->dev = port->dev;
>         return 0;
>  }
>
>
