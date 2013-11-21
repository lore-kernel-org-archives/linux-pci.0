Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64796 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab3KUUSl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2013 15:18:41 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so478778iec.7
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2013 12:18:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131121103021.GA29873@yanx>
References: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
	<1384912317-3721-7-git-send-email-yinghai@kernel.org>
	<20131121103021.GA29873@yanx>
Date: Thu, 21 Nov 2013 12:18:39 -0800
Message-ID: <CAE9FiQXgvaqErd1oiHmt6G8GwbW92C490+0sYyLUMcMFMMNRAg@mail.gmail.com>
Subject: Re: [PATCH 6/6] PCI: Try to allocate mem64 above 4G at first
From: Yinghai Lu <yinghai@kernel.org>
To: Guo Chao <yan@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=047d7bdca4307e980104ebb59aaa
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7bdca4307e980104ebb59aaa
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Nov 21, 2013 at 2:30 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> Hi:
>
> On Tue, Nov 19, 2013 at 05:51:57PM -0800, Yinghai Lu wrote:
>> Will fall back to below 4g if it can not find any above 4g.
>>
>
>
>
>
>> x86 32bit without X86_PAE support will have bottom set to 0, because
>> resource_size_t is 32bit.
>>
>> Also for 32bit with resource_size_t 64bit kernel on machine with pae support
>> we are safe because iomem_resource is limited to 32bit according to
>> x86_phys_bits.
>>
>> -v2: update bottom assigning to make it clear for non-pae support machine.
>> -v3: Bjorn's change:
>>         use MAX_RESOURCE instead of -1
>>         use start/end instead of bottom/max
>>         for all arch instead of just x86_64
>> -v4: updated after PCI_MAX_RESOURCE_32 change.
>> -v5: restore io handling to use PCI_MAX_RESOURCE_32 as limit.
>> -v6: checking pcibios_resource_to_bus return for every bus res, to decide it
>>       if we need to try high at first.
>>      It supports all arches instead of just x86_64.
>>

> Work fine in our systems if '[RFC PATCH 3/3] PCI: do not reset bridge's
> IORESOURCE_MEM_64 flag for ROM BAR' applied.
>
> Otherwise, in one system, the 32-bit window is too small to provide
> fallback space for prefetchable windows of root bridge, causing all
> prefethable resources failed to get addresses.
>
> Any comments about that patch?

no, that patch is not right.
That could prevent rom BAR getting allocate under 4G.

solution could be:
1. Just remove pref on rom bar allocation. as attached rom_no_pref.patch
2. or treat pref rom as option resource, as attached rom_option_1_xxx.patch
3. or more generic, treat all pci BAR 32bit prefetechable as normal
MMIO32 during allocation. aka mmio prefectechable will be used for pci
bridge that support 64bit mmio pref and leave bridge's 32bit only pref
bar register blank.

Bjorn, Linus,
Are you happy with No 3?

Thanks

Yinghai

--047d7bdca4307e980104ebb59aaa
Content-Type: text/x-patch; charset=US-ASCII; name="rom_no_pref.patch"
Content-Disposition: attachment; filename="rom_no_pref.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hoaf8q2e0

U3ViamVjdDogW1BBVENIXSBQQ0k6IERvbid0IGFsbG9jYXRlIHJvbSBiYXIgaW4gYnJpZGdlIHBy
ZWYgcmVzb3VyY2UKClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9y
Zz4KCi0tLQogZHJpdmVycy9wY2kvcHJvYmUuYyB8ICAgIDUgKystLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtMi42L2RyaXZl
cnMvcGNpL3Byb2JlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kv
cHJvYmUuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNpL3Byb2JlLmMKQEAgLTMzNiw5ICszMzYs
OCBAQCBzdGF0aWMgdm9pZCBwY2lfcmVhZF9iYXNlcyhzdHJ1Y3QgcGNpX2RlCiAJaWYgKHJvbSkg
ewogCQlzdHJ1Y3QgcmVzb3VyY2UgKnJlcyA9ICZkZXYtPnJlc291cmNlW1BDSV9ST01fUkVTT1VS
Q0VdOwogCQlkZXYtPnJvbV9iYXNlX3JlZyA9IHJvbTsKLQkJcmVzLT5mbGFncyA9IElPUkVTT1VS
Q0VfTUVNIHwgSU9SRVNPVVJDRV9QUkVGRVRDSCB8Ci0JCQkJSU9SRVNPVVJDRV9SRUFET05MWSB8
IElPUkVTT1VSQ0VfQ0FDSEVBQkxFIHwKLQkJCQlJT1JFU09VUkNFX1NJWkVBTElHTjsKKwkJcmVz
LT5mbGFncyA9IElPUkVTT1VSQ0VfTUVNIHwgSU9SRVNPVVJDRV9SRUFET05MWSB8CisJCQkJSU9S
RVNPVVJDRV9DQUNIRUFCTEUgfCBJT1JFU09VUkNFX1NJWkVBTElHTjsKIAkJX19wY2lfcmVhZF9i
YXNlKGRldiwgcGNpX2Jhcl9tZW0zMiwgcmVzLCByb20pOwogCX0KIH0K
--047d7bdca4307e980104ebb59aaa
Content-Type: text/x-patch; charset=US-ASCII; name="rom_option_1_xxx.patch"
Content-Disposition: attachment; filename="rom_option_1_xxx.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hoafadag1

