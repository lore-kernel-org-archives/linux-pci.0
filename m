Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:41600 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752914Ab3LBSHs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2013 13:07:48 -0500
Message-ID: <1386007657.2680.15.camel@joe-AO722>
Subject: Re: [PATCH] pci/checkpatch: Deprecate DEFINE_PCI_DEVICE_TABLE
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonas Bonn <jonas@southpole.se>, Jingoo Han <jg1.han@samsung.com>,
	'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	'Andrew Morton' <akpm@linux-foundation.org>,
	'Andy Whitcroft' <apw@canonical.com>,
	linux-serial@vger.kernel.org
Date: Mon, 02 Dec 2013 10:07:37 -0800
In-Reply-To: <20131202180147.GB31606@roeck-us.net>
References: <1385617213.12210.5.camel@joe-AO722>
	 <20131128055328.GA565@kroah.com> <1385619863.12210.14.camel@joe-AO722>
	 <529C026E.2000302@roeck-us.net>
	 <000f01ceef11$a14acf00$e3e06d00$%han@samsung.com>
	 <529C04C7.9050506@roeck-us.net>
	 <001001ceef13$7fa3ee70$7eebcb50$%han@samsung.com>
	 <1385963295.2680.2.camel@joe-AO722> <529C6495.3020305@southpole.se>
	 <1386006217.2680.13.camel@joe-AO722> <20131202180147.GB31606@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-12-02 at 10:01 -0800, Guenter Roeck wrote:
> On Mon, Dec 02, 2013 at 09:43:37AM -0800, Joe Perches wrote:
> > Prefer use of the direct definition of struct pci_device_id
[]
> > +all-zero entry.  Definitions with static const are generally preferred.

see here:

> Add 'const' ?

Also see $fix.

Not all can be const as some codes actually modify
the tables for various quirks.


