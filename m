Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <40F65EF2B5E2254199711F58E3ACB84D7825DE9F@MX104CL02.corp.emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com> <ae66adf68441cdaf893d2a562924615c229489c0.1432135631.git.Allen.Hubbe@emc.com>
 <CAErSpo5gf9VhegEGY5S+dak0UuMNEMDD29JT4TcTz_UPey3aNQ@mail.gmail.com>
 <40F65EF2B5E2254199711F58E3ACB84D7825D377@MX104CL02.corp.emc.com>
 <CAErSpo5WzQ86t5F2pfhHYipcUH3h2vv1DN1-Dpx_VPsOnbpu=w@mail.gmail.com> <40F65EF2B5E2254199711F58E3ACB84D7825DE9F@MX104CL02.corp.emc.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 21 May 2015 07:06:10 -0500
Message-ID: <CAErSpo76T1noeTyKw7FZh-dhfSfqezU9Y4rBftOCdGC8-M7ySg@mail.gmail.com>
Subject: Re: [PATCH 03/16] ntb: Enable link training for RP mode in the driver probe
To: "Hubbe, Allen" <Allen.Hubbe@emc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 20, 2015 at 6:00 PM, Hubbe, Allen <Allen.Hubbe@emc.com> wrote:
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> On Wed, May 20, 2015 at 4:46 PM, Hubbe, Allen <Allen.Hubbe@emc.com>
>> wrote:
>> > From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> >> Please run "git log --oneline drivers/ntb" and make your subject
>> lines
>> >> consistent.  The convention I use in PCI (and what was used in NTB
>> >> until recently) is
>> >>
>> >>   - Acronyms and initialisms are capitalized
>> >>   - Subject line is a subsystem prefix ("PCI:", "NTB:", etc.)
>> followed
>> >> by a complete sentence starting with a capitalized verb, with no
>> >> period at the end
>> >
>> > These are the new subject lines that will be in the v2 of this set.
>>
>> That helps a lot, thanks.
>>
>> > NTB: Fix small code format issues in transport
>> > NTB: Default to CPU memcpy for performance
>> > NTB: Improve performance with write combining
>> > NTB: Use NUMA aware memory allocation
>> > NTB: Use NUMA memory and DMA chan in transport
>> > NTB: Reset transport QP link stats on down
>> > NTB: Do not advance transport RX on link down
>> > NTB: Differentiate transport link down messages
>> > NTB: Rate limit ntb_qp_link_work
>> > NTB: Add tool client
>> > NTB: Add ping pong client
>>
>> I think these are test cases, not part of the kernel itself.  It'd be
>> nice to know that from the summary.  I don't know what the precedent
>> is for that (if there is one).
>
> Would you consider this as precedent:
>
> 4a776f0 dmatest: Simple DMA memcpy test client
>
>>
>> > NTB: Intel NTB params for SNB B2B addresses
>>
>> This sentence no verb :)  Not sure what you're doing with those params.
>
> NTB: Add parameters for Intel SNB B2B addresses
>
>>
>> > NTB: Check the DID for workaround error flags
>>
>> I think there's room to spell out "device ID".
>
> NTB: Check the device ID to set errata flags
>
> Also, add this prose description to this commit:
>
> Set errata flags for the specific device IDs to which they apply,
> instead of the whole xeon hardware class.
>
>>
>> > NTB: Enable link training for RP mode in probe
>>
>> Is that Root Port?
>
> yes
>
>>
>> > NTB: Add NTB hardware abstraction layer
>> > NTB: Move files in preparation for NTB abstraction

All looks good to me!
