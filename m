Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:53455 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaFYKXU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 06:23:20 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so1007432yho.30
        for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 03:23:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 25 Jun 2014 15:53:19 +0530
Message-ID: <CAD6G_RSCQ+CzifpofiXg9yFB3HpEqynF-3giEowRgR9E-qvX1Q@mail.gmail.com>
Subject: PCIe current resource settings
From: Jagan Teki <jagannadh.teki@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I think CRS feature is all ready available in Linux [1]

I'm guessing the respective root complex driver need to enable and use
this feature.
I'm using PCIe bridge which is operating in ARM, how can I enable or
is there RC driver which uses this feature already?

[1] http://lwn.net/Articles/373551/

thanks!
-- 
Jagan.
