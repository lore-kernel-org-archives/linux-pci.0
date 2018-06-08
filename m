Return-Path: <SRS0=c2HZ=I2=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=c2HZ=I2=intel.com=keith.busch@kernel.org>
Date: Fri, 8 Jun 2018 14:17:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] PCI/AER: Move aer_irq() declaration to portdrv.h
Message-ID: <20180608201713.GA24554@localhost.localdomain>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152848834128.11888.12263280185471104825.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152848834128.11888.12263280185471104825.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 08, 2018 at 03:05:41PM -0500, Bjorn Helgaas wrote:
> The aer_irq() declaration is the only thing needed by aer_inject.c.  Move
> it to portdrv.h so we eventually get rid of aerdrv.h completely.  No
> functional change intended.

Nothing against what you're doing here, but it does seem odd that aer_irq
is required to be exported just for the error injection to directly call
it. I feel like aer-inject should route it through the irq subsystem,
like with generic_handle_irq. ?
