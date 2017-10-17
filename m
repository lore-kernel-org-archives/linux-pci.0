Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:52193 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965610AbdJQTNG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 15:13:06 -0400
Received: by mail-qt0-f177.google.com with SMTP id h4so5893300qtk.8
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2017 12:13:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 17 Oct 2017 14:12:45 -0500
Message-ID: <CAErSpo76LN8sMS6G0oFJuo_vWUeATt6TKT3SBEJVT+mAvxe1xw@mail.gmail.com>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
To: Casey Leedom <leedom@chelsio.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Komali Katari <komali@chelsio.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex, Bryant, Steven, Juan]

On Tue, Oct 17, 2017 at 1:36 PM, Casey Leedom <leedom@chelsio.com> wrote:
>
> Hi there,
>
>   I hope this is the right Linux list for this issue.  One of our QA staff
> has noticed a new behavior starting about 4.14.0-rc3.  We instantiate PCIe
> SR-IOV Virtual Functions and the corresponding driver (cxgb4vf in this case)
> is automatically loaded.  That's fine and has been the case for some time.
> But, we remove the driver module (rmmod cxgb4vf) and then attach one of the
> VFs to a KVM Virtual Machine and the cxgb4vf driver module gets reloaded in
> the KVM Hypervisor.  This is new behavior.  I see that there was a pretty
> big change done by Luis R. Rodriguez in kernel.org commit revision 2355869
> but we haven't yet isolated the new behavior to that commit.  That'll be our
> next test but I wanted to get this out there for comment.

This is a good list.  I don't know what commit revision 2355869 refers
to.  It would be helpful if you could cite the git SHA1 for the
commit.

We're also having a conversation about the question of binding drivers
to VFs on powerpc here:
https://lkml.kernel.org/r/20170922140608.47665-3-bryantly@linux.vnet.ibm.com

It's not exactly the same issue, but you might have useful input there.
