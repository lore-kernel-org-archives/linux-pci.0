Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50205 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387713AbeHPJsS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 05:48:18 -0400
Message-ID: <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: poza@codeaurora.org
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Date: Thu, 16 Aug 2018 16:51:43 +1000
In-Reply-To: <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
         <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
         <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
         <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
         <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
         <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-16 at 12:06 +0530, poza@codeaurora.org wrote:
> 
> > Under what circumstances do you actually "unplug" the device ? We are
> > trying to cleanup/fix some of the PowerPC EEH code which is in a way
> > similar to AER, and we found that this unplug/replug, which we do if
> > the driver doesn't have recovery callbacks only, is causing more
> > problems than it solves.
> > 
> > We are moving toward instead unbinding the driver, resetting the
> > device, then re-binding the driver instead of unplug/replug.
> > 
> > Also why would you ever bypass the driver callbacks if the driver has
> > some ? The whole point is to keep the driver bound while resetting the
> > device (provided it has the right callbacks) so we don't lose the
> > linkage between stroage devices and mounted filesystems.
> > 
> 
> there are two different paths we are taking, one is for ERR_FATAL and 
> the other is for ERR_NONFATAL.

Ok. With EEH we have a much finer granularity but fundamentally we
don't care as long as we reset the device.

> while AER and DPC converge into ERR_FATAL path; ERR_NONFATAL path is the 
> one where AER and driver callbacks would come into picture.

I disagree. See below.

> since DPC does hw recovery of the link, and handles only ERR_FATAL, we 
> do remove devices and re-enumerate them.

What is "DPC" ?

> but if the error is no fatal, we will fall back to driver callbacks to 
> initiate link error handling and recovery process.

Hrm ... the callbacks were never about link errors, they were about
device errors of any kind and predate PCIe concept of links in fact.

They include iommu errors, HW errors, SW bugs etc...

> under normal circumstances I do not see the some downstream devices 
> would have been replaced in case of FATAL errors, but code might not 
> want to assume that
> same device is there, since we are removing downstream devices 
> completely. so taking reference of old BDF and keeping it for later 
> reference is not good idea.
> although I think there are some parts of pcie_do_fatal_recovery need a 
> fix, which Thomas is fixing is anyway.

I think you shouldn't be unplugging/replugging.

> so yes, I agree with you and we are talking about same thing e.g.
> "
>   We are moving toward instead unbinding the driver, resetting the
>   device, then re-binding the driver instead of unplug/replug.
> "
> 
> driver callbacks are very much there, please have a look at 
> pcie_do_nonfatal_recovery().

Even for fatal. Why on earth would you skip the driver callbacks ? Most
errors are fatal anyway.

For us, we don't really differenciate because in order to avoid any
form of propagation of bad data, our HW will freeze/isolate a device on
any error, whether it's fatal or non fatal.

So we treat them both as needing a full recovery which usually implies
a reset of the device.

However we do that through the use of the driver callbacks because
otherwise you will lose the linkage between a storage driver and the
moutned file systems which cannot be recovered, so you are killing your
system.

> refering Sepc: 6.2.2.2.1 Fatal Errors, where link is unreliable and it 
> might need AER style reset of link or DPC style HW recovery
> In both cases, the shutdown callbacks are expected to be called,

No, this is wrong and not the intent of the error handling.

You seem to be applying PCIe specific concepts brain-farted at Intel
that are way way away from what we care about in practice and in Linux.

> e.g.  some driver handle errors ERR_NONFATAL or FATAL in similar ways
> e.g.
> ioat_pcie_error_detected();  calls  ioat_shutdown(); in case of 
> ERR_NONFATAL
> otherwise ioat_shutdown() in case of ERR_FATAL.

Since when the error handling callbacks even have the concept of FATAL
vs. non-fatal ? This doesn't appear anyhwhere in the prototype of the
struct pci_error_handlers and shouldn't.

Benm=.

> 
> > Cheers,
> > Ben.
