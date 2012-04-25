Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41330 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2DYPV6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2012 11:21:58 -0400
Received: by obbta14 with SMTP id ta14so211534obb.19
        for <linux-pci@vger.kernel.org>; Wed, 25 Apr 2012 08:21:57 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 25 Apr 2012 23:21:57 +0800
Message-ID: <CADLM8XMY6ndFoEWJuHkH5gUKQYVgf9pRTZGT_r-AGxYJK06C0Q@mail.gmail.com>
Subject: What is the value of pci_bus.primary of Bus#0
From: Wei Yang <weiyang.kernel@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All

I go through the code and curious about the value of pci_bus.primary
of Bus#0, the root bus.

On x86, the root bus is get by,
     root->bus = pci_acpi_scan_root(root);

While I scan the code not find some place set the *primary* field.

I think this value indicate the upstream bus number, while for root
bus, this value should be?
So this value of the root bus is any value? Or some restriction?

-- 
Richard Yang
Help You, Help Me
