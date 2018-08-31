Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbeIADNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 23:13:19 -0400
To: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@kernel.org>
Subject: RFC on PCI Device Lock
Message-ID: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
Date: Fri, 31 Aug 2018 16:03:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Alex;

Since my recent series to relocate secondary bus reset code into the PCI core,
we hit a deadlock while trying to obtain a device lock during probe since
device lock is already held.

https://bugzilla.kernel.org/show_bug.cgi?id=200985

I posted a patch into the bugzilla so that we skip locks if we are probing
to follow the same strategy found in other lock routines in pci.c.

https://bugzilla.kernel.org/attachment.cgi?id=278221

I wanted to hear some opinions since this is a regression and need to find
a solution and also waiting for test feedback

Sinan
