Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20160511193645.GB28812@localhost>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
	<1461919919-120102-2-git-send-email-mika.westerberg@linux.intel.com>
	<20160511193645.GB28812@localhost>
Date: Wed, 11 May 2016 22:12:19 +0200
Message-ID: <CAJZ5v0h4GbFzBwwzQYG0HF0DBysaVYX212_N0n5iQ-Kq==2cpg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI: No need to set d3cold_allowed to PCIe ports
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 11, 2016 at 9:36 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Apr 29, 2016 at 11:51:56AM +0300, Mika Westerberg wrote:
>> The Linux PCI core skips PCI bridges and PCIe ports when system is
>> suspended. The PCI core checks return value of pci_has_subordinate() in
>> pci_pm_suspend_noirq() to skip all devices where it is non-zero (which
>> means PCI bridges and PCIe ports).
>
> This patch looks fine to me.
>
> But I wonder whether it's correct for pci_pm_suspend_noirq() (and the
> other PM functions) to use pci_has_subordinate() as opposed to
> pci_is_bridge().
>
> pci_is_bridge() is true for all bridge devices (plain old PCI-PCI
> bridges, PCIe ports, CardBus bridges, etc.)
>
> pci_has_subordinate() is true only if the bridge has a struct pci_bus
> allocated for its secondary bus.  This is probably the case for all or
> almost all bridges, but it's conceivable that if we don't have enough
> bus number space for the secondary bus, we might not allocate that
> struct pci_bus.
>
> What do you PM guys think?  I don't know what you would want to do
> with a bridge that didn't have any reachable devices below it.

Well, that's funny. :-)

The function we used in there used to be called pci_is_bridge(), as
per commit 46939f8b15e4 "PCI PM: Put devices into low power states
during late suspend (rev. 2)".

But then, it was renamed to pci_has_subordinate(), by commit
326c1cdae741 "PCI: Rename pci_is_bridge() to pci_has_subordinate()".

Next, a new pci_is_bridge() was introduced, by commit 1c86438c9423
"PCI: Add new pci_is_bridge() interface".  It is kind of hard to say
why that happened, because the changelog of that commit doesn't say
anything about the reason, but evidently the new one is not exactly
equivalent to the old one (as you mention).  The author of that commit
apparently was afraid to make that change in the PM code.

Now, I think what we do makes sense, because we want to avoid touching
bridges that have something below them (so as to avoid disrupting the
things below the bridge) and I'm not aware of any problems coming from
that.


>> Since PCIe ports are never suspended in the first place, there is no need
>> to set d3cold_allowed for them.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/pci/pcie/portdrv_pci.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
>> index be35da2e105e..6c6bb03392ea 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -134,11 +134,6 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>>               return status;
>>
>>       pci_save_state(dev);
>> -     /*
>> -      * D3cold may not work properly on some PCIe port, so disable
>> -      * it by default.
>> -      */
>> -     dev->d3cold_allowed = false;
>>       return 0;
>>  }
>>
>> --
