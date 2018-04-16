Return-Path: <SRS0=Gq9p=HF=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Gq9p=HF=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
To: Bjorn Helgaas <helgaas@kernel.org>, poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
 <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
 <9301606a70a213c180d9e6764b002cf9@codeaurora.org>
 <20180416132753.GA28657@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <91420f0f-31c1-0d82-63cc-627fb4920b6d@codeaurora.org>
Date: Mon, 16 Apr 2018 10:30:03 -0400
MIME-Version: 1.0
In-Reply-To: <20180416132753.GA28657@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/16/2018 9:27 AM, Bjorn Helgaas wrote:
>>> We realized that DPC and hotplug is heavily integrated today. We
>>> have use cases for systems without hotplug support but still
>>> support DPC. That's the problem we are trying to solve with this
>>> patchset.
> Apparently there's a problem with systems that have DPC but not
> hotplug.  It will be extremely helpful if you can articulate what that
> problem is and include it in the appropriate changelog.
> 

At a higher level, the DPC driver performs the stop operation regardless of
hotplug. However, DPC driver relies on hotplug driver observing link up to
re-enumerate. 

Of course, when the system didn't support hotplug; there was nobody to
restore functionality.

Our initial attempt was to also do a re-enumeration in the DPC driver
regardless of hotplug driver in the system or not. 

If hotplug driver is present, it would observe two enumerations. It still
worked as long as these were protected by a mutex.

Then, we got your input that you want DPC and AER to behave the same. We
started converging towards the AER path.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
