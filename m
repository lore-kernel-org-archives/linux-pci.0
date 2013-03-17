Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60000 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756252Ab3CQQEp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 17 Mar 2013 12:04:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1UHG51-000805-RV
	for linux-pci@vger.kernel.org; Sun, 17 Mar 2013 17:05:04 +0100
Received: from 120819-2718A.teremki.kiev.ua ([178.159.236.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2013 17:05:03 +0100
Received: from roman.yepishev by 120819-2718A.teremki.kiev.ua with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2013 17:05:03 +0100
To: linux-pci@vger.kernel.org
From: Roman Yepishev <roman.yepishev@gmail.com>
Subject: Re: is L1 really disabled in iwlwifi
Date: Sun, 17 Mar 2013 15:59:19 +0000 (UTC)
Message-ID: <loom.20130317T165508-222@post.gmane.org>
References: <CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com> <20130304134949.GB3021@redhat.com> <CANUX_P0JhuVWcQjTckYzG8eBb2MtT_=prKqV38mCpVjfLmGtCA@mail.gmail.com> <20130304154832.GD3021@redhat.com> <CANUX_P22AkqeOROP1QHzp20wGWgDbRzy+9FZy2KvHLXCQ5AVnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Emmanuel Grumbach <egrumbach <at> gmail.com> writes:
> nope - enabled on both kernel: 3.1 and 3.7. Makes sense though.
> CONFIG_PCIEASPM enabled, I have L1. Just wondering why doesn't that
> pci_disable_link_state do anything....
> Also, I remember so issues Mathew Garret debugged and he ended up
> disabling ASPM on older kernel because some BIOS issue (don't remember
> really). Apparently, ASPM is enabled again in newer kernels.
> 
> Anyway - I think I will just remove this pci_disable_link_state call
> and hopefully, it will stay long enough in linux-next so that people
> will report issues before it get into linux.
> I don't like leaving that code if it doesn't do anything.
> 

Does this bug - https://bugzilla.kernel.org/show_bug.cgi?id=55211 look related?

It deals with the changes to ASPM checks that broke the ability to use
pci_disable_link_state calls to control ASPM status.

-- 
Regards,
Roman Yepishev

