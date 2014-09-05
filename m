Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52217 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754363AbaIEWsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Sep 2014 18:48:00 -0400
Message-ID: <1409952807.11352.37.camel@pasglop>
Subject: Re: [PATCH] pci/msi-x: Sanity check MSI-X table offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, weiyang@linux.vnet.ibm.com
Date: Sat, 06 Sep 2014 07:33:27 +1000
In-Reply-To: <20140905211305.GF8080@google.com>
References: <1407731815.4508.69.camel@pasglop>
	 <20140905211305.GF8080@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-09-05 at 15:13 -0600, Bjorn Helgaas wrote:

> I assume we would just get 0xffffffff if something went wrong, wouldn't we?

It's HW, better safe than sorry. 0xffffffff is the normal case of "the
device isn't talking to you anymore" but all the other cases handled in
my patch are all illegal and might catch buggy/broken devices (which can
be useful if you are just developing such a device in an FPGA for
example).

> If it's possible to get arbitrary bad data, there's no end to the error
> checking we could add when reading config space.

Yeah, though not all of them result in mapping bad addresses ... in this
case the checks are pretty easy and it's not a performance sensitive
path, so while I was initially only checking for ff's I though "screw
it, may as well sanitiy check it all) :-)

> If we can add a minimal check for the value we get if the device has been
> removed or isolated, I'd rather do that than try to validate every field in
> the register.  An error message along the lines of "config read returned
> 0xffffffff" or "can't access device" is probably easier to debug than
> "MSI-X points to non-existing BAR 255" anway.

Ok.

Ben.


