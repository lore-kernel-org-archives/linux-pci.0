Return-Path: <SRS0=0zNO=J2=ti.com=kishon@kernel.org>
Return-Path: <SRS0=0zNO=J2=ti.com=kishon@kernel.org>
Subject: Re: [PATCH] driver core: Drop devices_kset_move_last() call from
 really_probe()
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan>
 <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan>
 <CAErSpo4eaaieQiZjAejXAoCv82wddPOcRQXpiqD6X=fFW5XAHQ@mail.gmail.com>
 <CAJZ5v0hVDo-Y2gPTxd6yHVY=vr093hai1VhLzNzzhFkKe0LoKA@mail.gmail.com>
 <CAErSpo4TOiBtdG0iwgeFpv76Lhs4s7PXAWv5_DG-VRyEoP5bOQ@mail.gmail.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <kernelfans@gmail.com>,
        Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko
	<grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn
 Helgaas <helgaas@kernel.org>, <dyoung@redhat.com>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Linux PM list
	<linux-pm@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5b134ed3-b473-90f3-acc7-5943e1669bb5@ti.com>
Date: Tue, 10 Jul 2018 11:49:19 +0530
MIME-Version: 1.0
In-Reply-To: <CAErSpo4TOiBtdG0iwgeFpv76Lhs4s7PXAWv5_DG-VRyEoP5bOQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

+Mark, Liam

Hi,

On Tuesday 10 July 2018 03:36 AM, Bjorn Helgaas wrote:
> [+cc Kishon]
> 
> On Mon, Jul 9, 2018 at 4:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Jul 9, 2018 at 3:57 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Fri, Jul 6, 2018 at 5:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> The devices_kset_move_last() call in really_probe() is a mistake
>>>> as it may cause parents to follow children in the devices_kset list
>>>> which then causes system shutdown to fail.  Namely, if a device has
>>>> children before really_probe() is called for it (which is not
>>>> uncommon), that call will cause it to be reordered after the children
>>>> in the devices_kset list and the ordering of that list will not
>>>> reflect the correct device shutdown order.
>>>>
>>>> Also it causes the devices_kset list to be constantly reordered
>>>> until all drivers have been probed which is totally pointless
>>>> overhead in the majority of cases.
>>>>
>>>> For that reason, revert the really_probe() modifications made by
>>>> commit 52cdbdd49853.
>>>
>>> I'm sure you've considered this, but I can't figure out whether this
>>> patch will reintroduce the problem that was solved by 52cdbdd49853.
>>> That patch updated two places: (1) really_probe(), the change you're
>>> reverting here, and (2) device_move().
>>>
>>> device_move() is only called from 4-5 places, none of which look
>>> related to the problem fixed by 52cdbdd49853, so it seems like that
>>> problem was probably resolved by the hunk you're reverting.
>>
>> That's right, but I don't want to revert all of it.  The other parts
>> of it are kind of useful as they make the handling of the devices_kset
>> list be consistent with the handling of dpm_list.
>>
>> The hunk I'm reverting, however, is completely off.  It not only is
>> incorrect (as per the above), but it also causes the devices_kset list
>> and dpm_list to be handled differently.
> 
> If I understand correctly, you are saying:
> 
>   - the 52cdbdd49853 really_probe() hunk fixed a problem, but
>   - that hunk was the wrong fix for it, and
>   - this patch removes the wrong fix (and probably reintroduces the problem)
> 
> If devices_kset is supposed to be ordered so children follow parents,
> I agree the really_probe() hunk doesn't make much sense because the
> parent/child relation is determined by the circuit design, not by the
> probe order.
> 
> It just seems like it's worth being clear that we're reintroducing the
> problem fixed by 52cdbdd49853, so it needs to be solved a different
> way.  Ideally that would be done before this patch so there's not a
> regression, and this changelog could mention what's happening.
> 
>> It had attempted to fix something, but it failed miserably at that.
> 
> If you're saying that 52cdbdd49853 *tried* to fix a DRA7XX_evm reboot
> problem, but in fact, it did not fix that problem, then I guess there
> should be no issue with reverting that hunk.

It did fix a problem making sure the regulator's shutdown is invoked after the
mmc shutdown. And reverting 52cdbdd49853 reintroduces the problem.

I tried adding device_link_add in the _regulator_get, something like below and
it seems to fix the problem again. But I guess we have to maintain a list of
device_link's in regulator_dev since there can be many consumers for a single
regulator and we also have to invoke device_link_del in _regulator_put. In
general this might have to be extended to other producers like PHY, pinctrl etc..

If this looks okay, I can post a patch after adding a list and invoking
device_link_del() in regulator core.

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6ed568b96c0e..24a25700128a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1740,6 +1740,7 @@ struct regulator *_regulator_get(struct device *dev,
const char *id,
                        rdev->use_count = 0;
        }

+       device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
        return regulator;
 }

Thanks
Kishon
