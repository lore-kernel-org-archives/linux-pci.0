Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57114 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab1LFSJf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2011 13:09:35 -0500
Received: by faar15 with SMTP id r15so11259faa.19
        for <linux-pci@vger.kernel.org>; Tue, 06 Dec 2011 10:09:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111028222743.30729.97632.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com> <20111028222743.30729.97632.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 6 Dec 2011 11:09:11 -0700
Message-ID: <CAErSpo4y4A7SXEhB087hNxUSoW18BvjKD5StmPTUgC5uErubgw@mail.gmail.com>
Subject: Re: [PATCH v3 26/34] powerpc/PCI: convert to pci_create_root_bus()
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary=f46d04447e1f5d44b604b37056b3
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--f46d04447e1f5d44b604b37056b3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2011 at 4:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Convert from pci_create_bus() to pci_create_root_bus(). =A0This way the r=
oot
> bus resources are correct immediately. =A0This patch doesn't fix a proble=
m
> because powerpc fixed the resources before scanning the bus, but it makes
> powerpc more consistent with other architectures.
>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> =A0arch/powerpc/kernel/pci-common.c | =A0 25 ++++++++++++++-----------
> =A01 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-c=
ommon.c
> index 942ced2..8c47c57 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1554,14 +1554,13 @@ int pcibios_enable_device(struct pci_dev *dev, in=
t mask)
> =A0 =A0 =A0 =A0return pci_enable_resources(dev, mask);
> =A0}
>
> -static void __devinit pcibios_setup_phb_resources(struct pci_controller =
*hose)
> +static void __devinit pcibios_setup_phb_resources(struct pci_controller =
*hose, struct list_head *resources)
> =A0{
> - =A0 =A0 =A0 struct pci_bus *bus =3D hose->bus;
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0/* Hookup PHB IO resource */
> - =A0 =A0 =A0 bus->resource[0] =3D res =3D &hose->io_resource;
> + =A0 =A0 =A0 res =3D &hose->io_resource;
>
> =A0 =A0 =A0 =A0if (!res->flags) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING "PCI: I/O resource not=
 set for host"
> @@ -1579,6 +1578,7 @@ static void __devinit pcibios_setup_phb_resources(s=
truct pci_controller *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res->start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res->end,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)res->flags);
> + =A0 =A0 =A0 pci_add_resource(resources, res);
>
> =A0 =A0 =A0 =A0/* Hookup PHB Memory resources */
> =A0 =A0 =A0 =A0for (i =3D 0; i < 3; ++i) {
> @@ -1596,12 +1596,12 @@ static void __devinit pcibios_setup_phb_resources=
(struct pci_controller *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->flags =3D IORESOURCE_=
MEM;
> =A0#endif /* CONFIG_PPC32 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->resource[i+1] =3D res;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("PCI: PHB MEM resource %d =3D %01=
6llx-%016llx [%lx]\n", i,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res->=
start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res->=
end,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)res->flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(resources, res);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0pr_debug("PCI: PHB MEM offset =A0 =A0 =3D %016llx\n",
> @@ -1695,6 +1695,7 @@ struct device_node *pcibios_get_phb_of_node(struct =
pci_bus *bus)
> =A0*/
> =A0void __devinit pcibios_scan_phb(struct pci_controller *hose)
> =A0{
> + =A0 =A0 =A0 LIST_HEAD(resources);
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> =A0 =A0 =A0 =A0struct device_node *node =3D hose->dn;
> =A0 =A0 =A0 =A0int mode;
> @@ -1702,22 +1703,24 @@ void __devinit pcibios_scan_phb(struct pci_contro=
ller *hose)
> =A0 =A0 =A0 =A0pr_debug("PCI: Scanning PHB %s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node ? node->full_name : "<NO NAME>");
>
> + =A0 =A0 =A0 /* Get some IO space for the new PHB */
> + =A0 =A0 =A0 pcibios_setup_phb_io_space(hose);
> +
> + =A0 =A0 =A0 /* Wire up PHB bus resources */
> + =A0 =A0 =A0 pcibios_setup_phb_resources(hose, &resources);
> +
> =A0 =A0 =A0 =A0/* Create an empty bus for the toplevel */
> - =A0 =A0 =A0 bus =3D pci_create_bus(hose->parent, hose->first_busno, hos=
e->ops, hose);
> + =A0 =A0 =A0 bus =3D pci_create_root_bus(hose->parent, hose->first_busno=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->o=
ps, hose, resources);

Typo here ("resources" should be "&resources") broke the build,
corrected patch attached.  (Also available
at git://github.com/bjorn-helgaas/linux.git on the "pci-scan-v4"
branch as 481c96ef546fd0a1ebd9254771f24d136aaff7cc)

--f46d04447e1f5d44b604b37056b3
Content-Type: application/octet-stream;
	name="patch.convert-to-pci_create_root_bus"
Content-Disposition: attachment;
	filename="patch.convert-to-pci_create_root_bus"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gvv83qok0

Y29tbWl0IDQ4MWM5NmVmNTQ2ZmQwYTFlYmQ5MjU0NzcxZjI0ZDEzNmFhZmY3Y2MKQXV0aG9yOiBC
am9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgpEYXRlOiAgIE1vbiBPY3QgMTAgMTY6
MTc6NDYgMjAxMSAtMDYwMAoKICAgIHBvd2VycGMvUENJOiBjb252ZXJ0IHRvIHBjaV9jcmVhdGVf
cm9vdF9idXMoKQogICAgCiAgICBDb252ZXJ0IGZyb20gcGNpX2NyZWF0ZV9idXMoKSB0byBwY2lf
Y3JlYXRlX3Jvb3RfYnVzKCkuICBUaGlzIHdheSB0aGUgcm9vdAogICAgYnVzIHJlc291cmNlcyBh
cmUgY29ycmVjdCBpbW1lZGlhdGVseS4gIFRoaXMgcGF0Y2ggZG9lc24ndCBmaXggYSBwcm9ibGVt
CiAgICBiZWNhdXNlIHBvd2VycGMgZml4ZWQgdGhlIHJlc291cmNlcyBiZWZvcmUgc2Nhbm5pbmcg
dGhlIGJ1cywgYnV0IGl0IG1ha2VzCiAgICBwb3dlcnBjIG1vcmUgY29uc2lzdGVudCB3aXRoIG90
aGVyIGFyY2hpdGVjdHVyZXMuCiAgICAKICAgIENDOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxi
ZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+CiAgICBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFz
IDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgoKZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwv
cGNpLWNvbW1vbi5jIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2ktY29tbW9uLmMKaW5kZXggMjQ4
Yjc4OC4uMmFhNzA3YiAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2ktY29tbW9u
LmMKKysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2ktY29tbW9uLmMKQEAgLTE1NTUsMTQgKzE1
NTUsMTMgQEAgaW50IHBjaWJpb3NfZW5hYmxlX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBp
bnQgbWFzaykKIAlyZXR1cm4gcGNpX2VuYWJsZV9yZXNvdXJjZXMoZGV2LCBtYXNrKTsKIH0KIAot
c3RhdGljIHZvaWQgX19kZXZpbml0IHBjaWJpb3Nfc2V0dXBfcGhiX3Jlc291cmNlcyhzdHJ1Y3Qg
cGNpX2NvbnRyb2xsZXIgKmhvc2UpCitzdGF0aWMgdm9pZCBfX2RldmluaXQgcGNpYmlvc19zZXR1
cF9waGJfcmVzb3VyY2VzKHN0cnVjdCBwY2lfY29udHJvbGxlciAqaG9zZSwgc3RydWN0IGxpc3Rf
aGVhZCAqcmVzb3VyY2VzKQogewotCXN0cnVjdCBwY2lfYnVzICpidXMgPSBob3NlLT5idXM7CiAJ
c3RydWN0IHJlc291cmNlICpyZXM7CiAJaW50IGk7CiAKIAkvKiBIb29rdXAgUEhCIElPIHJlc291
cmNlICovCi0JYnVzLT5yZXNvdXJjZVswXSA9IHJlcyA9ICZob3NlLT5pb19yZXNvdXJjZTsKKwly
ZXMgPSAmaG9zZS0+aW9fcmVzb3VyY2U7CiAKIAlpZiAoIXJlcy0+ZmxhZ3MpIHsKIAkJcHJpbnRr
KEtFUk5fV0FSTklORyAiUENJOiBJL08gcmVzb3VyY2Ugbm90IHNldCBmb3IgaG9zdCIKQEAgLTE1
ODAsNiArMTU3OSw3IEBAIHN0YXRpYyB2b2lkIF9fZGV2aW5pdCBwY2liaW9zX3NldHVwX3BoYl9y
ZXNvdXJjZXMoc3RydWN0IHBjaV9jb250cm9sbGVyICpob3NlKQogCQkgKHVuc2lnbmVkIGxvbmcg
bG9uZylyZXMtPnN0YXJ0LAogCQkgKHVuc2lnbmVkIGxvbmcgbG9uZylyZXMtPmVuZCwKIAkJICh1
bnNpZ25lZCBsb25nKXJlcy0+ZmxhZ3MpOworCXBjaV9hZGRfcmVzb3VyY2UocmVzb3VyY2VzLCBy
ZXMpOwogCiAJLyogSG9va3VwIFBIQiBNZW1vcnkgcmVzb3VyY2VzICovCiAJZm9yIChpID0gMDsg
aSA8IDM7ICsraSkgewpAQCAtMTU5NywxMiArMTU5NywxMiBAQCBzdGF0aWMgdm9pZCBfX2Rldmlu
aXQgcGNpYmlvc19zZXR1cF9waGJfcmVzb3VyY2VzKHN0cnVjdCBwY2lfY29udHJvbGxlciAqaG9z
ZSkKIAkJCXJlcy0+ZmxhZ3MgPSBJT1JFU09VUkNFX01FTTsKICNlbmRpZiAvKiBDT05GSUdfUFBD
MzIgKi8KIAkJfQotCQlidXMtPnJlc291cmNlW2krMV0gPSByZXM7CiAKIAkJcHJfZGVidWcoIlBD
STogUEhCIE1FTSByZXNvdXJjZSAlZCA9ICUwMTZsbHgtJTAxNmxseCBbJWx4XVxuIiwgaSwKIAkJ
CSAodW5zaWduZWQgbG9uZyBsb25nKXJlcy0+c3RhcnQsCiAJCQkgKHVuc2lnbmVkIGxvbmcgbG9u
ZylyZXMtPmVuZCwKIAkJCSAodW5zaWduZWQgbG9uZylyZXMtPmZsYWdzKTsKKwkJcGNpX2FkZF9y
ZXNvdXJjZShyZXNvdXJjZXMsIHJlcyk7CiAJfQogCiAJcHJfZGVidWcoIlBDSTogUEhCIE1FTSBv
ZmZzZXQgICAgID0gJTAxNmxseFxuIiwKQEAgLTE2OTYsNiArMTY5Niw3IEBAIHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqcGNpYmlvc19nZXRfcGhiX29mX25vZGUoc3RydWN0IHBjaV9idXMgKmJ1cykKICAq
Lwogdm9pZCBfX2RldmluaXQgcGNpYmlvc19zY2FuX3BoYihzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIg
Kmhvc2UpCiB7CisJTElTVF9IRUFEKHJlc291cmNlcyk7CiAJc3RydWN0IHBjaV9idXMgKmJ1czsK
IAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBob3NlLT5kbjsKIAlpbnQgbW9kZTsKQEAgLTE3
MDMsMjIgKzE3MDQsMjQgQEAgdm9pZCBfX2RldmluaXQgcGNpYmlvc19zY2FuX3BoYihzdHJ1Y3Qg
cGNpX2NvbnRyb2xsZXIgKmhvc2UpCiAJcHJfZGVidWcoIlBDSTogU2Nhbm5pbmcgUEhCICVzXG4i
LAogCQkgbm9kZSA/IG5vZGUtPmZ1bGxfbmFtZSA6ICI8Tk8gTkFNRT4iKTsKIAorCS8qIEdldCBz
b21lIElPIHNwYWNlIGZvciB0aGUgbmV3IFBIQiAqLworCXBjaWJpb3Nfc2V0dXBfcGhiX2lvX3Nw
YWNlKGhvc2UpOworCisJLyogV2lyZSB1cCBQSEIgYnVzIHJlc291cmNlcyAqLworCXBjaWJpb3Nf
c2V0dXBfcGhiX3Jlc291cmNlcyhob3NlLCAmcmVzb3VyY2VzKTsKKwogCS8qIENyZWF0ZSBhbiBl
bXB0eSBidXMgZm9yIHRoZSB0b3BsZXZlbCAqLwotCWJ1cyA9IHBjaV9jcmVhdGVfYnVzKGhvc2Ut
PnBhcmVudCwgaG9zZS0+Zmlyc3RfYnVzbm8sIGhvc2UtPm9wcywgaG9zZSk7CisJYnVzID0gcGNp
X2NyZWF0ZV9yb290X2J1cyhob3NlLT5wYXJlbnQsIGhvc2UtPmZpcnN0X2J1c25vLAorCQkJCSAg
aG9zZS0+b3BzLCBob3NlLCAmcmVzb3VyY2VzKTsKIAlpZiAoYnVzID09IE5VTEwpIHsKIAkJcHJf
ZXJyKCJGYWlsZWQgdG8gY3JlYXRlIGJ1cyBmb3IgUENJIGRvbWFpbiAlMDR4XG4iLAogCQkJaG9z
ZS0+Z2xvYmFsX251bWJlcik7CisJCXBjaV9mcmVlX3Jlc291cmNlX2xpc3QoJnJlc291cmNlcyk7
CiAJCXJldHVybjsKIAl9CiAJYnVzLT5zZWNvbmRhcnkgPSBob3NlLT5maXJzdF9idXNubzsKIAlo
b3NlLT5idXMgPSBidXM7CiAKLQkvKiBHZXQgc29tZSBJTyBzcGFjZSBmb3IgdGhlIG5ldyBQSEIg
Ki8KLQlwY2liaW9zX3NldHVwX3BoYl9pb19zcGFjZShob3NlKTsKLQotCS8qIFdpcmUgdXAgUEhC
IGJ1cyByZXNvdXJjZXMgKi8KLQlwY2liaW9zX3NldHVwX3BoYl9yZXNvdXJjZXMoaG9zZSk7Ci0K
IAkvKiBHZXQgcHJvYmUgbW9kZSBhbmQgcGVyZm9ybSBzY2FuICovCiAJbW9kZSA9IFBDSV9QUk9C
RV9OT1JNQUw7CiAJaWYgKG5vZGUgJiYgcHBjX21kLnBjaV9wcm9iZV9tb2RlKQo=
--f46d04447e1f5d44b604b37056b3--
