Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:49298 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbaEaBZw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 21:25:52 -0400
Received: by mail-ie0-f182.google.com with SMTP id x19so2529406ier.13
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2014 18:25:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140530231421.GH4607@google.com>
References: <1398966055-19325-1-git-send-email-yinghai@kernel.org>
	<20140520205340.GA22821@google.com>
	<CAE9FiQWCsKwb3aqUQ96x__xwR_+K=k5LzjxWCCS1+xz2Wd5baA@mail.gmail.com>
	<20140530231421.GH4607@google.com>
Date: Fri, 30 May 2014 18:25:51 -0700
Message-ID: <CAE9FiQVW7U-wLKPhjYEO8fK=t8dQZ9vz9T0yeBGzPXP5-JJ+Jw@mail.gmail.com>
Subject: Re: [PATCH v4] pciehp: only wait command complete for real hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 30, 2014 at 4:14 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I think your current patch is incorrect because you wait if the previous
> command has completed, and you write a new command if the previous one is
> still in progress.  That's backwards.
>

Agreed.
