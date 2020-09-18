Return-Path: <SRS0=Geob=C3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D4C43463
	for <linux-pci@archiver.kernel.org>; Fri, 18 Sep 2020 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4481D23888
	for <linux-pci@archiver.kernel.org>; Fri, 18 Sep 2020 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X4vERyHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIRQSB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgIRQSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 12:18:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CAC0613CE;
        Fri, 18 Sep 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=pMf3yFiIumdNcekeEz4Oor/d6RhvmD0GihZ6qnHJHTY=; b=X4vERyHqnHEBEA94wF51qqW4HX
        NghotAlu3GSor0pxZlvBGiNHhbRiNdC+NjJDY4gArxz+EQUb3Q3FMg3dbMRZhdvSQtuAswZWTTp2/
        T4L2vgVfjT/fQsbGttNjeAMsOEO+XCxpWTnlvq4WVVpXsXoQWIhIFtLA6Y66rhs4JZ8S9Lzen/gF8
        G24akz24Y6oR5qETilCtbC0nH3dpd6HdyZeSghodHIqRU9I/zwIN7FLro4RHyCHaTrqUJkHKAoLYG
        ZEluqruYgGD8oIGk0KLS9Uj3GNXuzmb6RRfluQqNZ+mArW3/cZr3FmyuntTySR2v+b/wpvpTU8ef0
        Z7x+YLlA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJJ5D-0005VP-4v; Fri, 18 Sep 2020 16:17:59 +0000
Subject: Re: [PATCH v5 12/17] PCI: endpoint: Add EP function driver to provide
 NTB functionality
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
References: <20200918064227.1463-1-kishon@ti.com>
 <20200918064227.1463-13-kishon@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31985ad8-2e9b-99d8-55ef-4ae90103e499@infradead.org>
Date:   Fri, 18 Sep 2020 09:17:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918064227.1463-13-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 8820d0f7ec77..55ac7bb2d469 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -12,3 +12,15 @@ config PCI_EPF_TEST
>  	   for PCI Endpoint.
>  
>  	   If in doubt, say "N" to disable Endpoint test driver.
> +
> +config PCI_EPF_NTB
> +	tristate "PCI Endpoint NTB driver"
> +	depends on PCI_ENDPOINT
> +	help
> +	   Select this configuration option to enable the NTB driver
> +	   for PCI Endpoint. NTB driver implements NTB controller
> +	   functionality using multiple PCIe endpoint instances. It
> +	   can support NTB endpoint function devices created using
> +	   device tree.

Indent help text with one tab + 2 spaces...
according to coding-style.rst.


> +
> +	   If in doubt, say "N" to disable Endpoint NTB driver.


thanks.
-- 
~Randy

