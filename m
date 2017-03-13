Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:17265 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdCMNKQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2017 09:10:16 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "liudongdong (C)" <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Bad DT binding (hisi-pcie-almost-ecam)
Date: Mon, 13 Mar 2017 13:09:52 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E2047C93F@FRAEML521-MBX.china.huawei.com>
References: <20170310174045.GB24571@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E2047A8C1@FRAEML521-MBX.china.huawei.com>
 <20170313104356.GA23239@leverpostej>
In-Reply-To: <20170313104356.GA23239@leverpostej>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mark

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: 13 March 2017 10:44
> To: Gabriele Paoloni
> Cc: liudongdong (C); Bjorn Helgaas; Wangzhou (B);
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: Bad DT binding (hisi-pcie-almost-ecam)
> 
> Hi,
> 
> On Mon, Mar 13, 2017 at 08:14:19AM +0000, Gabriele Paoloni wrote:
> > > -----Original Message-----
> > > From: Mark Rutland [mailto:mark.rutland@arm.com]
> 
> > > The commit adds the "hisilicon,pcie-almost-ecam", which goes
> against
> > > the
> > > usual DT conventions, and is non-sensical in that it describes the
> IP
> > > based on what it isn't.
> > >
> > > This binding shouldn't have gone in as-is, and we should fix it
> before
> > > v4.11.
> > >
> > > The binding states that this IP is found in Hip06 and Hip07. For
> these
> > > cases we'd usually take the name of the first implementation, e.g.
> > > something like "hisilicon,hip06-pcie", which can be used as a
> fallback
> > > in the compatible list if reused in subsequent SoC generations.
> > >
> > > I also see that "hisilicon,hip06-pcie" already exists, so I'm even
> more
> > > suspicious.
> >
> > For Hip06 the IP is the same but in we have a different BIOS
> configuration
> > that allows the controller be ECAM compliant for all the devices of
> the
> > hierarchy except the RC.
> >
> > > What exactly is the "hisilicon,pcie-almost-ecam" binding trying to
> > > describe? Is it a different IP also found on Hip06, or is it a new
> > > binding for the same IP?
> >
> > The reason why we need this new BIOS is to support the recent PCIe
> quirks
> > for the ACPI Root Port driver (commit
> 5b69b85ba1ddd36be01f5c57830b37a3c8256009
> > "PCI/ACPI: Check for platform-specific MCFG quirks"). So using one
> BIOS we
> > support both DT and ACPI.
> > This is the reason why you see Hip-06 being already there...
> 
> Ok. Thanks for clarifying that.
> 
> What I think we should do is:
> 
> a) Update the binding document to clarify when these strings are used.
> 
> b) Use an SoC prefix in the string. I'm happy to have both hip06 and
> hip07
>    strings.
> 
> c) Drop the "almost", since we don't use that elsewhere. (e.g. for
>    cavium,pci-host-thunder-ecam"
> 
> Would you be happy with the below?

Yes indeed it would work for us.

We could discuss about the appropriateness of ecam vs almost-ecam,
but I don't think it is of much value as long as we make the meaning
clear in the Documentation

We'll send the fix below to lists in a separate patch...

Many Thanks
Gab

> 
> Thanks,
> Mark.
> 
> ---->8----
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> index b7fa3b9..535426d 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -44,13 +44,19 @@ Hip05 Example (note that Hip06 is the same except
> compatible):
>         };
> 
>  HiSilicon Hip06/Hip07 PCIe host bridge DT (almost-ECAM) description.
> +
> +Some BIOSes place the host controller in a mode where it is ECAM
> compliant for
> +all devices other than the root complex. In such cases, the host
> controller
> +should be described as below.
> +
>  The properties and their meanings are identical to those described in
>  host-generic-pci.txt except as listed below.
> 
>  Properties of the host controller node that differ from
>  host-generic-pci.txt:
> 
> -- compatible     : Must be "hisilicon,pcie-almost-ecam"
> +- compatible     : Must be "hisilicon,hip06-pcie-ecam", or
> +                   "hisilicon,hip07-pcie-ecam"
> 
>  - reg            : Two entries: First the ECAM configuration space for
> any
>                    other bus underneath the root bus. Second, the base
> @@ -59,7 +65,7 @@ host-generic-pci.txt:
> 
>  Example:
>         pcie0: pcie@a0090000 {
> -               compatible = "hisilicon,pcie-almost-ecam";
> +               compatible = "hisilicon,hip06-pcie-ecam";
>                 reg = <0 0xb0000000 0 0x2000000>,  /*  ECAM
> configuration space */
>                       <0 0xa0090000 0 0x10000>; /* host bridge
> registers */
>                 bus-range = <0  31>;
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index fd66a31..bd5b1b4 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -380,7 +380,11 @@ struct pci_ecam_ops hisi_pcie_platform_ops = {
> 
>  static const struct of_device_id hisi_pcie_almost_ecam_of_match[] = {
>         {
> -               .compatible = "hisilicon,pcie-almost-ecam",
> +               .compatible = "hisilicon,hip06-pcie-ecam",
> +               .data       = (void *) &hisi_pcie_platform_ops,
> +       },
> +       {
> +               .compatible = "hisilicon,hip07-pcie-ecam",
>                 .data       = (void *) &hisi_pcie_platform_ops,
>         },
>         {},
