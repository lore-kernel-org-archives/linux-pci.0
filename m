Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:39192 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeACUAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 15:00:13 -0500
Date: Wed, 3 Jan 2018 12:00:09 -0800
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20180103200009.GO3875@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <CAJZ5v0hpK0_vjX3HinCpsFuKffVUn3d5EnqXdz0P893aRZgnRw@mail.gmail.com>
 <20171228165134.GH3875@atomide.com>
 <6120485.xubBpvge6h@aspire.rjw.lan>
 <20171229171548.GI3875@atomide.com>
 <CAJZ5v0icePurJoGdVtX06j=XHPdZSqXgm+vhL47ngv7OZoL3fw@mail.gmail.com>
 <CAJZ5v0hrzxJ2753Cj5LB=DkqDy9-JJnBXU_hJwOJpZazymStZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hrzxJ2753Cj5LB=DkqDy9-JJnBXU_hJwOJpZazymStZg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Rafael J. Wysocki <rafael@kernel.org> [171230 00:24]:
> On Sat, Dec 30, 2017 at 12:39 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > No, you need a wakeirq properly for the child *device* and that
> > property will be consumed by the PCI layer.
> 
> Or, if you use the convention mentioned in another message in this
> thread, you can make the wakeirq be a property of a bridge (port) with
> the clarification of the assumption that WAKE# is shared by all
> functions below the bridge.  So the presence of the "wakeirq" property
> for a bridge (in addition to providing the wakeup IRQ) will mean that
> it applies to all devices below the bridge.

Yes that makes sense from device tree point of view.

> In the case of parallel PCI (not PCIe), there may be multiple "slots"
> (or "PCI devices" consisting each of multiple functions) under one
> bridge and in theory each of them may use a different IRQ for WAKE#
> signaling, so the above convention will not work then.

OK. In that case the wakeirq would have to be mapped to each
PCI device if there is no other way to describe where the slot
WAKE# line is wired to. I guess the PCI controller could go
through the child devices and map the wakeirqs that way if
needed.

Regards,

Tony
