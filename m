Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED513DDDCA
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464978; cv=none; b=coPhcBRlnHLU9RYhHSMxK0Lx7XpfTg1yEhJxTXH1ffI+XNfnZ5jMZTvVZwDbZtkxLMaijmit8pjRZRV4wyYdFf66vIqXcq7r3z+GyDXULzk5XC4bqyovTG0JjWCAjZzGDKacGFhVmclmZdnmGFTvGZyoh42a/7ot/X0qNDqi4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464978; c=relaxed/simple;
	bh=WohKgLBEYo0YC4mhYnEcR6Ox3ntCs6fOwcO9ryIuVQA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BzBL4BSnCtrV6L5gzn6rdYs76utNbXw/+iWkyHrqc6syZ4CX1FXlYZH34R55UKrAnUVs7BZxCMvoksTkJ+P4O0tIpwc9l6v/yjt7llzUBLcd6HdQ4vtr7oGpVDYq58rVLr2Z0AQ5rYmMb13/NADFoE7SEeRe3aY3wK7tnA2uh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hs/18dkx; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hs/18dkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788464949; x=1788724149;
	bh=WohKgLBEYo0YC4mhYnEcR6Ox3ntCs6fOwcO9ryIuVQA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hs/18dkxevcZswBRTsd/gQDEK77p2f2E7x2t6ZPdRpxGxo1+2zn4AyXJm05GIgmmQ
	 v4oAcL5EJB/HVEyV51hMhhCI+6uCvMYYeWHWw6kX9tOKABDTW4NzRGHfTeBvZXZTKL
	 yUwrI1N/LVd3bO8UsReYS6IckTEORKdU6E/aornf1Mwp3VYpMd97uyCSKnes0p1BiO
	 XlyzPoCpmjt7YhfsC7N1r3MXV4UN9zW/AG+52VCnYkwnmvi+Xp5iO2+42TaD4sBT00
	 fBv5wR+iDSymg93ESgTyoAzC2XYpCs+2HpGPsRDsIVFH1W5GktueRqSWWTKEc2NYoM
	 GRj9pamJ46KaQ==
Date: Thu, 03 Sep 2026 19:48:56 +0000
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Piotr Szewczyk <pszewczyk22@proton.me>
Cc: "subtexel@gmail.com" <subtexel@gmail.com>, "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>, "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>, "bhelgaas@google.com" <bhelgaas@google.com>, "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>, "kbusch@kernel.org" <kbusch@kernel.org>, "mani@kernel.org" <mani@kernel.org>
Subject: [TEST REPORT] PCI: vmd: MTL016 workaround works on Arrow Lake 8086:ad0b
Message-ID: <JeWv6qxIRFTiSVNGflZqkEuFreM4DGTGLGjofWAUu6GUDeduzRzhBiauU8dOp4fI0bophEGdtIYJ2faW2mRU8jL8TIUHwMuYJpyyP6znzmM=@proton.me>
Feedback-ID: 45160023:user:proton
X-Pm-Message-ID: a9456e0083a4dada50e8446d6591fdb6efa0508b
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------64e34f0266c676ee82580b5eaf75b1542683d11e3a99a52d220266132f602df9"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------64e34f0266c676ee82580b5eaf75b1542683d11e3a99a52d220266132f602df9
Content-Type: multipart/mixed;boundary=---------------------dc04d847ddcdf18be93a25139dac9ea9

-----------------------dc04d847ddcdf18be93a25139dac9ea9
Content-Type: multipart/alternative;boundary=---------------------76996cb49ea50d07f273c6b4238f6f4e

-----------------------76996cb49ea50d07f273c6b4238f6f4e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,
I tested the implementation from:

https://patchwork.kernel.org/project/linux-pci/patch/20260825043220.9047-1=
-subtexel@gmail.com/

which was applied as commit 95ac22dd4bf13373f90bb6d51bcd1fd1d8f5db54.
I adapted it to v7.3-rc1 and additionally enabled
VMD_FEAT_INTERRUPT_QUIRK for Intel VMD PCI ID 8086:ad0b.

The workaround fixes the same early-MSI/late-DMA-completion symptom on
this Arrow Lake system.

Hardware and software:

