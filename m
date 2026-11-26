Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795722103;
	b=MOLiD4FKME+Vqx+Oc9YNwozsy486I29JAeIyhgGXeL7dnaMHgTwVF01TajGwGigBfzga
	 awPK/ulNwP7wSHqXHY2ecMv2G2itcv6tIudZIkyoKl8E1unBxa9yvDdIPkGCcJBbSQPFl
	 erTJtdytYxqK6FeXqXxUf3kurYtkP+7sWJdTo8aj+enLHGxnALwH4uyHqJ8BdbPnhjiP+
	 esWBT9ZKclg+yW7rpKOajgpqpW5lRySHHyRY9sncBBbG35uaFXQgRnG6sOP3a7Z7HvF28
	 siRS+KBO6+FJrdT5MbZ73sbb/6ks09p0VYzk7jBndmsKJwNVZnnNl726OFJE+DvAljg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=KY418BqW1FceT2VyhopgVkuzgNfxXGz8W25XX/X3PFg=;
	b=yr4zb21oA2jdFHgDg+RkxU1XRANsmUauPBg37JjoorLSsrZxjSCT7Z+8o3K+u6/B2Wgz
	 mJnhYr8myDvBhYVZ9ZhGtAfw1tgw+wO/U73BUr+xK5tdn7hlc+thLx1z6dvRPXClTESCX
	 vpk3T2psClxxYRP0p41p5hF65z/0in8RLLR758TmFNyvpzHyj0/Mrp9YBYDKuR6raRX0d
	 /r9T5N7wK7u48GeRGYAm7HyUsHiXUaVQFjPlR2dCNc/0Caus5qwoFU41LpTq9x1JYmQGw
	 SNE1BBiZPNYYeFcpGZZcuo6TKmNZ4zrwrQICo2bh0Gqr7NdSuDk3V/D+67EqosSeOcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWrr7VYY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9B606A326
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F9B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWrr7VYY
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b563e32936so3224809c88.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 11:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795722102; cv=none;
        d=google.com; s=arc-20260327;
        b=aV7/Rxlvrj/IPlDMeDaML0JSy781/DF57h88zw3+CyyeMMotBDFzuvLImSy5MrZ+Qj
         guDOGQcdXR1OKJlckOyDocY6ECoejpaPLWbCWGKgiEwtamth6bSpkX7Gg7oh59gZUT5T
         v2bdhTfAubVunddrqnUw4EV6L0ollZQRfvoNDX/TecJ+EqskLeo8et0NBF0HSDm65SlE
         t/+tMAGvVuoqZxk1dkVtqD+Lf6wGxln5K8d+wblrpzRMQKpNPqOtfrJghZrxO8IhCZoA
         B5LPT5EhmWv/H+tPQN+vdUGVNemE86DvKLG9rOyZ42MCCJwQBfcz+SGl/AsgO0xYNvtX
         R4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KY418BqW1FceT2VyhopgVkuzgNfxXGz8W25XX/X3PFg=;
        fh=NOGpps9hfj+ghb/DDMmqQapqFmbMP0nbjR9sjLkYW8U=;
        b=h3iAoroNzEBtxOuYrG0Wqxjai1BpQSb5UJNS/fAAV77CDdFveaobb3VwJHh2HNWl7A
         a7B3vgxkuINfIMO2IWeShOEOyqfNpDa20SP8ntj2CGKqgBv+PdY0bVxkyV0/ZRXhE1SN
         ZeSBhkT9sOCwVWXO2o/UQTc4N1y/QOnYeVC+KF5ondKbTFq4PgN9C/JdQ2hja+gGoXfX
         amLqUL6jG1msNfoL7pi5ak1rg41kq5LK8KEMt5sNfB0b+3ybMgnjovTnJNihNioosUD/
         fJJfJddgY0GhrcGCqHfGiqrRH/7L9fT4JrE2rRkk8Dwf5fwsspID4+KfAPgwuJPsFTCa
         TNgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795722102; x=1796326902; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KY418BqW1FceT2VyhopgVkuzgNfxXGz8W25XX/X3PFg=;
        b=EWrr7VYYgDgdg4JJUEp2SJXbKn9nrZ5Qapy0om7bdg2TAnEa7iKMbPATi+krAaq2ye
         ruyOCV+I7nbSYTzqqLqPYTFiSPhnO837ueEC43j9dwOlRneUHSP4KphUw5fI7gTAjwEx
         bctSGx0q7v1nNuu3ANrGzV/JMDA/M7HoJCe31BWetRLfYzE8WWPsTeIkXNz9u6UMeZhF
         mebb7vLojjjhFQDHWss1VYYbMpB0YQZU+iuoPQkbS1snboZkA8ZTt7XspW0c8xcJEGEp
         N2fFdaCi2JVJG3olrWVGNPqiHE5kAptmYc/NA/2Gy+2OkM3nlTko5399p6gdpEUnRXhW
         hk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795722102; x=1796326902;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KY418BqW1FceT2VyhopgVkuzgNfxXGz8W25XX/X3PFg=;
        b=wu1K+LVAr453nunAYC12FBaHdOuE+HTa5fgbI+kbuVLm1a5zWd9fAxsBb0mUnY2aLh
         79H2w/iEW7IOVIIf+aw1Anq+wLFslthsY+T+gjloXVTuM1hRKJKlLEGIkJBeBrZOO5x0
         BnP37KO7l4tRgc/Dh0PkP+Hjo0rEoWSlA3zhmjRF/8CebZZC5c2nTrRWi2iesUOZQClq
         nyMMlGKqt1/1cGm85y6zIHr4ey54sON/1O50ss/vsJ9vfy4hBD6t+i+R7XVaQi4xMtEn
         Q2nhdJKrgNH+VvGo5cpsE6eEHhGkgaeze+LsDEXvsQwdGHFaDcreKxiq6ePZN1CuCr5+
         OSsA==
