Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49513 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRBHT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 21:07:19 -0400
Date: Mon, 17 Sep 2018 21:38:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Rajat Jain <rajatja@google.com>
Cc: s.miroshnichenko@yadro.com, linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
Message-ID: <20180917193832.mfy7m4uumb3kohuv@wunner.de>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com>
 <CACK8Z6F1-P+SDYHx6x3zitSFh2iEPhQtY-Vdhz6Qwkt9=0XTjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6F1-P+SDYHx6x3zitSFh2iEPhQtY-Vdhz6Qwkt9=0XTjA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2018 at 12:00:22PM -0700, Rajat Jain wrote:
> On Fri, Sep 14, 2018 at 9:21 AM Sergey Miroshnichenko <s.miroshnichenko@yadro.com> wrote:
> > If a new PCIe device has been hot-plugged between two active ones, which
> > have no (or not big enough) gap between their BARs, allocating new BARs
> > requires to move BARs of the following working devices:
> 
> * What about non-memory resources? E.g. cards may have pci bridges or
> switches on them, and they may need extra PCI bus numbers. Does this
> help that use case?

FWIW, macOS has had a "PCI Pause" functionality since 2013, documented here:
(the anchor is apparently overridden by Javascript, scroll down to
"Supporting PCIe Pause")

https://developer.apple.com/library/archive/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics02/Basics02.html#//apple_ref/doc/uid/TP40011138-CH4-SW14

In addition to memory resources, they also reallocate bus numbers and MSIs.

Thanks,

Lukas
