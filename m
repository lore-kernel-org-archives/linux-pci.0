Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbeEVXao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 19:30:44 -0400
Subject: Re: [PATCH 2/5] PCI/AER: Add sysfs stats for AER capable devices
To: Rajat Jain <rajatja@google.com>, "Alex G." <mr.nuke.me@gmail.com>
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
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-3-rajatja@google.com>
 <dcbb2e92-722f-c178-efb7-8d99d4a9d99f@gmail.com>
 <CACK8Z6GNPa+15WLxJBUAZ2=+jfhtdz+85=41B56KWSWCHSnyGw@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9861c339-6784-c7ec-b1ec-6722fb0d5bd5@codeaurora.org>
Date: Tue, 22 May 2018 19:30:39 -0400
MIME-Version: 1.0
In-Reply-To: <CACK8Z6GNPa+15WLxJBUAZ2=+jfhtdz+85=41B56KWSWCHSnyGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/22/2018 7:27 PM, Rajat Jain wrote:
>> What about AER errors that are contained by DPC?
> Thanks, You are right, this patch does not take care of the DPC. I'll
> try to read up on DPC and can integrate it if it turns out to be easy
> enough.
> 

I'd focus on AER for the moment. DPC is going through major restructuring
and will only handle AER_FATAL errors moving forward.

> Thanks,
> 
> Rajat
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
