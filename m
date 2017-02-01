Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170201160224.jg6tuls2xcuul3m4@rob-hp-laptop>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170201160224.jg6tuls2xcuul3m4@rob-hp-laptop>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Feb 2017 21:04:44 +0100
Message-ID: <CACRpkdat3rcNL9=FHXBD7zT5LoZy3BGCV1ZT74AoeR4JytSoaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host
 Bridge
To: Rob Herring <robh@kernel.org>
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

On Wed, Feb 1, 2017 at 5:02 PM, Rob Herring <robh@kernel.org> wrote:
> On Sat, Jan 28, 2017 at 09:48:36PM +0100, Linus Walleij wrote:

>> +Example:
>> +
>> +pci@50000000 {
>> +     compatible = "cortina,gemini-pci";
>> +     reg = <0x50000000 0x100>;
>
> Config space is indirectly accessed?

Yes it is a really annoying construction. The first device, the Faraday
roob hub is at that address, the init code uses that to set up the bus.

As soon as the bus is up, we use bus accessors to talk to the root
hub on slot 0 (this manages interrupts etc).

I guess I could even unmap this reg range at that point ...

I guess I could also get the address directly from the IO range
and start poking around. I don't know if that is any better.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
