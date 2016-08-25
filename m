Return-Path: <wangyijing@huawei.com>
Return-Path: <wangyijing@huawei.com>
Subject: Re: [PATCH] PCI: release pci_host_bridge resource after remove root
 bus
To: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>
References: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
 <20160822172821.GG18628@localhost> <57BBB383.50503@huawei.com>
 <20160824213921.GH23914@localhost>
 <c9129658-d500-ac4c-ccd7-090ebcbf731d@codeaurora.org>
CC: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
From: wangyijing <wangyijing@huawei.com>
Message-ID: <57BEA94C.2010607@huawei.com>
Date: Thu, 25 Aug 2016 16:16:12 +0800
MIME-Version: 1.0
In-Reply-To: <c9129658-d500-ac4c-ccd7-090ebcbf731d@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>



在 2016/8/25 5:48, Sinan Kaya 写道:
> On 8/24/2016 5:39 PM, Bjorn Helgaas wrote:
>>> Yes, may some pci drivers make a mistake, the refcount control the device object
>>>> release is fine, but I think move the mem resource release out is better.
>> If this is caused by driver bugs, I think we need to fix the driver
>> bugs.
>>
>> So far all I see here is "it works when I do this."  What we need is
>> an argument for "it's correct to do this."  It's certainly possible
>> that you're already making that argument and I'm just not
>> understanding it.
>>
> 
> I also want to point out that the sysfs is not the only device removal
> path. As Bjorn pointed out, you were moving resource free code into the sysfs
> path and breaking other path (ACPI hotplug).

No, this changes is also in ACPI hotplug path, but I found antoher problem,
now host bridge resource allocated pci_acpi_root_add_resources(), if we move the
free into pci_remove_root_bus(), it's not symmetrical as Bjorn pointed out.
This may introudce some problem, E.g. if we created host bridge, but create root bus
fail, in this case ,we have no way to free host bridge resource again.  :(


> 
