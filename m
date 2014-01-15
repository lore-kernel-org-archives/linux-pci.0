Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:42599 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbaAOAeG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 19:34:06 -0500
Received: by mail-we0-f169.google.com with SMTP id u57so1142376wes.28
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 16:34:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6cYZL5q7R1ccEZW9GAGcmHsYrAeGr3r_z-A4S1SunfqA@mail.gmail.com>
References: <CAE9FiQUGpBTijNGX6T=mLgoVa7wVegOMye8uGOqhKq93-1hyqQ@mail.gmail.com>
	<CAErSpo6cYZL5q7R1ccEZW9GAGcmHsYrAeGr3r_z-A4S1SunfqA@mail.gmail.com>
Date: Tue, 14 Jan 2014 17:34:04 -0700
Message-ID: <CAPoiz9xhm0J1DJ9EYyFFFez8dQ8-6iVG-T_0NpVxie6qVwQYVQ@mail.gmail.com>
Subject: Re: about mpss with pcie_bus_perf
From: Jon Mason <jdmason@kudzu.us>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Myron Stowe <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jon Mason <jon.mason@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 14, 2014 at 3:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Jon, Yijing]
>
> On Thu, Jan 9, 2014 at 5:46 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> looks like we have some problem with MPSS.
>>
>> +-02.2-[10-1f]----00.0-[11-13]--+-02.0-[12]--+-00.0
>>                            |                      |                   \-00.1
>>                            |                      \-03.0-[13]----00.0
>>
>> kernel boot with pce_bus_perf:
>> 00:02.2: cap/ctl: 256/256
>> 10:00.0: cap/ctl: 256/256
>> 11:02.0: cap/ctl: 256/256
>> 12:00.0: cap/ctl: 128/128
>> 12:00.1: cap/ctl: 128/128
>>
>> 11:03.0: cap/ctl: 256/256
>> 13:00.0: cap/ctl: 256/256
>>
>> Should we set MPSS to 128?
>
> Please propose a patch and/or open a bug report.  I don't do enough
> with MPS to make the problem and its solution immediately obvious to
> me.

Not a lot of verbiage in here, but I believe this is the expected
behavior for the "pcie_bus_perf" kernel boot parm.  With it, each pci
device sets its MPS to the max of the parent

>From the commit log:

    - A more optimal way is possible, if it falls within a couple of
      constraints:
    * The top-level host bridge will never generate packets larger than the
      smallest TLP (or if it can be controlled independently from its MPS at
      least)
    * The device will never generate packets larger than MPS (which can be
      configured via MRRS)
    * No support of direct PCI-E <-> PCI-E transfers between devices without
      some additional code to specifically deal with that case

    Then we can use an approach that basically ignores downstream requests
    and focuses exclusively on upstream requests. In that case, all we need
    to care about is that a device MPS is no larger than its parent MPS,
    which allows us to keep all switches/bridges to the max MPS supported by
    their parent and eventually the PHB.


If this is not behaving as described (which I can't tell from the log
above), then feel free to assign the bug to me.

Thanks,
Jon



>
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
