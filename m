Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:40506 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbaGCUGR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 16:06:17 -0400
Received: by mail-oa0-f53.google.com with SMTP id l6so784497oag.26
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2014 13:06:17 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 3 Jul 2014 22:06:17 +0200
Message-ID: <CACna6ry7+oNLwGVkdJiDkLq_QCZ5+gKk8Dxr=tbs-kBYqCp9Yg@mail.gmail.com>
Subject: Checking PCIe generation in driver code
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I'm dealing with Broadcom devices and it appears I need to know if the
current PCIe device is Gen 1 or Gen 2. This is because they have
slightly different registers:
#define PCI_BAR0_WIN2 0xac
#define PCIE2_BAR0_WIN2 0x70

Is there a way to know that? I keep starring at struct pci_dev, but
can't see "generation" field. Tried Googling, but couldn't find
anything.

-- 
Rafał
