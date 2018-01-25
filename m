Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50920 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeAYQkP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jan 2018 11:40:15 -0500
Date: Thu, 25 Jan 2018 08:40:10 -0800
From: Tony Lindgren <tony@atomide.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        JeffyChen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20180125164010.GG4180@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <5491520.JsEYlZiECc@aspire.rjw.lan>
 <20180105004130.GA151625@google.com>
 <2806186.IK6EZBC0cX@aspire.rjw.lan>
 <20180125012148.lcgnxi3uwcjzue7o@ban.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180125012148.lcgnxi3uwcjzue7o@ban.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Brian Norris <briannorris@chromium.org> [180125 01:22]:
> On Fri, Jan 05, 2018 at 02:13:33AM +0100, Rafael J. Wysocki wrote:
> > The "wakeup-interrupt" property at the bridge level basically has to be defined
> > as the wakeup interrupt for all devices on the bus under the bridge.
> 
> The only thing I'm at a loss for is whether this goes in (referring to
> rk3399-gru.dtsi) &pcie or &pci_rootport. I think some versions of this
> series have been aiming for the former, and some the latter.

I'd keep the wakeup interrupt property at the rootport level. That way
it can work with whatever pcie card that might be plugged into that
slot. That is in case it's just a slot and not hardwired pcie device :)

Regards,

Tony
