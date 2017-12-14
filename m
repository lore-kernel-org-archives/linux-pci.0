Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:47124 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdLNLKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 06:10:02 -0500
Subject: Re: [PATCH v4 3/3] PCI: endpoint: Fix find_first_zero_bit() usage
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
 <20171212141634.5985-4-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7bd08771-d860-52b6-9439-a45a1b70c6e0@ti.com>
Date: Thu, 14 Dec 2017 16:39:52 +0530
MIME-Version: 1.0
In-Reply-To: <20171212141634.5985-4-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 12 December 2017 07:46 PM, Niklas Cassel wrote:
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix this by calling find_first_zero_bit() with size BITS_PER_LONG,
> rather than sizeof() and add missing find_first_zero_bit() return
> handling.
> 
> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

I'll hold Acking this patch, since it is dependent on the previous one.

Thanks
Kishon
