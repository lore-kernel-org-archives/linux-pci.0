Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56857 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472AbbDPIA6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2015 04:00:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	gabriele.paoloni@huawei.com, yuanzhichang@hisilicon.com,
	zhudacai@hisilicon.com, zhangjukuo@huawei.com,
	xiehaitao@huawei.com, liguozhu@hisilicon.com,
	wangzhou.bry@gmail.com
Subject: Re: [RFC PATCH 1/3] PCI: host: designware: support ARM64
Date: Thu, 16 Apr 2015 10:00:12 +0200
Message-ID: <4046182.mBfkEVqZjc@wuerfel>
In-Reply-To: <552F4DF3.6000402@hisilicon.com>
References: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com> <5374927.lpgzSJ47Sk@wuerfel> <552F4DF3.6000402@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 16 April 2015 13:51:47 Zhou Wang wrote:
> > 
> > Again, separate patch.
> > 
> > I've just tried to come up with a nicer way of doing all this, can
> > you try the experimental patch below?
> > 
> >       Arnd
> > 
> 
> Sure, I will try the patch below. I think it can work well in my Hisilicon
> D02 board. But I don't have arm32 PCIe related board to test. It will be helpful
> if someone could help to test it.

Ok, please incorporate the patch into your series then and make sure it
builds fine on both 32-bit (multi_v7_defconfig) and 64-bit ARM. If we
get consensus on the code, I'm sure we can find testers.

	Arnd
