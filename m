Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:38719 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751034Ab3ILJhK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2013 05:37:10 -0400
Date: Thu, 12 Sep 2013 11:37:06 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jason Cooper' <jason@lakedaemon.net>
Subject: Re: [PATCH 2/3] PCI: mvebu: make local functions static
Message-ID: <20130912113706.0289df56@skate>
In-Reply-To: <000401ceaf9b$9132cba0$b39862e0$%han@samsung.com>
References: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
	<000401ceaf9b$9132cba0$b39862e0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jingoo Han,

On Thu, 12 Sep 2013 18:36:33 +0900, Jingoo Han wrote:
> mvebu_pcie_add_bus(), mvebu_pcie_align_resource()  are used only
> in this file. Thus, these local functions should be staticized
> in order to fix the following sparse warnings:
> 
> drivers/pci/host/pci-mvebu.c:684:6: warning: symbol
> 'mvebu_pcie_add_bus' was not declared. Should it be static?
> drivers/pci/host/pci-mvebu.c:690:17: warning: symbol
> 'mvebu_pcie_align_resource' was not declared. Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
