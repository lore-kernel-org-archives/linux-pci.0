Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:41762 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbaCWSQV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 23 Mar 2014 14:16:21 -0400
Received: by mail-ig0-f171.google.com with SMTP id hl1so6041130igb.4
        for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2014 11:16:21 -0700 (PDT)
MIME-Version: 1.0
From: Andreas Noever <andreas.noever@gmail.com>
Date: Sun, 23 Mar 2014 19:16:00 +0100
Message-ID: <CAMxnaaVQLuExn_aEzY7QrxHiJ8Y0ZmG-EcDCuXyxH=rUdm-B6A@mail.gmail.com>
Subject: how to trigger pcieport runtime suspend?
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pcieport driver defines runtime_suspend and runtime_resume methods
(pcie_port_runtime_suspend/resume in portdrv_pci.c). I am trying to
trigger that code. But I cannot get power/runtime_usage to drop to
zero.

Initially power/runtime_usage is set to 2. The 2 comes (imho) from:
pci_pm_init -> pm_runtime_forbid
local_pci_probe -> pm_runtime_get_sync

The pm_runtime_forbid can be undone with echo auto > power/control,
but the second one seems to never go away. local_pci_probe spots the
following comment:
"If the driver supports runtime PM, it should call
pm_runtime_put_noidle() in its probe routine and
pm_runtime_get_noresume() in its remove routine." I cannot find any
such calls in the pcieport driver (or in the port service drivers).

What am I missing?

Thanks,
Andreas
