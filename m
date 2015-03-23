Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36705 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbbCWSSX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2015 14:18:23 -0400
Received: by ykcn8 with SMTP id n8so76855209ykc.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2015 11:18:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201503240247.Lu2Ttzhc%fengguang.wu@intel.com>
References: <201503240247.Lu2Ttzhc%fengguang.wu@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Mar 2015 13:18:03 -0500
Message-ID: <CAErSpo6zfA7t-CeYx1_aBYEcV=LFueWYE_bndH-s-ktjL_goPg@mail.gmail.com>
Subject: Re: [pci:pci/enumeration-yw7 32/35] drivers/pci/host-bridge.c:147:24:
 sparse: symbol 'pci_find_host_bridge' was not declared. Should it be static?
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"kbuild-all@01.org" <kbuild-all@01.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yijing,

On Mon, Mar 23, 2015 at 1:08 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration-yw7
> head:   2681a1f3d2011d4cbb888d3e974a13bda85d225c
> commit: 2577ed41b6a6db3117713069e49b72091b60c867 [32/35] PCI: rename to pci_find_host_bridge()
> reproduce:
>   # apt-get install sparse
>   git checkout 2577ed41b6a6db3117713069e49b72091b60c867
>   make ARCH=x86_64 allmodconfig
>   make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/pci/host-bridge.c:147:24: sparse: symbol 'pci_find_host_bridge' was not declared. Should it be static?
>
> Please review and possibly fold the followup patch.

It does look like pci_find_host_bridge() is only used inside
drivers/pci/host-bridge.c and could be static.  Given that it's only
used there, it doesn't even need to be renamed, so maybe you could
even just drop the rename patch, too.

Bjorn
