Return-Path: <SRS0=kEDy=ZW=bombadil.srs.infradead.org=BATV+0bef769f1c4d4d9eae97+4918+infradead.org+hch@kernel.org>
Return-Path: <SRS0=kEDy=ZW=bombadil.srs.infradead.org=BATV+0bef769f1c4d4d9eae97+4918+infradead.org+hch@kernel.org>
Date: Wed, 8 Feb 2017 23:19:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Jon Mason <jon.mason@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	devel@linuxdriverproject.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH v1 1/3] PCI: xilinx: Configure PCIe MPS settings
Message-ID: <20170209071956.GA21656@infradead.org>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170208224930.14351.91597.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208224930.14351.91597.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 08, 2017 at 04:49:30PM -0600, Bjorn Helgaas wrote:
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);

This loop is duplicated in just about every driver, so it it
might be a good idea to provide a littler helper for it.
