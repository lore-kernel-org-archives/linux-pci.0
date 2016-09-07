Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:40621 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757770AbcIGN2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2016 09:28:24 -0400
Date: Wed, 7 Sep 2016 15:28:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv2 0/4] Limiting pci access requsets
Message-ID: <20160907132829.GA28400@wunner.de>
References: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 04:00:15PM -0600, Keith Busch wrote:
> Here's version two of this, and is even more aggressive than before
> about reducing access that we know will end in failure.

I've briefly tested the whole series with Thunderbolt on the Mac
(which uses native pciehp, unlike the firmware-based Thunderbolt
on non-Macs, which somehow interfaces with the OS with acpiphp),
i.e. plug/unplug, suspend/resume. Everything still seems to work
as before, found no regressions, so this is

Tested-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas
