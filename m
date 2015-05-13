Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35874 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933470AbbEMOEk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2015 10:04:40 -0400
Received: by qku63 with SMTP id 63so28582454qku.3
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2015 07:04:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001d08d80$04aea8b0$0e0bfa10$@com>
References: <000001d08d80$04aea8b0$0e0bfa10$@com>
Date: Wed, 13 May 2015 19:34:39 +0530
Message-ID: <CAHM4w1myjzL0Ee+SNFZLYUACuHDmp4AV-6RRjXudVkjuMipsxg@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: Add 8 lanes support
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	Zhang Jukuo <zhangjukuo@huawei.com>,
	Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 13, 2015 at 6:53 PM, Jingoo Han <jingoohan1@gmail.com> wrote:
> On Wed, 13 May 2015 14:44:34 +0800, Zhou Wang wrote:
>> This patch adds 8 lanes support. Following suggestion from Arnd, just split
>> this patch from http://www.spinics.net/lists/linux-pci/msg40467.html
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>
> +cc: Pratyush Anand
>

Thanks, looks fine to me as well. So.

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>
> Best regards,
> Jingoo Han
>
