Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:62370 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbcGTGDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2016 02:03:13 -0400
From: "Levy, Amir (Jer)" <amir.jer.levy@intel.com>
To: Joe Perches <joe@perches.com>,
	"andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	thunderbolt-linux <thunderbolt-linux@intel.com>,
	"Westerberg, Mika" <mika.westerberg@intel.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH v4 0/7] thunderbolt: Introducing Thunderbolt(TM)
 networking
Date: Wed, 20 Jul 2016 06:02:57 +0000
Message-ID: <E607265CB020454880711A6F96C05A03893D2493@hasmsx107.ger.corp.intel.com>
References: <1468836040-28043-1-git-send-email-amir.jer.levy@intel.com>
 <1468948445.1900.53.camel@perches.com>
In-Reply-To: <1468948445.1900.53.camel@perches.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 19 2016, 08:14 PM, Joe Perches wrote:
> On Mon, 2016-07-18 at 13:00 +0300, Amir Levy wrote:
> > This is version 4 of Thunderbolt(TM) driver for non-Apple hardware.
> []
> >  Documentation/00-INDEX                   |    2 +
> >  Documentation/thunderbolt-networking.txt |  135 ++
> >  drivers/thunderbolt/Kconfig              |   25 +-
> >  drivers/thunderbolt/Makefile             |    3 +-
> >  drivers/thunderbolt/icm/Makefile         |   28 +
> >  drivers/thunderbolt/icm/icm_nhi.c        | 1642 +++++++++++++++++++++
> >  drivers/thunderbolt/icm/icm_nhi.h        |   93 ++
> >  drivers/thunderbolt/icm/net.c            | 2276
> > ++++++++++++++++++++++++++++++
> >  drivers/thunderbolt/icm/net.h            |  274 ++++
> >  drivers/thunderbolt/nhi_regs.h           |  115 +-
> >  10 files changed, 4585 insertions(+), 8 deletions(-)
> >  create mode 100644 Documentation/thunderbolt-networking.txt
> >  create mode 100644 drivers/thunderbolt/icm/Makefile
> >  create mode 100644 drivers/thunderbolt/icm/icm_nhi.c
> >  create mode 100644 drivers/thunderbolt/icm/icm_nhi.h
> >  create mode 100644 drivers/thunderbolt/icm/net.c
> >  create mode 100644 drivers/thunderbolt/icm/net.h
> 
> Is a MAINTAINERS update necessary or is Andreas going to be the
> maintainer?

Now that the drivers are completely separated it make sense that 
I'll maintain the thunderbolt/icm driver,  if there are no objections.
