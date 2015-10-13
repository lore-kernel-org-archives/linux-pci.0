Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:32826 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbbJMGVo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 02:21:44 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
	<CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
	<alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
	<CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
	<alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
	<CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com>
Date: Mon, 12 Oct 2015 23:21:43 -0700
Message-ID: <CAE9FiQUVom8RaEMDFHSZer3inB_QuckqxS6Dgsid0JcSHUFEFw@mail.gmail.com>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a113dccc2a99a1f0521f6753f
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a113dccc2a99a1f0521f6753f
Content-Type: text/plain; charset=UTF-8

On Mon, Oct 12, 2015 at 10:43 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Oct 12, 2015 at 10:06 PM, Meelis Roos <mroos@linux.ee> wrote:
>>> >> > sparc64 machines:
>>
>> Updated on V210 - the others were more recent. Now I get more BAR
>> warning there too:
>>
>> http://kodu.ut.ee/~mroos/dm/dm.v210+patches
>>
>
> interesting, mem and mem64 is overlapping.
>
> [   38.824625] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
> [   38.824654] /pci@1f,700000: PCI IO [io
> 0x7f601000000-0x7f601ffffff] offset 7f601000000
> [   38.824680] /pci@1f,700000: PCI MEM [mem
> 0x7f700000000-0x7f7ffffffff] offset 7f700000000
> [   38.824704] /pci@1f,700000: PCI MEM64 [mem
> 0x7f700000000-0x7f7ffffffff] offset 7f700000000
> [   38.826310] PCI: Scanning PBM /pci@1f,700000
> [   38.826479] schizo f0069c00: PCI host bridge to bus 0000:00
> [   38.826506] pci_bus 0000:00: root bus resource [io
> 0x7f601000000-0x7f601ffffff] (bus address [0x0000-0xffffff])
> [   38.826536] pci_bus 0000:00: root bus resource [mem
> 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
> [   38.826565] pci_bus 0000:00: root bus resource [mem
> 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
>

For overlapping, please check attached patch that should fix the problem.

Thanks

Yinghai

--001a113dccc2a99a1f0521f6753f
Content-Type: text/x-patch; charset=US-ASCII; name="fix_mem_mem64_overlapping.patch"
Content-Disposition: attachment; filename="fix_mem_mem64_overlapping.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ifozdfyo0

U3ViamVjdDogW1BBVENIXSBzcGFyYy9QQ0k6IGNoZWNrIG92ZXJsYXBwaW5nIG1taW82NCB3aXRo
IG1taW8gZm9yIHJvb3QgYnVzCgpGb3VuZCBvbmUgc3lzdGVtIGhhdmUgb3ZlcmxhcHBpbmcgYmV0
d2VlbiBtbWlvNjQgYW5kIG1taW86CgovcGNpQDFkLDcwMDAwMDogVE9NQVRJTExPIFBDSSBCdXMg
TW9kdWxlIHZlcls0OjBdCi9wY2lAMWQsNzAwMDAwOiBQQ0kgSU8gW2lvICAweDdjNjAxMDAwMDAw
LTB4N2M2MDFmZmZmZmZdIG9mZnNldCA3YzYwMTAwMDAwMAovcGNpQDFkLDcwMDAwMDogUENJIE1F
TSBbbWVtIDB4N2M3MDAwMDAwMDAtMHg3YzdmZmZmZmZmZl0gb2Zmc2V0IDdjNzAwMDAwMDAwCi9w
Y2lAMWQsNzAwMDAwOiBQQ0kgTUVNNjQgW21lbSAweDdjNzAwMDAwMDAwLTB4N2M3ZmZmZmZmZmZd
IG9mZnNldCA3YzcwMDAwMDAwMApQQ0k6IFNjYW5uaW5nIFBCTSAvcGNpQDFkLDcwMDAwMApzY2hp
em8gZjAwODU5ZDQ6IFBDSSBob3N0IGJyaWRnZSB0byBidXMgMDAwMzowMApwY2lfYnVzIDAwMDM6
MDA6IHJvb3QgYnVzIHJlc291cmNlIFtpbyAgMHg3YzYwMTAwMDAwMC0weDdjNjAxZmZmZmZmXSAo
YnVzIGFkZHJlc3MgWzB4MDAwMC0weGZmZmZmZl0pCnBjaV9idXMgMDAwMzowMDogcm9vdCBidXMg
cmVzb3VyY2UgW21lbSAweDdjNzAwMDAwMDAwLTB4N2M3ZmZmZmZmZmZdIChidXMgYWRkcmVzcyBb
MHgwMDAwMDAwMC0weGZmZmZmZmZmXSkKcGNpX2J1cyAwMDAzOjAwOiByb290IGJ1cyByZXNvdXJj
ZSBbbWVtIDB4N2M3MDAwMDAwMDAtMHg3YzdmZmZmZmZmZl0gKGJ1cyBhZGRyZXNzIFsweDAwMDAw
MDAwLTB4ZmZmZmZmZmZdKQoKc28gYWRkIGNoZWNraW5nIGZvciBvdmVybGFwcGluZywgYW5kIHNr
aXAgdGhhdCBtZW02NC4KClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVs
Lm9yZz4KCi0tLQogYXJjaC9zcGFyYy9rZXJuZWwvcGNpX2NvbW1vbi5jIHwgICAgNyArKysrKyst
CiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpJbmRleDog
bGludXgtMi42L2FyY2gvc3BhcmMva2VybmVsL3BjaV9jb21tb24uYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBs
aW51eC0yLjYub3JpZy9hcmNoL3NwYXJjL2tlcm5lbC9wY2lfY29tbW9uLmMKKysrIGxpbnV4LTIu
Ni9hcmNoL3NwYXJjL2tlcm5lbC9wY2lfY29tbW9uLmMKQEAgLTQ4MywxMiArNDgzLDE3IEBAIHZv
aWQgcGNpX2RldGVybWluZV9tZW1faW9fc3BhY2Uoc3RydWN0IHAKIAkJCWlmIChtZW02NF9vZmZz
ZXQgIT0gcGJtLT5tZW1fb2Zmc2V0KQogCQkJCXBhbmljKCJtZW0gb2Zmc2V0ICVsbHggIT0gbWVt
NjQgb2Zmc2V0ICVsbHhcbiIsCiAJCQkJCXBibS0+bWVtX29mZnNldCwgbWVtNjRfb2Zmc2V0KTsK
KwkJCWlmIChwYm0tPm1lbTY0X3NwYWNlLnN0YXJ0IDw9IHBibS0+bWVtX3NwYWNlLmVuZCkKKwkJ
CQlwYm0tPm1lbTY0X3NwYWNlLnN0YXJ0ID0gcGJtLT5tZW1fc3BhY2UuZW5kICsgMTsKKwkJCWlm
IChwYm0tPm1lbTY0X3NwYWNlLnN0YXJ0ID4gcGJtLT5tZW02NF9zcGFjZS5lbmQpCisJCQkJcGJt
LT5tZW02NF9zcGFjZS5mbGFncyA9IDA7CiAJCX0gZWxzZQogCQkJcGJtLT5tZW1fb2Zmc2V0ID0g
bWVtNjRfb2Zmc2V0OworCX0KIAorCWlmIChwYm0tPm1lbTY0X3NwYWNlLmZsYWdzKQogCQlwcmlu
dGsoIiVzOiBQQ0kgTUVNNjQgJXBSIG9mZnNldCAlbGx4XG4iLAogCQkgICAgICAgcGJtLT5uYW1l
LCAmcGJtLT5tZW02NF9zcGFjZSwgcGJtLT5tZW1fb2Zmc2V0KTsKLQl9CiAKIAlwYm0tPmlvX3Nw
YWNlLm5hbWUgPSBwYm0tPm1lbV9zcGFjZS5uYW1lID0gcGJtLT5uYW1lOwogCXBibS0+bWVtNjRf
c3BhY2UubmFtZSA9IHBibS0+bmFtZTsK
--001a113dccc2a99a1f0521f6753f--
