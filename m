Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:47224 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbbBZRsu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 12:48:50 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so12732619obc.11
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2015 09:48:50 -0800 (PST)
Date: Thu, 26 Feb 2015 11:48:47 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alnie <memobook80@comcast.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI Issues with ExpressCard/54 Audio Device
Message-ID: <20150226174847.GB25765@google.com>
References: <1703881568.13072732.1424911985807.JavaMail.zimbra@comcast.net>
 <1602089933.13084034.1424913145538.JavaMail.zimbra@comcast.net>
 <CAErSpo6E5EMDUA8tHRZYF6rgfRqtHEZtG4EyVcMSRL02T3Ttyg@mail.gmail.com>
 <s5hioep2idw.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hioep2idw.wl-tiwai@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 26, 2015 at 09:20:59AM +0100, Takashi Iwai wrote:

> FYI, during the previous debug sessions, we found that the sound
> driver gets only 0xff for mapped register accesses, so I suggested to
> report to PCI devs.  IIRC, the non-hotplug board with this chip worked
> in the past.

I skimmed the previous emails but I missed this part.  Did you add
instrumentation to the driver, or is it just obvious from the way the
driver behaves that we're getting 0xff?

Bjorn
