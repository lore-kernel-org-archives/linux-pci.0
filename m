Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:24484 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751330AbaCZIyv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 04:54:51 -0400
In-Reply-To: <20140325210319.GE27673@verge.net.au>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <1395766604-30926-7-git-send-email-phil.edworthy@renesas.com> <20140325210319.GE27673@verge.net.au>
To: Simon Horman <horms@verge.net.au>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OF088BE275.2B86FE6F-ON80257CA7.0030CD8C-80257CA7.0030F45E@eu.necel.com>
Date: Wed, 26 Mar 2014 08:54:44 +0000
Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Simon,

On: 25/03/2014 21:03, Simon wrote:
> Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes 
for R8A7790
> 
> On Tue, Mar 25, 2014 at 04:56:41PM +0000, Phil Edworthy wrote:
> > This patch adds the device tree nodes for R8A7790
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Please split this patch into two patches.
> 
> 1. A patch that updates arch/arm/boot/dts/r8a7790.dtsi
> 
>    I suggest calling that patch
>    "ARM: shmobile: r8a7791: Add PCI device nodes"
> 
> 2. A patch that updates arch/arm/boot/dts/r8a7790-lager.dts
> 
>    I suggest calling that patch
>    "ARM: shmobile: lager: Add PCI device nodes"
> 

For this, and your other comments, will do!

Thanks
Phil

