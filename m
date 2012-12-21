Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:44691 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab2LUTtt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2012 14:49:49 -0500
Received: by mail-la0-f50.google.com with SMTP id c1so5745869lah.37
        for <linux-pci@vger.kernel.org>; Fri, 21 Dec 2012 11:49:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7PUZgbD+=wXiQehHgoVtmn-9SLKvDJxQz9Mn18Fmx0TQ@mail.gmail.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
 <CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com>
 <20121214101911.00002f59@unknown> <50CF7993.9040606@redhat.com>
 <20121217232439.GA9746@google.com> <50D24355.1050100@redhat.com> <CAErSpo7PUZgbD+=wXiQehHgoVtmn-9SLKvDJxQz9Mn18Fmx0TQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Dec 2012 12:49:27 -0700
Message-ID: <CAErSpo7cj4hdk+PznobkmxoM5pqpSzhoM0_RKSbGo4xq2imHaQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI SRIOV device enable and disable via sysfs
To: Don Dutile <ddutile@redhat.com>
Cc: "Rose, Gregory V" <gregory.v.rose@intel.com>,
	linux-pci@vger.kernel.org, Yuval Mintz <yuvalmin@broadcom.com>,
	bhutchings@solarflare.com, yinghai@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 20, 2012 at 2:47 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> I made the -EPERM change suggested by Greg and added this to my
> pci/for-3.8 branch.  I'll ask Linus to pull it soon after v3.8-rc1.

After a little off-list discussion about the merits of EINVAL, EPERM,
EBUSY, etc., I adopted Ben's suggestion of EBUSY for this case:

+       if (pdev->sriov->num_VFs) {
+               dev_warn(&pdev->dev, "%d VFs already enabled. Disable
before enabling %d VFs\n",
+                        pdev->sriov->num_VFs, num_vfs);
+               return -EBUSY;

where the idea is "the device is already busy providing N VFs, so you
can't configure it to serve M VFs"

Does that sound agreeable to everybody?

Bjorn
