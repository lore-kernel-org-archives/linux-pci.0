Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:33732 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbdL2RQo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Dec 2017 12:16:44 -0500
Date: Fri, 29 Dec 2017 09:16:39 -0800
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
Message-ID: <20171229171639.GJ3875@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <CAJZ5v0hpK0_vjX3HinCpsFuKffVUn3d5EnqXdz0P893aRZgnRw@mail.gmail.com>
 <20171228165134.GH3875@atomide.com>
 <6120485.xubBpvge6h@aspire.rjw.lan>
 <CAJZ5v0hSMqwitCvfi7D+sknuO0YFr5F-kdkV-cSoVp30Cmdaeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hSMqwitCvfi7D+sknuO0YFr5F-kdkV-cSoVp30Cmdaeg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Rafael J. Wysocki <rafael@kernel.org> [171228 17:46]:
> 
> To be precise, it is not quite possible to figure out which WAKE#
> triggered, if they are sharing the line, without looking into the
> config spaces of the devices below the switch.  The switch is not
> expected to do that AFAICS.  It only generates a PME message meaning
> "wakeup is being signaled somewhere below" and the PME driver that
> handles the Root Port receiving it should look at the PME Status bits
> of the devices below the switch (the pme.c driver does that IIRC or at
> least it should do that ;-)).
> 
> Still, the handling of WAKE# doesn't need to cover this case AFAICS.

OK makes sense now.

Regards,

Tony
