Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdIKTYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Sep 2017 15:24:44 -0400
MIME-Version: 1.0
In-Reply-To: <20170911151029.25185-3-jeffy.chen@rock-chips.com>
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com> <20170911151029.25185-3-jeffy.chen@rock-chips.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 11 Sep 2017 14:24:21 -0500
Message-ID: <CAL_Jsq+n7B3d0BibVxj5yCTZuxJ_QYp9b0CGwc9envu9G8nSJA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: PCI: Add definition of pcie wake irq
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 11, 2017 at 10:10 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Add an optional interrupt for PCIE_WAKE pin.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v5:
> Move to pci.txt
>
> Changes in v3: None
> Changes in v2: None
>
>  Documentation/devicetree/bindings/pci/pci.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
