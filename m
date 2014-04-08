Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:63195 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbaDHWWn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 18:22:43 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so1653251iec.18
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2014 15:22:43 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Apr 2014 16:22:23 -0600
Message-ID: <CAErSpo5oGensBcGx-z+WuauRL87mjYbNRzSuhucUmpzef9LSJg@mail.gmail.com>
Subject: Bridge secondary latency not preserved across suspend/resume
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Parag,

You reported in [1] that a bridge secondary latency setting changed
after a suspend/resume.  As far as I know you're not seeing any ill
effects from this change, but I opened this bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=73701 for it.

The bugzilla is not high on my priority list, so it's mostly just for
documentation at this point, and as a little project for somebody who
wants to do something useful in PCI.

But you could help by attaching a complete dmesg log and two "lspci
-vvv" dumps (one before the suspend and one after the resume) to the
bugzilla.

Bjorn

[1] http://lkml.kernel.org/r/CAOULuOY5eryuH1KgaqiuGXyYiQd2h=TZoPe2M2+juts9XuzW6Q@mail.gmail.com
