Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:55813 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbaISFST (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Sep 2014 01:18:19 -0400
Received: by mail-ie0-f180.google.com with SMTP id rd18so2697908iec.25
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2014 22:18:18 -0700 (PDT)
Date: Thu, 18 Sep 2014 23:18:15 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2 v2] vgaarb: Don't default exclusively to first video
 device with mem+io
Message-ID: <20140919051815.GB21128@google.com>
References: <CAErSpo6D1B+dPLrYoAF4OA1KeWuW8VZW2_RR5jB1GbCRo+6vHg@mail.gmail.com>
 <20140822082324.12cb6e93@pluto>
 <CAMxnaaU9EiMcne-aQjS1sY1Orn6xGbVHEnd057ogcZ77p74Y=Q@mail.gmail.com>
 <20140823130624.06ecc057@neptune.home>
 <20140824230953.7c04890f@neptune.home>
 <CAMxnaaUoLBbN1gNgD3qvPV1mx3JoM6FPV9EndQG9vJSpux2xMw@mail.gmail.com>
 <20140828224750.23148125@neptune.home>
 <20140912131919.35c777e5@pluto>
 <CAErSpo5K-whTs7uzki3JHzmbrDzaG6u7BerYG42is_sfuEOGXA@mail.gmail.com>
 <CAPM=9twe7Ro9gthPbzw77CG3wCvbA2FdsBD2kPeAbhGti_w5bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAPM=9twe7Ro9gthPbzw77CG3wCvbA2FdsBD2kPeAbhGti_w5bA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 19, 2014 at 09:26:58AM +1000, Dave Airlie wrote:
> On 13 September 2014 00:28, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Fri, Sep 12, 2014 at 5:19 AM, Bruno Prémont
> > <bonbons@linux-vserver.org> wrote:
> >> Bjorn,
> >>
> >> What is missing to get these two patches pushed to Linus?
> >
> > Sorry, I've been working on some other regressions and overlooked this
> > one.  If you open a bugzilla report and mark it as a regression, that
> > will help keep this on my radar.
> 
> My MBP is crying? can we get these merged, I can handle if if you want
> to ack them for me!

Yep, it's in linux-next and I'll send Linus a pull request for the tag [1]
tomorrow.  I meant to send it tonight, but I had to fix my for-linus branch
to remove a duplicate commit and I don't want to send the pull request
immediately afterwards.

Bjorn

[1] https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tag/?h=for-linus&id=pci-v3.17-fixes-2
