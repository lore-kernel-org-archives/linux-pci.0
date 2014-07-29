Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:44999 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbaG2IDy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jul 2014 04:03:54 -0400
Message-ID: <53D752B5.1040006@huawei.com>
Date: Tue, 29 Jul 2014 15:52:21 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <Jordan_Hargrave@Dell.com>,
	<keith.busch@intel.com>
Subject: Re: [PATCH] Update device mps when doing pci hotplug
References: <1406621860-11967-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1406621860-11967-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/29 16:17, Yijing Wang wrote:
> Hi Bjorn,
> 	Keith Busch and jordan hargrave reported the same issue about
> mps issue after pci device hot add. It seems that more firmware
> set device mps >=256B default. So can you pick up this patch to fix
> this issue temporarily.
> 
> Yijing Wang (1):
>   PCI: update device mps when doing pci hotplug
> 
>  drivers/pci/probe.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 

Oh, sorry to cc the wrong email address to Jon, got a copy from jordan's last email. Will resend.

> 
> .
> 


-- 
Thanks!
Yijing

