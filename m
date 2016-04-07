Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33082 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbcDGG7L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 02:59:11 -0400
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
	<EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
Date: Thu, 7 Apr 2016 12:29:09 +0530
Message-ID: <CAHM4w1khRn4xbWbj5Qk-p5DMGjEdWfgr1W1OSsXPFVaYenFa8A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code to dw_pcie_setup_rc()
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Jisheng Zhang <jszhang@marvell.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gab,

Thanks for bringing it.


On Wed, Apr 6, 2016 at 8:20 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> Hi, sorry to be late on this
>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of Jisheng Zhang
>> Sent: 16 March 2016 11:41
>> To: jingoohan1@gmail.com; pratyush.anand@gmail.com; bhelgaas@google.com
>> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Jisheng Zhang
>> Subject: [PATCH v2] PCI: designware: move remaining rc setup code to
>> dw_pcie_setup_rc()
>>
>> dw_pcie_setup_rc(), as its name indicates, setups the RC. But current
>> dw_pcie_host_init() also contains some necessary rc setup code.
>>
>> Another reason: the host may lost power during suspend to ram, the RC
>> need to be re-setup after resume. The rc can't be correctly resumed
>> without the rc setup code in dw_pcie_host_init().
>>
>> So this patch moves the code to dw_pcie_setup_rc() to address the above
>> two issues. After this patch, each pcie designware driver users could
>> call dw_pcie_setup_rc() to re-setup rc when resume back.
>
> I think this patch breaks the Hisilicon driver...
>
> Our driver performs linkup setup in UEFI therefore we do not call
> dw_pcie_setup_rc(), we only call dw_pcie_host_init().
>
> Maybe better to group the part of code to be moved in as separate
> function...
>
> Thanks and sorry for late reply.
>

I am just wondering, should n't then what ever we do in
dw_pcie_setup_rc() be done in your boot loader and not just link up.

~Pratyush
