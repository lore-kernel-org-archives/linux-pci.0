Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 23 Feb 2016 11:02:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Marsan, Luugi" <Luugi.Marsan@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV
 on AMD GPU
Message-ID: <20160223170215.GA25203@localhost>
References: <CY1PR12MB0262D12DAC0897F8DC74541CFEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CY1PR12MB0262D12DAC0897F8DC74541CFEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Joerg, Alex]

Hi Kelly,

On Tue, Feb 23, 2016 at 03:52:13PM +0000, Zytaruk, Kelly wrote:
> As per our offline discussions I have created Bugzilla #112941 for
> the SRIOV issue.

https://bugzilla.kernel.org/show_bug.cgi?id=112941

> When trying to enable SRIOV on AMD GPU after doing a previous enable
> / disable sequence the following warning is shown in dmesg.  I
> suspect that there might be something missing from the cleanup on
> the disable.  
> 
> I had a quick look at the code and it is checking for something in
> the iommu, something to do with being attached to a domain.  I am
> not familiar with this code yet (what does it mean to be attached to
> a domain?) so it might take a little while before I can get the time
> to check it out and understand it.
> 
> From a quick glance I notice that during SRIOV enable the function
> do_attach()  in amd_iommu.c is called but during disable I don't see
> a corresponding call to do_detach (...).  do_detach(...) is called
> in the second enable SRIOV  sequence as a cleanup because it thinks
> that the iommu is still attached which it shouldn't be (as far as I
> understand).
> 
> If the iommu reports that the device is being removed why isn't it
> also detached??? Is this by design or an omission?

I don't know enough about the IOMMU code to understand this, but maybe
the IOMMU experts I copied do.

> I see the following in dmesg when I do a disable, note the device is removed.
> 
> [  131.674066] pci 0000:02:00.0: PME# disabled
> [  131.682191] iommu: Removing device 0000:02:00.0 from group 2
> 
> Stack trace of warn is shown below.
> 
> [  368.510742] pci 0000:02:00.2: calling pci_fixup_video+0x0/0xb1
> [  368.510847] pci 0000:02:00.3: [1002:692f] type 00 class 0x030000
> [  368.510888] pci 0000:02:00.3: Max Payload Size set to 256 (was 128, max 256)
> [  368.510907] pci 0000:02:00.3: calling quirk_no_pm_reset+0x0/0x1a
> [  368.511005] vgaarb: device added: PCI:0000:02:00.3,decodes=io+mem,owns=none,locks=none
> [  368.511421] ------------[ cut here ]------------
> [  368.511426] WARNING: CPU: 1 PID: 3390 at drivers/pci/ats.c:85 pci_disable_ats+0x26/0xa4()

This warning is because dev->ats_enabled doesn't have the value we
expect.  I think we only modify ats_enabled in two places.  Can you
stick a dump_stack() at those two places?  Maybe a little more context
will make this obvious.

Bjorn
