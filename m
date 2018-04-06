Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53539 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDFK6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Apr 2018 06:58:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id p9so2658909wmc.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Apr 2018 03:58:50 -0700 (PDT)
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 0/4] Add R8A77980 PCIe support & some driver cleanups
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Message-ID: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
Date: Fri, 6 Apr 2018 13:58:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

Here's a set of 4 patches against the 'pci.rcar' branch of Lorenzo Pieralisi's
'pci.git' repo. These are the changes needed for better R-Car gen3 support
(namely for R8A77980 support) plus some PCIe driver re-factoring done in
the process...

[1/4] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
[2/4] pcie-rcar: remove PHYRDY polling from rcar_pcie_hw_init_h1()
[3/4] pcie-rcar: add R-Car gen3 PHY support
[4/4] pcie-rcar: factor out rcar_pcie_hw_init() call

MBR, Sergei
