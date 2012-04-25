Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39315 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752811Ab2DYPWo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2012 11:22:44 -0400
Date: Wed, 25 Apr 2012 11:22:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Calin Demian <c.demian20@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
In-Reply-To: <CAD52pS8YbbgBGt_C8kTWfZWn0-CEiHUVBP+gC=wPid9kgAMQCw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1204251121000.1471-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 25 Apr 2012, Calin Demian wrote:

> I have reported the issue in bugzilla, before (bug 43073). Because the
> problem does not appear every time, I am able to boot with new kernels
> (sometimes).
> I also found that the problem is triggered by a specific sequence of
> io read/write operations (including the software reset) related to the
> host controller (during init) and by changing the operations or
> inserting delays between them it can be solved.

What delays do you need, and where should they be inserted?

Alan Stern

