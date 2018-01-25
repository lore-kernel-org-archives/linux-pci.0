Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Jan 2018 09:47:29 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        JeffyChen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20180125174728.rin6yghbn6gdtoxs@ban.mtv.corp.google.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <5491520.JsEYlZiECc@aspire.rjw.lan>
 <20180105004130.GA151625@google.com>
 <2806186.IK6EZBC0cX@aspire.rjw.lan>
 <20180125012148.lcgnxi3uwcjzue7o@ban.mtv.corp.google.com>
 <20180125164010.GG4180@atomide.com>
 <CAJZ5v0h7JvEFTV1mbqxtK8P0aoums2Cvjy3uU1gK4E26_rtZ5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0h7JvEFTV1mbqxtK8P0aoums2Cvjy3uU1gK4E26_rtZ5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thu, Jan 25, 2018 at 05:54:23PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 25, 2018 at 5:40 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Brian Norris <briannorris@chromium.org> [180125 01:22]:
> >> On Fri, Jan 05, 2018 at 02:13:33AM +0100, Rafael J. Wysocki wrote:
> >> > The "wakeup-interrupt" property at the bridge level basically has to be defined
> >> > as the wakeup interrupt for all devices on the bus under the bridge.
> >>
> >> The only thing I'm at a loss for is whether this goes in (referring to
> >> rk3399-gru.dtsi) &pcie or &pci_rootport. I think some versions of this
> >> series have been aiming for the former, and some the latter.
> >
> > I'd keep the wakeup interrupt property at the rootport level. That way
> > it can work with whatever pcie card that might be plugged into that
> > slot. That is in case it's just a slot and not hardwired pcie device :)

^^ Right, and that's what I believe this series was doing. Previous
versions put it in &pcie, which might have had a similar effect. The
existing behavior is the misguided bindings that put it in &mvl_wifi
(the endpoint device).

> Do I understand correctly that &pcie is the device and the
> &pci_rootport is the port that device is connected to?

No. (Assuming "device" means "endpoint PCIe device".)

&pcie: The top-level representation of the host bridge

&pci_rootport: a virtual representation of a root port. I don't think
this corresponds to a Linux device in the end, but I thought it
corresponded most closely to a "slot" [1]

&mvl_wifi: an endpoint device

Brian

[1] As another example, consider
arch/arm/boot/dts/armada-370{.dtsi,-dlink-dns327l.dts}
It has a structure of:

  pciec: pcie@82000000 {
    pcie0: pcie@1,0 /* Port 0, Lane 0 */ {
      // Brian: no subnode, since we don't generally want to describe
      // specific endpoints in DT, when they should be autodetectable
    };
    pcie2: pcie@2,0 /* Port 1, Lane 0 */ {
      // Brian: no subnode, since we don't generally want to describe
      // specific endpoints in DT, when they should be autodetectable
    };
  };

Where Gru's &pcie is equivalent to Armada's &pciec, and Gru's
&pci_rootport is equivalent to &pcie0 and &pcie2.
