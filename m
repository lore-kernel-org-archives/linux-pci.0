Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:60284 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3KSTbr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 14:31:47 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so2658337ieb.31
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 11:31:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1384843018-9479-2-git-send-email-yan@linux.vnet.ibm.com>
References: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
	<1384843018-9479-2-git-send-email-yan@linux.vnet.ibm.com>
Date: Tue, 19 Nov 2013 11:31:45 -0800
Message-ID: <CAE9FiQUBiocnOhdmK3n4rgmTzdtxxNP93UU+uJvZm56s3VY5GA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PCI: do not compare CPU address with PCI address
From: Yinghai Lu <yinghai@kernel.org>
To: Guo Chao <yan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: multipart/mixed; boundary=047d7bdca4300d4bbd04eb8cb7ef
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7bdca4300d4bbd04eb8cb7ef
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Nov 18, 2013 at 10:36 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> In resource assignment code, limits are exerted to restrict allocated
> resource range. However these limits are PCI address but compared to
> CPU address in the end. Translated them before comparing.
>
> We can't just use pcibios_bus_to_resource because the limits may not
> included in the host bridge window. Introduce a help function to
> do this translation, if address missed, return an approximate one.
>
> Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
> ---
>  drivers/pci/bus.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index fc1b740..532c0a4 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -99,6 +99,64 @@ void pci_bus_remove_resources(struct pci_bus *bus)
>  }
>
>  /**
> + * pci_bus_to_resource
> + *
> + * Much like pcibios_bus_to_resource() except it takes a single address
> + * and returns an approximate one if target address is not included
> + * in the bridge window. The approximate address is smaller than required
> + * one is 'bound' is 1, larger than required one if 'bound' is 0.
> + */
> +static resource_size_t pci_bus_to_resource(struct pci_bus *bus, int flags,
> +                                   int mask, resource_size_t addr, int bound)
> +{
> +       struct pci_host_bridge *bridge;
> +       struct pci_host_bridge_window *window, *match = NULL;
> +       resource_size_t max = 0, min = -1;
> +       resource_size_t offset = -1, start, end;
> +
> +       while (bus->parent)
> +               bus = bus->parent;
> +
> +       bridge = to_pci_host_bridge(bus->bridge);
> +
> +       list_for_each_entry(window, &bridge->windows, list) {
> +               if ((flags ^ window->res->flags) & mask)
> +                       continue;
> +
> +               start = window->res->start - window->offset;
> +               end = window->res->end - window->offset;
> +
> +               if (addr >= start && addr <= end) {
> +                       offset = window->offset;
> +                       break;
> +               }
> +
> +               if (bound && addr > end && end > max) {
> +                       max = end;
> +                       match = window;
> +               } else if (!bound && addr < start && start < min) {
> +                       min = start;
> +                       match = window;
> +               }
> +       }
> +
> +       if (offset == -1) {
> +               /*
> +                * Not even found the matched type. This may happen,
> +                * for example, if try to translate IO address in a HB
> +                * without IO window. Just return the original address,
> +                * it will fail later anyway.
> +                */
> +               if (match == NULL)
> +                       return addr;
> +
> +               return (bound ? max : min) + match->offset;
> +       }
> +
> +       return addr + offset;
> +}

that is confusing.

Can we use http://lkml.indiana.edu/hypermail/linux/kernel/1206.0/00437/pcibus_addr_converting_bus.patch
instead?

or as attached:

--047d7bdca4300d4bbd04eb8cb7ef
Content-Type: text/x-patch; charset=US-ASCII; name="pcibus_addr_converting_bus.patch"
Content-Disposition: attachment; filename="pcibus_addr_converting_bus.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ho7jb30a0

