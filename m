Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33419 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753556AbdGXPH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2017 11:07:28 -0400
Received: by mail-pg0-f46.google.com with SMTP id g14so9501745pgu.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2017 08:07:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724085635.6f0d7100@w520.home>
References: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
 <CAKSfGUD8ukDwujWVN9He6EeH3MFJj3Ez6NRkiP03P5p8dTCz2g@mail.gmail.com> <20170724085635.6f0d7100@w520.home>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Mon, 24 Jul 2017 18:07:27 +0300
Message-ID: <CAKSfGUAaZ3cSOfn4bVn27rSyM2wQfb1O8_NktORvtrjoOnFt0w@mail.gmail.com>
Subject: Re: [PATCH] pci: shpchp: set the bridge busmaster if MSI are enabled
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2017-07-24 17:56 GMT+03:00 Alex Williamson <alex.williamson@redhat.com>:
>
> On Sun, 23 Jul 2017 23:18:01 +0300
> Alexander Bezzubikov <zuban32s@gmail.com> wrote:
>
> > Just a friendly reminder - I wanted to check if you want something
> > else to get this patch merged.
> > [Somehow the first reminder attempt was rejected as a virus by
> > linux-pci mail server,
> >  so my apologize for possible duplication]
>
>
> Please note:
>
> http://www.spinics.net/lists/linux-pci/msg62941.html
>

Missed it, sorry.

>
> As potentially a long standing issue, I would expect this to be
> reviewed and evaluated for the v4.14 cycle.  Thanks,
>
> Alex


Ok, nothing urgent.
Thanks

-- 
Alexander Bezzubikov
