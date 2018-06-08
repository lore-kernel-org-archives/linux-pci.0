Return-Path: <SRS0=c2HZ=I2=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=c2HZ=I2=intel.com=keith.busch@kernel.org>
Date: Fri, 8 Jun 2018 16:43:30 -0600
From: Keith Busch <keith.busch@intel.com>
To: "poza@codeaurora.org" <poza@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH NEXT 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from
 pcie_portdrv_slot_reset()
Message-ID: <20180608224330.GA25132@localhost.localdomain>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
 <1528351234-26914-6-git-send-email-poza@codeaurora.org>
 <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
 <20180607213448.GB37077@bhelgaas-glaptop.roam.corp.google.com>
 <f9a6f1ae2e7c17f87e465e643c8e6dcc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f9a6f1ae2e7c17f87e465e643c8e6dcc@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 07, 2018 at 09:47:42PM -0700, poza@codeaurora.org wrote:
> Keith,
> 
> do you know why in ERR_FATAL case following was done ?
> have a look at pcie_portdrv_slot_reset() handling (for bridges, switches 
> etc..)

Not sure, but I was looking into some issues in this area anyway.

I'm finding that non-hotpluggable bridges that support D3 are getting
put into that low-power mode, and that pretty much breaks the
re-enumeration.
