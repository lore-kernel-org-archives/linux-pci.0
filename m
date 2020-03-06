Return-Path: <SRS0=A4Uv=4X=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40272C3F2D1
	for <linux-pci@archiver.kernel.org>; Fri,  6 Mar 2020 01:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1887820716
	for <linux-pci@archiver.kernel.org>; Fri,  6 Mar 2020 01:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgCFBau (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:30:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCFBau (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 20:30:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8E60F15537995;
        Thu,  5 Mar 2020 17:30:49 -0800 (PST)
Date:   Thu, 05 Mar 2020 17:30:48 -0800 (PST)
Message-Id: <20200305.173048.1775019045524971221.davem@davemloft.net>
To:     jacob.e.keller@intel.com
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        bhelgaas@google.com, kuba@kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Implement function to read Device Serial
 Number
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200303022506.1792776-1-jacob.e.keller@intel.com>
References: <CABhMZUXJ_Omt-+fwa4Oz-Ly=J+NM8+8Ryv-Ad1u_bgEpDRH7RQ@mail.gmail.com>
        <20200303022506.1792776-1-jacob.e.keller@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Mar 2020 17:30:49 -0800 (PST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  2 Mar 2020 18:24:59 -0800

> Several drivers read the Device Serial Number from the PCIe extended
> configuration space. Each of these drivers implements a similar approach to
> finding the position and then extracting the 8 bytes of data.
> 
> Implement a new helper function, pci_get_dsn, which can be used to extract
> this data into an 8 byte array.
 ...

Series applied to net-next, thanks.
