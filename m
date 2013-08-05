Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50210 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab3HEHTQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 03:19:16 -0400
Message-ID: <51FF51EB.9070907@oracle.com>
Date: Mon, 05 Aug 2013 15:19:07 +0800
From: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reply-To: zhenzhong.duan@oracle.com
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	xen-devel <xen-devel@lists.xen.org>,
	Feng Jin <joe.jin@oracle.com>,
	Sucheta Chakraborty <sucheta.chakraborty@qlogic.com>
Subject: Re: [PATCH 2/3] Refactor msi/msix restore code Part2
References: <51EF451A.8050003@oracle.com> <CAErSpo5phkLpdR35eaMnYthVXiAAAr-JLD44QkntOZi2-NppOg@mail.gmail.com> <20130801151616.GE21528@konrad-lan.dumpdata.com> <51FB78D1.6060802@oracle.com> <20130802120101.GE24540@konrad-lan.dumpdata.com>
In-Reply-To: <20130802120101.GE24540@konrad-lan.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 2013-08-02 20:01, Konrad Rzeszutek Wilk wrote:
>>>> Konrad, are you OK with this patch now?
>>> Yes, I wanted to make sure that the existing behavior under baremetal
>>> was not altered.
>>>
>>> And Duan had confirmed it was not  - thought to be on a safe side it
>>> would be good to confirm this via testing just in case.
>> I had ever let our customer test on baremetal and it passed.
> Are they OK with being credited for this in the patch? Meaning are they
> OK with Reported-by-and-Tested-by: flag?
sucheta.chakraborty from Qlogic also reproduced the same and I got his 
confirm patch worked.
Already add him in tested-by.

zduan
>
> Either way, I think the only remaining issue is to expand the git commit
> a bit to include the discussion about the flow of the pci_read/pci_write
> and point out that the logic remains the same.
>
>
>> zduan

