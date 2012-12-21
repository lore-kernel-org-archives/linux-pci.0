Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16985 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab2LUTxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2012 14:53:32 -0500
From: "Rose, Gregory V" <gregory.v.rose@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yuval Mintz <yuvalmin@broadcom.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v2] PCI SRIOV device enable and disable via sysfs
Date: Fri, 21 Dec 2012 19:53:28 +0000
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A073ED86DA6@ORSMSX106.amr.corp.intel.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
 <CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com>
 <20121214101911.00002f59@unknown> <50CF7993.9040606@redhat.com>
 <20121217232439.GA9746@google.com> <50D24355.1050100@redhat.com>
 <CAErSpo7PUZgbD+=wXiQehHgoVtmn-9SLKvDJxQz9Mn18Fmx0TQ@mail.gmail.com>
 <CAErSpo7cj4hdk+PznobkmxoM5pqpSzhoM0_RKSbGo4xq2imHaQ@mail.gmail.com>
In-Reply-To: <CAErSpo7cj4hdk+PznobkmxoM5pqpSzhoM0_RKSbGo4xq2imHaQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Friday, December 21, 2012 11:49 AM
> To: Don Dutile
> Cc: Rose, Gregory V; linux-pci@vger.kernel.org; Yuval Mintz;
> bhutchings@solarflare.com; yinghai@kernel.org; davem@davemloft.net
> Subject: Re: [PATCH v2] PCI SRIOV device enable and disable via sysfs
> 
> On Thu, Dec 20, 2012 at 2:47 PM, Bjorn Helgaas <bhelgaas@google.com>
> wrote:
> 
> > I made the -EPERM change suggested by Greg and added this to my
> > pci/for-3.8 branch.  I'll ask Linus to pull it soon after v3.8-rc1.
> 
> After a little off-list discussion about the merits of EINVAL, EPERM,
> EBUSY, etc., I adopted Ben's suggestion of EBUSY for this case:
> 
> +       if (pdev->sriov->num_VFs) {
> +               dev_warn(&pdev->dev, "%d VFs already enabled. Disable
> before enabling %d VFs\n",
> +                        pdev->sriov->num_VFs, num_vfs);
> +               return -EBUSY;
> 
> where the idea is "the device is already busy providing N VFs, so you
> can't configure it to serve M VFs"
> 
> Does that sound agreeable to everybody?

That makes sense, I'm fine with it.

- Greg

> 
> Bjorn
