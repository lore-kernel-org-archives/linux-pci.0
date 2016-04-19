Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33325 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbcDSL1H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 07:27:07 -0400
MIME-Version: 1.0
In-Reply-To: <1460804619-2972-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1460804619-2972-1-git-send-email-gabriele.paoloni@huawei.com>
Date: Tue, 19 Apr 2016 16:57:05 +0530
Message-ID: <CAHM4w1neBhNUeA5MDRzt1sgdczWnX1r7GF1o18sBEVuG50tgeg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Designware: remove wrong RC memory base/limit configuration
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, linuxarm@huawei.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 16, 2016 at 4:33 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
>
> Currently dw_pcie_setup_rc configures memory base and memory
> limit in the type1 configuration header for the root complex.
> In doing so it uses the cpu address (pp->mem_base) rather than
> the bus address (pp->mem_bus_addr): this is wrong and it is
> useless since the configuration is overwritten later on when
> pci_bus_assign_resources() is called.
>
> Therefore this patch just removes this configuration from
> dw_pcie_setup_rc.
>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
