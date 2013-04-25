Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:41756 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab3DYGBx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2013 02:01:53 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so2398656iaf.32
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 23:01:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQX7zyaZVm7QsZnOXtRD9qcCGCFpi2DLve863juL1ZxcWQ@mail.gmail.com>
References: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
	<CAAh6nkmkbKh7FjEZea4GmEbZvH4qvnfOJ2Og8xHYm5othsWLwQ@mail.gmail.com>
	<CAErSpo6zf34MOLNh5t_PifYhA87vFLRRx-g0WG5N=8+oUcWukQ@mail.gmail.com>
	<3400627.YcEmgrxv5I@vostro.rjw.lan>
	<CAE9FiQX7zyaZVm7QsZnOXtRD9qcCGCFpi2DLve863juL1ZxcWQ@mail.gmail.com>
Date: Wed, 24 Apr 2013 23:01:52 -0700
Message-ID: <CAE9FiQXwM_Jd_fbB7fKUAxuQJNXEbPA0yfWN_xFnYFUNxE8URg@mail.gmail.com>
Subject: Re: About dynamically loading the acpiphp.ko
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Guo <tuffkidtt@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: multipart/mixed; boundary=047d7b10cd29b2b79e04db292711
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7b10cd29b2b79e04db292711
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Apr 24, 2013 at 6:20 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Apr 24, 2013 at 3:55 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Wednesday, April 24, 2013 02:03:04 PM Bjorn Helgaas wrote:
>>>
>>> We install a notify handler on PCI0 in find_root_bridges(), and that
>>> notify handler leads to _handle_hotplug_event_root(), which assumes
>>> this is a host bridge hotplug event.  But I would expect the notify
>>> for a host bridge hot-add would go to the *parent* of the host bridge,
>>> not to the host bridge itself, so something seems wrong here.
>>>
>>> Maybe the ACPI & hotplug experts can comment on this.
>>
>> I think it may (ie. won't be against the spec) go both ways, so it may go
>> to the parent or the host bridge object itself.  We should be handling both
>> cases IMO.
>
> Yes, we missed that path.
>
> Attached patch should fix the problem.
>
> Gavin,
>
> Can you please check that on top of pci/next?

updated -v2.

--047d7b10cd29b2b79e04db292711
Content-Type: application/octet-stream;
	name="acpiphp_check_host_bridge_v2.patch"
Content-Disposition: attachment;
	filename="acpiphp_check_host_bridge_v2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hfxixob51

U3ViamVjdDogW1BBVENIIC12Ml0gUENJLCBBQ1BJLCBob3RwbHVnOiBGaXggQlVTX0NIRUNLIGV2
ZW50IGhhbmRsZSBvbiByb290IGJyaWRnZQoKV2Ugc2hvdWxkIGNoZWNrIHNsb3RzIHdoZW4gQlVT
X0NIRUNLIGlzIHNlbnQgdG8gcm9vdCBicmlkZ2UKYWNwaSBoYW5kbGUuCgotdjI6IERvbid0IGNo
ZWNrIGJyaWRnZSBmb3IgYWNwaV93YWxrX25hbWVzcGFjZSB3aXRoIGNoZWNrX3N1Yl9icmlkZ2Vz
LgogICAgIGFsc28gcHV0IGJhY2sgYnJpZGdlIHJlZmVyZW5jZS4KClNpZ25lZC1vZmYtYnk6IFlp
bmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9hY3BpL3BjaV9yb290
LmMgICAgICAgICAgICB8ICAgIDIgKysKIGRyaXZlcnMvcGNpL2hvdHBsdWcvYWNwaXBocF9nbHVl
LmMgfCAgIDE0ICsrKysrKysrKysrKysrCiBpbmNsdWRlL2xpbnV4L3BjaS1hY3BpLmggICAgICAg
ICAgIHwgICAgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCgpJbmRleDog
bGludXgtMi42L2RyaXZlcnMvYWNwaS9wY2lfcm9vdC5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIu
Ni5vcmlnL2RyaXZlcnMvYWNwaS9wY2lfcm9vdC5jCisrKyBsaW51eC0yLjYvZHJpdmVycy9hY3Bp
L3BjaV9yb290LmMKQEAgLTY0Myw2ICs2NDMsOCBAQCBzdGF0aWMgdm9pZCBfaGFuZGxlX2hvdHBs
dWdfZXZlbnRfcm9vdChzCiAJCQkJIChjaGFyICopYnVmZmVyLnBvaW50ZXIpOwogCQlpZiAoIXJv
b3QpCiAJCQloYW5kbGVfcm9vdF9icmlkZ2VfaW5zZXJ0aW9uKGhhbmRsZSk7CisJCWVsc2UKKwkJ
CWFjcGlwaHBfY2hlY2tfaG9zdF9icmlkZ2UoaGFuZGxlKTsKIAogCQlicmVhazsKIApJbmRleDog
bGludXgtMi42L2RyaXZlcnMvcGNpL2hvdHBsdWcvYWNwaXBocF9nbHVlLmMKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvaG90cGx1Zy9hY3BpcGhwX2dsdWUuYworKysg
bGludXgtMi42L2RyaXZlcnMvcGNpL2hvdHBsdWcvYWNwaXBocF9nbHVlLmMKQEAgLTk1MCw2ICs5
NTAsMjAgQEAgY2hlY2tfc3ViX2JyaWRnZXMoYWNwaV9oYW5kbGUgaGFuZGxlLCB1MwogCXJldHVy
biBBRV9PSyA7CiB9CiAKK3ZvaWQgYWNwaXBocF9jaGVja19ob3N0X2JyaWRnZShhY3BpX2hhbmRs
ZSBoYW5kbGUpCit7CisJc3RydWN0IGFjcGlwaHBfYnJpZGdlICpicmlkZ2U7CisKKwlicmlkZ2Ug
PSBhY3BpcGhwX2hhbmRsZV90b19icmlkZ2UoaGFuZGxlKTsKKwlpZiAoYnJpZGdlKSB7CisJCWFj
cGlwaHBfY2hlY2tfYnJpZGdlKGJyaWRnZSk7CisJCXB1dF9icmlkZ2UoYnJpZGdlKTsKKwl9CisK
KwlhY3BpX3dhbGtfbmFtZXNwYWNlKEFDUElfVFlQRV9ERVZJQ0UsIGhhbmRsZSwKKwkJQUNQSV9V
SU5UMzJfTUFYLCBjaGVja19zdWJfYnJpZGdlcywgTlVMTCwgTlVMTCwgTlVMTCk7Cit9CisKIHN0
YXRpYyB2b2lkIF9oYW5kbGVfaG90cGx1Z19ldmVudF9icmlkZ2Uoc3RydWN0IHdvcmtfc3RydWN0
ICp3b3JrKQogewogCXN0cnVjdCBhY3BpcGhwX2JyaWRnZSAqYnJpZGdlOwpJbmRleDogbGludXgt
Mi42L2luY2x1ZGUvbGludXgvcGNpLWFjcGkuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3Jp
Zy9pbmNsdWRlL2xpbnV4L3BjaS1hY3BpLmgKKysrIGxpbnV4LTIuNi9pbmNsdWRlL2xpbnV4L3Bj
aS1hY3BpLmgKQEAgLTYwLDExICs2MCwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYWNwaV9wY2lf
c2xvdF9yZW1vdmUoCiB2b2lkIGFjcGlwaHBfaW5pdCh2b2lkKTsKIHZvaWQgYWNwaXBocF9lbnVt
ZXJhdGVfc2xvdHMoc3RydWN0IHBjaV9idXMgKmJ1cywgYWNwaV9oYW5kbGUgaGFuZGxlKTsKIHZv
aWQgYWNwaXBocF9yZW1vdmVfc2xvdHMoc3RydWN0IHBjaV9idXMgKmJ1cyk7Cit2b2lkIGFjcGlw
aHBfY2hlY2tfaG9zdF9icmlkZ2UoYWNwaV9oYW5kbGUgaGFuZGxlKTsKICNlbHNlCiBzdGF0aWMg
aW5saW5lIHZvaWQgYWNwaXBocF9pbml0KHZvaWQpIHsgfQogc3RhdGljIGlubGluZSB2b2lkIGFj
cGlwaHBfZW51bWVyYXRlX3Nsb3RzKHN0cnVjdCBwY2lfYnVzICpidXMsCiAJCQkJCSAgIGFjcGlf
aGFuZGxlIGhhbmRsZSkgeyB9CiBzdGF0aWMgaW5saW5lIHZvaWQgYWNwaXBocF9yZW1vdmVfc2xv
dHMoc3RydWN0IHBjaV9idXMgKmJ1cykgeyB9CitzdGF0aWMgaW5saW5lIHZvaWQgYWNwaXBocF9j
aGVja19ob3N0X2JyaWRnZShhY3BpX2hhbmRsZSBoYW5kbGUpIHsgfQogI2VuZGlmCiAKICNlbHNl
CS8qIENPTkZJR19BQ1BJICovCg==
--047d7b10cd29b2b79e04db292711--
