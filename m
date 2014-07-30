Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:59068 "EHLO
	nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755448AbaG3RXN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Jul 2014 13:23:13 -0400
Message-ID: <53D929FE.40706@solarflare.com>
Date: Wed, 30 Jul 2014 18:23:10 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: <linux-pci@vger.kernel.org>
Subject: pci_sriov_set_totalvfs again
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Calling pci_sriov_set_totalvfs(dev, 0) has no effect, because
pci_sriov_get_totalvfs ignores dev->sriov->driver_max_VFs if it's 0, as
that is used as the 'not set' value.
So, three questions:
a) is this a bug?
b) if not, should the comment on pci_sriov_set_totalvfs mention that
passing numvfs=0 will be interpreted as numvfs=dev->sriov->total_VFs?
c) is there a better way of indicating "current configuration doesn't
support VFs" rather than calling set_totalvfs(0)?

Thanks,
-Edward
||
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
