Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:34110 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933209AbeAOLu7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jan 2018 06:50:59 -0500
Subject: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root
 subordinate
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
To: linux-pci <linux-pci@vger.kernel.org>
Cc: Koen Vandeputte <koen.vandeputte@ncentric.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <fcf1e2d5-b31c-9e4f-72e8-54e1e7bb040e@free.fr>
Date: Mon, 15 Jan 2018 12:50:48 +0100
MIME-Version: 1.0
In-Reply-To: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15/01/2018 10:36, Koen Vandeputte wrote:

> The subordinate value indicates the highest bus number which can be
> reached downstream though a certain device.
> 
> Commit a20c7f36bd3d ("PCI: Do not allocate more buses than available in
> parent")
> ensures that downstream devices cannot assign busnumbers higher than the
> upstream device subordinate number, which was indeed illogical.
> 
> By default, dw_pcie_setup_rc() inits the Root Complex subordinate to a
> value of 0x01.
> 
> Due to this combined with above commit, enumeration stops digging deeper
> downstream as soon as bus num 0x01 has been assigned, which is always
> the case for a bridge device.
> 
> This results in all devices behind a bridge bus to remain undetected, as
> these would be connected to bus 0x02 or higher.
> 
> Fix this by initializing the RC to a subordinate value of 0xff, which is
> not altering hardware behaviour in any way, but informs probing
> function pci_scan_bridge() later on which reads this value back from
> register.
> 
> Following nasty errors during boot are also fixed by this:
> 
> [    0.459145] pci_bus 0000:02: busn_res: can not insert [bus 02-ff]
> under [bus 01] (conflicts with (null) [bus 01])
> ...
> [    0.464515] pci_bus 0000:03: [bus 03] partially hidden behind bridge
> 0000:01 [bus 01]
> ...
> [    0.464892] pci_bus 0000:04: [bus 04] partially hidden behind bridge
> 0000:01 [bus 01]
> ...
> [    0.466488] pci_bus 0000:05: [bus 05] partially hidden behind bridge
> 0000:01 [bus 01]
> [    0.466506] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to
> 05
> [    0.466517] pci_bus 0000:02: busn_res: can not insert [bus 02-05]
> under [bus 01] (conflicts with (null) [bus 01])
> [    0.466534] pci_bus 0000:02: [bus 02-05] partially hidden behind
> bridge 0000:01 [bus 01]

FWIW, I find that this wrap-around looks ugly :-p

Regards.
