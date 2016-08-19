Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36496 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbcHSWhx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2016 18:37:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id q128so50873412wma.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2016 15:37:52 -0700 (PDT)
MIME-Version: 1.0
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Fri, 19 Aug 2016 15:37:50 -0700
Message-ID: <CAH=XD5_GGAXw=uuGn+S__+6D0dtfCHKAX-btwFhdnWYPtZ94YA@mail.gmail.com>
Subject: creating raw TLP packets
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I need to create raw TLP packets for configuration access to certain
PCIe port in a fabric. That is, the pci_config_read/write kernel
routines need to produce complete TLP packets with all the bits.

Is there any opensource code that forms TLP packets?

Thanks,
Kallol
