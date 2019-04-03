Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97248C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 17:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B61206DF
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 17:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCR12 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:27:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40018 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDCR12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 13:27:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so20519554qts.7
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2019 10:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=wJ3eRVwwNTD1aB1PgrPxgoJVqOyTqVWt3zOiEecpA4s=;
        b=fXSqNJXxCJFKHuznX6pYGRB6gAajysQ9ubncaleDrASZWpxVhIJ2xzt+R3TSPHA1yC
         e53brz+7g1+q+ju0WLna9hA1pamKV90PkOAFpmhKnXXAdiIZNIeTX5ydr3IXYmoAstfB
         PDfycqmADB/FKjoqhxshXxX9gsbDsjCfUI5MtdHeu+67VZfNVb7p2E0kFdt4k6zGzPyg
         rIbMPQAvK7SNSr+Rws4xzkbjuLoM1kwjv2hUsty61H9cam7dYRcTyiq0gsn4cQt/CE5c
         PbQ3Bij/6J2oJRLab63zK/xEiNMgdsFsmOG8/qyMASkzzV8+zqElMCGlrl4NQki9f5i7
         EU1g==
X-Gm-Message-State: APjAAAUSn2UGqLe8Sb7+gLKdHl8im7525OngNH1jMVouwse0SPJJY322
        ZJ0y+rrf10MPlfE0bHZ9ekEcVg==
X-Google-Smtp-Source: APXvYqzITGCsugUHGz+COp1O8x6jIA4JLT8xkIoIL11ybl4wtnj4VxmmcSG9ZXHfdo2jr6gnd+nzEQ==
X-Received: by 2002:ac8:247c:: with SMTP id d57mr1076131qtd.308.1554312447404;
        Wed, 03 Apr 2019 10:27:27 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id b37sm14186564qtb.92.2019.04.03.10.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 10:27:26 -0700 (PDT)
Message-ID: <59dbed40fc0fad4a945cbfe09c9f622b81c7bd94.camel@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
From:   Lyude Paul <lyude@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Wed, 03 Apr 2019 13:27:25 -0400
In-Reply-To: <20190322113015.GM251185@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
         <20190215004329.GR96272@google.com>
         <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
         <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
         <20190321224819.GK251185@google.com> <20190322113015.GM251185@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, any update on this/do you guys need any more information here? Would very
much like to get this upstream

On Fri, 2019-03-22 at 06:30 -0500, Bjorn Helgaas wrote:
> On Thu, Mar 21, 2019 at 05:48:19PM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 13, 2019 at 06:25:02PM -0400, Lyude Paul wrote:
> > > On Fri, 2019-02-15 at 16:17 -0500, Lyude Paul wrote:
> > > > On Thu, 2019-02-14 at 18:43 -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Feb 12, 2019 at 05:02:30PM -0500, Lyude Paul wrote:
> > > > > > On a very specific subset of ThinkPad P50 SKUs, particularly
> > > > > > ones that come with a Quadro M1000M chip instead of the M2000M
> > > > > > variant, the BIOS seems to have a very nasty habit of not
> > > > > > always resetting the secondary Nvidia GPU between full reboots
> > > > > > if the laptop is configured in Hybrid Graphics mode. The
> > > > > > reason for this happening is unknown, but the following steps
> > > > > > and possibly a good bit of patience will reproduce the issue:
> > > > > > 
> > > > > > 1. Boot up the laptop normally in Hybrid graphics mode
> > > > > > 2. Make sure nouveau is loaded and that the GPU is awake
> > > > > > 2. Allow the nvidia GPU to runtime suspend itself after being idle
> > > > > > 3. Reboot the machine, the more sudden the better (e.g sysrq-b may
> > > > > > help)
> > > > > > 4. If nouveau loads up properly, reboot the machine again and go
> > > > > > back to
> > > > > > step 2 until you reproduce the issue
> > > > > > 
> > > > > > This results in some very strange behavior: the GPU will quite
> > > > > > literally be left in exactly the same state it was in when the
> > > > > > previously booted kernel started the reboot. This has all
> > > > > > sorts of bad sideaffects: for starters, this completely breaks
> > > > > > nouveau starting with a mysterious EVO channel failure that
> > > > > > happens well before we've actually used the EVO channel for
> > > > > > anything:
> > 
> > Thanks for the hybrid tutorial (snipped from this response).  IIUC,
> > what you said was that in hybrid mode, the Intel GPU drives the
> > built-in display and the Nvidia GPU drives any external displays and
> > may be used for DRI PRIME rendering (whatever that is).  But since you
> > say the Nvidia device gets runtime suspended, I assume there's no
> > external display here and you're not using DRI PRIME.
> > 
> > I wonder if it's related to the fact that the Nvidia GPU has been
> > runtime suspended before you do the reboot.  Can you try turning of
> > runtime power management for the GPU by setting the runpm module
> > parameter to 0?  I *think* this would be booting with
> > "nouveau.runpm=0".
> 
> Sorry, I wasn't really thinking here.  You already *said* this is
> related to runtime suspend.  It only happens when the Nvidia GPU has
> been suspended.
> 
> I don't know that much about suspend, but ISTR seeing comments about
> resuming devices before we shutdown.  If we do that, maybe there's
> some kind of race between that resume and the reboot?
> 
> Bjorn
-- 
Cheers,
	Lyude Paul

