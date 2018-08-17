Return-Path: <SRS0=Mh2n=LA=broadcom.com=hari.vyas@kernel.org>
Return-Path: <SRS0=Mh2n=LA=broadcom.com=hari.vyas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1ffafe01887e3b760f84488b06339aba64f586e5.camel@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-6-benh@kernel.crashing.org> <66577784.13494160.1534493390262.JavaMail.zimbra@kalray.eu>
 <1ffafe01887e3b760f84488b06339aba64f586e5.camel@kernel.crashing.org>
From: Hari Vyas <hari.vyas@broadcom.com>
Date: Fri, 17 Aug 2018 14:30:16 +0530
Message-ID: <CAM5rFu-h25j-vfvybKbKr4huhBgpV3Rusj8E2JyaoG1YnokeMw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] pci: Protect the enable/disable state of pci_dev
 using the state mutex
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marta Rybczynska <mrybczyn@kalray.eu>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>, Srinath Mannam <srinath.mannam@broadcom.com>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 2:00 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2018-08-17 at 10:09 +0200, Marta Rybczynska wrote:
>>
>> ----- On 17 Aug, 2018, at 06:49, Benjamin Herrenschmidt benh@kernel.crashing.org wrote:
>>
>> > This protects enable/disable operations using the state mutex to
>> > avoid races with, for example, concurrent enables on a bridge.
>> >
>> > The bus hierarchy is walked first before taking the lock to
>> > avoid lock nesting (though it would be ok if we ensured that
>> > we always nest them bottom-up, it is better to just avoid the
>> > issue alltogether, especially as we might find cases where
>> > we want to take it top-down later).
>> >
>> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>>
>> >
>> > static void pci_enable_bridge(struct pci_dev *dev)
>> > {
>> >     struct pci_dev *bridge;
>> > -   int retval;
>> > +   int retval, enabled;
>> >
>> >     bridge = pci_upstream_bridge(dev);
>> >     if (bridge)
>> >             pci_enable_bridge(bridge);
>> >
>> > -   if (pci_is_enabled(dev)) {
>> > -           if (!dev->is_busmaster)
>> > -                   pci_set_master(dev);
>> > +   /* Already enabled ? */
>> > +   pci_dev_state_lock(dev);
>> > +   enabled = pci_is_enabled(dev);
>> > +   if (enabled && !dev->is_busmaster)
>> > +           pci_set_master(dev);
>> > +   pci_dev_state_unlock(dev);
>> > +   if (enabled)
>> >             return;
>> > -   }
>> >
>>
>> This looks complicated too me especially with the double locking. What do you
>> think about a function doing that check that used an unlocked version of
>> pcie_set_master?
>>
>> Like:
>>
>>         dev_state_lock(dev);
>>         enabled = pci_is_enabled(dev);
>>         if (enabled &&  !dev->is_busmaster)
>>                 pci_set_master_unlocked();
>>         pci_dev_state_unlock(dev);
>>
>> BTW If I remember correctly the code today can set bus mastering multiple
>> times without checking if already done.
>
> I don't mind but I tend to dislike all those _unlocked() suffixes, I
> suppose my generation is typing adverse enough that we call these
> __something instead :)
>
> As for setting multiple times, yes pci_set_master() doesn't check but
> look at the "-" hunks of my patch, I'm not changing the existing test
> here. Not that it matters much, it's an optimization.
>
> In fact my original version just completely removed the whole lot
> and just unconditionally did pci_enable_device() + pci_set_master(),
> just ignoring the existing state :-)
>
> But I decided to keep the patch functionally equivalent so I added it
> back.
>
> Cheers,
> Ben.
>
>
So many mail threads for common issues going so just trying to
summarize concern from my side.
1) HW level
PCI Config data overwritten (ex: PCI_COMMAND bits etc) was happening
at lower layer so from my
perspective, it is best to handle concern at lower level with locking
mechanism and that is what
I proposed in my upcoming patch. Without that, I guess, we may end up
in issues later with some weird scenario
which may not be known today  and we will again be fine tuning stuff
here and there.
2) SW level(internal data structure):
About is_added,is_busmaster: These all are bit fields so infact I too
suggested to remove those bit fields and
make separate variables in pci_dev structure. This will avoid all
data-overwritten,concurrency issues but ofcourse
at the level of space cost.
Other possibility will be either to use atomic or locking mechanism
for these. My point here is also same, better
avoid fine tuning later stage.
Moving is_added up and down doesn't look like good as we are just
shifting issue up and down.

Please check and decide accordingly. I will hold my to-be-submitted
modify() patch about handling hw level
over-written case with locking around read-write operation.

Regards,
hari
