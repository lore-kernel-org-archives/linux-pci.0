Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49060 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab2APBO0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2012 20:14:26 -0500
Received: by yhnn56 with SMTP id n56so953134yhn.19
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2012 17:14:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120115160558.GA2601@ram-ThinkPad-T61>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120113163922.GH7380@ram-ThinkPad-T61>
	<CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
	<20120115160558.GA2601@ram-ThinkPad-T61>
Date: Sun, 15 Jan 2012 17:14:26 -0800
Message-ID: <CAE9FiQX2wG9pEZHJE8LD7kL=eiCnFsaS6dRmyNf8F2Kgg=WcpQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	peter.henriksson@gmail.com
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: multipart/mixed; boundary=20cf303b431b7f2cd904b69aefef
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--20cf303b431b7f2cd904b69aefef
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 15, 2012 at 8:05 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Fri, Jan 13, 2012 at 03:28:29PM -0800, Yinghai Lu wrote:
>> On Fri, Jan 13, 2012 at 8:39 AM, Ram Pai <linuxram@us.ibm.com> wrote:
>> > On Wed, Dec 07, 2011 at 12:53:01AM -0800, Yinghai Lu wrote:
>> >
>> > =A0 =A0 =A0 =A0I am worried that this approach will resurface old bug
>> > https://bugzilla.kernel.org/show_bug.cgi?id=3D15960
>>
>>
>> so even required can not be satisfied?
>
> Yes. Even required cannot be satisfied fully.

double check that bug, it is caused by we stop IO type too early.

attached patch should fix the problem.

Also I updated for-pci2 in my tree.

	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci2

Peter Henriksson,
Can you try for-pci2 branch on your setup with Xonar DX?

also we need to ask Linus to test it, looks like Linus have one setup
with Nouveau.

Thanks

Yinghai

--20cf303b431b7f2cd904b69aefef
Content-Type: text/x-patch; charset=US-ASCII; name="pci_assign_unassigned_ioport.patch"
Content-Disposition: attachment;
	filename="pci_assign_unassigned_ioport.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxgsnbcr0

