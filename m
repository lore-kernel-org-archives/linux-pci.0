Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Apr 2016 19:06:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements
Message-ID: <20160427000652.GC6789@localhost>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
 <20160426183611.GC27803@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160426183611.GC27803@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 26, 2016 at 01:36:11PM -0500, Bjorn Helgaas wrote:
> On Sun, Apr 17, 2016 at 01:36:53PM -0400, Sinan Kaya wrote:
> > Code has been redesigned to calculate penalty requirements on the fly. This
> > significantly simplifies the implementation and removes some of the init
> > calls from x86 architecture.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> For all four patches:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Rafael, I should have mentioned that I'm assuming you'll take these
because they're in drivers/acpi and you merged the previous ones,
e.g.,

  0971686954f9 ACPI / PCI: Simplify acpi_penalize_isa_irq()
  37c5939136d7 ACPI, PCI, irq: remove interrupt number restriction
  b5bd02695471 ACPI, PCI, irq: remove interrupt count restriction

Just let me know if you'd rather have me take them.

Bjorn
