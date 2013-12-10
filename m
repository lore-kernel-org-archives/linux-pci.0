Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35128 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3LJXVY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 18:21:24 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so9527348iec.5
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2013 15:21:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a8c8cc16a5424e45b226bb40425b3772@DM2PR05MB671.namprd05.prod.outlook.com>
References: <a8c8cc16a5424e45b226bb40425b3772@DM2PR05MB671.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Dec 2013 16:21:04 -0700
Message-ID: <CAErSpo7XQeMr+t3e93-vrFBNmF2w7aQ1UqY8bnSRxQcc+uah1w@mail.gmail.com>
Subject: Re: Question about how PCI subsystem uses device trees
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc devicetree list; I'm devicetree-illiterate]

On Tue, Dec 10, 2013 at 12:53 PM, Rajat Jain <rajatjain@juniper.net> wrote:
> Hello,
>
> I am trying to understand and create device tree for a new powerpc platform. (Please feel free to point out any problems with my device tree below.) My questions:
>
> 1) For a PCI-PCI bridge that I'm representing like this:
>
> pcie@2,3 {
>         vendor-id = <0x10b5>;
>       device-id = <0x8618>;
>       class-code = <0x060400>;
>       #size-cells = <2>;
>       #address-cells = <3>;
>       device_type = "pci";
>       bus-range = <0x20 0x2f>;
>       reg = <0x00021800 0x00000000 0x000000000        /* Cfg:2.3.0: */
>              0x00000000 0x00000000>;
>       ranges = <0x02000000 0x00000000 0xA0000000      /* Mem behind bridge: 0xA0000000 - 0xA03FFFFF */
>                 0x02000000 0x00000000 0xA0000000
>                 0x00000000 0x04000000>;
> };
>
> Is the above is only to _notify_ the kernel that this is how the firmware shall be setting the PCI bridge (Thus firmware has obligation of setting it like this before passing control to the kernel), and hence the kernel will merely take note of it and not really configure the bridge registers?
>
> Or is the above telling the kernel that this is how the kernel should _setup_ the device (thus firmware does not set up the device, but rather the kernel use this info to setup the device)?
>
> 2) For an PCI endpoint that I am representing like this:
>
>
> xyz@20,0 {
>         vendor-id = ...
>       device-id = ...
>       class-code = <0x0880>;
>       compatible = ...
>         ...
>       reg = <0x00200000 0x00000000 0x00000000 /* Cfg:20.0.0: */
>              0x00000000 0x00000000
>              0x02200010 0x00000000 0xA0000000 /* Mem:20.0.0:(Bar0) 64MB@0xA0000000 */
>              0x00000000 0x04000000>;
>         ...
> };
>
> Does the above tell the kernel to _program_ the BAR0 register using the above address? Or does it cause the kernel to assume that the BAR0 has been programmed with this address?
>
> 3) Lastly, what is the difference in behavior when I select PCI_PROBE_NORMAL over PCI_PROBE_DEVTREE?
>
> Thanks,
>
> Rajat
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
