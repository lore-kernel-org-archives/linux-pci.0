Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965496AbcJYARn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Oct 2016 20:17:43 -0400
MIME-Version: 1.0
In-Reply-To: <1476755110-22647-2-git-send-email-shawn.lin@rock-chips.com>
References: <1476755110-22647-1-git-send-email-shawn.lin@rock-chips.com> <1476755110-22647-2-git-send-email-shawn.lin@rock-chips.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Oct 2016 19:17:19 -0500
Message-ID: <CAL_JsqKyGRU3T-gaFwG43zcChHDHUZhsH7Rn5FASrgnc-RBvCw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] of/pci: Add helper function to parse
 max-link-speed from dt
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 8:45 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This new helper function could be used by host drivers to
> get the limitaion of max link speed provided by dt. If the
> property isn't assigned or is invalid, it will return -EINVAL
> to the caller.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Rob Herring <robh@kernel.org>

Rob
