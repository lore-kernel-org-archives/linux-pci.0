Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33968 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbbHXX7y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2015 19:59:54 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUAAQZ4RF9rTxthBCJAJyDkw1g3dckfeJ870gqK9Dzg9A@mail.gmail.com>
References: <1415089784-28779-1-git-send-email-daniel@numascale.com>
	<1415089784-28779-4-git-send-email-daniel@numascale.com>
	<20150821181910.GA31378@agluck-desk.sc.intel.com>
	<CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
	<20150821202707.GA920@agluck-desk.sc.intel.com>
	<CAE9FiQU-=oAzi_benuEm=x_Y_LUp48uND6cGnx9osbYyPWySdw@mail.gmail.com>
	<CA+8MBbL4nqTxi14Lz92PRFZeobHBLimSfcTH=9HaZBcEUpLVOg@mail.gmail.com>
	<CAE9FiQVJozeJ9R9GgMEVPfJaSJL+J+M3ULu2VXPjrdDqnYGwvw@mail.gmail.com>
	<CA+8MBb+yJ9ywFnmfCAEPF0ZBQfH1R9b8hzmwVpM8+rsyJkEW5Q@mail.gmail.com>
	<CAE9FiQUDb=uNKV9Bj34v3vvMT04MiuoRHqTq6=KTMd+DVrMVNg@mail.gmail.com>
	<CA+8MBbK6wu+7-M+fP8_GMmhUDSMZ4akOVRkW8xaP8x0pqJN0bQ@mail.gmail.com>
	<CAE9FiQUAAQZ4RF9rTxthBCJAJyDkw1g3dckfeJ870gqK9Dzg9A@mail.gmail.com>
Date: Mon, 24 Aug 2015 16:59:53 -0700
Message-ID: <CAE9FiQXH0SxTCaw-J=nEhYtbuZfBDU3R+v_XRZYF6ymeXnPsgg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] Use 2GB memory block size on large-memory x86-64 systems
From: Yinghai Lu <yinghai@kernel.org>
To: Tony Luck <tony.luck@gmail.com>
Cc: Daniel J Blueman <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>
Content-Type: multipart/mixed; boundary=001a113fb700f275b0051e176965
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a113fb700f275b0051e176965
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 24, 2015 at 4:41 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Aug 24, 2015 at 3:39 PM, Tony Luck <tony.luck@gmail.com> wrote:
>> On Mon, Aug 24, 2015 at 2:25 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>>> Can you boot with "debug ignore_loglevel" so we can see following print out
>>> for vmemmap?
>>
>> See attached. There are a few extra messages from my own debug printk()
>> calls. It seems that we successfully deal with node 0 from topology_init()
>> but die walking node 1. I see that the NODE_DATA limits for memory
>> on node 1 were from 1d70000 to 3a00000. But when we get into
>> register_mem_sect_under_node() we have rounded the start pfn down to
>> 1d00000 ... and we panic processing that range (which is in a hole in e820).
>>
>> We seem to die here:
>>
>>         for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
>>                 int page_nid;
>>
>>                 page_nid = get_nid_for_pfn(pfn);
>
> oh, no.
> register_mem_sect_under_node() is assuming:
> first section in the block is present and first page in that section is present.

attached should fix the problem:

--001a113fb700f275b0051e176965
Content-Type: text/x-patch; charset=US-ASCII;
	name="check_section_for_memory_block_register.patch"
Content-Disposition: attachment;
	filename="check_section_for_memory_block_register.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_idql5l2x0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9ub2RlLmMgYi9kcml2ZXJzL2Jhc2Uvbm9kZS5jCmlu
