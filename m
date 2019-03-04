Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83324C43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5150C20823
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 20:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLoCgsAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCDU3h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:29:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38377 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDU3g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Mar 2019 15:29:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id a188so438663wmf.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2019 12:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ml2tdFA+5PlAJQBN6XbzQLx/7woCXwX7t6b6wUqam8o=;
        b=sLoCgsARwe8UHmk7A0Yg69rz227Drq9/UsbCHKeeJbwlSibGInLFET2GkHejSd6AVj
         LdW6RWKkUFODnjWMyk5aOS1fjdF274+/7H+FFDU/v91WispFNJO3Gg74i9oArAz0IwB+
         2QPUqlRAzysjyO1Zr3DytCMUGiLkemShez9JESNoyd18j2cxfISi1ZONdB7ltcsUi0Yp
         HVOtKNXTgKcdWwibCvdOPqcMFPkLpiDdkT5XUvKRwUMZEgaJQNwPZtcbDa9f7PbS5CUS
         Jj5BDmTYUw4VoMGcSwCJsmG3xoevKY/b14Mz6A6DI2XZFfQjrIk1IyjnBEmVvC1APPBs
         Mk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ml2tdFA+5PlAJQBN6XbzQLx/7woCXwX7t6b6wUqam8o=;
        b=XkO5icH6Ik3Zmys+d2YK+GVa+/KKD9/GZ6RSHu+uuwRTbN+b8SRJzZ75CgmWz+vmn9
         RB5Jo3/BNswE+8yXmaLBTj5iDxvsk2wfn/TrlRQpAbEQ9oPYJDm+bdkBCI7X4Dx7VssB
         XtLwE3gfx3SXZ97JyE4vJW0USZQAri0Fn8J+RkSX3EiS0LlTsR4kvVJqChWHkJ2Dcp6k
         6ER7GsUh55H45pHt1uTaDArMUGJ73vIB5HGHP1EqNmUsH4esilvAT26HiOlWCTtC+CkY
         cFelEcdMgHEI3pk0nIdPI0crBId0ZL8/n29b7g2AmwxyDqFhpbHAjM24XAHZjyJi4b6Y
         kvwA==
X-Gm-Message-State: APjAAAW4KEGWxR2cMiitGf3ROpOS/AJQRt5vLk5kgmEh4bHkPZJUrho3
        GusYY/gKsrNB/3mFQarftGQdY/rLWgp3WGxQdXbg
X-Google-Smtp-Source: APXvYqxgO/jYYpeuzkpREkIfXLetZXue0MaaWz0cvXBcEHZV7bOZO+trWaAWV4WFnhfzZbaKjyhig/yX9n8odFvgcwo=
X-Received: by 2002:a1c:6409:: with SMTP id y9mr583649wmb.68.1551731374113;
 Mon, 04 Mar 2019 12:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20190214170028.27862-1-logang@deltatee.com> <20190304002351.GA26569@google.com>
 <3e45b4ab-e848-cf3b-624f-121ad58b0250@deltatee.com> <CAErSpo4U6Kys5OzPwfyFdbnJWfTZ-y0P830okf11BwfNv9Y82A@mail.gmail.com>
 <ac64ba0e-e86a-f7ae-775b-753f933f178f@deltatee.com>
In-Reply-To: <ac64ba0e-e86a-f7ae-775b-753f933f178f@deltatee.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 4 Mar 2019 14:29:22 -0600
Message-ID: <CAErSpo5icDM2VgYoLdEp8C-CV5XEMThABMA8RBq64grhRSkRWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Prevent 64-bit resources from being counted in
 32-bit bridge region
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 4, 2019 at 2:21 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> On 2019-03-04 1:11 p.m., Bjorn Helgaas wrote:
> > On Mon, Mar 4, 2019 at 1:21 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >> On 2019-03-03 5:23 p.m., Bjorn Helgaas wrote:
> >>> Sorry for the delay.  This code gives a headache.  I still remember
> >>> my headache from the last time we touched it.  Help me understand
> >>> what's going on here.
> >>
> >> Yes, this code gave me a headache debugging it too. And it's not the
> >> first time I've tried to figure out what's going on with it because it
> >> often just prints noisy messages that look like errors. I think I
> >> understand it better now but it's something that's a bit fleeting and
> >> easy to forget the details of. There may also be other solutions to this
> >> problem.
> >
> > Thanks for the explanation below.  I haven't worked through it yet, but I will.
> >
> > Obviously it would be far better than an explanation if we could
> > simplify the code (and the noisy messages) such that it didn't
> > *require* so much explanation.
>
> I agree, but reworking this code scares me and I suspect it was designed
> this way for a reason. I'm guessing there are a lot of corner cases and
> unusual bios issues this stuff works around. We might end up fixing a
> some cases and breaking a bunch of other cases.

Scares me too, which is one reason I haven't done anything about it.

I didn't mean to suggest that you should rework it for *this* issue.
I just keep hoping that we can chip away at teensy pieces and in ten
or twenty years maybe make some headway.

Bjorn
