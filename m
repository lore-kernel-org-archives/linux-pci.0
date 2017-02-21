Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47053 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdBUP5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2017 10:57:35 -0500
Subject: Re: [PATCH] xen: do not re-use pirq number cached in pci device msi
 msg data
To: Juergen Gross <jgross@suse.com>, Dan Streetman <ddstreet@ieee.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <04f2a09f-59be-a720-bc98-4afb53171790@oracle.com>
 <20170113200751.20125-1-ddstreet@ieee.org>
 <20170113223035.GE23066@char.us.oracle.com>
 <CALZtONDL2Ph0MMMfSuqvofNZ-+6jPi9aKsE4mL30i15Up6Bvug@mail.gmail.com>
 <0c2b4d6a-93e7-90a2-ffaf-fa423fb022d5@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
        Dan Streetman <dan.streetman@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <72f8b025-e858-5e54-d900-50fbec46fea6@oracle.com>
Date: Tue, 21 Feb 2017 10:58:39 -0500
MIME-Version: 1.0
In-Reply-To: <0c2b4d6a-93e7-90a2-ffaf-fa423fb022d5@suse.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/21/2017 10:45 AM, Juergen Gross wrote:
> On 21/02/17 16:31, Dan Streetman wrote:
>> On Fri, Jan 13, 2017 at 5:30 PM, Konrad Rzeszutek Wilk
>> <konrad.wilk@oracle.com> wrote:
>>> On Fri, Jan 13, 2017 at 03:07:51PM -0500, Dan Streetman wrote:
>>>> Revert the main part of commit:
>>>> af42b8d12f8a ("xen: fix MSI setup and teardown for PV on HVM guests")
>>>>
>>>> That commit introduced reading the pci device's msi message data to see
>>>> if a pirq was previously configured for the device's msi/msix, and re-use
>>>> that pirq.  At the time, that was the correct behavior.  However, a
>>>> later change to Qemu caused it to call into the Xen hypervisor to unmap
>>>> all pirqs for a pci device, when the pci device disables its MSI/MSIX
>>>> vectors; specifically the Qemu commit:
>>>> c976437c7dba9c7444fb41df45468968aaa326ad
>>>> ("qemu-xen: free all the pirqs for msi/msix when driver unload")
>>>>
>>>> Once Qemu added this pirq unmapping, it was no longer correct for the
>>>> kernel to re-use the pirq number cached in the pci device msi message
>>>> data.  All Qemu releases since 2.1.0 contain the patch that unmaps the
>>>> pirqs when the pci device disables its MSI/MSIX vectors.
>>>>
>>>> This bug is causing failures to initialize multiple NVMe controllers
>>>> under Xen, because the NVMe driver sets up a single MSIX vector for
>>>> each controller (concurrently), and then after using that to talk to
>>>> the controller for some configuration data, it disables the single MSIX
>>>> vector and re-configures all the MSIX vectors it needs.  So the MSIX
>>>> setup code tries to re-use the cached pirq from the first vector
>>>> for each controller, but the hypervisor has already given away that
>>>> pirq to another controller, and its initialization fails.
>>>>
>>>> This is discussed in more detail at:
>>>> https://lists.xen.org/archives/html/xen-devel/2017-01/msg00447.html
>>>>
>>>> Fixes: af42b8d12f8a ("xen: fix MSI setup and teardown for PV on HVM guests")
>>>> Signed-off-by: Dan Streetman <dan.streetman@canonical.com>
>>> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> This doesn't seem to be applied yet, is it still waiting on another
>> ack?  Or maybe I'm looking at the wrong git tree...
> Am I wrong or shouldn't this go through the PCI tree? Konrad?

Konrad is away this week but since pull request for Xen tree just went
out we should probably wait until rc1 anyway (unless something big comes
up before that).

-boris
