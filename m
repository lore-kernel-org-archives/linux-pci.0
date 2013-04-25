Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54023 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669Ab3DYBUw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 21:20:52 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so2920021ied.5
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 18:20:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3400627.YcEmgrxv5I@vostro.rjw.lan>
References: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
	<CAAh6nkmkbKh7FjEZea4GmEbZvH4qvnfOJ2Og8xHYm5othsWLwQ@mail.gmail.com>
	<CAErSpo6zf34MOLNh5t_PifYhA87vFLRRx-g0WG5N=8+oUcWukQ@mail.gmail.com>
	<3400627.YcEmgrxv5I@vostro.rjw.lan>
Date: Wed, 24 Apr 2013 18:20:51 -0700
Message-ID: <CAE9FiQX7zyaZVm7QsZnOXtRD9qcCGCFpi2DLve863juL1ZxcWQ@mail.gmail.com>
Subject: Re: About dynamically loading the acpiphp.ko
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Guo <tuffkidtt@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: multipart/mixed; boundary=e89a8f3bb067b63ad904db253af7
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--e89a8f3bb067b63ad904db253af7
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Apr 24, 2013 at 3:55 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, April 24, 2013 02:03:04 PM Bjorn Helgaas wrote:
>>
>> We install a notify handler on PCI0 in find_root_bridges(), and that
>> notify handler leads to _handle_hotplug_event_root(), which assumes
>> this is a host bridge hotplug event.  But I would expect the notify
>> for a host bridge hot-add would go to the *parent* of the host bridge,
>> not to the host bridge itself, so something seems wrong here.
>>
>> Maybe the ACPI & hotplug experts can comment on this.
>
> I think it may (ie. won't be against the spec) go both ways, so it may go
> to the parent or the host bridge object itself.  We should be handling both
> cases IMO.

Yes, we missed that path.

Attached patch should fix the problem.

Gavin,

Can you please check that on top of pci/next?

Thanks

Yinghai

--e89a8f3bb067b63ad904db253af7
Content-Type: application/octet-stream;
	name="acpiphp_check_host_bridge.patch"
Content-Disposition: attachment; filename="acpiphp_check_host_bridge.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hfx8twi40

U3ViamVjdDogW1BBVENIXSBQQ0ksIEFDUEksIGhvdHBsdWc6IEZpeCBCVVNfQ0hFQ0sgZXZlbnQg
aGFuZGxlIG9uIHJvb3QgYnJpZGdlCgpXZSBzaG91bGQgY2hlY2sgc2xvdHMgd2hlbiBCVVNfQ0hF
Q0sgaXMgc2VudCB0byByb290IGJyaWRnZQphY3BpIGhhbmRsZS4KClNpZ25lZC1vZmYtYnk6IFlp
bmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9hY3BpL3BjaV9yb290
LmMgICAgICAgICAgICB8ICAgIDIgKysKIGRyaXZlcnMvcGNpL2hvdHBsdWcvYWNwaXBocF9nbHVl
LmMgfCAgIDEzICsrKysrKysrKysrKysKIGluY2x1ZGUvbGludXgvcGNpLWFjcGkuaCAgICAgICAg
ICAgfCAgICAyICsrCiAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCkluZGV4OiBs
aW51eC0yLjYvZHJpdmVycy9hY3BpL3BjaV9yb290LmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42
Lm9yaWcvZHJpdmVycy9hY3BpL3BjaV9yb290LmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL2FjcGkv
cGNpX3Jvb3QuYwpAQCAtNjQzLDYgKzY0Myw4IEBAIHN0YXRpYyB2b2lkIF9oYW5kbGVfaG90cGx1
Z19ldmVudF9yb290KHMKIAkJCQkgKGNoYXIgKilidWZmZXIucG9pbnRlcik7CiAJCWlmICghcm9v
dCkKIAkJCWhhbmRsZV9yb290X2JyaWRnZV9pbnNlcnRpb24oaGFuZGxlKTsKKwkJZWxzZQorCQkJ
YWNwaXBocF9jaGVja19ob3N0X2JyaWRnZShoYW5kbGUpOwogCiAJCWJyZWFrOwogCkluZGV4OiBs
aW51eC0yLjYvZHJpdmVycy9wY2kvaG90cGx1Zy9hY3BpcGhwX2dsdWUuYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3BjaS9ob3RwbHVnL2FjcGlwaHBfZ2x1ZS5jCisrKyBs
aW51eC0yLjYvZHJpdmVycy9wY2kvaG90cGx1Zy9hY3BpcGhwX2dsdWUuYwpAQCAtOTUwLDYgKzk1
MCwxOSBAQCBjaGVja19zdWJfYnJpZGdlcyhhY3BpX2hhbmRsZSBoYW5kbGUsIHUzCiAJcmV0dXJu
IEFFX09LIDsKIH0KIAordm9pZCBhY3BpcGhwX2NoZWNrX2hvc3RfYnJpZGdlKGFjcGlfaGFuZGxl
IGhhbmRsZSkKK3sKKwlzdHJ1Y3QgYWNwaXBocF9icmlkZ2UgKmJyaWRnZTsKKworCWJyaWRnZSA9
IGFjcGlwaHBfaGFuZGxlX3RvX2JyaWRnZShoYW5kbGUpOworCWlmICghYnJpZGdlKQorCQlyZXR1
cm47CisKKwlhY3BpcGhwX2NoZWNrX2JyaWRnZShicmlkZ2UpOworCWFjcGlfd2Fsa19uYW1lc3Bh
Y2UoQUNQSV9UWVBFX0RFVklDRSwgaGFuZGxlLAorCQlBQ1BJX1VJTlQzMl9NQVgsIGNoZWNrX3N1
Yl9icmlkZ2VzLCBOVUxMLCBOVUxMLCBOVUxMKTsKK30KKwogc3RhdGljIHZvaWQgX2hhbmRsZV9o
b3RwbHVnX2V2ZW50X2JyaWRnZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiB7CiAJc3RydWN0
IGFjcGlwaHBfYnJpZGdlICpicmlkZ2U7CkluZGV4OiBsaW51eC0yLjYvaW5jbHVkZS9saW51eC9w
Y2ktYWNwaS5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2luY2x1ZGUvbGludXgvcGNp
LWFjcGkuaAorKysgbGludXgtMi42L2luY2x1ZGUvbGludXgvcGNpLWFjcGkuaApAQCAtNjAsMTEg
KzYwLDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhY3BpX3BjaV9zbG90X3JlbW92ZSgKIHZvaWQg
YWNwaXBocF9pbml0KHZvaWQpOwogdm9pZCBhY3BpcGhwX2VudW1lcmF0ZV9zbG90cyhzdHJ1Y3Qg
cGNpX2J1cyAqYnVzLCBhY3BpX2hhbmRsZSBoYW5kbGUpOwogdm9pZCBhY3BpcGhwX3JlbW92ZV9z
bG90cyhzdHJ1Y3QgcGNpX2J1cyAqYnVzKTsKK3ZvaWQgYWNwaXBocF9jaGVja19ob3N0X2JyaWRn
ZShhY3BpX2hhbmRsZSBoYW5kbGUpOwogI2Vsc2UKIHN0YXRpYyBpbmxpbmUgdm9pZCBhY3BpcGhw
X2luaXQodm9pZCkgeyB9CiBzdGF0aWMgaW5saW5lIHZvaWQgYWNwaXBocF9lbnVtZXJhdGVfc2xv
dHMoc3RydWN0IHBjaV9idXMgKmJ1cywKIAkJCQkJICAgYWNwaV9oYW5kbGUgaGFuZGxlKSB7IH0K
IHN0YXRpYyBpbmxpbmUgdm9pZCBhY3BpcGhwX3JlbW92ZV9zbG90cyhzdHJ1Y3QgcGNpX2J1cyAq
YnVzKSB7IH0KK3N0YXRpYyBpbmxpbmUgdm9pZCBhY3BpcGhwX2NoZWNrX2hvc3RfYnJpZGdlKGFj
cGlfaGFuZGxlIGhhbmRsZSkgeyB9CiAjZW5kaWYKIAogI2Vsc2UJLyogQ09ORklHX0FDUEkgKi8K
--e89a8f3bb067b63ad904db253af7--
