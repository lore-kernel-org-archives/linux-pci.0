Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795721337;
	b=fedxkKBB2TdnDppH9INkDQkuNZT0mHhXgmh7Eaz2pJ3WihNO0UEA7D6+cweWZwXyKPhO
	 d85jVsoODeo4MMl+viaTHSqeSQBkKfHWnruWIwGwG6KphUOB5aLoKH9QLlfLs+UkAwMEJ
	 2dhLyY1113i6wp4IyP5hQHO/IAVBAQfCBRT7UY1w1zzHf23oaP/qT6HBA0PHoCUNYEzmz
	 XdxePMr3B0o8OJmNnEJNNKVLVwP6ytGxkLPpiyyoWezR6fh3i90rnNwOV57bPCDqcMiYJ
	 8ftLOGaEP1oTIGJB0S6BvtSVLb4e7m3xqystJ493farlwgnWI0aV3qO5zZs7oK4Bbjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795721337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=+1OO5VSwMOiGthJOHBqMFhGuA/eldCyJEeYuUmEhDMg=;
	b=Fe2pc+8j3ut4GhqzhhzcHhbqL01ePgx0bKbw+cIgiN78CzztZXOelQ6zIGRs9hUj2Alw
	 aGQTiLlWgoHPfL0b065fPPxKfcigdGPc7KqU7rQhRZDy4n+5XiEW1nHdAD18RpBjtwg5s
	 X5LwqwbtUPH0fkNWxI8dhsZA71x7IU7oxSpYrgoyz2Po2CdPf+AUI3YQgZGaDerTs17aU
	 WaDyqk7BoevkUYqQK552dHH0nsx7jyCHatqYY5mQ4SJqCWNpF4/Wb8k75xf5kj15Hh5mS
	 YL48Q1zCNubdGI9KImhOdGcIbNUIQDJ7x0DGRHKqXylAdpJGQsDxpE6gWPizNE0agCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Vz2/XDi/";
	arc=fail smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D07606A323
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26D07606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vz2/XDi/
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so12075585c88.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 11:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795721336; cv=none;
        d=google.com; s=arc-20260327;
        b=Fth7MvcaPhb0Xd455bD908HJxkTsZx3trI26wmbyqCiHqYcoWFSmRYhBZpxeTWxemk
         COQpqnapTpiLHhbQWjftkDIg+eV3gJ78KLOmdC8637sPbkNV5vFrdgigJgrfkWKPpaZw
         Tw9Qa8hF/26oXLxVrqFNhNz5H6wZcDNqWxHwffdmdD2ibJYuNvyyg69B/UfEQyOm3xcc
         JgNpMas5A2OsXgoN0G1bz+XfybQS1J+BvrW2fS8+iWZ1q3ufk2h8Ei4oqTQrsqyVPeM7
         uN9mX7MKlAwoWoHUKnwqKsL6pbiTUEBI42VJuM9z+bgsCF4xbfnXiEBAdmhXhV5q4SXD
         BYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+1OO5VSwMOiGthJOHBqMFhGuA/eldCyJEeYuUmEhDMg=;
        fh=NOGpps9hfj+ghb/DDMmqQapqFmbMP0nbjR9sjLkYW8U=;
        b=VEiSqiOUNfpezTYoLjWqDmDulfG87G2i4nP5BTxXQScnoRJ+xnnEjx8RwwqEaHnizB
         O6xEqpG2ZlNT5lMTNUKCAsFIrGOYO+yYN9s8WNlzDDwwI4ZaBeB9l+ptH+/C3jaBFRec
         08jrTLVIcqUyGB3V1UT5GloI9zCM30E5ecVeX+2/K5bFiZMRpfT7ORS9S8CxMVbYeUtv
         38eNQxj1SMYR/rABO1dZmbrXzApOYNZLy57oe267wcGY0dUPO+/PbPRJwi4qbtphvFsb
         ALevSpNp7KMABKkm+VyG9eNTSKFMiwkNC5xoFIfIbk6XmdF+xxvn8eEV9eoGs6zdZ8rR
         iGmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795721336; x=1796326136; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+1OO5VSwMOiGthJOHBqMFhGuA/eldCyJEeYuUmEhDMg=;
        b=Vz2/XDi/rAwSXbmwXdvx6PK/sobOHzsSUDqC1UnAvB+MwhlAhTpJ3y3kzqhUUKBds4
         Hplltcof4ucm1kfi30MEepkKWQ3ASAkIvwaMpC59AjiXGEO6EKfBqDwj2FAheInAcfgl
         tntXWDN7ovLFas9s1EujY4wkTUNuNp8FfSC1N08PsEqBY3bQ0+zpbbB0gQhgSeLsxIQl
         31Mi6eCXQlwK4RFJhlXK4IvrPhzt9j9eOBhTPBrqg7dmnhWwLafuFiv8ufXDcDttTut5
         mhEk1bO/FFfJZYBvkfmYJzj/BUwTPp5jgbylA1zVwt4Bx6XjrLVAeGuSnLAN+C8Yzkga
         ma0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795721336; x=1796326136;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+1OO5VSwMOiGthJOHBqMFhGuA/eldCyJEeYuUmEhDMg=;
        b=Ca/MEqhkjRAiOFrQtQVxD3pBV7yWB2I91lKWq+3/8uWckFWekvtgaoWDp4D9zf85pW
         EmqAEMbHdpr9DkDguFIAsrBK/NbIWqO49MQ1p8Os0Qso7hP6xDLboq5U1HeVSXyUeQMG
         47H+PL52bwQ65BCmw15jZdjtDXv12YU+Va27aLvO4FVBYzh/NE+eFAH92sZVF/SAU3rc
         jBVoC6yU5IXexeaVVubO2vsFymRdW/Ch3m15sJv8y0coSx2VQcDle2vrlZV/82Uqvq7K
         9eJVdcDNekjQHOCMOeO0judyRdMaLM8HfNOjWpzzWPM/0CrU6HpiDPAzTvER+pmPvptl
         5zBw==
