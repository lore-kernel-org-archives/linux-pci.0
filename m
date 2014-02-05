Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:41413 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaBEEOV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2014 23:14:21 -0500
Received: by mail-wg0-f53.google.com with SMTP id y10so13767524wgg.20
        for <linux-pci@vger.kernel.org>; Tue, 04 Feb 2014 20:14:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140131115340.GD26148@htj.dyndns.org>
References: <CAF2xp_HgT+2zmxHTYpxRFiK-pfQKQJhJ74SJhQVER4s2ZZX0PQ@mail.gmail.com>
 <20140131115340.GD26148@htj.dyndns.org>
From: Peter Chang <dpf@google.com>
Date: Tue, 4 Feb 2014 20:13:58 -0800
Message-ID: <CAF2xp_F_WeMOhffLv+tA2O8L6+8Vn=VZtNh3S4WXmEAMEQC-jw@mail.gmail.com>
Subject: Re: PATCH: platforms: avoid queuing work if possible
To: Tejun Heo <tj@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=f46d0444eb679aa20804f1a0fdfc
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--f46d0444eb679aa20804f1a0fdfc
Content-Type: text/plain; charset=UTF-8

sorry for the delay, this got filtered into the
check-every-once-in-while bucket.

2014-01-31 Tejun Heo <tj@kernel.org>:
> Hello,
>
> On Thu, Jan 30, 2014 at 05:24:16PM -0800, Peter Chang wrote:
>> 774a1221e862b343388347bac9b318767336b20b tries to avoid an expensive sync
>> by marking the current task iff it uses the async_schedule() machinery.
>
> That wasn't an optimization.  It was a workaround for deadlock.

sorry for the mis-characterization.

> The patch description doesn't describe the reasons for the change at
> all.  What issues have you encountered?  What are you trying to
> achieve?

the problem is that our current user-space environment expects block
devices to be in /sys/block after the module load completes. if the
cross cpu worker task is marked w/ ASYNC_USED (rather than the module
loading task), module loading completes and the async tasks are
'racing' w/ user space.

i fixed up the patch to just do the ASYNC_USED copying in the worker
function (since there was some bogus-ness in the original w/
get_cpu()). does this patch make more sense?

\p

--f46d0444eb679aa20804f1a0fdfc
Content-Type: application/octet-stream;
	name="0001-pci-copy-PF_USED_ASYNC-in-the-cross-cpu-probe-case.patch"
Content-Disposition: attachment;
	filename="0001-pci-copy-PF_USED_ASYNC-in-the-cross-cpu-probe-case.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hra2zn950

