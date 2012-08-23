Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33651 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934225Ab2HWTaG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Aug 2012 15:30:06 -0400
Received: by vbbff1 with SMTP id ff1so1212779vbb.19
        for <linux-pci@vger.kernel.org>; Thu, 23 Aug 2012 12:30:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120823050958.GB2332@ram-ThinkPad-T61>
References: <CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
	<20120816032602.GN2449@ram-ThinkPad-T61>
	<CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
	<20120816044104.GQ2449@ram-ThinkPad-T61>
	<20120821151245.GA2356@ram-ThinkPad-T61>
	<CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
	<20120822101533.GA2332@ram-ThinkPad-T61>
	<CAE9FiQVDkzFkjrBrZC9JpLW7JoquE_f-5BKGrbmmZMHFVcw=cw@mail.gmail.com>
	<CAE9FiQW5KkgszD2F4aez-jtXABkiPmUDVqTiFF8MDNKxWLopxA@mail.gmail.com>
	<CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
	<20120823050958.GB2332@ram-ThinkPad-T61>
Date: Thu, 23 Aug 2012 12:30:05 -0700
Message-ID: <CAE9FiQVq=6Shv_4taNzN3h4OBs1PgoFJZqV0i3tRvmz04qZbXw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 ]pci: pci resource iterator
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary=bcaec54b5434f330c004c7f3e2cd
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--bcaec54b5434f330c004c7f3e2cd
Content-Type: text/plain; charset=ISO-8859-1

Hi, Ram and Bjorn,

On Wed, Aug 22, 2012 at 10:09 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> +static inline int pci_next_resource_idx(int i, int flag)
> +{
> +       while (++i < PCI_NUM_RESOURCES) {
> +               if ((i >= 0 && i < PCI_ROM_RESOURCE && (flag & PCI_STD_RES)) ||
> +                   (i == PCI_ROM_RESOURCE && (flag & PCI_ROM_RES)) ||
> +#ifdef CONFIG_PCI_IOV
> +                   (i <= PCI_IOV_RESOURCE_END && (flag & PCI_IOV_RES)) ||
> +#endif
> +                   (i <= PCI_BRIDGE_RESOURCE_END && (flag & PCI_BRIDGE_RES)))
> +                       return i;
> +       }
> +       return -1;
> +}

no, you can not merge them.
when it start as -1, and user only need the bridge resource, it will
loop from 0 to 16.

I optimized it more to skip some searching. please check v5 and v6.
v5 will store aside the mask, and use the bit map later.
v6 will still to do the local checking, but will skip some ++i loop.

it seems v5 is more efficient while it will need 16*8 bytes for mask storage.

v5: pci_next_resource_idx:
000000000000098c <pci_next_resource_idx>:
     98c:       55                      push   %rbp
     98d:       48 89 e5                mov    %rsp,%rbp
     990:       53                      push   %rbx
     991:       41 50                   push   %r8
     993:       e8 00 00 00 00          callq  998 <pci_next_resource_idx+0xc>
     998:       89 fb                   mov    %edi,%ebx
     99a:       89 f7                   mov    %esi,%edi
     99c:       ff c3                   inc    %ebx
     99e:       e8 d1 fe ff ff          callq  874 <get_res_idx_mask>
     9a3:       48 89 c7                mov    %rax,%rdi
     9a6:       83 c8 ff                or     $0xffffffffffffffff,%eax
     9a9:       83 fb 10                cmp    $0x10,%ebx
     9ac:       7f 18                   jg     9c6 <pci_next_resource_idx+0x3a>
     9ae:       48 63 d3                movslq %ebx,%rdx
     9b1:       be 11 00 00 00          mov    $0x11,%esi
     9b6:       e8 00 00 00 00          callq  9bb <pci_next_resource_idx+0x2f>
     9bb:       ba ff ff ff ff          mov    $0xffffffff,%edx
     9c0:       83 f8 11                cmp    $0x11,%eax
     9c3:       0f 4d c2                cmovge %edx,%eax
     9c6:       59                      pop    %rcx
     9c7:       5b                      pop    %rbx
     9c8:       5d                      pop    %rbp
     9c9:       c3                      retq

