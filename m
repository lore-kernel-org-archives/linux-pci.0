Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:62573 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaG3CsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jul 2014 22:48:18 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so709729qgd.33
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2014 19:48:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53D7A9FC.3040001@solarflare.com>
References: <53D7A9FC.3040001@solarflare.com>
Date: Wed, 30 Jul 2014 10:48:17 +0800
Message-ID: <CABawtvN7nb6FkLc_00Qr55+=72tymmkSEDZt7jb9=+=r0BDTBg@mail.gmail.com>
Subject: Re: pci_sriov_set_totalvfs question
From: Ethan Zhao <ethan.kernel@gmail.com>
To: Edward Cree <ecree@solarflare.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 29, 2014 at 10:04 PM, Edward Cree <ecree@solarflare.com> wrote:
> Not sure if this list is the right place to ask, but:
> I'm working on fallback code in the sfc driver where in some
> configurations the device won't support using VFs, but will still
> advertise them as present [1].  This is discovered at PF probe time, and
> what I want to do is just set sriov_totalvfs to 0 in this case.
>
> As far as I can tell, pci_sriov_set_totalvfs (drivers/pci/iov.c) is the
> function to call, but I'm confused by the comment on that function which
> states "Should be called from PF driver's probe routine with device's
> mutex held."

 device_attach()
      device_lock(dev);  <--------
      driver_probe_device()
            really_probe()
                  drv->probe(dev)
                       ixgbe_probe()
                           pci_sriov_set_totalvfs()
      device_unlock(dev); <--------
>
> Specifically, it's unclear what mutex is meant.  struct pci_dev doesn't
> have one; struct pci_sriov /does/ but the struct is only defined in
> drivers/pci/pci.h which I don't appear to be able to include from a
> driver.  There's also one in the 'struct device dev' member of struct
> pci_dev, but that seems rather unlikely.
>
> Also, the wording of the comment makes me wonder if being in the PF
> probe routine /implies/ that the mutex is held already, in which case I
> don't have to do anything.  This is supported by the only callers,
> igb_probe (via igb_sw_init and igb_probe_vfs) and ixgbe_probe, not
> appearing to take any mutexes before calling pci_sriov_set_totalvfs.
>
> Please CC on replies, as I'm not subscribed to the list.
>
> Thanks,
> -Edward
>
> [1] SFC9120-based NICs support multiple PFs per port and these can be
> used as a kind of "poor-man's SR-IOV" (we're calling it 'PF-IOV') by
> placing the firmware v-switch below the PFs.  However, this then
> precludes adding a v-switch above the PF to direct VF traffic, meaning
> that VFs are useless in this configuration.  Consequently, our
> configuration tools won't allow VFs and PF-IOV to be enabled
> simultaneously, but bugs or corruption could cause this to happen.
> The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
