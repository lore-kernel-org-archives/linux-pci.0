Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32991 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932642AbcKWE5C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 23:57:02 -0500
Received: by mail-pf0-f177.google.com with SMTP id d2so916551pfd.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2016 20:57:02 -0800 (PST)
Date: Tue, 22 Nov 2016 20:56:58 -0800
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 3/3] PCI: rockchip: Add system PM support
Message-ID: <20161123045658.GB28948@google.com>
References: <1479863953-123874-1-git-send-email-shawn.lin@rock-chips.com>
 <1479863953-123874-3-git-send-email-shawn.lin@rock-chips.com>
 <20161123020835.GB119441@google.com>
 <1c4bd848-67f7-0d31-6392-d9550e4767a9@rock-chips.com>
 <20161123024527.GA18020@google.com>
 <bf970e48-80a0-7a18-4d87-93a5748f01c2@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <bf970e48-80a0-7a18-4d87-93a5748f01c2@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 10:51:50AM +0800, Shawn Lin wrote:
> 在 2016/11/23 10:45, Brian Norris 写道:
> >I'm not sure if that's necessary. I was just curious on how this got
> >determined, when it seemed that 500ms was plenty.
> >
> 
> Refer to https://lists.launchpad.net/kernel-packages/msg123315.html
> 
> "When the host (Linux/Driver) sends the PME_TURN_OFF message it should
> wait for PME_TO_ACK from the device. Microsoft Windows versions
> typically wait for 5 seconds."
> 
> This is the reason for why I added 5s for timeout.

Huh, good find. Seems like something that could go in either the commit
message or the comments.

FWIW, that bug report seems to also be related to the question at hand
-- how to handle L2 link state entry. That bug notes that Linux "doesn't
wait for PME_TO_ACK from the device", but AFAICT, Linux PCI drivers
don't typically send PME_TURN_OFF at all.

So right now, we're just relying on our platform suspend code like this.
It'd be interesting to know if other root complexes had programmable
Message Request support like this available to the host CPU, or if they
all have something hardcoded into their BIOS/ACPI support or something
(or just don't use PME_TURN_OFF at all).

Anyway, I guess that's just a future-work question, in case we want to
consolidate support like this into the PCI core framework.

Brian
