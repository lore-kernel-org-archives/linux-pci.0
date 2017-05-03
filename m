Return-Path: <SRS0=n/qv=4J=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=n/qv=4J=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 3 May 2017 16:06:35 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, xen-devel@lists.xenproject.org,
	Dan Streetman <dan.streetman@canonical.com>,
	Dan Streetman <ddstreet@ieee.org>
Subject: Re: [Xen-devel] [PATCH] xen: do not re-use pirq number cached in pci
 device msi msg data
Message-ID: <20170503230635.GB11256@kroah.com>
References: <20170113200751.20125-1-ddstreet@ieee.org>
 <20170113223035.GE23066@char.us.oracle.com>
 <CALZtONDL2Ph0MMMfSuqvofNZ-+6jPi9aKsE4mL30i15Up6Bvug@mail.gmail.com>
 <0c2b4d6a-93e7-90a2-ffaf-fa423fb022d5@suse.com>
 <72f8b025-e858-5e54-d900-50fbec46fea6@oracle.com>
 <20170222142810.GA28359@bhelgaas-glaptop.roam.corp.google.com>
 <3379a82f-04b7-152a-1577-bf99b1c638cc@oracle.com>
 <1493835543.4904.5.camel@infradead.org>
 <1b84c2a5-1fd6-02b9-c080-0f99f6a8d085@oracle.com>
 <alpine.DEB.2.10.1705031540140.9240@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1705031540140.9240@sstabellini-ThinkPad-X260>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 03, 2017 at 03:59:15PM -0700, Stefano Stabellini wrote:
> On Wed, 3 May 2017, Boris Ostrovsky wrote:
> > On 05/03/2017 02:19 PM, David Woodhouse wrote:
> > > On Wed, 2017-02-22 at 10:14 -0500, Boris Ostrovsky wrote:
> > >> On 02/22/2017 09:28 AM, Bjorn Helgaas wrote:
> > >>> On Tue, Feb 21, 2017 at 10:58:39AM -0500, Boris Ostrovsky wrote:
> > >>>> On 02/21/2017 10:45 AM, Juergen Gross wrote:
> > >>>>> On 21/02/17 16:31, Dan Streetman wrote:
> > >>>>>> On Fri, Jan 13, 2017 at 5:30 PM, Konrad Rzeszutek Wilk
> > >>>>>> <konrad.wilk@oracle.com> wrote:
> > >>>>>>> On Fri, Jan 13, 2017 at 03:07:51PM -0500, Dan Streetman wrote:
> > >>>>>>>> Revert the main part of commit:
> > >>>>>>>> af42b8d12f8a ("xen: fix MSI setup and teardown for PV on HVM guests")
> > >>>>>>>>
> > >>>>>>>> That commit introduced reading the pci device's msi message data to see
> > >>>>>>>> if a pirq was previously configured for the device's msi/msix, and re-use
> > >>>>>>>> that pirq.  At the time, that was the correct behavior.  However, a
> > >>>>>>>> later change to Qemu caused it to call into the Xen hypervisor to unmap
> > >>>>>>>> all pirqs for a pci device, when the pci device disables its MSI/MSIX
> > >>>>>>>> vectors; specifically the Qemu commit:
> > >>>>>>>> c976437c7dba9c7444fb41df45468968aaa326ad
> > >>>>>>>> ("qemu-xen: free all the pirqs for msi/msix when driver unload")
> > >>>>>>>>
> > >>>>>>>> Once Qemu added this pirq unmapping, it was no longer correct for the
> > >>>>>>>> kernel to re-use the pirq number cached in the pci device msi message
> > >>>>>>>> data.  All Qemu releases since 2.1.0 contain the patch that unmaps the
> > >>>>>>>> pirqs when the pci device disables its MSI/MSIX vectors.
> > >>>>>>>>
> > >>>>>>>> This bug is causing failures to initialize multiple NVMe controllers
> > >>>>>>>> under Xen, because the NVMe driver sets up a single MSIX vector for
> > >>>>>>>> each controller (concurrently), and then after using that to talk to
> > >>>>>>>> the controller for some configuration data, it disables the single MSIX
> > >>>>>>>> vector and re-configures all the MSIX vectors it needs.  So the MSIX
> > >>>>>>>> setup code tries to re-use the cached pirq from the first vector
> > >>>>>>>> for each controller, but the hypervisor has already given away that
> > >>>>>>>> pirq to another controller, and its initialization fails.
> > >>>>>>>>
> > >>>>>>>> This is discussed in more detail at:
> > >>>>>>>> https://lists.xen.org/archives/html/xen-devel/2017-01/msg00447.html
> > >>>>>>>>
> > >>>>>>>> Fixes: af42b8d12f8a ("xen: fix MSI setup and teardown for PV on HVM guests")
> > >>>>>>>> Signed-off-by: Dan Streetman <dan.streetman@canonical.com>
> > >>>>>>> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > >>>>>> This doesn't seem to be applied yet, is it still waiting on another
> > >>>>>> ack?  Or maybe I'm looking at the wrong git tree...
> > >>>>> Am I wrong or shouldn't this go through the PCI tree? Konrad?
> > >>>> Konrad is away this week but since pull request for Xen tree just went
> > >>>> out we should probably wait until rc1 anyway (unless something big comes
> > >>>> up before that).
> > >>> I assume this should go via the Xen or x86 tree, since that's how most
> > >>> arch/x86/pci/xen.c patches have been handled, including af42b8d12f8a.
> > >>> If you think otherwise, let me know.
> > >> OK, I applied it to Xen tree's for-linus-4.11.
> > > Hm, we want this (c74fd80f2f4) in stable too, don't we?
> > 
> > 
> > Maybe.
> > 
> > Per https://lists.xen.org/archives/html/xen-devel/2017-01/msg00987.html
> > it may break things on older (4.4-) hypervisors. They are out of
> > support, which is why this patch went in now but I am not sure this
> > automatically applies to stable kernels.
> > 
> > Stefano?
> 
> This is a difficult call. We could just say that all the broken Xen
> versions are out of support, so let's fix all the Linux kernel stable
> trees that we can.
> 
> Or we could give a look at the release dates. Linux 3.18 is still
> maintained and was tagged on Dec 7 2014.

Don't do anything "special" for 3.18 if you have to.  I'm only
semi-maintaining it because some SoC vendors never upstreamed their
trees and lots of devices rely on it.  None of them use Xen on their
platforms, so no need for me to backport any change there.

thanks,

greg k-h
