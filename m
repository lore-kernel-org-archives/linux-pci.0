Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44134 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbcHQT4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Aug 2016 15:56:13 -0400
Date: Wed, 17 Aug 2016 14:49:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com
Subject: Re: [PATCH v5 0/3] pcie-designware: add iATU unroll feature
Message-ID: <20160817194938.GC27353@localhost>
References: <cover.1470822461.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1470822461.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Wed, Aug 10, 2016 at 11:02:37AM +0100, Joao Pinto wrote:
> The new DWC PCIe Core version (4.80) implements iATU in a different way.
> This new mechanism is called iATU Unroll Mode. The Core still supports
> the "old" mechanism calling it Legacy Mode if configured to do so, but
> the standard way will be using Unroll.
> This patch adds the necessary support for the mechanism and makes
> some minor improvements to the existent one.
> 
> Joao Pinto (3):
>   pci: move definitions from header to pcie-designware.c
>   pci: add iATU Unroll mechanism
>   pcie-designware: fix typo
> 
>  drivers/pci/host/pcie-designware.c | 138 ++++++++++++++++++++++++++++++++-----
>  drivers/pci/host/pcie-designware.h |   6 +-
>  2 files changed, 122 insertions(+), 22 deletions(-)

I applied these to pci/host-designware for v4.9.

I made a few changes and additions, so I'll post the patches I applied
as a v6 series so you can test and point out any errors.
