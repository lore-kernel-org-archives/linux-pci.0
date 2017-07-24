Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932289AbdGXO4j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jul 2017 10:56:39 -0400
Date: Mon, 24 Jul 2017 08:56:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexander Bezzubikov <zuban32s@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: shpchp: set the bridge busmaster if MSI are
 enabled
Message-ID: <20170724085635.6f0d7100@w520.home>
In-Reply-To: <CAKSfGUD8ukDwujWVN9He6EeH3MFJj3Ez6NRkiP03P5p8dTCz2g@mail.gmail.com>
References: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
        <CAKSfGUD8ukDwujWVN9He6EeH3MFJj3Ez6NRkiP03P5p8dTCz2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 23 Jul 2017 23:18:01 +0300
Alexander Bezzubikov <zuban32s@gmail.com> wrote:

> Just a friendly reminder - I wanted to check if you want something
> else to get this patch merged.
> [Somehow the first reminder attempt was rejected as a virus by
> linux-pci mail server,
>  so my apologize for possible duplication]


Please note:

http://www.spinics.net/lists/linux-pci/msg62941.html

As potentially a long standing issue, I would expect this to be
reviewed and evaluated for the v4.14 cycle.  Thanks,

Alex
