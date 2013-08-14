Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:56393 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933081Ab3HNUPg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 16:15:36 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so12517760obb.18
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2013 13:15:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5uYciz4dZtf6utfehXGnooRAT3BcVHyz+EoZ4m7tbitg@mail.gmail.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
	<20130807040112.GA14662@google.com>
	<CAE9FiQVXhg299RKsoa8eCqoN7b9c0HaeTGHCnxQY=9vkSYaJJg@mail.gmail.com>
	<CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
	<20130809170404.GA29690@google.com>
	<CAE9FiQXuNPfhndRAm7uX4phvVqqVsQuuEzEqEi8at9f2oWPYOg@mail.gmail.com>
	<CAErSpo5uYciz4dZtf6utfehXGnooRAT3BcVHyz+EoZ4m7tbitg@mail.gmail.com>
Date: Wed, 14 Aug 2013 13:15:35 -0700
Message-ID: <CAE9FiQULOCz3snO26EHy_dumRULyOT34_iEjM_rZeP=pH8KGvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Content-Type: multipart/mixed; boundary=047d7b6700c9300dce04e3ee0541
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7b6700c9300dce04e3ee0541
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 14, 2013 at 12:44 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Don]
>
> On Fri, Aug 9, 2013 at 5:44 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Aug 9, 2013 at 10:04 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>>> What would happen if we just reverted dc087f2f6a2 for now?  Jiang?
>
> I tried to reproduce the problem you reported ("Cannot add device at
> 0000:02:00"), but I haven't been able to.  I have an ixgbe SR-IOV
> device in an external hotplug-capable chassis, and I'm using v3.11-rc4
> with a patch to add a little instrumentation.  Here's what I see:
>
>     # echo -n 8 > /sys/bus/pci/devices/0000:08:00.0/sriov_numvfs
>     ixgbe 0000:08:00.0 eth1: SR-IOV enabled with 8 VFs
>     pci 0000:08:10.0: [8086:1515] type 00 class 0x020000        # VF1
>     pci 0000:08:10.2: [8086:1515] type 00 class 0x020000        # VF2
>     ...
>     pci 0000:08:11.6: [8086:1515] type 00 class 0x020000        # VF8
>
> Created 8 VFs; no problem there.
>
>     # echo -n 0 > /sys/bus/pci/slots/4-1/power
>     pciehp 0000:04:03.0:pcie24: disable_slot: physical_slot = 4-1
>     pciehp 0000:04:03.0:pcie24: pciehp_unconfigure_device:
> domain:bus:dev = 0000:08:00
>     ixgbevf 0000:08:11.6: pci_stop_and_remove_bus_device
>     pci 0000:08:11.6: pci_release_dev                   # release VF8
>     ixgbevf 0000:08:11.4: pci_stop_and_remove_bus_device
>     pci 0000:08:11.4: pci_release_dev                   # release VF7
>     ...
>     ixgbevf 0000:08:10.0: pci_stop_and_remove_bus_device
>     pci 0000:08:10.0: pci_release_dev                   # release VF1
>     ixgbe 0000:08:00.1: pci_stop_and_remove_bus_device
>     pci 0000:08:00.1: pci_release_dev                   # release PF1
>     ixgbe 0000:08:00.0: pci_stop_and_remove_bus_device  # stop/remove PF0
>                                                         # PF0 not released
>
> When I turn off power to the slot, pciehp stops and removes all the
> devices, starting with the VFs.  The PF 08:00.0 is stopped but not
> released, because we didn't call virtfn_remove(), so the reference
> held by the VFs was never released.  This is a problem.
>
>    # echo -n 1 > /sys/bus/pci/slots/4-1/power
>     pci 0000:08:00.0: [8086:1528] type 00 class 0x020000
>     pci 0000:08:00.1: [8086:1528] type 00 class 0x020000
>
> When I turn the slot back on, we find both PFs; no apparent problem there.
>
> On v3.10 (which does not contain dc087f2f6a), I see essentially the
> same thing.  The PFs are stopped before the VFs because v3.10 doesn't
> contain 29ed1f29b68, which removes devices in reverse order.  But even
> in v3.10, PF0 is stopped but not released because the VFs still hold
> references to it.  And there's no complaint when turning the slot back
> on.
>
> So we definitely have a problem: when we remove the PF, we don't
> release it correctly because we don't release the references held by
> VFs.  But this is not a regression, and doesn't seem urgent enough to
> rush something for v3.11.
>
> I think we're headed toward tearing down all VFs when removing a PF.
> Obviously, we *have* to do that when powering off the device, and I
> think we also need to do it when removing the PF driver just to keep
> all the bookkeeping sane.  I don't know how much heartburn this will
> cause Don.
>
> So tell me if you still think we need to do something for v3.11.

in your test: the PF is not get freed but it is removed for bus's device list.
so pciehp_configure_device will create new one even the old is not
really released.

Please check with attached patch, that only release that from link-list in
pci_release device. I posted it a while back.
After it get applied, you will not have chance to create new device in
pciehp_configure_device.

Thanks

Yinghai

--047d7b6700c9300dce04e3ee0541
Content-Type: application/octet-stream;
	name="fix_racing_removing_6_2_before.patch"
Content-Disposition: attachment;
	filename="fix_racing_removing_6_2_before.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkcz8l3f0

U3ViamVjdDogW1BBVENIIDIvN10gUENJOiBtb3ZlIHJlc291cmNlcyBhbmQgYnVzX2xpc3QgcmVs
ZWFzaW5nIHRvIHBjaV9yZWxlYXNlX2RldgpGcm9tOiBZaW5naGFpIEx1IDx5aW5naGFpQGtlcm5l
bC5vcmc+CgpXZSBzaG91bGQgbm90IHJlbGVhc2UgcmVzb3VyY2UgaW4gcGNpX2Rlc3Ryb3kgdGhh
dCBpcyB0b28gZWFybHkKYXMgdGhlcmUgY291bGQgYmUgc3RpbGwgb3RoZXIgdXNlIGhvbGQgcmVm
ZXJlbmNlLgoKcmVsZWFzZSB0aGVtIG9yIHJlbW92ZSBpdCBmcm9tIGJ1cyBkZXZpY2VzIGxpc3Qg
YXQgbGFzdAppbiBwY2lfcmVsZWFzZV9kZXYgaW5zdGVhZC4KClNpZ25lZC1vZmYtYnk6IFlpbmdo
YWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9wY2kvcHJvYmUuYyAgfCAg
IDIyICsrKysrKysrKysrKysrKysrKysrLS0KIGRyaXZlcnMvcGNpL3JlbW92ZS5jIHwgICAxOSAt
LS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIx
IGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9wcm9iZS5jCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvcGNpL3Byb2JlLmMKKysrIGxpbnV4LTIu
Ni9kcml2ZXJzL3BjaS9wcm9iZS5jCkBAIC0xMTUwLDYgKzExNTAsMjAgQEAgc3RhdGljIHZvaWQg
cGNpX3JlbGVhc2VfY2FwYWJpbGl0aWVzKHN0cgogCXBjaV9mcmVlX2NhcF9zYXZlX2J1ZmZlcnMo
ZGV2KTsKIH0KIAorc3RhdGljIHZvaWQgcGNpX2ZyZWVfcmVzb3VyY2VzKHN0cnVjdCBwY2lfZGV2
ICpkZXYpCit7CisJaW50IGk7CisKKwltc2lfcmVtb3ZlX3BjaV9pcnFfdmVjdG9ycyhkZXYpOwor
CisJcGNpX2NsZWFudXBfcm9tKGRldik7CisJZm9yIChpID0gMDsgaSA8IFBDSV9OVU1fUkVTT1VS
Q0VTOyBpKyspIHsKKwkJc3RydWN0IHJlc291cmNlICpyZXMgPSBkZXYtPnJlc291cmNlICsgaTsK
KwkJaWYgKHJlcy0+cGFyZW50KQorCQkJcmVsZWFzZV9yZXNvdXJjZShyZXMpOworCX0KK30KKwog
LyoqCiAgKiBwY2lfcmVsZWFzZV9kZXYgLSBmcmVlIGEgcGNpIGRldmljZSBzdHJ1Y3R1cmUgd2hl
biBhbGwgdXNlcnMgb2YgaXQgYXJlIGZpbmlzaGVkLgogICogQGRldjogZGV2aWNlIHRoYXQncyBi
ZWVuIGRpc2Nvbm5lY3RlZApAQCAtMTE1OSw5ICsxMTczLDEzIEBAIHN0YXRpYyB2b2lkIHBjaV9y
ZWxlYXNlX2NhcGFiaWxpdGllcyhzdHIKICAqLwogc3RhdGljIHZvaWQgcGNpX3JlbGVhc2VfZGV2
KHN0cnVjdCBkZXZpY2UgKmRldikKIHsKLQlzdHJ1Y3QgcGNpX2RldiAqcGNpX2RldjsKKwlzdHJ1
Y3QgcGNpX2RldiAqcGNpX2RldiA9IHRvX3BjaV9kZXYoZGV2KTsKKworCWRvd25fd3JpdGUoJnBj
aV9idXNfc2VtKTsKKwlsaXN0X2RlbCgmcGNpX2Rldi0+YnVzX2xpc3QpOworCXVwX3dyaXRlKCZw
Y2lfYnVzX3NlbSk7CisJcGNpX2ZyZWVfcmVzb3VyY2VzKHBjaV9kZXYpOwogCi0JcGNpX2RldiA9
IHRvX3BjaV9kZXYoZGV2KTsKIAlwY2lfcmVsZWFzZV9jYXBhYmlsaXRpZXMocGNpX2Rldik7CiAJ
cGNpX3JlbGVhc2Vfb2Zfbm9kZShwY2lfZGV2KTsKIAlwY2liaW9zX3JlbGVhc2VfZGV2aWNlKHBj
aV9kZXYpOwpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNpL3JlbW92ZS5jCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
LS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvcGNpL3JlbW92ZS5jCisrKyBsaW51eC0yLjYvZHJp
dmVycy9wY2kvcmVtb3ZlLmMKQEAgLTMsMjAgKzMsNiBAQAogI2luY2x1ZGUgPGxpbnV4L3BjaS1h
c3BtLmg+CiAjaW5jbHVkZSAicGNpLmgiCiAKLXN0YXRpYyB2b2lkIHBjaV9mcmVlX3Jlc291cmNl
cyhzdHJ1Y3QgcGNpX2RldiAqZGV2KQotewotCWludCBpOwotCi0gCW1zaV9yZW1vdmVfcGNpX2ly
cV92ZWN0b3JzKGRldik7Ci0KLQlwY2lfY2xlYW51cF9yb20oZGV2KTsKLQlmb3IgKGkgPSAwOyBp
IDwgUENJX05VTV9SRVNPVVJDRVM7IGkrKykgewotCQlzdHJ1Y3QgcmVzb3VyY2UgKnJlcyA9IGRl
di0+cmVzb3VyY2UgKyBpOwotCQlpZiAocmVzLT5wYXJlbnQpCi0JCQlyZWxlYXNlX3Jlc291cmNl
KHJlcyk7Ci0JfQotfQotCiBzdGF0aWMgdm9pZCBwY2lfc3RvcF9kZXYoc3RydWN0IHBjaV9kZXYg
KmRldikKIHsKIAlwY2lfcG1lX2FjdGl2ZShkZXYsIGZhbHNlKTsKQEAgLTM2LDExICsyMiw2IEBA
IHN0YXRpYyB2b2lkIHBjaV9zdG9wX2RldihzdHJ1Y3QgcGNpX2RldgogCiBzdGF0aWMgdm9pZCBw
Y2lfZGVzdHJveV9kZXYoc3RydWN0IHBjaV9kZXYgKmRldikKIHsKLQlkb3duX3dyaXRlKCZwY2lf
YnVzX3NlbSk7Ci0JbGlzdF9kZWwoJmRldi0+YnVzX2xpc3QpOwotCXVwX3dyaXRlKCZwY2lfYnVz
X3NlbSk7Ci0KLQlwY2lfZnJlZV9yZXNvdXJjZXMoZGV2KTsKIAlwdXRfZGV2aWNlKCZkZXYtPmRl
dik7CiB9CiAK
--047d7b6700c9300dce04e3ee0541--
