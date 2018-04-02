Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753987AbeDBAmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Apr 2018 20:42:03 -0400
Date: Sun, 1 Apr 2018 19:42:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] ACPI / hotplug / PCI: Check presence of slot itself in
 get_slot_status()
Message-ID: <20180402004201.GC131023@bhelgaas-glaptop.roam.corp.google.com>
References: <20180212105523.15984-1-mika.westerberg@linux.intel.com>
 <20180323211819.GB210003@bhelgaas-glaptop.roam.corp.google.com>
 <CAHbf0-FR4dn8g10T42J8mbEr8XznyuNLem_Rvr6+G4YGLPv8Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHbf0-FR4dn8g10T42J8mbEr8XznyuNLem_Rvr6+G4YGLPv8Bg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 01, 2018 at 11:36:02PM +0100, Mike Lothian wrote:
> On 23 March 2018 at 21:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > I (finally) applied this to pci/hotplug with Rafael's ack for v4.17,
> > thanks!
> >
> 
> Sorry for sounding like a broken record but this still hasn't landed
> in linux-next (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/pci/hotplug/acpiphp_glue.c)

It's in my "next" branch pushed yesterday, so it should appear in
the next cut of linux-next.
