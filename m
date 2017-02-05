Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <7079928.XO1j93ERJc@wuerfel>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <7079928.XO1j93ERJc@wuerfel>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 5 Feb 2017 15:44:42 +0100
Message-ID: <CACRpkdZtuqF-ekNzVTNY4BBCt2bG6NcTAFs-ARYGw7q5E=jBTw@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host
 Bridge
To: Arnd Bergmann <arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Janos Laube <janos.dev@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 1, 2017 at 12:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday, January 28, 2017 9:48:36 PM CET Linus Walleij wrote:
>> +       pci_intc: interrupt-controller {
>> +               interrupt-controller;
>> +               #address-cells = <0>;
>> +               #interrupt-cells = <1>;
>> +       };
>
> I think this one needs at least an interrupt-parent property, otherwise
> you would recursively translate the numbers back through the interrupt-map
> property of its parent.

OK I added this, I think it was the cause of the error Hand Uli Kroll
was seeing. I guess I didn't run into it because I was only testing the
device in slot 9 so everything was defaulting to zero.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
