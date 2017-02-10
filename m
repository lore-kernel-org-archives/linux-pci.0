Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 10 Feb 2017 15:58:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 1/3] PCI: xilinx: Configure PCIe MPS settings
Message-ID: <20170210215829.GQ29169@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170208224930.14351.91597.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170209071956.GA21656@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170209071956.GA21656@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Michal Simek <michal.simek@xilinx.com>,
 Jon Mason <jon.mason@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, devel@linuxdriverproject.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 08, 2017 at 11:19:56PM -0800, Christoph Hellwig wrote:
> On Wed, Feb 08, 2017 at 04:49:30PM -0600, Bjorn Helgaas wrote:
> > +	list_for_each_entry(child, &bus->children, node)
> > +		pcie_bus_configure_settings(child);
> 
> This loop is duplicated in just about every driver, so it it
> might be a good idea to provide a littler helper for it.

Yeah, you're right.  One reason I didn't is because I would like to
remove these if we can move the MPS setup into the pci_device_add()
path.

We ought to be able to do at least the minimal "configure this new
device to match the existing hierarchy; if that's impossible, disable
the device" sort of thing there.

We probably would still want some sort of bus- or root port- or host
bridge-level configuration that can take a broader view, and that
might be done where we currently have this loop.  But I don't know 
exactly what that should look like.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
