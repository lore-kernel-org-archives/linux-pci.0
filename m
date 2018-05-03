Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:40836 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeECTcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 15:32:45 -0400
Received: by mail-lf0-f47.google.com with SMTP id j16-v6so27650050lfb.7
        for <linux-pci@vger.kernel.org>; Thu, 03 May 2018 12:32:44 -0700 (PDT)
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3 0/5] Add R8A77980 PCIe support & some driver cleanups
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Message-ID: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Date: Thu, 3 May 2018 22:32:41 +0300
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