=C2=A0 System: Dell Alienware 16X Aurora (AC16251)
=C2=A0 BIOS: 2.6.0, RAID On / VMD mode forced by firmware
=C2=A0 CPU/platform: Intel Arrow Lake
=C2=A0 VMD: 0000:00:0e.0, PCI ID 8086:ad0b
=C2=A0 VMD domain: 10000:e0
=C2=A0 NVMe devices:
=C2=A0 =C2=A0 10000:e2:00.0, SK hynix PVC10 1024GB
=C2=A0 =C2=A0 10000:e3:00.0, Lexar NM710 2TB
=C2=A0 Kernel: 7.3.0-070300rc1-generic, based on upstream v7.3-rc1
=C2=A0 Kernel command line included:
=C2=A0 =C2=A0 nvme_core.io_timeout=3D4 nvme.poll_queues=3D4

Before the workaround, the kernel continuously logged messages such as:

=C2=A0 nvme nvme0: I/O tag ... QID ... timeout, completion polled

New messages appeared approximately every 5-8 seconds during normal use.
One unpatched boot accumulated 1,388 occurrences, with the errors still
continuing every few seconds when the log was collected.

For v7.3-rc1 I used feature bit 7 because bit 6 is already occupied by
VMD_FEAT_USE_BIOS_INFO. =C2=A0The relevant addition to the device table wa=
s:

=C2=A0 { PCI_VDEVICE(INTEL, 0xad0b),
=C2=A0 =C2=A0 .driver_data =3D VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK=
, },

The loaded patched module was verified through its distinct srcversion.

Results after booting the patched initramfs:

=C2=A0 - both NVMe controllers remained in state "live"
=C2=A0 - zero "timeout, completion polled" messages in 15 minutes
=C2=A0 - zero NVMe controller resets, aborts, or I/O errors
=C2=A0 - zero EXT4, buffer I/O, or blk_update_request errors

I also ran a three-minute read-only fio test against files on both NVMe
devices, using direct random reads, 128 KiB blocks, and iodepth 8. =C2=A0B=
oth
devices reached 100% utilization. =C2=A0The test completed with err=3D0 af=
ter
approximately 691 GiB of aggregate reads (about 3.9 GiB/s aggregate),
and the kernel still logged zero completion-polled timeouts. Passed 12 tim=
es around.

This is strong evidence that the child-device config-space read also
resolves the issue on Arrow Lake VMD 8086:ad0b. =C2=A0Please consider enab=
ling
VMD_FEAT_INTERRUPT_QUIRK for 0xad0b in a follow-up to commit 95ac22dd4bf1.

I can test a follow-up patch on this hardware and provide a Tested-by tag.

Best Regards

Piotr Szewczyk
mobile: +48 697 069 452

Wys=C5=82ana przez bezpieczn=C4=85 poczt=C4=99 Proton Mail.
-----------------------76996cb49ea50d07f273c6b4238f6f4e
Content-Type: multipart/related;boundary=---------------------8e7f16c1feeba89f3e15f350c752d33c

