Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0133.outbound.protection.outlook.com ([207.46.100.133]:45856
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750901AbaJAUOr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 16:14:47 -0400
Date: Wed, 1 Oct 2014 12:41:15 -0700
From: Guenter Roeck <groeck@juniper.net>
To: Danielle Costantino <danielle.costantino@gmail.com>
CC: linux-i2c <linux-i2c@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Rajat Jain <rajatjain@juniper.net>
Subject: Re: Fwd: [Proposal] PM sleep children of inactive I2C bus segments
 off Masters in multi-master systems
Message-ID: <20141001194115.GA6948@svl-evodev-groeck.juniper.net>
References: <CAAVjN7dwS62EKMnuZc_P1UjkbRVk6RXqJ91GwWZ96bbY5Ct-rg@mail.gmail.com>
 <CAAVjN7eUmBVcAGPbcn3qsJ9M9uu2nkFoKHqGhhKGekZSceGiMw@mail.gmail.com>
 <20141001184304.GA6832@svl-evodev-groeck.juniper.net>
 <CAAVjN7edpkXYMHBm+wLegA_pc0hnm_YZf_z=Ni3h=EbDTmfegQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAAVjN7edpkXYMHBm+wLegA_pc0hnm_YZf_z=Ni3h=EbDTmfegQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 01, 2014 at 11:44:59AM -0700, Danielle Costantino wrote:
> Re-sending Proposal:
> 
> Currently I2C mux devices that support multiple master arbitration are
> the i2c-mux-pca9541 and i2c-arb-gpio-challenge drivers. I propose to
> add the ability to configure an interrupt pin from the Master Selector
> device to indicate that bus ownership has been lost. Once the device
> loses ownership, all of its children should enter a pm sleep mode (as
> you can't talk to them at this point) until master-ship has been
> reacquired.
> 
Not sure I understand what you are proposing here.

A typical use case would be a power supply such as the one supported by
drivers/hwmon/lineage-pem.c from both an active and standby system
controller. The power supply needs to be accessible from both controllers.
If one controller looses access, it can only mean that it did not follow
the access protocol. Similar, one controller enforcing access means that
it either does not follow the access protocol either, or that the other
end did not follow the protocol (or maybe the other end died).

In all cases, loss of access does not mean that the end device can or should
be put in sleep mode, not even logically. All it means is that there was
an access protocol error. Not sure if there is anything that can be done
about that, but putting the device into sleep mode does not seem to be
an appropriate response to me.

> This has come up as an issue when the master loses control over a bus
> the return code of all transactions to its lave devices is EIO (not
> very helpful).
> 
But, again, doesn't that mean that there was some access protocol error ?
Shouldn't it try to re-acquire mastership instead, and block all accesses
to slaves until it acquired it ?

Thanks,
Guenter
