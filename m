Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33290 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754590AbdABTX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2017 14:23:56 -0500
Received: by mail-yw0-f170.google.com with SMTP id r204so273694709ywb.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2017 11:23:56 -0800 (PST)
MIME-Version: 1.0
From: Chris Murphy <lists@colorremedies.com>
Date: Mon, 2 Jan 2017 12:23:54 -0700
Message-ID: <CAJCQCtS-e8+6WZWd7fdDnxW32ye+2K6DKi1tQehmjJVO=hFaEw@mail.gmail.com>
Subject: Fwd: [Bug 189731] New: Thunderbolt 3 (USB-C) to Thunderbolt 2
 adapter[05ac:1657] doesn't work at all
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

re: this post

From: Bjorn Helgaas <bhelgaas@xxxxxxxxxx>
http://www.spinics.net/lists/linux-pci/msg57021.html


Bjorn, try the adapter being disconnected until the system is booted,
and you're at the DE or even already logged in. Then connect the
adapter, and then the display. What I'm experiencing on an HP Spectre
with Thunderbolt/USB-C/USB 3.1 Gen 2 ports and a USB-C to USB-3
adapter is it doesn't work if connected at boot time. If it's
connected after startup, then it works OK.


-- 
Chris Murphy