X-Gm-Message-State: APuU4Z92bgCVZCfT1DFUKr+NrIiRohcOZvTWGdBrLzCNmLNTVKz6t8qj
	NCQfkAq/P1316rgvkBgSJCNc9jB3cUcyjotP9bUB7lFMcUM0ad8NMYR7oRW3edHYNc2r/woiXXH
	9CIJznlzCfWVrmWBWryhybn1w6rdcw7Q=
X-Gm-Gg: AZFdTZc6/WTpEbSjrJfqjFR/RZZjFwax87rCfF9yqloIlXlc4YIlROXK0/jxhKwY/kb
	Bs0XPpMsOlbBAM5Y3HRajhN3T1rymbXs3drC3+sFChk+zK5Rju72hQP5E3W9pkMHR/Xy6gsfvix
	38NWEU9ZWQR4Jfm37ChkI1GdMLsUeuiANICERmeJVPNdYIcwWq6umSjlwATdmDDmycWsm2fhjpd
	gSE3kZMXRB72DZWSoOVTQH/T2HmhsOvT6ZtGMHnGMswqDtiA+Y2uQaCT67/YYaQ5xr3qgB2gcx2
	xK5bHVHBEhrd9pvHu8m9Ku9DSE/9S8PKy1e3rD3yV56m5Fi8LoP35Fzw3aNkw5xGOC1lTtYgozx
	esc34zIlxIk1zrfqkM8flhGAnmsW1V3avc4DiVbDIemE0CjWxd7tMmUPgqolcomIxsxZyhNHyto
	0rQhyrsGfzrnzxRg==
X-Received: by 2002:a05:701a:815a:20b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-1b556695bf9mr20287971c88.0.1795721336067; Thu, 26 Nov 2026
 11:28:56 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Felipe Infante de Castro <felipe.infante.de.castro@gmail.com>
Date: Thu, 26 Nov 2026 14:28:44 -0500
X-Gm-Features: Aa3M54qm7DAGowzI8vRO80FKAUnQvis1dj1NJQYc-pQZkjBP1gRBOUqgAmcVlQo
Message-ID: <CADy1qsYumu=QY34qDxL2dPjQc4teadMaMgFS4rR2iAr3rMiqag@mail.gmail.com>
Subject: [PATCH] PCI: dwc: Skip the empty CFG1 window for a two-bus ECAM range
To: mani@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005a990f066132f4b9"

