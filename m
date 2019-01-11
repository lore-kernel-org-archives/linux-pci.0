Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E728C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 06:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1B520675
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 06:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfAKGAY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:00:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:34452 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfAKGAY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 01:00:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 22:00:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,464,1539673200"; 
   d="scan'208";a="134930843"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.70])
  by fmsmga004.fm.intel.com with SMTP; 10 Jan 2019 22:00:22 -0800
Received: by ubuntu (sSMTP sendmail emulation); Fri, 11 Jan 2019 14:00:16 +0800
Message-ID: <1547186416.35646.4.camel@intel.com>
Subject: Re: [PATCH v3 0/2] Add Stratix 10 PCIe Root Port support
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com
Date:   Fri, 11 Jan 2019 14:00:16 +0800
In-Reply-To: <1546409810-37630-1-git-send-email-ley.foon.tan@intel.com>
References: <1546409810-37630-1-git-send-email-ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-01-02 at 14:16 +0800, Ley Foon Tan wrote:
> Add PCIe Root Port support for Stratix 10 device and also update
> device tree binding documentation.
> 
> v2 -> v3:
> ---------
> - Rename Stratix10 to Stratix 10.
> - Change bool s10_flag to enum version.
> 
> v1 -> v2:
> ---------
> - Add define S10_TLP_FMTTYPE_* macros.
> - Remove initialize structure members to NULL/zero.
> - Rename *_funcs to *_data.
> - Update comment and fix coding style warning from checkpatch.pl.
> - Rename StratixXX to stratix10.
> 
> History:
> --------
> [v1]: https://lkml.org/lkml/2018/12/26/68
> [v2]: https://lkml.org/lkml/2018/12/31/46
> 
> Ley Foon Tan (2):
>   PCI: altera: Add Stratix 10 PCIe support
>   dt-bindings: PCI: altera: Add altr,pcie-root-port-2.0
> 
>  .../devicetree/bindings/pci/altera-pcie.txt        |    4 +-
>  drivers/pci/controller/Kconfig                     |    2 +-
>  drivers/pci/controller/pcie-altera.c               |  246
> ++++++++++++++++++--
>  3 files changed, 226 insertions(+), 26 deletions(-)
> 
Hi,

Any further comment on these patches?

Regards
Ley Foon
