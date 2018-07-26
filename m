Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:39398 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbeGZX5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2018 19:57:45 -0400
Received: by mail-oi0-f48.google.com with SMTP id d189-v6so5840861oib.6
        for <linux-pci@vger.kernel.org>; Thu, 26 Jul 2018 15:38:52 -0700 (PDT)
To: Keith Busch <keith.busch@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Bolen, Austin" <austin_bolen@dell.com>,
        "alex_gagniuc@dellteam.com" <Alex_Gagniuc@Dellteam.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Message-ID: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
Date: Thu, 26 Jul 2018 17:38:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I was under the impression that a DLLSC or PDSC would trigger the 
PCI_DEV_DISCONNECTED bit to be set, blocking any further config access.

Although I'm not seeing that happen after a  "Slot(xxx): Link Down" 
event. I suspect my understanding is then wrong. Or maybe 
PCI_DEV_DISCONNECTED means something else.

In the latter case, does it not make sense to have a separate bit to say 
"Don't touch this device"?

Alex
