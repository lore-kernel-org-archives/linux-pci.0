Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbeEOO1k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 10:27:40 -0400
Date: Tue, 15 May 2018 15:27:31 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Replace lower into upper case characters
Message-ID: <20180515142731.GA30500@e107981-ln.cambridge.arm.com>
References: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 14, 2018 at 05:56:22PM +0100, Gustavo Pimentel wrote:
> Replacement of all initial lowercase character in comments and debug
> messages to uppercase to maintain coherence.

Applied to pci/endpoint for v4.18, thanks.

Lorenzo

> Gustavo Pimentel (2):
>   misc: pci_endpoint_test: Replace lower into upper case characters
>   PCI: endpoint: functions/pci-epf-test: Replace lower into upper case
>     characters
> 
>  drivers/misc/pci_endpoint_test.c              | 18 +++++++++---------
>  drivers/pci/endpoint/functions/pci-epf-test.c | 26 +++++++++++++-------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
