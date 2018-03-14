Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeCNKsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 06:48:50 -0400
Date: Wed, 14 Mar 2018 11:48:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <dev@g0hl1n.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mathias.nyman@intel.com,
        bhelgaas@google.com, richard.leitner@skidata.com
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
Message-ID: <20180314104849.GB32615@kroah.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314102933.21367-3-dev@g0hl1n.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:29:32AM +0100, Richard Leitner wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
> pci_ids.h

Why?  It's only being used in one file, so it should not be in
pci_ids.h, right?

thanks,

greg k-h
