Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34468 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbeHNPgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2018 11:36:36 -0400
MIME-Version: 1.0
From: Ramon Fried <ramon.fried@gmail.com>
Date: Tue, 14 Aug 2018 13:49:20 +0100
Message-ID: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
Subject: PCI Endpoint - Missing inbound mapping ops ?
To: kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi.
I recently saw that the PCI endpoint API only supports outbound memory
mapping: (AXI -> PCI) through the map_addr op.
Why inbound mapping is missing (PCI->AXI) is missing ?
In almost all of the PCI EP controllers I've worked with there was a
need to map complete BARS or part of BARS to mmio/aperature regions on
the device.

Thanks !
Ramon.
