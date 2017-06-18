Return-Path: <SRS0=KlWK=5X=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=KlWK=5X=gmail.com=robherring2@kernel.org>
Date: Sun, 18 Jun 2017 09:05:01 -0500
From: Rob Herring <robh@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	David Laight <david.laight@aculab.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>, Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v6 1/3] PCI: Add DT binding for tango PCIe controller
Message-ID: <20170618140501.mu3zrr5dw4fstshd@rob-hp-laptop>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com>
 <20170607212907.2wr3hqbokjb74kj3@rob-hp-laptop>
 <3790db8d-6a4c-5c74-9ca2-431715a712a7@sigmadesigns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3790db8d-6a4c-5c74-9ca2-431715a712a7@sigmadesigns.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 03:51:32PM +0200, Marc Gonzalez wrote:
> Binding for the Sigma Designs SMP8759 SoC.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Changes from v5 to v6
> o Delete links to elinux.org
> o Use explicit hex numbers instead of symbolic constants for sizes (in the example)
> o Add bus-range to "Required properties"
> ---
>  .../devicetree/bindings/pci/tango-pcie.txt         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt

Acked-by: Rob Herring <robh@kernel.org>
