Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI: release pci_host_bridge resource after remove root
 bus
To: Bjorn Helgaas <helgaas@kernel.org>, wangyijing <wangyijing@huawei.com>
References: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
 <20160822172821.GG18628@localhost> <57BBB383.50503@huawei.com>
 <20160824213921.GH23914@localhost>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c9129658-d500-ac4c-ccd7-090ebcbf731d@codeaurora.org>
Date: Wed, 24 Aug 2016 17:48:48 -0400
MIME-Version: 1.0
In-Reply-To: <20160824213921.GH23914@localhost>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/24/2016 5:39 PM, Bjorn Helgaas wrote:
>> Yes, may some pci drivers make a mistake, the refcount control the device object
>> > release is fine, but I think move the mem resource release out is better.
> If this is caused by driver bugs, I think we need to fix the driver
> bugs.
> 
> So far all I see here is "it works when I do this."  What we need is
> an argument for "it's correct to do this."  It's certainly possible
> that you're already making that argument and I'm just not
> understanding it.
> 

I also want to point out that the sysfs is not the only device removal
path. As Bjorn pointed out, you were moving resource free code into the sysfs
path and breaking other path (ACPI hotplug).

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
