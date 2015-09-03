Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: pcieport AER error spam on Intel Skylake
To: Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Drake <drake@endlessm.com>
References: <CAD8Lp44cpj0Z3aadOzW=Lc=m88AbQpaW3g=GCgtpvbpGATT7uw@mail.gmail.com>
 <CAErSpo6tMJYqiynS-+svvMB2mskMBrTpWNBxR7OLPSxGxKbBvw@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Carlo Caione <carlo@endlessm.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <55E7A90A.5080406@gmail.com>
Date: Wed, 2 Sep 2015 18:57:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAErSpo6tMJYqiynS-+svvMB2mskMBrTpWNBxR7OLPSxGxKbBvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/02/2015 03:53 PM, Bjorn Helgaas wrote:
> On Wed, Sep 2, 2015 at 5:01 PM, Daniel Drake <drake@endlessm.com> wrote:
>> Hi,
>>
>> Working with a sample for a new laptop based on Intel Skylake, the
>> kernel logs are full of these messages:
>>
>>   pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
>>   pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected,
>> type=Physical Layer, id=00e5(Receiver ID)
>>   pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
>>   pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
>>   pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
>>   pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected,
>> type=Physical Layer, id=00e5(Receiver ID)
>>   pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
>>   pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
>>   pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
>>   pcieport 0000:00:1c.5: can't find device of ID00e5
>>
>> Reproduced on 4.2 and on linus master as of today, using x86_64_defconfig.
>>
>> Apart from the log spam, there is no user-visible effect that I'm
>> aware of. Booting with pci=nomsi makes the messages go away.
>>
>> Any thoughts, is this something worth looking into in more detail?
>>
>> full dmesg: https://gist.github.com/dsd/1d7f738e917465edf2ae
>> lspci dump: https://gist.github.com/dsd/dc2481d64aadd520b0b3
> Thanks, Daniel, this is indeed really annoying and worth looking into.
> Do you happen to know whether it's a regression?  We haven't changed
> much in AER recently, but it's possible we broke something.
>
> Even if it's not a regression, the output seems a bit wordy and redundant.
>
> Bjorn

Since it is correctable errors it is likely some sort of signalling 
issue.  Could we get the output of something like an lspci -vt? Then you 
would be able to tell what the device is on the other side of the link 
from 00:1c.5 and then we could probably check to see if there has been 
any changes for the device driver on the other end of the link.

My suspicion since this is a laptop is that something like a power 
management change might be responsible if this is a regression as I have 
seen messages like this pop up as a result of ASPM being enabled before.

- Alex
