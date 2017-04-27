Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1493194205.27023.80.camel@mtkswgap22>
References: <1492935543-18190-1-git-send-email-ryder.lee@mediatek.com>
 <1492935543-18190-3-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a1vgi9VBZfRNq0dDKzmfe8FkHQtgz6fEXW9fyUnBHtaQQ@mail.gmail.com>
 <1493194205.27023.80.camel@mtkswgap22>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 27 Apr 2017 21:06:32 +0200
Message-ID: <CAK8P3a0vD8s_3R+jS=JdUXX3X05SkCk-mipMA6UxWYQZe6vLUQ@mail.gmail.com>
Subject: Re: [SPAM]Re: [PATCH 2/2] dt-bindings: pcie: Add documentation for
 Mediatek PCIe
To: Ryder Lee <ryder.lee@mediatek.com>
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

On Wed, Apr 26, 2017 at 10:10 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> Hi
>
> On Tue, 2017-04-25 at 14:18 +0200, Arnd Bergmann wrote:
>> On Sun, Apr 23, 2017 at 10:19 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
>> > Add documentation for PCIe host driver available in MT7623
>> > series SoCs.
>> >
>> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>> > ---
>> >  .../bindings/pci/mediatek,mt7623-pcie.txt          | 153 +++++++++++++++++++++
>> >  1 file changed, 153 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
>> > new file mode 100644
>> > index 0000000..ee93ba2
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
>> > @@ -0,0 +1,153 @@
>> > +Mediatek MT7623 PCIe controller
>> > +
>> > +Required properties:
>> > +- compatible: Should contain "mediatek,mt7623-pcie".
>>
>> Did mediatek license the IP block from someone else or was it
>> developed in-house? Is there a name and/or version identifier
>> for the block itself other than identifying it as the one in mt7623?
>
> Originally, it license from synopsys. Our designer add a wrapper to hide
> the DBI detail so that we cannot use them directly. Perhaps I can call
> it "mediatek,gen2v1-pcie", because we have a plan to upstream a in-house
> Gen2 IP in the future.

Ok, so this is the same hardware that drivers/pci/dwc/ handles, but
it needs a separate driver because the wrapper that was added uses
a completely different register layout, right?

Are any of the registers the same at all, e.g. for MSI handling?

>> > +Required properties:
>> > +- device_type: Must be "pci"
>> > +- assigned-addresses: Address and size of the port configuration registers
>> > +- reg: Only the first four bytes are used to refer to the correct bus number
>> > +  and device number.
>> > +- #address-cells: Must be 3
>> > +- #size-cells: Must be 2
>> > +- ranges: Sub-ranges distributed from the PCIe controller node. An empty
>> > +  property is sufficient.
>> > +- clocks: Must contain an entry for each entry in clock-names.
>> > +  See ../clocks/clock-bindings.txt for details.
>> > +- clock-names: Must include the following entries:
>> > +  - sys_ck
>> > +- resets: Must contain an entry for each entry in reset-names.
>> > +  See ../reset/reset.txt for details.
>>
>> This seems odd: you have a device that is simply identified as "pci"
>> without any more specific ID, but you require additional properties
>> (clocks, reset, ...) that are not part of the standard PCI binding.
>>
>> Can you clarify how the port devices related to the root device in
>> this hardware design?
>
> I will write clarify like this:
>
> PCIe subsys includes one Host/PCI bridge and 3 PCIe MAC port. There
> are 3 bus master for data access and 1 slave for configuration and
> status register access. Each port has PIPE interface to PHY and

If I understand this right, then each of the ports in your hardware
is what we normally drive using the drivers/pci/dwc/ driver framework,
but your implementation actually made it more PCI standard compliant
by implementing the normal PCIe host bridge registers for all ports
combined, something that most others don't.

>> Have you considered moving the nonstandard properties into the host
>> bridge node and having that device deal with setting up the links
>> to the other drivers? That way we could use the regular pcie
>> port driver for the children.
>>
>
> OK, but I still want to use port->reset to catch reset properties in
> driver.

Do you mean in drivers/pci/pcie/portdrv_pci.c? I see that it
has a function called pcie_portdrv_slot_reset(), but I don't see
how that relates to your reset line at the moment. Is this
something you have submitted in a different series?

Or do you mean in this host driver? The problem I see with
that approach is that the port device is owned by portdrv_pci,
so the host bridge driver should not look at the properties of
the port.

>> > +- reset-names: Must include the following entries:
>> > +  - pcie-reset
>> > +- num-lanes: Number of lanes to use for this port.
>> > +- phys: Must contain an entry for each entry in phy-names.
>> > +- phy-names: Must include an entry for each sub node. Entries are of the form
>> > +  "pcie-phyN": where N ranges from 0 to the value specified for port number.
>> > +  See ../phy/phy-mt7623-pcie.txt for details.
>>
>> I think the name should not include the number of the port but rather
>> be always the same here.
>>
>
> Hmm, I think it's better to keep the name here. It's more readable for
> user to understand the relationship between port0 and phy0.

No, I would argue that it's confusing for the reader because it
is different from how most other DT bindings work: In each device
node, you tend to have a set of properties with well-known names
that are documented. When your reference is called "pcie-phy1"
in one node and "pcie-phy2", I would interpret that as both ports
having two phys each, but only one of them being used.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
