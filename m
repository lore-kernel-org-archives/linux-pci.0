Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Marsan, Luugi" <Luugi.Marsan@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: RE: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV
 on AMD GPU
Date: Wed, 24 Feb 2016 18:29:56 +0000
Message-ID: <CY1PR12MB02629490AFFE29BACB197EA6FEA50@CY1PR12MB0262.namprd12.prod.outlook.com>
References: <CY1PR12MB0262D12DAC0897F8DC74541CFEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
 <20160223170215.GA25203@localhost>
 <CY1PR12MB0262E17EF294E8A1F23D8CB2FEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
In-Reply-To: <CY1PR12MB0262E17EF294E8A1F23D8CB2FEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Zytaruk, Kelly
> Sent: Tuesday, February 23, 2016 12:47 PM
> To: Bjorn Helgaas
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; Marsan, Luugi; Joerg Roedel; Alex Williamson
> Subject: RE: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV
> on AMD GPU
> 
> 
> 
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Tuesday, February 23, 2016 12:02 PM
> > To: Zytaruk, Kelly
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > bhelgaas@google.com; Marsan, Luugi; Joerg Roedel; Alex Williamson
> > Subject: Re: BUGZILLA [112941] - Cannot reenable SRIOV after disabling
> > SRIOV on AMD GPU
> >
> > [+cc Joerg, Alex]
> >
> > Hi Kelly,
> >
> > On Tue, Feb 23, 2016 at 03:52:13PM +0000, Zytaruk, Kelly wrote:
> > > As per our offline discussions I have created Bugzilla #112941 for
> > > the SRIOV issue.
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=112941
> >
> > > When trying to enable SRIOV on AMD GPU after doing a previous enable
> > > / disable sequence the following warning is shown in dmesg.  I
> > > suspect that there might be something missing from the cleanup on the
> disable.
> > >
> > > I had a quick look at the code and it is checking for something in
> > > the iommu, something to do with being attached to a domain.  I am
> > > not familiar with this code yet (what does it mean to be attached to
> > > a
> > > domain?) so it might take a little while before I can get the time
> > > to check it out and understand it.
> > >
> > > From a quick glance I notice that during SRIOV enable the function
> > > do_attach()  in amd_iommu.c is called but during disable I don't see
> > > a corresponding call to do_detach (...).  do_detach(...) is called
> > > in the second enable SRIOV  sequence as a cleanup because it thinks
> > > that the iommu is still attached which it shouldn't be (as far as I
> > > understand).
> > >
> > > If the iommu reports that the device is being removed why isn't it
> > > also detached??? Is this by design or an omission?
> >
> > I don't know enough about the IOMMU code to understand this, but maybe
> > the IOMMU experts I copied do.
> >
> > > I see the following in dmesg when I do a disable, note the device is removed.
> > >
> > > [  131.674066] pci 0000:02:00.0: PME# disabled [  131.682191] iommu:
> > > Removing device 0000:02:00.0 from group 2
> > >
> > > Stack trace of warn is shown below.
> > >
> > > [  368.510742] pci 0000:02:00.2: calling pci_fixup_video+0x0/0xb1 [
> > > 368.510847] pci 0000:02:00.3: [1002:692f] type 00 class 0x030000 [
> > > 368.510888] pci 0000:02:00.3: Max Payload Size set to 256 (was 128,
> > > max 256) [  368.510907] pci 0000:02:00.3: calling
> > > quirk_no_pm_reset+0x0/0x1a [  368.511005] vgaarb: device added:
> > > PCI:0000:02:00.3,decodes=io+mem,owns=none,locks=none
> > > [  368.511421] ------------[ cut here ]------------ [  368.511426]
> > > WARNING: CPU: 1 PID: 3390 at drivers/pci/ats.c:85
> > > pci_disable_ats+0x26/0xa4()
> >
> > This warning is because dev->ats_enabled doesn't have the value we
> > expect.  I think we only modify ats_enabled in two places.  Can you
> > stick a dump_stack() at those two places?  Maybe a little more context will
> make this obvious.
> >
> 
> Yes, I only see the two places.
> The dump_stack() doesn't help much other than tell me that dev->ats_enabled is
> never set to 0.  The code path never gets hit.
> 
> dev->ats_enabled is set to 1 when the VF is created but it is not set to 0 when
> the VF is destroyed.
> 
> The code path looks like detach_device (from amd_iommu.c) calls
> pci_disable_ats() which sets ats_enabled = 0.
> From the log trace detach_device() is not called when SRIOV is disabled, so when
> SRIOV is enabled again ats_enabled is still == 1.
> 
> I am not sure where detach_device() should be called but my guess is that
> detach_device() should be somewhere in the disable SRIOV path.  I don't yet
> know enough about the iommu code.

I have made some progress on this and it is related in part to the asymmetrical nature of the iommu attach/detach calls.
There are three code flows that need to be examined and I have summarized them below.

The iommu attach code flows as follows;
.attach_dev = amd_iommu_attach_device
    --> amd_iommu_attach_device
        --> get dev_data from dev.archdata.iommu
               If dev_data->domain != NULL  --> detach_device()   <-- the WARNING is coming from this code path.
               attach_device ()

The iommu detach code path flows as follows;
.detach_dev = amd_iommu_detach_device
    --> amd_iommu_detach_device 
        --> detach_device()
            -->  __detach_device()
                --> do_detach()
                    --> set dev_data->domain = NULL;
            --> pci_disable_ats()    <-- expects ats_enabled == 1 on entry
                --> Set ats_enabled = 0

And finally when pci_enable_sriov() is called the following flow is important;
--> virtfn_add()    <-- allocates a new virtual function device
    --> pci_device_add()
        --> iommu_init_device()
            --> find_dev_data()

Now here is the problem.  
When pci_enable_sriov is called for the first time, amd_iommu_attach_device() gets called and it adds dev->archdata.iommu to its dev_data list (stored by device_id which looks like it is related to BDF) . Remember that the value of dev_data->domain is saved here.

When pci_disable_sriov is called, amd_iommu_detach_device is NOT called.  The dev_data for the device is still on the iommu dev_data list even though the device has been destroyed.

When pci_enable_sriov() is called for the second time it creates new dev's for the virtual functions BUT the dev_data for the dev (identified by device_id) still remains in the iommu dev_data list. 

Iommu_init_device() searches the dev_data list to see if a dev_data already exists for this dev. It erroneously finds one.  When amd_iommu_attach_device() is ultimately called it uses the dev_data from the previous dev and sees that dev_data->domain != NULL.  This causes the call to detach_device() which eventually calls pci_disable_ats().  BUT this is a new dev and ats is not enabled yet and the ats_enabled flag == 0.  Hence the WARNING and bug.

I have done the triage but I am not sure where the fix should be.  I quite accidentally found the following somewhat related thread at http://www.gossamer-threads.com/lists/linux/kernel/2225731.  It seems that he is having a similar problem but on a different platform.

I don't know if the asynchronous nature of the iommu attach/detach is by design or if it is broken somewhere up the tree and just not working in my case.  Maybe one of the iommu owners could answer this.


> 
> > Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the body of
> a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
