Return-Path: <SRS0=MBbZ=GC=bombadil.srs.infradead.org=BATV+67f3e043b1e7b26abb15+5314+infradead.org+hch@kernel.org>
Return-Path: <SRS0=MBbZ=GC=bombadil.srs.infradead.org=BATV+67f3e043b1e7b26abb15+5314+infradead.org+hch@kernel.org>
Date: Mon, 12 Mar 2018 01:04:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>,
	Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>,
	Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Message-ID: <20180312080402.GE10358@infradead.org>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

> +	 * We assume we can manage these PCIe features.  Some systems may
> +	 * reserve these for use by the platform itself, e.g., an ACPI BIOS
> +	 * may implement its own AER handling and use _OSC to prevent the
> +	 * OS from interfering.
> +	 */
> +	bridge->use_aer = 1;
> +	bridge->use_hotplug = 1;
> +	bridge->use_pme = 1;

If we start out with enabled maybe these should be disable_foo flags
instead?

Also please use bool (or a bitfield bool) for true/false values.
