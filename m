Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32830 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbcA2QQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2016 11:16:50 -0500
Received: by mail-vk0-f66.google.com with SMTP id n1so3069696vkb.0
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2016 08:16:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454066972-3609-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1454066972-3609-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1454066972-3609-2-git-send-email-lorenzo.pieralisi@arm.com>
Date: Fri, 29 Jan 2016 21:46:49 +0530
Message-ID: <CAHM4w1nGWtJP57jLJAoh4bu0YZCK6dMUYujxy-xnRgC4TrJBzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: pci: host: designware: remove PCI_PROBE_ONLY handling
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 29, 2016 at 4:59 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> The PCIe designware host driver is not used in system configurations
> requiring the PCI_PROBE_ONLY flag to be set to prevent resources
> assignment, therefore the driver code handling the flag can be
> removed from the kernel.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>


Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
