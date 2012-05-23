Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48144 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab2EWHDR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 03:03:17 -0400
Received: by wibhn6 with SMTP id hn6so4289966wib.1
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 00:03:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWJcxbUvOcYf-mZYThKMogYzYUwk+w-Oc43dEU9KLA3oQ@mail.gmail.com>
References: <20120523043347.13449.1063.stgit@bhelgaas.mtv.corp.google.com>
	<20120523043511.13449.22006.stgit@bhelgaas.mtv.corp.google.com>
	<CAE9FiQVs0U62NRxkDYdOC67EUiEBu1f5ojGxGXkdbt0O6XO4uQ@mail.gmail.com>
	<CAFeW=pZiEODGx09=HaJDWujmCc92wCKt2fhZM03yNDb9CSs3gA@mail.gmail.com>
	<CAE9FiQWJcxbUvOcYf-mZYThKMogYzYUwk+w-Oc43dEU9KLA3oQ@mail.gmail.com>
Date: Wed, 23 May 2012 15:03:16 +0800
Message-ID: <CAFeW=pazkYZ9bYZ1uG3hXxSzUC5bD3nOo2KDHLir6=Q7J-O5iw@mail.gmail.com>
Subject: [PATCH v8 2/2] PCI: acpiphp: remove all functions in slot, even
 without ACPI _EJx
From: Amos Kong <kongjianjun@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	liuj97@gmail.com, qemu-devel@nongnu.org, jbarnes@virtuousgeek.org,
	kaneshige.kenji@jp.fujitsu.com
Content-Type: multipart/mixed; boundary=f46d0435c032bacba204c0aeba74
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--f46d0435c032bacba204c0aeba74
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2012 at 1:29 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, May 22, 2012 at 10:15 PM, Amos Kong <kongjianjun@gmail.com> wrote=
:
>> Attached the v7, =A0test passed.
>
> would be better to have break...

Yeah. Otherwise, it will delete from the last function.
Attached v8, test passed.


