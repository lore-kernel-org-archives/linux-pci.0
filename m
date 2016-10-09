Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:53365 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbcJIKqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2016 06:46:15 -0400
Date: Sun, 9 Oct 2016 12:46:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/1] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_power hook
Message-ID: <20161009104626.GA8299@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
 <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
 <1475873734.11323.324.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1475873734.11323.324.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 11:55:34PM +0300, Andy Shevchenko wrote:
> On Thu, 2016-10-06 at 08:24 +0200, Lukas Wunner wrote:
> > +
> > +	reg = (id * LSS_PWS_BITS) / 32;
> > +	bit = (id * LSS_PWS_BITS) % 32;
> > +	power = mid_pwr_get_state(pwr, reg);
> > +	return (power >> bit) & 3;
> 
> Don't add sparse warnings:
> 
>         return (__force pci_power_t)((power >> bit) & 3);

I do not get any different sparse warnings with or without the cast
despite using -Wsparse-all.  This is with sparse 0.5.0 as included in
Debian stretch.

With which options and sparse version did you manage to get new warnings?

Thanks,

Lukas
