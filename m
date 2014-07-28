Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Srikanth Thokala <sthokal@xilinx.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	svemula@xilinx.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	Grant Likely <grant.likely@linaro.org>, anirudh@xilinx.com,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5] pcie: Add Xilinx PCIe Host Bridge IP driver
Date: Mon, 28 Jul 2014 15:02:52 +0200
Message-ID: <8258903.Rn4s07GKGV@wuerfel>
In-Reply-To: <CA+mB=1JhDF=BBXcyTbgVB8S7qH=Mb1JH78HLL4pA9OBH19hQvA@mail.gmail.com>
References: <1406131381-25577-1-git-send-email-sthokal@xilinx.com> <CA+mB=1JhDF=BBXcyTbgVB8S7qH=Mb1JH78HLL4pA9OBH19hQvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 28 July 2014 18:04:34 Srikanth Thokala wrote:
> Hi Arnd and Rob,
> 
> I discussed with Bjorn and we believe this patch is in good shape to
> apply.  And Bjorn requires ACKs to apply this patch.  So, could you
> guys please review this patch and provided your ACKs to this patch.

Looks great for the most part. I've looked through the whole driver
again, and I have two small issues remaining:

a) Please clarify in the changeset description why there is no support
   for PCI I/O space. 

b) I think you should use the 'msi-parent' property, and the
   of_pci_find_msi_chip_by_node() to find the msi_chip for the
   PCI controller. This will make it possible to forward MSIs
   to the main interrupt controller in the system, which is more
   efficient. See the pcie-mvebu driver for an example of this.

Other than these:

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
