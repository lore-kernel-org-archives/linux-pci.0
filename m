Return-Path: <SRS0=ut0H=K7=broadcom.com=hari.vyas@kernel.org>
Return-Path: <SRS0=ut0H=K7=broadcom.com=hari.vyas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180816102645.btqgmnycprgyup4o@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
 <fa218ce2-c337-e776-d958-f1f8a1129c9a@yandex-team.ru> <6f76eb5f54fdc780dac744773d836214d7844346.camel@kernel.crashing.org>
 <CAM5rFu-QCBq9TdoiFtvfNENUaS5Tpay5f0H9_BenEqK8nDgoNg@mail.gmail.com>
 <f7aa5f1904f56beb3d202033089449a45f86e6d3.camel@kernel.crashing.org> <20180816102645.btqgmnycprgyup4o@wunner.de>
From: Hari Vyas <hari.vyas@broadcom.com>
Date: Thu, 16 Aug 2018 16:17:01 +0530
Message-ID: <CAM5rFu_YX8eQxRkQ5_YGdDvZ3M+v6ciry31VSnHF36J2MqOfQw@mail.gmail.com>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
To: Lukas Wunner <lukas@wunner.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 3:56 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Aug 16, 2018 at 08:10:28PM +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2018-08-16 at 14:52 +0530, Hari Vyas wrote:
>> > There was an issue reported by my colleague srinath while enabling pci
>> > bridge and a race condition was happening while setting memory and
>> > master bits i.e. bits were over-written.
>> > As per my understanding is_busmaster and is_added bit race issue was
>> > at internal data management and is quite different from pci bridge
>> > enabling issue.
>> > Am I missing some thing ? Would be interested to know what exactly was
>> > affected due to is_busmaster fix.
>>
>> The is_busmaster fix isn't I think affecting anything, however I don't
>> like the use of atomics for these things. It's a band-aid. If we grow a
>> proper pci_dev mutex, which is what I'm introducing here, it should be
>> able to also handle the is_added race etc..
>
> What is your rationale to introduce an additional mutex instead if
> utilizing the existing mutex in struct device via device_lock() /
> device_unlock() or alternatively pci_dev_lock() / pci_dev_unlock()?
>
> This is also what Bjorn had suggested here:
> https://lore.kernel.org/lkml/20170816134354.GV32525@bhelgaas-glaptop.roam.corp.google.com/
>
> Thanks,
>
> Lukas
Agreeing. My "pci bridge enabling" proposed simple fix(issue is not
easy to reproduce in our environment
so not tested yet but believe it should work) too uses existing
locking mechanism only.

https://bugzilla.kernel.org/show_bug.cgi?id=200793

Currently addressing only PCI_COMMAND but can be easily extended for
other pci config having bit fields.
Good that we all are in same direction. Issue should be fixed though
be addressed in different way.

Regards,
hari
