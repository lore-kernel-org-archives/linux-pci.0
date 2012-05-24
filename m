Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42681 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2EXAAG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 20:00:06 -0400
Received: by vbbff1 with SMTP id ff1so5071263vbb.19
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 17:00:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120523205238.GE23940@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
	<CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
	<20120523024313.GA2888@redhat.com>
	<CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
	<20120523205238.GE23940@redhat.com>
Date: Wed, 23 May 2012 17:00:05 -0700
Message-ID: <CAE9FiQVnYd62BR7j+E=dFWvOKi-W6dBOCqJ21NmqFjmF+yhtKg@mail.gmail.com>
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Jason Baron <jbaron@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com
Content-Type: multipart/mixed; boundary=20cf307cff742df05304c0bcef02
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--20cf307cff742df05304c0bcef02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2012 at 1:52 PM, Jason Baron <jbaron@redhat.com> wrote:
> Ok, I've also verified that quirk approach resolves the issue for me as
> well. It might not be a bad solution, especially if we anticipate moving
> to pciehp. We can also always change bridge vendor id to not hit the
> quirk, if we choose to implement more complex guest, or acpi fixes. The
> defaults for i/o and mem seem pretty sane too:
>
>
> #define DEFAULT_HOTPLUG_IO_SIZE =A0 =A0 =A0 =A0 (256)
> #define DEFAULT_HOTPLUG_MEM_SIZE =A0 =A0 =A0 =A0(2*1024*1024)
>
> And further can be set on the guest command line via:
>
> /* pci=3Dhpmemsize=3DnnM,hpiosize=3Dnn can override this */
>
> So I don't see any down-side really to the quirk approach (which is a
> quite simple 1-line patch to the guest), even if it is not a long-term
> solution.

Good. please check attached patch,
it should auto set that bit for apciphp when complex slot are
supported by platform.

next, we still need to extend probe_resource() to support
mmio/pref_mmio extension.
that is for when you have a lot slots on hotplug bridge.

Thanks

Yinghai

--20cf307cff742df05304c0bcef02
Content-Type: application/octet-stream;
	name="acpi_slot_hotplug_bridge_detection.patch"
Content-Disposition: attachment;
	filename="acpi_slot_hotplug_bridge_detection.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2l1ymp90