U3ViamVjdDogW1BBVENIXSBQQ0k6IFJldHJ5IG9uIHR5cGUgSU9SRVNPVVJDRV9JTyBhbGxvY2F0
aW9uLgoKRHVyaW5nIHJlZW5hYmxpbmcgcGNpIHJlYWxsb2NhdGluZyBmb3IgcGNpIGJyaWRnZSBi
eSBjbGVhbiB0aGUgc21hbGwgc2l6ZSBpbgpicmlkZ2UgYW5kIGFzc2lnbiB3aXRoIHJlcXVlc3Rl
ZCArIG9wdGlvbmFsIHNpemUgZm9yIGZpcnN0IHNldmVyYWwgdHJ5LApSYW0gbWVudGlvbiBjb3Vs
ZCBoYXZlIHByb2JsZW0gd2l0aCBvbmUgY2FzZQoJaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
L3Nob3dfYnVnLmNnaT9pZD0xNTk2MAoKQWZ0ZXIgY2hlY2tpbmcgdGhlIGJvb3RpbmcgbG9nIGlu
CglodHRwczovL2xrbWwub3JnL2xrbWwvMjAxMC80LzE5LzQ0CglbcmVncmVzc2lvbiwgYmlzZWN0
ZWRdIFhvbmFyIERYIGludmFsaWQgUENJIEkvTyByYW5nZSBzaW5jZSA5NzdkMTdiYjE3NAoKV2Ug
c2hvdWxkIG5vdCBzdG9wIHRvbyBlYXJseSBmb3IgaW8gcG9ydHMuCglBcHIgMTkgMTA6MTk6Mzgg
W2tlcm5lbF0gcGNpIDAwMDA6MDQ6MDAuMDogQkFSIDc6IGNhbid0IGFzc2lnbiBpbyAoc2l6ZSAw
eDQwMDApCglBcHIgMTkgMTA6MTk6MzggW2tlcm5lbF0gcGNpIDAwMDA6MDU6MDEuMDogQkFSIDg6
IGFzc2lnbmVkIFttZW0gMHg4MDQwMDAwMC0weDgwNWZmZmZmXQoJQXByIDE5IDEwOjE5OjM4IFtr
ZXJuZWxdIHBjaSAwMDAwOjA1OjAxLjA6IEJBUiA3OiBjYW4ndCBhc3NpZ24gaW8gKHNpemUgMHgy
MDAwKQoJQXByIDE5IDEwOjE5OjM4IFtrZXJuZWxdIHBjaSAwMDAwOjA1OjAyLjA6IEJBUiA3OiBj
YW4ndCBhc3NpZ24gaW8gKHNpemUgMHgxMDAwKQoJQXByIDE5IDEwOjE5OjM4IFtrZXJuZWxdIHBj
aSAwMDAwOjA1OjAzLjA6IEJBUiA3OiBjYW4ndCBhc3NpZ24gaW8gKHNpemUgMHgxMDAwKQoJQXBy
IDE5IDEwOjE5OjM4IFtrZXJuZWxdIHBjaSAwMDAwOjA4OjAwLjA6IEJBUiA3OiBjYW4ndCBhc3Np
Z24gaW8gKHNpemUgMHgxMDAwKQoJQXByIDE5IDEwOjE5OjM4IFtrZXJuZWxdIHBjaSAwMDAwOjA5
OjA0LjA6IEJBUiAwOiBjYW4ndCBhc3NpZ24gaW8gKHNpemUgMHgxMDApCmFuZCBjbGVhciAwMDox
Yy4wIHRvIHJldHJ5IGFnYWluLgoKVGhlIHBhdGNoIHJlbW92ZSB0aGUgSU9SRVNPVUNFX0lPIGNo
ZWNraW5nLCBhbmQgdHJ5IG9uZSBtb3JlIHRpbWUuCmFuZCB3ZSB3aWxsIGhhdmUgY2hhbmNlIHRv
IGdldCBhbGxvY2F0aW9uIGZvciAwMDoxYy4wIGlvIHBvcnQgcmFuZ2UgYmVjYXVzZQpmcm9tIDB4
NDAwMCB0byAweDgwMDAgY291bGQgYmUgdXNlZC4KClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUg
PHlpbmdoYWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMgfCAgIDEy
ICstLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMSBkZWxldGlv
bnMoLSkKCkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKKysrIGxpbnV4LTIu
Ni9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYwpAQCAtMTI3OCw3ICsxMjc4LDYgQEAgcGNpX2Fzc2ln
bl91bmFzc2lnbmVkX3Jlc291cmNlcyh2b2lkKQogCXN0cnVjdCBwY2lfZGV2X3Jlc291cmNlICpm
YWlsX3JlczsKIAl1bnNpZ25lZCBsb25nIHR5cGVfbWFzayA9IElPUkVTT1VSQ0VfSU8gfCBJT1JF
U09VUkNFX01FTSB8CiAJCQkJICBJT1JFU09VUkNFX1BSRUZFVENIOwotCXVuc2lnbmVkIGxvbmcg
ZmFpbGVkX3R5cGU7CiAJaW50IHBjaV90cnlfbnVtID0gMTsKIAogCS8qIGRvbid0IHJlYWxsb2Mg
aWYgYXNrZWQgdG8gZG8gc28gKi8KQEAgLTEzMTMsMTYgKzEzMTIsNyBAQCBhZ2FpbjoKIAlpZiAo
bGlzdF9lbXB0eSgmZmFpbF9oZWFkKSkKIAkJZ290byBlbmFibGVfYW5kX2R1bXA7CiAKLQlmYWls
ZWRfdHlwZSA9IDA7Ci0JbGlzdF9mb3JfZWFjaF9lbnRyeShmYWlsX3JlcywgJmZhaWxfaGVhZCwg
bGlzdCkKLQkJZmFpbGVkX3R5cGUgfD0gZmFpbF9yZXMtPmZsYWdzOwotCi0JLyoKLQkgKiBpbyBw
b3J0IGFyZSB0aWdodCwgZG9uJ3QgdHJ5IGV4dHJhCi0JICogb3IgaWYgcmVhY2ggdGhlIGxpbWl0
LCBkb24ndCB3YW50IHRvIHRyeSBtb3JlCi0JICovCi0JZmFpbGVkX3R5cGUgJj0gdHlwZV9tYXNr
OwotCWlmICgoZmFpbGVkX3R5cGUgPT0gSU9SRVNPVVJDRV9JTykgfHwgKHRyaWVkX3RpbWVzID49
IHBjaV90cnlfbnVtKSkgeworCWlmICh0cmllZF90aW1lcyA+PSBwY2lfdHJ5X251bSkgewogCQlm
cmVlX2xpc3QoJmZhaWxfaGVhZCk7CiAJCWdvdG8gZW5hYmxlX2FuZF9kdW1wOwogCX0K
--20cf303b431b7f2cd904b69aefef--