--0000000000005a990f066132f4b9
Content-Type: text/plain; charset="UTF-8"

Hi,

The patch is attached as a file rather than inline, because my mail
client cannot send it inline without wrapping lines and converting
tabs. Apologies for that. The commit message is repeated below for
review.

With the iATU-based ECAM mechanism and a host bus resource of [bus
00-01] (bus-range = <0 1> in a device tree),
dw_pcie_config_ecam_iatu() programs the CFG0 window for bus 1 and then
requests a CFG1 window of zero bytes:

  atu.size = (SZ_1M * bus_range_max) - SZ_2M;

dw_pcie_prog_outbound_atu() rejects a zero-size window with -EINVAL,
the error propagates through dw_pcie_host_init() and the host bridge
is never registered.

resource_size() counts both ends of the range, so [bus 00-01] holds
two buses. Bus 0 uses the DBI registers and bus 1 uses the CFG0
window. A CFG1 window is needed only from bus 2 on, that is for three
buses or more. The early return tests "bus_range_max < 2", which lets
the two-bus case through. The patch returns early for two buses as
well.

Tested by replaying dw_pcie_config_ecam_iatu() and
dw_pcie_prog_outbound_atu() in user space against memory-backed
registers, for every bus count from 2 to 256 at two ECAM bases.
Without the change the two-bus case fails with -EINVAL; with it all
510 cases pass and the CFG1 window for three or more buses is
unchanged. Not tested on hardware with a two-bus range. The patch also
builds cleanly on a 7.3.6 tree with W=1.