U3ViamVjdDogW1BBVENIXSBQQ0ksIGFjcGlwaHA6IGFkZCBpc19ob3RwbHVnX2JyaWRnZSBkZXRl
Y3Rpb24KCldoZW4gc3lzdGVtIHN1cHBvcnQgaG90cGx1ZyBicmlkZ2Ugd2l0aCBjaGlsZHJlbiBo
b3RwbHVnIHNsb3RzLCB3ZSBuZWVkIHRvIG1ha2Ugc3VyZQp0aGF0IHBhcmVudCBicmlkZ2UgZ2V0
IHByZWFsbG9jYXRlZCByZXNvdXJjZSBzbyBsYXRlciB3aGVuIGRldmljZSBpcyBwbHVnZ2VkIGlu
dG8KY2hpbGRyZW4gc2xvdCwgdGhvc2UgY2hpbGRyZW4gZGV2aWNlcyB3aWxsIGdldCByZXNvdXJj
ZSBhbGxvY2F0ZWQuCgpXZSBkbyBub3QgbWVldCB0aGlzIHByb2JsZW0sIGJlY2F1c2UgZm9yIHBj
aWUgaG90cGx1ZyBjYXJkLCB3aGVuIGFjcGlwaHAgaXMgdXNlZCwKcGNpX3NjYW5fYnJpZGdlIHdp
bGwgc2V0IHRoYXQgZm9yIHVzIHdoZW4gZGV0ZWN0IGhvdHBsdWcgYml0IGluIHNsb3QgY2FwLgoK
UmVwb3J0ZWQtYnk6IEphc29uIEJhcm9uIDxqYmFyb25AcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1i
eTogWWluZ2hhaSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2hvdHBsdWcvYWNwaXBocF9nbHVlLmMgYi9kcml2ZXJzL3BjaS9ob3RwbHVnL2FjcGlwaHBf
Z2x1ZS5jCmluZGV4IDYyZDBhZTQuLjVjODM0ZDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2hv
dHBsdWcvYWNwaXBocF9nbHVlLmMKKysrIGIvZHJpdmVycy9wY2kvaG90cGx1Zy9hY3BpcGhwX2ds
dWUuYwpAQCAtNzgxLDYgKzc4MSwyNiBAQCBzdGF0aWMgdm9pZCBhY3BpcGhwX3NldF9hY3BpX3Jl
Z2lvbihzdHJ1Y3QgYWNwaXBocF9zbG90ICpzbG90KQogCX0KIH0KIAorc3RhdGljIHZvaWQgY2hl
Y2tfaG90cGx1Z19icmlkZ2Uoc3RydWN0IGFjcGlwaHBfc2xvdCAqc2xvdCwgc3RydWN0IHBjaV9k
ZXYgKmRldikKK3sKKwlzdHJ1Y3QgYWNwaXBocF9mdW5jICpmdW5jOworCisJaWYgKCFkZXYtPnN1
Ym9yZGluYXRlKQorCQlyZXR1cm47CisKKwkvKiBxdWlyaywgb3IgcGNpZSBjb3VsZCBzZXQgaXQg
YWxyZWFkeSAqLworCWlmIChkZXYtPmlzX2hvdHBsdWdfYnJpZGdlKQorCQlyZXR1cm47CisKKwls
aXN0X2Zvcl9lYWNoX2VudHJ5KGZ1bmMsICZzbG90LT5mdW5jcywgc2libGluZykgeworCQlpZiAo
UENJX0ZVTkMoZGV2LT5kZXZmbikgPT0gZnVuYy0+ZnVuY3Rpb24pIHsKKwkJCS8qIGNoZWNrIGlm
IHRoaXMgYnJpZGdlIGhhcyBlamVjdGFibGUgc2xvdHMgKi8KKwkJCWlmICgoZGV0ZWN0X2VqZWN0
YWJsZV9zbG90cyhmdW5jLT5oYW5kbGUpID4gMCkpCisJCQkJZGV2LT5pc19ob3RwbHVnX2JyaWRn
ZSA9IDE7CisJCQlicmVhazsKKwkJfQorCX0KK30KIC8qKgogICogZW5hYmxlX2RldmljZSAtIGVu
YWJsZSwgY29uZmlndXJlIGEgc2xvdAogICogQHNsb3Q6IHNsb3QgdG8gYmUgZW5hYmxlZApAQCAt
ODE1LDggKzgzNSwxMCBAQCBzdGF0aWMgaW50IF9fcmVmIGVuYWJsZV9kZXZpY2Uoc3RydWN0IGFj
cGlwaHBfc2xvdCAqc2xvdCkKIAkJCWlmIChkZXYtPmhkcl90eXBlID09IFBDSV9IRUFERVJfVFlQ
RV9CUklER0UgfHwKIAkJCSAgICBkZXYtPmhkcl90eXBlID09IFBDSV9IRUFERVJfVFlQRV9DQVJE
QlVTKSB7CiAJCQkJbWF4ID0gcGNpX3NjYW5fYnJpZGdlKGJ1cywgZGV2LCBtYXgsIHBhc3MpOwot
CQkJCWlmIChwYXNzICYmIGRldi0+c3Vib3JkaW5hdGUpCisJCQkJaWYgKHBhc3MgJiYgZGV2LT5z
dWJvcmRpbmF0ZSkgeworCQkJCQljaGVja19ob3RwbHVnX2JyaWRnZShzbG90LCBkZXYpOwogCQkJ
CQlwY2lfYnVzX3NpemVfYnJpZGdlcyhkZXYtPnN1Ym9yZGluYXRlKTsKKwkJCQl9CiAJCQl9CiAJ
CX0KIAl9Cg==
--20cf307cff742df05304c0bcef02--
