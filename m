Return-Path: <SRS0=M1MQ=JI=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=M1MQ=JI=codeaurora.org=tbaicar@kernel.org>
Subject: Re: [PATCH v5 3/5] PCI/AER: Add sysfs attributes to provide breakdown
 of AERs
To: rajatxjain@gmail.com, Bjorn Helgaas <helgaas@kernel.org>
Cc: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Philippe Ombredanne
 <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
 Keith Busch <keith.busch@intel.com>, Alexandru Gagniuc
 <mr.nuke.me@gmail.com>, Thomas Tai <thomas.tai@oracle.com>,
 "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
 linux-pci <linux-pci@vger.kernel.org>, linux-doc
 <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180620234147.48438-1-rajatja@google.com>
 <20180620234147.48438-3-rajatja@google.com>
 <20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com>
 <CAA93t1rz6YGmvvORDB0ehr7Gwp-W+0HDYxEDgjtgYmGm3qMgCw@mail.gmail.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <a16746f0-351f-276e-2a66-3ebf2c267507@codeaurora.org>
Date: Fri, 22 Jun 2018 12:38:50 -0400
MIME-Version: 1.0
In-Reply-To: <CAA93t1rz6YGmvvORDB0ehr7Gwp-W+0HDYxEDgjtgYmGm3qMgCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 6/21/2018 5:25 PM, Rajat Jain wrote:
> On Thu, Jun 21, 2018 at 11:48 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Tyler for AER dmesg decoding]
>>
>> - Tyler posted a patch [1] to update those dmesg strings so they match
>>    the way lspci decodes them.  I really liked that update, but we
>>    never quite finished it.  If we're going to do that, it would be
>>    nice to do it first, so we don't publish new sysfs files, then
>>    immediately change the labels used in them.
> Sure, I guess you can push them in the right order.
The way the prints are handled has already been unified in 4.18rc1:

https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/pci/pcie/aer.c#L636

So that patch isn't needed anymore in it's entirety.
>> - IIRC, Tyler's patch had the nice property of changing the strings so
>>    each error name had no spaces, which would make it a little easier
>>    to parse this sysfs file: each line would be a single identifier
>>    followed by a single number (I would probably remove the "=" from
>>    the middle).
>
> Will do.
Would you like me to send a patch with just the string changes?

Thanks,
Tyler
>> [1] https://lkml.kernel.org/r/1518034285-3543-1-git-send-email-tbaicar@codeaurora.org
>>
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
