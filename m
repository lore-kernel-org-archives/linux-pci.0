Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32939 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbeEVXT0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 19:19:26 -0400
Received: by mail-oi0-f65.google.com with SMTP id k5-v6so17823851oiw.0
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2018 16:19:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cffe5b81-a05c-a249-8c36-70a9c4d61e7f@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com> <20180522222805.80314-6-rajatja@google.com>
 <cffe5b81-a05c-a249-8c36-70a9c4d61e7f@gmail.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 22 May 2018 16:18:45 -0700
Message-ID: <CACK8Z6E7Ax=_Ai7XOic5hWMRqQXiOox2z-w23j0S3O9P5AnCLw@mail.gmail.com>
Subject: Re: [PATCH 5/5] Documentation/PCI: Add details of PCI AER statistics
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci <linux-pci@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, May 22, 2018 at 3:52 PM, Alex G. <mr.nuke.me@gmail.com> wrote:
> On 05/22/2018 05:28 PM, Rajat Jain wrote:
>> Add the PCI AER statistics details to
>> Documentation/PCI/pcieaer-howto.txt
>>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> ---
>>  Documentation/PCI/pcieaer-howto.txt | 35 +++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
>> index acd0dddd6bb8..86ee9f9ff5e1 100644
>> --- a/Documentation/PCI/pcieaer-howto.txt
>> +++ b/Documentation/PCI/pcieaer-howto.txt
>> @@ -73,6 +73,41 @@ In the example, 'Requester ID' means the ID of the device who sends
>>  the error message to root port. Pls. refer to pci express specs for
>>  other fields.
>>
>> +2.4 AER statistics
>> +
>> +When AER messages are captured, the statistics are exposed via the following
>> +sysfs attributes under the "aer_stats" folder for the device:
>> +
>> +2.4.1 Device sysfs Attributes
>> +
>> +These attributes show up under all the devices that are AER capable. These
>> +indicate the errors "as seen by the device". Note that this may mean that if
>> +an end point is causing problems, the AER counters may increment at its link
>> +partner (e.g. root port) because the errors will be "seen" by the link partner
>> +and not the the problematic end point itself (which may report all counters
>> +as 0 as it never saw any problems).
>
> I was afraid of that. Is there a way to look at the requester ID to log
> AER errors to the correct device?

I do not think it is possible to pin point the source of the problem.
Errors may be caused due to sub optimal link tuning, or signal
integrity, or either of the link partners. Both the link partners will
detect and report the errors that they "see".

The bits and errors defined by the PCIe spec, follow the same semantics i.e.
 => the spec defines the different error conditions "as
seen/encountered by the device",
       => Thus the device reports those errors to the root port
               => which is what we are counting and reporting here.

IMHO, any interpretation / analysis of this error data / counters
should be left to the user so that he can look at different devices
and the errors they see, and then conclude on what might be the
problem.

Thanks,
Rajat

>
> Alex
