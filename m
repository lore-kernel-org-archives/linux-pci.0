Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeCONWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2018 09:22:14 -0400
Date: Thu, 15 Mar 2018 14:22:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180315132213.GA8629@kroah.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-6-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308133331.19464-6-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 08, 2018 at 02:33:30PM +0100, Niklas Cassel wrote:
> A 64-bit BAR consists of a BAR pair, where the second BAR has the
> upper bits, so we cannot simply call pci_ioremap_bar() on every single
> BAR index.
> 
> The second BAR in a BAR pair will not have the IORESOURCE_MEM resource
> flag set. Only call ioremap on BARs that have the IORESOURCE_MEM
> resource flag set.
> 
> pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR1
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR3
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR5
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Where are the 4 other patches in this series?  I can't just only apply
the last one, right?

Please be careful when sending patches to properly notify everyone...

this is now dropped from my patch queue.

greg k-h
