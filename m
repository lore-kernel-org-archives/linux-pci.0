Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Tony Lindgren <tony@atomide.com>
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
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE# signal for OF
Date: Fri, 05 Jan 2018 01:11:55 +0100
Message-ID: <1652279.Kf304cK0PT@aspire.rjw.lan>
In-Reply-To: <20180103200837.GP3875@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com> <6120485.xubBpvge6h@aspire.rjw.lan> <20180103200837.GP3875@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, January 3, 2018 9:08:37 PM CET Tony Lindgren wrote:
> Hi,
> 
> * Rafael J. Wysocki <rjw@rjwysocki.net> [171228 17:33]:
> > So we are fine except for the race and we need the wakeirq field in wakeup
> > sources to automatically arm the wakeup IRQs during suspend.
> > 
> > If I'm not mistaken, we only need something like the patch below (untested).
> 
> Yeah for your patch below works just fine for my
> test cases so:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Cool, thanks!

Let me respin it with a subject/changelog.

Thanks,
Rafael
