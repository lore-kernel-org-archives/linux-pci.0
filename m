Return-Path: <SRS0=qnmi=YM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B440CA9EAC
	for <linux-pci@archiver.kernel.org>; Sat, 19 Oct 2019 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2915B20872
	for <linux-pci@archiver.kernel.org>; Sat, 19 Oct 2019 08:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sA/UjIes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfJSIel (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:34:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfJSIel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Oct 2019 04:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=efxDZLovhWIsVcKlBeoAv6/PbDTOqjRHdFPX6c+nSqI=; b=sA/UjIesauDMAOC8QbNr7SoNs
        4REJpMZYaeLtw/RXa2i39bQefpGee1IVtiLTCW0s1tYGJAzeoMQyYUlRYa8/Kk92/HnKP9Gdb0aW7
        yWWtRpw7t5PI1HN3PzRAOWvKrMI+/JR75//jaTllBitf1RaLEGa7mNHwVCj35E2ms1fc+yL2wx02t
        EpmCtDJktGTDABTuokYKzR8/i3JuCZx1d0+/nV0PX0FICIftJEu+y0em89gt0LOp6kyg/8mR2CCyz
        i/lgJYoj+hiVXHQib0xd9lRiG06LnPohkubCI0+OItJ6CV1h7ggHne69xKfQH//18fX5GQpo0zxPE
        VdQNOCwMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLkBz-0006ty-5X; Sat, 19 Oct 2019 08:34:31 +0000
Date:   Sat, 19 Oct 2019 01:34:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        peterz@infradead.org, robin.murphy@arm.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, paul.burton@mips.com
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
Message-ID: <20191019083431.GA26340@infradead.org>
References: <1571467543-26125-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571467543-26125-1-git-send-email-linyunsheng@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
> +	if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
> +		dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
> +

The whole idea of mentioning a BIOS in architeture indepent code doesn't
make sense at all.
