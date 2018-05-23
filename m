Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45785 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933114AbeEWOdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 10:33:33 -0400
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
To: Jes Sorensen <jsorensen@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle McMartin <jkkm@fb.com>,
        rajatxjain@gmail.com
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
 <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
 <20180523142656.GE19987@bombadil.infradead.org>
 <46f0a2fa-9b48-c6d3-05ac-a75168b1998c@fb.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <ffa4e203-f320-b9be-c0d7-8432e949765b@gmail.com>
Date: Wed, 23 May 2018 09:33:30 -0500
MIME-Version: 1.0
In-Reply-To: <46f0a2fa-9b48-c6d3-05ac-a75168b1998c@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/23/2018 09:32 AM, Jes Sorensen wrote:
> On 05/23/2018 10:26 AM, Matthew Wilcox wrote:
>> On Wed, May 23, 2018 at 10:20:10AM -0400, Jes Sorensen wrote:
>>>> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
>>>> @@ -0,0 +1,64 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>
>>> Fix the formatting please - that gross // gibberish doesn't belong there.
>>
>> Sorry, Jes.  The Chief Penguin has Spoken, and that's the preferred
>> syntax:
>>
>> 2. Style:
>>
>>    The SPDX license identifier is added in form of a comment.  The comment
>>    style depends on the file type::
>>
>>       C source: // SPDX-License-Identifier: <SPDX License Expression>
>>
>> (you can dig up the discussion around this on the mailing list if you
>> like.  Linus actually thinks that C++ single-line comments are one of
>> the few things that language got right)
> 
> Well I'll agree to disagree with Linus on this one. It's ugly as fsck
> and allows for ambiguous statements in the code.

You misspelled "fuck".

Alex
