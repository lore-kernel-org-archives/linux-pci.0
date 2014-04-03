Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:47184 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbaDCQxV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 12:53:21 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so2142935iec.9
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 09:53:21 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 10:53:01 -0600
Message-ID: <CAErSpo4hujoq8Ni7sSrNQv61rf4Xz4s3GjYxNQR6TDLDm0N-Jw@mail.gmail.com>
Subject: Coverity CID 712278: c_can_pci_probe() doesn't check pci_enable_msi()
 return value
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-can@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity complains that c_can_pci_probe() calls pci_enable_msi()
without checking the result:


CID 712278 (#1 of 1): Unchecked return value (CHECKED_RETURN)
3. check_return: Calling pci_enable_msi_block without checking return
value (as is done elsewhere 88 out of 105 times).
 88        pci_enable_msi(pdev);

This is CID 712278.

Bjorn
