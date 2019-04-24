Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56690C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216D421900
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125481;
	bh=oWctvPUg5co4TD+kNQjoNrwx7yXnylYFc66/H/Vt2DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KdBWKAsn8N30RRVcSflf0k32SczP/+I/P3d6EcvJVP2KMjkQAjFw3ucnek6TARnhy
	 udhO9Io3Lft7I/2KcSLtAbOBBaqoYRtvgoq1Zg3IQrbQ0v5SZLNouO6R0J5LQ6kSMx
	 N38kUE0vwFB1h8nJs4xCV7hRX/oR3UiwXwpt8qL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbfDXREf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:04:35 -0400
Received: from casper.infradead.org ([85.118.1.10]:37504 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731146AbfDXREf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 13:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DCGeBvTyVQ8SMBoHvyttGac1kiVwGgaKGx64/cYbuDE=; b=MbCZxQukmg5r9iu99o5wQPndZ6
        /t8x9bkkfig6RtvUHiSTrQXjWGQxIHCK5fjmKxTlkICyMHJBTQQdEsuLfEuMdByY9DfNFvP/67jd5
        M9WSRQtIoGsnfbfS1+xAq2Qbm/1VmX2ZwshDmlMjSacekQp4OTny8w8Ot37uudoSgJTmZQDiK6+LG
        RHInVFxGa1V4zDbnenAYwzEZN9dRJw++CnrIhWyoj6hkJEQRMQVqkAFtaf56LoJIQco/EXMYIa02n
        /EAKvxnnlTumATOIOAKpAVpqH02tBqdW7rYe8+226PqQwQKk5PODZiuOixFPuyay06HhBw02f7JJW
        +n5kY6FQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJLJu-0006Bt-Im; Wed, 24 Apr 2019 17:04:31 +0000
Date:   Wed, 24 Apr 2019 14:04:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 37/63] Documentation: add Linux x86 docs to Sphinx
 TOC tree
Message-ID: <20190424140424.72d5ae56@coco.lan>
In-Reply-To: <20190423162932.21428-38-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-38-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:29:06 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> Add a index.rst for x86 support. More docs will be added later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/index.rst     | 1 +
>  Documentation/x86/index.rst | 9 +++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 Documentation/x86/index.rst
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index d80138284e0f..f185c8040fa9 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -112,6 +112,7 @@ implementation.
>  .. toctree::
>     :maxdepth: 2
>  
> +   x86/index
>     sh/index
>  
>  Filesystem Documentation
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> new file mode 100644
> index 000000000000..7612d3142b2a
> --- /dev/null
> +++ b/Documentation/x86/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Linux x86 Support
> +=================
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:

Looks ok to me:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Just one reminder: after merging both this and my conversions, we may
need to do some review at the architecture titles, in order to
make them consistent. 

On mu conversion patches, I'm using

	==================
	$arch Architecture
	==================

Probably also not the best title. Anyway, this can easily be fixed
with a follow up patch once we get everything merged.

Thanks,
Mauro
