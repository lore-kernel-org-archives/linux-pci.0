Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E3C67839
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 22:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281662084C
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 22:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566904;
	bh=fSLFMvVoixiNmlDMP5MQDqBjxk5RY6oXyNRPaQk4bMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UI/yqhLTK0ROx5w69k+VntmjO+2/7A2dnxmksoWiiDSGUu6tVQMkEfpJKjkZYOdbn
	 vrvt13C1KVu9e6ui2M2K66PZabTKW6/niUqPjKBQhn4J4szjQyMSl1Dn5X2reF/nfx
	 63Bk7lw3IiwuLiKrOIwZsEAzjjNDqaEMxAqydoO0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281662084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLKWVn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKWVn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 17:21:43 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5502F2084C;
        Tue, 11 Dec 2018 22:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544566902;
        bh=fSLFMvVoixiNmlDMP5MQDqBjxk5RY6oXyNRPaQk4bMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2KzfXbQcsrgv0jb+hhBJqaYEAg/n6aelD3tVxjcUVX5v4ry42r0FiNVPy/2qIr7y
         mROUGxwEKErr9bGgVsoj1oAFzWYfxIcOqJemcBo8P8SktR37CBfZ9n7YQSnqvic1yU
         bd7X8g3BlkqAmxxKaZJbiy55mKReIKmomB0iw25E=
Date:   Tue, 11 Dec 2018 16:21:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Mertarg10@gmail.com" <Mertarg10@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fran RR <fjrr87@outlook.com>
Subject: Re: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get
 detected but bluetooth works
Message-ID: <20181211222131.GH99796@google.com>
References: <20181128211959.GB178809@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB3013373E4A3@HASMSX112.ger.corp.intel.com>
 <20181210222452.GC85090@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133754C00@HASMSX112.ger.corp.intel.com>
 <20181211135121.GB99796@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133756A29@HASMSX112.ger.corp.intel.com>
 <20181211182630.GF99796@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133756B5D@HASMSX112.ger.corp.intel.com>
 <20181211183805.GG99796@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133756BE7@HASMSX112.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0BA3FCBA62E2DC44AF3030971E174FB30133756BE7@HASMSX112.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 06:51:14PM +0000, Grumbach, Emmanuel wrote:
> > 
> > On Tue, Dec 11, 2018 at 06:31:47PM +0000, Grumbach, Emmanuel wrote:
> > > > On Tue, Dec 11, 2018 at 04:32:25PM +0000, Grumbach, Emmanuel wrote:
> > > > > > On Tue, Dec 11, 2018 at 06:35:20AM +0000, Grumbach, Emmanuel
> > wrote:
> > > > > > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=201647
> > > > > >
> > > > > > > FWIW: I saw another problem like this with a 9650 device.
> > > > > >
> > > > > > Do you have a pointer to any info about this 9650 issue?  Maybe
> > > > > > that would have a clue.
> > > > >
> > > > > I added him here so that you can ask whatever you like :) The
> > > > > story is the same. I am attaching a picture I got from the reporter.
> > > > > I can confirm that this device ID / subdevice ID is supported by
> > > > > the linux
> > > > driver.
> > > >
> > > > Was there a resolution, i.e., if somebody figured out how to make
> > > > the
> > > > 9650 wifi work, maybe a similar solution would work for the 3165?
> > >
> > > Unfortunately not, I am stuck there at the exact same point.  No
> > > Wifi device shows up in lspci...
> > 
> > Is there a public spec?  My patience for reverse engineering
> > things that are documented somewhere that I'm not allowed to see
> > is pretty limited.  Presumably *you* should be able to see the
> > spec, since this is an Intel device and you have an @intel.com
> > address?
> 
> Ok, I start to understand. So no, no public spec. I am an Intel
> employee, I used to maintain the WiFi driver (iwlwifi). I don't know
> much about PCI though.  I am definitely not asking you to reverse
> engineer our device :) I can try to ask internally what could be
> going on.  The reason I haven't done so so far and reached out to
> you is because I am not aware about switches that we need to toggle
> to make the device magically show up. So I thought it'd be related
> to the PCI core, which take me to the next point...
>
> > From what we can tell so far, I don't *think* this is a PCI issue.
> > If the device doesn't respond to a PCI config access, the PCI core
> > can't really be expected to do anything about it.
> 
> Ok, thanks. So I understand from you that you didn't see any weird
> log from the PCI core saying: "I can see this device, but I can't
> enumerate it because XYZ".  I tried to look for such a thing but
> couldn't.

Right; we should be doing a config read to the device, but apparently
we don't get a response so we think it's not there.  It's still
conceivable there's some hotplug or power management wrinkle that we
aren't handling correctly, but those things are used on many systems,
so it would have to be a fairly esoteric issue.

> From this point, I guess I can't do much either. I'll try to get
> info internally.

Great, thanks!

Bjorn
