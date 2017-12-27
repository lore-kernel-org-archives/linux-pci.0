Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:39628 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdL0Bgt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Dec 2017 20:36:49 -0500
Message-ID: <5A42F925.5090806@rock-chips.com>
Date: Wed, 27 Dec 2017 09:36:37 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
CC: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v12 1/5] dt-bindings: PCI: Add definition of PCIe
 WAKE# irq and PCI irq
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com> <20171226023646.17722-2-jeffy.chen@rock-chips.com> <20171226233552.nacwqbpkozmy7n6c@rob-hp-laptop> <3268448.IvXk7OJtIY@aspire.rjw.lan>
In-Reply-To: <3268448.IvXk7OJtIY@aspire.rjw.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael and Rob,

Thanks for your reply.

On 12/27/2017 08:43 AM, Rafael J. Wysocki wrote:
> On Wednesday, December 27, 2017 12:35:52 AM CET Rob Herring wrote:
>> >On Tue, Dec 26, 2017 at 10:36:42AM +0800, Jeffy Chen wrote:
>>> > >We are going to handle PCIe WAKE# pin for PCI devices in the pci core,
>>> > >so add definitions of the optional PCIe WAKE# pin for PCI devices.
>>> > >
>>> > >Also add an definition of the optional PCI interrupt pin for PCI
>>> > >devices to distinguish it from the PCIe WAKE# pin.
>> >
>> >By v13 you should drop "RFC". RFC implies not ready for merging.
> Which very much still is the case AFAICS.
>
maybe i should split this series, and send dt-binding patch and the pci 
irq parsing patch along without RFC ?

> Thanks,
> Rafael
>
>
>
>
