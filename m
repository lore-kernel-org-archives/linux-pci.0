Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 30 Sep 2014 14:35:51 -0700
From: Guenter Roeck <groeck@juniper.net>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Rajat Jain <rajatjain@juniper.net>
Subject: Re: [PATCH 0/4] Driver for talking to PLX PEX8xxx PCIe switch over
 I2C
Message-ID: <20140930213306.GA29008@svl-evodev-groeck.juniper.net>
References: <542A3593.4020108@gmail.com>
 <CAErSpo7BkXDHOZwHzwEu2BN3=39xFwQOyrjgVo6afWKMsnYT=A@mail.gmail.com>
 <20140930211339.GA1264@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140930211339.GA1264@katana>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 30, 2014 at 11:13:39PM +0200, Wolfram Sang wrote:
> 
> > > Since this is a driver for a PCIe switch, I currently put it under /driver/pci/.
> > > I'm very open to suggestions for moving this around (Does introducing
> > > drivers/pci/switch/ seem any better?). Especially I can see that the
> > > drivers/pci/Kconfig appears under "Bus Options" in the main menu which does not
> > > look like the right place for this driver. I am looking for suggestions here.
> > 
> > Definitely interesting work.  I have no idea where to put it.  It
> > doesn't have anything to do with PCI core services or structures, so
> > drivers/pci doesn't seem like the ideal place for it, but I don't have
> > any better ideas.  If it did end up under drivers/pci, I agree that a
> > drivers/pci/switch or something similar would probably be better than
> > having it directly in drivers/pci.
> > 
> > Maybe Wolfram or other I2C folks will have an idea.
> 
> Hmm, is this a common interface for those switches? Then a directory
> like drivers/pci/switch could make sense. Otherwise I'd suggest
> drivers/misc?
> 
We had discussed drivers/misc internally, but it didn't seem to be the right
location to me. After all, it is not a misc driver, but a driver to configure
a PCIe switch. Not that I have a better idea, though.

Guenter
