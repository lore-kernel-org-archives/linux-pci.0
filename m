Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:38105 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbcEXKDK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2016 06:03:10 -0400
Date: Tue, 24 May 2016 12:06:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc: "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"Levy, Amir (Jer)" <amir.jer.levy@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Svahn, Kai" <kai.svahn@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Jamet, Michael" <michael.jamet@intel.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>,
	"Alloun, Dan" <dan.alloun@intel.com>,
	"Westerberg, Mika" <mika.westerberg@intel.com>
Subject: Re: [PATCH 1/6] thunderbolt: Updating the register definitions
Message-ID: <20160524100631.GA5396@wunner.de>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <1463993336-2750-2-git-send-email-amir.jer.levy@intel.com>
 <1463998286.31269.24.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1463998286.31269.24.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andriy, Hi Amir,

On Mon, May 23, 2016 at 10:10:11AM +0000, Shevchenko, Andriy wrote:
> On Mon, 2016-05-23 at 11:48 +0300, Amir Levy wrote:
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2618,6 +2618,8 @@
> >  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE  0x156b
> >  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI     0x156c
> >  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE  0x156d
> 
> > +#define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_NHI        0x157d
> > +#define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_BRIDGE     0x157e
> 
> Are those IDs going to be used somewhere else than one driver?

We have a number of Thunderbolt quirks in drivers/pci/quirks.c.
Although they do not pertain to Win Ridge right now, it's good to have
the list complete.

However the list should be sorted numerically, so these should go below
Alpine Ridge. I assume Win Ridge is DSL5110, so a comment would be good
to signify that it's not Thunderbolt 2 or 3, e.g.:

#define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_NHI        0x157d /* Tbt 1 Low Pwr */
#define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_BRIDGE     0x157e

Thanks,

Lukas