-----------------------8e7f16c1feeba89f3e15f350c752d33c
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij48c3Bhbj5IZWxsbyw8L3NwYW4+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj5JIHRlc3Rl
ZCB0aGUgaW1wbGVtZW50YXRpb24gZnJvbTo8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj48c3Bhbj48YSB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIG5vZm9sbG93IG5vb3Bl
bmVyIiBocmVmPSJodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcGNp
L3BhdGNoLzIwMjYwODI1MDQzMjIwLjkwNDctMS1zdWJ0ZXhlbEBnbWFpbC5jb20vIj5odHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcGNpL3BhdGNoLzIwMjYwODI1MDQz
MjIwLjkwNDctMS1zdWJ0ZXhlbEBnbWFpbC5jb20vPC9hPjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PjxzcGFuPndoaWNoIHdhcyBhcHBsaWVkIGFzIGNvbW1pdCA5NWFjMjJkZDRiZjEz
MzczZjkwYmI2ZDUxYmNkMWZkMWQ4ZjVkYjU0Ljwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPkkgYWRh
cHRlZCBpdCB0byB2Ny4zLXJjMSBhbmQgYWRkaXRpb25hbGx5IGVuYWJsZWQ8L3NwYW4+PC9kaXY+
PGRpdj48c3Bhbj5WTURfRkVBVF9JTlRFUlJVUFRfUVVJUksgZm9yIEludGVsIFZNRCBQQ0kgSUQg
ODA4NjphZDBiLjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPlRoZSB3b3Jr
YXJvdW5kIGZpeGVzIHRoZSBzYW1lIGVhcmx5LU1TSS9sYXRlLURNQS1jb21wbGV0aW9uIHN5bXB0
b20gb248L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj50aGlzIEFycm93IExha2Ugc3lzdGVtLjwvc3Bh
bj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPkhhcmR3YXJlIGFuZCBzb2Z0d2FyZTo8
L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgU3lzdGVtOiBEZWxs
IEFsaWVud2FyZSAxNlggQXVyb3JhIChBQzE2MjUxKTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyBCSU9TOiAyLjYuMCwgUkFJRCBPbiAvIFZNRCBtb2RlIGZvcmNlZCBieSBmaXJtd2FyZTwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyBDUFUvcGxhdGZvcm06IEludGVsIEFycm93IExh
a2U8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgVk1EOiAwMDAwOjAwOjBlLjAsIFBDSSBJ
RCA4MDg2OmFkMGI8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgVk1EIGRvbWFpbjogMTAw
MDA6ZTA8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgTlZNZSBkZXZpY2VzOjwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgMTAwMDA6ZTI6MDAuMCwgU0sgaHluaXggUFZD
MTAgMTAyNEdCPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAxMDAwMDplMzow
MC4wLCBMZXhhciBOTTcxMCAyVEI8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgS2VybmVs
OiA3LjMuMC0wNzAzMDByYzEtZ2VuZXJpYywgYmFzZWQgb24gdXBzdHJlYW0gdjcuMy1yYzE8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgS2VybmVsIGNvbW1hbmQgbGluZSBpbmNsdWRlZDo8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IG52bWVfY29yZS5pb190aW1lb3V0
PTQgbnZtZS5wb2xsX3F1ZXVlcz00PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNw
YW4+QmVmb3JlIHRoZSB3b3JrYXJvdW5kLCB0aGUga2VybmVsIGNvbnRpbnVvdXNseSBsb2dnZWQg
bWVzc2FnZXMgc3VjaCBhczo8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4m
bmJzcDsgbnZtZSBudm1lMDogSS9PIHRhZyAuLi4gUUlEIC4uLiB0aW1lb3V0LCBjb21wbGV0aW9u
IHBvbGxlZDwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPk5ldyBtZXNzYWdl
cyBhcHBlYXJlZCBhcHByb3hpbWF0ZWx5IGV2ZXJ5IDUtOCBzZWNvbmRzIGR1cmluZyBub3JtYWwg
dXNlLjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPk9uZSB1bnBhdGNoZWQgYm9vdCBhY2N1bXVsYXRl
ZCAxLDM4OCBvY2N1cnJlbmNlcywgd2l0aCB0aGUgZXJyb3JzIHN0aWxsPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4+Y29udGludWluZyBldmVyeSBmZXcgc2Vjb25kcyB3aGVuIHRoZSBsb2cgd2FzIGNv
bGxlY3RlZC48L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj5Gb3IgdjcuMy1y
YzEgSSB1c2VkIGZlYXR1cmUgYml0IDcgYmVjYXVzZSBiaXQgNiBpcyBhbHJlYWR5IG9jY3VwaWVk
IGJ5PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Vk1EX0ZFQVRfVVNFX0JJT1NfSU5GTy4gJm5ic3A7
VGhlIHJlbGV2YW50IGFkZGl0aW9uIHRvIHRoZSBkZXZpY2UgdGFibGUgd2FzOjwvc3Bhbj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyB7IFBDSV9WREVWSUNFKElOVEVMLCAw
eGFkMGIpLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgLmRyaXZlcl9kYXRh
ID0gVk1EX0ZFQVRTX0NMSUVOVCB8IFZNRF9GRUFUX0lOVEVSUlVQVF9RVUlSSywgfSw8L3NwYW4+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj5UaGUgbG9hZGVkIHBhdGNoZWQgbW9kdWxl
IHdhcyB2ZXJpZmllZCB0aHJvdWdoIGl0cyBkaXN0aW5jdCBzcmN2ZXJzaW9uLjwvc3Bhbj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPlJlc3VsdHMgYWZ0ZXIgYm9vdGluZyB0aGUgcGF0
Y2hlZCBpbml0cmFtZnM6PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+Jm5i
c3A7IC0gYm90aCBOVk1lIGNvbnRyb2xsZXJzIHJlbWFpbmVkIGluIHN0YXRlICJsaXZlIjwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAtIHplcm8gInRpbWVvdXQsIGNvbXBsZXRpb24gcG9s
bGVkIiBtZXNzYWdlcyBpbiAxNSBtaW51dGVzPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7
IC0gemVybyBOVk1lIGNvbnRyb2xsZXIgcmVzZXRzLCBhYm9ydHMsIG9yIEkvTyBlcnJvcnM8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgLSB6ZXJvIEVYVDQsIGJ1ZmZlciBJL08sIG9yIGJs
a191cGRhdGVfcmVxdWVzdCBlcnJvcnM8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48
c3Bhbj5JIGFsc28gcmFuIGEgdGhyZWUtbWludXRlIHJlYWQtb25seSBmaW8gdGVzdCBhZ2FpbnN0
IGZpbGVzIG9uIGJvdGggTlZNZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmRldmljZXMsIHVzaW5n
IGRpcmVjdCByYW5kb20gcmVhZHMsIDEyOCBLaUIgYmxvY2tzLCBhbmQgaW9kZXB0aCA4LiAmbmJz
cDtCb3RoPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+ZGV2aWNlcyByZWFjaGVkIDEwMCUgdXRpbGl6
YXRpb24uICZuYnNwO1RoZSB0ZXN0IGNvbXBsZXRlZCB3aXRoIGVycj0wIGFmdGVyPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+YXBwcm94aW1hdGVseSA2OTEgR2lCIG9mIGFnZ3JlZ2F0ZSByZWFkcyAo
YWJvdXQgMy45IEdpQi9zIGFnZ3JlZ2F0ZSksPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+YW5kIHRo
ZSBrZXJuZWwgc3RpbGwgbG9nZ2VkIHplcm8gY29tcGxldGlvbi1wb2xsZWQgdGltZW91dHMuIFBh
c3NlZCAxMiB0aW1lcyBhcm91bmQuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNw
YW4+VGhpcyBpcyBzdHJvbmcgZXZpZGVuY2UgdGhhdCB0aGUgY2hpbGQtZGV2aWNlIGNvbmZpZy1z
cGFjZSByZWFkIGFsc288L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5yZXNvbHZlcyB0aGUgaXNzdWUg
b24gQXJyb3cgTGFrZSBWTUQgODA4NjphZDBiLiAmbmJzcDtQbGVhc2UgY29uc2lkZXIgZW5hYmxp
bmc8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5WTURfRkVBVF9JTlRFUlJVUFRfUVVJUksgZm9yIDB4
YWQwYiBpbiBhIGZvbGxvdy11cCB0byBjb21taXQgOTVhYzIyZGQ0YmYxLjwvc3Bhbj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPkkgY2FuIHRlc3QgYSBmb2xsb3ctdXAgcGF0Y2ggb24g
dGhpcyBoYXJkd2FyZSBhbmQgcHJvdmlkZSBhIFRlc3RlZC1ieSB0YWcuPC9zcGFuPjwvZGl2Pjxz
cGFuPjwvc3Bhbj48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5z
LXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij48YnI+PC9kaXY+CjxkaXYgc3R5bGU9ImZvbnQtZmFt
aWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyIgY2xhc3M9InByb3Rvbm1h
aWxfc2lnbmF0dXJlX2Jsb2NrIj4KICAgIDxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJl
X2Jsb2NrLXVzZXIiPgogICAgICAgIDxkaXY+QmVzdCBSZWdhcmRzPGJyPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+UGlvdHIgU3pld2N6eWsgPGJyPjwvZGl2PjxkaXY+bW9iaWxlOiArNDggNjk3
IDA2OSA0NTI8YnI+PC9kaXY+CiAgICA8L2Rpdj4KICAgIDxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5
OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PGJyPjwvZGl2PgogICAgPGRp
diBjbGFzcz0icHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stcHJvdG9uIj4KICAgICAgICBXeXPF
gmFuYSBwcnpleiBiZXpwaWVjem7EhSBwb2N6dMSZIDxhIGhyZWY9Imh0dHBzOi8vcHJvdG9uLm1l
L21haWwvaG9tZSIgdGFyZ2V0PSJfYmxhbmsiPlByb3RvbiBNYWlsPC9hPi4KICAgIDwvZGl2Pgo8
L2Rpdj4K
-----------------------8e7f16c1feeba89f3e15f350c752d33c--
-----------------------76996cb49ea50d07f273c6b4238f6f4e--
-----------------------dc04d847ddcdf18be93a25139dac9ea9
Content-Type: application/pgp-keys; filename="publickey - pszewczyk22@proton.me - 0x820F3640.asc"; name="publickey - pszewczyk22@proton.me - 0x820F3640.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - pszewczyk22@proton.me - 0x820F3640.asc"; name="publickey - pszewczyk22@proton.me - 0x820F3640.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FYVlRdEF4WUpLd1lCQkFI
YVJ3OEJBUWRBU1JUelcxMXJ0dUh3SnlKN2Zza2NqZ3pJSmhvaGd3eVAKRHkyQno4VVVWTUxOTFhC
emVtVjNZM3A1YXpJeVFIQnliM1J2Ymk1dFpTQThjSE42WlhkamVubHJNakpBCmNISnZkRzl1TG0x
bFBzTEFFUVFURmdvQWd3V0NhWVF0QXdNTENRY0pFQzdJSjNTWG5UeXVSUlFBQUFBQQpBQndBSUhO
aGJIUkFibTkwWVhScGIyNXpMbTl3Wlc1d1ozQnFjeTV2Y21mV3JPRXRMVTBPKzBkL0lDUTcKTHd4
dEdYbkFlL1NxV2JtcmNRUFBKSC9aaWdNVkNnZ0VGZ0FDQVFJWkFRS2JBd0llQVJZaEJJSVBOa0Rl
CjUvOExhenVSY3k3SUozU1huVHl1QUFBSC9nRUF0Y3NkMFkyOVhVb2w3ZDRFWEJGRllJaHlSYnFR
dWl3YQoxQVhPaUcyWnREMEEvMnF4enRxSXU4aGcraEZ1VWxlcTVaYmdFazFnSFdsemlFQmt3V3Jh
eENZS3pqZ0UKYVlRdEF4SUtLd1lCQkFHWFZRRUZBUUVIUU05MnBtWWM5WmU4U25MZTVEalhKd2Ey
ZmpacmlDNnVkYmdQCngvbmdKeXBJQXdFSUI4SytCQmdXQ2dCd0JZSnBoQzBEQ1JBdXlDZDBsNTA4
cmtVVUFBQUFBQUFjQUNCegpZV3gwUUc1dmRHRjBhVzl1Y3k1dmNHVnVjR2R3YW5NdWIzSm5vWDlQ
dVhjQUwrQ1Avd2tubmxWYWpycDUKa0dGTUprVUhUMmpxTDdlektvTUNtd3dXSVFTQ0R6WkEzdWYv
QzJzN2tYTXV5Q2QwbDUwOHJnQUFpa0lCCkFQcWVRUTFKd291ZUEvUnppdHFBd3F0QUJxQnRQNncv
aVlrbWFCM20vWWttQVFDTEdtV0RzNnBSejRaZwp4R2MyY24ycmlva3pmQ1BkMXo2bTRhazNxU2F0
Qmc9PQo9eXdVRQotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------dc04d847ddcdf18be93a25139dac9ea9--

--------64e34f0266c676ee82580b5eaf75b1542683d11e3a99a52d220266132f602df9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqZzw8JEC7IJ3SXnTyuRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeyCONocnJAdImuFsHbyTHjDaMhz/gWSktlr8fw
KJ4dXxYhBIIPNkDe5/8LazuRcy7IJ3SXnTyuAABD0gD/Zn+6SPvZUBL42+LV
nV/DslungjLbwPktqGf/9Cs3cw4BAPy9DsQYvvnELn2oNVOleRecfjy8AKmw
XLx2wBkGq+MD
=Ru3o
-----END PGP SIGNATURE-----


--------64e34f0266c676ee82580b5eaf75b1542683d11e3a99a52d220266132f602df9--

