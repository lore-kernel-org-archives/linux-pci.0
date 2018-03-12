Return-Path: <SRS0=MBbZ=GC=bombadil.srs.infradead.org=BATV+67f3e043b1e7b26abb15+5314+infradead.org+hch@kernel.org>
Return-Path: <SRS0=MBbZ=GC=bombadil.srs.infradead.org=BATV+67f3e043b1e7b26abb15+5314+infradead.org+hch@kernel.org>
Date: Mon, 12 Mar 2018 01:00:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>,
	Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>,
	Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 02/13] PCI/PM: Move pcie_clear_root_pme_status() to
 core
Message-ID: <20180312080021.GB10358@infradead.org>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062200018.77693.9632596426168244205.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152062200018.77693.9632596426168244205.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 09, 2018 at 01:00:00PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Move pcie_clear_root_pme_status() from the port driver to the PCI core so
> it will be available even when the port driver isn't present.  No
> functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
