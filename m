Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:49932 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeECHOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 03:14:11 -0400
Subject: Re: [PATCH v2 03/10] PCI: Factor out
 __of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <35efe707d03c886f1ac1e0c9634810c9da59c88a.1525067324.git.jan.kiszka@siemens.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <63e44c62-df98-0e73-5981-fdf2094e2fb2@mentor.com>
Date: Thu, 3 May 2018 10:14:06 +0300
MIME-Version: 1.0
In-Reply-To: <35efe707d03c886f1ac1e0c9634810c9da59c88a.1525067324.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This will be needed for sharing the core logic between current
> of_pci_get_host_bridge_resources() and upcoming
> devm_of_pci_get_host_bridge_resources().
> 
> Already rename the dev parameter to dev_node in order to free the
> namespace for a real device parameter.
> 
> No functional changes.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
