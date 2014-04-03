Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41797 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbaDCRt6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 13:49:58 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so2199318iec.38
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 10:49:57 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 11:49:37 -0600
Message-ID: <CAErSpo6ssN_6kz17jahP85GGNoap39azzVk4bx5vhCsY4f=1xg@mail.gmail.com>
Subject: Coverity CID 200651: pci_specified_resource_alignment() integer overflow
To: Yuji Shimada <shimada-yxb@necst.nec.co.jp>
Cc: Yu Zhao <yu.zhao@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity complains about unintentional integer overflow in
pci_specified_resource_alignment():

CID 200651 (#1 of 1): Unintentional integer overflow (OVERFLOW_BEFORE_WIDEN)
overflow_before_widen: Potentially overflowing expression 1 <<
align_order with type int (32 bits, signed) is evaluated using 32-bit
arithmetic before being used in a context which expects an expression
of type resource_size_t (64 bits, unsigned). To avoid overflow, cast
the left operand to resource_size_t before performing the left shift.

4219                                align = 1 << align_order;

Bjorn
