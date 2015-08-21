Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36534 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbbHUSiO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 14:38:14 -0400
MIME-Version: 1.0
In-Reply-To: <20150821181910.GA31378@agluck-desk.sc.intel.com>
References: <1415089784-28779-1-git-send-email-daniel@numascale.com>
	<1415089784-28779-4-git-send-email-daniel@numascale.com>
	<20150821181910.GA31378@agluck-desk.sc.intel.com>
Date: Fri, 21 Aug 2015 11:38:13 -0700
Message-ID: <CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] Use 2GB memory block size on large-memory x86-64 systems
From: Yinghai Lu <yinghai@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Daniel J Blueman <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>
Content-Type: multipart/mixed; boundary=001a1140945c065e01051dd692a3
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a1140945c065e01051dd692a3
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 21, 2015 at 11:19 AM, Luck, Tony <tony.luck@intel.com> wrote:
> On Tue, Nov 04, 2014 at 04:29:44PM +0800, Daniel J Blueman wrote:
>> On large-memory x86-64 systems of 64GB or more with memory hot-plug
>> enabled, use a 2GB memory block size. Eg with 64GB memory, this reduces
>> the number of directories in /sys/devices/system/memory from 512 to 32,
>> making it more manageable, and reducing the creation time accordingly.
>>
>> This caveat is that the memory can't be offlined (for hotplug or otherwise)
>> with finer 128MB granularity, but this is unimportant due to the high
>> memory densities generally used with such large-memory systems, where
>> eg a single DIMM is the order of 16GB.
>
> git bisect points to this commit as the cause of a panic on my
> machine:
>
> [    4.518415] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    4.525882] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [    4.536280] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> [    4.544344] PCI: Using configuration type 1 for base access
> [    4.550778] BUG: unable to handle kernel paging request at ffffea0078000020
> [    4.558572] IP: [<ffffffff8142ab0d>] register_mem_sect_under_
...
> so the older code will look at max_pfn and set memory block size:
>
> [    3.021752] memory block size : 256MB
>
> I think the problem is more connected to the strange max_pfn rather
> than the holes ... but will defer to wiser heads.
>
> If the problem is with max_pfn ... I don't think it is a safe assumption
> that systems with >64GB memory will have 2GB aligned max_pfn.

That commit could be reverted.
According to
https://lkml.org/lkml/2014/11/10/123

I had attached patch for my test setups for a while.

Yinghai

--001a1140945c065e01051dd692a3
Content-Type: text/x-patch; charset=US-ASCII; name="revert_commit_bdee237.patch"
Content-Disposition: attachment; filename="revert_commit_bdee237.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_idlzbggp0

U3ViamVjdDogW1BBVENIXSB4ODYsIG1tOiBwdXQgbWVtb3J5IGJsb2NrIHNpemUgcHJvYmluZyBi
YWNrCgpjb21taXQgYmRlZTIzN2MwMzQzICgieDg2OiBtbTogVXNlIDJHQiBtZW1vcnkgYmxvY2sg
c2l6ZSBvbiBsYXJnZS1tZW1vcnkgeDg2LTY0IHN5c3RlbXMiKQpsZXQgc3lzdGVtIHdpdGggbW9y
ZSB0aGFuIDY0R2lCIHJhbSBqdXN0IHVzZSAyRyBhcyBtZW1vcnkgYmxvY2sKc2l6ZSB3aXRob3V0
IHByb2JpbmcuCgpmb3VuZCBvbmUgc3lzdGVtOiBoYXMgbWVtb3J5IG1hcCBsaWtlOgpbMHgwMDAw
MDAwMC0weDYwMDAwMDAwKQpbMHgxMDAwMDAwMDAtMHgyMGEwMDAwMDAwKQoKV2Ugc2hvdWxkIHVz
ZSAweDIwMDAwMDAwIGluIHRoaXMgY2FzZS4gU28gY2FuIG5vdCBhc3N1bWUgc3lzdGVtIHdpdGgg
YmlnCm1lbW9yeSBoYXZlIDJnIHRhaWwgYW55bW9yZS4KClNvIHJldmVydCBpdCB0byBwdXQgcHJv
YmluZyBiYWNrLgoKRml4ZXM6IGJkZWUyMzdjMDM0MyAoIng4NjogbW06IFVzZSAyR0IgbWVtb3J5
IGJsb2NrIHNpemUgb24gbGFyZ2UtbWVtb3J5IHg4Ni02NCBzeXN0ZW1zIikKU2lnbmVkLW9mZi1i
eTogWWluZ2hhaSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPgoKLS0tCiBhcmNoL3g4Ni9tbS9pbml0
XzY0LmMgfCAgICA3ICsrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtMi42L2FyY2gveDg2L21tL2luaXRfNjQuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9hcmNoL3g4Ni9tbS9pbml0XzY0LmMKKysrIGxpbnV4
LTIuNi9hcmNoL3g4Ni9tbS9pbml0XzY0LmMKQEAgLTUyLDYgKzUyLDcgQEAKICNpbmNsdWRlIDxh
c20vbnVtYS5oPgogI2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+CiAjaW5jbHVkZSA8YXNtL2lu
aXQuaD4KKyNpbmNsdWRlIDxhc20vdXYvdXYuaD4KICNpbmNsdWRlIDxhc20vc2V0dXAuaD4KIAog
I2luY2x1ZGUgIm1tX2ludGVybmFsLmgiCkBAIC0xMjA0LDEwICsxMjA1LDEyIEBAIHN0YXRpYyB1
bnNpZ25lZCBsb25nIHByb2JlX21lbW9yeV9ibG9ja18KIAkvKiBzdGFydCBmcm9tIDJnICovCiAJ
dW5zaWduZWQgbG9uZyBieiA9IDFVTDw8MzE7CiAKLQlpZiAodG90YWxyYW1fcGFnZXMgPj0gKDY0
VUxMIDw8ICgzMCAtIFBBR0VfU0hJRlQpKSkgewotCQlwcl9pbmZvKCJVc2luZyAyR0IgbWVtb3J5
IGJsb2NrIHNpemUgZm9yIGxhcmdlLW1lbW9yeSBzeXN0ZW1cbiIpOworI2lmZGVmIENPTkZJR19Y
ODZfVVYKKwlpZiAoaXNfdXZfc3lzdGVtKCkpIHsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiVVY6IG1l
bW9yeSBibG9jayBzaXplIDJHQlxuIik7CiAJCXJldHVybiAyVUwgKiAxMDI0ICogMTAyNCAqIDEw
MjQ7CiAJfQorI2VuZGlmCiAKIAkvKiBsZXNzIHRoYW4gNjRnIGluc3RhbGxlZCAqLwogCWlmICgo
bWF4X3BmbiA8PCBQQUdFX1NISUZUKSA8ICgxNlVMIDw8IDMyKSkK
--001a1140945c065e01051dd692a3--
