Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 May 2013 08:37:53 +0000 (UTC)
From: "Artem S. Tashkinov" <t.artem@lycos.com>
To: patrik.r.jakobsson@gmail.com
Cc: bhelgaas@google.com, hancockrwd@gmail.com,
	stern@rowland.harvard.edu, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rjw@sisk.pl, psusi@ubuntu.com
Message-ID: <1786821921.88859.1368002273356.JavaMail.mail@webmail05>
References: <CAErSpo7qj2SNR7BfuBsfF-saZXvgcqqLtgoP5Hyb5u99qR4Ncg@mail.gmail.com>
 <Pine.LNX.4.44L0.1302191119270.2215-100000@iolanthe.rowland.org>
 <CAErSpo7NZoOQZyW76HEoOTVgdqL2CgbVScAeF6HGLAVaNCq0=w@mail.gmail.com>
 <337833384.57445.1361860509194.JavaMail.mail@webmail08>
 <CAErSpo6CbO5KYXiErv6J_Dnm1u694C5fQPP2_cZL8VKDEnZa9A@mail.gmail.com>
 <569718148.80620.1361906088301.JavaMail.mail@webmail13>
 <CAErSpo6UkVhSf+nFW4zwJLBQw_0RQ5H9Bv-UuQRb6zdwsFPw4g@mail.gmail.com>
 <CAErSpo4X+XXKvWDfqh2CKZAtJ9WMQk91OcsWwdxwYv2MfEM_zQ@mail.gmail.com>
 <771333906.75854.1367057440028.JavaMail.mail@webmail08>
 <CAErSpo4B4sRco-nuqgXiYtGQxBcbEB6ArQjHD0A9cj4TRE+qQw@mail.gmail.com>
 <518097B8.4020402@gmail.com>
 <CAErSpo7KWPRVEnw+n068pUZz+=WSTwno6m6t7N6dunuhnFC8EA@mail.gmail.com>
 <384171828.66802.1367942365492.JavaMail.mail@webmail05>
 <CADLC3L3bdTP8-X3ftMq1qxnL=LVDf7d5gbu2ZMH0pXg2AU8xjw@mail.gmail.com>
 <CAErSpo50iyEbCer+-K8uXUdnsG_EzFe_ZjKnrtfq5x0Zw3Yd6w@mail.gmail.com>
 <CAMeQTsZEpRE_bv6o9mBpqNrbf36SZVscxy+JS72=BOzA1ey-XQ@mail.gmail.com>
 <CAErSpo75SETEe-OKhY2-NW3csaxt=f09JcheHx95bzkCcGO6yg@mail.gmail.com><CAMeQTsY1jc99boFC_KDTL=-Pt-W1q5ZiS+r89QkPE+vAk386UQ@mail.gmail.com>
Subject: Re: Abysmal HDD/USB write speed after sleep on a UEFI system
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

May 8, 2013 04:25:43 AM, Patrik Jakobsson wrote:
On Wed, May 8, 2013 at 12:02 AM, Bjorn Helgaas wrote:
>> On Tue, May 7, 2013 at 2:48 PM, Patrik Jakobsson wrote:
>>> On Tue, May 7, 2013 at 10:20 PM, Bjorn Helgaas  wrote:
>>>>> I'm not sure if reading /proc/mtrr actually reads the registers out of
>>>>> the CPU each time, or whether we just return the cached values we read
>>>>> out during initial boot-up. If the latter, then this output isn't
>>>>> really useful as there's no guarantee the values are still intact.
>>>>
>>>> Good point.  From what I can tell, on Artem's system with "CPU0:
>>>> Intel(R) Core(TM) i5-2500 CPU @ 3.30GHz," we would be using
>>>> generic_mtrr_ops, and generic_get_mtrr() appears to read from the
>>>> MSRs, so I think it should be useful.
>>>
>>> FWIW, that motherboard suffers from a PCI to PCIE bridge problem. It might
>>> have been fixed by bios upgrades by now but not sure.
>>>
>>> It might also suffer (depending on the revision) from the Sandy bridge SATA
>>> issue. So if affected, SATA controller is a ticking bomb.
>>>
>>> I have a P8H67-V motherboard but I haven't seen any suspend related issues.
>>>
>>> If this is totally unrelated I'm sorry for wasting your time. Just thought it
>>> might be good to know.
>>
>> Thanks for chiming in.  I'm not familiar with either of the issues you
>> mentioned.  Do you have any references where I could read up on them?
>
>I think this is the official statement from Intel on the SATA issue:
>http://newsroom.intel.com/community/intel_newsroom/blog/2011/01/31/intel-identifies-chipset-design-error-implementing-solution

My motherboard has a new fixed B3 revision so this issue doesn't affect me.
Besides this SATA ports degradation issue is constantly present - it has no
relationship to suspend.

>
>And here's a link to a discussion about the PCIe-to-PCI bridge stuff:
>https://lkml.org/lkml/2012/1/30/216
>
>> Artem's system has a PCIe-to-PCI bridge (not a PCI-to-PCIe bridge) at
>> 05:00.0, but it leads to [bus 06] and there's nothing on bus 06, so I
>> don't think that's the problem.
>
>I meant what you said ;) and yes, it seems unrelated. Both my P8H67 and a
>P8P67 I've built behave nicely if nothing is connected.

Have you tried suspending more than three times? In the absence of UEFI
boot this bug emerges only on a third or even fourth resume attempt. UEFI
boot triggers it immediately on a first resume though.

>> And the issue affects both USB and a hard drive, so I suspect it's
>> more than just SATA.  Artem, did you identify the PCI devices leading
>> to your USB and hard drive?  I can't remember if I've actually seen
>> that.
