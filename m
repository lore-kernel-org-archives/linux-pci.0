Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927F9C43381
	for <linux-pci@archiver.kernel.org>; Tue,  2 Feb 2021 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6D64E56
	for <linux-pci@archiver.kernel.org>; Tue,  2 Feb 2021 18:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbhBBSDL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Feb 2021 13:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbhBBSBM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 13:01:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA07DC0613ED;
        Tue,  2 Feb 2021 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=34JzfiaD98noVdYI8wGijdt5CbMl5vmcMb4nVnbQldQ=; b=vO5z5tvjc31myEUZzGdE71R7Br
        Y/Nzfs8zJY3uV6y00Mu/zEVEuwDCnaWBP6eQDvXu9TgZYzNa27lpaKOBRtu9RgwBdeWVMcavrCjjV
        toAyiyWm0vxFwXBjDYsOgWNyGOG6Xbs5JEA6G7YGX6TCA2TWe1ShBYZVhTZYhKgV7rULNHXjAHAOd
        ki+AU+lsEHlKowzeBwXTkqImxPd90/51+ccfIDW0dVXiCeZmURqv5kO913twHNJCIT6QnmEhq8Ppo
        iWdmd1PWCPDoACyTXy2Hoz+wGH9jdKYph4lEObpw24XkEk+eQUJQYJBEr6SVxYnqmPZoh2a8zxgcF
        my47UCuQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6zyW-00FYwW-Ne; Tue, 02 Feb 2021 18:00:28 +0000
Date:   Tue, 2 Feb 2021 18:00:28 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210202180028.GB3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-2-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-2-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> +{
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
> +
> +	while (pos) {
> +		u16 vendor, id;
> +
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_ID_OFFSET,
> +				     &vendor);
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> +		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos,
> +						   PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return 0;
> +}

There should be a patch with a generic version of this find a vendor
specific capability helper on linux-pci.

> +#define PCI_CLASS_MEMORY_CXL	0x050210

I think this should go into linux/pci_ids.h.
