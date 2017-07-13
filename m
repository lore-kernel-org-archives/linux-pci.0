Return-Path: <SRS0=JYXB=6Q=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=JYXB=6Q=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org,
 Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0bcc0b00-1ad3-6866-32ab-15da8ea1821e@codeaurora.org>
Date: Thu, 13 Jul 2017 11:44:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 7/13/2017 8:17 AM, Bjorn Helgaas wrote:
>> he spec is calling to wait up to 1 seconds if the device is sending CRS.
>> The NVMe device seems to be requiring more. Relax this up to 60 seconds.
> Can you add a pointer to the "1 second" requirement in the spec here?
> We use 60 seconds in pci_scan_device() and acpiphp_add_context().  Is
> there a basis in the spec for the 60 second timeout?

This does not specify a hard limit above on how long SW need to wait. 

"6.6.2 Function Level Reset
After an FLR has been initiated by writing a 1b to the Initiate Function Level Reset bit, 
the Function must complete the FLR within 100 ms.

While a Function is required to complete the FLR operation within the time limit described above,
the subsequent Function-specific initialization sequence may require additional time. 
If additional time is required, the Function must return a Configuration Request Retry Status (CRS) 
Completion Status when a Configuration Request is received 15 after the time limit above. 
After the Function responds to a Configuration Request with a Completion status other than CRS, 
it is not permitted to return CRS until it is reset again."

However, another indirect reference here tells us it is capped by 1 second below.

"6.23. Readiness Notifications (RN)
Readiness Notifications (RN) is intended to reduce the time software needs to
wait before issuing Configuration Requests to a Device or Function following DRS
Events or FRS Events. RN includes both the Device Readiness Status (DRS) and
Function Readiness Status (FRS) mechanisms. These mechanisms provide a direct
indication of Configuration-Readiness (see 5 Terms and Acronyms entry for “Configuration-Ready”). 

When used, DRS and FRS allow an improved behavior over the CRS mechanism, and eliminate
its associated periodic polling time of up to 1 second following a reset."

If I remember it right from CRS commit messages, 60 seconds was coming from
some PCIe switch taking too long to boot.

> 
> What's the NVMe excuse for requiring more time than the spec allows?
> Is this a hardware erratum?  Is there some PCIe ECN pending to address
> this?

We have seen the issue with Intel 750 and Intel P3600 NVMe drives. I don't
have access to the errata document for either of the drives.

> 
> I try to avoid adding generic changes based on one specific piece of
> hardware because it can penalize everybody else who actually bothered
> to follow the spec.  For example, if FLR fails because a non-NVMe
> device is broken, it will now take 60 seconds to notice that instead
> of 1 second.
> 

We can look for a better number like 3-4 seconds and put some nice warning
that HW might be broken (violating the spec) and could be in need of
a FW/BIOS update.

What do you think?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
