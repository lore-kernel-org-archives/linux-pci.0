Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:39509 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbeBEN6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Feb 2018 08:58:23 -0500
Received: by mail-qt0-f181.google.com with SMTP id f4so39628392qtj.6
        for <linux-pci@vger.kernel.org>; Mon, 05 Feb 2018 05:58:23 -0800 (PST)
MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Mon, 5 Feb 2018 15:58:22 +0200
Message-ID: <CAJ2oMhKRmSb-XFp2eeGEWqivL60C0uD22Yx1EdZ5ziAMOvmUUQ@mail.gmail.com>
Subject: Q: uio_pci_generic
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,


I can't find in uio_pci_generic.c any usage of DMA.
Is it that the driver does not use DMA in transactions between device
and host ? If not - isn't it a sort disadvantage ?

Regards,
Ran
