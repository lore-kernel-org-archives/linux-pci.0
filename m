Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFiDJ59PuhRj3F288A_451pLiKnqPUKin9C2t5uuH2iNPnJfAg@mail.gmail.com>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
 <1442801587-3812-6-git-send-email-lftan@altera.com> <5606171A.5000609@kernel.org>
 <CAFiDJ59PuhRj3F288A_451pLiKnqPUKin9C2t5uuH2iNPnJfAg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 28 Sep 2015 12:31:36 -0500
Message-ID: <CAL_JsqL9eoTRa2-eeNJgVoO=0LyuaaJ87E4_BS0KocRKBXGdGA@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] Documentation: dt-bindings: pci: altera pcie
 device tree binding
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 28, 2015 at 12:38 AM, Ley Foon Tan <lftan@altera.com> wrote:
> On Sat, Sep 26, 2015 at 11:55 AM, Rob Herring <robh@kernel.org> wrote:
>>
>> On 09/20/2015 09:13 PM, Ley Foon Tan wrote:
>> > This patch adds the bindings for Altera PCIe host controller driver and
>> > Altera PCIe MSI driver.

[...]

>> > +     num-vectors = <32>;
>> > +};
>> > diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
>> > new file mode 100644
>> > index 0000000..4440db1
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
>> > @@ -0,0 +1,49 @@
>> > +* Altera PCIe controller
>> > +
>> > +Required properties:
>> > +- compatible :       should contain "altr,pcie-root-port-1.0"
>> > +- reg:               a list of physical base address and length for TXS and CRA.
>> > +- reg-names: must include the following entries:
>> > +             "Txs" or "txs": TX slave port region
>> > +             "Cra" or "cra": Control register access region
>>
>> Why both cases? Can we please just have one (or none is better IMO).
> The PCIe IP on different device families use different register names.
> And our device tree generator will auto generate the register names
> based on the hardware description name. Too bad we can't change the
> hardware description names now.

Okay, your problem to maintain. Hopefully the driver just goes by index then.

Strictly speaking, if you have undocumented bindings downstream that
is your problem and we don't have to accept them as-is upstream. I'm
not going to worry about that here.

>> txs contains the config space?
> It is not the config space, but a memory slave port.

Then where is the config space? It should not be part of "ranges" is
all I care about.

Rob