X-Gm-Message-State: APuU4Z8SFWqxRkkFCN9K1AtSUH+CTn4dLNkxLnLolbnGGBRXNd9Dkx1x
	VeyPrFE+aOlW6GEAXgUniHC8i2hbD+vvLHd+CRJk5zSBSzBKrlnz9psSPUqy/UzS8mmZrcB9Eqd
	ntMJbSOTsAmG0CCafSdNk+P/a3o3n4zk=
X-Gm-Gg: AZFdTZdqD/WRDAMEomVeTNkPPOp4veC/u12Dn5c8GyBaV9+1OAtCTBbxUi+Kav9Q6UZ
	QpdwVhEtnXbqH0MgoG9bIJ88EbSsdsKmHVDndgAZAlaLUx7xtWJYu4K7M0DLKwfYXwQyyehooii
	gM4La3iw1XUq2Q+VFpnUVg01Qmj3OWssOChmBt5Q1iiW9R0fouz63VADNwpDch0i2ZMD1PA7ULx
	oO77ybitwL9SlpDnPJqnR1ryA8mv8Pq8sYeErUu5c2nKpr3pMO4jC0UE/S3Vzb381kVft/0jpAs
	LalcBQF/tl+EOFH11zmUeB4KOHsxNmgCrlxcBecE2vSWaUeG6zkU230wxI+QMn/GWvUM7l99lCT
	pj3oCB6rbOxTwabS/lkkFmX2Q5ImnGLikD6UNBgsoLkLWXiHlV9K0VEuPtRlmAEQzQFBM
