Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:63331 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934883Ab3BTIIl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Feb 2013 03:08:41 -0500
Message-ID: <1361347716.1341.9.camel@x61.thuisdomein>
Subject: Re: pciehp: errors on resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Oliver Neukum <oneukum@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Wed, 20 Feb 2013 09:08:36 +0100
In-Reply-To: <5124284e.09d80e0a.294a.ffff9ee6SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1359377173.1345.25.camel@x61.thuisdomein>
	 <512336fb.42d70e0a.73ed.ffffc77eSMTPIN_ADDED_BROKEN@mx.google.com>
	 <1361266095.26423.19.camel@x61.thuisdomein>
	 <5124284e.09d80e0a.294a.ffff9ee6SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Richard,

On Wed, 2013-02-20 at 09:34 +0800, Wei Yang wrote:
> I hope I can have similar devices, so I can reproduce it. Since I am not very
> familiar with the process.

Well, here it is triggered by the combination of this port
    00:1c.1 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 [8086:2841] (rev 03)

with this card
    03:00.0 Network controller [0280]: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection [8086:4230] (rev 61)

(The first PCIE port is apparently unused on this machine. I assume it's
meant for a WWAN card, which I don't use.)

But feel free to post some code here. I'm fine with testing any
reasonable solution.


Paul Bolle

