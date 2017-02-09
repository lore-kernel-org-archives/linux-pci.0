Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:36415 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbdBIPPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2017 10:15:45 -0500
Received: by mail-it0-f42.google.com with SMTP id c7so127182394itd.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Feb 2017 07:15:45 -0800 (PST)
MIME-Version: 1.0
From: rupert THURNER <rupert.thurner@gmail.com>
Date: Thu, 9 Feb 2017 15:45:01 +0100
Message-ID: <CAJs9aZ9FqU-NCj2egBp6J06uD_Qp3Lje=mSSVbV4vNcYGKdumA@mail.gmail.com>
Subject: linux <=4.9.5, 4.10-rc7 ok, 4.9.6 - 4.9.8 nok with realtek wlan, atom
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hi,

not technical expert enough, i just wanted to give a short user
feedback. for realtek wlan on atom, kernels up to 4.9.5 are ok, and
kernel 4.10.0-rc7-g926af6273fc6 (arch linux-git version numbering) as
well. kernels 4.9.6, 4.9.7, and 4.9.8 fail, i.e. connection to a WLAN
hotspot is possible then drops, or connecting to wlan fails
alltogether.

24: PCI 300.0: 0282 WLAN controller
  [Created at pci.366]
  Model: "Realtek RTL8188CE 802.11b/g/n WiFi Adapter"
  Device: pci 0x8176 "RTL8188CE 802.11b/g/n WiFi Adapter"
  Revision: 0x01
  Driver: "rtl8192ce"
  Driver Modules: "rtl8192ce"
  Device File: wlp3s0
  Features: WLAN

best
rupert
