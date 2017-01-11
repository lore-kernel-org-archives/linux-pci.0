Return-Path: <SRS0=xM39=YZ=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=xM39=YZ=quantumtechnology.info=kilian.singer@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: Peter Jones <pjones@redhat.com>, Hans de Goede <hdegoede@redhat.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de> <20170104210954.GA11946@al>
 <59349185.1aqio7kYFn@aspire.rjw.lan>
 <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com>
 <20170105150646.GB21446@wunner.de>
 <bd9af400-6b8e-d852-8cf0-b437dffc507c@redhat.com>
 <ad5be7b2-a931-5db3-fafb-7784d9c5c1ea@quantumtechnology.info>
 <ad6e8189-eef6-4f18-7d22-f0fc9a665ec6@redhat.com>
 <20170111162453.zavhr2m3olufckio@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Wu <peter@lekensteyn.nl>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
From: Kilian Singer <kilian.singer@quantumtechnology.info>
Message-ID: <b70d41f6-71ac-f3b5-dda4-2486f6610953@quantumtechnology.info>
Date: Wed, 11 Jan 2017 20:20:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170111162453.zavhr2m3olufckio@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

I updated ti 2.29 but issue is not resolved.


On 11-Jan-17 17:24, Peter Jones wrote:
> On Wed, Jan 11, 2017 at 02:26:09PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11-01-17 14:24, Kilian Singer wrote:
>>> Dear all,
>>>
>>> sounds interesting I could try to update to 2.29.
>>>
>>> Shall I do so?
>> According to the BIOS changelog 2.29 has some
>> fixes for bugs introduces in 2.28, so trying
>> 2.29 is probably a good idea.
> I'd also be interested in seeing dmesg from that with efi=debug on the
> kernel command line, if you don't mind.
>
