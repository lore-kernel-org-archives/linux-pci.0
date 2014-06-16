Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:41204 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaFPB0U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jun 2014 21:26:20 -0400
Received: by mail-pb0-f45.google.com with SMTP id rr13so1330452pbb.32
        for <linux-pci@vger.kernel.org>; Sun, 15 Jun 2014 18:26:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <CAE9FiQUbw7OUhRB+gKMxkuE9+nm9097+mwZ2z4adO8Hv_NjF1Q@mail.gmail.com>
	<20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Sun, 15 Jun 2014 18:26:20 -0700
Message-ID: <CAA93t1pmvUJ+VwxSTF4y3o1kSTOfpeXrZxU7m02wu5MaHB38dQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] PCI: pciehp: Fix Command Completion handling
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

>
> I haven't heard anything for a while, so I wrote up these patches to
> make my proposals concrete.  Unfortunately, I can't easily test any of
> this, so I'm posting these for comment and possible testing if anybody
> is ambitious.
>

I'll test them out on my machines tomorrow.

Thanks,

Rajat