U3ViamVjdDogW1BBVENIXSBQQ0k6IHBjaWJ1cyBhZGRyZXNzIHRvIHJlc291cmNlIGNvbnZlcnRp
bmcgdGFrZSBidXMgZGlyZWN0bHkKCkZvciBhbGxvY2F0aW5nIHJlc291cmNlIHVuZGVyIGJ1cyBw
YXRoLCB3ZSBkbyBoYXZlIGRldiBwYXNzIGFsb25nLCBhbmQgd2UKY291bGQganVzdCB1c2UgYnVz
IGluc3RlYWQuCgpTaWduZWQtb2ZmLWJ5OiBZaW5naGFpIEx1IDx5aW5naGFpQGtlcm5lbC5vcmc+
CgotLS0KIGRyaXZlcnMvcGNpL2hvc3QtYnJpZGdlLmMgfCAgIDM0ICsrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0KIGluY2x1ZGUvbGludXgvcGNpLmggICAgICAgfCAgICAzICsrKwog
MiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKCkluZGV4
OiBsaW51eC0yLjYvZHJpdmVycy9wY2kvaG9zdC1icmlkZ2UuYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51
eC0yLjYub3JpZy9kcml2ZXJzL3BjaS9ob3N0LWJyaWRnZS5jCisrKyBsaW51eC0yLjYvZHJpdmVy
cy9wY2kvaG9zdC1icmlkZ2UuYwpAQCAtOSwyMiArOSwxOSBAQAogCiAjaW5jbHVkZSAicGNpLmgi
CiAKLXN0YXRpYyBzdHJ1Y3QgcGNpX2J1cyAqZmluZF9wY2lfcm9vdF9idXMoc3RydWN0IHBjaV9k
ZXYgKmRldikKK3N0YXRpYyBzdHJ1Y3QgcGNpX2J1cyAqZmluZF9wY2lfcm9vdF9idXMoc3RydWN0
IHBjaV9idXMgKmJ1cykKIHsKLQlzdHJ1Y3QgcGNpX2J1cyAqYnVzOwotCi0JYnVzID0gZGV2LT5i
dXM7CiAJd2hpbGUgKGJ1cy0+cGFyZW50KQogCQlidXMgPSBidXMtPnBhcmVudDsKIAogCXJldHVy
biBidXM7CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpmaW5kX3BjaV9ob3N0
X2JyaWRnZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQorc3RhdGljIHN0cnVjdCBwY2lfaG9zdF9icmlk
Z2UgKmZpbmRfcGNpX2hvc3RfYnJpZGdlKHN0cnVjdCBwY2lfYnVzICpidXMpCiB7Ci0Jc3RydWN0
IHBjaV9idXMgKmJ1cyA9IGZpbmRfcGNpX3Jvb3RfYnVzKGRldik7CisJc3RydWN0IHBjaV9idXMg
KnJvb3RfYnVzID0gZmluZF9wY2lfcm9vdF9idXMoYnVzKTsKIAotCXJldHVybiB0b19wY2lfaG9z
dF9icmlkZ2UoYnVzLT5icmlkZ2UpOworCXJldHVybiB0b19wY2lfaG9zdF9icmlkZ2Uocm9vdF9i
dXMtPmJyaWRnZSk7CiB9CiAKIHZvaWQgcGNpX3NldF9ob3N0X2JyaWRnZV9yZWxlYXNlKHN0cnVj
dCBwY2lfaG9zdF9icmlkZ2UgKmJyaWRnZSwKQEAgLTQwLDEwICszNywxMSBAQCBzdGF0aWMgYm9v
bCByZXNvdXJjZV9jb250YWlucyhzdHJ1Y3QgcmVzCiAJcmV0dXJuIHJlczEtPnN0YXJ0IDw9IHJl
czItPnN0YXJ0ICYmIHJlczEtPmVuZCA+PSByZXMyLT5lbmQ7CiB9CiAKLXZvaWQgcGNpYmlvc19y
ZXNvdXJjZV90b19idXMoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IHBjaV9idXNfcmVnaW9u
ICpyZWdpb24sCi0JCQkgICAgIHN0cnVjdCByZXNvdXJjZSAqcmVzKQordm9pZCBfX3BjaWJpb3Nf
cmVzb3VyY2VfdG9fYnVzKHN0cnVjdCBwY2lfYnVzICpidXMsCisJCQkJICAgICAgc3RydWN0IHBj
aV9idXNfcmVnaW9uICpyZWdpb24sCisJCQkJICAgICAgc3RydWN0IHJlc291cmNlICpyZXMpCiB7
Ci0Jc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlID0gZmluZF9wY2lfaG9zdF9icmlkZ2Uo
ZGV2KTsKKwlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UgPSBmaW5kX3BjaV9ob3N0X2Jy
aWRnZShidXMpOwogCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2Vfd2luZG93ICp3aW5kb3c7CiAJcmVz
b3VyY2Vfc2l6ZV90IG9mZnNldCA9IDA7CiAKQEAgLTYwLDYgKzU4LDExIEBAIHZvaWQgcGNpYmlv
c19yZXNvdXJjZV90b19idXMoc3RydWN0IHBjaV8KIAlyZWdpb24tPnN0YXJ0ID0gcmVzLT5zdGFy
dCAtIG9mZnNldDsKIAlyZWdpb24tPmVuZCA9IHJlcy0+ZW5kIC0gb2Zmc2V0OwogfQordm9pZCBw
Y2liaW9zX3Jlc291cmNlX3RvX2J1cyhzdHJ1Y3QgcGNpX2RldiAqZGV2LCBzdHJ1Y3QgcGNpX2J1
c19yZWdpb24gKnJlZ2lvbiwKKwkJCSAgICAgc3RydWN0IHJlc291cmNlICpyZXMpCit7CisJX19w
Y2liaW9zX3Jlc291cmNlX3RvX2J1cyhkZXYtPmJ1cywgcmVnaW9uLCByZXMpOworfQogRVhQT1JU
X1NZTUJPTChwY2liaW9zX3Jlc291cmNlX3RvX2J1cyk7CiAKIHN0YXRpYyBib29sIHJlZ2lvbl9j
b250YWlucyhzdHJ1Y3QgcGNpX2J1c19yZWdpb24gKnJlZ2lvbjEsCkBAIC02OCwxMCArNzEsMTAg
QEAgc3RhdGljIGJvb2wgcmVnaW9uX2NvbnRhaW5zKHN0cnVjdCBwY2lfYgogCXJldHVybiByZWdp
b24xLT5zdGFydCA8PSByZWdpb24yLT5zdGFydCAmJiByZWdpb24xLT5lbmQgPj0gcmVnaW9uMi0+
ZW5kOwogfQogCi12b2lkIHBjaWJpb3NfYnVzX3RvX3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2ICpk
ZXYsIHN0cnVjdCByZXNvdXJjZSAqcmVzLAotCQkJICAgICBzdHJ1Y3QgcGNpX2J1c19yZWdpb24g
KnJlZ2lvbikKK3N0YXRpYyB2b2lkIF9fcGNpYmlvc19idXNfdG9fcmVzb3VyY2Uoc3RydWN0IHBj
aV9idXMgKmJ1cywgc3RydWN0IHJlc291cmNlICpyZXMsCisJCQkJICAgICAgc3RydWN0IHBjaV9i
dXNfcmVnaW9uICpyZWdpb24pCiB7Ci0Jc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlID0g
ZmluZF9wY2lfaG9zdF9icmlkZ2UoZGV2KTsKKwlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlk
Z2UgPSBmaW5kX3BjaV9ob3N0X2JyaWRnZShidXMpOwogCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2Vf
d2luZG93ICp3aW5kb3c7CiAJcmVzb3VyY2Vfc2l6ZV90IG9mZnNldCA9IDA7CiAKQEAgLTkzLDQg
Kzk2LDkgQEAgdm9pZCBwY2liaW9zX2J1c190b19yZXNvdXJjZShzdHJ1Y3QgcGNpXwogCXJlcy0+
c3RhcnQgPSByZWdpb24tPnN0YXJ0ICsgb2Zmc2V0OwogCXJlcy0+ZW5kID0gcmVnaW9uLT5lbmQg
KyBvZmZzZXQ7CiB9Cit2b2lkIHBjaWJpb3NfYnVzX3RvX3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2
ICpkZXYsIHN0cnVjdCByZXNvdXJjZSAqcmVzLAorCQkJICAgICBzdHJ1Y3QgcGNpX2J1c19yZWdp
b24gKnJlZ2lvbikKK3sKKwlfX3BjaWJpb3NfYnVzX3RvX3Jlc291cmNlKGRldi0+YnVzLCByZXMs
IHJlZ2lvbik7Cit9CiBFWFBPUlRfU1lNQk9MKHBjaWJpb3NfYnVzX3RvX3Jlc291cmNlKTsKSW5k
ZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2xpbnV4L3BjaS5oCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIu
Ni5vcmlnL2luY2x1ZGUvbGludXgvcGNpLmgKKysrIGxpbnV4LTIuNi9pbmNsdWRlL2xpbnV4L3Bj
aS5oCkBAIC03OTIsNiArNzkyLDkgQEAgdm9pZCBwY2lfZml4dXBfY2FyZGJ1cyhzdHJ1Y3QgcGNp
X2J1cyAqKQogCiAvKiBHZW5lcmljIFBDSSBmdW5jdGlvbnMgdXNlZCBpbnRlcm5hbGx5ICovCiAK
K3ZvaWQgX19wY2liaW9zX3Jlc291cmNlX3RvX2J1cyhzdHJ1Y3QgcGNpX2J1cyAqYnVzLAorCQkJ
ICAgICAgIHN0cnVjdCBwY2lfYnVzX3JlZ2lvbiAqcmVnaW9uLAorCQkJICAgICAgIHN0cnVjdCBy
ZXNvdXJjZSAqcmVzKTsKIHZvaWQgcGNpYmlvc19yZXNvdXJjZV90b19idXMoc3RydWN0IHBjaV9k
ZXYgKmRldiwgc3RydWN0IHBjaV9idXNfcmVnaW9uICpyZWdpb24sCiAJCQkgICAgIHN0cnVjdCBy
ZXNvdXJjZSAqcmVzKTsKIHZvaWQgcGNpYmlvc19idXNfdG9fcmVzb3VyY2Uoc3RydWN0IHBjaV9k
ZXYgKmRldiwgc3RydWN0IHJlc291cmNlICpyZXMsCg==
--047d7bdca4300d4bbd04eb8cb7ef
Content-Type: text/x-patch; charset=US-ASCII; name="pcibus_addr_converting_bus_2.patch"
Content-Disposition: attachment;
	filename="pcibus_addr_converting_bus_2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ho7jbbc11

