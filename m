Return-Path: <SRS0=KZ3s=5E=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=KZ3s=5E=redhat.com=alex.williamson@kernel.org>
Date: Tue, 30 May 2017 11:32:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jon Masters <jcm@jonmasters.org>
Cc: David Daney <ddaney@caviumnetworks.com>, Bjorn Helgaas
 <helgaas@kernel.org>, David Daney <david.daney@cavium.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, Jon Masters
 <jcm@redhat.com>, Robert Richter <robert.richter@cavium.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] PCI: Workaround for bus reset on Cavium cn8xxx root
 ports
Message-ID: <20170530113212.0178852a@w520.home>
In-Reply-To: <508c694b-ccce-e491-b9b3-9f8839e28b04@jonmasters.org>
References: <20170516001736.4001-1-david.daney@cavium.com>
	<20170523204750.GC15055@bhelgaas-glaptop.roam.corp.google.com>
	<20170523150404.221b01c7@w520.home>
	<14ebfcd3-3f04-4dde-629a-cb2fc3843e39@caviumnetworks.com>
	<20170523161524.565357ea@w520.home>
	<508c694b-ccce-e491-b9b3-9f8839e28b04@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 29 May 2017 23:30:52 -0400
Jon Masters <jcm@jonmasters.org> wrote:

> Following up on this thread...
> 
> On 05/23/2017 06:15 PM, Alex Williamson wrote:
> > On Tue, 23 May 2017 14:22:01 -0700
> > David Daney <ddaney@caviumnetworks.com> wrote:
> >   
> >> On 05/23/2017 02:04 PM, Alex Williamson wrote:  
> >>> On Tue, 23 May 2017 15:47:50 -0500
> >>> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>     
> >>>> On Mon, May 15, 2017 at 05:17:34PM -0700, David Daney wrote:    
> >>>>> With the recent improvements in arm64 and vfio-pci, we are seeing
> >>>>> failures like this (on cn8890 based systems):
> >>>>>
> >>>>> [  235.622361] Unhandled fault: synchronous external abort (0x96000210) at 0xfffffc00c1000100
> >>>>> [  235.630625] Internal error: : 96000210 [#1] PREEMPT SMP
> >>>>> .
> >>>>> .
> >>>>> .
> >>>>> [  236.208820] [<fffffc0008411250>] pci_generic_config_read+0x38/0x9c
> >>>>> [  236.214992] [<fffffc0008435ed4>] thunder_pem_config_read+0x54/0x1e8
> >>>>> [  236.221250] [<fffffc0008411620>] pci_bus_read_config_dword+0x74/0xa0
> >>>>> [  236.227596] [<fffffc000841853c>] pci_find_next_ext_capability.part.15+0x40/0xb8
> >>>>> [  236.234896] [<fffffc0008419428>] pci_find_ext_capability+0x20/0x30
> >>>>> [  236.241068] [<fffffc0008423e2c>] pci_restore_vc_state+0x34/0x88
> >>>>> [  236.246979] [<fffffc000841af3c>] pci_restore_state.part.37+0x2c/0x1fc
> >>>>> [  236.253410] [<fffffc000841b174>] pci_dev_restore+0x4c/0x50
> >>>>> [  236.258887] [<fffffc000841b19c>] pci_bus_restore+0x24/0x4c
> >>>>> [  236.264362] [<fffffc000841c2dc>] pci_try_reset_bus+0x7c/0xa0
> >>>>> [  236.270021] [<fffffc00060a1ab0>] vfio_pci_ioctl+0xc34/0xc3c [vfio_pci]
> >>>>> [  236.276547] [<fffffc0005eb0410>] vfio_device_fops_unl_ioctl+0x20/0x30 [vfio]
> >>>>> [  236.283587] [<fffffc000824b314>] do_vfs_ioctl+0xac/0x744
> >>>>> [  236.288890] [<fffffc000824ba30>] SyS_ioctl+0x84/0x98
> >>>>> [  236.293846] [<fffffc0008082ca0>] __sys_trace_return+0x0/0x4
> >>>>>
> >>>>> These are caused by the inability of the PCIe root port and Intel
> >>>>> e1000e to sucessfully do a bus reset.  
> 
> Right now, we have a whole bunch of systems in our labs and across the
> industry where people are testing VFIO on Cavium ThunderX platforms. It
> is amazing how many people have e1000 cards lying around (this is even
> more popular on ARM servers because things like Tianocore usually "just
> work" with an e1000 card installed...). I know I have many more e1000s
> than I do x86 systems. So we need a solution to not crash on use.
> 
> >>>>> The proposed fix is to not do a bus reset on these systems.  
> 
> It's not the best solution, but it's a solution, and there are plenty of
> other quirks. I would like to see us figure out a sensible path to
> perhaps take this patch now and continue researching to determine
> whether there's an even better option later.
> 
> The reasons I say this are:
> 
> 1). It will take some time for various teams with protocol analyzers to
> determine which end is not fully spec compliant, while in the interim
> everyone has to carry this patch or some other nasty hack anyway.
> 
> 2). I have an even worse patch in my test kernels (just disable reset
> for every device, which is nasty) and I'm sure I'm not alone. It would
> be better (IMO) to confine the lack of reset to a subset of devices.
> 
> <snip>
> 
> > My hope would be that such analysis would help us understand what's
> > really happening and perhaps present a less drastic workaround.  Is the
> > point at which we crash simply the first read from the device?  Is the
> > link state shown as stable at this point?  Is there any chance that we
> > have a timing issue and an additional delay could resolve it?  Is there
> > some manipulation of the link state before or after the bus reset that
> > produces different results?  If such options have been exhausted, then
> > I guess I have no objection, or at least no better solution, and I'll
> > keep an eye out for any fallout.  Thanks,  
> 
> My understanding is that various teams have already spent man months of
> time with protocol analyzer equipment trying to figure out who is at
> "fault". I have no reason not to believe that they don't intend to
> continue that work, since they certainly want to ensure future root port
> implementations are event more robust in the presence of both fully
> compliant, and also somewhat compliant endpoints. If David affirms that
> the work will continue, can we take this for now?

I'd feel slightly more inclined to agree on that course if we gave
hardware vendors some incentive to resolve the problem and users some
indication that a problem exists, by adding a dev_warn when we apply
PCI_DEV_FLAGS_NO_BUS_RESET to the device.  I'd also entertain the idea
of only printing a warning when an affected devices is opened by the
user through vfio.  Thanks,

Alex
