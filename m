Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38842 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab2CEMqo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Mar 2012 07:46:44 -0500
Received: by bkcik5 with SMTP id ik5so3091521bkc.19
        for <linux-pci@vger.kernel.org>; Mon, 05 Mar 2012 04:46:42 -0800 (PST)
Message-ID: <7829A8FF08814C6BA755016F2F177F96@SonyVAIO>
From: "Anton Murashov" <anton.murashov@gmail.com>
To: "Grant Grundler" <grantgrundler@gmail.com>
Cc: <Robert.Olsson@data.slu.se>, <buytenh@wantstofly.org>,
	<laforge@gnumonks.org>, <grundler@parisc-linux.org>,
	<derbenev@quantstellation.ru>, "Evgeny Vasin" <gevorr@gmail.com>,
	<linux-pci@vger.kernel.org>
References: <7CA7CC8661C64A85926B8624168F24BA@SonyVAIO> <CANEJEGs+tpLx539wtC0wLB=zu_o_3YkMfMk0QDiCo-_dHRM7aw@mail.gmail.com>
In-Reply-To: <CANEJEGs+tpLx539wtC0wLB=zu_o_3YkMfMk0QDiCo-_dHRM7aw@mail.gmail.com>
Subject: Re: PCIe latency / your MMIO latency
Date: Mon, 5 Mar 2012 16:46:38 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello All!

Sorry for the delay.

>> How did you arrive at this theoretical number of 250ns? What did you 
>> consider?

1. Here is academic research on PCIe latency:
http://www.cl.cam.ac.uk/~awm22/publications/miller2009motivating.pdf
they measure 315ns (~252ns PCIe level + ~63ns board itself) read latency 
using some relatively old configuration (MCU outside CPU) and we can`t reach 
this figure on our modern Intel i7-2700k + AsRock z68 Extreme7 Gen3 setup.

2. Here is PCIe vs. HyperTransport comparison with 250ns read latency 
breakdown.

http://www.caoni.info/pdf/Latency/7.pdf

>> I'm wondering why cache coherency traffic should interfere with your
measurement.

Upon completion of PCIe read request or after bus mastered write to host 
memory MCU snoops CPU cache. Cache miss costs a lot - and there is some 
technics (like DCA - Direct Cache Access by Intel) to place data directly 
into processors cache after operation. We do not use these technics now 
because even cache miss costs much less than 100ns we are looking for.

>> Can you post chip set models/vendors and times measured so we can
duplicate the results with other devices?

Our main test system is  i7-2700k + AsRock z68 Extreme7 Gen3 with integrated 
MCU. The best results were around 400-500ns (depending on board used) but 
never close to 300ns. OK, you will probably say "he is funny, looking for 
100ns - what is the difference between 315ns he is looking for and 400-500 
he has at the moment" but for me not the actual figure matters - the 
understanding of what is happening is of most importance. I do not 
understand why 250ns is a figure for PCIe RTT and I experience above 400 on 
a modern hardware.

Thank you for your help, Gents!

Kind regards,
        Anton.

-----Исходное сообщение----- 
From: Grant Grundler
Sent: Wednesday, February 29, 2012 9:11 PM
To: Anton Murashov
Cc: Robert.Olsson@data.slu.se ; buytenh@wantstofly.org ; 
laforge@gnumonks.org ; grundler@parisc-linux.org ; 
derbenev@quantstellation.ru ; Evgeny Vasin ; linux-pci@vger.kernel.org
Subject: Re: PCIe latency / your MMIO latency

+linux-pci  [ re: http://svn.gnumonks.org/trunk/mmio_test/ ]

Hi Anton,
Please CC linux-pci. mmio_test is a public tool - please use a public
mailing list when asking for advice. Secondly, *current* linux pci
expertise resides on this list.

On Tue, Feb 28, 2012 at 11:42 PM, Anton Murashov
<anton.murashov@gmail.com> wrote:
> Hello, Gents.
>
> I am writing to you because you are the authors of great MMIO tool.
>
> We are developing very latency-sensitive hardware/software complex and 
> part
> of this project is a very fast (=low-latency) interconnect between CPU and
> PCIe card. Theoretically PCIe latency (non-posted read request – 
> completion
> or posted write-write pair from/to the device) should be around 250ns (=
> 875 clock cycles @ our 3.5 Ghz CPU).

How did you arrive at this theoretical number of 250ns? What did you 
consider?

MMIO is measuring in CPU cycles (TSC) the time from CPU

> Cache coherence and other issues can
> vary this figure.

MMIO space is generally non-coherent and uncached. Is that not true
for your device?
I'm wondering why cache coherency traffic should interfere with your
measurement.

> – but measuring real-world machine we`ve never got anything
> even close to these 250ns. We tried different motherboards, different 
> CPUs,
> different slots within one motherboard, etc.

Can you post chip set models/vendors and times measured so we can
duplicate the results with other devices?

> Results vary deadly – from 0.7 us to 2 us, what is much bigger figures 
> than
> we were expecting. More of that – this dispersion depending on particular
> setup means that problem is not inside our hardware (actually, we tried
> multiply hardware options as well) but in PCIe hardware / settings.

0.7us-2us seems quite reasonable for PCIe MMIO read based on my
previous experience. 700ns is about 4x-5x longer than an "open page"
memory fetch.  250ns would be roughly 2x-3x a memory fetch. 250ns
seems unrealistic given memory operations are generally all occur on
one chip (crossing timing domains but all within one chip) and MMIO
operations must traverse many more timing domains and "bridges".

> So, my questions to you gents are:
>
> Do you have any experience with PCIe from this perspective?

Not recently. See
http://www.parisc-linux.org/~grundler/talks/ols_2002/4_6MMIO_Reads_are.html

> Do you have ideas how to make it work around it`s theoretical 250ns? Have 
> you ever seen
> figures like this while working on MMIO or other things?

No. I've never seen 250us PCIe MMIO read completion time. In general,
to get those sorts of transaction times, one has to have a "flow" of
transactions (ie all DMA, no MMIO reads or writes) and one can then
just measure the time a device needs to DMA in a command queue and
emit a completion message in another queue (CPU polled). And even with
that, I'm skeptical the "round trip time" will be below ~400-500ns on
conventional x86 HW.

> We will really appreciate any comments from you regarding this issue. The
> fact that you`ve written MMIO means you have a lot of great experience in
> this filed!

Uhm. Not really. It just means we were curious and wanted other people
to help us measure MMIO access times.

mmio_test is also an "education tool" so HW vendors become more aware
of how expensive MMIO reads are and why they should design interfaces
that do NOT use MMIO read in the "performance path".

More "tips" on developing high performance PCI devices here:
    "09_Advanced Programming Interfaces for PCI Devices"
    http://www.pcisig.com/developers/main/training_materials/get_document?doc_id=00941b570381863f8cc97850d46c0597e919a34b

cheers,
grant

>
> Thank you!
>
> Kind regards,
>         Anton. 

