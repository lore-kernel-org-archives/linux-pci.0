Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:48500 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbaBADvu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 22:51:50 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so6212975oag.28
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2014 19:51:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQU8+RRiTdsCm0v8Z46UyQ5xLSGWResVzEyHNCoWvWZjEw@mail.gmail.com>
References: <20140130131236.GW18029@intel.com>
	<1418039.AWHqDGWMFa@vostro.rjw.lan>
	<20140131123606.GF18029@intel.com>
	<1426729.BFFFkbZrqa@vostro.rjw.lan>
	<20140131134925.GI18029@intel.com>
	<CAE9FiQU8+RRiTdsCm0v8Z46UyQ5xLSGWResVzEyHNCoWvWZjEw@mail.gmail.com>
Date: Fri, 31 Jan 2014 19:51:49 -0800
Message-ID: <CAE9FiQVm2mbZnJTJ=wJ6yQqpByZHD2+gaUvhJSZ6P13sa2Z6vg@mail.gmail.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: multipart/mixed; boundary=001a11c2019ad93b5d04f1503567
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a11c2019ad93b5d04f1503567
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jan 31, 2014 at 7:44 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Jan 31, 2014 at 5:49 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>> On Fri, Jan 31, 2014 at 02:49:21PM +0100, Rafael J. Wysocki wrote:
>>> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.672933] pci_bus 0000:03: busn_res: [bus 03-3a] is released
>>>
>>> OK, so my guess wasn't right.  We seem to call pci_release_dev for all of the
>>> devices that go away after unplug.
>>>
>>> Do I think correctly that the below doesn't happen with the Yinghai's commit
>>> reverted?
>>
>> Yes, with that commit reverted everything works fine.
>
> can you make it clear ?
>
> after my commit is reverted, the warning does not happen any more?
>
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.616434]
> ------------[ cut here ]------------
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.618102] WARNING:
> CPU: 1 PID: 956 at lib/kobject.c:244 kobject_add_internal+0x12d/
> 0x400()

Hi, Mika,

Can you try attached partial reverting?

Thanks

Yinghai

--001a11c2019ad93b5d04f1503567
Content-Type: text/x-patch; charset=US-ASCII; name="partial_revert.patch"
Content-Disposition: attachment; filename="partial_revert.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hr4chssr0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCmlu
ZGV4IDA0Nzk2YzAuLmRkOTExMTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMKKysr
IGIvZHJpdmVycy9wY2kvcHJvYmUuYwpAQCAtMTIzMSwxMCArMTIzMSw2IEBAIHN0YXRpYyB2b2lk
IHBjaV9yZWxlYXNlX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7CiAJc3RydWN0IHBjaV9kZXYg
KnBjaV9kZXYgPSB0b19wY2lfZGV2KGRldik7CiAKLQlkb3duX3dyaXRlKCZwY2lfYnVzX3NlbSk7
Ci0JbGlzdF9kZWwoJnBjaV9kZXYtPmJ1c19saXN0KTsKLQl1cF93cml0ZSgmcGNpX2J1c19zZW0p
OwotCiAJcGNpX2ZyZWVfcmVzb3VyY2VzKHBjaV9kZXYpOwogCiAJcGNpX3JlbGVhc2VfY2FwYWJp
bGl0aWVzKHBjaV9kZXYpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcmVtb3ZlLmMgYi9kcml2
ZXJzL3BjaS9yZW1vdmUuYwppbmRleCA0ZmYzNmJmLi5jODI2NGM0IDEwMDY0NAotLS0gYS9kcml2
ZXJzL3BjaS9yZW1vdmUuYworKysgYi9kcml2ZXJzL3BjaS9yZW1vdmUuYwpAQCAtMjUsNiArMjUs
MTAgQEAgc3RhdGljIHZvaWQgcGNpX2Rlc3Ryb3lfZGV2KHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAK
IAlkZXZpY2VfZGVsKCZkZXYtPmRldik7CiAKKwlkb3duX3dyaXRlKCZwY2lfYnVzX3NlbSk7CisJ
bGlzdF9kZWwoJmRldi0+YnVzX2xpc3QpOworCXVwX3dyaXRlKCZwY2lfYnVzX3NlbSk7CisKIAlw
dXRfZGV2aWNlKCZkZXYtPmRldik7CiB9CiAK
--001a11c2019ad93b5d04f1503567--
