Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:37038 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbeFUAjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 20:39:33 -0400
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        jesper.nilsson@axis.com, sboyd@codeaurora.org,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/11] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        adouglas@cadence.com
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
 <180c7a9743a67120e77ab198889c1373e91643b9.1529507416.git.gustavo.pimentel@synopsys.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <8fda923d-b6c3-58aa-c534-f646b134a68b@rock-chips.com>
Date: Thu, 21 Jun 2018 08:39:28 +0800
MIME-Version: 1.0
In-Reply-To: <180c7a9743a67120e77ab198889c1373e91643b9.1529507416.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018/6/21 0:28, Gustavo Pimentel wrote:

>   drivers/pci/controller/pcie-rockchip-ep.c         | 2 +-

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
