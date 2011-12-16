Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52301 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab1LPVYY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 16:24:24 -0500
Received: by wgbdr13 with SMTP id dr13so6875092wgb.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 13:24:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111028222611.30729.46284.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com> <20111028222611.30729.46284.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 16 Dec 2011 14:24:01 -0700
Message-ID: <CAErSpo7WHixAQL2=ptHj+JUsE8W6PTG0ZEM1T0fYQAixqjm=pQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/34] alpha/PCI: convert to pci_scan_root_bus() for
 correct root bus resources
To: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: multipart/mixed; boundary=00151747548883e99d04b43c39d5
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--00151747548883e99d04b43c39d5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2011 at 4:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Convert from pci_scan_bus() to pci_scan_root_bus() and remove root bus
> resource fixups. =A0This fixes the problem of "early" and "header" quirks
> seeing incorrect root bus resources.
>
> CC: linux-alpha@vger.kernel.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> =A0arch/alpha/kernel/pci.c | =A0 37 ++++++++++++++++++++-----------------
> =A01 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> index c9ab94e..e9e78a2 100644
> --- a/arch/alpha/kernel/pci.c
> +++ b/arch/alpha/kernel/pci.c
> @@ -286,22 +286,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
> =A0 =A0 =A0 =A0struct pci_controller *hose =3D bus->sysdata;
> =A0 =A0 =A0 =A0struct pci_dev *dev =3D bus->self;
>
> - =A0 =A0 =A0 if (!dev) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Root bus. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 pci_mem_end;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 sg_base =3D hose->sg_pci ? hose->sg_pci=
->dma_base : ~0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long end;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->resource[0] =3D hose->io_space;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->resource[1] =3D hose->mem_space;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Adjust hose mem_space limit to prevent P=
CI allocations
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in the iommu windows. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_mem_end =3D min((u32)__direct_map_base,=
 sg_base) - 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D hose->mem_space->start + pci_mem_en=