> +static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
> +{
> + =A0 =A0 =A0 struct pci_bus *bus =3D slot->bridge->pci_bus;
> + =A0 =A0 =A0 struct pci_dev *dev;
> + =A0 =A0 =A0 int ret =3D NULL;
> +
> + =A0 =A0 =A0 down_read(&pci_bus_sem);
> + =A0 =A0 =A0 list_for_each_entry(dev, &bus->devices, bus_list)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (PCI_SLOT(dev->devfn) =3D=3D slot->devic=
e)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pci_dev_get(dev);
> + =A0 =A0 =A0 up_read(&pci_bus_sem);
> +
> + =A0 =A0 =A0 return ret;
> +}
>
> =3D=3D=3D>
>
>
> +static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
> +{
> + =A0 =A0 =A0 struct pci_bus *bus =3D slot->bridge->pci_bus;
> + =A0 =A0 =A0 struct pci_dev *dev;
> + =A0 =A0 =A0 int ret =3D NULL;
> +
> + =A0 =A0 =A0 down_read(&pci_bus_sem);
> + =A0 =A0 =A0 list_for_each_entry(dev, &bus->devices, bus_list)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (PCI_SLOT(dev->devfn) =3D=3D slot->devic=
e) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pci_dev_get(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 up_read(&pci_bus_sem);
> +
> + =A0 =A0 =A0 return ret;
> +}

--f46d0435c032bacba204c0aeba74
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-PCI-acpiphp-remove-all-functions-in-slot-even-withou.patch"
Content-Disposition: attachment;
	filename="0002-PCI-acpiphp-remove-all-functions-in-slot-even-withou.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2k1omwj0

RnJvbSAzMmM0MmU4MTU2Njk4MzdlMTE0YWNiZDE0NzE1ZWI2MGJjNzQxYmJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbW9zIEtvbmcgPGtvbmdqaWFuanVuQGdtYWlsLmNvbT4KRGF0
ZTogVHVlLCAyMiBNYXkgMjAxMiAxODozNToxMSArMDAwMApTdWJqZWN0OiBbUEFUQ0ggVjggMi8y
XSBQQ0k6IGFjcGlwaHA6IHJlbW92ZSBhbGwgZnVuY3Rpb25zIGluIHNsb3QsIGV2ZW4gd2l0aG91
dCBBQ1BJIF9FSngKCldoZW4gd2UgYWRkIGEgZGV2aWNlIHdpdGggYWNwaXBocCwgd2UgZW51bWVy
YXRlIGFsbCBmdW5jdGlvbnMgaW4gdGhlCnNsb3Qgd2l0aCBwY2lfc2Nhbl9zbG90KCksIHJlZ2Fy
ZGxlc3Mgb2Ygd2hldGhlciB0aGV5IGhhdmUgYXNzb2NpYXRlZApBQ1BJIG1ldGhvZHMgc3VjaCBh
cyBfRUowLgoKV2hlbiByZW1vdmluZyB0aGUgZGV2aWNlLCB3ZSBwcmV2aW91c2x5IHJlbW92ZWQg
b25seSB0aGUgZnVuY3Rpb25zCndpdGggdGhvc2UgQUNQSSBtZXRob2RzLiAgVGhpcyBwYXRjaCBt
YWtlcyB0aGUgcmVtb3ZlIHN5bW1ldHJpYyB3aXRoIHRoZQphZGQ6IHdlIHJlbW92ZSBhbGwgZnVu
Y3Rpb25zIGluIHRoZSBzbG90LCB3aGV0aGVyIHRoZXkgaGF2ZSBhc3NvY2lhdGVkCkFDUEkgbWV0
aG9kcyBvciBub3QuCgpXaXRoIHFlbXUta3ZtIGFuZCBTZWFCSU9TLCB3ZSBjYW4gYnVpbGQgYSBt
dWx0aS1mdW5jdGlvbiBkZXZpY2Ugd2hlcmUKb25seSBmdW5jdGlvbiAwIGhhcyBfRUowIGFuZCBf
QURSIChzZWUgYnVnemlsbGEgYmVsb3cpLiAgUmVtb3ZpbmcgYW5kCnJlLWFkZGluZyB0aGF0IGRl
dmljZSB3b3JrcyBjb3JyZWN0bHkgd2l0aCBXaW5kb3dzIGd1ZXN0cy4gIFRoaXMgcGF0Y2gKbWFr
ZXMgaXQgYWxzbyB3b3JrIGluIExpbnV4IGd1ZXN0cy4KCltiaGVsZ2FhczogcmVzdHJ1Y3R1cmUg
bG9vcCBpdGVyYXRpb24sIHB1bGwgb3V0IG9mIHNsb3QtPmZ1bmNzIGxvb3BdClJlZmVyZW5jZTog
aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD00MzIxOQpTaWduZWQt
b2ZmLWJ5OiBBbW9zIEtvbmcgPGtvbmdqaWFuanVuQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTog
Qmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KCi0tLQp2Nzoga2VlcCB0aGF0IHBj
aV9idXNfc2VtIG9wZXJhdGlvbiBwYWlyIG9uIHJldHVybiBwYXRoCnY4OiBicmVhayB3aGVuIHRo
ZSBmaXJzdCBhdmFpbGFibGUgZGV2aWNlIGlzIGZvdW5kCi0tLQogZHJpdmVycy9wY2kvaG90cGx1
Zy9hY3BpcGhwX2dsdWUuYyB8ICAgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0KIDEgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvaG90cGx1Zy9hY3BpcGhwX2dsdWUuYyBiL2RyaXZlcnMv
cGNpL2hvdHBsdWcvYWNwaXBocF9nbHVlLmMKaW5kZXggMGQ4NzEzNi4uZTM3ZTczYyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9wY2kvaG90cGx1Zy9hY3BpcGhwX2dsdWUuYworKysgYi9kcml2ZXJzL3Bj
aS9ob3RwbHVnL2FjcGlwaHBfZ2x1ZS5jCkBAIC04NzgsNiArODc4LDI0IEBAIHN0YXRpYyB2b2lk
IGRpc2FibGVfYnJpZGdlcyhzdHJ1Y3QgcGNpX2J1cyAqYnVzKQogCX0KIH0KIAorLyogcmV0dXJu
IGZpcnN0IGRldmljZSBpbiBzbG90LCBhY3F1aXJpbmcgYSByZWZlcmVuY2Ugb24gaXQgKi8KK3N0
YXRpYyBzdHJ1Y3QgcGNpX2RldiAqZGV2X2luX3Nsb3Qoc3RydWN0IGFjcGlwaHBfc2xvdCAqc2xv
dCkKK3sKKwlzdHJ1Y3QgcGNpX2J1cyAqYnVzID0gc2xvdC0+YnJpZGdlLT5wY2lfYnVzOworCXN0
cnVjdCBwY2lfZGV2ICpkZXY7CisJc3RydWN0IHBjaV9kZXYgKnJldCA9IE5VTEw7CisKKwlkb3du
X3JlYWQoJnBjaV9idXNfc2VtKTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGRldiwgJmJ1cy0+ZGV2
aWNlcywgYnVzX2xpc3QpCisJCWlmIChQQ0lfU0xPVChkZXYtPmRldmZuKSA9PSBzbG90LT5kZXZp
Y2UpIHsKKwkJCXJldCA9IHBjaV9kZXZfZ2V0KGRldik7CisJCQlicmVhazsKKwkJfQorCXVwX3Jl
YWQoJnBjaV9idXNfc2VtKTsKKworCXJldHVybiByZXQ7Cit9CisKIC8qKgogICogZGlzYWJsZV9k
ZXZpY2UgLSBkaXNhYmxlIGEgc2xvdAogICogQHNsb3Q6IEFDUEkgUEhQIHNsb3QKQEAgLTkwMiwx
OCArOTIwLDIyIEBAIHN0YXRpYyBpbnQgZGlzYWJsZV9kZXZpY2Uoc3RydWN0IGFjcGlwaHBfc2xv
dCAqc2xvdCkKIAkJCQkJCSh1MzIpMSwgTlVMTCwgTlVMTCk7CiAJCQlmdW5jLT5icmlkZ2UgPSBO
VUxMOwogCQl9CisJfQogCi0JCXBkZXYgPSBwY2lfZ2V0X3Nsb3Qoc2xvdC0+YnJpZGdlLT5wY2lf
YnVzLAotCQkJCSAgICBQQ0lfREVWRk4oc2xvdC0+ZGV2aWNlLCBmdW5jLT5mdW5jdGlvbikpOwot
CQlpZiAocGRldikgewotCQkJcGNpX3N0b3BfYnVzX2RldmljZShwZGV2KTsKLQkJCWlmIChwZGV2
LT5zdWJvcmRpbmF0ZSkgewotCQkJCWRpc2FibGVfYnJpZGdlcyhwZGV2LT5zdWJvcmRpbmF0ZSk7
Ci0JCQkJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOwotCQkJfQotCQkJX19wY2lfcmVtb3ZlX2J1
c19kZXZpY2UocGRldik7Ci0JCQlwY2lfZGV2X3B1dChwZGV2KTsKKwkvKgorCSAqIGVuYWJsZV9k
ZXZpY2UoKSBlbnVtZXJhdGVzIGFsbCBmdW5jdGlvbnMgaW4gdGhpcyBkZXZpY2UgdmlhCisJICog
cGNpX3NjYW5fc2xvdCgpLCB3aGV0aGVyIHRoZXkgaGF2ZSBhc3NvY2lhdGVkIEFDUEkgaG90cGx1
ZworCSAqIG1ldGhvZHMgKF9FSjAsIGV0Yy4pIG9yIG5vdC4gIFRoZXJlZm9yZSwgd2UgcmVtb3Zl
IGFsbCBmdW5jdGlvbnMKKwkgKiBoZXJlLgorCSAqLworCXdoaWxlICgocGRldiA9IGRldl9pbl9z
bG90KHNsb3QpKSkgeworCQlwY2lfc3RvcF9idXNfZGV2aWNlKHBkZXYpOworCQlpZiAocGRldi0+
c3Vib3JkaW5hdGUpIHsKKwkJCWRpc2FibGVfYnJpZGdlcyhwZGV2LT5zdWJvcmRpbmF0ZSk7CisJ
CQlwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7CiAJCX0KKwkJX19wY2lfcmVtb3ZlX2J1c19kZXZp
Y2UocGRldik7CisJCXBjaV9kZXZfcHV0KHBkZXYpOwogCX0KIAogCWxpc3RfZm9yX2VhY2hfZW50
cnkoZnVuYywgJnNsb3QtPmZ1bmNzLCBzaWJsaW5nKSB7Ci0tIAoxLjcuMQoK
--f46d0435c032bacba204c0aeba74--
