Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58970 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933269AbeEWO3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 10:29:49 -0400
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
To: "Alex G." <mr.nuke.me@gmail.com>, Rajat Jain <rajatja@google.com>,
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
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kyle McMartin <jkkm@fb.com>
CC: <rajatxjain@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
 <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
 <53789ac0-b571-5d6a-5925-7e83925b5b31@gmail.com>
From: Jes Sorensen <jsorensen@fb.com>
Message-ID: <b25d5e6a-9373-2295-33e6-699fa74a94eb@fb.com>
Date: Wed, 23 May 2018 10:28:39 -0400
MIME-Version: 1.0
In-Reply-To: <53789ac0-b571-5d6a-5925-7e83925b5b31@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/23/2018 10:26 AM, Alex G. wrote:
> On 05/23/2018 09:20 AM, Jes Sorensen wrote:
>> On 05/22/2018 06:28 PM, Rajat Jain wrote:
>>> new file mode 100644
>>> index 000000000000..b9f251992209
>>> --- /dev/null
>>> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
>>> @@ -0,0 +1,64 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>
>> Fix the formatting please - that gross // gibberish doesn't belong there.
> 
> Deep breath in. Deep breath out.
> 
> git grep SPDX
> 
> Although I don't like it, this format is already too common.

So? Just because some people did something wrong doesn't mean you should
continue to do it.

Jes
