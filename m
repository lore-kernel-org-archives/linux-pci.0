Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.nic.cz ([217.31.204.67]:35409 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751928AbdIVLb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Sep 2017 07:31:28 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:8982:ed8c:62b1:c0c8])
        by mail.nic.cz (Postfix) with ESMTPS id 05CDB6231D
        for <linux-pci@vger.kernel.org>; Fri, 22 Sep 2017 13:26:03 +0200 (CEST)
Date: Fri, 22 Sep 2017 13:24:44 +0200
From: Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To: linux-pci@vger.kernel.org
Subject: aardvark pci controller ath9k request_irq fail
Message-ID: <20170922132444.588e27cb@dellmb.labs.office.nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,
we are developing a new board based on Marvell Armada 3720.
While testing the PCI-e slot, I have enountered this problem:

- lspci always correctly prints information about the PCIe card in the
  slot
- when a ath9k card is in the slot, ath9k fails to initialize with
     ath9k 0000:00:00.0: request_irq failed

  The irq number passed to the request_irq function is from the irq
  member of struct pci_dev:
     request_irq(pdev->irq, ath_isr, IRQF_SHARED, "ath9k", sc);

  this number (pdev->irq) is 255

  The request_irq function fails in request_threaded_irq on line:
     desc = irq_to_desc(irq);
  (desc is NULL and thus -EINVAL is returned.)

- what is strange is that another card, Intel Centrino Ultimate-N 6300
  with iwlwifi works.

- another card (ath10k driver) also does not work.

Is this a problem with the pci-aardvark driver for the Aardvark
controller?

Thank you.

Marek
