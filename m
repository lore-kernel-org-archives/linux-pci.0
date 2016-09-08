Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756863AbcIHNqB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Sep 2016 09:46:01 -0400
MIME-Version: 1.0
In-Reply-To: <1472744284-18305-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472744284-18305-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1472744284-18305-4-git-send-email-thomas.petazzoni@free-electrons.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 8 Sep 2016 08:45:35 -0500
Message-ID: <CAL_JsqJHN3VCzs4k_FpQSGr=69B_YcCJDhZxi=poZW-2QNMRvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: pci: remove unused MSI controller helpers
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Nadav Haklai <nadavh@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>, Victor Gu <xigu@marvell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 1, 2016 at 10:38 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> All the users of the small MSI controller API have been migrated to use
> the generic MSI infrastructure instead. We no longer need a global
> chained list of msi_controller. Instead, MSI controllers are now
> represented as irq domains attached to OF nodes, and the resolution
> between a device requesting an MSI and the corresponding MSI controller
> is done by the generic interrupt resolution logic.
>
> Therefore, this API is now completely useless, and can be removed from
> the kernel.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/of/of_pci.c    | 45 ---------------------------------------------
>  include/linux/of_pci.h | 11 -----------
>  2 files changed, 56 deletions(-)

This is to both Bjorn and me, but I'm assuming you want Bjorn to take
the series.

Acked-by: Rob Herring <robh@kernel.org>

Rob
