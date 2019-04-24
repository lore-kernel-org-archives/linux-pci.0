Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD8C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 15:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2132084F
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556118233;
	bh=U0chuWLdxheduV1YrZbWEWFde8pTsDKlMF+U4NXHlUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ddwRV8Rshv0xNoV/Npksytm9ba+/YNoMVSOeT+UmKbgIGUwlE3XSW/cwpAsdwCTh5
	 YIJiJ5qixNoEMIAuy59kQ+1Nl2MfQPh2+AxMle0IlpvMy4An3Q0jcuVKBxHgpFD/Xd
	 L5FjLcH8nv9U+MbSn4xo1g/pwDO2tr2puChUaeQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfDXPDx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:03:53 -0400
Received: from casper.infradead.org ([85.118.1.10]:52764 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfDXPDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 11:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jSu9ny5eryGAPEhyPkjGFXlRuxhppqvvRvIzVbMknhY=; b=ifE9egBVhU+e9aqmk3M8nPTP6t
        JWiIL2BOfDdWP2w4WH/oqB9he+nfAYQqmexFE5UxTsFSSSl9effMr48OF5PAKuTdA+abOe/cujoZs
        +2EeNAhGIz60DAvRI3fQft77KdMxpHFrK6laY8HrzNK9Re6CsPVYpsPDqhBzdEip+U+a8hzZ+Bm6r
        eL46kfpx5rG4SmiRyUDzE6hbzI4ABjkrwU18K4lUIF1dt8EcshOD3u/aa6UB07uHI0v9B3LIxSmgD
        U+94wyMYhJ6wP5MORtopKIAglp12BKsCUvXoB/WB8WMizPb/8SlFg/OShp2nyaQcmHgioVLBf2Hlt
        uGll19Yg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJJR7-0001WG-8O; Wed, 24 Apr 2019 15:03:49 +0000
Date:   Wed, 24 Apr 2019 12:03:43 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 25/63] Documentation: add Linux PCI to Sphinx TOC
 tree
Message-ID: <20190424120336.4f66cbb8@coco.lan>
In-Reply-To: <20190423162932.21428-26-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-26-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:54 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> Add a index.rst for PCI subsystem. More docs will be added later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/index.rst | 9 +++++++++

On a past discussion at docs ML, we've agreed to use lowercase for new
stuff. My suggestion here would be to use lowercase for "pci".

Also, there's already a pci directory under driver-api, added on this
commit:

	commit fcc78f9c22474d60c65d522e50ea07006ec1b9fc
	Author: Logan Gunthorpe <logang@deltatee.com>
	Date:   Thu Oct 4 15:27:39 2018 -0600

	    docs-rst: Add a new directory for PCI documentation

I would just add a new section at Documentation/driver-api/pci/index.rst
with something like:

	Legacy PCI documentation
	========================

	.. note::

	   The files here were written a long time ago and need some serious
	   work. Use their contents with caution.

	.. toctree::
	    :maxdepth: 1

	    <files converted from Documentation/PCI>

And add those documents from Documentation/PCI into it.

>  Documentation/index.rst     | 1 +
>  2 files changed, 10 insertions(+)
>  create mode 100644 Documentation/PCI/index.rst
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> new file mode 100644
> index 000000000000..c2f8728d11cf
> --- /dev/null
> +++ b/Documentation/PCI/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Linux PCI Bus Subsystem
> +=======================
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index fdfa85c56a50..d80138284e0f 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -100,6 +100,7 @@ needed).
>     filesystems/index
>     vm/index
>     bpf/index
> +   PCI/index
>     misc-devices/index
>  
>  Architecture-specific documentation



Thanks,
Mauro
