Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:43347 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbeEOKFT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2018 06:05:19 -0400
Subject: Re: [PATCH v4 4/8] PCI: Replace dev_node parameter of
 of_pci_get_host_bridge_resources with device
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <6bbbb011-7cae-80a3-4cce-6608b4aace2c@mentor.com>
Date: Tue, 15 May 2018 13:05:13 +0300
MIME-Version: 1.0
In-Reply-To: <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/15/2018 12:07 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Another step towards a managed version of
> of_pci_get_host_bridge_resources(): Feed in the underlying device,
> rather than just the OF node. This will allow to use managed resource
> allocation internally later on.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
