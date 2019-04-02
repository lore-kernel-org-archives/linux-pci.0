Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5631C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 15:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9D320657
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 15:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmUDFGBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfDBPJC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:09:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37493 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfDBPJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 11:09:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so3476493ply.4;
        Tue, 02 Apr 2019 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4dkRspi12M80P/Gbp6NIlu04dGK84PNBtzQKplZbBxI=;
        b=lmUDFGBS9E6Ar+P/5rvuqos+MILsfI7vVr0xLiIC0kHr1zxjqPyci4ZszZaZDPDQlQ
         ztNTIMY+HqH0nr1Yqf0P9N5qhLE4mJSJrmnLPnHrv2hGcGrORtHhJvrNbBllJvsJ2XnK
         VoMr+6yIm4YByzs8KwVYpd4N41PUnXMahtw6zFmnTSg0Cixl39AaALuRo0VhyWj3J6H2
         wllf7egQ/7e/0GuZ+TDoenwCE1MVvox3f3b3rZw9nivSlbWOsLQ6/TPX16nDmaz03OYA
         8YZrkNw084EemIqe7ACY8fZ195cx2bGt9/UPyxgcoeTfw5Q8mMnhngmHny/RW8uISZiD
         St0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4dkRspi12M80P/Gbp6NIlu04dGK84PNBtzQKplZbBxI=;
        b=Ep6sIywFmRwfI1/zSpFLD2nnhMTKaSjPPnUuY8zwqz4rLEqd9FJpT9lK3rDp8rcmMH
         S8IVrRTkNXHUsGv212Fs8lWKLtTFCCMfSTMjQfnwYshL1u8byZHP6/v3aB17mQHUNsNw
         8H3ZvxKwPLrT6vQNL80cUyDxiPbtpGoqlNsh47S1l7PN/tZ3hUf0UktE3JQc/Yg8aOEO
         oIFJWYq42WtlSR8YbosBxWoNvJasAoQ4pGqF2cueuytB6MBixg4zcsR3PStkW1KC91Ag
         JKy3e80e/i4TY6Ws8I1i65xZJWZED6XI7z7q7Hw2YAUcpD/n+gf9QD/isOezXgX2Yv5v
         jPsg==
X-Gm-Message-State: APjAAAWU46E4KUG8n/lxVlj4QOcpOubcd2UNMsaF89RS6q4mrF81HOFn
        etO9YnENJETl9DtSsUsG2n8xcFpNClI=
X-Google-Smtp-Source: APXvYqxyjE/CHKID56yKKjfhnfQd7oBgDUrlRAlmf0cq96iEFvF8Z0YOEOmMvb5dUE6DqFbGEtTKxQ==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr35142583pls.250.1554217740811;
        Tue, 02 Apr 2019 08:09:00 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id m16sm32424999pfi.29.2019.04.02.08.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:09:00 -0700 (PDT)
Date:   Tue, 2 Apr 2019 23:08:54 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190402150852.juugbq7gripqbrmz@mail.google.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
 <20190401230321.GB141706@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401230321.GB141706@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 01, 2019 at 06:03:21PM -0500, Bjorn Helgaas wrote:
> On Sat, Mar 30, 2019 at 12:04:01AM +0800, Changbin Du wrote:
> > Hi Corbet,
> 
> Conventional address would be "Hi Jonathan", just FYI.
>
I know this convention. I said 'Hi Corbet' because I saw the name of email
address. Sorry if this is not the case. :)

> > I also did the conversion for PCI documentation. Please check, Thanks!
> > 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted most of the Linux PCI docs to rst
> > format in this serias.
> > 
> > For you to preview, please visit below url:
> > http://104.238.181.70:8080/kernel-doc/PCI/index.html
> > 
> > Thank you!
> > 
> > Changbin Du (12):
> >   Documentation: add Linux PCI to Sphinx TOC tree
> >   pci doc: convert PCI/pci.txt to rst format
> >   pci doc: convert PCI/PCIEBUS-HOWTO.txt to rst format
> >   pci doc: convert PCI/pci-iov-howto.txt to rst format
> >   pci doc: convert PCI/MSI-HOWTO.txt to rst format
> >   pci doc: convert PCI/acpi-info.txt to rst format
> >   pci doc: convert PCI/pci-error-recovery.txt to rst format
> >   pci doc: convert PCI/pcieaer-howto.txt to rst format
> >   pci doc: convert PCI/endpoint/pci-endpoint.txt to rst format
> >   pci doc: convert PCI/endpoint/pci-endpoint-cfs.txt to rst format
> >   pci doc: convert PCI/endpoint/pci-test-function.txt to rst format
> >   pci doc: convert PCI/endpoint/pci-test-howto.txt to rst format
> 
> Thanks for doing all this work!
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> There's not a real convention yet for subject lines in Documentation/,
> but I would propose:
> 
>   Documentation: PCI: Convert pci.txt to reST
>   Documentation: PCI: Convert endpoint/pci-endpoint.txt to reST
> 
> because that at least goes with some recent Documentation/PCI changes
> and it identifies "reST" as something other than a plain English word
> (RST or ReST would also work for me).
> 
I agree. I am just a little lazy to update all of them this time :)
Thanks for your ACK!

> >  .../PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst}      |  56 +++--
> >  .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  | 112 +++++----
> >  .../PCI/{acpi-info.txt => acpi-info.rst}      |  11 +-
> >  Documentation/PCI/endpoint/index.rst          |  13 ++
> >  ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++++----
> >  .../{pci-endpoint.txt => pci-endpoint.rst}    |  74 +++---
> >  ...est-function.txt => pci-test-function.rst} |  32 +--
> >  ...{pci-test-howto.txt => pci-test-howto.rst} |  51 ++--
> >  Documentation/PCI/index.rst                   |  17 ++
> >  ...or-recovery.txt => pci-error-recovery.rst} | 180 ++++++++-------
> >  .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 144 +++++++-----
> >  Documentation/PCI/{pci.txt => pci.rst}        | 218 +++++++++---------
> >  .../{pcieaer-howto.txt => pcieaer-howto.rst}  |  67 ++++--
> >  Documentation/index.rst                       |   1 +
> >  MAINTAINERS                                   |   2 +-
> >  15 files changed, 641 insertions(+), 436 deletions(-)
> >  rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (89%)
> >  rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (75%)
> >  rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)
> >  create mode 100644 Documentation/PCI/endpoint/index.rst
> >  rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
> >  rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (86%)
> >  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
> >  rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (83%)
> >  create mode 100644 Documentation/PCI/index.rst
> >  rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)
> >  rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (65%)
> >  rename Documentation/PCI/{pci.txt => pci.rst} (80%)
> >  rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (83%)
> > 
> > -- 
> > 2.20.1
> > 

-- 
Cheers,
Changbin Du
