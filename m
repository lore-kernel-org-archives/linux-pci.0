Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 11 Nov 2016 16:25:24 -0500
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VMD: Use local SRCU to prevent delaying global RCU
Message-ID: <20161111212523.GB10660@localhost.localdomain>
References: <1475794062-3114-1-git-send-email-jonathan.derrick@intel.com>
 <20161111210725.GE9868@bhelgaas-glaptop.roam.corp.google.com>
 <20161111211223.GA2828@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161111211223.GA2828@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 02:12:24PM -0700, Jon Derrick wrote:
> Hi Bjorn,
> 
> I need to attach a patch which selects SRCU in the Kconfig. Do you want
> this and the original patch as a new set or should I just send this new
> Kconfig patch?

Hi Jon,
Please send a new patch. This hasn't been applied yet, so we'd prefer
not to have intermediate breakage if we discover the gaps early.
