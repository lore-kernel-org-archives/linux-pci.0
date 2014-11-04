Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:55872 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbaKDO6H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Nov 2014 09:58:07 -0500
Received: by mail-qc0-f172.google.com with SMTP id i17so11180842qcy.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2014 06:58:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0ef630975c0c4108b64ecb0b5e688f0b@DM2PR05MB975.namprd05.prod.outlook.com>
References: <0ef630975c0c4108b64ecb0b5e688f0b@DM2PR05MB975.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Nov 2014 07:57:46 -0700
Message-ID: <CAErSpo4cGm_dfPXtmaAhUn8E7diYit-yOHDAF0kNtNs_OQFQzA@mail.gmail.com>
Subject: Re: Bug #79611
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 3, 2014 at 11:11 PM, Rajat Jain <rajatjain@juniper.net> wrote:
> Hi Bjorn,
>
> Since the bug 79611 is fixed by the commit 0d25d35c987d7b0b63368d9c1ae35a917e1a7bab, is there any reason to still keep it open?

https://bugzilla.kernel.org/show_bug.cgi?id=79611

Thanks for noticing this.  I should go through and see if there are
others that can be closed.  I closed this one with:

Fixed by 0d25d35c987d ("PCI: pciehp: Clear Data Link Layer State
Changed during init") which appeared in v3.17-rc1.
