Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58534 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeHQAox (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 20:44:53 -0400
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180816190646.GA9610@embeddedor.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9a8fe29a-741e-c7ca-a844-ac6a8104211e@deltatee.com>
Date: Thu, 16 Aug 2018 15:44:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180816190646.GA9610@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] switchtec: Fix potential Spectre v1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/08/18 01:06 PM, Gustavo A. R. Silva wrote:
> p.port can is indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/pci/switch/switchtec.c:912 ioctl_port_to_pff() warn: potential
> spectre issue 'pcfg->dsp_pff_inst_id' [r]
> 
> Fix this by sanitizing p.port before using it to index
> pcfg->dsp_pff_inst_id
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Looks good to me, thanks.

Logan
