Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 21 Aug 2017 15:23:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v11 2/4] PCI: Factor out pci_bus_wait_crs()
Message-ID: <20170821202338.GD28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170818213210.15145.15340.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <9cb3006d-31d0-e57a-fd3e-c32914e8ba42@codeaurora.org>
 <20170821191806.GC28977@bhelgaas-glaptop.roam.corp.google.com>
 <eca38319-9e78-1a9c-b275-43944fd0a63d@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <eca38319-9e78-1a9c-b275-43944fd0a63d@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 21, 2017 at 03:37:06PM -0400, Sinan Kaya wrote:
> On 8/21/2017 3:18 PM, Bjorn Helgaas wrote:
> ...
> if (pci_bus_crs_pending(id))
> 	return pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
> 
> > I think that makes sense.  We'd want to check for CRS SV being
> > enabled, e.g., maybe read PCI_EXP_RTCTL_CRSSVE back in
> > pci_enable_crs() and cache it somewhere.  Maybe a crs_sv_enabled bit
> > in the root port's pci_dev, and check it with something like what
> > pcie_root_rcb_set() does?
> > 
> 
> You can observe CRS under the following conditions
> 
> 1. root port <-> endpoint 
> 2. bridge <-> endpoint 
> 3. root port<->bridge
> 
> I was relying on the fact that we are reading 0x001 as an indication that
> this device detected CRS. Maybe, this is too indirect.
> 
> If we also want to capture the capability, I think the right thing is to
> check the parent capability.
> 
> bool pci_bus_crs_vis_supported(struct pci_dev *bridge)
> {
> 	if (device type(bridge) == root port)
> 		return read(root_crs_register_reg);
> 
> 	if (device type(bridge) == switch)
> 		return read(switch_crs_register);

I don't understand this part.  AFAIK, CRS SV is only a feature of root
ports.  The capability and enable bits are in the Root Capabilities
and Root Control registers.

It's certainly true that a device below a switch can respond with a
CRS completion, but the switch is not the requester, and my
understanding is that it would not take any action on the completion
other than passing it upstream.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
