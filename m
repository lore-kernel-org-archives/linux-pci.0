Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:51805 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbaH2WhN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 18:37:13 -0400
Received: by mail-qc0-f177.google.com with SMTP id i8so3130121qcq.36
        for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2014 15:37:13 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 29 Aug 2014 16:36:52 -0600
Message-ID: <CAErSpo68rteOFbbX5n6GccPc9kpt-UL9FRS7JbOMAoDLR-7mtA@mail.gmail.com>
Subject: pciehp regression (bug #79701)
To: Rajat Jain <rajatxjain@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rajat,

This bug report: https://bugzilla.kernel.org/show_bug.cgi?id=79701 was
bisected to 02e93a8a7c1d ("PCI: pciehp: Don't check adapter or latch
status while disabling").  Can you take a look?

Bjorn
