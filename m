Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:45495 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315Ab3CLGFb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 02:05:31 -0400
Received: by mail-lb0-f170.google.com with SMTP id ge1so3788086lbb.29
        for <linux-pci@vger.kernel.org>; Mon, 11 Mar 2013 23:05:29 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 12 Mar 2013 16:05:26 +1000
Message-ID: <CAPM=9tzbb7dMZgtVOE4wNosHFcFX30u3OjtP0GcxeQnT3O+9cg@mail.gmail.com>
Subject: sub function power management (gpu + audio device)
From: Dave Airlie <airlied@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey guys,

I've been writing dynamic power management code for the secondary
GPUs, however a lot of these GPUs have audio codecs as a subfunction
PCI device.

So we get 01:00.0 as the GPU and 01:00.1 as the HDMI audio device.

Now we have a single power switch for these devices, and generally the
power switch is hit when the ACPI entry to D3 is called for the GPU
and it shuts off the whole device.

So the problem I'm having is how to have the audio device
(snd_hda_intel), understand that it needs to have the GPU devices D0
called before it can do its own D0, and thats its D3 should be called
before the GPU drivers D3.

Any pointers? Do I need to create a separate pm domain for these
devices? how does the ordering work then?

Dave.
