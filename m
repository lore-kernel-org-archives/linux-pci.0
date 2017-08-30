Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbdH3C50 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Aug 2017 22:57:26 -0400
Date: Tue, 29 Aug 2017 21:57:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, robh+dt@kernel.org, minghuan.lian@nxp.com,
        shawnguo@kernel.org
Subject: Re: [PATCHv2 0/2] PCI: add ls2088a and ls1088a support
Message-ID: <20170830025710.GA10338@bhelgaas-glaptop.roam.corp.google.com>
References: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 02:41:32PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Hou Zhiqiang (2):
>   PCI: layerscape: Add support for ls2088a
>   PCI: layerscape: Add support for ls1088a
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt |  2 ++
>  drivers/pci/dwc/pci-layerscape.c                         | 10 ++++++++++
>  2 files changed, 12 insertions(+)

Applied with Minghuan's ack to pci/host-layerscape for v4.14, thanks!
