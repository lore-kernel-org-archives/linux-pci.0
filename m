Return-Path: <SRS0=kucU=BF=gmail.com=richard.weiyang@kernel.org>
Return-Path: <SRS0=kucU=BF=gmail.com=richard.weiyang@kernel.org>
Date: Fri, 6 Oct 2017 09:11:00 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Govindarajulu Varadarajan <gvaradar@cisco.com>, benve@cisco.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jlbec@evilplan.org, hch@lst.de, Ingo Molnar <mingo@redhat.com>,
	peterz@infradead.org, okaya@codeaurora.org,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] PCI: AER: fix deadlock in do_recovery
Message-ID: <20171006011100.GA43201@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20170930054938.43271-1-gvaradar@cisco.com>
 <20171003211537.GH25517@bhelgaas-glaptop.roam.corp.google.com>
 <CADZGycacDiu8O6kzqyrXMFCtsj4Xm2Mb5r=EnEJBXE3p80iQaA@mail.gmail.com>
 <20171005184209.GV25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171005184209.GV25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 05, 2017 at 01:42:09PM -0500, Bjorn Helgaas wrote:
>On Thu, Oct 05, 2017 at 11:05:12PM +0800, Wei Yang wrote:
>> On Wed, Oct 4, 2017 at 5:15 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > [+cc Alex, Gavin, Wei]
>> >
>> > On Fri, Sep 29, 2017 at 10:49:38PM -0700, Govindarajulu Varadarajan wrote:
>> >> CPU0                                  CPU1
>> >> ---------------------------------------------------------------------
>> >> __driver_attach()
>> >> device_lock(&dev->mutex) <--- device mutex lock here
>> >> driver_probe_device()
>> >> pci_enable_sriov()
>> >> pci_iov_add_virtfn()
>> >> pci_device_add()
>> >>                                       aer_isr()               <--- pci aer error
>> >>                                       do_recovery()
>> >>                                       broadcast_error_message()
>> >>                                       pci_walk_bus()
>> >>                                       down_read(&pci_bus_sem) <--- rd sem
>> >> down_write(&pci_bus_sem) <-- stuck on wr sem
>> >>                                       report_error_detected()
>> >>                                       device_lock(&dev->mutex)<--- DEAD LOCK
>> >>
>> >> This can also happen when aer error occurs while pci_dev->sriov_config() is
>> >> called.
>> >>
>> >> This patch does a pci_bus_walk and adds all the devices to a list. After
>> >> unlocking (up_read) &pci_bus_sem, we go through the list and call
>> >> err_handler of the devices with devic_lock() held. This way, we dont try
>> >> to hold both locks at same time.
>> >
>> > I feel like we're working too hard to come up with an ad hoc solution
>> > for this lock ordering problem: the __driver_attach() path acquires
>> > the device lock, then the pci_bus_sem; the AER path acquires
>> > pci_bus_sem, then the device lock.
>> >
>> > To me, the pci_bus_sem, then device lock order seems natural.  The
>> > pci_bus_sem protects all the bus device lists, so it makes sense to
>> > hold it while iterating over those lists.  And if we're operating on
>> > one of those devices while we're iterating, it makes sense to acquire
>> > the device lock.
>> >
>> > The pci_enable_sriov() path is the one that feels strange to me.
>> > We're in a driver probe method, and, surprise!, brand-new devices show
>> > up and we basically ask the PCI core to enumerate them synchronously
>> > while still in the probe method.
>> >
>> > Is there some reason this enumeration has to be done synchronously?
>> > I wonder if we can get that piece out of the driver probe path, e.g.,
>> > by queuing up the pci_iov_add_virtfn() part to be done later, in a
>> > path where we're not holding a device lock?
>> >
>> 
>> Hi, Bjorn,
>> 
>> First let me catch up with the thread.
>> 
>> We have two locking sequence:
>> 1. pci_bus_sem -> device lock, which is natural
>> 2. device lock -> pci_bus_sem, which is not
>
>Right.  Or at least, that's my assertion :)  I could be convinced
>otherwise.
>
>> pci_enable_sriov() sits in class #2 and your suggestion is to move the
>> pci_iov_add_virtfn() to some queue which will avoid case #2.
>> 
>> If we want to implement your suggestion, one thing unclear to me is
>> how would we handle the error path? Add a notification for the
>> failure? This would be easy for the core kernel, while some big change
>> for those drivers.
>
>My suggestion was for discussion.  It's entirely possible it will turn
>out not to be feasible.
>
>We're only talking about errors from pci_iov_add_virtfn() here.  We
>can still return all the other existing errors from sriov_enable(),
>which the driver can see.  These errors seem more directly related to
>the PF itself.
>
>The pci_iov_add_virtfn() errors are enumeration-type errors (failure
>to add a bus, failure to read config space of a VF, etc.)  These
>feel more like PCI core issues to me.  The driver isn't going to be
>able to do anything about them.
>

Ideally, PF and VF has their own probe function and they don't interfere each
other. From this point of view, I agree these failures are not handled by
drivers.

While in the real implementation, I am not 100% for sure the PF driver
operates without the knowledge of enabled VFs.

>The end result would likely be that a VF is enabled in the hardware
>but not added as a PCI device.  The same errors can occur during
>boot-time or hotplug-time enumeration of non-SR-IOV devices.
>
>Are these sort of errors important to the PF driver?  If the PF driver
>can get along without them, maybe we can use the same strategy as when
>we enumerate all other devices, i.e., log something in dmesg and
>continue on without the device.
>

Besides the functionality, I have another concern on the behavior change.

Current behavior is the VFs will be enabled ALL or NONE, which we will add a
third condition PARTIAL.

For example, the sys admin wants to enable 5 VFs while leads to 3 enabled at
last.

Hmm, not a big deal, while need to inform the users.

>Bjorn

-- 
Wei Yang
Help you, Help me
