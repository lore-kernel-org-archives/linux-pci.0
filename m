Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43585 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030714Ab2B2RLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Feb 2012 12:11:55 -0500
Received: by yenl12 with SMTP id l12so1408841yen.19
        for <linux-pci@vger.kernel.org>; Wed, 29 Feb 2012 09:11:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7CA7CC8661C64A85926B8624168F24BA@SonyVAIO>
References: <7CA7CC8661C64A85926B8624168F24BA@SonyVAIO>
Date: Wed, 29 Feb 2012 09:11:54 -0800
Message-ID: <CANEJEGs+tpLx539wtC0wLB=zu_o_3YkMfMk0QDiCo-_dHRM7aw@mail.gmail.com>
Subject: Re: PCIe latency / your MMIO latency
From: Grant Grundler <grantgrundler@gmail.com>
To: Anton Murashov <anton.murashov@gmail.com>
Cc: Robert.Olsson@data.slu.se, buytenh@wantstofly.org,
	laforge@gnumonks.org, grundler@parisc-linux.org,
	derbenev@quantstellation.ru, Evgeny Vasin <gevorr@gmail.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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
> We are developing very latency-sensitive hardware/software complex and part
> of this project is a very fast (=low-latency) interconnect between CPU and
> PCIe card. Theoretically PCIe latency (non-posted read request – completion
> or posted write-write pair from/to the device) should be around 250ns (=
> 875 clock cycles @ our 3.5 Ghz CPU).

How did you arrive at this theoretical number of 250ns? What did you consider?

MMIO is measuring in CPU cycles (TSC) the time from CPU

> Cache coherence and other issues can
> vary this figure.

MMIO space is generally non-coherent and uncached. Is that not true
for your device?
I'm wondering why cache coherency traffic should interfere with your
measurement.

> – but measuring real-world machine we`ve never got anything
> even close to these 250ns. We tried different motherboards, different CPUs,
> different slots within one motherboard, etc.

Can you post chip set models/vendors and times measured so we can
duplicate the results with other devices?

> Results vary deadly – from 0.7 us to 2 us, what is much bigger figures than
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

> Do you have ideas how to make it work around it`s theoretical 250ns? Have you ever seen
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
>         Anton.
