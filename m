Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B4C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 18:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3D820817
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 18:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3D820817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeK0E65 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:58:57 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47641 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeK0E65 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Nov 2018 23:58:57 -0500
Received: from 79.184.254.110.ipv4.supernova.orange.pl (79.184.254.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id fcfea4f969da0254; Mon, 26 Nov 2018 19:04:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: [Bug] SD card reader in Acer Aspire S5 broken in 4.20-rc
Date:   Mon, 26 Nov 2018 19:03:58 +0100
Message-ID: <2960808.4YCFhzuD0k@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4303141.x26C91lLnn"
Content-Transfer-Encoding: 7Bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart4303141.x26C91lLnn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Bjorn,

The SD card reader in my Acer Aspire S5 doesn't work with 4.20-rc.

Here's what lspci -v says about it (in a bad kernel):

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card Reader 
(rev 01)
        Subsystem: Acer Incorporated [ALI] Device 0704
        Flags: bus master, fast devsel, latency 0, IRQ 35
        Memory at d9001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-00-00-01-00-4c-e0-00
        Kernel driver in use: rtsx_pci
        Kernel modules: rtsx_pci

When it doesn't work, it doesn't generate any interrupts on device insertion
and removal and this seems to be reproducible 100% of the time.

Bisection turned up

commit de468b755464426c276df2daf1e54bcd64186020
Merge: b1801bf05964 d6112f8def51
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat Oct 20 11:45:28 2018 -0500

    Merge branch 'pci/enumeration'
    
      - Remove x86 and arm64 node-local allocation for host bridge structures
        (Punit Agrawal)
    
      - Pay attention to device-specific _PXM node values (Jonathan Cameron)
    
      - Support new Immediate Readiness bit (Felipe Balbi)
    
    * pci/enumeration:
      PCI: Add support for Immediate Readiness
      ACPI/PCI: Pay attention to device-specific _PXM node values
      x86/PCI: Remove node-local allocation when initialising host controller
      arm64: PCI: Remove node-local allocations when initialising host controller

as the first bad commit, but the "PCI: Add support for Immediate Readiness"
one was tested as "good" (full bisect log is attached).

I wonder if you have any ideas on what to check?

Cheers,
Rafael

--nextPart4303141.x26C91lLnn
Content-Disposition: attachment; filename="aspire-rtsx-bisect.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="aspire-rtsx-bisect.log"

git bisect start
# good: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
git bisect good 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
# bad: [2e6e902d185027f8e3cb8b7305238f7e35d6a436] Linux 4.20-rc4
git bisect bad 2e6e902d185027f8e3cb8b7305238f7e35d6a436
# bad: [18d0eae30e6a4f8644d589243d7ac1d70d29203d] Merge tag 'char-misc-4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad 18d0eae30e6a4f8644d589243d7ac1d70d29203d
# good: [50b825d7e87f4cff7070df6eb26390152bb29537] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 50b825d7e87f4cff7070df6eb26390152bb29537
# bad: [3acbd2de6bc3af215c6ed7732dfc097d1e238503] Merge tag 'sound-4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad 3acbd2de6bc3af215c6ed7732dfc097d1e238503
# good: [a41efc2a0f68cea26665ab9e6d991c9bf33b3f59] Merge tag 'dmaengine-4.20-rc1' of git://git.infradead.org/users/vkoul/slave-dma
git bisect good a41efc2a0f68cea26665ab9e6d991c9bf33b3f59
# bad: [d49f8a52b15bf35db778035340d8a673149f9f93] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad d49f8a52b15bf35db778035340d8a673149f9f93
# good: [6c404a68bf83b4135a8a9aa1c388ebdf98e8ba7f] scsi: dc395x: fix DMA API usage in sg_update_list
git bisect good 6c404a68bf83b4135a8a9aa1c388ebdf98e8ba7f
# bad: [61ce5809570b38710f08ebfcd44a5b067eeee77d] Merge branch 'remotes/lorenzo/pci/cadence'
git bisect bad 61ce5809570b38710f08ebfcd44a5b067eeee77d
# good: [e51cd9ce5dd3b10f9e67a30a4dc00fc1fa80c673] PCI/AER: Refactor error injection fallbacks
git bisect good e51cd9ce5dd3b10f9e67a30a4dc00fc1fa80c673
# bad: [ee8360fdafac54eefd0df69fbd99338896cf806b] Merge branch 'pci/misc'
git bisect bad ee8360fdafac54eefd0df69fbd99338896cf806b
# good: [fb513f60ea58f096be7006f899e2181762af37cb] NTB: switchtec_ntb: Update switchtec documentation with prerequisites for NTB
git bisect good fb513f60ea58f096be7006f899e2181762af37cb
# good: [b1801bf05964321d79fbbeae96c8ab09da2e2e49] Merge branch 'pci/aspm'
git bisect good b1801bf05964321d79fbbeae96c8ab09da2e2e49
# good: [d6112f8def514e019658bcc9b57d53acdb71ca3f] PCI: Add support for Immediate Readiness
git bisect good d6112f8def514e019658bcc9b57d53acdb71ca3f
# bad: [20634dc361e1c5fe2dae380a7d0a21ca7f32c4f7] Merge branch 'pci/hotplug'
git bisect bad 20634dc361e1c5fe2dae380a7d0a21ca7f32c4f7
# bad: [de468b755464426c276df2daf1e54bcd64186020] Merge branch 'pci/enumeration'
git bisect bad de468b755464426c276df2daf1e54bcd64186020
# first bad commit: [de468b755464426c276df2daf1e54bcd64186020] Merge branch 'pci/enumeration'

--nextPart4303141.x26C91lLnn--