U3ViamVjdDogW1BBVENIXSBQQ0k6IFRyZWF0IFJPTSByZXNvdXJjZSBhcyBvcHRpb25hbCBkdXJp
bmcgYXNzaWduaW5nLgoKU28gd2lsbCB0cnkgdG8gYWxsb2NhdGUgdGhlbSB0b2dldGhlciB3aXRo
IHJlcXVlc3RlZCBvbmVzLCBpZiBjYW4gbm90IGFzc2lnbgp0aGVtLCBjb3VsZCBnbyB3aXRoIHJl
cXVlc3RlZCBvbmUgb25seSwgYW5kIGp1c3Qgc2tpcCBST00gcmVzb3VyY2UuCgpTaWduZWQtb2Zm
LWJ5OiBZaW5naGFpIEx1IDx5aW5naGFpQGtlcm5lbC5vcmc+CgotLS0KIGRyaXZlcnMvcGNpL3Nl
dHVwLWJ1cy5jIHwgICAyMSArKysrKysrLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJz
L3BjaS9zZXR1cC1idXMuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3Bj
aS9zZXR1cC1idXMuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jCkBAIC0z
MDMsMTggKzMwMywxMCBAQCBzdGF0aWMgdm9pZCBhc3NpZ25fcmVxdWVzdGVkX3Jlc291cmNlc19z
CiAJCWlkeCA9IHBjaV9kZXZfcmVzb3VyY2VfaWR4KGRldl9yZXMtPmRldiwgcmVzKTsKIAkJaWYg
KHJlc291cmNlX3NpemUocmVzKSAmJgogCQkgICAgcGNpX2Fzc2lnbl9yZXNvdXJjZV9maXQoZGV2
X3Jlcy0+ZGV2LCBpZHgsIGZpdCkpIHsKLQkJCWlmIChmYWlsX2hlYWQpIHsKLQkJCQkvKgotCQkJ
CSAqIGlmIHRoZSBmYWlsZWQgcmVzIGlzIGZvciBST00gQkFSLCBhbmQgaXQgd2lsbAotCQkJCSAq
IGJlIGVuYWJsZWQgbGF0ZXIsIGRvbid0IGFkZCBpdCB0byB0aGUgbGlzdAotCQkJCSAqLwotCQkJ
CWlmICghKChpZHggPT0gUENJX1JPTV9SRVNPVVJDRSkgJiYKLQkJCQkgICAgICAoIShyZXMtPmZs
YWdzICYgSU9SRVNPVVJDRV9ST01fRU5BQkxFKSkpKQotCQkJCQlhZGRfdG9fbGlzdChmYWlsX2hl
YWQsCi0JCQkJCQkgICAgZGV2X3Jlcy0+ZGV2LCByZXMsCi0JCQkJCQkgICAgMCAvKiBkb24ndCBj
YXJlICovLAotCQkJCQkJICAgIDAgLyogZG9uJ3QgY2FyZSAqLyk7Ci0JCQl9CisJCQlpZiAoZmFp
bF9oZWFkKQorCQkJCWFkZF90b19saXN0KGZhaWxfaGVhZCwgZGV2X3Jlcy0+ZGV2LCByZXMsCisJ
CQkJCSAgICAwIC8qIGRvbid0IGNhcmUgKi8sCisJCQkJCSAgICAwIC8qIGRvbid0IGNhcmUgKi8p
OwogCQkJcmVzZXRfcmVzb3VyY2UocmVzKTsKIAkJfQogCX0KQEAgLTkwMyw4ICs4OTUsOSBAQCBz
dGF0aWMgaW50IHBidXNfc2l6ZV9tZW0oc3RydWN0IHBjaV9idXMKIAkJCQljb250aW51ZTsKIAkJ
CXJfc2l6ZSA9IHJlc291cmNlX3NpemUocik7CiAKLQkJCS8qIHB1dCBTUklPViByZXF1ZXN0ZWQg
cmVzIHRvIHRoZSBvcHRpb25hbCBsaXN0ICovCi0JCQlpZiAocmVhbGxvY19oZWFkICYmIGlzX3Bj
aV9pb3ZfcmVzb3VyY2VfaWR4KGkpKSB7CisJCQkvKiBwdXQgU1JJT1YvUk9NIHJlcXVlc3RlZCBy
ZXMgdG8gdGhlIG9wdGlvbmFsIGxpc3QgKi8KKwkJCWlmIChyZWFsbG9jX2hlYWQgJiYgKGlzX3Bj
aV9pb3ZfcmVzb3VyY2VfaWR4KGkpIHx8CisJCQkJCSAgICAgaXNfcGNpX3JvbV9yZXNvdXJjZV9p
ZHgoaSkpKSB7CiAJCQkJci0+ZW5kID0gci0+c3RhcnQgLSAxOwogCQkJCWFkZF90b19saXN0KHJl
YWxsb2NfaGVhZCwgZGV2LCByLCByX3NpemUsIDAvKiBkb250JyBjYXJlICovKTsKIAkJCQljaGls
ZHJlbl9hZGRfc2l6ZSArPSByX3NpemU7Cg==
--047d7bdca4307e980104ebb59aaa--
