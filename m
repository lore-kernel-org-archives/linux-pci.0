Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62739 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762001Ab2FVKS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 06:18:27 -0400
Received: by lbbgm6 with SMTP id gm6so3384811lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 03:18:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
References: <4FD849CF.4030009@firmworks.com> <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
 <4FD85127.8050301@firmworks.com> <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
 <4FDA2DDA.1030704@wwwdotorg.org> <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org> <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com> <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 22 Jun 2012 04:18:05 -0600
Message-ID: <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Mitch Bradley <wmb@firmworks.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2012 at 12:47 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Tue, Jun 19, 2012 at 11:31:39AM -1000, Mitch Bradley wrote:

>> Version A - 3 address cells:  In this version, the intermediate
>> address space has 3 cells:  port#, address type, offset.  Address
>> type is
>>   0 : root port
>>   1 : config space
>>   2 : extended config space
>>   3 : I/O
>>   4 : non-prefetchable memory
>>   5 : prefetchable memory.
>>
>> The third cell "offset" is necessary so that the size field has a
>> number space that can include it.
>>
>>       pcie-controller {
>>               compatible = "nvidia,tegra20-pcie";
>>               reg = <0x80003000 0x00000800   /* PADS registers */
>>                      0x80003800 0x00000200>; /* extended configuration space */
>>               interrupts = <0 98 0x04   /* controller interrupt */
>>                             0 99 0x04>; /* MSI interrupt */
>>               status = "disabled";
>>
>>               ranges = <0 0 0  0x80000000 0x00001000   /* Root port 0 */
>>                         0 1 0  0x80004000 0x00080000   /* Port 0 config space */
>>                         0 2 0  0x80104000 0x00080000   /* Port 0 ext config space *
>>                         0 3 0  0x80400000 0x00008000   /* Port 0 downstream I/O */
>>                         0 4 0  0x90000000 0x08000000   /* Port 0 non-prefetchable memory */
>>                         0 5 0  0xa0000000 0x08000000   /* Port 0 prefetchable memory */
>>
>>                         1 0 0  0x80001000 0x00001000   /* Root port 1 */
>>                         1 1 0  0x80004000 0x00080000   /* Port 1 config space */
>>                         1 2 0  0x80184000 0x00080000   /* Port 1 ext config space */
>>                         1 3 0  0x80408000 0x00010000   /* Port 1 downstream I/O */
>>                         1 4 0  0x98000000 0x08000000   /* Port 1 non-prefetchable memory */
>>                         1 5 0  0xa0000000 0x08000000>; /* Port 1 prefetchable memory */
>>
>>               #address-cells = <3>;
>>               #size-cells = <1>;
>>
>>               pci@0 {
>>                       reg = <0 0 0 0x1000>;
>>                       status = "disabled";
>>
>>                       #address-cells = <3>;
>>                       #size-cells = <2>;
>>
>>                       ranges = <0x80000000 0 0  0 1 0  0 0x00080000   /* config */
>>                                 0x90000000 0 0  0 2 0  0 0x00080000   /* extended config */
>>                                 0x81000000 0 0  0 3 0  0 0x00008000   /* I/O */
>>                                 0x82000000 0 0  0 4 0  0 0x08000000   /* non-prefetchable memory */
>>                                 0xc2000000 0 0  0 5 0  0 0x08000000>; /* prefetchable memory */
>>
>>                       nvidia,ctrl-offset = <0x110>;
>>                       nvidia,num-lanes = <2>;
>>               };
>>
>>
>>               pci@1 {
>>                       reg = <1 0 0 0x1000>;
>>                       status = "disabled";
>>
>>                       #address-cells = <3>;
>>                       #size-cells = <2>;
>>
>>                       ranges = <0x80000000 0 0  1 1 0  0 0x00080000   /* config */
>>                                 0x90000000 0 0  1 2 0  0 0x00080000   /* extended config */
>>                                 0x81000000 0 0  1 3 0  0 0x00008000   /* I/O */
>>                                 0x82000000 0 0  1 4 0  0 0x08000000   /* non-prefetchable memory */
>>                                 0xc2000000 0 0  1 5 0  0 0x08000000>; /* prefetchable memory */
>>
>>                       nvidia,ctrl-offset = <0x118>;
>>                       nvidia,num-lanes = <2>;
>>               };

I'm not familiar with device tree, so pardon me if these are stupid
questions.  These seem to be describing PCI host bridges.  I assume
some of these ranges describe MMIO, prefetchable MMIO, and I/O port
apertures that the bridge forwards to the PCI bus.

Is there provision for any address offset applied by the bridge when
it forwards downstream?  (Maybe these bridges don't apply any offset?)
 "0xa0000000 0x08000000" appears for both ports 0 and 1 prefetchable
memory; I don't know if that's an error, an indication that each
bridge applies a different offset, or that both bridges forward the
same aperture (I hope not the latter, because Linux can't really deal
with that).

Is the bus number aperture included somewhere?  How do we know what
bus numbers are available for allocation under each bridge?

I see mention of config space.  Is some of that referring to the ECAM
as in 7.2.2 of the PCIe spec v3.0 (what we refer to as MMCONFIG on
x86)?
