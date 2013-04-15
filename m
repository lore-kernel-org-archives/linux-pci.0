Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34431 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab3DOUlU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2013 16:41:20 -0400
MIME-Version: 1.0
In-Reply-To: <20130415182614.GB9224@xanatos>
References: <5AA430FFE4486C448003201AC83BC85E01F83F0D@EXHQ.corp.stratus.com>
	<20130415182614.GB9224@xanatos>
Date: Mon, 15 Apr 2013 13:41:20 -0700
Message-ID: <CAE9FiQVe95hT2mv4G+v_FMk5_qQDSg0e0fPdZdoe8Cgam70EnA@mail.gmail.com>
Subject: Re: USB PCI quirk issue
From: Yinghai Lu <yinghai@kernel.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	"Bulkow, David" <David.Bulkow@stratus.com>
Cc: "Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: multipart/mixed; boundary=20cf300e528f7464c804da6c46ae
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--20cf300e528f7464c804da6c46ae
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Apr 15, 2013 at 11:26 AM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
> Cc-ing the public Linux PCI and USB mailing lists.
>
> On Fri, Apr 12, 2013 at 02:59:29PM -0400, Bulkow, David wrote:
>> Susan,
>
> I'm Sarah. :)
>
>> While testing Linux 3.9 we ran into an issue which I believe is a
>> conflict between a couple of PCI changes.  Stratus has hardware that
>> can hot add/remove chunks of its PCI hierarchy which has tickled some
>> of the newer code.  I am mailing you because I believe the second
>> change I list below holds the key.
>>
>> I believe we are experiencing a collision between two changes.  The
>> first:
>>
>> PCI: Put pci_dev in device tree as early as possible
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4f535093cf8f6da8cfda7c36c2c1ecd2e9586ee4
>>
>> is causing device_add to be called during pci_scan_slot.  The second:
>>
>> USB: Fix handoff when BIOS disables host PCI device
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=cab928ee1f221c9cc48d6615070fefe2e444384a
>>
>> is getting activated by device_add.

looks like we call quirk_final too early for hotadd path.

Please check if attached can workaround the problem.

Thanks

Yinghai

--20cf300e528f7464c804da6c46ae
Content-Type: application/octet-stream; name="fix_qurik_final_hotadd.patch"
Content-Disposition: attachment; filename="fix_qurik_final_hotadd.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hfk3xmj60

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2J1cy5jIGIvZHJpdmVycy9wY2kvYnVzLmMKaW5kZXgg
YmRjMWU4Yi4uMWVkZmZiNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvYnVzLmMKKysrIGIvZHJp
dmVycy9wY2kvYnVzLmMKQEAgLTIwMSw2ICsyMDEsNyBAQCB2b2lkIHBjaV9idXNfYWRkX2Rldmlj
ZXMoY29uc3Qgc3RydWN0IHBjaV9idXMgKmJ1cykKIAkJLyogU2tpcCBhbHJlYWR5LWFkZGVkIGRl
dmljZXMgKi8KIAkJaWYgKGRldi0+aXNfYWRkZWQpCiAJCQljb250aW51ZTsKKwkJcGNpX2ZpeHVw
X2RldmljZShwY2lfZml4dXBfZmluYWwsIGRldik7CiAJCXJldHZhbCA9IHBjaV9idXNfYWRkX2Rl
dmljZShkZXYpOwogCX0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZl
cnMvcGNpL3Byb2JlLmMKaW5kZXggNDNlY2U1ZC4uNjdjZDA0NSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9wY2kvcHJvYmUuYworKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCkBAIC0xMzQxLDcgKzEzNDEs
NiBAQCB2b2lkIHBjaV9kZXZpY2VfYWRkKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0cnVjdCBwY2lf
YnVzICpidXMpCiAJbGlzdF9hZGRfdGFpbCgmZGV2LT5idXNfbGlzdCwgJmJ1cy0+ZGV2aWNlcyk7
CiAJdXBfd3JpdGUoJnBjaV9idXNfc2VtKTsKIAotCXBjaV9maXh1cF9kZXZpY2UocGNpX2ZpeHVw
X2ZpbmFsLCBkZXYpOwogCXJldCA9IHBjaWJpb3NfYWRkX2RldmljZShkZXYpOwogCVdBUk5fT04o
cmV0IDwgMCk7CiAK
--20cf300e528f7464c804da6c46ae--
