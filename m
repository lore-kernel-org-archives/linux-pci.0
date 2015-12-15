Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34287 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbLOTlj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2015 14:41:39 -0500
Received: by mail-qk0-f176.google.com with SMTP id p187so30239592qkd.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Dec 2015 11:41:39 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 15 Dec 2015 11:41:39 -0800
Message-ID: <CAES_P+9oHnH5JzCZnO9eF-b__Vt+_dxLZ+jFWMX16JMEDXtaVA@mail.gmail.com>
Subject: Adding support for new amplifier on ACPI platform
From: noman pouigt <variksla@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently we have a Linux driver which is working fine on arm platforms.
However our vendor wants to add support for ACPI compliant platform.

This is referred to as an NHLT entry, which is part of ACPI, to be
more specific.
There is a notation for naming devices within this environment which
uses the PCI manufacturer ID.  The list I found is here:
http://pcidatabase.com/vendors.php?sort=name
Looks like our company does not have a number assigned.

question: Do i need to register our device with this database? How can i get the
acpi string as shown in this patch?

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/sound/soc/codecs/max98090.c?id=70f29d388915723ce03eee74a649f170e4c9f1e0


Thanks,
variksla
