Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752675AbeENQX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 May 2018 12:23:58 -0400
Date: Mon, 14 May 2018 17:23:54 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: dwc: Code clean up
Message-ID: <20180514162354.GB14611@e107981-ln.cambridge.arm.com>
References: <cover.1526310453.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526310453.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 14, 2018 at 04:09:47PM +0100, Gustavo Pimentel wrote:
> Does a code cleanup on DesignWare driver, which involves:
>  - Replacement of magic numbers by a self-explained define to ease human
> comprehension.
>  - Replacement a division by 2 operation for a right shift rotation of 1
> bit.
>  - Replacement of all initial lowercase character in comments and debug
> messages to uppercase to maintain coherence.
> 
> Gustavo Pimentel (3):
>   PCI: dwc: Replace lower into upper case characters
>   PCI: dwc: Small computation improvement
>   PCI: dwc: Replace magic number by defines
> 
>  drivers/pci/dwc/pcie-designware-ep.c   | 16 +++----
>  drivers/pci/dwc/pcie-designware-host.c | 77 +++++++++++++++++++---------------
>  drivers/pci/dwc/pcie-designware.c      | 22 +++++-----
>  drivers/pci/dwc/pcie-designware.h      |  1 +
>  4 files changed, 63 insertions(+), 53 deletions(-)

Applied to pci/dwc for v4.18, thanks.

Lorenzo
