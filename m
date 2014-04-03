Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35303 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbaDCPxo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 11:53:44 -0400
Received: by mail-ig0-f175.google.com with SMTP id ur14so7942030igb.8
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 08:53:43 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 09:53:23 -0600
Message-ID: <CAErSpo79w7n=kOUM7D+USA7tHGJ50Sggndun=LwTkeirVqKfvg@mail.gmail.com>
Subject: Coverity CID 714665: vfio_ext_cap_len() use of uninitialized variable
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity complains that "byte" is used uninitialized in
drivers/vfio/pci/vfio_pci_config.c in vfio_ext_cap_len():

1139                        sts = byte & PCI_TPH_CAP_ST_MASK;
1140                        sts >>= PCI_TPH_CAP_ST_SHIFT;
1141                        return PCI_TPH_BASE_SIZEOF + round_up(sts * 2, 4);

This is CID 714665.
