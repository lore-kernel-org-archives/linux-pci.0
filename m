Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E375C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 23:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5349F218A5
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 23:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553123714;
	bh=8/iDkKwCKAv25h89N4o0KQXtJz0Ow1OVrrKkgI2uwko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=alR9zPToCRKvRZDjkbjfGtesBArRFsCdwvUJ1XR9pBNA5AIb36+xVZ3uJLwXZrByM
	 0LLKHuEfvbc4IveXaAkHOPmtVp55V2ZuzPB5NdqyhfY3tiBRcaZmqLifOAwjrJ4Luo
	 3AIyVC8FRtXlkdSSkhv8Kk/7Aq9JEUcGK2DASzSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCTXPN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbfCTXPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 19:15:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682C22183E;
        Wed, 20 Mar 2019 23:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553123712;
        bh=8/iDkKwCKAv25h89N4o0KQXtJz0Ow1OVrrKkgI2uwko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Za75zfkNm504Dkr1ImKxUFTnAIIsjhEhHKVf68kyLvtnzRqyfF9D+9S6g95b1TFEA
         HZAkR4ifw/eRPrKbF1rlGVMkAoQafm8uwFFhNr+jqCjwEhMG15FX4020XMAX61FyzE
         fAYkJ1CDgrGUb++8ge7MvU8c8pMo1PpK3gVhI/os=
Date:   Wed, 20 Mar 2019 18:15:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 00/12] PCI: brcmstb: Add Broadcom Settopbox PCIe
 support (resend)
Message-ID: <20190320231508.GJ251185@google.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 10:31:55AM -0400, Jim Quinlan wrote:
> This patch series adds support for the Broadcom Settopbox PCIe host
> controller.  It is targeted to Broadcom Settopbox chips running on
> ARM, ARM64, and MIPS platforms.

Whatever happened with this series?  I saw some discussion that suggests
it's not quite ready to be merged, but there's a lot of good work here,
so I hope it can get finished up.

Bjorn