RnJvbSBjMTc4MzQwOGI2NDc5NTA0MDQwMzM0NWNkYmQ4NTJkOWNmZDBmNTUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBwZXRlciBjaGFuZyA8ZHBmQGdvb2dsZS5jb20+CkRhdGU6IFR1
ZSwgNCBGZWIgMjAxNCAxOTo1MTowMyAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHBjaTogY29weSBQ
Rl9VU0VEX0FTWU5DIGluIHRoZSBjcm9zcyBjcHUgcHJvYmUgY2FzZQoKNzc0YTEyMjFlODYyYjM0
MzM4ODM0N2JhYzliMzE4NzY3MzM2YjIwYiBhdm9pZHMgYSBkZWFkbG9jayBjb25kaXRpb24KYnkg
bWFya2luZyB0aGUgY3VycmVudCB0YXNrIGlmZiBpdCB1c2VzIHRoZSBhc3luY19zY2hlZHVsZSgp
IG1hY2hpbmVyeS4KaG93ZXZlciwgaWYgdGhlIHBhcnQgb2YgdGhlIGRyaXZlcidzIHByb2JlIGlz
IGNhbGxlZCB0aHJvdWdoIGEgd29ya2VyCnRocmVhZCB0aGUgYm9va2VlcGluZyBmYWlscyB0byBt
YXJrIHRoZSBjb3JyZWN0IHRhc2sgYXMgaGF2aW5nIHVzZWQgdGhlCmFzeW5jIG1hY2hpbmVyeS4g
c2luY2UgdGhlIG1vZHVsZSBsb2FkaW5nIHRhc2sgaXNuJ3QgbWFya2VkIGl0IG5vIGxvbmdlcgpk
b2VzIGFuIGFzeW5jX3N5bmNocm9uaXplX2Z1bGwoKSB3aGljaCBtZWFucyB0aGF0IHRoZXJlJ3Mg
cmFjZSB3Lwp1c2VyLXNwYWNlIHdoaWNoIHdhcyBleHBlY3RpbmcgYmxvY2sgZGV2aWNlcyBpbiAv
c3lzL2Jsb2NrIGFuZCB0aGUKYXN5bmMgdGFza3MuCgpUZXN0ZWQ6Ci0gY2hlY2tlZCBvbiB2ZWJt
eTIgKGludGVsIHNhbmR5YnJpZGdlICsgZGlza3RyYXkpIHdoaWNoIGlzIHdoZXJlIHRoZQogIG9y
aWdpbmFsIGlzc3VlIHdhcyBkaXNjb3ZlcmVkLgotIGNoZWNrZWQgb24gZmRoYTM0NyAoaW50ZWwg
d2VzdG1lcmUgKyBtdWx0aXBsZSBkaXNrdHJheXMpIHRvIHNob3cgdGhhdAogIG5vdGhpbmcgY2hh
bmdlZCB3aGVuIG5vdCBtYWtpbmcgYSBjcm9zcyBjcHUgY2FsbC4KClNpZ25lZC1vZmYtYnk6IHBl
dGVyIGNoYW5nIDxkcGZAZ29vZ2xlLmNvbT4KLS0tCiBkcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMg
fCAxOCArKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS1kcml2ZXIuYyBi
L2RyaXZlcnMvcGNpL3BjaS1kcml2ZXIuYwppbmRleCAyNWYwYmM2Li45ZDdmMjk0IDEwMDY0NAot
LS0gYS9kcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMKKysrIGIvZHJpdmVycy9wY2kvcGNpLWRyaXZl
ci5jCkBAIC0yNDcsNiArMjQ3LDcgQEAgc3RydWN0IGRydl9kZXZfYW5kX2lkIHsKIAlzdHJ1Y3Qg
cGNpX2RyaXZlciAqZHJ2OwogCXN0cnVjdCBwY2lfZGV2ICpkZXY7CiAJY29uc3Qgc3RydWN0IHBj
aV9kZXZpY2VfaWQgKmlkOworCXVuc2lnbmVkIGludCB0YXNrX2ZsYWdzOwogfTsKIAogc3RhdGlj
IGxvbmcgbG9jYWxfcGNpX3Byb2JlKHZvaWQgKl9kZGkpCkBAIC0yNjgsOCArMjY5LDExIEBAIHN0
YXRpYyBsb25nIGxvY2FsX3BjaV9wcm9iZSh2b2lkICpfZGRpKQogCXBtX3J1bnRpbWVfZ2V0X3N5
bmMoZGV2KTsKIAlwY2lfZGV2LT5kcml2ZXIgPSBwY2lfZHJ2OwogCXJjID0gcGNpX2Rydi0+cHJv
YmUocGNpX2RldiwgZGRpLT5pZCk7Ci0JaWYgKCFyYykKKwlpZiAoIXJjKSB7CisJCWlmIChjdXJy
ZW50KQorCQkJZGRpLT50YXNrX2ZsYWdzID0gY3VycmVudC0+ZmxhZ3M7CiAJCXJldHVybiByYzsK
Kwl9CiAJaWYgKHJjIDwgMCkgewogCQlwY2lfZGV2LT5kcml2ZXIgPSBOVUxMOwogCQlwbV9ydW50
aW1lX3B1dF9zeW5jKGRldik7CkBAIC0yODcsNyArMjkxLDcgQEAgc3RhdGljIGludCBwY2lfY2Fs
bF9wcm9iZShzdHJ1Y3QgcGNpX2RyaXZlciAqZHJ2LCBzdHJ1Y3QgcGNpX2RldiAqZGV2LAogCQkJ
ICBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCiB7CiAJaW50IGVycm9yLCBub2RlOwot
CXN0cnVjdCBkcnZfZGV2X2FuZF9pZCBkZGkgPSB7IGRydiwgZGV2LCBpZCB9OworCXN0cnVjdCBk
cnZfZGV2X2FuZF9pZCBkZGkgPSB7IGRydiwgZGV2LCBpZCwgMCB9OwogCiAJLyoKIAkgKiBFeGVj
dXRlIGRyaXZlciBpbml0aWFsaXphdGlvbiBvbiBub2RlIHdoZXJlIHRoZSBkZXZpY2UgaXMKQEAg
LTMxNCw5ICszMTgsMTUgQEAgc3RhdGljIGludCBwY2lfY2FsbF9wcm9iZShzdHJ1Y3QgcGNpX2Ry
aXZlciAqZHJ2LCBzdHJ1Y3QgcGNpX2RldiAqZGV2LAogCiAJCWdldF9vbmxpbmVfY3B1cygpOwog
CQljcHUgPSBjcHVtYXNrX2FueV9hbmQoY3B1bWFza19vZl9ub2RlKG5vZGUpLCBjcHVfb25saW5l
X21hc2spOwotCQlpZiAoY3B1IDwgbnJfY3B1X2lkcykKKwkJaWYgKGNwdSA8IG5yX2NwdV9pZHMp
IHsKIAkJCWVycm9yID0gd29ya19vbl9jcHUoY3B1LCBsb2NhbF9wY2lfcHJvYmUsICZkZGkpOwot
CQllbHNlCisJCQkvKiBjb3B5IG91dCBzb21lIHRhc2sgZmxhZ3MgZm9yIHRoZSBtb2R1bGUgbG9h
ZGluZworCQkJICogY2FzZS4KKwkJCSAqLworCQkJaWYgKCFlcnJvciAmJiBjdXJyZW50KQorCQkJ
CWN1cnJlbnQtPmZsYWdzIHw9IChkZGkudGFza19mbGFncyAmCisJCQkJCQkgICBQRl9VU0VEX0FT
WU5DKTsKKwkJfSBlbHNlCiAJCQllcnJvciA9IGxvY2FsX3BjaV9wcm9iZSgmZGRpKTsKIAkJcHV0
X29ubGluZV9jcHVzKCk7CiAJfSBlbHNlCi0tIAoxLjkuMC5yYzEuMTc1LmcwYjFkY2I1Cgo=
--f46d0444eb679aa20804f1a0fdfc--
