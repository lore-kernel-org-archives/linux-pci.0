Return-Path: <SRS0=Ym3V=TM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A523C04A6B
	for <linux-pci@archiver.kernel.org>; Sun, 12 May 2019 14:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4886A2133D
	for <linux-pci@archiver.kernel.org>; Sun, 12 May 2019 14:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfELOWS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 12 May 2019 10:22:18 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:59433 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbfELOWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 10:22:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 86C44182CF666;
        Sun, 12 May 2019 14:22:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skin28_8819c53057e61
X-Filterd-Recvd-Size: 1760
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 May 2019 14:22:15 +0000 (UTC)
Message-ID: <d00c1c42689e08df0ce7cd8b2c796eee5b9f5642.camel@perches.com>
Subject: Re: [PATCH v4 07/12] Documentation: PCI: convert
 pci-error-recovery.txt to reST
From:   Joe Perches <joe@perches.com>
To:     Changbin Du <changbin.du@gmail.com>, bhelgaas@google.com,
        corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org
Date:   Sun, 12 May 2019 07:22:13 -0700
In-Reply-To: <20190512125009.32079-8-changbin.du@gmail.com>
References: <20190512125009.32079-1-changbin.du@gmail.com>
         <20190512125009.32079-8-changbin.du@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2019-05-12 at 20:50 +0800, Changbin Du wrote:
> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -12100,7 +12100,7 @@ M:	Sam Bobroff <sbobroff@linux.ibm.com>
>  M:	Oliver O'Halloran <oohall@gmail.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> -F:	Documentation/PCI/pci-error-recovery.txt
> +F:	Documentation/PCI/pci-error-recovery.rst
>  F:	drivers/pci/pcie/aer.c
>  F:	drivers/pci/pcie/dpc.c
>  F:	drivers/pci/pcie/err.c

There is another section to update as well:

PCI ERROR RECOVERY
M:	Linas Vepstas <linasvepstas@gmail.com>
L:	linux-pci@vger.kernel.org
S:	Supported
F:	Documentation/PCI/pci-error-recovery.txt