v6: would need to more code in pci_next_resource_idx:
00000000000008e1 <pci_next_resource_idx>:
     8e1:       55                      push   %rbp
     8e2:       48 89 e5                mov    %rsp,%rbp
     8e5:       e8 00 00 00 00          callq  8ea <pci_next_resource_idx+0x9>
     8ea:       89 f1                   mov    %esi,%ecx
     8ec:       89 f2                   mov    %esi,%edx
     8ee:       89 f8                   mov    %edi,%eax
     8f0:       89 f7                   mov    %esi,%edi
     8f2:       83 e1 04                and    $0x4,%ecx
     8f5:       83 e2 02                and    $0x2,%edx
     8f8:       83 e7 08                and    $0x8,%edi
     8fb:       83 e6 01                and    $0x1,%esi
     8fe:       eb 35                   jmp    935 <pci_next_resource_idx+0x54>
     900:       85 c0                   test   %eax,%eax
     902:       78 1c                   js     920 <pci_next_resource_idx+0x3f>
     904:       83 f8 05                cmp    $0x5,%eax
     907:       7f 07                   jg     910 <pci_next_resource_idx+0x2f>
     909:       40 84 f6                test   %sil,%sil
     90c:       75 38                   jne    946 <pci_next_resource_idx+0x65>
     90e:       eb 05                   jmp    915 <pci_next_resource_idx+0x34>
     910:       83 f8 06                cmp    $0x6,%eax
     913:       75 0b                   jne    920 <pci_next_resource_idx+0x3f>
     915:       85 d2                   test   %edx,%edx
     917:       75 28                   jne    941 <pci_next_resource_idx+0x60>
     919:       b8 07 00 00 00          mov    $0x7,%eax
     91e:       eb 0a                   jmp    92a <pci_next_resource_idx+0x49>
     920:       83 f8 06                cmp    $0x6,%eax
     923:       7e 10                   jle    935 <pci_next_resource_idx+0x54>
     925:       83 f8 0c                cmp    $0xc,%eax
     928:       7f 1e                   jg     948 <pci_next_resource_idx+0x67>
     92a:       85 c9                   test   %ecx,%ecx
     92c:       75 18                   jne    946 <pci_next_resource_idx+0x65>
     92e:       b8 0d 00 00 00          mov    $0xd,%eax
     933:       eb 13                   jmp    948 <pci_next_resource_idx+0x67>
     935:       ff c0                   inc    %eax
     937:       83 f8 10                cmp    $0x10,%eax
     93a:       7e c4                   jle    900 <pci_next_resource_idx+0x1f>
     93c:       83 c8 ff                or     $0xffffffffffffffff,%eax
     93f:       eb 05                   jmp    946 <pci_next_resource_idx+0x65>
     941:       b8 06 00 00 00          mov    $0x6,%eax
     946:       5d                      pop    %rbp
     947:       c3                      retq
     948:       85 ff                   test   %edi,%edi
     94a:       75 fa                   jne    946 <pci_next_resource_idx+0x65>
     94c:       b8 11 00 00 00          mov    $0x11,%eax
     951:       eb e2                   jmp    935 <pci_next_resource_idx+0x54>

So just -v5 from now?

Please let me know which one is good, so I could rebase
for-pci-for-each-res-addon branch,
and then Ram could rebase his patches to top of new
for-pci-each-res-addon branch.

Thanks

Yinghai

--bcaec54b5434f330c004c7f3e2cd
Content-Type: application/octet-stream; name="ram_pci_it_v5.patch"
Content-Disposition: attachment; filename="ram_pci_it_v5.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h688jr2w0

