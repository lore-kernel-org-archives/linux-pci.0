Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33516 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab2FLPvS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 11:51:18 -0400
Received: by weyu7 with SMTP id u7so2949691wey.19
        for <linux-pci@vger.kernel.org>; Tue, 12 Jun 2012 08:51:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339472328.67669.YahooMailNeo@web193202.mail.sg3.yahoo.com>
References: <1339472328.67669.YahooMailNeo@web193202.mail.sg3.yahoo.com>
Date: Tue, 12 Jun 2012 08:51:16 -0700
Message-ID: <CAP6odjhx=nfhc=wwWxoV9iqApK0iC_ahQQcLw=NMS+rZcHBv8Q@mail.gmail.com>
Subject: Re: Issue in Documentation/PCI/pci.txt file
From: Grant Grundler <grantgrundler@gmail.com>
To: Mahendra Ladhe <lml108@yahoo.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+linux-pci

On Mon, Jun 11, 2012 at 8:38 PM, Mahendra Ladhe <lml108@yahoo.com> wrote:
> Hello Grant,
>      the Documentation/PCI/pci.txt file in Linux kernel sources has the
> following line at line number 335.
>
> Also see pci_request_selected_regions() below.
>
> But after this line, there is absolutely no mention of
> pci_request_selected_regions API in the remaining document.

hi Mahendra,
Good catch! Thanks for pointing this out.

For now, you can take a look at the comments and examples of use when
this function was introduced:
    http://lkml.indiana.edu/hypermail/linux/kernel/0606.0/1167.html

> Could you please rectify this?

I've not looked at the core PCI code in quite a while and I expect
additional updates are needed. Anyone interested in working on
updating pci.txt?

If not, I can add something about why one should use
pci_request_selected_regions() instead of pci_request_regions().

cheers,
grant
