Return-Path: <SRS0=D/+s=AQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D82C433E0
	for <linux-pci@archiver.kernel.org>; Sun,  5 Jul 2020 11:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6CD20739
	for <linux-pci@archiver.kernel.org>; Sun,  5 Jul 2020 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593949750;
	bh=iCu9UAIJm6TBbuLUaXFLsgTtuafoH/z57UaD3/vrcmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vtWS31LudCzh0TKqOzJQkpLYHc4EzI4gIURwdt/w0VsdVGPibo3wQdpEp1haPpijO
	 VHspdLh+rcQORHx1K1jFtQAhAjebkChHuj65TDTz0VzB7i3I2kgBs7zCEq+67tsCJv
	 xADK4blvAF177vVBGtXN+VUbIlD/B/JBaj2hf6dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGELtJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 5 Jul 2020 07:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELtJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 5 Jul 2020 07:49:09 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497B320723;
        Sun,  5 Jul 2020 11:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949749;
        bh=iCu9UAIJm6TBbuLUaXFLsgTtuafoH/z57UaD3/vrcmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+v1y5YWBABT090Sgp2aqWkr4NhIbv68eNFeO9gutQvgQJ6PrLKshxXBtsfN55hug
         c4dXoiwlIMX3IV6hfV7+NgUH+JI2IYrXC7wbjUBmVSWyOZgFflvLDpFE0WIn5tIvye
         l6xWPmZPh7PjDW4iRicXXEPTF18ef06Cy8S9D3ow=
Date:   Sun, 5 Jul 2020 14:49:01 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH 0/4] Documentation: PCI: eliminate doubled words
Message-ID: <20200705114901.GG2999148@kernel.org>
References: <20200703212156.30453-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703212156.30453-1-rdunlap@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 03, 2020 at 02:21:52PM -0700, Randy Dunlap wrote:
> Fix doubled (duplicated) words in Documentation/PCI/.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Linas Vepstas <linasvepstas@gmail.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

>  Documentation/PCI/endpoint/pci-endpoint-cfs.rst |    2 +-
>  Documentation/PCI/endpoint/pci-endpoint.rst     |    2 +-
>  Documentation/PCI/pci-error-recovery.rst        |    2 +-
>  Documentation/PCI/pci.rst                       |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

-- 
Sincerely yours,
Mike.
