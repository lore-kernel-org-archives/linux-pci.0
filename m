Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:58413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbcKHQZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2016 11:25:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        bhelgaas@google.com, mark.rutland@arm.com, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org,
        benh@kernel.crashing.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Tue, 08 Nov 2016 17:24:35 +0100
Message-ID: <1555494.4IFvGxvsfe@wuerfel>
In-Reply-To: <1478576829-112707-4-git-send-email-yuanzhichang@hisilicon.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <1478576829-112707-4-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:
> +       /*
> +        * The first PCIBIOS_MIN_IO is reserved specifically for indirectIO.
> +        * It will separate indirectIO range from pci host bridge to
> +        * avoid the possible PIO conflict.
> +        * Set the indirectIO range directly here.
> +        */
> +       lpcdev->io_ops.start = 0;
> +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
> +       lpcdev->io_ops.devpara = lpcdev;
> +       lpcdev->io_ops.pfin = hisilpc_comm_in;
> +       lpcdev->io_ops.pfout = hisilpc_comm_out;
> +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
> +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;

I have to look at patch 2 in more detail again, after missing a few review
rounds. I'm still a bit skeptical about hardcoding a logical I/O port
range here, and would hope that we can just go through the same
assignment of logical port ranges that we have for PCI buses, decoupling
the bus addresses from the linux-internal ones.

	Arnd
