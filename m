Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2BCC433E6
	for <linux-pci@archiver.kernel.org>; Thu, 25 Feb 2021 18:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F6F64F4D
	for <linux-pci@archiver.kernel.org>; Thu, 25 Feb 2021 18:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBYSvp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:51:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232982AbhBYSvn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 13:51:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36ED564F29;
        Thu, 25 Feb 2021 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614279062;
        bh=MmXrhKpXug2McN3faWeNdMvPLMny3JE46p+2y9M4jYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tytnpNQr52fVeD5UQJXFycNDm0X6Ocao34AL65DEC6a+iG2/MZ+Qj565eQzTXlX/3
         zCeEaZ4JSeqnHyAZXnSefl2gdKz+jS8OM8zCAwXyZ1SmrOPQ4A9/Lcjamo3968lK2Y
         IcfGhu3NLdcWT7STywQ+jIhyL0p8cxkEEovqh+vyXaK1ZOG48MvsHmb4E0zQ5ktHdT
         5YR2/Rd5lN+vAdrXzNqyFZ36/bko9g8aBLWtcMufNPHIZn6p05xxSFuZg+T5tbb8wY
         yaWK/2o0zYB/3gZ+jh0iV9qTXvTccifOAUMj9h6sdr+YEKCJ7NTKA9CG/9K/w1G2qc
         wBMT85rLFuasQ==
Date:   Thu, 25 Feb 2021 12:51:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Robert Richter <rric@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: controller: thunder: fix compile testing
Message-ID: <20210225185100.GA17711@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0dd513-dc7d-d7ca-c0b6-4bc9db355a53@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 25, 2021 at 09:44:12AM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 2/25/21 6:37 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Compile-testing these drivers is currently broken. Enabling
> > it causes a couple of build failures though:
> > 
> > drivers/pci/controller/pci-thunder-ecam.c:119:30: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> > drivers/pci/controller/pci-thunder-pem.c:54:2: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
> > drivers/pci/controller/pci-thunder-pem.c:392:8: error: implicit declaration of function 'acpi_get_rc_resources' [-Werror,-Wimplicit-function-declaration]
> > 
> > Fix them with the obvious one-line changes.
> Looks good to me.

Thanks for looking this over!  I'd like to acknowledge your review,
but I need an explicit Reviewed-by or similar.  I don't want to put
words in your mouth by converting "Looks good to me" to "Reviewed-by".
