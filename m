Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:49960 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeECHOY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 03:14:24 -0400
Subject: Re: [PATCH v2 04/10] PCI: Add dev parameter to
 __of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <cfab525f3d0436f75187fbd65907ada909d7692f.1525067324.git.jan.kiszka@siemens.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <e06087fd-3258-89d4-cdc3-06196bd61dbe@mentor.com>
Date: Thu, 3 May 2018 10:14:20 +0300
MIME-Version: 1.0
In-Reply-To: <cfab525f3d0436f75187fbd65907ada909d7692f.1525067324.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> When non-NULL, use the new dev parameter of
> __of_pci_get_host_bridge_resources() to allocate the resource data
> structures via devm_kzalloc. That allows to release them automatically
> during device destruction.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
