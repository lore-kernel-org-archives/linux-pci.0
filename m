Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37253 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbaDCU4r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 16:56:47 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so2435977ier.41
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 13:56:47 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 14:56:26 -0600
Message-ID: <CAErSpo7uQtRXcxC-9oAS8PJ6Vi3H8Z1fVB2wQR-uxGjyoLDkCQ@mail.gmail.com>
Subject: Coverity CIDs 138749, 138750: cnb20le_res() unintended sign extension
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity complains about unintended sign extension in cnb20le_res() in
arch/x86/pci/broadcom_bus.c here:

60        word1 = read_pci_config_16(bus, slot, func, 0xc4);
 61        word2 = read_pci_config_16(bus, slot, func, 0xc6);
 62        if (word1 != word2) {

CID 138749 (#1 of 2): Unintended sign extension (SIGN_EXTENSION)
sign_extension: Suspicious implicit sign extension: word1 with type
unsigned short (16 bits, unsigned) is promoted in (word1 << 16) | 0 to
type int (32 bits, signed), then sign-extended to type unsigned long
long (64 bits, unsigned). If (word1 << 16) | 0 is greater than
0x7FFFFFFF, the upper bits of the result will all be 1.
 63                res.start = (word1 << 16) | 0x0000;
    CID 138750: Unintended sign extension (SIGN_EXTENSION) [select issue]
 64                res.end   = (word2 << 16) | 0xffff;
 65                res.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 66                update_res(info, res.start, res.end, res.flags, 0);
 67        }

Bjorn
