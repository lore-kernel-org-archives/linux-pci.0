Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33041 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbbEFPXs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 11:23:48 -0400
Received: by qgdy78 with SMTP id y78so6255171qgd.0
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2015 08:23:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150506072557.GA22377@richard>
References: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150505212905.GB24643@google.com> <20150506072557.GA22377@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 6 May 2015 10:23:26 -0500
Message-ID: <CAErSpo7oTxbThDGj6UkbpsAKBakkzJsq104swqsZWkr=0+dNkA@mail.gmail.com>
Subject: Re: [PATCH] pci/iov: return a reference to PF on destroying VF
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 6, 2015 at 2:25 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Tue, May 05, 2015 at 04:29:05PM -0500, Bjorn Helgaas wrote:

>>It would be useful to mention a way to cause the leak.  I suspect writing
>>to a VF's sysfs "remove" file is the easiest.
>>
>
> Looks a VF don't support the remove now.
>
> static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
>                                             struct attribute *a, int n)
> {
>         struct device *dev = container_of(kobj, struct device, kobj);
>         struct pci_dev *pdev = to_pci_dev(dev);
>
>         if (pdev->is_virtfn)
>                 return 0;
>
>         return a->mode;
> }
>
> static struct attribute_group pci_dev_hp_attr_group = {
>         .attrs = pci_dev_hp_attrs,
>         .is_visible = pci_dev_hp_attrs_are_visible,
> };

Right, I forgot about this.  A VF has no "remove" file, so it can't be
used to cause the leak.
