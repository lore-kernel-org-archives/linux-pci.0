Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 5 Feb 2016 16:36:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Clean up warnings
Message-ID: <20160205223624.GB16238@localhost>
References: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 02, 2016 at 01:20:28PM -0600, Bjorn Helgaas wrote:
> I'm on a quest to clean up compiler warnings in drivers/pci.  I'd like to
> be able to treat warnings as errors, at least for the 0day build robot.
> 
> ---
> 
> Bjorn Helgaas (3):
>       PCI: Check device_attach() return value always
>       PCI/PME: Remove redundant port lookup
>       PCI/PME: Restructure pcie_pme_suspend() to prevent compiler warning
> 
> 
>  drivers/pci/bus.c      |    7 ++++++-
>  drivers/pci/pcie/pme.c |   11 ++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)

I applied these, with Rafael's ack, to pci/misc for v4.6.
