Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59263 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbaEZJxL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 May 2014 05:53:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so7354246pab.24
        for <linux-pci@vger.kernel.org>; Mon, 26 May 2014 02:53:10 -0700 (PDT)
Message-ID: <53830EE0.1070700@linaro.org>
Date: Mon, 26 May 2014 17:52:32 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	x86@kernel.org, Will Deacon <will.deacon@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PCI: Turn pcibios_penalize_isa_irq() into __weak function
References: <1399346992-6584-1-git-send-email-hanjun.guo@linaro.org> <4534160.Diq8cthzci@wuerfel>
In-Reply-To: <4534160.Diq8cthzci@wuerfel>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014-5-6 15:26, Arnd Bergmann wrote:
> On Tuesday 06 May 2014 11:29:52 Hanjun Guo wrote:
>> pcibios_penalize_isa_irq() is only useful for x86 now, and
>> legacy ISA is not used by some architectures, so make
>> pcibios_penalize_isa_irq() as __weak function to simplify
>> the code, this will prevent new platform from introducing
>> dummy stub function for pcibios_penalize_isa_irq() too.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Hi Bjorn,

Any comments on this patch?

Thanks
Hanjun
