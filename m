Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:62189 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdL0AoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Dec 2017 19:44:08 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Rob Herring <robh@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v12 1/5] dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
Date: Wed, 27 Dec 2017 01:43:09 +0100
Message-ID: <3268448.IvXk7OJtIY@aspire.rjw.lan>
In-Reply-To: <20171226233552.nacwqbpkozmy7n6c@rob-hp-laptop>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com> <20171226023646.17722-2-jeffy.chen@rock-chips.com> <20171226233552.nacwqbpkozmy7n6c@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 27, 2017 12:35:52 AM CET Rob Herring wrote:
> On Tue, Dec 26, 2017 at 10:36:42AM +0800, Jeffy Chen wrote:
> > We are going to handle PCIe WAKE# pin for PCI devices in the pci core,
> > so add definitions of the optional PCIe WAKE# pin for PCI devices.
> > 
> > Also add an definition of the optional PCI interrupt pin for PCI
> > devices to distinguish it from the PCIe WAKE# pin.
> 
> By v13 you should drop "RFC". RFC implies not ready for merging.

Which very much still is the case AFAICS.

Thanks,
Rafael
