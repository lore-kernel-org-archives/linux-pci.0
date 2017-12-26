Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41830 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdLZXf4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Dec 2017 18:35:56 -0500
Date: Tue, 26 Dec 2017 17:35:52 -0600
From: Rob Herring <robh@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v12 1/5] dt-bindings: PCI: Add definition of PCIe
 WAKE# irq and PCI irq
Message-ID: <20171226233552.nacwqbpkozmy7n6c@rob-hp-laptop>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
 <20171226023646.17722-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171226023646.17722-2-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 26, 2017 at 10:36:42AM +0800, Jeffy Chen wrote:
> We are going to handle PCIe WAKE# pin for PCI devices in the pci core,
> so add definitions of the optional PCIe WAKE# pin for PCI devices.
> 
> Also add an definition of the optional PCI interrupt pin for PCI
> devices to distinguish it from the PCIe WAKE# pin.

By v13 you should drop "RFC". RFC implies not ready for merging.

> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v13: None
> Changes in v12:
> Only add irq definitions for PCI devices and rewrite the commit message.
> 
> Changes in v11: None
> Changes in v10: None
> Changes in v9:
> Add section for PCI devices and rewrite the commit message.
> 
> Changes in v8:
> Add optional "pci", and rewrite commit message.
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5:
> Move to pci.txt
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
