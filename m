Return-Path: <SRS0=D2E3=DE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D77C4346E
	for <linux-pci@archiver.kernel.org>; Sun, 27 Sep 2020 09:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3E623977
	for <linux-pci@archiver.kernel.org>; Sun, 27 Sep 2020 09:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgI0JO3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 27 Sep 2020 05:14:29 -0400
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:42266 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbgI0JO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 05:14:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 67EF2100E7B43;
        Sun, 27 Sep 2020 09:14:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: map07_2d111ff27177
X-Filterd-Recvd-Size: 2342
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Sep 2020 09:14:26 +0000 (UTC)
Message-ID: <6e7fe17a30e455187066da1079fad0941f5aa5cc.camel@perches.com>
Subject: Re: [PATCH 4/5 V4] PCI: only return true when dev io state is
 really changed
From:   Joe Perches <joe@perches.com>
To:     Ethan Zhao <haifeng.zhao@intel.com>, bhelgaas@google.com,
        oohall@gmail.com, ruscur@russell.cc, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com, mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com, hch@infradead.org
Date:   Sun, 27 Sep 2020 02:14:25 -0700
In-Reply-To: <20200927082736.14633-5-haifeng.zhao@intel.com>
References: <20200927082736.14633-1-haifeng.zhao@intel.com>
         <20200927082736.14633-5-haifeng.zhao@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2020-09-27 at 04:27 -0400, Ethan Zhao wrote:
> When uncorrectable error happens, AER driver and DPC driver interrupt
> handlers likely call
> 
>    pcie_do_recovery()
>    ->pci_walk_bus()
>      ->report_frozen_detected()
> 
> with pci_channel_io_frozen the same time.
>    If pci_dev_set_io_state() return true even if the original state is
> pci_channel_io_frozen, that will cause AER or DPC handler re-enter
> the error detecting and recovery procedure one after another.
>    The result is the recovery flow mixed between AER and DPC.
> So simplify the pci_dev_set_io_state() function to only return true
> when dev->error_state is changed.
> 
> Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> Tested-by: Wen Jin <wen.jin@intel.com>
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Reviewed-by: Joe Perches <joe@perches.com>

Hi Ethan/Haifeng.

Like Andy, I did not "review" this patch and sign it.
I merely suggested another simplification.
Please do not add -by: lines unless actually received by you.


