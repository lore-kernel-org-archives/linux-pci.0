Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:33246 "EHLO
        caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755107AbcI2OY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 10:24:26 -0400
Date: Thu, 29 Sep 2016 10:24:24 -0400
To: Steve Kenton <skenton@ou.edu>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        yinghai Lu <yinghai@kernel.org>,
        Blackmagic Developer Support <developer@blackmagicdesign.com>
Subject: Re: lspci not showing motherboard ethernet controller after PCIe
 card firmware update change from 32-bit to 64-bit BAR
Message-ID: <20160929142424.GB14309@csclub.uwaterloo.ca>
References: <2cc60cd1-bab1-a086-2326-7ce161b8f083@ou.edu>
 <efdbf332-841c-7617-efd1-facf785472fd@ou.edu>
 <20160926155018.GL14311@csclub.uwaterloo.ca>
 <68936975-5496-0e0d-5137-d48575e8ec0d@ou.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68936975-5496-0e0d-5137-d48575e8ec0d@ou.edu>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 28, 2016 at 09:05:44AM -0500, Steve Kenton wrote:
> I decided to experiment with /sys/bus/pci and the BIOS settings to try
> and understand things better.
> 
> The BIOS has a settings to enable/disable the on-board LAN. When the
> Blackmagic card firmware is upgraded
> bus[03] and hence the on-board LAN disappears, but the apparently unused
> bus[02] is still visible and
> the BIOS setting is still enabled. When the BIOS LAN settings is
> disabled busses[02][03] and the on-board
> LAN disappear. In both cases, the "disappeared" resources are not
> restored by echo to /sys/.../rescan
> 
> Why? What can the BIOS be doing to the chipset/busses[02][03] to make
> them invisible to /sys manipulation?

It can activate the reset line to the network chip making it never able
to respond to anything.  Or it could even power it off.

And PCIe is point to point, so they are not really busses anymore.
So at least turning off the network chip means no link on that point to
point PCIe link and hence no "bus" there.

> There is apparently something I do not understand about the H81 chipset
> PCIe configuration. I have
> been reading the Intel Series 8 / Series C220 Chipset documentation but
> so far have come up empty.
> 
> Anybody have cluebat for me?

I wish.

-- 
Len Sorensen
