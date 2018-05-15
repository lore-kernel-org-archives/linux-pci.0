Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:43491 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEOKGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2018 06:06:53 -0400
Subject: Re: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <f93ebc6b-a324-427a-80cc-133477bc2528@mentor.com>
Date: Tue, 15 May 2018 13:06:48 +0300
MIME-Version: 1.0
In-Reply-To: <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/15/2018 12:07 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, convert the
> existing function to a managed version.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Now it is correct, thanks.

Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
