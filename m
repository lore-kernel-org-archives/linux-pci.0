Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbcHaL3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2016 07:29:10 -0400
Date: Wed, 31 Aug 2016 13:29:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Amir Levy <amir.jer.levy@intel.com>
Cc: andreas.noever@gmail.com, bhelgaas@google.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        thunderbolt-linux@intel.com, mika.westerberg@intel.com,
        tomas.winkler@intel.com
Subject: Re: [PATCH v6 3/8] thunderbolt: Kconfig for Thunderbolt(TM)
 networking
Message-ID: <20160831112914.GC17607@kroah.com>
References: <1470054233-4309-1-git-send-email-amir.jer.levy@intel.com>
 <1470054233-4309-4-git-send-email-amir.jer.levy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470054233-4309-4-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 01, 2016 at 03:23:48PM +0300, Amir Levy wrote:
> Updating the Kconfig Thunderbolt(TM) description.

Why are you inserting a (TM) in here?  Do you see that in any other
kernel Kconfig file?  Please don't start adding it here, it's not
needed from what I can tell.

thanks,

greg k-h
