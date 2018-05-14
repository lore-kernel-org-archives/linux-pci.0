Return-Path: <SRS0=95/U=IB=bombadil.srs.infradead.org=BATV+815ad0f354bf9734604b+5377+infradead.org+hch@kernel.org>
Return-Path: <SRS0=95/U=IB=bombadil.srs.infradead.org=BATV+815ad0f354bf9734604b+5377+infradead.org+hch@kernel.org>
Date: Mon, 14 May 2018 07:23:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>,
	linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>
Subject: Re: [RFC PATCH 1/4] PCI/VMD: Assign membar addresses from shadow
 registers
Message-ID: <20180514142312.GA2654@infradead.org>
References: <20180511004903.19892-1-jonathan.derrick@intel.com>
 <20180511004903.19892-2-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180511004903.19892-2-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

> +	 * For the new VMD device id, shadow registers exist within the MEMBAR2

It won't be new rather soon.  Better us a more descriptive name.
