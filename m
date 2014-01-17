Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64126 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbaAQQOH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2014 11:14:07 -0500
Received: by mail-ie0-f171.google.com with SMTP id to1so5742406ieb.30
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2014 08:14:07 -0800 (PST)
Date: Fri, 17 Jan 2014 09:14:04 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: eiichiro.oiwa.nm@hitachi.com
Cc: Sander Eikelenboom <linux@eikelenboom.it>,
	Dave Airlie <airlied@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	David Airlie <airlied@linux.ie>
Subject: Re: Re[2]: In "pci_fixup_video" check if this is or should be
 theprimaryvideo d
Message-ID: <20140117161404.GA13220@google.com>
References: <XNM1$9$0$4$$3$3$7$A$9006870U52d8928d@hitachi.com>
 <CAErSpo678TwmMu7tB5u2uWogLCvQPyoZeXz3Do52XUTSGjYAwg@mail.gmail.c>
 <XNM1$9$0$4$$3$3$7$A$9006873U52d90952@hitachi.com>
 <CAErSpo5oi1cMyXiLAOd5j5Gi0GwKZ7-LD-TkD6r8HM5TBEq3Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAErSpo5oi1cMyXiLAOd5j5Gi0GwKZ7-LD-TkD6r8HM5TBEq3Dg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

By the way, your emails are not being forwarded to the mailing lists,
probably because they contain MIME or something else considered "fancy" by
the mailing list manager.  So people reading this conversation via the list
never see your emails.

There are some hints here:
  http://vger.kernel.org/majordomo-info.html
  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n228
  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/email-clients.txt
