Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14578 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750701AbcJIL6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Oct 2016 07:58:46 -0400
Message-ID: <1476014249.11323.329.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_power hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org
Date: Sun, 09 Oct 2016 14:57:29 +0300
In-Reply-To: <20161009104626.GA8299@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
         <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
         <1475873734.11323.324.camel@linux.intel.com>
         <20161009104626.GA8299@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2016-10-09 at 12:46 +0200, Lukas Wunner wrote:
> On Fri, Oct 07, 2016 at 11:55:34PM +0300, Andy Shevchenko wrote:
> > 
> > On Thu, 2016-10-06 at 08:24 +0200, Lukas Wunner wrote:
> > > 
> > > +
> > > +	reg = (id * LSS_PWS_BITS) / 32;
> > > +	bit = (id * LSS_PWS_BITS) % 32;
> > > +	power = mid_pwr_get_state(pwr, reg);
> > > +	return (power >> bit) & 3;
> > 
> > Don't add sparse warnings:
> > 
> >         return (__force pci_power_t)((power >> bit) & 3);
> 
> I do not get any different sparse warnings with or without the cast
> despite using -Wsparse-all.  This is with sparse 0.5.0 as included in
> Debian stretch.
> 
> With which options and sparse version did you manage to get new
> warnings?

$ sparse --version
v0.5.0

$ make C=1 CF=-D__CHECK_ENDIAN__ W=1 -j64 

Warning itself:

arch/x86/platform/intel-mid/pwr.c:305:31: warning: incorrect type in
return expression (different base types)
arch/x86/platform/intel-mid/pwr.c:305:31:    expected restricted
pci_power_t
arch/x86/platform/intel-mid/pwr.c:305:31:    got unsigned int


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
