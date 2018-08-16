Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeHPJcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2018 05:32:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 16 Aug 2018 12:06:36 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
Message-ID: <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-16 03:26, Benjamin Herrenschmidt wrote:
> (resent using my proper email address)
> 
> On Tue, 2018-08-14 at 14:52 +0530, poza@codeaurora.org wrote:
>> > >       if (result == PCI_ERS_RESULT_RECOVERED) {
>> > >               if (pcie_wait_for_link(udev, true))
>> > >                       pci_rescan_bus(udev->bus);
>> > > -            pci_info(dev, "Device recovery from fatal error successful\n");
>> > > +            /* find the pci_dev after rescanning the bus */
>> > > +            dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
>> >
>> > one of the motivations was to remove and re-enumerate rather then
>> > going thorugh driver's recovery sequence
>> > was; it might be possible that hotplug capable bridge, the device
>> > might have changed.
>> > hence this check will fail
> 
> Under what circumstances do you actually "unplug" the device ? We are
> trying to cleanup/fix some of the PowerPC EEH code which is in a way
> similar to AER, and we found that this unplug/replug, which we do if
> the driver doesn't have recovery callbacks only, is causing more
> problems than it solves.
> 
> We are moving toward instead unbinding the driver, resetting the
> device, then re-binding the driver instead of unplug/replug.
> 
> Also why would you ever bypass the driver callbacks if the driver has
> some ? The whole point is to keep the driver bound while resetting the
> device (provided it has the right callbacks) so we don't lose the
> linkage between stroage devices and mounted filesystems.
> 

there are two different paths we are taking, one is for ERR_FATAL and 
the other is for ERR_NONFATAL.
while AER and DPC converge into ERR_FATAL path; ERR_NONFATAL path is the 
one where AER and driver callbacks would come into picture.

since DPC does hw recovery of the link, and handles only ERR_FATAL, we 
do remove devices and re-enumerate them.
but if the error is no fatal, we will fall back to driver callbacks to 
initiate link error handling and recovery process.

under normal circumstances I do not see the some downstream devices 
would have been replaced in case of FATAL errors, but code might not 
want to assume that
same device is there, since we are removing downstream devices 
completely. so taking reference of old BDF and keeping it for later 
reference is not good idea.
although I think there are some parts of pcie_do_fatal_recovery need a 
fix, which Thomas is fixing is anyway.

so yes, I agree with you and we are talking about same thing e.g.
"
  We are moving toward instead unbinding the driver, resetting the
  device, then re-binding the driver instead of unplug/replug.
"

driver callbacks are very much there, please have a look at 
pcie_do_nonfatal_recovery().

refering Sepc: 6.2.2.2.1 Fatal Errors, where link is unreliable and it 
might need AER style reset of link or DPC style HW recovery
In both cases, the shutdown callbacks are expected to be called,
e.g.  some driver handle errors ERR_NONFATAL or FATAL in similar ways
e.g.
ioat_pcie_error_detected();  calls  ioat_shutdown(); in case of 
ERR_NONFATAL
otherwise ioat_shutdown() in case of ERR_FATAL.


> Cheers,
> Ben.
