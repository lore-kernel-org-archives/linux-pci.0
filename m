Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:39086 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaDCUnZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 16:43:25 -0400
Received: by mail-ig0-f175.google.com with SMTP id ur14so79242igb.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 13:43:25 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 14:43:05 -0600
Message-ID: <CAErSpo6JNDFiV6tmDKKDdnod+skBHx6T-+JGvjCRRLsL98h_uQ@mail.gmail.com>
Subject: Coverity CID 142811: pci_set_vga_state() operands don't affect result
To: Dave Airlie <airlied@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity complains about this in drivers/pci/pci.c:

CID 142811 (#1 of 1): Operands don't affect result (CONSTANT_EXPRESSION_RESULT)
result_independent_of_operands: flags & (2U /* 1 << 1 */) &
(command_bits & 4294967292U /* ~(1 | 2) */) is always 0 regardless of
the values of its operands. This occurs as the logical operand of if.

4128        WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) &
(command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));

This is a result of 3448a19da479 "vgaarb: use bridges to control VGA
routing where possible."

I wonder if that middle "&" was intended to be "&&"?

Bjorn
