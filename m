Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32006 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeDIOeO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Apr 2018 10:34:14 -0400
Date: Mon, 9 Apr 2018 08:37:05 -0600
From: Keith Busch <keith.busch@intel.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2 6/7] PCI/AER: API for obtaining AER information
Message-ID: <20180409143704.GO10098@localhost.localdomain>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-7-keith.busch@intel.com>
 <bc217ceacda04d9884331f5b6bff30d3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc217ceacda04d9884331f5b6bff30d3@AcuMS.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:03:14AM +0000, David Laight wrote:
> 
> Should there be an EXPORT_SYMBOL(aer_get_device_error_info) here?
> (preferable without _GPL).
> 
> 	David

That's necessary only if a module is using the symbol. All existing and
proposed users are built-in, so no need to export it at this time.
