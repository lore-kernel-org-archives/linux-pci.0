Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29937 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbcEXJtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2016 05:49:02 -0400
From: "Levy, Amir (Jer)" <amir.jer.levy@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Jamet, Michael" <michael.jamet@intel.com>,
	"Alloun, Dan" <dan.alloun@intel.com>,
	"Westerberg, Mika" <mika.westerberg@intel.com>,
	"Svahn, Kai" <kai.svahn@intel.com>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH 1/6] thunderbolt: Updating the register definitions
Date: Tue, 24 May 2016 09:48:56 +0000
Message-ID: <E607265CB020454880711A6F96C05A0377FBC679@hasmsx107.ger.corp.intel.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <1463993336-2750-2-git-send-email-amir.jer.levy@intel.com>
 <20160523144006.GA28980@kroah.com>
In-Reply-To: <20160523144006.GA28980@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Monday, May 23, 2016 17:40
> To: Levy, Amir (Jer) <amir.jer.levy@intel.com>
> Cc: andreas.noever@gmail.com; bhelgaas@google.com; linux-
> pci@vger.kernel.org; Jamet, Michael <michael.jamet@intel.com>; Alloun,
> Dan <dan.alloun@intel.com>; Westerberg, Mika
> <mika.westerberg@intel.com>; Svahn, Kai <kai.svahn@intel.com>;
> Shevchenko, Andriy <andriy.shevchenko@intel.com>; Winkler, Tomas
> <tomas.winkler@intel.com>
> Subject: Re: [PATCH 1/6] thunderbolt: Updating the register definitions
> 
> On Mon, May 23, 2016 at 11:48:51AM +0300, Amir Levy wrote:
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2618,6 +2618,8 @@
> >  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE  0x156b
> >  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI     0x156c
> >  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE  0x156d
> > +#define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_NHI        0x157d
> > +#define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_BRIDGE     0x157e
> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_NHI     0x1575 /*
> Thunderbolt 3 */
> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE  0x1576
> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
> 
> Please read the top of this file for why you shouldn't be adding new ids to it.

I missed the comment in top of this file, just wanted that the thunderbolt device list will be complete. 
I'll revert the 2 new entries.
Note that the instruction in this file wasn't kept even before this patch.

Thanks,
Amir
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

