Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36364 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeDHR5Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Apr 2018 13:57:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id x82so11672757wmg.1
        for <linux-pci@vger.kernel.org>; Sun, 08 Apr 2018 10:57:16 -0700 (PDT)
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2 0/5] Add R8A77980 PCIe support & some driver cleanups
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Message-ID: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
Date: Sun, 8 Apr 2018 20:57:13 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

Here's a set of 5 patches against the 'pci/rcar' branch of Lorenzo Pieralisi's
'pci.git' repo. These are the changes needed for better R-Car gen3 support
(namely for R8A77980 support) plus some PCIe driver re-factoring done in
the process...

[1/5] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
[2/5] pcie-rcar: remove PHYRDY polling from rcar_pcie_hw_init_h1()
[3/5] pcie-rcar: add R-Car gen3 PHY support
[4/5] pcie-rcar: factor out rcar_pcie_hw_init() call
[5/5] DT: pci: rcar-pci: document R8A77980 bindings

MBR, Sergei