The code was introduced by f6fd357f7afb ("PCI: dwc: Prepare the driver
for enabling ECAM mechanism using iATU 'CFG Shift Feature'") and is
unchanged in v7.4-rc4.

Thanks,
Felipe

--0000000000005a990f066132f4b9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-PCI-dwc-Skip-the-empty-CFG1-window-for-a-two-bus-ECA.patch"
Content-Disposition: attachment; 
	filename="0001-PCI-dwc-Skip-the-empty-CFG1-window-for-a-two-bus-ECA.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwxy2h8q0>
X-Attachment-Id: f_mwxy2h8q0

RnJvbSAzOTk4YmI2YzZmOTY1Y2NjOWI1ZWFkNGZkN2MyZTc4NjJmYTUxM2Q1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgSW5mYW50ZSBkZSBDYXN0cm8gPGZlbGlwZS5pbmZh
bnRlLmRlLmNhc3Ryb0BnbWFpbC5jb20+CkRhdGU6IFRodSwgMjYgTm92IDIwMjYgMTM6NTQ6MDEg
LTA1MDAKU3ViamVjdDogW1BBVENIXSBQQ0k6IGR3YzogU2tpcCB0aGUgZW1wdHkgQ0ZHMSB3aW5k
b3cgZm9yIGEgdHdvLWJ1cyBFQ0FNIHJhbmdlCgpXaXRoIHRoZSBpQVRVLWJhc2VkIEVDQU0gbWVj
aGFuaXNtIGFuZCBhIGhvc3QgYnVzIHJlc291cmNlIG9mIFtidXMgMDAtMDFdCihidXMtcmFuZ2Ug
PSA8MCAxPiBpbiBhIGRldmljZSB0cmVlKSwgZHdfcGNpZV9jb25maWdfZWNhbV9pYXR1KCkgcHJv
Z3JhbXMKdGhlIENGRzAgd2luZG93IGZvciBidXMgMSBhbmQgdGhlbiByZXF1ZXN0cyBhIENGRzEg
d2luZG93IG9mIHplcm8gYnl0ZXM6CgogIGF0dS5zaXplID0gKFNaXzFNICogYnVzX3JhbmdlX21h
eCkgLSBTWl8yTTsKCmR3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUoKSByZWplY3RzIGEgemVyby1z
aXplIHdpbmRvdyB3aXRoIC1FSU5WQUwsIHRoZQplcnJvciBwcm9wYWdhdGVzIHRocm91Z2ggZHdf
cGNpZV9ob3N0X2luaXQoKSBhbmQgdGhlIGhvc3QgYnJpZGdlIGlzIG5ldmVyCnJlZ2lzdGVyZWQu
CgpyZXNvdXJjZV9zaXplKCkgY291bnRzIGJvdGggZW5kcyBvZiB0aGUgcmFuZ2UsIHNvIFtidXMg
MDAtMDFdIGhvbGRzIHR3bwpidXNlcy4gQnVzIDAgdXNlcyB0aGUgREJJIHJlZ2lzdGVycyBhbmQg
YnVzIDEgdXNlcyB0aGUgQ0ZHMCB3aW5kb3cuIEEKQ0ZHMSB3aW5kb3cgaXMgbmVlZGVkIG9ubHkg
ZnJvbSBidXMgMiBvbiwgdGhhdCBpcyBmb3IgdGhyZWUgYnVzZXMgb3IKbW9yZS4gVGhlIGVhcmx5
IHJldHVybiB0ZXN0cyAiYnVzX3JhbmdlX21heCA8IDIiLCB3aGljaCBsZXRzIHRoZSB0d28tYnVz
CmNhc2UgdGhyb3VnaC4KClJldHVybiBlYXJseSBmb3IgdHdvIGJ1c2VzIGFzIHdlbGwuCgpUZXN0
ZWQgYnkgcmVwbGF5aW5nIGR3X3BjaWVfY29uZmlnX2VjYW1faWF0dSgpIGFuZApkd19wY2llX3By
b2dfb3V0Ym91bmRfYXR1KCkgaW4gdXNlciBzcGFjZSBhZ2FpbnN0IG1lbW9yeS1iYWNrZWQKcmVn
aXN0ZXJzLCBmb3IgZXZlcnkgYnVzIGNvdW50IGZyb20gMiB0byAyNTYgYXQgdHdvIEVDQU0gYmFz
ZXMuIFdpdGhvdXQKdGhlIGNoYW5nZSB0aGUgdHdvLWJ1cyBjYXNlIGZhaWxzIHdpdGggLUVJTlZB
TDsgd2l0aCBpdCBhbGwgNTEwIGNhc2VzCnBhc3MgYW5kIHRoZSBDRkcxIHdpbmRvdyBmb3IgdGhy
ZWUgb3IgbW9yZSBidXNlcyBpcyB1bmNoYW5nZWQuIE5vdAp0ZXN0ZWQgb24gaGFyZHdhcmUgd2l0
aCBhIHR3by1idXMgcmFuZ2UuCgpGaXhlczogZjZmZDM1N2Y3YWZiICgiUENJOiBkd2M6IFByZXBh
cmUgdGhlIGRyaXZlciBmb3IgZW5hYmxpbmcgRUNBTSBtZWNoYW5pc20gdXNpbmcgaUFUVSAnQ0ZH
IFNoaWZ0IEZlYXR1cmUnIikKQXNzaXN0ZWQtYnk6IE9wZW5BSSBDb2RleApBc3Npc3RlZC1ieTog
Q2xhdWRlIEZhYmxlIDUuMgpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgSW5mYW50ZSBkZSBDYXN0cm8g
PGZlbGlwZS5pbmZhbnRlLmRlLmNhc3Ryb0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jCmluZGV4IGJiYjAyNDUuLjBhYjgwNzQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1o
b3N0LmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhv
c3QuYwpAQCAtNDQ3LDcgKzQ0Nyw3IEBAIHN0YXRpYyBpbnQgZHdfcGNpZV9jb25maWdfZWNhbV9p
YXR1KHN0cnVjdCBkd19wY2llX3JwICpwcCkKIAogCWJ1c19yYW5nZV9tYXggPSByZXNvdXJjZV9z
aXplKGJ1cy0+cmVzKTsKIAotCWlmIChidXNfcmFuZ2VfbWF4IDwgMikKKwlpZiAoYnVzX3Jhbmdl
X21heCA8PSAyKQogCQlyZXR1cm4gMDsKIAogCS8qIENvbmZpZ3VyZSByZW1haW5pbmcgYnVzZXMg
aW4gdHlwZSAxIGlBVFUgY29uZmlndXJhdGlvbiAqLwotLSAKMi41Ni4xCgo=
--0000000000005a990f066132f4b9--
