Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:53994 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbaBKAiS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2014 19:38:18 -0500
Received: by mail-ie0-f178.google.com with SMTP id rl12so883422iec.9
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2014 16:38:17 -0800 (PST)
Date: Mon, 10 Feb 2014 17:38:14 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: David Miller <davem@davemloft.net>
Cc: agordeev@redhat.com, linux-kernel@vger.kernel.org,
	mchan@broadcom.com, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/34] bnx2: Use pci_enable_msix_range()
Message-ID: <20140211003814.GC12851@google.com>
References: <cover.1391172839.git.agordeev@redhat.com>
 <434a34e01c353441131204edef36126a95e8928a.1391172839.git.agordeev@redhat.com>
 <20140131.133051.483295479425700960.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140131.133051.483295479425700960.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 31, 2014 at 01:30:51PM -0800, David Miller wrote:
> 
> Please submit this patch series when the net-next tree opens back up,
> I'm only accepting bug fixes at this time.
> 
> Also, please always provide a proper "00/NN" openning posting for a
> patch series, that gives background and high level information about
> what your patch series is trying to achieve and how it achieves it.
> 
> That way people reviewing the patches know what to expect, and why,
> and I have exactly one posting to reply to if I apply the whole
> series.

I *think* this whole series applies to drivers/net (the usual patch sending
tools like "stg mail" insert the diffstat automatically in the 00/nn
message), and it sounds like David is willing to apply them via his tree,
so I'm ignoring these for now.  Let me know if you need me to do anything.

Bjorn
