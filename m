Return-Path: <SRS0=YPu5=HB=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=YPu5=HB=intel.com=keith.busch@kernel.org>
Date: Thu, 12 Apr 2018 09:02:31 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180412150231.GD4810@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412143954.GB4810@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2018 at 08:39:54AM -0600, Keith Busch wrote:
> On Thu, Apr 12, 2018 at 10:34:37AM -0400, Sinan Kaya wrote:
> > On 4/12/2018 10:06 AM, Bjorn Helgaas wrote:
> > > 
> > > I think the scenario you are describing is two systems that are
> > > identical except that in the first, the endpoint is below a hotplug
> > > bridge, while in the second, it's below a non-hotplug bridge.  There's
> > > no physical hotplug (no drive removed or inserted), and DPC is
> > > triggered in both systems.
> > > 
> > > I suggest that DPC should be handled identically in both systems:
> > > 
> > >   - The PCI core should have the same view of the endpoint: it should
> > >     be removed and re-added in both cases (or in neither case).
> > > 
> > >   - The endpoint itself should not be able to tell the difference: it
> > >     should see a link down event, followed by a link retrain, followed
> > >     by the same sequence of config accesses, etc.
> > > 
> > >   - The endpoint driver should not be able to tell the difference,
> > >     i.e., we should be calling the same pci_error_handlers callbacks
> > >     in both cases.
> > > 
> > > It's true that in the non-hotplug system, pciehp probably won't start
> > > re-enumeration, so we might need an alternate path to trigger that.
> > > 
> > > But that's not what we're doing in this patch.  In this patch we're
> > > adding a much bigger difference: for hotplug bridges, we stop and
> > > remove the hierarchy below the bridge; for non-hotplug bridges, we do
> > > the AER-style flow of calling pci_error_handlers callbacks.
> > 
> > Our approach on V12 was to go to AER style recovery for all DPC events
> > regardless of hotplug support or not. 
> > 
> > Keith was not comfortable with this approach. That's why, we special cased
> > hotplug.
> > 
> > If we drop 6/6 on this patch on v13, we achieve this. We still have to
> > take care of Keith's inputs on individual patches.
> > 
> > we have been struggling with the direction for a while.
> > 
> > Keith, what do you think?
> 
> My only concern was for existing production environments that use DPC
> for handling surprise removal, and I don't wish to break the existing
> uses.

Also, I thought the plan was to keep hotplug and non-hotplug the same,
except for the very end: if not a hotplug bridge, initiate the rescan
automatically after releasing from containment, otherwise let pciehp
handle it when the link reactivates.
