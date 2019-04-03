Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A757C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AFD2054F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oy1474TU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfDCPj0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:39:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41098 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCPj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 11:39:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so8345833pfd.8;
        Wed, 03 Apr 2019 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4K7W0j8rTa+YRaaAstvUDc1uzqxpUCqMhMXLcqU75Hc=;
        b=oy1474TUswjxugfN0Bu6CcbkHenxjvmFB5/KVpITrqwm3QTufVyDd8JTu8xFYegoWr
         QeQGs/f8FknYLjzs2NQtUvZB1BkOrP0Lfu8GmYsii9D77HRx+PmeqmHG0FO2GyjaU2Tu
         b6oog/NOgd8OI5PmYzPi0rEeMx+muDrHJIrx8buHEH79aZlRG8CvqlLncAtbw57UtAqm
         1TKRhutqzb2GAVXggizw3AhvuXW4QRccQ8vMlcb7EfLBzgTQ3AMEWXTWUGMnBb7geBtX
         /YXhebJCdjVcGVShGKW6F+4C7kEePemnsxzLXzWw1BXIWUdVV8/YgMV6fbH1b7i7Rv9P
         qMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4K7W0j8rTa+YRaaAstvUDc1uzqxpUCqMhMXLcqU75Hc=;
        b=a76AM+7S5jbVbOQ/bw7WvhmShU2wbi9yOEAMDNzi0j4Wb8uR0RxiCkW4UWFZcQ3WRu
         RuacvKCpzWlZHK//TNIRjRn4YwXXiNbt8dSvc9xqS9jscaC3aLz9ssLXXuH29okJbe3X
         uLplB1Mef7VZEiCvf3dKLGPV7BZ2tNjiJ6P4WmI4M1I30nxDPa7RiluAHesSDTfcJhxs
         0UqtT/pJgM3X8Uz8YXVQmSftLfGri8Q6qVJIvoaa8Q9d2bCj/gxocNehqU1gWAoUZXwc
         PGw+Nf4SmMD9H7fSaoXAvWqz9QDcMD+aAYySL+3bsf8DpjuU7gtx5ap/QDN3hMQ/qiO2
         0EEA==
X-Gm-Message-State: APjAAAXZa6HgbWGuzMp7jAOPADwvBh/8dKbSREGkNmmDgJZKPLEYq7hG
        oaj2eGHgbJAQeIjWL0y32xc=
X-Google-Smtp-Source: APXvYqwPPcI2Q5taQ8Fbp4n8GiG8PnfWB+RprnDtY62cdNO1PArVojWfZfVbhTyAl4GDvwZKRwtz8w==
X-Received: by 2002:aa7:80c8:: with SMTP id a8mr15488pfn.193.1554305965352;
        Wed, 03 Apr 2019 08:39:25 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id z21sm23213491pfn.139.2019.04.03.08.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:39:24 -0700 (PDT)
Date:   Wed, 3 Apr 2019 23:39:19 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190403153917.4r73hhzjp6anuyhj@mail.google.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
 <20190401230321.GB141706@google.com>
 <20190402150852.juugbq7gripqbrmz@mail.google.com>
 <20190402180744.GD141706@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402180744.GD141706@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 01:07:44PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 02, 2019 at 11:08:54PM +0800, Changbin Du wrote:
> > On Mon, Apr 01, 2019 at 06:03:21PM -0500, Bjorn Helgaas wrote:
> > > On Sat, Mar 30, 2019 at 12:04:01AM +0800, Changbin Du wrote:
> > > > Changbin Du (12):
> > > >   Documentation: add Linux PCI to Sphinx TOC tree
> > > >   pci doc: convert PCI/pci.txt to rst format
> > > >   pci doc: convert PCI/PCIEBUS-HOWTO.txt to rst format
> > > >   pci doc: convert PCI/pci-iov-howto.txt to rst format
> > > >   pci doc: convert PCI/MSI-HOWTO.txt to rst format
> > > >   pci doc: convert PCI/acpi-info.txt to rst format
> > > >   pci doc: convert PCI/pci-error-recovery.txt to rst format
> > > >   pci doc: convert PCI/pcieaer-howto.txt to rst format
> > > >   pci doc: convert PCI/endpoint/pci-endpoint.txt to rst format
> > > >   pci doc: convert PCI/endpoint/pci-endpoint-cfs.txt to rst format
> > > >   pci doc: convert PCI/endpoint/pci-test-function.txt to rst format
> > > >   pci doc: convert PCI/endpoint/pci-test-howto.txt to rst format
> > > 
> > > Thanks for doing all this work!
> > > 
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > There's not a real convention yet for subject lines in Documentation/,
> > > but I would propose:
> > > 
> > >   Documentation: PCI: Convert pci.txt to reST
> > >   Documentation: PCI: Convert endpoint/pci-endpoint.txt to reST
> > > 
> > > because that at least goes with some recent Documentation/PCI changes
> > > and it identifies "reST" as something other than a plain English word
> > > (RST or ReST would also work for me).
> > > 
> > I agree. I am just a little lazy to update all of them this time :)
> > Thanks for your ACK!
> 
> Well, I guess I'm too lazy to fix them all for you, so I personally
> wouldn't apply these.  But maybe Jonathan will be more accommodating.
>
ok, I will fix this serias since they do matter.

> Bjorn

-- 
Cheers,
Changbin Du
