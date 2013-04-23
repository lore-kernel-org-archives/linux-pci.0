Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:34659
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755402Ab3DWKuu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2013 06:50:50 -0400
Message-ID: <5176679D.7090008@freescale.com>
Date: Tue, 23 Apr 2013 18:51:09 +0800
From: Chen Yuanquan-B41889 <B41889@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yuanquan Chen <Yuanquan.Chen@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Subject: Re: [PATCH] powerpc/pci: fix PCI-e devices rescan issue on powerpc
 platform
References: <1364902014-943-1-git-send-email-Yuanquan.Chen@freescale.com>  <1364915422.16520.8.camel@pasglop> <515BAB44.9070001@freescale.com>  <51652C20.2060105@freescale.com> <517653D8.8000205@freescale.com> <1366711520.2886.24.camel@pasglop>
In-Reply-To: <1366711520.2886.24.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/23/2013 06:05 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2013-04-23 at 17:26 +0800, Chen Yuanquan-B41889 wrote:
>> There's no response from Ben. How do you think about this patch?
>> What's
>> your advice?
> Didn't Michael put your patch in -next while I was on vacation ? I'll
> check tomorrow.
>
> Cheers,
> Ben.
>

Hi Ben,

I have checked the latest kernel(v3.9-rc7). This patch has been applied.

Thanks,
Yuanquan

>
>
>


