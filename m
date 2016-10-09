Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:51499 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbcJIMtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2016 08:49:20 -0400
Date: Sun, 9 Oct 2016 14:49:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/1] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_power hook
Message-ID: <20161009124931.GA8446@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
 <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
 <1475873734.11323.324.camel@linux.intel.com>
 <20161009104626.GA8299@wunner.de>
 <1476014249.11323.329.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1476014249.11323.329.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 09, 2016 at 02:57:29PM +0300, Andy Shevchenko wrote:
> On Sun, 2016-10-09 at 12:46 +0200, Lukas Wunner wrote:
> > On Fri, Oct 07, 2016 at 11:55:34PM +0300, Andy Shevchenko wrote:
> > > 
> > > On Thu, 2016-10-06 at 08:24 +0200, Lukas Wunner wrote:
> > > > 
> > > > +
> > > > +	reg = (id * LSS_PWS_BITS) / 32;
> > > > +	bit = (id * LSS_PWS_BITS) % 32;
> > > > +	power = mid_pwr_get_state(pwr, reg);
> > > > +	return (power >> bit) & 3;
> > > 
> > > Don't add sparse warnings:
> > > 
> > >         return (__force pci_power_t)((power >> bit) & 3);
> > 
> > I do not get any different sparse warnings with or without the cast
> > despite using -Wsparse-all.  This is with sparse 0.5.0 as included in
> > Debian stretch.
> > 
> > With which options and sparse version did you manage to get new
> > warnings?
> 
> $ sparse --version
> v0.5.0
> 
> $ make C=1 CF=-D__CHECK_ENDIAN__ W=1 -j64 
> 
> Warning itself:
> 
> arch/x86/platform/intel-mid/pwr.c:305:31: warning: incorrect type in
> return expression (different base types)
> arch/x86/platform/intel-mid/pwr.c:305:31:    expected restricted
> pci_power_t
> arch/x86/platform/intel-mid/pwr.c:305:31:    got unsigned int

Okay, -D__CHECK_ENDIAN__ was necessary to reproduce the warning.
Thanks for replying so quickly, much appreciated.

Lukas
