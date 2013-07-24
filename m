Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:45279 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3GXCPt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 22:15:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUX7Dx5Z8zgx94bQ5vWTRsExarzG6WB_iuGj1jWkurc4w@mail.gmail.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<51EF3570.7030608@huawei.com>
	<CAE9FiQUX7Dx5Z8zgx94bQ5vWTRsExarzG6WB_iuGj1jWkurc4w@mail.gmail.com>
Date: Tue, 23 Jul 2013 19:15:48 -0700
Message-ID: <CAE9FiQVBfx_nyyna-9Xn+769fqqmMMMiNUwcacf4dA1iaZj6jw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix hotplug remove with sriov again
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: multipart/mixed; boundary=90e6ba6e901cf2439a04e2387c2b
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--90e6ba6e901cf2439a04e2387c2b
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jul 23, 2013 at 7:04 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jul 23, 2013 at 7:01 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Hi Yinghai,
>>    It seems to have the the same problem in acpiphp,
>>
>> diable_device(..):
>>
>>         while ((pdev = dev_in_slot(slot))) {
>>                 pci_stop_and_remove_bus_device(pdev);
>>                 pci_dev_put(pdev);
>>         }
>>
>>
>> static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
>> {
>>         struct pci_bus *bus = slot->bridge->pci_bus;
>>         struct pci_dev *dev;
>>         struct pci_dev *ret = NULL;
>>
>>         down_read(&pci_bus_sem);
>>         list_for_each_entry(dev, &bus->devices, bus_list)
>>                 if (PCI_SLOT(dev->devfn) == slot->device) {
>>                         ret = pci_dev_get(dev);
>>                         break;
>>                 }
>>         up_read(&pci_bus_sem);
>>
>
> acpiphp is ok.
>
> dev_in_slot will restart from bus->devices again every time.

Actually I had another version to fix the problem, but I did not even
try to compile
and to test it after i figured out that mlx4_core like to VF get stopped before
PF's driver.

Thanks

Yinghai

--90e6ba6e901cf2439a04e2387c2b
Content-Type: application/octet-stream; name="fix_cx3_hotplug_1x.patch"
Content-Disposition: attachment; filename="fix_cx3_hotplug_1x.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjhweggi0

LS0tCiBkcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9wY2kuYyB8ICAgMjEgKysrKysrKysrKysr
KysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfcGNpLmMKPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfcGNp
LmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9wY2kuYwpAQCAtNzYs
MTIgKzc2LDI4IEBAIGludCBwY2llaHBfY29uZmlndXJlX2RldmljZShzdHJ1Y3Qgc2xvdAogCXJl
dHVybiAwOwogfQogCisvKiByZXR1cm4gb25lIGRldmljZSBvbiBidXMsIGFjcXVpcmluZyBhIHJl
ZmVyZW5jZSBvbiBpdCAqLworc3RhdGljIHN0cnVjdCBwY2lfZGV2ICpvbmVfZGV2X29uX2J1cyhz
dHJ1Y3QgcGNpX2J1cyAqYnVzKQoreworCXN0cnVjdCBwY2lfZGV2ICpkZXY7CisJc3RydWN0IHBj
aV9kZXYgKnJldCA9IE5VTEw7CisKKwlkb3duX3JlYWQoJnBjaV9idXNfc2VtKTsKKwlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGRldiwgJmJ1cy0+ZGV2aWNlcywgYnVzX2xpc3QpIHsKKwkJcmV0ID0gcGNp
X2Rldl9nZXQoZGV2KTsKKwkJYnJlYWs7CisJfQorCXVwX3JlYWQoJnBjaV9idXNfc2VtKTsKKwor
CXJldHVybiByZXQ7Cit9CisKIGludCBwY2llaHBfdW5jb25maWd1cmVfZGV2aWNlKHN0cnVjdCBz
bG90ICpwX3Nsb3QpCiB7CiAJaW50IHJldCwgcmMgPSAwOwogCXU4IGJjdGwgPSAwOwogCXU4IHBy
ZXNlbmNlID0gMDsKLQlzdHJ1Y3QgcGNpX2RldiAqZGV2LCAqdGVtcDsKKwlzdHJ1Y3QgcGNpX2Rl
diAqZGV2OwogCXN0cnVjdCBwY2lfYnVzICpwYXJlbnQgPSBwX3Nsb3QtPmN0cmwtPnBjaWUtPnBv
cnQtPnN1Ym9yZGluYXRlOwogCXUxNiBjb21tYW5kOwogCXN0cnVjdCBjb250cm9sbGVyICpjdHJs
ID0gcF9zbG90LT5jdHJsOwpAQCAtOTIsOCArMTA4LDcgQEAgaW50IHBjaWVocF91bmNvbmZpZ3Vy
ZV9kZXZpY2Uoc3RydWN0IHNsbwogCWlmIChyZXQpCiAJCXByZXNlbmNlID0gMDsKIAotCWxpc3Rf
Zm9yX2VhY2hfZW50cnlfc2FmZShkZXYsIHRlbXAsICZwYXJlbnQtPmRldmljZXMsIGJ1c19saXN0
KSB7Ci0JCXBjaV9kZXZfZ2V0KGRldik7CisJd2hpbGUgKGRldiA9IG9uZV9kZXZfb25fYnVzKHBh
cmVudCkpIHsKIAkJaWYgKGRldi0+aGRyX3R5cGUgPT0gUENJX0hFQURFUl9UWVBFX0JSSURHRSAm
JiBwcmVzZW5jZSkgewogCQkJcGNpX3JlYWRfY29uZmlnX2J5dGUoZGV2LCBQQ0lfQlJJREdFX0NP
TlRST0wsICZiY3RsKTsKIAkJCWlmIChiY3RsICYgUENJX0JSSURHRV9DVExfVkdBKSB7Cg==
--90e6ba6e901cf2439a04e2387c2b--
