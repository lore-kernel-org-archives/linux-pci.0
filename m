Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo04.seg.att.com ([209.65.160.86]:23176 "EHLO
	nbfkord-smmo04.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751248AbaG2ONd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jul 2014 10:13:33 -0400
Message-ID: <53D7A9FC.3040001@solarflare.com>
Date: Tue, 29 Jul 2014 15:04:44 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: <linux-pci@vger.kernel.org>
Subject: pci_sriov_set_totalvfs question
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Not sure if this list is the right place to ask, but:
I'm working on fallback code in the sfc driver where in some
configurations the device won't support using VFs, but will still
advertise them as present [1].  This is discovered at PF probe time, and
what I want to do is just set sriov_totalvfs to 0 in this case.

As far as I can tell, pci_sriov_set_totalvfs (drivers/pci/iov.c) is the
function to call, but I'm confused by the comment on that function which
states "Should be called from PF driver's probe routine with device's
mutex held."

Specifically, it's unclear what mutex is meant.  struct pci_dev doesn't
have one; struct pci_sriov /does/ but the struct is only defined in
drivers/pci/pci.h which I don't appear to be able to include from a
driver.  There's also one in the 'struct device dev' member of struct
pci_dev, but that seems rather unlikely.

Also, the wording of the comment makes me wonder if being in the PF
probe routine /implies/ that the mutex is held already, in which case I
don't have to do anything.  This is supported by the only callers,
igb_probe (via igb_sw_init and igb_probe_vfs) and ixgbe_probe, not
appearing to take any mutexes before calling pci_sriov_set_totalvfs.

Please CC on replies, as I'm not subscribed to the list.

Thanks,
-Edward

[1] SFC9120-based NICs support multiple PFs per port and these can be
used as a kind of "poor-man's SR-IOV" (we're calling it 'PF-IOV') by
placing the firmware v-switch below the PFs.  However, this then
precludes adding a v-switch above the PF to direct VF traffic, meaning
that VFs are useless in this configuration.  Consequently, our
configuration tools won't allow VFs and PF-IOV to be enabled
simultaneously, but bugs or corruption could cause this to happen.
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
