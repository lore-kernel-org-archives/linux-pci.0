Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329B7C43219
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2C206C1
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 15:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIxieLUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfDYPmU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:42:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45377 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfDYPmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2019 11:42:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so25928pgk.12;
        Thu, 25 Apr 2019 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fdGRNyUQlpc4HjiFlwZawue24kiF5g7GyMltLZfo7cE=;
        b=YIxieLUPcMA5EY/ryz/w3MSDrHtVKhB0buP5Ib9v2TtDcrgrLatRkRvmwcaFgImjog
         rxhPiSaeNOz5dkfMh7ZHxpqoA4NqsqKw89f3Z+JMEyoau91GLZmMdnvke0dUQAZcO7J+
         O0lfbBVh/k3/SnSW3V8u8M2e5//l8DeJXd2AKiB7uaMwWIXoQ5gOvC5If6VwBDVWffzL
         V+flPXi9xp3Dj5DOxTJjJDjnHOChw+HGMGDQebfCEq5LNIgNeMAKxqLq+Taa/fdxXpve
         H/LlHOz/jS+mZ1iN7+bGG1Jfb1a1EwwCRpNnJlHmjTnmhbfUozKFuMCCbJ5YXwtJ5ksW
         0rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fdGRNyUQlpc4HjiFlwZawue24kiF5g7GyMltLZfo7cE=;
        b=RgEvKRCiBFptdy5dV7DSyg7CoxXJb2uM1BCtHiKW01xDLhhUJY4s4IObSGKwPOYkSi
         S7d6A1O3Z4laHAuOJrM4XCB/3nd4ou2PxVjR0JvlWloxnSL12p5hj9XPH+sHnO2LB/P/
         hdkeIEVYt8ZnNZ3pu2Y/Ufbs6+BJOsH5u3IWLvGdnrKAXZAfoYUprIRJOS+YTDgqOc0I
         C2ZpHbUkqGEylQqTF1E5O7gFOQ5Gadc0OAR9bzNWsRKpYqONJrG3gwnFBSXCa+ODYftY
         OSwPobQJIzjv7F+PQHFaZeo6WFkLl6TB2nEpjVKttEi9bXf2Sz2qsL3zWPCcuywBdebO
         aKHg==
X-Gm-Message-State: APjAAAXl4vWXR8WarLq9UaC5IOFcWNy1rAgZlPDeguNpn7A3lIPD8K0v
        kV/SwSUmqpVG9Y3scGGFUys=
X-Google-Smtp-Source: APXvYqyeeWmVX0kg2+bRmqQrJjqbejE5dDoGnKIs4kkB8kuPCsHm+s3GgBBlCTp7tZUOrfb0T+9NTg==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr40431342pff.35.1556206938879;
        Thu, 25 Apr 2019 08:42:18 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id z22sm23504071pgv.23.2019.04.25.08.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 08:42:17 -0700 (PDT)
Date:   Thu, 25 Apr 2019 23:42:08 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 25/63] Documentation: add Linux PCI to Sphinx TOC tree
Message-ID: <20190425154207.admsorr4ztmqxqv2@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-26-changbin.du@gmail.com>
 <20190424120336.4f66cbb8@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424120336.4f66cbb8@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 12:03:43PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:54 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > Add a index.rst for PCI subsystem. More docs will be added later.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  Documentation/PCI/index.rst | 9 +++++++++
> 
> On a past discussion at docs ML, we've agreed to use lowercase for new
> stuff. My suggestion here would be to use lowercase for "pci".
> 
> Also, there's already a pci directory under driver-api, added on this
> commit:
> 
> 	commit fcc78f9c22474d60c65d522e50ea07006ec1b9fc
> 	Author: Logan Gunthorpe <logang@deltatee.com>
> 	Date:   Thu Oct 4 15:27:39 2018 -0600
> 
> 	    docs-rst: Add a new directory for PCI documentation
> 
> I would just add a new section at Documentation/driver-api/pci/index.rst
> with something like:
> 
> 	Legacy PCI documentation
> 	========================
> 
> 	.. note::
> 
> 	   The files here were written a long time ago and need some serious
> 	   work. Use their contents with caution.
> 
> 	.. toctree::
> 	    :maxdepth: 1
> 
> 	    <files converted from Documentation/PCI>
> 
> And add those documents from Documentation/PCI into it.
>
Bjorn, Jonathan,
Do you agree with this? By this all Documentation/PCI/* will be moved to
Documentation/driver-api/pci.

> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