X-Received: by 2002:a05:7022:f516:b0:14c:8461:b3ef with SMTP id
 a92af1059eb24-1b5568fbf43mr18969656c88.24.1795722102378; Thu, 26 Nov 2026
 11:41:42 -0800 (PST)
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
Date: Thu, 26 Nov 2026 14:41:30 -0500
X-Gm-Features: Aa3M54rUBuYGAkt2yTYL2k7FYSYe9U_fRfgne7iAyAKc4OvpzCeI73Urhf10M0E
Message-ID: <CADy1qsZ_j7FnfZHQnwqFWiQKyxoQGLt+LJKG=Y-63Yi71uiNZQ@mail.gmail.com>
Subject: [PATCH v2] PCI: dwc: Skip the empty CFG1 window for a two-bus ECAM range
To: mani@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000785380661332261"

--0000000000000785380661332261
Content-Type: text/plain; charset="UTF-8"



--0000000000000785380661332261
Content-Type: application/x-patch; 
	name="v2-0001-PCI-dwc-Skip-the-empty-CFG1-window-for-a-two-bus-ECA.patch"
Content-Disposition: attachment; 
	filename="v2-0001-PCI-dwc-Skip-the-empty-CFG1-window-for-a-two-bus-ECA.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwxyj5nv0>
X-Attachment-Id: f_mwxyj5nv0

