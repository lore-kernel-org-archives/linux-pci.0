Return-Path: <SRS0=fKP7=HB=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=fKP7=HB=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
To: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
Date: Wed, 11 Apr 2018 21:41:56 -0400
MIME-Version: 1.0
In-Reply-To: <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/10/2018 5:03 PM, Bjorn Helgaas wrote:
>> DPC and AER should attempt recovery in the same way, except the
>> cases where system is with hotplug enabled.
> What's the connection with hotplug?  I see from the patch that for
> hotplug bridges you remove the tree below the bridge, and otherwise
> you just reset the secondary link (I think).
> 
> The changelog should explain why we need the difference.
> 
> I'm a little skeptical to begin with, because I'm not sure why we
> should handle a DPC event differently just because a bridge has the
> *capability* of hotplug.  Even if a hotplug bridge reports a DPC
> event, that doesn't necessarily mean a hotplug has occurred.
> 

Let's do a recap on what we have discussed about this until now.

There are two conflicting error recovery mechanisms for PCIe. 

If a system supports both hotplug and DPC, endpoint can be removed and inserted safely.
DPC driver shuts down the driver on link down. When link comes back up,
hotplug driver takes over and initiates an enumeration process. 
Keith mentioned the stop and re-enumerate design was chosen because 
someone could remove a drive and insert an unrelated drive back to the
system.  We can't really save and restore state as we do in the AER path. 

Now, let's assume a system without hotplug capability.
Second mechanism is to go through DPC/AER path and do an automatic link
down recovery via DPC retrain/secondary bus reset including register save and
restore.  Second mechanism is more suitable for handling "surprise link down"
event. The goal is to retrain the link and continue driver operation. 

The goal of this patch to separate these two cases from each other as
the DPC driver needs to work on both contexts. Current DPC code doesn't handle
the second use case.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
