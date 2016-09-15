Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44928 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934061AbcIOIjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2016 04:39:14 -0400
Subject: Re: LPC16 PCI microconference - Call for sessions proposals
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>
References: <20160613171823.GA29621@red-moon>
CC: David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Keith Busch <keith.busch@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Myron Stowe <myron.stowe@gmail.com>,
        Auger Eric <eric.auger@redhat.com>,
        Yinghai Lu <yinghai@kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57DA5DF7.8040003@ti.com>
Date: Thu, 15 Sep 2016 14:08:15 +0530
MIME-Version: 1.0
In-Reply-To: <20160613171823.GA29621@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Recently I sent a patch series to add support for configurable PCI endpoint
[1]. It would be nice if we can allocate time to discuss this in LPC. I've also
submitted a proposal for this in [2]. Let me know your thoughts.

Thanks
Kishon


[1] -> https://lkml.org/lkml/2016/9/13/543
[2] -> http://www.linuxplumbersconf.org/2016/ocw/proposals/3657

On Monday 13 June 2016 10:48 PM, Lorenzo Pieralisi wrote:
> Hi,
> 
> following the official LPC16 PCI uconf acceptance notification:
> 
> https://www.linuxplumbersconf.org/2016/pci-microconference-accepted-into-2016-linux-plumbers-conference/
> 
> I am sending out a call for sessions proposals open to all developers
> interested/involved in Linux kernel PCI development.
> 
> The LPC16 uconf wiki provides a list of topics that we put forward for
> the microconference submission:
> 
> http://wiki.linuxplumbersconf.org/2016:pci
> 
> The wiki is there to provide a list of topics that we considered key
> and it should not be considered final, actually it is a starting point
> to define a possible schedule structure.
> 
> Session proposals for the LPC16 PCI microconference are warmly encouraged
> and can be submitted here:
> 
> http://www.linuxplumbersconf.org/2016/ocw/events/LPC2016/tracks/531
> 
> Maintainers in CC, as an initial step we singled out the main subtracks
> below and I would be grateful if you could add a session through the link
> above and run the respective session (in brackets people whom I know are
> involved in the topic and are likely to be asked to run/take part in the
> session; NB: it is obviously incomplete, and it is based on what we
> could infer from current PCI related patches, please do manifest your
> interest):
> 
> - PCI resources allocation/validation/cross-arch consolidation
>   ([Bjorn, Lorenzo, Yinghai, Benjamin, Jesse, Arnd])
> - PCI Virtualization (cross-topic)
>   ([Alex, Bjorn, Eric, Marc, Joerg, Will, David])
> - PCI MSI ([Alex, Eric, Marc])
> - PCI IOMMU ([Joerg, David, Jesse, Will, Marc])
> - PCIe (ATS, PRI) ([Jesse, Will])
> - PCIe root ports power management ([Rafael])
> - PCI DT/ACPI - consolidation ([Bjorn, Lorenzo, Arnd, Rob])
> 
> Anyone involved in PCI kernel development, if you wish to add sessions and
> attend the microconference consider yourself welcome, for any questions
> just reply to this thread or drop me a line.
> 
> Looking forward to meeting you all in Santa Fe for this interesting track !
> 
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
