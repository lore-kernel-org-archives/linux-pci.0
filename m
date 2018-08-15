Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727408AbeHPAuB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2018 20:50:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FLsSpV116045
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2018 17:55:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kvv500n9h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2018 17:55:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
        Wed, 15 Aug 2018 22:55:57 +0100
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: poza@codeaurora.org, Thomas Tai <thomas.tai@oracle.com>
Cc: bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
Date: Thu, 16 Aug 2018 07:55:48 +1000
In-Reply-To: <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
         <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
         <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
         <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
Mime-Version: 1.0
Message-Id: <1c844f2fff88379a2ccc84a1c2ddc2a61dfa036f.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-08-14 at 14:52 +0530, poza@codeaurora.org wrote:
> > >       if (result == PCI_ERS_RESULT_RECOVERED) {
> > >               if (pcie_wait_for_link(udev, true))
> > >                       pci_rescan_bus(udev->bus);
> > > -            pci_info(dev, "Device recovery from fatal error successful\n");
> > > +            /* find the pci_dev after rescanning the bus */
> > > +            dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> > 
> > one of the motivations was to remove and re-enumerate rather then
> > going thorugh driver's recovery sequence
> > was; it might be possible that hotplug capable bridge, the device
> > might have changed.
> > hence this check will fail

Under what circumstances do you actually "unplug" the device ? We are
trying to cleanup/fix some of the PowerPC EEH code which is in a way
similar to AER, and we found that this unplug/replug, which we do if
the driver doesn't have recovery callbacks only, is causing more
problems than it solves.

We are moving toward instead unbinding the driver, resetting the
device, then re-binding the driver instead of unplug/replug.

Also why would you ever bypass the driver callbacks if the driver has
some ? The whole point is to keep the driver bound while resetting the
device (provided it has the right callbacks) so we don't lose the
linkage between stroage devices and mounted filesystems.

Cheers,
Ben.
