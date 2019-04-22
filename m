Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40B1C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 23:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7353C20859
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555974239;
	bh=N7th4S9j1WjwNCgF21IL2GaQQP8ZSm2WompJXYc9sQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JtLKHMAyovfKAdpE7oWgY3X2q2+fiZ1i69J8BOyWIUy8hSuQy7mXn9ERjIDSsyLT4
	 +WPG73oHcXQ35ZAG8xrSNlcKVEgv2D8nwMpmhd1l/HEODJ0+C10pq8OBkhAmFvreVI
	 A33gq+qtcqzqz2qTFbORDOvPuXzcFGpZoUPN88FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfDVXD6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbfDVXD6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 19:03:58 -0400
Received: from localhost (unknown [146.7.4.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9AB20811;
        Mon, 22 Apr 2019 23:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555974237;
        bh=N7th4S9j1WjwNCgF21IL2GaQQP8ZSm2WompJXYc9sQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yT0jkpbpH5PtFOqWZqDdxFepC24p8kvBk8LmAyRXmDE4lXpis1ioLIfN2paejhna7
         l867dh/CLQLCKNvwytEJEJOW9Y+1YoJk62EFt0OVEtPSIFgi/EUrt2ObSXXFO/3/7b
         e5h7p0q3M5bbzCTK8IF9xwq2SFm64Zc/xBO1zYnc=
Date:   Mon, 22 Apr 2019 18:03:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/hotplug 4/5] include/linux/pci_hotplug.h:145:1: error:
 expected identifier or '(' before '{' token
Message-ID: <20190422230355.GN173520@google.com>
References: <201904230541.l1Tz6i3p%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904230541.l1Tz6i3p%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 05:19:48AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
> head:   d98ba96a72ca1a1dd9d2f3a321e64bac3d94bd39
> commit: 93395b9ebeb0cfee5e5c617ec44d249d19439126 [4/5] PCI / ACPI: Remove the need for 'struct hotplug_params'
> config: xtensa-common_defconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 93395b9ebeb0cfee5e5c617ec44d249d19439126
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/pci/pci.c:30:
> >> include/linux/pci_hotplug.h:145:1: error: expected identifier or '(' before '{' token
>     {
>     ^

I fixed this and updated the pci/hotplug branch.

Bjorn
