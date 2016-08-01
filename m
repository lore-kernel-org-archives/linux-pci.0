Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36185 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbcHASag (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2016 14:30:36 -0400
Received: by mail-wm0-f52.google.com with SMTP id q128so380773680wma.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2016 11:30:00 -0700 (PDT)
MIME-Version: 1.0
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Mon, 1 Aug 2016 11:29:58 -0700
Message-ID: <CAH=XD5_0RV_o0vpx1v3dXEadzdNTwFYhevH70XNFBG-1jBnYzQ@mail.gmail.com>
Subject: how to initialize a PCI device via specific B:D.F
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
    I have exposed a realtek PF via an additional switch to a host CPU.

The host CPU can now view the device via two paths. One, in regular
path and another via the additional switch. The device has two B:D.Fs
assigned to it.

How can I tell the Realtek driver to configure the device only via new path?

Bind/unbind may not work, as I do not want to initialize the device
via the regular path.

Thanks,
Kallol