LS0tCiBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgICA0OCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvbGludXgvcGNpLmggfCAgIDI0ICsrKysr
KysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspCgpJ
bmRleDogbGludXgtMi42L2luY2x1ZGUvbGludXgvcGNpLmgKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgt
Mi42Lm9yaWcvaW5jbHVkZS9saW51eC9wY2kuaAorKysgbGludXgtMi42L2luY2x1ZGUvbGludXgv
cGNpLmgKQEAgLTM3Myw2ICszNzMsMzAgQEAgc3RydWN0IHBjaV9kZXYgewogc3RydWN0IHJlc291
cmNlICpwY2lfZGV2X3Jlc291cmNlX24oc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IG4pOwogaW50
IHBjaV9kZXZfcmVzb3VyY2VfaWR4KHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0cnVjdCByZXNvdXJj
ZSAqcmVzKTsKIAorI2RlZmluZSBQQ0lfU1REX1JFUwkJKDE8PDApCisjZGVmaW5lIFBDSV9ST01f
UkVTCQkoMTw8MSkKKyNkZWZpbmUgUENJX0lPVl9SRVMJCSgxPDwyKQorI2RlZmluZSBQQ0lfQlJJ
REdFX1JFUwkJKDE8PDMpCisjZGVmaW5lIFBDSV9SRVNfQkxPQ0tfTlVNCTQKKworI2RlZmluZSBQ
Q0lfQUxMX1JFUwkJKFBDSV9TVERfUkVTIHwgUENJX1JPTV9SRVMgfCBQQ0lfQlJJREdFX1JFUyB8
IFBDSV9JT1ZfUkVTKQorI2RlZmluZSBQQ0lfTk9TVERfUkVTCQkoUENJX0FMTF9SRVMgJiB+UENJ
X1NURF9SRVMpCisjZGVmaW5lIFBDSV9OT0lPVl9SRVMJCShQQ0lfQUxMX1JFUyAmIH5QQ0lfSU9W
X1JFUykKKyNkZWZpbmUgUENJX05PUk9NX1JFUwkJKFBDSV9BTExfUkVTICYgflBDSV9ST01fUkVT
KQorI2RlZmluZSBQQ0lfTk9CUklER0VfUkVTCShQQ0lfQUxMX1JFUyAmIH5QQ0lfQlJJREdFX1JF
UykKKyNkZWZpbmUgUENJX1NURF9ST01fUkVTCQkoUENJX1NURF9SRVMgfCBQQ0lfUk9NX1JFUykK
KyNkZWZpbmUgUENJX1NURF9JT1ZfUkVTCQkoUENJX1NURF9SRVMgfCBQQ0lfSU9WX1JFUykKKyNk
ZWZpbmUgUENJX1NURF9ST01fSU9WX1JFUwkoUENJX1NURF9SRVMgfCBQQ0lfUk9NX1JFUyB8IFBD
SV9JT1ZfUkVTKQorCitpbnQgcGNpX25leHRfcmVzb3VyY2VfaWR4KGludCBpLCBpbnQgZmxhZyk7
CisKKyNkZWZpbmUgZm9yX2VhY2hfcGNpX3Jlc291cmNlKGRldiwgcmVzLCBpLCBmbGFnKQlcCisJ
Zm9yIChpID0gcGNpX25leHRfcmVzb3VyY2VfaWR4KC0xLCBmbGFnKSwJXAorCQlyZXMgPSBwY2lf
ZGV2X3Jlc291cmNlX24oZGV2LCBpKTsJXAorCSAgICAgcmVzOwkJCQkJXAorCSAgICAgaSA9IHBj
aV9uZXh0X3Jlc291cmNlX2lkeChpLCBmbGFnKSwJXAorCQlyZXMgPSBwY2lfZGV2X3Jlc291cmNl
X24oZGV2LCBpKSkKKwogc3RhdGljIGlubGluZSBzdHJ1Y3QgcGNpX2RldiAqcGNpX3BoeXNmbihz
dHJ1Y3QgcGNpX2RldiAqZGV2KQogewogI2lmZGVmIENPTkZJR19QQ0lfSU9WCkluZGV4OiBsaW51
eC0yLjYvZHJpdmVycy9wY2kvcHJvYmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9k
cml2ZXJzL3BjaS9wcm9iZS5jCisrKyBsaW51eC0yLjYvZHJpdmVycy9wY2kvcHJvYmUuYwpAQCAt
MTI0LDYgKzEyNCw1NCBAQCBpbnQgcGNpX2Rldl9yZXNvdXJjZV9pZHgoc3RydWN0IHBjaV9kZXYK
IAlyZXR1cm4gLTE7CiB9CiAKK3N0YXRpYyB2b2lkIF9faW5pdF9yZXNfaWR4X21hc2sodW5zaWdu
ZWQgbG9uZyAqbWFzaywgaW50IGZsYWcpCit7CisJYml0bWFwX3plcm8obWFzaywgUENJX05VTV9S
RVNPVVJDRVMpOworCWlmIChmbGFnICYgUENJX1NURF9SRVMpCisJCWJpdG1hcF9zZXQobWFzaywg
UENJX1NURF9SRVNPVVJDRVMsCisJCQlQQ0lfU1REX1JFU09VUkNFX0VORCAtIFBDSV9TVERfUkVT
T1VSQ0VTICsgMSk7CisJaWYgKGZsYWcgJiBQQ0lfUk9NX1JFUykKKwkJYml0bWFwX3NldChtYXNr
LCBQQ0lfUk9NX1JFU09VUkNFLCAxKTsKKyNpZmRlZiBDT05GSUdfUENJX0lPVgorCWlmIChmbGFn
ICYgUENJX0lPVl9SRVMpCisJCWJpdG1hcF9zZXQobWFzaywgUENJX0lPVl9SRVNPVVJDRVMsCisJ
CQlQQ0lfSU9WX1JFU09VUkNFX0VORCAtIFBDSV9JT1ZfUkVTT1VSQ0VTICsgMSk7CisjZW5kaWYK
KwlpZiAoZmxhZyAmIFBDSV9CUklER0VfUkVTKQorCQliaXRtYXBfc2V0KG1hc2ssIFBDSV9CUklE
R0VfUkVTT1VSQ0VTLAorCQkJUENJX0JSSURHRV9SRVNPVVJDRV9FTkQgLSBQQ0lfQlJJREdFX1JF
U09VUkNFUyArIDEpOworfQorCitzdGF0aWMgYm9vbCByZXNfaWR4X21hc2tfaW5pdGVkOworc3Rh
dGljIERFQ0xBUkVfQklUTUFQKHJlc19pZHhfbWFza1sxIDw8IFBDSV9SRVNfQkxPQ0tfTlVNXSwg
UENJX05VTV9SRVNPVVJDRVMpOworc3RhdGljIHVuc2lnbmVkIGxvbmcgKmdldF9yZXNfaWR4X21h
c2soaW50IGZsYWcpCit7CisJaW50IGk7CisKKwlpZiAoIXJlc19pZHhfbWFza19pbml0ZWQpIHsK
KwkJZm9yIChpID0gMDsgaSA8ICgxIDw8IFBDSV9SRVNfQkxPQ0tfTlVNKTsgaSsrKQorCQkJX19p
bml0X3Jlc19pZHhfbWFzayhyZXNfaWR4X21hc2tbaV0sIGkpOworCisJCXJlc19pZHhfbWFza19p
bml0ZWQgPSB0cnVlOworCX0KKworCXJldHVybiByZXNfaWR4X21hc2tbZmxhZyAmICgoMSA8PCBQ
Q0lfUkVTX0JMT0NLX05VTSkgLSAxKV07Cit9CisKK2ludCBwY2lfbmV4dF9yZXNvdXJjZV9pZHgo
aW50IGksIGludCBmbGFnKQoreworCXVuc2lnbmVkIGxvbmcgKm1hc2sgPSBnZXRfcmVzX2lkeF9t
YXNrKGZsYWcpOworCisJaSsrOworCWlmIChpIDwgUENJX05VTV9SRVNPVVJDRVMpCisJCWkgPSBm
aW5kX25leHRfYml0KG1hc2ssIFBDSV9OVU1fUkVTT1VSQ0VTLCBpKTsKKworCWlmIChpIDwgUENJ
X05VTV9SRVNPVVJDRVMpCisJCXJldHVybiBpOworCisJcmV0dXJuIC0xOworfQorCiBzdGF0aWMg
dTY0IHBjaV9zaXplKHU2NCBiYXNlLCB1NjQgbWF4YmFzZSwgdTY0IG1hc2spCiB7CiAJdTY0IHNp
emUgPSBtYXNrICYgbWF4YmFzZTsJLyogRmluZCB0aGUgc2lnbmlmaWNhbnQgYml0cyAqLwo=
--bcaec54b5434f330c004c7f3e2cd
Content-Type: application/octet-stream; name="ram_pci_it_v6.patch"
Content-Disposition: attachment; filename="ram_pci_it_v6.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h688k93r1

