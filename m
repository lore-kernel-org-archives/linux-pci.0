Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77897C43441
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4FF2086A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 09:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hKq7HD4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4FF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeJLQuZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:50:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbeJLQuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Oct 2018 12:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2xe+s4Wbr7FgqF/2Q1owCcxKtS/pF8tx/FqElyXCSu0=; b=hKq7HD4T+gtaq12jv6h33B4O9
        XS7jpMYmJ5qhvbGohfMSP/5jzmeAdglfd8fY5LdEaPWdE7PmzHgeHAlxugEU1jar9GboYyw9qfsPS
        oy2B7pzvf3QYG7RYJnXl5JM9NL4HvLu9J8YaSad3NuWcFEzsBwwMSl9soHjL93IpDF+tErxOXKvw5
        un60WQR9/COsOvEvtD0NPiVfiCztEKZpbqgpimFA7EUNDgrkT9J/MK+pnvY3Gaj5TIv+SOfKI8MtP
        5XbpAeapm4BaznQrfHNPkfj51SUwbjrml6nTXgGIdNAFYGT5NK8NkrnsnwnUm3TClsPyWmKXSfua7
        Avw+QFtHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAtaw-0002tx-Bq; Fri, 12 Oct 2018 09:18:54 +0000
Date:   Fri, 12 Oct 2018 02:18:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
Subject: Re: [PATCH v5 09/11] PCI: Add options to pci_reset_function
Message-ID: <20181012091854.GB6669@infradead.org>
References: <20181011045008.32212-1-okaya@kernel.org>
 <20181011045008.32212-9-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011045008.32212-9-okaya@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 04:50:01AM +0000, Sinan Kaya wrote:
> Getting ready to deprecate pci_reset_function_locked(). Add
> saverestore and locked parameters to pci_reset_function() function
> and add saverestore = true and locked = false to all existing
> callers.

NAK - no conditional locking based on a parameter, please.
