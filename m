Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F209C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71BA205C9
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554310741;
	bh=3g36jHGdFK5MyjOcqtR8XuXiOCEx1C8Ty2LeBYG1sBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m7yvGifc275fDwZPr17zgrTMSLOuJkR5i1Qs6flwaXsmJ/MCuCGKOSFPzRl+p5xTv
	 856pIEuw/MESH8ltWG8xSQ46fnw36k84oACHfPHdnAEQHrKXf6AMMwQnxtBAVp5a1C
	 IUfEL9nyMjlTK1s91ss0oalZ31VQjQMf02RQkyvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDCQ7B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCQ7B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Apr 2019 12:59:01 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA0C20663;
        Wed,  3 Apr 2019 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554310740;
        bh=3g36jHGdFK5MyjOcqtR8XuXiOCEx1C8Ty2LeBYG1sBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOlbrkzDWcVxsFibt7o+a3B7plj9hTBSED1NZkefzoUWgGFDvFib4F7kBSSJIZORT
         f5l1zaN2Px8aDGiu/OJmObwlNRgaj1LmVgSXDeFBYlJMUvZV6/pmzftH69NzM45TFa
         LgV0PzXuXruSwL1ab78x2vut1QbEi7UbuCT0xyfw=
Date:   Wed, 3 Apr 2019 11:58:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190403165858.GA67241@google.com>
References: <20190403154955.12096-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403154955.12096-1-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 03, 2019 at 11:49:43PM +0800, Changbin Du wrote:
> Hi all,
> 
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted most of the Linux PCI docs to rst
> format in this serias.
> 
> For you to preview, please visit below url:
> http://www.bytemem.com:8080/kernel-doc/PCI/index.html
> 
> Thank you!
> 
> v2: trivial style update.
> 
> Changbin Du (12):
>   Documentation: add Linux PCI to Sphinx TOC tree
>   Documentation: PCI: convert PCI/pci.txt to reST format
>   Documentation: PCI: convert PCI/PCIEBUS-HOWTO.txt to reST format
>   Documentation: PCI: convert PCI/pci-iov-howto.txt to reST format
>   Documentation: PCI: convert PCI/MSI-HOWTO.txt to reST format
>   Documentation: PCI: convert PCI/acpi-info.txt to reST format
>   Documentation: PCI: convert PCI/pci-error-recovery.txt to reST format
>   Documentation: PCI: convert PCI/pcieaer-howto.txt to reST format
>   Documentation: PCI: convert PCI/endpoint/pci-endpoint.txt to reST
>     format
>   Documentation: PCI: convert PCI/endpoint/pci-endpoint-cfs.txt to reST
>     format
>   Documentation: PCI: convert PCI/endpoint/pci-test-function.txt to reST
>     format
>   Documentation: PCI: convert PCI/endpoint/pci-test-howto.txt to reST
>     format

Thanks for doing that!  If you have occasion to revise this for any
other reason, I actually suggested this:

  Documentation: PCI: Convert pci.txt to reST
  Documentation: PCI: Convert endpoint/pci-endpoint.txt to reST

which (a) Capitalizes the "Convert" and (b) omits the "PCI/" prefix
because it seems redundant.

By coincidence I happened across this post that talks about why I care
about these seemingly trivial things:

  https://chris.beams.io/posts/git-commit/

But with or without that change, for the whole series:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>  .../PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst}      |  83 +++---
>  .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  | 140 +++++----
>  .../PCI/{acpi-info.txt => acpi-info.rst}      |  11 +-
>  Documentation/PCI/endpoint/index.rst          |  13 +
>  ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++++---
>  .../{pci-endpoint.txt => pci-endpoint.rst}    |  95 ++++---
>  ...est-function.txt => pci-test-function.rst} |  32 ++-
>  ...{pci-test-howto.txt => pci-test-howto.rst} |  81 ++++--
>  Documentation/PCI/index.rst                   |  18 ++
>  ...or-recovery.txt => pci-error-recovery.rst} | 178 ++++++------
>  .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++++-----
>  Documentation/PCI/{pci.txt => pci.rst}        | 267 +++++++++---------
>  .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 110 +++++---
>  Documentation/index.rst                       |   1 +
>  MAINTAINERS                                   |   2 +-
>  15 files changed, 754 insertions(+), 537 deletions(-)
>  rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (88%)
>  rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (70%)
>  rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)
>  create mode 100644 Documentation/PCI/endpoint/index.rst
>  rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
>  rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (82%)
>  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
>  rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
>  create mode 100644 Documentation/PCI/index.rst
>  rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)
>  rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)
>  rename Documentation/PCI/{pci.txt => pci.rst} (78%)
>  rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (81%)
> 
> -- 
> 2.20.1
> 
