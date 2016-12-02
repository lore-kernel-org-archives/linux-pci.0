Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36241 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933523AbcLBKhU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2016 05:37:20 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 0/3 pci/next] PCI: rcar, rcar-gen2: Bindings cleanups
Date: Fri,  2 Dec 2016 11:36:57 +0100
Message-Id: <1480675020-26346-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

this short series makes some bindings cleanups to the Renesas PCI drivers.

Simon Horman (3):
  PCI: rcar-gen2: Use gen2 fallback compatibility last
  PCI: rcar: Use gen2 fallback compatibility last
  PCI: rcar: Add gen3 fallback compatibility string for pcie-rcar

 Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
 drivers/pci/host/pci-rcar-gen2.c                   | 2 +-
 drivers/pci/host/pcie-rcar.c                       | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344

