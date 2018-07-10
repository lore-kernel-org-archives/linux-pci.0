Return-Path: <SRS0=0zNO=J2=ti.com=kishon@kernel.org>
Return-Path: <SRS0=0zNO=J2=ti.com=kishon@kernel.org>
Subject: Re: [PATCH v2] driver core: Partially revert "driver core: correct
 device's shutdown order"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <2927655.Y1qg3UnIrE@aspire.rjw.lan>
 <5284251.Resgjlja2Q@aspire.rjw.lan> <20180710125956.GA25343@kroah.com>
 <CAJZ5v0iV0ZaCbhoVOrGx08f6Y7Ei2q+qazxEMQRYD4LAq9LUbA@mail.gmail.com>
 <20180710154715.GA20793@kroah.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pingfan Liu
	<kernelfans@gmail.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>, Lukas
 Wunner <lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a35d5f42-a89e-9614-e621-a3274475ef55@ti.com>
Date: Wed, 11 Jul 2018 00:43:55 +0530
MIME-Version: 1.0
In-Reply-To: <20180710154715.GA20793@kroah.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 10 July 2018 09:17 PM, Greg Kroah-Hartman wrote:
> On Tue, Jul 10, 2018 at 05:40:21PM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jul 10, 2018 at 2:59 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Tue, Jul 10, 2018 at 02:51:33PM +0200, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> Commit 52cdbdd49853 (driver core: correct device's shutdown order)
>>>> introduced a regression by breaking device shutdown on some systems.
>>>>
>>>> Namely, the devices_kset_move_last() call in really_probe() added by
>>>> that commit is a mistake as it may cause parents to follow children
>>>> in the devices_kset list which then causes shutdown to fail.  For
>>>> example, if a device has children before really_probe() is called
>>>> for it (which is not uncommon), that call will cause it to be
>>>> reordered after the children in the devices_kset list and the
>>>> ordering of that list will not reflect the correct device shutdown
>>>> order any more.
>>>>
>>>> Also it causes the devices_kset list to be constantly reordered
>>>> until all drivers have been probed which is totally pointless
>>>> overhead in the majority of cases and it only covered an issue
>>>> with system shutdown, while system-wide suspend/resume potentially
>>>> had the same issue on the affected platforms (which was not covered).
>>>>
>>>> Moreover, the shutdown issue originally addressed by the change in
>>>> really_probe() made by commit 52cdbdd49853 is not present in 4.18-rc
>>>> any more, since dra7 started to use the sdhci-omap driver which
>>>> doesn't disable any regulators during shutdown, so the really_probe()
>>>> part of commit 52cdbdd49853 can be safely reverted.  [The original
>>>> issue was related to the omap_hsmmc driver used by dra7 previously.]
>>>>
>>>> For the above reasons, revert the really_probe() modifications made
>>>> by commit 52cdbdd49853.
>>>>
>>>> The other code changes made by commit 52cdbdd49853 are useful and
>>>> they need not be reverted.
>>>>
>>>> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
>>>> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
>>>> Reported-by: Pingfan Liu <kernelfans@gmail.com>
>>>> Tested-by: Pingfan Liu <kernelfans@gmail.com>
>>>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>
>>>> -> v2: Added information from Kishon on the fact that it should be safe
>>>>        to revert the really_probe() modifications added by the
>>>>        problematic commit.  Also added the Reviewed-by tag from Kishon.
>>>
>>> Looks good to me, want me to queue it up in my tree, or are you going to
>>> send it on to Linus?
>>
>> Please queue it up.
>>
>>> And shouldn't this have a stable tag as well?
>>
>> That is sort of a gray area, because I think it may expose the
>> shutdown issue on dra7 in -stable, but technically it still fixes a
>> regression in the driver core.  So your call I suppose. :-)
> 
> Being bug compatible is key :)
> 
> I'll add a stable tag.

sure. If I see the issue in dra7, I'll send a stable fix in omap_hsmmmc driver.

Thanks
Kishon
