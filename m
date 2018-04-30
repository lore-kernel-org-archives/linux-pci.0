Return-Path: <SRS0=12iv=HT=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=12iv=HT=codeaurora.org=okaya@kernel.org>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Eric Biederman <ebiederm@xmission.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Vivek Goyal <vgoyal@redhat.com>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
 <20180427211255.GI8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180428005620.GB1675@dhcp-128-65.nay.redhat.com>
 <20180428011845.GC1675@dhcp-128-65.nay.redhat.com>
 <3ebc908fb196168bf0373875ffc5679e@codeaurora.org>
 <d8d134dc-9757-97cd-7a24-cbb21611d6c6@codeaurora.org>
 <20180430211740.GG95643@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <7285da70-2c3e-c3b7-62e1-fdbb55a77729@codeaurora.org>
Date: Mon, 30 Apr 2018 17:27:32 -0400
MIME-Version: 1.0
In-Reply-To: <20180430211740.GG95643@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/30/2018 5:17 PM, Bjorn Helgaas wrote:
>> What should we do about this?
>>
>> Since there is an actual HW errata involved, should we quirk this
>> root port and not wait as if remove/shutdown doesn't exist?
> I was hoping to avoid a quirk because AFAIK all Intel parts have this
> issue so it will be an ongoing maintenance issue.  I tried to avoid
> the timeout delays, e.g., with 40b960831cfa ("PCI: pciehp: Compute
> timeout from hotplug command start time").
> 
> But we still see the alarming messages, so we should probably add a
> quirk to get rid of those.
> 
> But I haven't given up on the idea of getting rid of the
> pciehp_remove() path.  I'm not convinced yet that we actually need to
> do anything to shut this device down.  I don't like the assumption
> that kexec requires this.  The kexec is fundamentally just a branch,
> and anything we do before the branch (i.e., in the old kernel), we
> should also be able to do after the branch (i.e., in the kexec-ed
> kernel).
> 

In my experience with kexec, MSI type edge interrupts are harmless.
You might just see a few unhandled interrupt messages during boot
if something is pending from the first kernel.

It is the level interrupts that are more concerning. It remains pending
until the interrupt source is cleared. CPU never returns from the
interrupt handler to actually continue booting the second kernel.

Execution doesn't reach to PCIe hp driver initialization for
acknowledging the interrupt.

How about remove() only if MSI is disabled? Most root port interrupts
are MSI based anyhow.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
