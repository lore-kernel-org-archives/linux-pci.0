Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:51570 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944958AbcJaRIi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2016 13:08:38 -0400
Date: Mon, 31 Oct 2016 13:08:31 -0400 (EDT)
Message-Id: <20161031.130831.2006896157400677867.davem@davemloft.net>
To: jgross@suse.com
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xen.org,
        david.vrabel@citrix.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jarkko.sakkinen@linux.intel.com,
        jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        wei.liu2@citrix.com, paul.durrant@citrix.com,
        netdev@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, tomi.valkeinen@ti.com,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 00/12] xen: add common function for reading optional
 value
From: David Miller <davem@davemloft.net>
In-Reply-To: <1477932510-28594-1-git-send-email-jgross@suse.com>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Juergen Gross <jgross@suse.com>
Date: Mon, 31 Oct 2016 17:48:18 +0100

> There are multiple instances of code reading an optional unsigned
> parameter from Xenstore via xenbus_scanf(). Instead of repeating the
> same code over and over add a service function doing the job and
> replace the call of xenbus_scanf() with the call of the new function
> where appropriate.

As this seems to be a series that will go through some tree other
than mine, I assume the networking bits will be taken care of that
way.
