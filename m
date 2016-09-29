Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:46023 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755173AbcI2MKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 08:10:40 -0400
Date: Thu, 29 Sep 2016 14:11:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 0/5] PCI PM refinements
Message-ID: <20160929121117.GA6648@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de>
 <20160928165445.GB5658@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160928165445.GB5658@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 28, 2016 at 11:54:45AM -0500, Bjorn Helgaas wrote:
> On Sun, Sep 18, 2016 at 05:39:20AM +0200, Lukas Wunner wrote:
> >   PCI: Afford direct-complete to devices with nonstandard PM
> >   PCI: Query platform firmware for device power state
> >   PCI: Recognize D3cold in pci_update_current_state()
> >   PCI: Avoid unnecessary resume after direct-complete
> 
> I applied the patches above with Rafael's acks to pci/pm for v4.9, thanks,
> Lukas!  I particularly appreciate your changelogs -- they're very readable,
> complete, and consistent in style.

As a non-native English speaker I cannot imagine a bigger compliment,
thanks so much!


> >   PCI: Avoid unnecessary resume on shutdown
> 
> Sounds like there's still a little discussion on this, so I haven't applied
> this one yet.

Yes, indeed I need more time with this one.

Thanks!

Lukas