ZGV4IDMxZGY0NzRkLi5jYzkxMGFkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jhc2Uvbm9kZS5jCisr
KyBiL2RyaXZlcnMvYmFzZS9ub2RlLmMKQEAgLTM5MCw4ICszOTAsMTQgQEAgaW50IHJlZ2lzdGVy
X21lbV9zZWN0X3VuZGVyX25vZGUoc3RydWN0IG1lbW9yeV9ibG9jayAqbWVtX2JsaywgaW50IG5p
ZCkKIAlzZWN0X2VuZF9wZm4gPSBzZWN0aW9uX25yX3RvX3BmbihtZW1fYmxrLT5lbmRfc2VjdGlv
bl9ucik7CiAJc2VjdF9lbmRfcGZuICs9IFBBR0VTX1BFUl9TRUNUSU9OIC0gMTsKIAlmb3IgKHBm
biA9IHNlY3Rfc3RhcnRfcGZuOyBwZm4gPD0gc2VjdF9lbmRfcGZuOyBwZm4rKykgewotCQlpbnQg
cGFnZV9uaWQ7CisJCWludCBwYWdlX25pZCwgc2NuX25yOwogCisJCXNjbl9uciA9IHBmbl90b19z
ZWN0aW9uX25yKHBmbik7CisJCWlmICghcHJlc2VudF9zZWN0aW9uX25yKHNjbl9ucikpIHsKKwkJ
CXBmbiA9IHJvdW5kX2Rvd24ocGZuICsgUEFHRVNfUEVSX1NFQ1RJT04sCisJCQkJCSBQQUdFU19Q
RVJfU0VDVElPTikgLSAxOworCQkJY29udGludWU7CisJCX0KIAkJcGFnZV9uaWQgPSBnZXRfbmlk
X2Zvcl9wZm4ocGZuKTsKIAkJaWYgKHBhZ2VfbmlkIDwgMCkKIAkJCWNvbnRpbnVlOwpAQCAtNDI2
LDEwICs0MzIsMTggQEAgaW50IHVucmVnaXN0ZXJfbWVtX3NlY3RfdW5kZXJfbm9kZXMoc3RydWN0
IG1lbW9yeV9ibG9jayAqbWVtX2JsaywKIAkJcmV0dXJuIC1FTk9NRU07CiAJbm9kZXNfY2xlYXIo
KnVubGlua2VkX25vZGVzKTsKIAotCXNlY3Rfc3RhcnRfcGZuID0gc2VjdGlvbl9ucl90b19wZm4o
cGh5c19pbmRleCk7Ci0Jc2VjdF9lbmRfcGZuID0gc2VjdF9zdGFydF9wZm4gKyBQQUdFU19QRVJf
U0VDVElPTiAtIDE7CisJc2VjdF9zdGFydF9wZm4gPSBzZWN0aW9uX25yX3RvX3BmbihtZW1fYmxr
LT5zdGFydF9zZWN0aW9uX25yKTsKKwlzZWN0X2VuZF9wZm4gPSBzZWN0aW9uX25yX3RvX3Bmbiht
ZW1fYmxrLT5lbmRfc2VjdGlvbl9ucik7CisJc2VjdF9lbmRfcGZuICs9IFBBR0VTX1BFUl9TRUNU
SU9OIC0gMTsKIAlmb3IgKHBmbiA9IHNlY3Rfc3RhcnRfcGZuOyBwZm4gPD0gc2VjdF9lbmRfcGZu
OyBwZm4rKykgewotCQlpbnQgbmlkOworCQlpbnQgbmlkLCBzY25fbnI7CisKKwkJc2NuX25yID0g
cGZuX3RvX3NlY3Rpb25fbnIocGZuKTsKKwkJaWYgKCFwcmVzZW50X3NlY3Rpb25fbnIoc2NuX25y
KSkgeworCQkJcGZuID0gcm91bmRfZG93bihwZm4gKyBQQUdFU19QRVJfU0VDVElPTiwKKwkJCQkJ
IFBBR0VTX1BFUl9TRUNUSU9OKSAtIDE7CisJCQljb250aW51ZTsKKwkJfQogCiAJCW5pZCA9IGdl
dF9uaWRfZm9yX3BmbihwZm4pOwogCQlpZiAobmlkIDwgMCkK
--001a113fb700f275b0051e176965--
