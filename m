Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:38692 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeHIUkQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Aug 2018 16:40:16 -0400
Received: by mail-qt0-f175.google.com with SMTP id w26-v6so7565538qto.5
        for <linux-pci@vger.kernel.org>; Thu, 09 Aug 2018 11:14:14 -0700 (PDT)
MIME-Version: 1.0
From: Eric Pilmore <epilmore@gigaio.com>
Date: Thu, 9 Aug 2018 11:14:13 -0700
Message-ID: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
Subject: IOAT DMA w/IOMMU
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Didn't get any response on the IRC channel so trying here.

Was wondering if anybody here has used IOAT DMA engines with an
IOMMU turned on (Xeon based system)? My specific question is really
whether it is possible to DMA (w/IOAT) to a PCI BAR address as the
destination without having to map that address to the IOVA space of the
DMA engine first (assuming the IOMMU is on)?

I am encountering issues where I see PTE Errors reported from DMAR in this
scenario, but I do not if I use a different DMA engine that's sitting downstream
off the PCI tree. I'm wondering if the IOAT DMA failure is some
artifact of these
engines sitting behind the Host Bridge.

Thanks in advance!
Eric
