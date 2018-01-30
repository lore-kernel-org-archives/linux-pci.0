Return-Path: <SRS0=2slI=EZ=free-electrons.com=cyrille.pitchen@kernel.org>
Return-Path: <SRS0=2slI=EZ=free-electrons.com=cyrille.pitchen@kernel.org>
Subject: Re: [PATCH v5 00/11] PCI: Add support to the Cadence PCIe controller
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
 adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
 kgopi@cadence.com, eandrews@cadence.com,
 thomas.petazzoni@free-electrons.com, sureshp@cadence.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
References: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
 <20180128214741.GA232763@bhelgaas-glaptop.roam.corp.google.com>
 <20180130114155.GA12009@e107981-ln.cambridge.arm.com>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Message-ID: <8cec81b2-85c4-d7bf-4171-9e94a745eab0@free-electrons.com>
Date: Tue, 30 Jan 2018 22:12:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180130114155.GA12009@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo, Bjorn,

Le 30/01/2018 à 12:41, Lorenzo Pieralisi a écrit :
> On Sun, Jan 28, 2018 at 03:47:41PM -0600, Bjorn Helgaas wrote:
>> On Sun, Jan 28, 2018 at 09:40:14PM +0100, Cyrille Pitchen wrote:
>>> Hi all,
>>>
>>> this series of patches adds support to the Cadence PCIe controller.
>>> It was tested on a ARM64 platform emulated by a Palladium running the
>>> pci-next kernel.
>>>
>>> The host mode was tested with some PCIe devices connected to the Palladium
>>> through a speed-bridge. Some of those devices were a USB host controller
>>> and a SATA controller. The PCIe host controller was also tested with a
>>> second controller configured in endpoint mode and connected back to back
>>> to the first controller.
>>>
>>> The EndPoint Controller (EPC) driver was tested with 2 PCI functions, both
>>> handled by the pci-epf-test driver, using the pcitest userspace program.
>>> I used the "-D" optional command line parameter to select the proper PCI
>>> function.
>>>
>>> Best regards,
>>>
>>> Cyrille
>>>
>>> ChangeLog
>>>
>>> v4 -> v5:
>>> - rebase on today's (20180128) linux-pci/next
>>
>> Don't bother rebasing onto linux-pci/next.
>>
>> If your patches actually *depend* on something that has already been
>> merged onto a PCI topic branch, you should mention that and say which
>> branch.
> 
> Yes - Cyrille please advise which branch(es) this series depends on,
> it does not apply cleanly to -rc4.
> 
> Merge window is open and I do not know what we can do with this series
> for v4.16 but please let me know.
>

I've just sent v6. No change from v5 except that the series has been
rebased onto linux-pci/master (v4.15-rc4) and tested on the Palladium.
I've cherry-picked one Kishon's patch from linux-pci/next to test the
endpoint mode.

Best regards,

Cyrille
 
> Thanks,
> Lorenzo
> 


-- 
Cyrille Pitchen, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
