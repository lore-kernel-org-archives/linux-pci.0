Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:57252 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbaAOSSU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 13:18:20 -0500
Received: by mail-we0-f169.google.com with SMTP id u57so2195454wes.14
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2014 10:18:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52D5EEA1.3030603@huawei.com>
References: <CAE9FiQUGpBTijNGX6T=mLgoVa7wVegOMye8uGOqhKq93-1hyqQ@mail.gmail.com>
	<CAErSpo6cYZL5q7R1ccEZW9GAGcmHsYrAeGr3r_z-A4S1SunfqA@mail.gmail.com>
	<CAPoiz9xhm0J1DJ9EYyFFFez8dQ8-6iVG-T_0NpVxie6qVwQYVQ@mail.gmail.com>
	<52D5EEA1.3030603@huawei.com>
Date: Wed, 15 Jan 2014 11:18:19 -0700
Message-ID: <CAPoiz9ySed6fAi8h0TFCG08EVKgGN6uDiAHyKLj9v3yLkMhGDQ@mail.gmail.com>
Subject: Re: about mpss with pcie_bus_perf
From: Jon Mason <jdmason@kudzu.us>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Myron Stowe <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jon Mason <jon.mason@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 14, 2014 at 7:12 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2014/1/15 8:34, Jon Mason wrote:
>> On Tue, Jan 14, 2014 at 3:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> [+cc Jon, Yijing]
>>>
>>> On Thu, Jan 9, 2014 at 5:46 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> looks like we have some problem with MPSS.
>>>>
>>>> +-02.2-[10-1f]----00.0-[11-13]--+-02.0-[12]--+-00.0
>>>>                            |    |            \-00.1
>>>>                            |    \-03.0-[13]----00.0
>>>>
>>>> kernel boot with pce_bus_perf:
>>>> 00:02.2: cap/ctl: 256/256
>>>> 10:00.0: cap/ctl: 256/256
>>>> 11:02.0: cap/ctl: 256/256
>>>> 12:00.0: cap/ctl: 128/128
>>>> 12:00.1: cap/ctl: 128/128
>>>>
>>>> 11:03.0: cap/ctl: 256/256
>>>> 13:00.0: cap/ctl: 256/256
>>>>
>>>> Should we set MPSS to 128?
>>>
>>> Please propose a patch and/or open a bug report.  I don't do enough
>>> with MPS to make the problem and its solution immediately obvious to
>>> me.
>>
>> Not a lot of verbiage in here, but I believe this is the expected
>> behavior for the "pcie_bus_perf" kernel boot parm.  With it, each pci
>> device sets its MPS to the max of the parent
>
> Yes, it's the expected behavior for the "pcie_bus_per".
> Pcie_write_mrrs() will additionally set mrrs to largest supported value for safe.
>
>>
>>>From the commit log:
>>
>>     - A more optimal way is possible, if it falls within a couple of
>>       constraints:
>>     * The top-level host bridge will never generate packets larger than the
>>       smallest TLP (or if it can be controlled independently from its MPS at
>>       least)
>>     * The device will never generate packets larger than MPS (which can be
>>       configured via MRRS)
>>     * No support of direct PCI-E <-> PCI-E transfers between devices without
>>       some additional code to specifically deal with that case
>>
>>     Then we can use an approach that basically ignores downstream requests
>>     and focuses exclusively on upstream requests. In that case, all we need
>
> Hi Jon, I do not quite understand why we can ignores downstream here , as a model like Yinghai's pcie topo:
>
> mps 256           mps 256               mps 256
> root port ------Switch port(UP) -------Switch port(DP) A   --------PCIe Endpoint Device ( mps = 128)
>                                |                          <-------Read Request to upstream is safe because MRRS is set to properly value.
>                                |                          <-------TLP payload won't excess (mps=128) as a transmitter, so this is also safe.
>                                |                          -------->Downstream TLP like read completion and some other TLP write to PCIe EP device
>                                |                                   My question is here, how can we ensure Downstream is safe?
>                                |
>                                |
>                                |-------Switch port(DP) B
>
> Sorry to disturb you, I would be appreciate if you can me any advice. Thanks!

If all inter-device communication is removed, then the only
communication is CPU, Endpoint, and switches in-between.  Going from
CPU to Endpoint, the MPS is actually going to be the Cache Line size.
Since the Cache line size is 64B on x86 and most other architectures,
there is no worry that the endpoint will get a PCIE packet larger than
the MPS.  Also, using the MRRS to clamp down the endpoint to the MPS
of the switches should ensure no reads larger than the MPS.  Going
from Endpoint to CPU, we must ensure that all switches have a MPSS
large enough for any device under them.  If not, then we must clamp
down the Endpoint MPS.

If all of this works, then we can ensure a much larger MPS for all of
the PCI devices under a switch and not be bound by the smallest MPSS
of an endpoint on the switch.

Thanks,
Jon

>
>>     to care about is that a device MPS is no larger than its parent MPS,
>>     which allows us to keep all switches/bridges to the max MPS supported by
>>     their parent and eventually the PHB.
>>
>>
>> If this is not behaving as described (which I can't tell from the log
>> above), then feel free to assign the bug to me.
>>
>> Thanks,
>> Jon
>>
>>
>>
>>>
>>> Bjorn
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> .
>>
>
>
> --
> Thanks!
> Yijing
>
