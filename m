Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:42799 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751671AbcHGPeB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Aug 2016 11:34:01 -0400
Date: Sun, 7 Aug 2016 11:33:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Lukas Wunner <lukas@wunner.de>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	<linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 11/13] PM / sleep: Allow opt-out from runtime resume
 after direct-complete
In-Reply-To: <20160807095627.GB5679@wunner.de>
Message-ID: <Pine.LNX.4.44L0.1608071105360.31680-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 7 Aug 2016, Lukas Wunner wrote:

> Normally the device hierarchy is traversed bottom-up during suspend
> and top-down during resume. However ->prepare and ->complete do it
> the other way round. In the case of ->prepare, this is even documented
> in Documentation/power/devices.txt but the reason thereof is not.
> Could you explain this please?

The purpose of ->prepare is to tell drivers that a system sleep is
beginning and accordingly they should stop registering new children.  
This is necessary for the PM core to be able to traverse the entire
device tree safely; we want to avoid races where a new child is added
below a device concurrently with that device being suspended.  (Or if
you want to be more precise, races in which a new child is added below
a device while the PM core is acquiring the device's lock just prior to
invoking its ->suspend callback.)

Telling drivers to stop registering new children below a device has to
be done top-down, because if it were done bottom-up then it would be
subject to the same race described above.  Doing it top-down avoids 
problems; if a device registers new children while the PM core is 
acquiring its lock prior to invoking ->prepare, it doesn't matter.  The 
new children will be handled later, right along with the existing ones.

Alan Stern

