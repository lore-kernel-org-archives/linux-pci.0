Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 23 Oct 2017 14:32:25 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] PCI: hisi: add PCIe driver support for HiSilicon STB SoCs
Message-ID: <20171023063224.GI8700@dragon>
References: <1508043971-23216-1-git-send-email-shawnguo@kernel.org>
 <CAKv+Gu9rY-UuVLGBUoVJqbqMR9Gz1Pcw37W4gnfMPmGAdDE=_A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9rY-UuVLGBUoVJqbqMR9Gz1Pcw37W4gnfMPmGAdDE=_A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jianguo Sun <sunjianguo1@huawei.com>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Shawn Guo <shawn.guo@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ard,

On Sun, Oct 22, 2017 at 10:36:47AM +0100, Ard Biesheuvel wrote:
> > +Example:
> > +       pcie@f9860000 {
> > +               compatible = "hisilicon,hi3798cv200-pcie";
> > +               reg = <0xf9860000 0x1000>,
> > +                     <0xf0000000 0x2000>,
> > +                     <0xf2000000 0x01000000>;
> > +               reg-names = "control", "rc-dbi", "config";
> > +               #address-cells = <3>;
> > +               #size-cells = <2>;
> > +               device_type = "pci";
> > +               bus-range = <0 15>;
> > +               num-lanes = <1>;
> > +               ranges=<0x81000000 0 0 0xf4000000 0 0x00010000
> > +                       0x82000000 0 0xf3000000 0xf3000000 0 0x01000000>;
> > +               interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> > +               interrupt-names = "msi";
> > +               #interrupt-cells = <1>;
> > +               interrupt-map-mask = <0 0 0 7>;
> > +               interrupt-map = <0 0 0 1 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> 
> I know this is just the example, but this looks wrong to me: this only
> covers INTA, so any multi-function devices that rely on legacy
> interrupts (such as Nvidia GFX cards with HDMI audio device that are
> blacklisted for MSI support) will fail to work. What I /think/ you
> need is:
> 
> interrupt-map-mask = <0 0 0 0>;
> interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;

I really appreciate the comment.  Yes, all 4 legacy interrupts should be
mapped to this IRQ.  I will get it fixed.  Thanks again.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
