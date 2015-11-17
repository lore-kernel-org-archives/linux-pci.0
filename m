Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33029 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbKQDSu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2015 22:18:50 -0500
Received: by pabfh17 with SMTP id fh17so199121837pab.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2015 19:18:50 -0800 (PST)
Message-ID: <564A9C54.3090904@linaro.org>
Date: Tue, 17 Nov 2015 11:17:40 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Zhou Wang <wangzhou1@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>
CC: linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@marvell.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hisi: fix deferred probing
References: <1447329728-1589-1-git-send-email-jszhang@marvell.com> <4417267.EzK5DAjM5p@wuerfel> <56459149.8090709@hisilicon.com>
In-Reply-To: <56459149.8090709@hisilicon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/13/2015 03:29 PM, Zhou Wang wrote:
> On 2015/11/12 20:21, Arnd Bergmann wrote:
>> The hisi_pcie_probe function is incorrectly marked as __init, as Kconfig
>> tells us:
>>
>> WARNING: drivers/pci/host/built-in.o(.data+0x7780): Section mismatch in reference from the variable hisi_pcie_driver to the function .init.text:hisi_pcie_probe()
>>
>> If the probe for this device gets deferred past the point where __init
>> functions are removed, or the device is unbound and then reattached to
>> the driver, we branch into uninitialized memory, which is bad.
>>
>> This removes the __init annotation.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>
> Hi Arnd,
>
> Many thanks, it looks good to me. so
> Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

I found this problem too and prepared a patch for it, but
I noticed that Arnd already fixed it :)

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
