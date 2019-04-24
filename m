Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8761C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1072218FE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXJxsY53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfDXKBH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:01:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45899 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDXKBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 06:01:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so14148410lfl.12;
        Wed, 24 Apr 2019 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ui5QahMrKAtg0E0dOy4iSCZ6lLklrJQXdi1/50ZN5Bg=;
        b=uXJxsY53uayUxx7GSUur7VU87d7JSrz7DyRw5OMwER96JA5dW1UQ585vsA1yUJ/giU
         uHalNqZI6vMtO0xthDePx3Bl8qGGRPX0kqFyl9tcwJDe8Sc5GALe0EsMleJtSsoK5tzJ
         Lz+rR9WYUl21Cekv+CERaudlHDSid9qVzTU9cXX9twEtzLsoHig5Zld68Xy9vDTZ20bf
         YJGgFXmlcxlPRswJfvnnuS4ITBXslFJ8IFCtEiHml8Q+GtwlMmhawTuiSBQ8AOTF/1mo
         8C44z+bN9YIaZJFyEE+7nLgkNskzNAgBwDCB9WIwEcnnIpRZbLRN3m6jl6rl/N3/T+XY
         kJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ui5QahMrKAtg0E0dOy4iSCZ6lLklrJQXdi1/50ZN5Bg=;
        b=JsTkKQA/KIU5BctDuFBTzTAhZFeLFu2aDkE8XeUivFs0GDhQrgb+Y063niy7cdLG9V
         Q//X0ieOlaTcKxPUlZPbyzK2ehql0K9VkGCO5zN7dJs5hLUWGQ9D7uXqcddNCEc9N58q
         eB359PkoqewZWeammcMt3+7EPlCHRemdnJDZgkNBJLkR+Nc8Tw8M4ULX0i/GMnMvOezk
         KnMSuNepOTjWMo+Lw2Ovue2fv3GV+l1NUoAk+m/aHyyXWB0VnCu+SjrTHRvhSNdT3qCU
         XoJ2Tq47OGIk7FzGTHBuAcUN752nM1O1jvsPs5pvzXWLg3TwRGuvydZLNZ6yTh5F2Pe6
         dQ3w==
X-Gm-Message-State: APjAAAUHPruu0CLmjIpa4kRJJKGH5E+7U3rIeoOVKYVN0YiNTrlwUvXn
        rFoGZYuCJ1M0Qn9BWGe+BKX3+bT15Ckfxg==
X-Google-Smtp-Source: APXvYqxOvvtiQucYRgGSRJF1axAaDuhWBXieImvotqCdCNHRCv4Ue9uOwoq5NAiJWRV6Ja3niP/BNw==
X-Received: by 2002:ac2:4850:: with SMTP id 16mr17797446lfy.18.1556100065536;
        Wed, 24 Apr 2019 03:01:05 -0700 (PDT)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id f25sm4264582lfc.46.2019.04.24.03.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 03:01:03 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:01:02 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190424100102.iyxogbsa4l7dyusb@yadro.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
 <20190415141554.GL126710@google.com>
 <20190423215340.GH14616@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423215340.GH14616@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 04:53:40PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 15, 2019 at 09:15:54AM -0500, Bjorn Helgaas wrote:
> > This says it's a resend, but I don't see a previous posting; maybe it was
> > HTML and rejected by the mailing list?
> > 
The first post was niether rejected nor accepted in ML. So I added
"resend" tag in case it appears in the archive finally.

> > On Mon, Apr 15, 2019 at 04:59:03PM +0300, Alexander Fomichev wrote:
> > > PLX switches have an issue that their internal registers become inaccessible
> > > when runtime PM is enabled. Therefore PLX service tools can't communicate
> > > with the hardware. A kernel option "pcie_port_pm=off" can be used as a
> > > workaround. But it affects all the devices.
> > > So this solution is to add PLX switch devices to the quirk list for
> > > disabling runtime PM only for them.
> > 
> > I assume the problem is actually that the config space registers are
> > inaccessible when the device is in D3hot?
> 
> Reading this again, I realize you said "internal registers".  I don't
> know whether that actually means config space registers (which
> *should* work even when the device is in D3hot (see the PCIe reference
> below and PCI Power Management Spec r1.2, sec 5.4.1)), or MMIO
> registers (which are not expected to work while in D3hot).
> 
> If the service tools read MMIO registers, presumably that goes through
> some driver that should be able to manage runtime PM.  Or, if there's
> no driver, I think your service tool could prevent runtime power
> management by changing /sys/devices/.../power/control to "on" (see
> Documentation/power/runtime_pm.txt).
> 
You're right. Config space registers are accessible. The driver can't
read/write MMIO registers (Device-Specific Registers as they're called
by Broadcom).

> Please repost this with more details.
> 
> > I think config space access is supposed to work when a device is in D3hot
> > (see PCIe r4.0, sec 5.3.1.4).
> > 
> > If it doesn't work, wouldn't that mean that we couldn't even bring the
> > device *out* of D3hot, since that requires a config write?
> > 
> > If this is really the problem, it'd be nice to identify this specifically
> > instead of piggy-backing on the "is_hotplug_bridge" thing, which might be
> > coincidentally related, but also carries other meanings.
> > 
The proposed patch was a sort of workaround. If this approach is not
acceptable then it needs more research how to change PLX driver that it
can play with PM to access MMIO registers.

Regards,
  Alexander
