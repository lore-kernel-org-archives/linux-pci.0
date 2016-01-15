Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 15 Jan 2016 16:06:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "Busch, Keith" <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Veal, Bryan E" <bryan.e.veal@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160115220631.GA14080@localhost>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <8D943B239464E04C9184454D8B3F5CFF0ABF18EC@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8D943B239464E04C9184454D8B3F5CFF0ABF18EC@ORSMSX101.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 15, 2016 at 07:48:11PM +0000, Derrick, Jonathan wrote:
> Additionally, what are your thoughts of moving the menuconfig option from the root-tier to 'Processor Type and Features'?

I don't know how Intel is going to market this feature, but from a
developer point of view, the code looks more like the PCI host bridge
drivers in drivers/pci/host than it does like a processor feature.
Most of those drivers are specific to a particular architecture or
SoC.

Bjorn
