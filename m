Return-Path: <SRS0=Mh2n=LA=broadcom.com=hari.vyas@kernel.org>
Return-Path: <SRS0=Mh2n=LA=broadcom.com=hari.vyas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <af7ceae785489f2006074109b27b3f07b190c89b.camel@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-6-benh@kernel.crashing.org> <66577784.13494160.1534493390262.JavaMail.zimbra@kalray.eu>
 <1ffafe01887e3b760f84488b06339aba64f586e5.camel@kernel.crashing.org>
 <CAM5rFu-h25j-vfvybKbKr4huhBgpV3Rusj8E2JyaoG1YnokeMw@mail.gmail.com> <af7ceae785489f2006074109b27b3f07b190c89b.camel@kernel.crashing.org>
From: Hari Vyas <hari.vyas@broadcom.com>
Date: Fri, 17 Aug 2018 15:40:53 +0530
Message-ID: <CAM5rFu8ebfaV=8QQ8u=4HThM2T4ZRR9XHxqhKoyAfnv0N79Z8Q@mail.gmail.com>
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

On Fri, Aug 17, 2018 at 3:09 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2018-08-17 at 14:30 +0530, Hari Vyas wrote:
>> So many mail threads for common issues going so just trying to
>> summarize concern from my side.
>> 1) HW level
>> PCI Config data overwritten (ex: PCI_COMMAND bits etc) was happening
>> at lower layer so from my
>> perspective, it is best to handle concern at lower level with locking
>> mechanism and that is what
>> I proposed in my upcoming patch. Without that, I guess, we may end up
>> in issues later with some weird scenario
>> which may not be known today  and we will again be fine tuning stuff
>> here and there.
>
> Maybe... at this point I'm not trying to address that specific issue.
> That being said, the PCI_COMMAND register should be under control of
> the driver at runtime and thus shouldn't be exposed to races like that
> except in the usual case of races in configuring bridges. Those races
> definitely need to be handled at the higher level.
>
> So I'm rather dubious of adding a whole new layer of "modify" callbacks
> to config space accessors for that, especially since they won't do any
> good on architectures with lockless config accesses such as ... x86
>
modify() is optional.  host/controller layers may override it.
It was just a proposal to avoid race issues which happens in SMP environment and
solves other issues. I agree, nothing great anyhow can be done in
lockless config

>> 2) SW level(internal data structure):
>> About is_added,is_busmaster: These all are bit fields so infact I too
>> suggested to remove those bit fields and
>> make separate variables in pci_dev structure.
>> This will avoid all data-overwritten,concurrency issues but ofcourse
>> at the level of space cost.
>
> It's unnecessary to do blanket changes without first understanding the
> details of what's going on. A lot of these things are never touched
> outside of the overall single threaded environment of
> discovery/assignment or under driver control, in which case it's
> expectd that the driver doesn't call them in racy ways
>
> That said, I'm happy to move some of them under my proposed
> dev_state_lock.
>
> For is_added specifically, the field is simply set at the wrong time as
> you can see in my previous patch.
>
Issue needs to be addressed and that is our goal.
Some times simple mistakes need lot of debugging which happened in my case and
my suggestion is to just avoid. SMP related issues are popping up now
so we just need
to be careful.
>> Other possibility will be either to use atomic
>
> Atomic is almost always wrong. It doesn't synchronize anything other
> than the field, so either it's a big waste of it gives a false sense of
> security for something that's almost always still racy.
>
> I'd rather keep the indication that a bunch of those fields *are*
> unprotected and rely on the outer layers being single threaded.
>
>>  or locking mechanism
>> for these. My point here is also same, better
>> avoid fine tuning later stage.
>> Moving is_added up and down doesn't look like good as we are just
>> shifting issue up and down.
>
> No, you are wrong. I also originally covered is_added with my new mutex
> but in hindsight it's the wrong thing to do, and went back to the
> correct fix at this point which is precisely to move it up.
>
> is_added is essentially owned by the part of the PCI probe code that
> runs single threaded before the device gets exposed to the device
> model.
>
> Pretty much all of the code, including all the corresponding fields
> (struct resources etc...) in pci_dev are unprotected and rely on being
> accessed in a single threaded manner. is_added is no exception.
>
> It was simply a mistake to set it after device_attach().
>
> Thus moving it back up fixes it *correctly* by making it follow the
> same rules as all the related fields.
>
> That said, if we want to start adding protection to all those other
> fields, then this is a different matter alltogether. But at this point,
> this is the best fix for the problem at hand.
>
>> Please check and decide accordingly. I will hold my to-be-submitted
>> modify() patch about handling hw level
>> over-written case with locking around read-write operation.
>
> Can you remind us in this thread which specific cases of RMW races of
> config space you were trying to address ?
>
Same pci bridge master, memory bit setting concern only (which my
colleague Srinath figured
out after lot of effort some time back) where only one bit in
PCI_COMMAND  was getting set.
(Bug 200793 - PCI: read-write config operation doesn't look like SMP safe)
My approach is to handle with modify operations at lower level so bits
are not over-written or lost.


As stated earlier, issue should be just resolved in better way. No
issue in going with majority
Regards,
hari
> Cheers,
> Ben.
>
>
