Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5217BDF2.4020909@kraav.com>
Date: Fri, 23 Aug 2013 22:54:26 +0300
From: Leho Kraav <leho@kraav.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [Bug 57961] ExpressCard hot-remove and hot-add not recognized
 by acpiphp
References: <bug-57961-41252@https.bugzilla.kernel.org/> <bug-57961-41252-X2PJk78p44@https.bugzilla.kernel.org/> <CAErSpo4jFGdW-OXf2OrUQw-e8EdE5h6fPs-v9=QQh1xPjz-Nvg@mail.gmail.com>
In-Reply-To: <CAErSpo4jFGdW-OXf2OrUQw-e8EdE5h6fPs-v9=QQh1xPjz-Nvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 23.08.2013 17:58, Bjorn Helgaas wrote:
> [+cc linux-pci, linux-acpi, switch to email for now]
>
> On Fri, Aug 23, 2013 at 7:34 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=57961
>> ...
>> I'm arriving here from googling "_handle_hotplug_event_root Bus check notify on
>> \_SB_.PCI0".
>
> Huh, interesting.  I didn't think the kernel bugzilla was visible to
> search engines (I wish it were).  But maybe Google just found an email
> that mentioned the URL?

Yes, I actually got there through LKML http://lkml.org/lkml/2013/5/10/432

>> My Dell L421X is spitting this notification both when I close and open the
>> laptop lid, one each. No ACPI LID event is emitted, which doesn't seem right.
>
> Can you post a complete dmesg log including a lid close/event cycle?

E-mailed that to you personally.

>> Running on 3.10.6. Is this bug related in any way?
>
> Bug 57961 is for ExpressCard changes that we didn't handle correctly.
> It doesn't sound like you're adding or removing an ExpressCard, so
> you're likely seeing a different problem.
>
> Is the problem that (1) you see "_handle_hotplug_event_root Bus check
> notify on \_SB_.PCI0" messages that you don't expect, and (2) you do
> not see LID events, which you do expect?
>
> Is there anything that is not actually working correctly, or is it
> just messages that don't seem right?

Mailing list thread discussed some apparently significant ACPI changes 
in 3.10. I've yet to have a laptop that didn't emit an ACPI LID event. 
Instead the kernel does emit something that looks like something is not 
quite what it should be. I'm wondering if I have missed something in 
kernel configuration or am I somehow affected by the recent ACPI changes 
or a machine specific bug somewhere. Dells are among the 
Linux-friendliest machines throughout history, that makes me think it 
could be the kernel.

You're right, I'm not on the acpiphp bus for sure, but sometimes things 
are related at a level above so I took a shot at trying to find out 
what's happening.
