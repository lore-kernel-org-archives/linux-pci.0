Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36362 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965567AbcIVVOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 17:14:40 -0400
Received: by mail-pf0-f182.google.com with SMTP id q2so34214766pfj.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Sep 2016 14:14:40 -0700 (PDT)
Date: Thu, 22 Sep 2016 14:14:37 -0700
From: Brian Norris <briannorris@chromium.org>
To: Rajat Jain <rajatja@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>
Subject: Re: [PATCH] rockchip: Increase the Max Credit update interval.
Message-ID: <20160922211436.GA69457@google.com>
References: <1474578027-64292-1-git-send-email-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474578027-64292-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(Nit: I think the $subject is typically 'PCI: rockchip: ...'.)

Hi Rajat,

On Thu, Sep 22, 2016 at 02:00:27PM -0700, Rajat Jain wrote:
> The register value gets lost on a Link speed/width change, and the
> ideal fix should reprogram this on that event (refer "Link Bandwidth
> Management Interrupt Enable" & "Link Autonomous Bandwidth Interrupt Enable"
> in link control reg?).

Oh, that that reminds me (sorry for not noticing this earlier): Rockchip
did add handling of those two interrupt bits. See:

        } else if (reg & PCIE_CLIENT_INT_PHY) {
                dev_dbg(dev, "phy link changes\n");
                rockchip_pcie_clr_bw_int(rockchip);
        }

Do you ever see such interrupts? In any case, it's possible we could do
the re-programming there, just to be sure, though I'm not sure we can
test it well.

Brian
