Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52841 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755871Ab2DZRFj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 13:05:39 -0400
Date: Thu, 26 Apr 2012 13:05:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Calin Demian <c.demian20@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
In-Reply-To: <CAD52pS--R8Ob14doabyqU7JBd96VQ-TqL5cdy4GW0k+gmFgpzg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1204261304020.1530-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 26 Apr 2012, Calin Demian wrote:

> Yes, it's ok. Thank you.
> Nevertheless, I think I will try to find out exactly what's happening.

Okay.  It may be that your hardware never turns on the HCR bit in the 
first place.

Remember, there will be no problem merging that patch, if it helps your
system.

Alan Stern