LS0tCiBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgICAzNCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiBpbmNsdWRlL2xpbnV4L3BjaS5oIHwgICAyMyArKysrKysrKysrKysrKysrKysr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspCgpJbmRleDogbGludXgtMi42
L2luY2x1ZGUvbGludXgvcGNpLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvaW5jbHVk
ZS9saW51eC9wY2kuaAorKysgbGludXgtMi42L2luY2x1ZGUvbGludXgvcGNpLmgKQEAgLTM3Myw2
ICszNzMsMjkgQEAgc3RydWN0IHBjaV9kZXYgewogc3RydWN0IHJlc291cmNlICpwY2lfZGV2X3Jl
c291cmNlX24oc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IG4pOwogaW50IHBjaV9kZXZfcmVzb3Vy
Y2VfaWR4KHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0cnVjdCByZXNvdXJjZSAqcmVzKTsKIAorI2Rl
ZmluZSBQQ0lfU1REX1JFUwkJKDE8PDApCisjZGVmaW5lIFBDSV9ST01fUkVTCQkoMTw8MSkKKyNk
ZWZpbmUgUENJX0lPVl9SRVMJCSgxPDwyKQorI2RlZmluZSBQQ0lfQlJJREdFX1JFUwkJKDE8PDMp
CisKKyNkZWZpbmUgUENJX0FMTF9SRVMJCShQQ0lfU1REX1JFUyB8IFBDSV9ST01fUkVTIHwgUENJ
X0JSSURHRV9SRVMgfCBQQ0lfSU9WX1JFUykKKyNkZWZpbmUgUENJX05PU1REX1JFUwkJKFBDSV9B
TExfUkVTICYgflBDSV9TVERfUkVTKQorI2RlZmluZSBQQ0lfTk9JT1ZfUkVTCQkoUENJX0FMTF9S
RVMgJiB+UENJX0lPVl9SRVMpCisjZGVmaW5lIFBDSV9OT1JPTV9SRVMJCShQQ0lfQUxMX1JFUyAm
IH5QQ0lfUk9NX1JFUykKKyNkZWZpbmUgUENJX05PQlJJREdFX1JFUwkoUENJX0FMTF9SRVMgJiB+
UENJX0JSSURHRV9SRVMpCisjZGVmaW5lIFBDSV9TVERfUk9NX1JFUwkJKFBDSV9TVERfUkVTIHwg
UENJX1JPTV9SRVMpCisjZGVmaW5lIFBDSV9TVERfSU9WX1JFUwkJKFBDSV9TVERfUkVTIHwgUENJ
X0lPVl9SRVMpCisjZGVmaW5lIFBDSV9TVERfUk9NX0lPVl9SRVMJKFBDSV9TVERfUkVTIHwgUENJ
X1JPTV9SRVMgfCBQQ0lfSU9WX1JFUykKKworaW50IHBjaV9uZXh0X3Jlc291cmNlX2lkeChpbnQg
aSwgaW50IGZsYWcpOworCisjZGVmaW5lIGZvcl9lYWNoX3BjaV9yZXNvdXJjZShkZXYsIHJlcywg
aSwgZmxhZykJXAorCWZvciAoaSA9IHBjaV9uZXh0X3Jlc291cmNlX2lkeCgtMSwgZmxhZyksCVwK
KwkJcmVzID0gcGNpX2Rldl9yZXNvdXJjZV9uKGRldiwgaSk7CVwKKwkgICAgIHJlczsJCQkJCVwK
KwkgICAgIGkgPSBwY2lfbmV4dF9yZXNvdXJjZV9pZHgoaSwgZmxhZyksCVwKKwkJcmVzID0gcGNp
X2Rldl9yZXNvdXJjZV9uKGRldiwgaSkpCisKIHN0YXRpYyBpbmxpbmUgc3RydWN0IHBjaV9kZXYg
KnBjaV9waHlzZm4oc3RydWN0IHBjaV9kZXYgKmRldikKIHsKICNpZmRlZiBDT05GSUdfUENJX0lP
VgpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNpL3Byb2JlLmMKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGlu
dXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvcHJvYmUuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNp
L3Byb2JlLmMKQEAgLTEyNCw2ICsxMjQsNDAgQEAgaW50IHBjaV9kZXZfcmVzb3VyY2VfaWR4KHN0
cnVjdCBwY2lfZGV2CiAJcmV0dXJuIC0xOwogfQogCitzdGF0aWMgYm9vbCBjaGVja19yZXNvdXJj
ZV9pZHgoaW50ICppLCBpbnQgc3RhcnQsIGludCBlbmQsIGJvb2wgbWF0Y2gpCit7CisJaWYgKCpp
ID49IHN0YXJ0ICYmICppIDw9IGVuZCkgeworCQlpZiAobWF0Y2gpCisJCQlyZXR1cm4gdHJ1ZTsK
KwkJZWxzZQorCQkJKmkgPSBlbmQgKyAxOworCX0KKwlyZXR1cm4gZmFsc2U7Cit9CisKK2ludCBw
Y2lfbmV4dF9yZXNvdXJjZV9pZHgoaW50IGksIGludCBmbGFnKQoreworCXdoaWxlICgrK2kgPCBQ
Q0lfTlVNX1JFU09VUkNFUykgeworCQlpZiAoY2hlY2tfcmVzb3VyY2VfaWR4KCZpLCBQQ0lfU1RE
X1JFU09VUkNFUywKKwkJCQlQQ0lfU1REX1JFU09VUkNFX0VORCwgISEoZmxhZyAmIFBDSV9TVERf
UkVTKSkpCisJCQlyZXR1cm4gaTsKKwkJaWYgKGNoZWNrX3Jlc291cmNlX2lkeCgmaSwgUENJX1JP
TV9SRVNPVVJDRSwKKwkJCQlQQ0lfUk9NX1JFU09VUkNFLCAhIShmbGFnICYgUENJX1JPTV9SRVMp
KSkKKwkJCXJldHVybiBpOworI2lmZGVmIENPTkZJR19QQ0lfSU9WCisJCWlmIChjaGVja19yZXNv
dXJjZV9pZHgoJmksIFBDSV9JT1ZfUkVTT1VSQ0VTLAorCQkJCSBQQ0lfSU9WX1JFU09VUkNFX0VO
RCwgISEoZmxhZyAmIFBDSV9JT1ZfUkVTKSkpCisJCQlyZXR1cm4gaTsKKyNlbmRpZgorCQlpZiAo
Y2hlY2tfcmVzb3VyY2VfaWR4KCZpLCBQQ0lfQlJJREdFX1JFU09VUkNFUywKKwkJCQlQQ0lfQlJJ
REdFX1JFU09VUkNFX0VORCwKKwkJCQkhIShmbGFnICYgUENJX0JSSURHRV9SRVMpKSkKKwkJCXJl
dHVybiBpOworCX0KKworCXJldHVybiAtMTsKK30KKwogc3RhdGljIHU2NCBwY2lfc2l6ZSh1NjQg
YmFzZSwgdTY0IG1heGJhc2UsIHU2NCBtYXNrKQogewogCXU2NCBzaXplID0gbWFzayAmIG1heGJh
c2U7CS8qIEZpbmQgdGhlIHNpZ25pZmljYW50IGJpdHMgKi8K
--bcaec54b5434f330c004c7f3e2cd--