U3ViamVjdDogW1BBVENIXSBQQ0k6IEFkZCBwY2liaW9zX2J1c19hZGRyX3RvX3JlcygpCgppdCB0
YWtlcyBhZGRyIGFuZCByZXR1cm4gY29udmVydGVkIGFkZHJlc3Mgb25seS4KClNpZ25lZC1vZmYt
Ynk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9wY2kvaG9z
dC1icmlkZ2UuYyB8ICAgMTQgKysrKysrKysrKysrKysKIGluY2x1ZGUvbGludXgvcGNpLmggICAg
ICAgfCAgICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKCkluZGV4OiBs
aW51eC0yLjYvZHJpdmVycy9wY2kvaG9zdC1icmlkZ2UuYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0y
LjYub3JpZy9kcml2ZXJzL3BjaS9ob3N0LWJyaWRnZS5jCisrKyBsaW51eC0yLjYvZHJpdmVycy9w
Y2kvaG9zdC1icmlkZ2UuYwpAQCAtMTAyLDMgKzEwMiwxNyBAQCB2b2lkIHBjaWJpb3NfYnVzX3Rv
X3Jlc291cmNlKHN0cnVjdCBwY2lfCiAJX19wY2liaW9zX2J1c190b19yZXNvdXJjZShkZXYtPmJ1
cywgcmVzLCByZWdpb24pOwogfQogRVhQT1JUX1NZTUJPTChwY2liaW9zX2J1c190b19yZXNvdXJj
ZSk7CisKK3Jlc291cmNlX3NpemVfdCBwY2liaW9zX2J1c19hZGRyX3RvX3JlcyhzdHJ1Y3QgcGNp
X2J1cyAqYnVzLCBpbnQgZmxhZ3MsCisJCQkJCXJlc291cmNlX3NpemVfdCBhZGRyKQoreworCXN0
cnVjdCBwY2lfYnVzX3JlZ2lvbiByZWdpb247CisJc3RydWN0IHJlc291cmNlIHI7CisKKwlyLmZs
YWdzID0gZmxhZ3M7CisJcmVnaW9uLnN0YXJ0ID0gYWRkcjsKKwlyZWdpb24uZW5kID0gYWRkcjsK
KwlfX3BjaWJpb3NfYnVzX3RvX3Jlc291cmNlKGJ1cywgJnIsICZyZWdpb24pOworCisJcmV0dXJu
IHIuZW5kOworfQpJbmRleDogbGludXgtMi42L2luY2x1ZGUvbGludXgvcGNpLmgKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gbGludXgtMi42Lm9yaWcvaW5jbHVkZS9saW51eC9wY2kuaAorKysgbGludXgtMi42L2lu
Y2x1ZGUvbGludXgvcGNpLmgKQEAgLTc5OSw2ICs3OTksOCBAQCB2b2lkIHBjaWJpb3NfcmVzb3Vy
Y2VfdG9fYnVzKHN0cnVjdCBwY2lfCiAJCQkgICAgIHN0cnVjdCByZXNvdXJjZSAqcmVzKTsKIHZv
aWQgcGNpYmlvc19idXNfdG9fcmVzb3VyY2Uoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IHJl
c291cmNlICpyZXMsCiAJCQkgICAgIHN0cnVjdCBwY2lfYnVzX3JlZ2lvbiAqcmVnaW9uKTsKK3Jl
c291cmNlX3NpemVfdCBwY2liaW9zX2J1c19hZGRyX3RvX3JlcyhzdHJ1Y3QgcGNpX2J1cyAqYnVz
LCBpbnQgZmxhZ3MsCisJCQkJCXJlc291cmNlX3NpemVfdCBhZGRyKTsKIHZvaWQgcGNpYmlvc19z
Y2FuX3NwZWNpZmljX2J1cyhpbnQgYnVzbik7CiBzdHJ1Y3QgcGNpX2J1cyAqcGNpX2ZpbmRfYnVz
KGludCBkb21haW4sIGludCBidXNucik7CiB2b2lkIHBjaV9idXNfYWRkX2RldmljZXMoY29uc3Qg
c3RydWN0IHBjaV9idXMgKmJ1cyk7Cg==
--047d7bdca4300d4bbd04eb8cb7ef--
