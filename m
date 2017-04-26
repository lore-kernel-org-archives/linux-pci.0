Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1493194205.27023.80.camel@mtkswgap22>
Subject: Re: [SPAM]Re: [PATCH 2/2] dt-bindings: pcie: Add documentation for
 Mediatek PCIe
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Apr 2017 16:10:05 +0800
In-Reply-To: <CAK8P3a1vgi9VBZfRNq0dDKzmfe8FkHQtgz6fEXW9fyUnBHtaQQ@mail.gmail.com>
References: <1492935543-18190-1-git-send-email-ryder.lee@mediatek.com>
 <1492935543-18190-3-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a1vgi9VBZfRNq0dDKzmfe8FkHQtgz6fEXW9fyUnBHtaQQ@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi

On Tue, 2017-04-25 at 14:18 +0200, Arnd Bergmann wrote:
> On Sun, Apr 23, 2017 at 10:19 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> > Add documentation for PCIe host driver available in MT7623
> > series SoCs.
> >
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  .../bindings/pci/mediatek,mt7623-pcie.txt          | 153 +++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
> > new file mode 100644
> > index 0000000..ee93ba2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
> > @@ -0,0 +1,153 @@
> > +Mediatek MT7623 PCIe controller
> > +
> > +Required properties:
> > +- compatible: Should contain "mediatek,mt7623-pcie".
> 
> Did mediatek license the IP block from someone else or was it
> developed in-house? Is there a name and/or version identifier
> for the block itself other than identifying it as the one in mt7623?

Originally, it license from synopsys. Our designer add a wrapper to hide
the DBI detail so that we cannot use them directly. Perhaps I can call
it "mediatek,gen2v1-pcie", because we have a plan to upstream a in-house
Gen2 IP in the future.

> > +- device_type: Must be "pci"
> > +- reg: Base addresses and lengths of the pcie controller.
> > +- interrupts: A list of interrupt outputs of the controller.
> 
> Please be more specific about what each interrupt is for, and how
> many there are.

OK.

> > +Required properties:
> > +- device_type: Must be "pci"
> > +- assigned-addresses: Address and size of the port configuration registers
> > +- reg: Only the first four bytes are used to refer to the correct bus number
> > +  and device number.
> > +- #address-cells: Must be 3
> > +- #size-cells: Must be 2
> > +- ranges: Sub-ranges distributed from the PCIe controller node. An empty
> > +  property is sufficient.
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +  See ../clocks/clock-bindings.txt for details.
> > +- clock-names: Must include the following entries:
> > +  - sys_ck
> > +- resets: Must contain an entry for each entry in reset-names.
> > +  See ../reset/reset.txt for details.
> 
> This seems odd: you have a device that is simply identified as "pci"
> without any more specific ID, but you require additional properties
> (clocks, reset, ...) that are not part of the standard PCI binding.
> 
> Can you clarify how the port devices related to the root device in
> this hardware design?

I will write clarify like this:

PCIe subsys includes one Host/PCI bridge and 3 PCIe MAC port. There
are 3 bus master for data access and 1 slave for configuration and
status register access. Each port has PIPE interface to PHY and

> Have you considered moving the nonstandard properties into the host
> bridge node and having that device deal with setting up the links
> to the other drivers? That way we could use the regular pcie
> port driver for the children.
> 

OK, but I still want to use port->reset to catch reset properties in
driver.
 
> > +- reset-names: Must include the following entries:
> > +  - pcie-reset
> > +- num-lanes: Number of lanes to use for this port.
> > +- phys: Must contain an entry for each entry in phy-names.
> > +- phy-names: Must include an entry for each sub node. Entries are of the form
> > +  "pcie-phyN": where N ranges from 0 to the value specified for port number.
> > +  See ../phy/phy-mt7623-pcie.txt for details.
> 
> I think the name should not include the number of the port but rather
> be always the same here.
> 

Hmm, I think it's better to keep the name here. It's more readable for
user to understand the relationship between port0 and phy0.

>       Arnd
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
