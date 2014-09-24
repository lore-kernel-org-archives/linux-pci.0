Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:53850 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbaIXP7v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 11:59:51 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so3693937obc.32
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2014 08:59:50 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 24 Sep 2014 08:59:50 -0700
Message-ID: <CA+HUmGgTd=nbLqXXjQL=WVHAMjYAKE2s99JjXN3pwcS2_j7b5g@mail.gmail.com>
Subject: PCI_VENDOR_ID_VMWARE not in pci_ids.h
From: Francesco Ruggeri <fruggeri@arista.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_VENDOR_ID_VMWARE is not in pci_ids.h, but it is instead defined
in device specific files.
It can be useful to always have access to it, especially when accessing
subsystem_vendor_id on emulated devices.
Is there a reason to keep it out of pci_defs.h?
Any objections to moving it there?

Thanks,
Francesco Ruggeri
