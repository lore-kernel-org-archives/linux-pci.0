Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57182 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdL1Iu3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 03:50:29 -0500
Message-ID: <1514450844.7000.305.camel@linux.intel.com>
Subject: Re: [RFC PATCH v12 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
        JeffyChen <jeffy.chen@rock-chips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, linux-pci@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Date: Thu, 28 Dec 2017 10:47:24 +0200
In-Reply-To: <CAL_JsqJssPABjoRM-XAnuN_Xd2-sHoFifJNrRDdk_ruQ0DRw6A@mail.gmail.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
         <20171226023646.17722-5-jeffy.chen@rock-chips.com>
         <20171226235607.4rgp4ebrrktt6d56@rob-hp-laptop>
         <5A42F847.5060305@rock-chips.com>
         <CAL_JsqJssPABjoRM-XAnuN_Xd2-sHoFifJNrRDdk_ruQ0DRw6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-12-27 at 09:30 -0600, Rob Herring wrote:
> On Tue, Dec 26, 2017 at 7:32 PM, JeffyChen <jeffy.chen@rock-chips.com>
> wrote:

> this new file does something similar to the pci-acpi.c and pci-mid.c..

> pci-acpi.c has similar things to pci/of.c. The naming is just not
> consistent.

> > and i am agree the naming is not clear, maybe we can rename both of
> > those
> > files to something like pci-pm-***.c?
> 
> At least pci-acpi.c is more than just PM functions, so that doesn't
> make sense. Given that all the ACPI related functions are in 1 file,
> we should do the same for DT.

> > but i have no idea about pci-mid.c or would it possible to have more
> > platform pm ops in the future...maybe we should add some dependency
> > in the
> > Kconfig?

You may consider pci-mid.c as pci-sfi.c to some extend.

So, in that sense it more looks like pci-of.c would be the name for DT
case.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
