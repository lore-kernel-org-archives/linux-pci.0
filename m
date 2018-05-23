Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46668 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933114AbeEWO0M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 10:26:12 -0400
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
To: Jes Sorensen <jsorensen@fb.com>, Rajat Jain <rajatja@google.com>,
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
        linux-kernel@vger.kernel.org, Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
 <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <53789ac0-b571-5d6a-5925-7e83925b5b31@gmail.com>
Date: Wed, 23 May 2018 09:26:09 -0500
MIME-Version: 1.0
In-Reply-To: <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/23/2018 09:20 AM, Jes Sorensen wrote:
> On 05/22/2018 06:28 PM, Rajat Jain wrote:
>> new file mode 100644
>> index 000000000000..b9f251992209
>> --- /dev/null
>> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Fix the formatting please - that gross // gibberish doesn't belong there.

Deep breath in. Deep breath out.

git grep SPDX

Although I don't like it, this format is already too common.

Cheers,
Alex
