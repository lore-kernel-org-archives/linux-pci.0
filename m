Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8708CC10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 13:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562C12183E
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260418;
	bh=QfgSXICcLsFHX48Dgu7Qo1L94TeNrwxP0FWO3ynu8kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OFDpEEajtz3DIUVMaNiCSqWPNI7+JsvUhtQ4R00Cg2acH/vtG4RSUQzaRlWiJwy7G
	 I+HHouvffLNl/uptV9RaqHTCiyDSQeNc4RCrYqSBe2wOS6i4qd9CHOWEaa5mj5Bj4t
	 jTX7rZQEI0U+uGi9kvyQI9FFWhCwxYL6movdPN+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfCVNNb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbfCVLaT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:19 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366B4218B0;
        Fri, 22 Mar 2019 11:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254218;
        bh=QfgSXICcLsFHX48Dgu7Qo1L94TeNrwxP0FWO3ynu8kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQJwk2sfMYmur9IF3CR9A+iiTwjFZtsPtbsqaneMPXkBwTYfTOcaukWvMaVHWk3Zc
         AwviV5/VXCw3nu5Av9YTPT+q8gI3UtWhOr2YfEsosJ+iHdiaDTsViWb7Y7VqOzlKyI
         dZGSgpx8GKgwC3J+b73mOl+cFq4G2XzyVd65oOLg=
Date:   Fri, 22 Mar 2019 06:30:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
Message-ID: <20190322113015.GM251185@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
 <20190215004329.GR96272@google.com>
 <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
 <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
 <20190321224819.GK251185@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321224819.GK251185@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 21, 2019 at 05:48:19PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 13, 2019 at 06:25:02PM -0400, Lyude Paul wrote:
> > On Fri, 2019-02-15 at 16:17 -0500, Lyude Paul wrote:
> > > On Thu, 2019-02-14 at 18:43 -0600, Bjorn Helgaas wrote:
> > > > On Tue, Feb 12, 2019 at 05:02:30PM -0500, Lyude Paul wrote:
> > > > > On a very specific subset of ThinkPad P50 SKUs, particularly
> > > > > ones that come with a Quadro M1000M chip instead of the M2000M
> > > > > variant, the BIOS seems to have a very nasty habit of not
> > > > > always resetting the secondary Nvidia GPU between full reboots
> > > > > if the laptop is configured in Hybrid Graphics mode. The
> > > > > reason for this happening is unknown, but the following steps
> > > > > and possibly a good bit of patience will reproduce the issue:
> > > > > 
> > > > > 1. Boot up the laptop normally in Hybrid graphics mode
> > > > > 2. Make sure nouveau is loaded and that the GPU is awake
> > > > > 2. Allow the nvidia GPU to runtime suspend itself after being idle
> > > > > 3. Reboot the machine, the more sudden the better (e.g sysrq-b may help)
> > > > > 4. If nouveau loads up properly, reboot the machine again and go back to
> > > > > step 2 until you reproduce the issue
> > > > > 
> > > > > This results in some very strange behavior: the GPU will quite
> > > > > literally be left in exactly the same state it was in when the
> > > > > previously booted kernel started the reboot. This has all
> > > > > sorts of bad sideaffects: for starters, this completely breaks
> > > > > nouveau starting with a mysterious EVO channel failure that
> > > > > happens well before we've actually used the EVO channel for
> > > > > anything:
> 
> Thanks for the hybrid tutorial (snipped from this response).  IIUC,
> what you said was that in hybrid mode, the Intel GPU drives the
> built-in display and the Nvidia GPU drives any external displays and
> may be used for DRI PRIME rendering (whatever that is).  But since you
> say the Nvidia device gets runtime suspended, I assume there's no
> external display here and you're not using DRI PRIME.
> 
> I wonder if it's related to the fact that the Nvidia GPU has been
> runtime suspended before you do the reboot.  Can you try turning of
> runtime power management for the GPU by setting the runpm module
> parameter to 0?  I *think* this would be booting with
> "nouveau.runpm=0".

Sorry, I wasn't really thinking here.  You already *said* this is
related to runtime suspend.  It only happens when the Nvidia GPU has
been suspended.

I don't know that much about suspend, but ISTR seeing comments about
resuming devices before we shutdown.  If we do that, maybe there's
some kind of race between that resume and the reboot?

Bjorn
