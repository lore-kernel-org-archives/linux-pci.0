Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:47276 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752647AbcLGUe4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 15:34:56 -0500
Date: Wed, 7 Dec 2016 15:44:10 -0500
From: Keith Busch <keith.busch@intel.com>
To: Wang Sheng-Hui <shhuiw@foxmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Subject: Re: ask for help: How to make pcie-dpc detect DPC feature in
 platform device?
Message-ID: <20161207204410.GB22478@localhost.localdomain>
References: <tencent_1274B1EA3B46AD0574878017@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <tencent_1274B1EA3B46AD0574878017@qq.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 05:30:00PM -0700, Wang Sheng-Hui wrote:
> Keith,
> 
> Sorry to trouble you.
> 
> I'm making up a driver (DPC supported in the device) for our private SoC system, 
> and the driver is regarded as a platform driver.
> 
> I wonder how can I make the pcie-dpc driver detect my DPC-enabled SOC and tigger
> some action in my platform driver?
> 
> And one more question:
>            How to simulate DPC event in simulation env, e.g QEMU?

Sorry for the late reply. A lot of mailing list messages have been
redirected to my spam folder for some reason.

The pcie-dpc driver, if enabled in your kernel config, automatically
binds to any pcie downstream or root port that has the DPC capability. If
your DPC capable device is not seen as a root or downstream pcie port,
then pcie-dpc won't bind to it.

I don't see why you couldn't emulate the capability in QEMU, but I don't
see it implemented in any of the emulated pcie devices, so you'd have
to get someone to implement it in one of them.
