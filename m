Return-Path: <SRS0=Zh8q=GC=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Zh8q=GC=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
To: Keith Busch <keith.busch@intel.com>, poza@codeaurora.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
 <20180312145823.GC18494@localhost.localdomain>
 <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
 <20180312173301.GD18494@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57d0b245-aecb-1518-c8bb-df8b69a86bcc@codeaurora.org>
Date: Mon, 12 Mar 2018 13:41:07 -0400
MIME-Version: 1.0
In-Reply-To: <20180312173301.GD18494@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

I was just writing a reply to you. You acted first :)

On 3/12/2018 1:33 PM, Keith Busch wrote:
>>> After releasing a slot from DPC, the link is allowed to retrain. If
>>> there
>>> is a working device on the other side, a link up event occurs. That
>>> event is handled by the pciehp driver, and that schedules enumeration
>>> no matter what you do to the DPC driver.
>> yes, that is what i current, but this patch-set makes DPC aware of error
>> handling driver callbacks.
> I've been questioning the utility of doing that since the very first
> version of this patch set.
> 

I think we should all agree that shutting down the device drivers with active
work is not safe. There could be outstanding work that the endpoint driver
needs to take care of. 

That was the motivation for this change so that we give endpoint drivers an 
error callback when something goes wrong. 

The rest is implementation detail that we can all figure out.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
