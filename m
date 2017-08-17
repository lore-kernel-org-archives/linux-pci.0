Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753124AbdHQQsI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Aug 2017 12:48:08 -0400
Date: Thu, 17 Aug 2017 11:48:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "liudongdong (C)" <liudongdong3@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Chenxin (Charles)" <charles.chenxin@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] PCIe AER: report non fatal errors only to the functions
 of the same device
Message-ID: <20170817164806.GH28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1501813106-89672-1-git-send-email-liudongdong3@huawei.com>
 <20170815225007.GS32525@bhelgaas-glaptop.roam.corp.google.com>
 <025ad3e8-7411-6e97-29ba-6e5cfa7665eb@huawei.com>
 <20170816140744.GW32525@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40BC1D5B@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40BC1D5B@FRAEML521-MBX.china.huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 17, 2017 at 01:06:32PM +0000, Gabriele Paoloni wrote:
> Hi Bjorn
> 
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: 16 August 2017 15:08
> > To: liudongdong (C)
> > Cc: linux-pci@vger.kernel.org; Gabriele Paoloni; Chenxin (Charles);
> > Linuxarm
> > Subject: Re: [PATCH] PCIe AER: report non fatal errors only to the
> > functions of the same device
> > 
> > On Wed, Aug 16, 2017 at 04:50:16PM +0800, Dongdong Liu wrote:
> > > Hi Bjorn
> > >
> > > 在 2017/8/16 6:50, Bjorn Helgaas 写道:
> > > >On Fri, Aug 04, 2017 at 10:18:26AM +0800, Dongdong Liu wrote:
> > > >>From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > > >>
> > > >>Currently if an uncorrectable error is reported by an EP the AER
> > > >>driver walks over all the devices connected to the upstream port
> > > >>bus and in turns call the report_error_detected() callback.
> > > >>If any of the devices connected to the bus does not implement
> > > >>dev->driver->err_handler->error_detected() do_recovery() will fail.
> > > >>
> > > >>However for non fatal errors the PCIe link should not be considered
> > > >>compromised, therefore it makes sense to report the error only to
> > > >>all the functions of a multifunction device.
> > > >>This patch implements this new behaviour for non fatal errors.
> > > >
> > > >Why do we bother even with other functions in the same multifunction
> > > >device?  PCIe r3.1, sec 6.2.2.2.2, says non-fatal errors only affect
> > a
> > > >particular transaction, and "devices not associated with the
> > > >transaction in error are not impacted."
> > > >
> > > >A transaction is only associated with one function, so other
> > functions
> > > >in the same device shouldn't be affected, should they?
> > >
> > > PCIe r3.1, sec 6.2.4 Error Logging
> > > PCI Express errors are not Function-specific.  "Software is
> > > responsible for scanning all Functions in a multi-Function device
> > > when it detects one of those errors"
> > 
> > The previous text basically says that if a multi-function device
> > should generate at most one error reporting message, even if several
> > functions have logged an error of the same severity.  I think that
> > single message corresponds to a single interrupt.
> > 
> > So when it says "software is responsible for scanning all Functions in
> > a multi-Function device," I think the point is that software should
> > read the error reporting registers of all functions in case several of
> > them have logged errors.
> 
> Right, looking again at the AER core it seems that find_source_device()
> would look for the error sources by walking the PCIe hierarchy starting
> from the RP that reported the error (however from AER_MAX_MULTI_ERR_DEVICES
> max 5 devices can log an error on a single AER interrupt...).
> 
> Anyway as it is now, and assuming that we have no more than 5 functions
> in a multi-function device, AER core should call handle_error_source()
> for each function that logged an error, right?
> 
> > 
> > But IIUC, this patch has nothing to do with reading the error CSRs
> > (which should be done in the PCI/AER core).  This patch merely changes
> > the set of devices for which we call the driver's error reporting
> > interfaces.
> 
> Correct. From our point of view if a fatal AER is reported by a function
> then we need to call the driver callbacks also on all the function under
> the same bus as the reporting device (as the link is compromised).
> 
> We thought that for non-fatal errors this is not necessary as the bus 
> link should not be considered compromised, but we thought that for MF
> devices maybe it would have been appropriate to call the driver callbacks
> on the other functions of the same device. However after your consideration
> above and after double checking the AER core it seems that also this is
> not necessary (in fact for a MF device handle_error_source() will be called
> for each function that logged the error)
> 
> > 
> > If this is fixing a problem, maybe it would help clarify things if you
> > could include the concrete details of what's going wrong.
> 
> In Hi1620 we have some integrated controllers that appear as PCIe EPs
> under the same bus. Some of these controllers (e.g. the SATA 
> controller) are missing the err_handler callbacks.
> 
> If one device reports a non-fatal uncorrectable error with the current
> AER core code the callbacks for all the devices under the same bus will
> be called and, if any of the devices is missing the callback all the
> devices in the subtree are left in error state without recovery... 
> This patch is needed to sort out a situation like this one.
> 
> Anyway I think that after the considerations above on the MF device
> I can modify this patch to just call the callback for the reporting
> function...?

Sounds like a reasonable approach.  I'll compare the patch with the
spec in more detail when you post it.
