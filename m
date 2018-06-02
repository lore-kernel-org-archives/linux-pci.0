Return-Path: <SRS0=OP+v=IU=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=OP+v=IU=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 2 Jun 2018 21:48:23 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 1/2] PCI: shpchp: Use dev_printk() for OSHP-related
 messages
Message-ID: <20180602184823.GT15419@lahna.fi.intel.com>
References: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152791812599.257724.10989340037255897378.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152791812599.257724.10989340037255897378.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 02, 2018 at 12:42:06AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use dev_printk() for messages related to requesting control of SHPC hotplug
> via the OSHP method.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
