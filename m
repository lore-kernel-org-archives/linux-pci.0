Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48178 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab3LHNKF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 8 Dec 2013 08:10:05 -0500
Date: Sun, 8 Dec 2013 14:09:58 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Set master earlier
Message-ID: <20131208140958.0f1eb921@endymion.delvare>
In-Reply-To: <CAErSpo6ikaTXXvWzX_Z0=mabwD4aedoLoSVjsd+_E5kV9YJpuA@mail.gmail.com>
References: <20131009163304.62b439a9@endymion.delvare>
	<CAErSpo6ikaTXXvWzX_Z0=mabwD4aedoLoSVjsd+_E5kV9YJpuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Sat, 7 Dec 2013 15:23:25 -0700, Bjorn Helgaas wrote:
> [+cc Yinghai]
> 
> On Wed, Oct 9, 2013 at 8:33 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > Since kernel 3.12-rc3, I get the following warning messages at boot:
> > pcieport 0000:00:07.0: driver skip pci_set_master, fix it!
> > pcieport 0000:00:01.0: driver skip pci_set_master, fix it!
> 
> cf3e1feba7f9 ("PCI: Workaround missing pci_set_master in pci drivers")
> added this warning and, at the same time, turned on bus mastering.
> 
> There didn't seem to be any reason for the warning and no reason why
> bus mastering should be enabled in the driver rather than the core, so
> fbeeb822f6f4 ("PCI: Drop warning about drivers that don't use
> pci_set_master()") just dropped the warning.
> 
> This should resolve the problem, so I don't think there's a need for
> this patch.  Let me know if otherwise.

This is fine with me, all I really wanted was to get rid of the
warning. I am not aware of any problem either (but I am no PCI expert
by any means.)

Thanks,
-- 
Jean Delvare
Suse L3 Support
