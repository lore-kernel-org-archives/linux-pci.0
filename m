Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44076 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168245AbcKAJev (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2016 05:34:51 -0400
Date: Tue, 1 Nov 2016 09:34:35 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Scott Branden <sbranden@broadcom.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] PCI: Warn on possible RW1C corruption for sub-32 bit
 config writes
Message-ID: <20161101093435.GO1041@n2100.armlinux.org.uk>
References: <20161031213902.6340.96123.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161031213902.6340.96123.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 31, 2016 at 04:39:02PM -0500, Bjorn Helgaas wrote:
> Hardware that supports only 32-bit config writes is not spec-compliant.
> For example, if software performs a 16-bit write, we must do a 32-bit read,
> merge in the 16 bits we intend to write, followed by a 32-bit write.  If
> the 16 bits we *don't* intend to write happen to have any RW1C (write-one-
> to-clear) bits set, we just inadvertently cleared something we shouldn't
> have.
> 
> Add a rate-limited warning when we do sub-32 bit config writes.  Remove
> similar probe-time warnings from some of the affected host bridge drivers.

Yay, I've been on about this for ages...

Enthusiastically-Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
