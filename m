Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36053 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab3H0Q1H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 12:27:07 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so5093530pde.37
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 09:27:06 -0700 (PDT)
Date: Tue, 27 Aug 2013 10:27:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCIe endpoint crosstalk
Message-ID: <20130827162702.GB21180@google.com>
References: <521C5AFF.90209@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <521C5AFF.90209@desy.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 27, 2013 at 09:53:35AM +0200, Ludwig Petrosyan wrote:
> So: I use microTCA system with PCIe bus, there are two AMC cards (PCIe
> endpoints), lets call card A and card B.
> as well there are two device drivers for A and B. Card B has bug, after
> PCIe memory write  operation (MWr) the card sends back Completion
> packet without data (Cpl) (I now it is wrong, but card designed in this
> way and has to be changed).
> User process Ua reads data from Card A in loop, everything is OK , but
> then I start second user process Ub which writes in loop data to card B
> (bugged card) the Ua gets wrong data. After improving card B the problem
> was solved, but could be it has to be checked on the PCIe driver level
> as well.

PCIe transactions (MWr, MRd, Cpl, etc.) are not directly visible
to the OS or the driver.

The only thing I can think of that we could do is add a quirk to
blacklist the broken version of card B.  You can look at existing
quirks in drivers/pci/quirks.c.  Most of them workaround issues
that aren't quite as severe as this one, but we could probably
figure out a way to make the device completely unusable.

Or do you have something else in mind?

Bjorn
