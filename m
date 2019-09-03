Return-Path: <SRS0=pntK=W6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A0C3A5A7
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 07:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96B32168B
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567496597;
	bh=VtrJTlz/934AIhYmM6InHRxgMo7S9QIWe6BX+HcGZbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vpZGVNzBn2DyJ+j3em8411AYTqaBygtj57zhj/e63C8OEBZIg/F4ZfxS8Cd0MPiVS
	 ul8hxrztN5/nSXhZiOx02cc8eM3Cy0q2ureO5LfLBr4TW+4X6YaSfpunP1OxW3PwVI
	 +tj7jxgWuGIH4ct84P0WJzm0xjA3DsMIPhrN50xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfICHnQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:43:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38794 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfICHnP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 03:43:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id 7so3865308oip.5;
        Tue, 03 Sep 2019 00:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtrJTlz/934AIhYmM6InHRxgMo7S9QIWe6BX+HcGZbw=;
        b=mOf7E/Gtv0PQauwWsgsc3CGIUORrbSaTXj4DrXHjWFsbyKREJMBydxcDqosNPeHO/k
         qAznXsb7W91+0Nw8GH9stD+GNrlF7zwsSLCUoPTGp1XPcOhX/u5sRnFhEWaYt/wCozxj
         C8AG+idRqY7TlHY5AGdW6etUcUWMyUcCeKjW8clgxV6I3vIh8SDIfEygbXF2DrB7fpyk
         qpeW5WYZhc/hYWZ2R0nIhHNMCdA54jGOmayycu5jP8y8o12wpyCygdHPAk4e7jJrVcxG
         PHDNXNaSWIf0EEe5Tjl8xP8wuN2l9CWnPe7pZwa/ZfmLyJUN0+u26TVz5yKbD1mwZFat
         yh0Q==
X-Gm-Message-State: APjAAAUL9+Zfdg7/Iw3jYrH7T+wGH5eE2NPUDN34IF1c3hbds0cQfEjc
        ++TICr/r3rlrNwlQfjafLsvmtoZEVwBDjvEehpQ=
X-Google-Smtp-Source: APXvYqzuZuXy/yJKJbRDe7WOvpYY7XAyKsxtk48XfvsIfssNrVG9az3Pj5KT0bba1x8OBSt4v5dTxKKvB0u1+5ICdeM=
X-Received: by 2002:aca:50ca:: with SMTP id e193mr10273740oib.110.1567496594789;
 Tue, 03 Sep 2019 00:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <1566359059-4844-1-git-send-email-wenwen@cs.uga.edu>
 <CAJZ5v0gm3Mv0-6fVe+7v4Kd49xG6W=TXcxfTJthpe9o46n4EEQ@mail.gmail.com> <20190902223424.GJ7013@google.com>
In-Reply-To: <20190902223424.GJ7013@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Sep 2019 09:43:03 +0200
Message-ID: <CAJZ5v0iG_h1k9mAfsZ5QdTA++AgfR=h5d0nH0ACVNn_AunaSwA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / PCI: fix acpi_pci_irq_enable() memory leak
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 3, 2019 at 12:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Sep 02, 2019 at 11:19:58PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Aug 21, 2019 at 5:44 AM Wenwen Wang <wenwen@cs.uga.edu> wrote:
> > >
> > > In acpi_pci_irq_enable(), 'entry' is allocated by kzalloc() in
> > > acpi_pci_irq_check_entry() (invoked from acpi_pci_irq_lookup()). However,
> > > it is not deallocated if acpi_pci_irq_valid() returns false, leading to a
> > > memory leak. To fix this issue, free 'entry' before returning 0.
> > >
> > > Fixes: e237a5518425 ("x86/ACPI/PCI: Recognize that Interrupt Line 255 means
> > > "not connected"")
> > >
> > > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> >
> > Bjorn, any more comments?
>
> Nope, looks fine to me.

Thanks, queuing it up for v5.4 then.
