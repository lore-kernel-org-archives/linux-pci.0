Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0088.outbound.protection.outlook.com ([207.46.100.88]:57888
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752692AbcBWRrN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Feb 2016 12:47:13 -0500
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Marsan, Luugi" <Luugi.Marsan@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: RE: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV
 on AMD GPU
Date: Tue, 23 Feb 2016 17:47:11 +0000
Message-ID: <CY1PR12MB0262E17EF294E8A1F23D8CB2FEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
References: <CY1PR12MB0262D12DAC0897F8DC74541CFEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
 <20160223170215.GA25203@localhost>
In-Reply-To: <20160223170215.GA25203@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, February 23, 2016 12:02 PM
> To: Zytaruk, Kelly
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; Marsan, Luugi; Joerg Roedel; Alex Williamson
> Subject: Re: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV
> on AMD GPU
> 
> [+cc Joerg, Alex]
> 
> Hi Kelly,
> 
> On Tue, Feb 23, 2016 at 03:52:13PM +0000, Zytaruk, Kelly wrote:
> > As per our offline discussions I have created Bugzilla #112941 for the
> > SRIOV issue.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=112941
> 
> > When trying to enable SRIOV on AMD GPU after doing a previous enable /
> > disable sequence the following warning is shown in dmesg.  I suspect
> > that there might be something missing from the cleanup on the disable.
> >
> > I had a quick look at the code and it is checking for something in the
> > iommu, something to do with being attached to a domain.  I am not
> > familiar with this code yet (what does it mean to be attached to a
> > domain?) so it might take a little while before I can get the time to
> > check it out and understand it.
> >
> > From a quick glance I notice that during SRIOV enable the function
> > do_attach()  in amd_iommu.c is called but during disable I don't see a
> > corresponding call to do_detach (...).  do_detach(...) is called in
> > the second enable SRIOV  sequence as a cleanup because it thinks that
> > the iommu is still attached which it shouldn't be (as far as I
> > understand).
> >
> > If the iommu reports that the device is being removed why isn't it
> > also detached??? Is this by design or an omission?
> 
> I don't know enough about the IOMMU code to understand this, but maybe the
> IOMMU experts I copied do.
> 
> > I see the following in dmesg when I do a disable, note the device is removed.
> >
> > [  131.674066] pci 0000:02:00.0: PME# disabled [  131.682191] iommu:
> > Removing device 0000:02:00.0 from group 2
> >
> > Stack trace of warn is shown below.
> >
> > [  368.510742] pci 0000:02:00.2: calling pci_fixup_video+0x0/0xb1 [
> > 368.510847] pci 0000:02:00.3: [1002:692f] type 00 class 0x030000 [
> > 368.510888] pci 0000:02:00.3: Max Payload Size set to 256 (was 128,
> > max 256) [  368.510907] pci 0000:02:00.3: calling
> > quirk_no_pm_reset+0x0/0x1a [  368.511005] vgaarb: device added:
> > PCI:0000:02:00.3,decodes=io+mem,owns=none,locks=none
> > [  368.511421] ------------[ cut here ]------------ [  368.511426]
> > WARNING: CPU: 1 PID: 3390 at drivers/pci/ats.c:85
> > pci_disable_ats+0x26/0xa4()
> 
> This warning is because dev->ats_enabled doesn't have the value we expect.  I
> think we only modify ats_enabled in two places.  Can you stick a dump_stack() at
> those two places?  Maybe a little more context will make this obvious.
> 

Yes, I only see the two places.
The dump_stack() doesn't help much other than tell me that dev->ats_enabled is never set to 0.  The code path never gets hit.

dev->ats_enabled is set to 1 when the VF is created but it is not set to 0 when the VF is destroyed.

The code path looks like detach_device (from amd_iommu.c) calls pci_disable_ats() which sets ats_enabled = 0.
>From the log trace detach_device() is not called when SRIOV is disabled, so when SRIOV is enabled again ats_enabled is still == 1. 

I am not sure where detach_device() should be called but my guess is that detach_device() should be somewhere in the disable SRIOV path.  I don't yet know enough about the iommu code.

> Bjorn
