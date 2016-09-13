Return-Path: <rafael.j.wysocki@intel.com>
Return-Path: <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI: Fix bridge_d3 update on device removal
To: Bjorn Helgaas <helgaas@kernel.org>
References: <9bc855a01d0f29cc8425cf50dce9812062309cfb.1473135221.git.lukas@wunner.de>
 <20160913210231.GG4138@localhost>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <aa6e6682-7152-cbba-cb5c-22336b770107@intel.com>
Date: Tue, 13 Sep 2016 23:03:43 +0200
MIME-Version: 1.0
In-Reply-To: <20160913210231.GG4138@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 9/13/2016 11:02 PM, Bjorn Helgaas wrote:
> On Tue, Sep 06, 2016 at 06:20:46AM +0200, Lukas Wunner wrote:
>> Starting with v4.8, we allow a PCIe port to runtime suspend to D3hot if
>> the port itself and its children satisfy a number of conditions.  Once a
>> child is removed, we recheck those conditions in case the removed device
>> was blocking the port from suspending.
>>
>> The rechecking needs to happen *after* the device has been removed from
>> the bus it resides on.  Otherwise when walking the port's subordinate
>> bus in pci_bridge_d3_update(), the device being removed would
>> erroneously still be taken into account.
>>
>> However the device is removed from the bus_list in pci_destroy_dev() and
>> we currently recheck *before* that.  Fix it.
>>
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 9d26d3a8f1b0 appeared in v4.8-rc1, so I assume this fix should be merged
> before v4.8, right?

Yup.

> I applied it to for-linus with Mika's reviewed-by and Rafael's acked-by on
> that assumption.

Cool, thanks!
