Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33045 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbdECMCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2017 08:02:17 -0400
Received: by mail-oi0-f68.google.com with SMTP id h4so4334475oib.0
        for <linux-pci@vger.kernel.org>; Wed, 03 May 2017 05:02:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170503103153.GB10800@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-6-lorenzo.pieralisi@arm.com> <CAK8P3a1bnnq-9iuse43bCNX_9TirZPOtmH_vFsvJ9VOAsoUBzQ@mail.gmail.com>
 <20170503103153.GB10800@red-moon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 3 May 2017 14:02:16 +0200
Message-ID: <CAK8P3a2Ww0DtTq_ZeACJPC7oGkoY3YP4GQB7RWouY2=e9gck1A@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 05/18] ARM: PCI: dove: Convert PCI scan API to pci_scan_root_bus_bridge()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 3, 2017 at 12:31 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Apr 28, 2017 at 02:38:48PM +0200, Arnd Bergmann wrote:
>> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > The introduction of pci_scan_root_bus_bridge() provides a PCI core
>> > API to scan a PCI root bus backed by an already initialized
>> > struct pci_host_bridge object, which simplifies the bus scan
>> > interface and makes the PCI scan root bus interface easier to
>> > generalize as members are added to the struct pci_host_bridge().
>> >
>> > Convert ARM dove platform code to pci_scan_root_bus_bridge() to improve
>> > the PCI root bus scanning interface.
>> >
>> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>
>> Is this patch required for one of the later steps in the series?
>>
>> As non-DT dove uses the traditional pci_common_init() helper rather
>> than registering its own driver, I wonder if there is anything to gain here.
>
> Well, the point is, the non-DT platforms I patched implement a custom
> .scan method in struct hw_pci. If we move the bridge allocation to
> pcibios_init_hw() we would end up initializing some struct
> pci_host_bridge fields in pcibios_init_hw() and some in the custom .scan
> method (ie custom pci_ops) which I found not very elegant but it could be
> done I reckon, I need to give it a go to see how the code looks like.

I don't see anything wrong with initializing the members in different
places. The first set would give you a default that works for basic
drivers, and the second set is a way to override the defaults for drivers
that do something special. Conceptually we do this all the time in
other places.

     Arnd
