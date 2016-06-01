Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36403 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbcFAOjw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 10:39:52 -0400
Date: Wed, 1 Jun 2016 09:39:50 -0500
From: Rob Herring <robh@kernel.org>
To: Po Liu <po.liu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan Lian <minghuan.lian@nxp.com>
Subject: Re: [PATCH 1/2] freescale/dts: add pcie aer interrupt-name property
 in the dts
Message-ID: <20160601143950.GA1817@rob-hp-laptop>
References: <1464242349-15323-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464242349-15323-1-git-send-email-po.liu@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 26, 2016 at 01:59:09PM +0800, Po Liu wrote:
> Freescale some platforms aer interrupt was not MSI/MSI-X/INTx

some or all?

> but using interrupt line independently. This patch add a "aer"
> interrupt-names for aer interrupt.

You are not adding, but replacing the interrupt. This needs a better 
explanation as you are breaking compatibility.

Rob
