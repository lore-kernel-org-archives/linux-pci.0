Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39159 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751091AbdFAMia (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jun 2017 08:38:30 -0400
Date: Thu, 1 Jun 2017 14:38:26 +0200
From: Jean Delvare <jdelvare@suse.de>
To: x86@kernel.org, linux-pci@vger.kernel.org
Cc: Narendra_K@Dell.com, Jordan Hargrave <jordan_hargrave@dell.com>,
        Shyam Iyer <shyam_iyer@dell.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: dmi type 0xB1 record - unknown flag
Message-ID: <20170601143826.5f980444@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I see the following message in my kernel log:

dmi type 0xB1 record - unknown flag

This is on a Dell Optiplex 9020 workstation. I see the message comes
from:

static void __init read_dmi_type_b1(const struct dmi_header *dm,
                                    void *private_data)
{
	(...)
        switch (((*(u32 *)d) >> 9) & 0x03) {
        case 0x00:
                printk(KERN_INFO "dmi type 0xB1 record - unknown flag\n");
                break;

What is the value of this message? Is there anything which needs to be
done to properly support such systems?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
