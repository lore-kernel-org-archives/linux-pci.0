Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:63339 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbaIRX1A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Sep 2014 19:27:00 -0400
Received: by mail-lb0-f170.google.com with SMTP id n15so237820lbi.15
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2014 16:26:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5K-whTs7uzki3JHzmbrDzaG6u7BerYG42is_sfuEOGXA@mail.gmail.com>
References: <20140514224339.7f8be3a9@neptune.home>
	<CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
	<20140810112654.1bf684d6@neptune.home>
	<CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
	<20140810183411.19370721@neptune.home>
	<CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
	<20140816192135.34260115@neptune.home>
	<CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
	<20140820075508.74f5b622@pluto>
	<20140820091152.76cd4e1a@pluto>
	<CAMxnaaUodONkqmdPWedN-Q1qheHiJAScFcG_XbX1--ZmiOQZDg@mail.gmail.com>
	<20140821233435.19a9cffa@neptune.home>
	<CAErSpo6D1B+dPLrYoAF4OA1KeWuW8VZW2_RR5jB1GbCRo+6vHg@mail.gmail.com>
	<20140822082324.12cb6e93@pluto>
	<CAMxnaaU9EiMcne-aQjS1sY1Orn6xGbVHEnd057ogcZ77p74Y=Q@mail.gmail.com>
	<20140823130624.06ecc057@neptune.home>
	<20140824230953.7c04890f@neptune.home>
	<CAMxnaaUoLBbN1gNgD3qvPV1mx3JoM6FPV9EndQG9vJSpux2xMw@mail.gmail.com>
	<20140828224750.23148125@neptune.home>
	<20140912131919.35c777e5@pluto>
	<CAErSpo5K-whTs7uzki3JHzmbrDzaG6u7BerYG42is_sfuEOGXA@mail.gmail.com>
Date: Fri, 19 Sep 2014 09:26:58 +1000
Message-ID: <CAPM=9twe7Ro9gthPbzw77CG3wCvbA2FdsBD2kPeAbhGti_w5bA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] vgaarb: Don't default exclusively to first video
 device with mem+io
From: Dave Airlie <airlied@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13 September 2014 00:28, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Sep 12, 2014 at 5:19 AM, Bruno Prémont
> <bonbons@linux-vserver.org> wrote:
>> Bjorn,
>>
>> What is missing to get these two patches pushed to Linus?
>
> Sorry, I've been working on some other regressions and overlooked this
> one.  If you open a bugzilla report and mark it as a regression, that
> will help keep this on my radar.

My MBP is crying? can we get these merged, I can handle if if you want
to ack them for me!

Dave.
