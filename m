Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46658C43381
	for <linux-pci@archiver.kernel.org>; Wed, 10 Feb 2021 07:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015B964E42
	for <linux-pci@archiver.kernel.org>; Wed, 10 Feb 2021 07:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhBJHmE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:42:04 -0500
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:57246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231520AbhBJHmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 02:42:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 81F6718010A5F;
        Wed, 10 Feb 2021 07:41:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trip57_0a1601f2760e
X-Filterd-Recvd-Size: 2373
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Feb 2021 07:41:10 +0000 (UTC)
Message-ID: <715cfa18165f472420496de96a0a08837de2902d.camel@perches.com>
Subject: Re: [PATCH] Documentation: Replace lkml.org links with lore
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        bhelgaas@google.com, robh+dt@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 09 Feb 2021 23:41:09 -0800
In-Reply-To: <202102092327.F6D8335A7@keescook>
References: <20200627103050.71712-1-grandmaster@al2klimov.de>
         <20200630180917.GA3455699@bjorn-Precision-5520>
         <20200630140417.3a2dba67@lwn.net>
         <77cdb7f32cfb087955bfc3600b86c40bed5d4104.camel@perches.com>
         <202102092327.F6D8335A7@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-02-09 at 23:28 -0800, Kees Cook wrote:
> On Sun, Jan 10, 2021 at 12:41:44PM -0800, Joe Perches wrote:
> > Replace the lkml.org links with lore to better use a single source
> > that's more likely to stay available long-term.
> 
> What's the best way to teach checkpatch about this? I couldn't find the
> right place to do it. (And more generally, can it also suggest https
> over http?)

Bjorn's patch:
https://lore.kernel.org/lkml/20201217235615.43328-1-helgaas@kernel.org/

And my comments:
https://lore.kernel.org/lkml/3e21b6e87e219d6538a193a9021b965fd8180025.camel@perches.com/

