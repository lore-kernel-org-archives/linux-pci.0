Return-Path: <SRS0=c2HZ=I2=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=c2HZ=I2=intel.com=keith.busch@kernel.org>
Date: Fri, 8 Jun 2018 14:23:03 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/13] PCI/AER: Squash into one file
Message-ID: <20180608202303.GB24554@localhost.localdomain>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 08, 2018 at 03:04:45PM -0500, Bjorn Helgaas wrote:
> The AER code is scattered across several files and buried a little too deep
> in the hierarchy, which makes it a bit of a hassle to browse.  Consolidate
> it all in a single file (plus the optional aer_inject module) and move it
> up one level to drivers/pci/pcie/aer.c.
> 
> This is all pure code moves; no functional changes intended.

Thanks for doing this. I got a head start on reviewing when I saw this
merged to your tree earlier today, and the driver is much more pleasant
to read than before!

Reviewed-by: Keith Busch <keith.busch@intel.com>
