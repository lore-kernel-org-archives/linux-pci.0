Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWM0teGrWjn2xTfbLW1hqYG0Xau8poSxJCWfjfaQhdt5Q@mail.gmail.com>
References: <20150123203145.GA6691@google.com> <CA+8MBbKnT=mE3kev8BRPq0GeTgHx8WVa6o54tJuBX_XXLpHdYQ@mail.gmail.com>
 <CAErSpo7y1wWStjcEOH9xTiM-As8+QeMynZ5ENrL9v3X2PvQCcw@mail.gmail.com>
 <CA+8MBb+bWiX2eayjBQHsvCjTp3t8H9=AviF9AkV6CC--cC_fYQ@mail.gmail.com>
 <CAE9FiQXj07CtOJ6uBZomNyhAH9ANanbbUSo51td6G-UB5Rmmow@mail.gmail.com>
 <CA+8MBbLVgfk3LEAnuAx_MRJpHkQO-cEQnuCrcbxcyOezr5RLcg@mail.gmail.com>
 <CAE9FiQXnTPO2tM252zvTGJF9Nmc-R+6z65Kq3aXC3jvxtAK2Qw@mail.gmail.com>
 <CAErSpo5CmVTw1-jQ2cwZS27nWH6zEyO5yqaedPN8jeRiU=JUfQ@mail.gmail.com> <CAE9FiQWM0teGrWjn2xTfbLW1hqYG0Xau8poSxJCWfjfaQhdt5Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 30 Jan 2015 16:12:30 -0600
Message-ID: <CAErSpo5J5aXVLXJ-Xkpr8JSF6U=itX_6+SwnD3f8EAEwNF745w@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v3.19
To: Yinghai Lu <yinghai@kernel.org>
Cc: Tony Luck <tony.luck@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Marek Kordik <kordikmarek@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andreas Hartmann <andihartmann@freenet.de>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 30, 2015 at 3:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Jan 30, 2015 at 8:56 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Jan 27, 2015 at 6:54 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Tue, Jan 27, 2015 at 3:24 PM, Tony Luck <tony.luck@gmail.com> wrote:
>>>> On Mon, Jan 26, 2015 at 7:43 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>>> Can you please get boot bog with "debug ignore_logleve"?
>>>>>
>>>>> we should get print out from
>>>>>
>>>>> +               dev_printk(KERN_DEBUG, &dev->dev, "%pR clipped to %pR\n",
>>>>> +                                &orig_res, res);
>>>>
>>>> Attached ... but I don't see any "clipped" messages
>>>
>>> Good. so the system should just work as before but have annoying warnings.
>>>
>>> Do we need to put the paper back to hide the warning?
>>
>> Ping, I'm not sure this is resolved.
>>
>> Tony, does the system work as it did before?  Is the only problem that
>> now we have more warnings than we did before?
>>
>> Yinghai, I sort of feel like I'm being left to sweep up behind your
>> changes here.  I *could* analyze this and figure out what's going on
>> and fix it, but I don't have time to do that for everybody, and I
>> consider that more your job.
>
> Sorry to hear that.
>
> I did respond the email, and gave the the explanation.
>
>>
>> If we start with the same _CRS config and same device config, ideally
>> PCI enumeration would produce the same messages, same warnings, and
>> same resource assignments no matter what arch we feed them to, because
>> enumeration is not really arch-specific.  So if ia64 does something
>> different here, I think something needs to be fixed.
>
> ia64 was doing different,
> 1. It check if the range is valid with bus resources. and only call
> pci_claim_resource for that path.
> 2. and it does not reset invalid resource to allocate new one.
>
> This patch change to call pci_claim_resource directly, so we have warning now.
> but just warning as we did not reset the resource.

OK, I guess I just didn't understand what you were saying.

So I'll consider this resolved unless I hear somebody say otherwise.

Bjorn
