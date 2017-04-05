Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 5 Apr 2017 11:52:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v6 01/23] PCI: endpoint: Add EP core layer to enable EP
 controller and EP functions
Message-ID: <20170405165254.GA17066@bhelgaas-glaptop.roam.corp.google.com>
References: <20170405085243.18123-1-kishon@ti.com>
 <20170405085243.18123-2-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <20170405085243.18123-2-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, hch@infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 05, 2017 at 02:22:21PM +0530, Kishon Vijay Abraham I wrote:
> Introduce a new EP core layer in order to support endpoint functions in
> linux kernel. This comprises the EPC library (Endpoint Controller Library)
> and EPF library (Endpoint Function Library). EPC library implements
> functions specific to an endpoint controller and EPF library implements
> functions specific to an endpoint function.
> ...

> +/**
> + * pci_epf_linkup() - Notify the function driver that EPC device has
> + *		      established a connection with the Root Complex.
> + * @epf: the EPF device bound to the EPC device which has established
> + *	 the connection with the host
> + *
> + * Invoke to notify the function driver that EPC device has established
> + * a connection with the Root Complex.
> + */
> +void pci_epf_linkup(struct pci_epf *epf)
> +{
> +	if (!epf->driver)
> +		dev_WARN(&epf->dev, "epf device not bound to driver\n");
> +
> +	epf->driver->ops->linkup(epf);

I don't understand what's going on here.  We warn if epf->driver is
NULL, but the next thing we do is dereference it.

For NULL pointers that are symptoms of Linux defects, I usually prefer
not to check at all so that a dereference generates an oops and we can
debug the problem.  For NULL pointers caused by user error, we would
generally return an error that percolates up to the user.

I haven't competely wrapped my head around this endpoint support, but
I assume a NULL pointer here would be caused by user error, not
necessarily a Linux defect.  So why would we dereference a NULL
pointer?  And what happens when we do?  Is this just going to oops an
embedded Linux running inside the endpoint?  Is that the correct
behavior?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
