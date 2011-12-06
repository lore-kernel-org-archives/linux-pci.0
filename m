Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20111028222738.30729.96314.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com> <20111028222738.30729.96314.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 6 Dec 2011 11:07:16 -0700
Message-ID: <CAErSpo5MAN5V5EznrDDMgL-WDeHCbQpn7wQU3A7oxckzJhCkAg@mail.gmail.com>
Subject: Re: [PATCH v3 25/34] powerpc/PCI: split PHB part out of pcibios_map_io_space()
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary=00151744868681944804b3704fb0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--00151744868681944804b3704fb0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2011 at 4:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> No functional change. =A0This is so we can use pcibios_phb_map_io_space()
> before we have a struct pci_bus.
>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> =A0arch/powerpc/kernel/pci_64.c | =A0 40 +++++++++++++++++++++-----------=
--------
> =A01 files changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index ab34046..4401425 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -130,30 +130,13 @@ EXPORT_SYMBOL_GPL(pcibios_unmap_io_space);
>
> =A0#endif /* CONFIG_HOTPLUG */
>
> -int __devinit pcibios_map_io_space(struct pci_bus *bus)
> +static int __devinit pcibios_map_phb_io_space(struct pci_controller *hos=
e)
> =A0{
> =A0 =A0 =A0 =A0struct vm_struct *area;
> =A0 =A0 =A0 =A0unsigned long phys_page;
> =A0 =A0 =A0 =A0unsigned long size_page;
> =A0 =A0 =A0 =A0unsigned long io_virt_offset;
> - =A0 =A0 =A0 struct pci_controller *hose;
> -
> - =A0 =A0 =A0 WARN_ON(bus =3D=3D NULL);
> -
> - =A0 =A0 =A0 /* If this not a PHB, nothing to do, page tables still exis=
t and
> - =A0 =A0 =A0 =A0* thus HPTEs will be faulted in when needed
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (bus->self) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("IO mapping for PCI-PCI bridge %s\=
n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_name(bus->self));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(" =A0virt=3D0x%016llx...0x%016llx\=
n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus->resource[0]->start =
+ _IO_BASE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus->resource[0]->end + =
_IO_BASE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 /* Get the host bridge */
> - =A0 =A0 =A0 hose =3D pci_bus_to_host(bus);
> =A0 =A0 =A0 =A0phys_page =3D _ALIGN_DOWN(hose->io_base_phys, PAGE_SIZE);
> =A0 =A0 =A0 =A0size_page =3D _ALIGN_UP(hose->pci_io_size, PAGE_SIZE);
>
> @@ -197,11 +180,30 @@ int __devinit pcibios_map_io_space(struct pci_bus *=
bus)
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +
> +int __devinit pcibios_map_io_space(struct pci_bus *bus)
> +{
> + =A0 =A0 =A0 WARN_ON(bus =3D=3D NULL);
> +
> + =A0 =A0 =A0 /* If this not a PHB, nothing to do, page tables still exis=
t and
> + =A0 =A0 =A0 =A0* thus HPTEs will be faulted in when needed
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (bus->self) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("IO mapping for PCI-PCI bridge %s\=
n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_name(bus->self));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(" =A0virt=3D0x%016llx...0x%016llx\=
n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus->resource[0]->start =
+ _IO_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus->resource[0]->end + =
_IO_BASE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return pcibios_phb_map_phb_io_space(pci_bus_to_host(bus));

Typo here broke the build, corrected patch attached.  (Also available
at git://github.com/bjorn-helgaas/linux.git on the "pci-scan-v4"
branch as b6550f8d5a6470dd113249c00eacc922f9062450)

--00151744868681944804b3704fb0
Content-Type: application/octet-stream; name="patch.split-phb-part-out"
Content-Disposition: attachment; filename="patch.split-phb-part-out"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gvv812dh0

Y29tbWl0IGI2NTUwZjhkNWE2NDcwZGQxMTMyNDljMDBlYWNjOTIyZjkwNjI0NTAKQXV0aG9yOiBC
am9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgpEYXRlOiAgIE1vbiBPY3QgMTAgMTY6
MTc6MjMgMjAxMSAtMDYwMAoKICAgIHBvd2VycGMvUENJOiBzcGxpdCBQSEIgcGFydCBvdXQgb2Yg
cGNpYmlvc19tYXBfaW9fc3BhY2UoKQogICAgCiAgICBObyBmdW5jdGlvbmFsIGNoYW5nZS4gIFRo
aXMgaXMgc28gd2UgY2FuIHVzZSBwY2liaW9zX3BoYl9tYXBfaW9fc3BhY2UoKQogICAgYmVmb3Jl
IHdlIGhhdmUgYSBzdHJ1Y3QgcGNpX2J1cy4KICAgIAogICAgQ0M6IEJlbmphbWluIEhlcnJlbnNj
aG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4KICAgIFNpZ25lZC1vZmYtYnk6IEJqb3Ju
IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+CgpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBj
L2tlcm5lbC9wY2lfNjQuYyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvcGNpXzY0LmMKaW5kZXggYmNm
NGJmOS4uMzMxOGQzOSAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2lfNjQuYwor
KysgYi9hcmNoL3Bvd2VycGMva2VybmVsL3BjaV82NC5jCkBAIC0xMzEsMzAgKzEzMSwxMyBAQCBF
WFBPUlRfU1lNQk9MX0dQTChwY2liaW9zX3VubWFwX2lvX3NwYWNlKTsKIAogI2VuZGlmIC8qIENP
TkZJR19IT1RQTFVHICovCiAKLWludCBfX2RldmluaXQgcGNpYmlvc19tYXBfaW9fc3BhY2Uoc3Ry
dWN0IHBjaV9idXMgKmJ1cykKK3N0YXRpYyBpbnQgX19kZXZpbml0IHBjaWJpb3NfbWFwX3BoYl9p
b19zcGFjZShzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2UpCiB7CiAJc3RydWN0IHZtX3N0cnVj
dCAqYXJlYTsKIAl1bnNpZ25lZCBsb25nIHBoeXNfcGFnZTsKIAl1bnNpZ25lZCBsb25nIHNpemVf
cGFnZTsKIAl1bnNpZ25lZCBsb25nIGlvX3ZpcnRfb2Zmc2V0OwotCXN0cnVjdCBwY2lfY29udHJv
bGxlciAqaG9zZTsKLQotCVdBUk5fT04oYnVzID09IE5VTEwpOwotCi0JLyogSWYgdGhpcyBub3Qg
YSBQSEIsIG5vdGhpbmcgdG8gZG8sIHBhZ2UgdGFibGVzIHN0aWxsIGV4aXN0IGFuZAotCSAqIHRo
dXMgSFBURXMgd2lsbCBiZSBmYXVsdGVkIGluIHdoZW4gbmVlZGVkCi0JICovCi0JaWYgKGJ1cy0+
c2VsZikgewotCQlwcl9kZWJ1ZygiSU8gbWFwcGluZyBmb3IgUENJLVBDSSBicmlkZ2UgJXNcbiIs
Ci0JCQkgcGNpX25hbWUoYnVzLT5zZWxmKSk7Ci0JCXByX2RlYnVnKCIgIHZpcnQ9MHglMDE2bGx4
Li4uMHglMDE2bGx4XG4iLAotCQkJIGJ1cy0+cmVzb3VyY2VbMF0tPnN0YXJ0ICsgX0lPX0JBU0Us
Ci0JCQkgYnVzLT5yZXNvdXJjZVswXS0+ZW5kICsgX0lPX0JBU0UpOwotCQlyZXR1cm4gMDsKLQl9
CiAKLQkvKiBHZXQgdGhlIGhvc3QgYnJpZGdlICovCi0JaG9zZSA9IHBjaV9idXNfdG9faG9zdChi
dXMpOwogCXBoeXNfcGFnZSA9IF9BTElHTl9ET1dOKGhvc2UtPmlvX2Jhc2VfcGh5cywgUEFHRV9T
SVpFKTsKIAlzaXplX3BhZ2UgPSBfQUxJR05fVVAoaG9zZS0+cGNpX2lvX3NpemUsIFBBR0VfU0la
RSk7CiAKQEAgLTE5OCwxMSArMTgxLDMwIEBAIGludCBfX2RldmluaXQgcGNpYmlvc19tYXBfaW9f
c3BhY2Uoc3RydWN0IHBjaV9idXMgKmJ1cykKIAogCXJldHVybiAwOwogfQorCitpbnQgX19kZXZp
bml0IHBjaWJpb3NfbWFwX2lvX3NwYWNlKHN0cnVjdCBwY2lfYnVzICpidXMpCit7CisJV0FSTl9P
TihidXMgPT0gTlVMTCk7CisKKwkvKiBJZiB0aGlzIG5vdCBhIFBIQiwgbm90aGluZyB0byBkbywg
cGFnZSB0YWJsZXMgc3RpbGwgZXhpc3QgYW5kCisJICogdGh1cyBIUFRFcyB3aWxsIGJlIGZhdWx0
ZWQgaW4gd2hlbiBuZWVkZWQKKwkgKi8KKwlpZiAoYnVzLT5zZWxmKSB7CisJCXByX2RlYnVnKCJJ
TyBtYXBwaW5nIGZvciBQQ0ktUENJIGJyaWRnZSAlc1xuIiwKKwkJCSBwY2lfbmFtZShidXMtPnNl
bGYpKTsKKwkJcHJfZGVidWcoIiAgdmlydD0weCUwMTZsbHguLi4weCUwMTZsbHhcbiIsCisJCQkg
YnVzLT5yZXNvdXJjZVswXS0+c3RhcnQgKyBfSU9fQkFTRSwKKwkJCSBidXMtPnJlc291cmNlWzBd
LT5lbmQgKyBfSU9fQkFTRSk7CisJCXJldHVybiAwOworCX0KKworCXJldHVybiBwY2liaW9zX21h
cF9waGJfaW9fc3BhY2UocGNpX2J1c190b19ob3N0KGJ1cykpOworfQogRVhQT1JUX1NZTUJPTF9H
UEwocGNpYmlvc19tYXBfaW9fc3BhY2UpOwogCiB2b2lkIF9fZGV2aW5pdCBwY2liaW9zX3NldHVw
X3BoYl9pb19zcGFjZShzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2UpCiB7Ci0JcGNpYmlvc19t
YXBfaW9fc3BhY2UoaG9zZS0+YnVzKTsKKwlwY2liaW9zX21hcF9waGJfaW9fc3BhY2UoaG9zZSk7
CiB9CiAKICNkZWZpbmUgSU9CQVNFX0JSSURHRV9OVU1CRVIJMAo=
--00151744868681944804b3704fb0--
