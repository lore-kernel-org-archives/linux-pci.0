Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeCNLtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 07:49:49 -0400
Date: Wed, 14 Mar 2018 12:49:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <richard.leitner@skidata.com>
Cc: Richard Leitner <dev@g0hl1n.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mathias.nyman@intel.com, bhelgaas@google.com
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
Message-ID: <20180314114948.GA25368@kroah.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net>
 <20180314104849.GB32615@kroah.com>
 <d755d623-2bb3-460f-45a0-2be6ab6f47ea@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d755d623-2bb3-460f-45a0-2be6ab6f47ea@skidata.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:36:17PM +0100, Richard Leitner wrote:
> 
> On 03/14/2018 11:48 AM, Greg KH wrote:
> > On Wed, Mar 14, 2018 at 11:29:32AM +0100, Richard Leitner wrote:
> >> From: Richard Leitner <richard.leitner@skidata.com>
> >>
> >> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
> >> pci_ids.h
> > 
> > Why?  It's only being used in one file, so it should not be in
> > pci_ids.h, right?
> 
> It's also used as PCI_VENDOR_NETLOGIC in arch/mips/netlogic/xlp/.
> 
> Should this be replaced with PCI_VENDOR_ID_NETLOGIC from pci_ids.h?

Yes, if you are going to add it to pci_ids.h, it had better be used by
multiple files, otherwise it does not belong in there.

thanks,

greg k-h
