Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Apr 2018 08:27:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
Message-ID: <20180416132753.GA28657@bhelgaas-glaptop.roam.corp.google.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
 <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
 <9301606a70a213c180d9e6764b002cf9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9301606a70a213c180d9e6764b002cf9@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:33:13AM +0530, poza@codeaurora.org wrote:
> On 2018-04-16 09:23, Sinan Kaya wrote:
> > On 4/15/2018 11:16 PM, Bjorn Helgaas wrote:
> > > On Mon, Apr 09, 2018 at 10:41:48AM -0400, Oza Pawandeep wrote:
> > > > This patch set brings in error handling support for DPC
> > > > 
> > > > The current implementation of AER and error message broadcasting
> > > > to the
> > > > EP driver is tightly coupled and limited to AER service driver.
> > > > It is important to factor out broadcasting and other link handling
> > > > callbacks. So that not only when AER gets triggered, but also
> > > > when DPC get
> > > > triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> > > > 
> > > > DPC should behave identical to AER as far as error handling is
> > > > concerned.
> > > > DPC should remove the devices and not to do recovery for hotplug
> > > > enabled system.
> > > 
> > > Is there a specific bug that's fixed by these patches?  I didn't see
> > > one mentioned in the changelogs.
> > > 
> > 
> > There is no actual bug.
> > 
> > We realized that DPC and hotplug is heavily integrated today. We
> > have use cases for systems without hotplug support but still
> > support DPC. That's the problem we are trying to solve with this
> > patchset.

Apparently there's a problem with systems that have DPC but not
hotplug.  It will be extremely helpful if you can articulate what that
problem is and include it in the appropriate changelog.

> Adding to what Sinan said;
> 
> DPC should handle the error handling and recovery similar to AER,
> because finally both are attempting recovery in some or the other
> way, and for that error handling and recovery framework has to be
> loosely coupled.  It achieves uniformity and transparency to the
> error handling agents such as AER, DPC, with respect to recovery and
> error handling.
> 
> So, this patch-set tries to unify lot of things between error agents
> and make them behave in a well defined way. (be it error (FATAL,
> NON_FATAL) handling or recovery).

I totally support this objective.

Bjorn
