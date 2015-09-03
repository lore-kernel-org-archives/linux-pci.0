Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: pcieport AER error spam on Intel Skylake
To: Daniel Drake <drake@endlessm.com>
References: <CAD8Lp44cpj0Z3aadOzW=Lc=m88AbQpaW3g=GCgtpvbpGATT7uw@mail.gmail.com>
 <CAErSpo6tMJYqiynS-+svvMB2mskMBrTpWNBxR7OLPSxGxKbBvw@mail.gmail.com>
 <55E7A90A.5080406@gmail.com>
 <CAD8Lp4534o9+=MSSt5Rf_9HgxpoNJdA=gRsFAG8w-U8Eh5Otng@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Carlo Caione <carlo@endlessm.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <55E88C07.3090503@gmail.com>
Date: Thu, 3 Sep 2015 11:05:59 -0700
MIME-Version: 1.0
In-Reply-To: <CAD8Lp4534o9+=MSSt5Rf_9HgxpoNJdA=gRsFAG8w-U8Eh5Otng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/03/2015 06:32 AM, Daniel Drake wrote:
> On Wed, Sep 2, 2015 at 7:57 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>> Since it is correctable errors it is likely some sort of signalling issue.
>> Could we get the output of something like an lspci -vt? Then you would be
>> able to tell what the device is on the other side of the link from 00:1c.5
>> and then we could probably check to see if there has been any changes for
>> the device driver on the other end of the link.
> "lspci -vt" reliably causes one occurance of the message, which is
> logged by the kernel before lspci has written anything to stdout.
>   pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
>   pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected,
> type=Physical Layer, id=00e5(Receiver ID)
>   pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
>   pcieport 0000:00:1c.5:    [ 0] Receiver Error
>
> -[0000:00]-+-00.0  Intel Corporation Device 1904
>             +-02.0  Intel Corporation Device 1916
>             +-04.0  Intel Corporation Device 1903
>             +-08.0  Intel Corporation Device 1911
>             +-14.0  Intel Corporation Device 9d2f
>             +-14.2  Intel Corporation Device 9d31
>             +-15.0  Intel Corporation Device 9d60
>             +-15.1  Intel Corporation Device 9d61
>             +-16.0  Intel Corporation Device 9d3a
>             +-17.0  Intel Corporation Device 9d03
>             +-1c.0-[01]--
>             +-1c.4-[02]----00.0  Realtek Semiconductor Co., Ltd.
> RTL8111/8168 PCI Express Gigabit Ethernet controller
>             +-1c.5-[03]----00.0  Realtek Semiconductor Co., Ltd. Device b723
>             +-1f.0  Intel Corporation Device 9d48
>             +-1f.2  Intel Corporation Device 9d21
>             +-1f.3  Intel Corporation Device 9d70
>             \-1f.4  Intel Corporation Device 9d23
>
> Does this mean these messages are somehow related to the Realtek b723
> device? That is the wifi card.
> Using x86_64_defconfig there is not even any driver loaded for this
> device, yet the messages appear quite a bit.
> If I use a full config with all the relevant drivers including
> rtlwifi, the frequency of these messages goes up a lot though.

The correctable errors are likely a result of some sort of link error 
between the root port 00:1c.5 and the wireless adapter at 3:00.0.  What 
is likely happening is that when the device is unused it transitions 
down to a lower power link state like L0s or L1, and when it comes out 
of that state it is likely triggering the PCIe error most likely as a 
result of something during the PCIe link training sequence.

You might want to notify the manufacturer of the laptop as they may need 
to address an issue in their hardware, firmware, or possibly add  a 
workaround to mask off Receiver Error reporting for their part via 
either a PCIe quirk or driver fix.

>> My suspicion since this is a laptop is that something like a power
>> management change might be responsible if this is a regression as I have
>> seen messages like this pop up as a result of ASPM being enabled before.
> It's likely not a regression, this is brand new hardware and this
> message is seen on all kernels that we have tried (4.1, 4.2, master).
> pcie_aspm=off also makes these messages go away.

Correctable errors are considered a sign of the PCIe link health. In 
theory they can be ignored since by definition they can be corrected by 
the hardware.  One thing you could do if you aren't using the wireless 
card would be to simply switch off the correctable error reporting by 
setting the mask bit for it in configuration space using setpci.

To do that what you could do is find the offset for the PCIe AER 
configuration register for your port by doing a "lspci -vvv -s 0:1c.5" 
and what you should get will be a dump listing the capabilities and 
their current settings.  In there you should find a line like:
     Capabilities: [148 v1] Advanced Error Reporting

The 148 is the hex offset of the configuration space.  The Correctable 
Error mask is located at a hex offset of 0x14 from there.  So adding the 
hex values 0x148 and 0x14 gives us 0x15C.  To disable reporting 
correctable receiver errors you would just want to add a 1 to whatever 
value you get from "setpci -s 0:1c.5 0x15C.l" and then write that value 
back.  So for example on my system I ended up with something like 
"setpci -s 0:1c.5 0x15C.l=2001" where the output from the first command 
was 2000.

- Alex


