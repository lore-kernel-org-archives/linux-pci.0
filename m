Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:40566 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbaHADSf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jul 2014 23:18:35 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so5102675qgd.23
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2014 20:18:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53DA674A.9030305@solarflare.com>
References: <53D9288B.5030302@solarflare.com>
	<53D93407.8040308@redhat.com>
	<53D93848.7070203@solarflare.com>
	<53D9602A.4010406@intel.com>
	<53DA3180.5040302@solarflare.com>
	<alpine.LFD.2.03.1407311500570.16821@solarflare.com>
	<53DA5EF4.1030500@intel.com>
	<53DA674A.9030305@solarflare.com>
Date: Fri, 1 Aug 2014 11:18:34 +0800
Message-ID: <CABawtvMK=FrquFm-imovjjCV9YMj-fH1mWYd=5G=kpJccdETPQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
From: Ethan Zhao <ethan.kernel@gmail.com>
To: Edward Cree <ecree@solarflare.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 31, 2014 at 11:56 PM, Edward Cree <ecree@solarflare.com> wrote:
> On 31/07/14 16:21, Alexander Duyck wrote:
>> However if you are wanting to use this as a way to disable SR-IOV for a
>> device I wouldn't recommend it.  Based on what you have described I
>> would suggest dropping the fix in drivers/pci/quirks that would clear
>> dev->is_physfn if you are in the PF-IOV mode.  That way the SR-IOV
>> functionality should be fully disabled.
> I still don't see how this can go in drivers/pci/quirks, because PF-IOV
> mode can only be detected at driver probe time.  The way we find out
> that the NIC is in PF-IOV mode is that a request to the MC (the
> Management CPU on the card) to create a vswitch fails.  But maybe I'm
> wrong about what quirks can do - is there any relevant documentation?
>
> Clearing dev->is_physfn in the driver probe routine isn't safe:
> dev->sriov memory can get leaked, for example, as sriov_init will get
> called at device add, but sriov_release won't be called at removal.
>

  I think this memory leak bug doesn't exist.

  The dev->sriov memory was allocated when pci_device_add() called.
whenever devices
  were hot-pluged into system or built-in devices were scanned while booting.

  The memory of dev->sriov is to be freed by kobject->kobject_release() when
the device reference counter reaches zero when put_device() was called.
for hot-plug, that is pciehp_unconfigure_device()....etc.  but not in
driver->remove().

     put_device()
        kobject_put()
           kobject_release()
               kobject_cleanup()
                   device_release()
                       dev->release(dev)
                             pci_release_dev()
                                  pci_release_capabilities()
                                     pci_iov_release()
                                         sriov_release(dev);
                                               kfree(dev->sriov);

Thanks,
Ethan


> I'm also unconvinced that having !(dev->is_physfn || dev->is_virtfn) is
> a valid state; but maybe I'm misunderstanding and "is_physfn" doesn't
> actually mean "is a physical function", but rather "has SR-IOV capability".
>> In addition this solution would
>> also resolve the fact that the driver wouldn't actually have to be
>> loaded for it to work so if someone were to load a driver that didn't
>> contain the fix they would be blocked from enabling SR-IOV as well.
> The current driver fails to probe the PF because it assumes the vswitch
> creation failure is fatal.  There should never be a driver that knows it
> can live without the vswitch but doesn't know that that breaks SR-IOV.
>
> -Edward
> The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
