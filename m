Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <000001d30b90$31697f70$943c7e50$@dell.com>
References: <20170725205753.4735-1-logang@deltatee.com> <20170725205753.4735-15-logang@deltatee.com>
 <20170801191050.GJ4186@kudzu.us> <dda576ad-d3ca-814b-f0cf-478cbb61adf2@deltatee.com>
 <000001d30b90$31697f70$943c7e50$@dell.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 2 Aug 2017 12:32:24 -0400
Message-ID: <CAPoiz9wy3bFUWkE1udiY7ynkOT5VxvvtoawNw1qRTFnSapcOEQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] switchtec_ntb: implement scratchpad registers
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-ntb@googlegroups.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 2, 2017 at 9:06 AM, Allen Hubbe <Allen.Hubbe@dell.com> wrote:
> From: Logan Gunthorpe
>> On 01/08/17 01:10 PM, Jon Mason wrote:
>> > It would probaly be better if I remarked about the SPADs in the actual
>> > patch about the SPADS :)
>> >
>> > The whole point of using the SPADs in the NTB driver was to workaround
>> > the problems establishing a connection between the two sides of the
>> > NTB and where everything lives.  So, using a MW to get around the
>> > SPADs is sort of backwards (and slightly funny).  I realize you are
>> > trying to use the existing transport with minimal changes to enable
>> > your hardware, and thus this makes logical sense to you.  However, if
>> > the SPADs are not really needed, then we should either remove them
>> > from the transport (or use them for something else).
>> >
>> > Per my comment in the other patch, I'm amenable to take this series
>> > as-is, assuming you are willing to address this design issue in the
>> > near future.  Thoughts?
>>
>> Yes, I agree. I'd be willing to help but it seems the clients are
>> written the way they are for the other drivers, so it's their needs
>> (which I'm not fully aware of) that have to be considered.
>
> The proposed change, removing use of spads from transport, would not affect ntrdma.

After a long-ish conversation on IRC, the way we want to go forward
would be to provide 2 ways of communicating prior to the MW's being
setup:  SPADs and Message Registers.  The HW driver would make
available whichever ones are supported by the hardware.  The transport
can see which of those are available in the HW driver, select the
appropriate one, and use it to setup the NTB connection, MW, etc.
similar to how the SPADs are being used today.  This would allow for
any current clients to work unmodified, and would require minimal
changes to the existing transport layer.

Since this is outside the scope of this series, per my email yesterday
allowing the SPAD workaround, we should start up another thread on the
NTB mailing list and flesh out the details and any benefits/drawbacks.
Then we, as a community, can make the changes necessary to the drivers
and transport to get this working more optimally.

Thanks,
Jon

>> I've also made all the other changes you sent as well as the file rename
>> Dave requested. Once I see the bug fix patch you were going to pull hit
>> ntb-next I'll rebase, test and resubmit.
>>
>> Thanks,
>>
>> Logan
>
