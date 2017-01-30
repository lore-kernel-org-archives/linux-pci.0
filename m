Return-Path: <SRS0=ukF7=ZM=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=ukF7=ZM=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20170128220914.GN20550@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1484486499.git.lukas@wunner.de> <14d64f19bc1b1ea67371b8336dca618edddc0b52.1484486499.git.lukas@wunner.de>
 <20170128220914.GN20550@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jan 2017 08:15:40 +0100
Message-ID: <CAJZ5v0gZgp0RVo_2toASw+-GF=FV8=TdEmauP+7+-czU5kshjg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] PCI: Allow runtime PM on Thunderbolt ports
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>,
	Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 28, 2017 at 11:09 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
>> Currently PCIe ports are only allowed to go to D3 if the BIOS is dated
>> 2015 or newer to avoid potential issues with old chipsets.  However for
>> Thunderbolt we know that even the oldest controller, Light Ridge (2010),
>> is able to suspend its ports to D3 just fine.
>>
>> We're about to add runtime PM for Thunderbolt on the Mac.  Apple has
>> released two EFI security updates in 2015 which encompass all machines
>> with Thunderbolt, but the achieved power saving should be made available
>> to users even if they haven't updated their BIOS.  To this end,
>> special-case Thunderbolt in pci_bridge_d3_possible().
>
> I think this whole paragraph is unnecessary detail.  I first thought
> you had some connection with a firmware security issue, but now I see
> the only point is that if you have pre-2015 firmware, you could update
> it since newer firmware is available.
>
>> This allows the Thunderbolt controller to power down but the root port
>> to which the Thunderbolt controller is attached remains in D0 unless
>> the EFI update is installed.  Users can pass pcie_port_pm=force on the
>> kernel command line if they cannot install the EFI update but still want
>> to benefit from the additional power saving of putting the root port
>> into D3.  In practice, root ports can be suspended to D3 without issues
>> at least on 2012 Ivy Bridge machines.
>
> I'm not sure I like advertising pcie_port_pm=force.  That just means a
> few leet folks will use this parameter and run in a subtly different
> configuration than everybody else, and possibly trip over subtly
> different issues.  The audience (users who read kernel change logs and
> are willing to use special boot parameters, but who can't install an
> EFI update) seems small.

That basically is for somebody who has a product and knows that the
feature works there, but doesn't want or simply can't patch the kernel
(which is shipped by a distro or similar).

Thanks,
Rafael
