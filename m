Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:45342 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759306Ab3BXDNM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Feb 2013 22:13:12 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so1788986oag.8
        for <linux-pci@vger.kernel.org>; Sat, 23 Feb 2013 19:13:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
	<alpine.DEB.2.02.1301181322500.31163@jlaw-desktop.mno.stratus.com>
	<51122BED.8090308@cn.fujitsu.com>
	<CAErSpo6aGiuBbgcVfcduPk++7B_zzuk2Y+fjLiJBvdOqnU+Qmw@mail.gmail.com>
	<5122F276.80807@cn.fujitsu.com>
	<CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com>
Date: Sat, 23 Feb 2013 19:13:11 -0800
Message-ID: <CAE9FiQV814mCKqcOKAE_y3JSUq2HotVjde6VYW4M8Zb2-S=NRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Joe Lawrence <Joe.Lawrence@stratus.com>,
	linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Content-Type: multipart/mixed; boundary=bcaec5523bb6e9d06c04d66fcd98
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--bcaec5523bb6e9d06c04d66fcd98
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Feb 23, 2013 at 4:20 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I think this is a general object lifetime issue that really has
> nothing to do with ASPM except that ASPM happens to be the victim.
>
> You're doing this:
>
>     echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove ; echo -n 1
>>  /sys/bus/pci/devices/0000\:1a\:01.0/remove
>
> The 1a:01.0 device is downstream from the 10:00.0 bridge.  The sysfs
> interface remove_store() uses device_schedule_callback() to schedule
> the remove for later.  I think what's happening is that we schedule
> remove_callback() for both devices before 10:00.0 has been removed,
> like this:
>
>     # echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove
>     remove_store  # for 10:00.0
>       device_schedule_callback(10:00.0, remove_callback)
>         sysfs_schedule_callback
>           kobject_get
>           queue_work
>     # echo -n 1 >  /sys/bus/pci/devices/0000\:1a\:01.0/remove
>     remove_store  # for 1a:01.0
>       device_schedule_callback(1a:01.0, remove_callback)
>         sysfs_schedule_callback
>           kobject_get
>           queue_work
>
> Note that we acquire a reference on each pci_dev before queuing the work item.
>
> Later, we run the callbacks, starting with 10:00.0.  This calls
> remove_callback() to perform the remove:
>
>     remove_callback(10:00.0)
>       mutex_lock(&pci_remove_rescan_mutex)
>       pci_stop_and_remove_bus_device(pdev)
>       mutex_unlock(&pci_remove_rescan_mutex)
>
> This will stop and remove the subtree below 10:00.0, but it does not
> actually free the pci_dev for 1a:01.0 because we increased its ref
> count in sysfs_schedule_callback.  So after completing
> remove_callback(10:00.0), we run the second callback for 1a:01.0.
>
> The remove for 1a:01.0 calls pcie_aspm_exit_link_state() from
> pci_stop_dev().  This is where we blow up because, according to your
> debugging, pdev->bus->self is no longer valid.
>
> The PCI core did this removal wrong.  If we have a valid pci_dev
> pointer, as we do in pcie_aspm_exit_link_state(), the whole object
> ought to be valid.  But the PCI core deallocated the struct pci_bus
> for bus 0000:1a too soon.
>
> My guess is that when we build a pci_dev, we need to increase the ref
> count on the pci_bus where that pci_dev lives.  That way we can keep
> around all the buses and bridges leading from the root to the device
> in question.

Agreed, Please check if attached is what you want.

Thanks

Yinghai

--bcaec5523bb6e9d06c04d66fcd98
Content-Type: application/octet-stream; name="pci_dev_bus_ref.patch"
Content-Disposition: attachment; filename="pci_dev_bus_ref.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hdjmgwqs0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCmlu
ZGV4IGI0OTQwNjYuLjZkZjU0MjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMKKysr
IGIvZHJpdmVycy9wY2kvcHJvYmUuYwpAQCAtMTMzNyw2ICsxMzM3LDcgQEAgdm9pZCBwY2lfZGV2
aWNlX2FkZChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBzdHJ1Y3QgcGNpX2J1cyAqYnVzKQogCSAqLwog
CWRvd25fd3JpdGUoJnBjaV9idXNfc2VtKTsKIAlsaXN0X2FkZF90YWlsKCZkZXYtPmJ1c19saXN0
LCAmYnVzLT5kZXZpY2VzKTsKKwlnZXRfZGV2aWNlKCZidXMtPmRldik7CiAJdXBfd3JpdGUoJnBj
aV9idXNfc2VtKTsKIAogCXBjaV9maXh1cF9kZXZpY2UocGNpX2ZpeHVwX2ZpbmFsLCBkZXYpOwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcmVtb3ZlLmMgYi9kcml2ZXJzL3BjaS9yZW1vdmUuYwpp
bmRleCBjYzg3NWU2Li5hNzJiNzAwIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9yZW1vdmUuYwor
KysgYi9kcml2ZXJzL3BjaS9yZW1vdmUuYwpAQCAtMzYsNiArMzYsNyBAQCBzdGF0aWMgdm9pZCBw
Y2lfZGVzdHJveV9kZXYoc3RydWN0IHBjaV9kZXYgKmRldikKIHsKIAlkb3duX3dyaXRlKCZwY2lf
YnVzX3NlbSk7CiAJbGlzdF9kZWwoJmRldi0+YnVzX2xpc3QpOworCXB1dF9kZXZpY2UoJmRldi0+
YnVzLT5kZXYpOwogCXVwX3dyaXRlKCZwY2lfYnVzX3NlbSk7CiAKIAlwY2lfZnJlZV9yZXNvdXJj
ZXMoZGV2KTsK
--bcaec5523bb6e9d06c04d66fcd98--
