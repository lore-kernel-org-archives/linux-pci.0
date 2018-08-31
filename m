Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:42747 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeHaNCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2018 09:02:03 -0400
Date: Fri, 31 Aug 2018 10:55:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Patch v1 0/7] mpt3sas: Hot-Plug Surprise removal support on IOC.
Message-ID: <20180831085534.n6eikj5cw522ihhe@wunner.de>
References: <1535690081-16116-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75VfC8GN3oEzSFJYfMr0iqBTYUJ=WPoLS9Oh5NgVcFmnBkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VfC8GN3oEzSFJYfMr0iqBTYUJ=WPoLS9Oh5NgVcFmnBkw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[cc += linux-pci, benh]

On Fri, Aug 31, 2018 at 7:37 AM Suganath Prabu S <suganath-prabu.subramani@broadcom.com> wrote:
> Posting below set of patches to support PCIe Hot Plug surprise removal,
> and few defect fixes.

Please cross-post to linux-pci in the future.


Regarding [PATCH 1/7] mpt3sas: Introduce mpt3sas_base_pci_device_is_unplugged:
https://www.spinics.net/lists/linux-scsi/msg122962.html

* mpt3sas_base_pci_device_is_unplugged() is a duplication of the existing
  pci_device_is_present().

* Just reading the vendor ID may not be sufficient to detect unplug,
  it may also read as "all ones" if the link is down due to error
  recovery by DPC.


Regarding [PATCH 2/7] mpt3sas: Add HBA hot plug watchdog thread:
https://www.spinics.net/lists/linux-scsi/msg122963.html

* I don't see why you need to poll for the device's removal from a
  watchdog thread.  pciehp will invoke your driver's ->remove hook
  once the device is gone.

* A recent discussion initiated by Benjamin Herrenschmidt came to the
  conclusion that device removal should be treated as a type of
  error state (either pci_channel_io_perm_failure or another, newly
  introduced state).  It will then be possible to detect the device's
  inaccessibility with pci_channel_offline().  Please help work towards
  such a future solution in the PCI core instead of solutions localized
  to a single device driver.  Sorry, the discussion was lengthy, it is
  available here:
  https://www.spinics.net/lists/linux-pci/msg75425.html

Thanks,

Lukas