RnJvbSAzOTk4YmI2YzZmOTY1Y2NjOWI1ZWFkNGZkN2MyZTc4NjJmYTUxM2Q1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgSW5mYW50ZSBkZSBDYXN0cm8gPGZlbGlwZS5pbmZh
bnRlLmRlLmNhc3Ryb0BnbWFpbC5jb20+CkRhdGU6IFRodSwgMjYgTm92IDIwMjYgMTM6NTQ6MDEg
LTA1MDAKU3ViamVjdDogW1BBVENIIHYyXSBQQ0k6IGR3YzogU2tpcCB0aGUgZW1wdHkgQ0ZHMSB3
aW5kb3cgZm9yIGEgdHdvLWJ1cyBFQ0FNIHJhbmdlCgpXaXRoIHRoZSBpQVRVLWJhc2VkIEVDQU0g
bWVjaGFuaXNtIGFuZCBhIGhvc3QgYnVzIHJlc291cmNlIG9mIFtidXMgMDAtMDFdCihidXMtcmFu
Z2UgPSA8MCAxPiBpbiBhIGRldmljZSB0cmVlKSwgZHdfcGNpZV9jb25maWdfZWNhbV9pYXR1KCkg
cHJvZ3JhbXMKdGhlIENGRzAgd2luZG93IGZvciBidXMgMSBhbmQgdGhlbiByZXF1ZXN0cyBhIENG
RzEgd2luZG93IG9mIHplcm8gYnl0ZXM6CgogIGF0dS5zaXplID0gKFNaXzFNICogYnVzX3Jhbmdl
X21heCkgLSBTWl8yTTsKCmR3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUoKSByZWplY3RzIGEgemVy
by1zaXplIHdpbmRvdyB3aXRoIC1FSU5WQUwsIHRoZQplcnJvciBwcm9wYWdhdGVzIHRocm91Z2gg
ZHdfcGNpZV9ob3N0X2luaXQoKSBhbmQgdGhlIGhvc3QgYnJpZGdlIGlzIG5ldmVyCnJlZ2lzdGVy
ZWQuCgpyZXNvdXJjZV9zaXplKCkgY291bnRzIGJvdGggZW5kcyBvZiB0aGUgcmFuZ2UsIHNvIFti
dXMgMDAtMDFdIGhvbGRzIHR3bwpidXNlcy4gQnVzIDAgdXNlcyB0aGUgREJJIHJlZ2lzdGVycyBh
bmQgYnVzIDEgdXNlcyB0aGUgQ0ZHMCB3aW5kb3cuIEEKQ0ZHMSB3aW5kb3cgaXMgbmVlZGVkIG9u
bHkgZnJvbSBidXMgMiBvbiwgdGhhdCBpcyBmb3IgdGhyZWUgYnVzZXMgb3IKbW9yZS4gVGhlIGVh
cmx5IHJldHVybiB0ZXN0cyAiYnVzX3JhbmdlX21heCA8IDIiLCB3aGljaCBsZXRzIHRoZSB0d28t
YnVzCmNhc2UgdGhyb3VnaC4KClJldHVybiBlYXJseSBmb3IgdHdvIGJ1c2VzIGFzIHdlbGwuCgpU
ZXN0ZWQgYnkgcmVwbGF5aW5nIGR3X3BjaWVfY29uZmlnX2VjYW1faWF0dSgpIGFuZApkd19wY2ll
X3Byb2dfb3V0Ym91bmRfYXR1KCkgaW4gdXNlciBzcGFjZSBhZ2FpbnN0IG1lbW9yeS1iYWNrZWQK
cmVnaXN0ZXJzLCBmb3IgZXZlcnkgYnVzIGNvdW50IGZyb20gMiB0byAyNTYgYXQgdHdvIEVDQU0g
YmFzZXMuIFdpdGhvdXQKdGhlIGNoYW5nZSB0aGUgdHdvLWJ1cyBjYXNlIGZhaWxzIHdpdGggLUVJ
TlZBTDsgd2l0aCBpdCBhbGwgNTEwIGNhc2VzCnBhc3MgYW5kIHRoZSBDRkcxIHdpbmRvdyBmb3Ig
dGhyZWUgb3IgbW9yZSBidXNlcyBpcyB1bmNoYW5nZWQuIE5vdAp0ZXN0ZWQgb24gaGFyZHdhcmUg
d2l0aCBhIHR3by1idXMgcmFuZ2UuCgpGaXhlczogZjZmZDM1N2Y3YWZiICgiUENJOiBkd2M6IFBy
ZXBhcmUgdGhlIGRyaXZlciBmb3IgZW5hYmxpbmcgRUNBTSBtZWNoYW5pc20gdXNpbmcgaUFUVSAn
Q0ZHIFNoaWZ0IEZlYXR1cmUnIikKQXNzaXN0ZWQtYnk6IE9wZW5BSSBDb2RleApBc3Npc3RlZC1i
eTogQ2xhdWRlIEZhYmxlIDUuMgpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgSW5mYW50ZSBkZSBDYXN0
cm8gPGZlbGlwZS5pbmZhbnRlLmRlLmNhc3Ryb0BnbWFpbC5jb20+Ci0tLQpDaGFuZ2VzIGluIHYy
OgotIFJlc2VudCB3aXRoIGFuIGVtcHR5IG1haWwgYm9keS4gdjEgY2FycmllZCBhIGdyZWV0aW5n
IGFuZAogIGEgc2Vjb25kIGNvcHkgb2YgdGhlIGNoYW5nZWxvZyBpbiB0aGUgYm9keSwgd2hpY2gg
dG9vbGluZyBmb2xkZWQKICBpbnRvIHRoZSBjb21taXQgbWVzc2FnZS4gTm8gY2hhbmdlIHRvIHRo
ZSBwYXRjaCBpdHNlbGYuCgogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLWhvc3QuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS1ob3N0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtaG9zdC5jCmluZGV4IGJiYjAyNDUuLjBhYjgwNzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMKKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYwpAQCAtNDQ3LDcgKzQ0Nyw3IEBA
IHN0YXRpYyBpbnQgZHdfcGNpZV9jb25maWdfZWNhbV9pYXR1KHN0cnVjdCBkd19wY2llX3JwICpw
cCkKIAogCWJ1c19yYW5nZV9tYXggPSByZXNvdXJjZV9zaXplKGJ1cy0+cmVzKTsKIAotCWlmIChi
dXNfcmFuZ2VfbWF4IDwgMikKKwlpZiAoYnVzX3JhbmdlX21heCA8PSAyKQogCQlyZXR1cm4gMDsK
IAogCS8qIENvbmZpZ3VyZSByZW1haW5pbmcgYnVzZXMgaW4gdHlwZSAxIGlBVFUgY29uZmlndXJh
dGlvbiAqLwotLSAKMi41Ni4xCgo=
--0000000000000785380661332261--
