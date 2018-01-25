Return-Path: <SRS0=8PhW=EU=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=8PhW=EU=intel.com=keith.busch@kernel.org>
Date: Thu, 25 Jan 2018 14:19:49 -0700
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Maik Broemme <mbroemme@libmpq.org>,
	Pawandeep Oza <poza@codeaurora.org>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2 4/6] PCI/DPC: Print AER status in DPC event handling
Message-ID: <20180125211949.GA20258@localhost.localdomain>
References: <20180117052206.7703-1-keith.busch@intel.com>
 <20180117052206.7703-5-keith.busch@intel.com>
 <20180125195512.GL5317@bhelgaas-glaptop.roam.corp.google.com>
 <20180125211521.GB19484@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180125211521.GB19484@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 25, 2018 at 02:15:21PM -0700, Keith Busch wrote:
> On Thu, Jan 25, 2018 at 01:55:12PM -0600, Bjorn Helgaas wrote:
> 
> > After we clear PCI_EXP_DPC_STATUS_TRIGGER, we're supposed to "honor
> > timing requirements ... with respect to the first Configuration Read
> > following a Conventional Reset" (PCIe r4.0, sec 7.9.15.4).  Where does
> > that happen?
> 
> That is referring to reading the downstream port, and that is not
> handled by the DPC driver. The expectation is that the link is down on a
> DPC event, and the Link Up is handled by the pciehp driver, which
> should be honoring those timing requirements.

Sorry, I didn't mean "reading the downstream port". You can config read
that anytime. I meant issuing a config read to the device connected
downstream the contained port.
