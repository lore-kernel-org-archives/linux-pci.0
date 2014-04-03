Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36552 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbaDCQcW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 12:32:22 -0400
Received: by mail-ie0-f175.google.com with SMTP id to1so2083428ieb.34
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 09:32:22 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 10:32:01 -0600
Message-ID: <CAErSpo7u4_gmOpuqTuXkWesMVYBzMQYVcpwTLd4wBU5HCk8-Og@mail.gmail.com>
Subject: Coverity CIDs 1011624, 1011625: mei/pci-me.c doesn't check
 pci_enable_msi() return value
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Alexander Gordeev <agordeev@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity complains that mei_me_probe() and mei_me_pci_resume() call
pci_enable_msi() without checking the result.  They do check
indirectly, by testing pci_dev_msi_enabled(), but it would be nicer to
check the pci_enable_msi() result directly:

CID 1011625 (#1 of 1): Unchecked return value (CHECKED_RETURN)
9. check_return: Calling pci_enable_msi_block without checking return
value (as is done elsewhere 88 out of 105 times).
173        pci_enable_msi(pdev);
174
175         /* request and enable interrupt */
176        if (pci_dev_msi_enabled(pdev))

These are CIDs 1011624 and 1011625.

Bjorn
