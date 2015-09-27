Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:56441 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604AbbI0L0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 27 Sep 2015 07:26:08 -0400
MIME-Version: 1.0
Message-ID: <trinity-b50eba01-12bd-411c-b954-4101f1c26722-1443353161263@3capp-webde-bs08>
From: "Roland Weber" <r-o-l@web.de>
To: linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2015 13:26:01 +0200
In-Reply-To: <trinity-873ca220-d869-40c4-88b0-a6ae9ec8548d-1443213001295@3capp-webde-bs54>
References: <Pine.LNX.4.44L0.1509231058110.1670-100000@iolanthe.rowland.org>,
 <trinity-873ca220-d869-40c4-88b0-a6ae9ec8548d-1443213001295@3capp-webde-bs54>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

I have now installed the machine to boot Xubuntu 15.04 in
UEFI mode without secure boot. It does not freeze anymore.
So we can finally let this mail thread fade out.

Nevertheless, a warning for those who want to try the same:
it's not a smooth experience at all. After installing on
the full disk, the BIOS/UEFI reported that there is no
bootable device. I booted from the live USB stick again
and ran the boot-repair tool from the live session. This
fixed the matter, after a fashion. When booting, I now get:
1. a warning that the default boot device is missing and
   that I should insert a recovery disk (I have none)
   [select OK, there is no other option]
2. a boot selection with options "Unnamed device" and
   "Windows Boot Manager" (there is no Windows on the machine)
   [select "Unnamed device"]
3. the Grub menu, finally

Attempts to improve matters with 'efibootmgr' were futile.
This will have to do for a while.

cheers,
  Roland
