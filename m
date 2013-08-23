Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5217C985.20103@kraav.com>
References: <bug-57961-41252@https.bugzilla.kernel.org/> <bug-57961-41252-X2PJk78p44@https.bugzilla.kernel.org/>
 <CAErSpo4jFGdW-OXf2OrUQw-e8EdE5h6fPs-v9=QQh1xPjz-Nvg@mail.gmail.com>
 <5217BDF2.4020909@kraav.com> <CAErSpo5B6dvY6ri1-NajudgS1v1tyTCCicb9vMrOYP=8yv4pPg@mail.gmail.com>
 <5217C794.1020902@kraav.com> <CAErSpo5j-_JWinFSDSJx6uGnw-opEHm668Md=9z-ZoxZmuX+VQ@mail.gmail.com>
 <5217C985.20103@kraav.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 23 Aug 2013 14:52:23 -0600
Message-ID: <CAErSpo5yA61+QcQMk1d=JGJp8D9Tuhxfr-4Lhz1oCnxCq+dyhA@mail.gmail.com>
Subject: Re: [Bug 57961] ExpressCard hot-remove and hot-add not recognized by acpiphp
To: Leho Kraav <leho@kraav.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 23, 2013 at 2:43 PM, Leho Kraav <leho@kraav.com> wrote:
> On 23.08.2013 23:40, Bjorn Helgaas wrote:
>>
>> [+cc Rafael]
>>
>> On Fri, Aug 23, 2013 at 2:35 PM, Leho Kraav <leho@kraav.com> wrote:
>>>
>>>
>>> I don't suspend on lid close, actually. I close the lid just to carry the
>>> laptop around, and always suspend manually.
>>>
>> Huh.  That's strange.  I don't know why you would get bus checks on
>> lid open/close events when you're not suspending/resuming.  Maybe
>> Rafael will have some ideas.
>>
>> If you can collect an acpidump, that might have a clue, too.  At
>> least, we ought to be able to see a method that is sending the Notify
>> to the PCI host bridge.
>
>
> acpidump attached

            Method (GNOT, 2, NotSerialized)
                         Notify (PCI0, Arg1)
                         Notify (GFX0, Arg1)

I wonder if this bus check on lid open/close has something to do with
telling us that we should re-evaluate which monitors are present or
useful.  In any case, I think I'm out of my depth.
