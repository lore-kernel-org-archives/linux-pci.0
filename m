Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7804 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932659AbcKGQUL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Nov 2016 11:20:11 -0500
Date: Mon, 7 Nov 2016 08:20:08 -0800
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: David Vrabel <david.vrabel@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xen.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        tpmdd-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, wei.liu2@citrix.com,
        paul.durrant@citrix.com, netdev@vger.kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 00/12] xen: add common function for reading optional value
Message-ID: <20161107162008.a2x2lgn3syvv7m23@intel.com>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
 <8d314b86-4a28-5628-2a79-842a2fafc4c1@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8d314b86-4a28-5628-2a79-842a2fafc4c1@citrix.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 07, 2016 at 11:08:09AM +0000, David Vrabel wrote:
> On 31/10/16 16:48, Juergen Gross wrote:
> > There are multiple instances of code reading an optional unsigned
> > parameter from Xenstore via xenbus_scanf(). Instead of repeating the
> > same code over and over add a service function doing the job and
> > replace the call of xenbus_scanf() with the call of the new function
> > where appropriate.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> 
> Please queue for the next release.

If you want this change to tpmdd, please resend it to tpmdd mailing
list and CC it to linux-security-module. Thanks.

> David

/Jarkko
