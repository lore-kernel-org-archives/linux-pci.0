Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.xlhost.de ([213.202.242.118]:59123 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756172Ab3GZKFy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Jul 2013 06:05:54 -0400
Message-ID: <51F24788.6010505@kpanic.de>
Date: Fri, 26 Jul 2013 11:55:20 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: bhelgaas@google.com, yu.zhao@intel.com,
	"Duyck, Alexander H" <alexander.h.duyck@intel.com>
Subject: return value for "if (!dev->is_physfn)"
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looking at drivers/pci/iov.c I see at least 3 different return values
for if (!dev->is_physfn).

sriov_enable() and pci_enable_sriov()
[...]
	if (!dev->is_physfn)
		return -ENODEV;
pci_num_vf() and pci_vfs_assigned()
[...]
	if (!dev->is_physfn)
		return 0;
pci_sriov_set_totalvfs() and pci_sriov_get_totalvfs()
[...]
	if (!dev->is_physfn)
		return -EINVAL;

I'd like to make this consistently return one of the above. Question is,
which one should it be? I'd lean towards -ENODEV, other opinions?

  Stefan
