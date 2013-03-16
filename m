Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from queue01c.mail.zen.net.uk ([212.23.3.237]:46293 "EHLO
	queue01c.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab3CPJEb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Mar 2013 05:04:31 -0400
Received: from [212.23.1.3] (helo=smarthost03.mail.zen.net.uk)
	by queue01c.mail.zen.net.uk with esmtp (Exim 4.72)
	(envelope-from <rjt-linux-pci@thegrindstone.me.uk>)
	id 1UGmGu-00067o-Hh
	for linux-pci@vger.kernel.org; Sat, 16 Mar 2013 08:15:20 +0000
Received: from [82.68.127.150] (helo=bee.taylor.home)
	by smarthost03.mail.zen.net.uk with esmtp (Exim 4.72)
	(envelope-from <rjt-linux-pci@thegrindstone.me.uk>)
	id 1UGmFr-0000bx-E2
	for linux-pci@vger.kernel.org; Sat, 16 Mar 2013 08:14:15 +0000
Message-ID: <514429D7.5040203@thegrindstone.me.uk>
Date: Sat, 16 Mar 2013 08:14:15 +0000
From: Richard Taylor <rjt-linux-pci@thegrindstone.me.uk>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Configuration settings to return 0xFFFFFFFF on error?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

I am struggling with a badly behaved PCIe device that is either not
sending Read Completion packets or it is sending Unsupported Requests.

My problem is that the affect of these is to leave the Non-Posted
transaction that is waiting for the Read Completion in a hung state,
consuming 100% CPU.

I have read a number of times that when an error occurs it should be
possible to have the transaction return with 0xFFFFFFFF rather than hang.

I suspect this may be something to do with error severity or error
masking settings in the PCIe configuration registers.

The CPU is a QoriQ P2020.

Can anyone point me in the right direction for something to try?

I have the AER driver installed and it shows error interrupts being
generated - but the memory read call still does not terminate.

I am not very familiar with PCI and I have struggled to find an
explanation of this issue that gives me a clue on where to go next.

Regards

Richard
