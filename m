Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Myron Stowe <myron.stowe@gmail.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <CAL-B5D3g=ZWRg7Qh8_KumJkdg6F2+2a8=HCz2US7a4g2tKC0Lw@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci <linux-pci@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <735068a7-7805-dad0-b5b0-5218a18f335c@deltatee.com>
Date: Mon, 19 Dec 2016 10:06:56 -0700
MIME-Version: 1.0
In-Reply-To: <CAL-B5D3g=ZWRg7Qh8_KumJkdg6F2+2a8=HCz2US7a4g2tKC0Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 0/1] New PCI Switch Management Driver
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey,

On 19/12/16 09:09 AM, Myron Stowe wrote:
> I guess the obvious questions is: why is a driver for a PCI switch
> necessary?  The core works with all compliant switches today and there
> are no specifics for a particular design or such.

> So I guess I'd like to hear the reasoning and justifications for why a
> driver for a common device that should conform to the specifications
> and not seem to need any special considerations is required or desired
> here.

As I noted, the hardware is compliant and works perfectly fine with the
in-kernel driver. However, the hardware has many additional custom
features that are not covered by the PCI specs. For example, it has an
interface to count packets that match a specific criteria. It also has
firmware that can be expanded to do completely custom things by the
user. Additionally, the switch is _very_ configurable and has a
configuration file that can be uploaded and downloaded.

All these features and more are exposed through a special management
endpoint that is completely separate from the standard PCI switch
interface. This work is a driver for that endpoint and is not required
to use the switch. It only makes the advanced features available to the
user.

Does that make sense?

Thanks,

Logan


> On Sat, Dec 17, 2016 at 10:09 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> Hi,
>>
>> [Appologies: this is a resend for some people. Due to a configuration
>> error the original email was rejected by the mailing lists. I hope
>> this one makes it!]
>>
>> We're looking to get some initial feedback on a new driver for
>> a line of PCIe switches produced and produced and sold by Microsemi.
>> The goal is to get the process moving to get this code included in
>> upstream hopefully for 4.11. Facebook is currently gearing up to
>> use this hardware in its Open Compute Platform and is pushing to
>> have this driver in the upstream kernel.
>>
>> The following patch briefly describes the hardware and provides
>> the first draft of driver code. Currently, the driver works and
>> has been tested but is not feature complete. Thus, we are not looking
>> to get it merged immediately. However we would like some early review,
>> specifically on the interfaces and core concepts so that we don't
>> do a lot of work down a path the community would reject. Barring any
>> objections to this RFC, we will flesh out all the features
>> and provide a completed patch for inclusion in the coming weeks.
>>
>> Work on a userspace tool, that utilizes this driver, is also being
>> done at [1]. The tool is currently also a bit of a skeleton and
>> will be fleshed out assuming there are no serious objections to our
>> userspace interface. In the end, the tool will be released with a
>> GPL license.
>>
>> The patch is based off of the v4.9 release.
>>
>> Thanks for your review,
>>
>> Logan
>>
>> [1] https://github.com/sbates130272/switchtec-user
>>
>> Logan Gunthorpe (1):
>>   MicroSemi Switchtec management interface driver
>>
>>  Documentation/switchtec.txt    |  54 +++
>>  MAINTAINERS                    |   9 +
>>  drivers/pci/Kconfig            |   1 +
>>  drivers/pci/Makefile           |   1 +
>>  drivers/pci/switch/Kconfig     |  13 +
>>  drivers/pci/switch/Makefile    |   1 +
>>  drivers/pci/switch/switchtec.c | 824 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/switch/switchtec.h | 119 ++++++
>>  8 files changed, 1022 insertions(+)
>>  create mode 100644 Documentation/switchtec.txt
>>  create mode 100644 drivers/pci/switch/Kconfig
>>  create mode 100644 drivers/pci/switch/Makefile
>>  create mode 100644 drivers/pci/switch/switchtec.c
>>  create mode 100644 drivers/pci/switch/switchtec.h
>>
>> --
>> 2.1.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
