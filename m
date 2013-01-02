Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46166 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab3ABRI0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Jan 2013 12:08:26 -0500
Message-ID: <50E4697F.70408@redhat.com>
Date: Wed, 02 Jan 2013 12:08:15 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rose, Gregory V" <gregory.v.rose@intel.com>,
	linux-pci@vger.kernel.org, Yuval Mintz <yuvalmin@broadcom.com>,
	bhutchings@solarflare.com, yinghai@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v2] PCI SRIOV device enable and disable via sysfs
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com> <CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com> <20121214101911.00002f59@unknown> <50CF7993.9040606@redhat.com> <20121217232439.GA9746@google.com> <50D24355.1050100@redhat.com> <CAErSpo7PUZgbD+=wXiQehHgoVtmn-9SLKvDJxQz9Mn18Fmx0TQ@mail.gmail.com> <CAErSpo7cj4hdk+PznobkmxoM5pqpSzhoM0_RKSbGo4xq2imHaQ@mail.gmail.com>
In-Reply-To: <CAErSpo7cj4hdk+PznobkmxoM5pqpSzhoM0_RKSbGo4xq2imHaQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/21/2012 02:49 PM, Bjorn Helgaas wrote:
> On Thu, Dec 20, 2012 at 2:47 PM, Bjorn Helgaas<bhelgaas@google.com>  wrote:
>
>> I made the -EPERM change suggested by Greg and added this to my
>> pci/for-3.8 branch.  I'll ask Linus to pull it soon after v3.8-rc1.
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
>
> Bjorn
Ack!

