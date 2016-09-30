Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56143 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934757AbcI3GaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2016 02:30:03 -0400
Date: Fri, 30 Sep 2016 08:30:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Miller <davem@davemloft.net>
Cc: amir.jer.levy@intel.com, andreas.noever@gmail.com,
        bhelgaas@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, mario_limonciello@dell.com,
        thunderbolt-linux@intel.com, mika.westerberg@intel.com,
        tomas.winkler@intel.com, xiong.y.zhang@intel.com
Subject: Re: [PATCH v8 0/8] thunderbolt: Introducing Thunderbolt(TM)
 Networking
Message-ID: <20160930063005.GA7571@kroah.com>
References: <1475073870-2126-1-git-send-email-amir.jer.levy@intel.com>
 <20160930.015555.2177533749954623343.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160930.015555.2177533749954623343.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 30, 2016 at 01:55:55AM -0400, David Miller wrote:
> From: Amir Levy <amir.jer.levy@intel.com>
> Date: Wed, 28 Sep 2016 17:44:22 +0300
> 
> > This driver enables Thunderbolt Networking on non-Apple platforms
> > running Linux.
> 
> Greg, any idea where this should get merged once fully vetted?  I can
> take it through the net-next tree, but I'm fine with another more
> appropriate tree taking it as well.

I am supposed to be taking thunderbolt patches, but if this really is a
network driver, it should go under drivers/net/ somewhere.  It needs
more review though, it's not ready to go through anyone's tree just yet :)

I'll let the thunderbolt maintainer go through it first before asking
for a netdev review.

thanks,

greg k-h
