Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A9C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 23:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3492084B
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554159805;
	bh=3Mjx1vmB6gysLzxXmw82/5HSigtoJhMJSy+dfG3Uwq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G2dITAmlyd8IzNJc4/plp6QOE79zVkXiDjrMyzkqFW/63XPxp9LcaYcr45c5lmkHg
	 7t6+R7kYT1LQ/mKGS/7kbm26BUgWJ2XCj2lgD7+OJGFIVFQAkEOvlFM7yHWvPl3byV
	 9dgbl+tjBavsmj8swxj5ZCOqX3UP0LgCoSGoPYIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfDAXDY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfDAXDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 19:03:24 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDD432084B;
        Mon,  1 Apr 2019 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554159803;
        bh=3Mjx1vmB6gysLzxXmw82/5HSigtoJhMJSy+dfG3Uwq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFsC2s0dfEhVf90//G02A9XJeoKu+bxVXOAdVHEvFmmLl5pqA5RFOFC/2ZxJ/kuzU
         9ARCmw326KgmP0i+ggW6zqb2x4wwWJXgKp7zo/FXlRJhRU3IVi6AZ4ubaYOLKbRn30
         0GsQ+aWKHjbaodJ7o04wAr1+LAuJHzSi5NpHgito=
Date:   Mon, 1 Apr 2019 18:03:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190401230321.GB141706@google.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329160413.4293-1-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 30, 2019 at 12:04:01AM +0800, Changbin Du wrote:
> Hi Corbet,

Conventional address would be "Hi Jonathan", just FYI.

> I also did the conversion for PCI documentation. Please check, Thanks!
> 
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted most of the Linux PCI docs to rst
> format in this serias.
> 
> For you to preview, please visit below url:
> http://104.238.181.70:8080/kernel-doc/PCI/index.html
> 
> Thank you!
> 
> Changbin Du (12):
>   Documentation: add Linux PCI to Sphinx TOC tree
>   pci doc: convert PCI/pci.txt to rst format
>   pci doc: convert PCI/PCIEBUS-HOWTO.txt to rst format
>   pci doc: convert PCI/pci-iov-howto.txt to rst format
>   pci doc: convert PCI/MSI-HOWTO.txt to rst format
>   pci doc: convert PCI/acpi-info.txt to rst format
>   pci doc: convert PCI/pci-error-recovery.txt to rst format
>   pci doc: convert PCI/pcieaer-howto.txt to rst format
>   pci doc: convert PCI/endpoint/pci-endpoint.txt to rst format
>   pci doc: convert PCI/endpoint/pci-endpoint-cfs.txt to rst format
>   pci doc: convert PCI/endpoint/pci-test-function.txt to rst format
>   pci doc: convert PCI/endpoint/pci-test-howto.txt to rst format

Thanks for doing all this work!

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

There's not a real convention yet for subject lines in Documentation/,
but I would propose:

  Documentation: PCI: Convert pci.txt to reST
  Documentation: PCI: Convert endpoint/pci-endpoint.txt to reST

because that at least goes with some recent Documentation/PCI changes
and it identifies "reST" as something other than a plain English word
(RST or ReST would also work for me).

>  .../PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst}      |  56 +++--
>  .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  | 112 +++++----
>  .../PCI/{acpi-info.txt => acpi-info.rst}      |  11 +-
>  Documentation/PCI/endpoint/index.rst          |  13 ++
>  ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++++----
>  .../{pci-endpoint.txt => pci-endpoint.rst}    |  74 +++---
>  ...est-function.txt => pci-test-function.rst} |  32 +--
>  ...{pci-test-howto.txt => pci-test-howto.rst} |  51 ++--
>  Documentation/PCI/index.rst                   |  17 ++
>  ...or-recovery.txt => pci-error-recovery.rst} | 180 ++++++++-------
>  .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 144 +++++++-----
>  Documentation/PCI/{pci.txt => pci.rst}        | 218 +++++++++---------
>  .../{pcieaer-howto.txt => pcieaer-howto.rst}  |  67 ++++--
>  Documentation/index.rst                       |   1 +
>  MAINTAINERS                                   |   2 +-
>  15 files changed, 641 insertions(+), 436 deletions(-)
>  rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (89%)
>  rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (75%)
>  rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)
>  create mode 100644 Documentation/PCI/endpoint/index.rst
>  rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
>  rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (86%)
>  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
>  rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (83%)
>  create mode 100644 Documentation/PCI/index.rst
>  rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)
>  rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (65%)
>  rename Documentation/PCI/{pci.txt => pci.rst} (80%)
>  rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (83%)
> 
> -- 
> 2.20.1
> 
