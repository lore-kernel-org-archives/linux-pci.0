Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA877C677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 19:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8B52098A
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 19:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTpbkh6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8B52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeJLDFc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeJLDFc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 23:05:32 -0400
Received: from localhost (32.sub-174-234-152.myvzw.com [174.234.152.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6952075C;
        Thu, 11 Oct 2018 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539286611;
        bh=F7reNq7i1JQtZiheMHZGjzCNw6qSNWvN0YkpsnrI3sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTpbkh6Eb9MYLlsOa8/pNmYC01BtbaTTr2RglLBosBxStnWnkuyhPOxkEsn2Kpw8m
         A/pD0e3JnYTBrqRStohOOPtHI7SK2/AvFn05L2oDJ79M9x9xsR+3jPVY/bQZzPY+Re
         jciEqecj4icqJb43oH90dgpjEoBZVlYvtaVoqlBw=
Date:   Thu, 11 Oct 2018 14:36:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/virtualization 1/2] drivers/pci/probe.c:1460:15: error:
 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
Message-ID: <20181011193649.GT5906@bhelgaas-glaptop.roam.corp.google.com>
References: <201810120115.eUoVoata%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810120115.eUoVoata%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 01:16:19AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/virtualization
> head:   71fad47b6941d0922562a1e5e32f57b99f9f2c32
> commit: 601f9f6679157b70a7a4e752baa590bd2af69ffb [1/2] PCI/IOV: Use VF0 cached config space size for other VFs
> config: i386-randconfig-x002-201840 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 601f9f6679157b70a7a4e752baa590bd2af69ffb
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/probe.c: In function 'pci_cfg_space_size':
> >> drivers/pci/probe.c:1460:15: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
>       return dev->physfn->sriov->cfg_size;
>                   ^~~~~~
>                   is_physfn

Sorry, this was my fault.  I fixed it.