d;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hose->mem_space->end > end)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->mem_space->end =3D en=
d;
> - =A0 =A0 =A0 } else if (pci_probe_only &&
> + =A0 =A0 =A0 if (pci_probe_only && dev &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dev->class >> 8) =3D=3D PCI_CLASS_BR=
IDGE_PCI) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_read_bridge_bases(bus);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pcibios_fixup_device_resources(dev, bus);
> @@ -414,13 +399,31 @@ void __init
> =A0common_init_pci(void)
> =A0{
> =A0 =A0 =A0 =A0struct pci_controller *hose;
> + =A0 =A0 =A0 struct list_head resources;
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> =A0 =A0 =A0 =A0int next_busno;
> =A0 =A0 =A0 =A0int need_domain_info =3D 0;
> + =A0 =A0 =A0 u32 pci_mem_end;
> + =A0 =A0 =A0 u32 sg_base;
> + =A0 =A0 =A0 unsigned long end;
>
> =A0 =A0 =A0 =A0/* Scan all of the recorded PCI controllers. =A0*/
> =A0 =A0 =A0 =A0for (next_busno =3D 0, hose =3D hose_head; hose; hose =3D =
hose->next) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_scan_bus(next_busno, alpha_mv.p=
ci_ops, hose);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_base =3D hose->sg_pci ? hose->sg_pci->dm=
a_base : ~0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Adjust hose mem_space limit to prevent P=
CI allocations
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in the iommu windows. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_mem_end =3D min((u32)__direct_map_base,=
 sg_base) - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D hose->mem_space->start + pci_mem_en=
d;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hose->mem_space->end > end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->mem_space->end =3D en=
d;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&resources);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(&resources, &hose->io_spac=
e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(&resources, &hose->mem_spa=
ce);

These two lines are errors: hose->io_space is already a struct
resource pointer, so we shouldn't take the pointer's address.  Updated
patch and incremental patch attached.

Bjorn

--00151747548883e99d04b43c39d5
Content-Type: application/octet-stream;
	name="patch.alpha-pci-convert-to-pci_scan_root_bus"
Content-Disposition: attachment;
	filename="patch.alpha-pci-convert-to-pci_scan_root_bus"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gw9pgkgb0

Y29tbWl0IDRjZWJhMmZiZmQ3MmYzMzFhMjBjNjYzOGM5ZGI5MjZiOTVkYTczYjEKQXV0aG9yOiBC
am9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgpEYXRlOiAgIFR1ZSBPY3QgMTEgMTc6
MDc6NDggMjAxMSAtMDYwMAoKICAgIGFscGhhL1BDSTogY29udmVydCB0byBwY2lfc2Nhbl9yb290
X2J1cygpIGZvciBjb3JyZWN0IHJvb3QgYnVzIHJlc291cmNlcwogICAgCiAgICBDb252ZXJ0IGZy
b20gcGNpX3NjYW5fYnVzKCkgdG8gcGNpX3NjYW5fcm9vdF9idXMoKSBhbmQgcmVtb3ZlIHJvb3Qg
YnVzCiAgICByZXNvdXJjZSBmaXh1cHMuICBUaGlzIGZpeGVzIHRoZSBwcm9ibGVtIG9mICJlYXJs
eSIgYW5kICJoZWFkZXIiIHF1aXJrcwogICAgc2VlaW5nIGluY29ycmVjdCByb290IGJ1cyByZXNv
dXJjZXMuCiAgICAKICAgIENDOiBsaW51eC1hbHBoYUB2Z2VyLmtlcm5lbC5vcmcKICAgIFNpZ25l
ZC1vZmYtYnk6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+CgpkaWZmIC0tZ2l0
IGEvYXJjaC9hbHBoYS9rZXJuZWwvcGNpLmMgYi9hcmNoL2FscGhhL2tlcm5lbC9wY2kuYwppbmRl
eCBjOWFiOTRlLi5mY2I0YjkxIDEwMDY0NAotLS0gYS9hcmNoL2FscGhhL2tlcm5lbC9wY2kuYwor
KysgYi9hcmNoL2FscGhhL2tlcm5lbC9wY2kuYwpAQCAtMjgxLDI3ICsyODEsOSBAQCBwY2liaW9z
X2ZpeHVwX2RldmljZV9yZXNvdXJjZXMoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IHBjaV9i
dXMgKmJ1cykKIHZvaWQgX19kZXZpbml0CiBwY2liaW9zX2ZpeHVwX2J1cyhzdHJ1Y3QgcGNpX2J1
cyAqYnVzKQogewotCS8qIFByb3BhZ2F0ZSBob3NlIGluZm8gaW50byB0aGUgc3Vib3JkaW5hdGUg
ZGV2aWNlcy4gICovCi0KLQlzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2UgPSBidXMtPnN5c2Rh
dGE7CiAJc3RydWN0IHBjaV9kZXYgKmRldiA9IGJ1cy0+c2VsZjsKIAotCWlmICghZGV2KSB7Ci0J
CS8qIFJvb3QgYnVzLiAqLwotCQl1MzIgcGNpX21lbV9lbmQ7Ci0JCXUzMiBzZ19iYXNlID0gaG9z
ZS0+c2dfcGNpID8gaG9zZS0+c2dfcGNpLT5kbWFfYmFzZSA6IH4wOwotCQl1bnNpZ25lZCBsb25n
IGVuZDsKLQotCQlidXMtPnJlc291cmNlWzBdID0gaG9zZS0+aW9fc3BhY2U7Ci0JCWJ1cy0+cmVz
b3VyY2VbMV0gPSBob3NlLT5tZW1fc3BhY2U7Ci0KLQkJLyogQWRqdXN0IGhvc2UgbWVtX3NwYWNl
IGxpbWl0IHRvIHByZXZlbnQgUENJIGFsbG9jYXRpb25zCi0JCSAgIGluIHRoZSBpb21tdSB3aW5k
b3dzLiAqLwotCQlwY2lfbWVtX2VuZCA9IG1pbigodTMyKV9fZGlyZWN0X21hcF9iYXNlLCBzZ19i
YXNlKSAtIDE7Ci0JCWVuZCA9IGhvc2UtPm1lbV9zcGFjZS0+c3RhcnQgKyBwY2lfbWVtX2VuZDsK
LQkJaWYgKGhvc2UtPm1lbV9zcGFjZS0+ZW5kID4gZW5kKQotCQkJaG9zZS0+bWVtX3NwYWNlLT5l
bmQgPSBlbmQ7Ci0gCX0gZWxzZSBpZiAocGNpX3Byb2JlX29ubHkgJiYKKwlpZiAocGNpX3Byb2Jl
X29ubHkgJiYgZGV2ICYmCiAgCQkgICAoZGV2LT5jbGFzcyA+PiA4KSA9PSBQQ0lfQ0xBU1NfQlJJ
REdFX1BDSSkgewogIAkJcGNpX3JlYWRfYnJpZGdlX2Jhc2VzKGJ1cyk7CiAgCQlwY2liaW9zX2Zp
eHVwX2RldmljZV9yZXNvdXJjZXMoZGV2LCBidXMpOwpAQCAtNDE0LDEzICszOTYsMzEgQEAgdm9p
ZCBfX2luaXQKIGNvbW1vbl9pbml0X3BjaSh2b2lkKQogewogCXN0cnVjdCBwY2lfY29udHJvbGxl
ciAqaG9zZTsKKwlzdHJ1Y3QgbGlzdF9oZWFkIHJlc291cmNlczsKIAlzdHJ1Y3QgcGNpX2J1cyAq
YnVzOwogCWludCBuZXh0X2J1c25vOwogCWludCBuZWVkX2RvbWFpbl9pbmZvID0gMDsKKwl1MzIg
cGNpX21lbV9lbmQ7CisJdTMyIHNnX2Jhc2U7CisJdW5zaWduZWQgbG9uZyBlbmQ7CiAKIAkvKiBT
Y2FuIGFsbCBvZiB0aGUgcmVjb3JkZWQgUENJIGNvbnRyb2xsZXJzLiAgKi8KIAlmb3IgKG5leHRf
YnVzbm8gPSAwLCBob3NlID0gaG9zZV9oZWFkOyBob3NlOyBob3NlID0gaG9zZS0+bmV4dCkgewot
CQlidXMgPSBwY2lfc2Nhbl9idXMobmV4dF9idXNubywgYWxwaGFfbXYucGNpX29wcywgaG9zZSk7
CisJCXNnX2Jhc2UgPSBob3NlLT5zZ19wY2kgPyBob3NlLT5zZ19wY2ktPmRtYV9iYXNlIDogfjA7
CisKKwkJLyogQWRqdXN0IGhvc2UgbWVtX3NwYWNlIGxpbWl0IHRvIHByZXZlbnQgUENJIGFsbG9j
YXRpb25zCisJCSAgIGluIHRoZSBpb21tdSB3aW5kb3dzLiAqLworCQlwY2lfbWVtX2VuZCA9IG1p
bigodTMyKV9fZGlyZWN0X21hcF9iYXNlLCBzZ19iYXNlKSAtIDE7CisJCWVuZCA9IGhvc2UtPm1l
bV9zcGFjZS0+c3RhcnQgKyBwY2lfbWVtX2VuZDsKKwkJaWYgKGhvc2UtPm1lbV9zcGFjZS0+ZW5k
ID4gZW5kKQorCQkJaG9zZS0+bWVtX3NwYWNlLT5lbmQgPSBlbmQ7CisKKwkJSU5JVF9MSVNUX0hF
QUQoJnJlc291cmNlcyk7CisJCXBjaV9hZGRfcmVzb3VyY2UoJnJlc291cmNlcywgaG9zZS0+aW9f
c3BhY2UpOworCQlwY2lfYWRkX3Jlc291cmNlKCZyZXNvdXJjZXMsIGhvc2UtPm1lbV9zcGFjZSk7
CisKKwkJYnVzID0gcGNpX3NjYW5fcm9vdF9idXMoTlVMTCwgbmV4dF9idXNubywgYWxwaGFfbXYu
cGNpX29wcywKKwkJCQkJaG9zZSwgJnJlc291cmNlcyk7CiAJCWhvc2UtPmJ1cyA9IGJ1czsKIAkJ
aG9zZS0+bmVlZF9kb21haW5faW5mbyA9IG5lZWRfZG9tYWluX2luZm87CiAJCW5leHRfYnVzbm8g
PSBidXMtPnN1Ym9yZGluYXRlICsgMTsK
--00151747548883e99d04b43c39d5
Content-Type: application/octet-stream; name="patch.alpha-incremental"
Content-Disposition: attachment; filename="patch.alpha-incremental"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gw9pgqbw1

djI6IGZpeCByZXNvdXJjZSBwb2ludGVyIGVycm9yCgpkaWZmIC11IGIvYXJjaC9hbHBoYS9rZXJu
ZWwvcGNpLmMgYi9hcmNoL2FscGhhL2tlcm5lbC9wY2kuYwotLS0gYi9hcmNoL2FscGhhL2tlcm5l
bC9wY2kuYworKysgYi9hcmNoL2FscGhhL2tlcm5lbC9wY2kuYwpAQCAtMjgxLDkgKzI4MSw2IEBA
CiB2b2lkIF9fZGV2aW5pdAogcGNpYmlvc19maXh1cF9idXMoc3RydWN0IHBjaV9idXMgKmJ1cykK
IHsKLQkvKiBQcm9wYWdhdGUgaG9zZSBpbmZvIGludG8gdGhlIHN1Ym9yZGluYXRlIGRldmljZXMu
ICAqLwotCi0Jc3RydWN0IHBjaV9jb250cm9sbGVyICpob3NlID0gYnVzLT5zeXNkYXRhOwogCXN0
cnVjdCBwY2lfZGV2ICpkZXYgPSBidXMtPnNlbGY7CiAKIAlpZiAocGNpX3Byb2JlX29ubHkgJiYg
ZGV2ICYmCkBAIC00MTksOCArNDE2LDggQEAKIAkJCWhvc2UtPm1lbV9zcGFjZS0+ZW5kID0gZW5k
OwogCiAJCUlOSVRfTElTVF9IRUFEKCZyZXNvdXJjZXMpOwotCQlwY2lfYWRkX3Jlc291cmNlKCZy
ZXNvdXJjZXMsICZob3NlLT5pb19zcGFjZSk7Ci0JCXBjaV9hZGRfcmVzb3VyY2UoJnJlc291cmNl
cywgJmhvc2UtPm1lbV9zcGFjZSk7CisJCXBjaV9hZGRfcmVzb3VyY2UoJnJlc291cmNlcywgaG9z
ZS0+aW9fc3BhY2UpOworCQlwY2lfYWRkX3Jlc291cmNlKCZyZXNvdXJjZXMsIGhvc2UtPm1lbV9z
cGFjZSk7CiAKIAkJYnVzID0gcGNpX3NjYW5fcm9vdF9idXMoTlVMTCwgbmV4dF9idXNubywgYWxw
aGFfbXYucGNpX29wcywKIAkJCQkJaG9zZSwgJnJlc291cmNlcyk7Cg==
--00151747548883e99d04b43c39d5--
