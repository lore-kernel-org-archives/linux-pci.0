Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:52243 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3JANtb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2013 09:49:31 -0400
Message-ID: <524AD2E3.9010808@gmail.com>
Date: Tue, 01 Oct 2013 15:49:23 +0200
From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Wei Yongjun' <weiyj.lk@gmail.com>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	'Grant Likely' <grant.likely@linaro.org>,
	'Rob Herring' <rob.herring@calxeda.com>,
	'Seungwon Jeon' <tgih.jun@samsung.com>,
	'Wei Yongjun' <yongjun_wei@trendmicro.com.cn>
Subject: Re: [PATCH] PCI: exynos: missing clk_disable_unprepare() on error
 in exynos_pcie_probe()
References: <CAPgLHd_RTNxi-OYhmTZ35NttjnAg-gQ_WKHkUQr5ueMhXVLTMg@mail.gmail.com> <000301cebe46$42e86e00$c8b94a00$%han@samsung.com>
In-Reply-To: <000301cebe46$42e86e00$c8b94a00$%han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/01/2013 03:33 AM, Jingoo Han wrote:
> On Sunday, September 29, 2013 11:29 AM, Wei Yongjun wrote:
>>
>> From: Wei Yongjun<yongjun_wei@trendmicro.com.cn>
>>
>> Add the missing clk_disable_unprepare() before return
>> from exynos_pcie_probe() in the error handling case.
>>
>> Signed-off-by: Wei Yongjun<yongjun_wei@trendmicro.com.cn>
>
> Acked-by: Jingoo Han<jg1.han@samsung.com>
>
> However, the commit name should be fixed as below:
> [PATCH] PCI: exynos: use missing clk_disable_unprepare() on error in exynos_pcie_probe()

Perhaps just:

"PCI: exynos: Add missing clk_disable_unprepare() on error path

How can something that is missing be used ? :)
