Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793841560;
	b=aVCrxhaH4/aqgoIlJlpl5355d1KstkSzrWAjvGAwZ1xY+1lhw0TrfcY4DWWgJEbAY63I
	 aLvMd/nPQTvwnc8PqG7dsyfjdMeR37co+G0FF4CmPbyn8IT1VqoBTJyvw3NjSEW18/rjb
	 m63+PDpGUtts7urqvdAdjJlUJM8tdeebYaUX/b/Y8Wun1aKcZij50OxAShKF8jHHD/Qfb
	 omP7iI6RcH0euotDDrrLuW2LJ+yiGY5s4/zPfJ8ZqMtIaDgcyxdVS7C4wHjHAFt6O4sl5
	 E6kBe/OR7V7YwkNMw+eie/nmxA2sH+OjN1jVSovVsuvwJQwgp+5C7quq1G7y5taSi0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=n3MtPBLV0to0nephb6ivBjQGJjsNOIYgMJYpV60oxUk=;
	b=OHG0pl0pYV6MWC/MQ1gFMbivCAZjejlAcq8iqQ61uFMIzCxgmSJ4eQKE2bke9HTuxDpZ
	 Kq6SIBT5tIOW2y8mU/BBqDazQIaM6n0IdF2R0wzetdy0HKHfm2rRVCVkqAGQ/7vv+HujJ
	 xcd2rN1QfXdLhhNKwxIVSh99rZzHON5rvUfoi4EkM02aBzFVgl5r+WYE+j7nbd3/czWJo
	 7Qr4/3VLtYh9hLWCb/+Knm3ZOzurB/eVRr/JRMKfhY//n6yntRVsvARbc+FuIRLW1G4oq
	 7wOtREY7wA71kkfDYI7VYiGa1yjQuBeYZwnDZmxlaL3x59c1ue9dcl151iTGjPtcehg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.oaklandcc.edu;
	spf=pass smtp.mailfrom=student.oaklandcc.edu;
	dkim=pass header.d=student.oaklandcc.edu header.i=@student.oaklandcc.edu header.a=rsa-sha256 header.s=google header.b=ibyZUBmH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0D606A334
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 01:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E0D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.oaklandcc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.oaklandcc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=student.oaklandcc.edu header.i=@student.oaklandcc.edu header.a=rsa-sha256 header.s=google header.b=ibyZUBmH
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ab3d3c5761so16990107b3.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 17:19:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793841558; cv=none;
        d=google.com; s=arc-20260327;
        b=BLNfINdJL4BQHm/eNYSM3sygcArQkGSxHcN538xYhS2R8VL06rRtuR47EyVox4mhq3
         aBIWhpWVLkqBqT1GtubZO4wUrHTb0v7q3cUC3gGYIRCJ7CD4Z5fic3f1WaoAG1d21DPY
         Yf3Yf+nSNcw/inTLo6DBc8JobmtSuru6uTDGbB/QqoqUzCDHNQXcev4EKEVSHxXgDKnh
         85P+I0Jcn3q642VbNEvmXxo83fnJn7/9/3d9ZESyiOeXXvsI0ozl5tBGE/K1PTIlH8qR
         UmUVO72EpjHEOP1aQoNNdDGK7DxbTwInKyisJwYaEYIgqj1PpOgcoYh8hrOuO+YJKZwI
         AfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=n3MtPBLV0to0nephb6ivBjQGJjsNOIYgMJYpV60oxUk=;
        fh=eW7iQdKcZ2ExO2FqD3RHdpEmehW+pWblwUM9dStdj1s=;
        b=QxdNqfk6VyXGl8pgbevrxmp3qKGmZgmGjrzR/0SpuULfdaWb7mQ7NlsE6UzJLH47Qq
         rxjmofujnD9PhhBKXVjLT0yhCQP0nb/7tN+uAaKe2/QJ0AQtNS+L6dK5kHbLKOxrASL5
         YTTurPu6i6A4I4G6jMo6Na5MrycBCDbvF25YMbL+6tcRm9i9MWCTVy+Cpnkx2B3MzNKQ
         apryRq2mVcL3GCHXIPWOl8CMobjdR8MEL++1o9ThxOPF1dPLa36kMfSGbNaBVM9H48ch
         u5mTIRD8pT3QgzQQ6nAH5Oe4yhefULo60TApQC8v4aMYHkVpftWH0ru8cqEDbu3vg5rX
         Ikag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.oaklandcc.edu; s=google; t=1793841558; x=1794446358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n3MtPBLV0to0nephb6ivBjQGJjsNOIYgMJYpV60oxUk=;
        b=ibyZUBmHmd+MKS8f5oeSbKfulBJmbwlE+kPH+QcrEfQOz3HBFXEO7gtcsxkdxUoOWU
         qC3gr/Y8CDVLnljLA6j1sr0e1/fXx43A8diNPwXeetkeR+u5Oeu6HAQZNp+fizipuWZU
         mYZMgW84mMT/aK1W2dLJNisVK24vlTo4RR8nM3m+E9Efe2lqLXVyRHfGi0YrQYqZgHFJ
         p6uQNKunbB8lZFCsymjgjc6N9GaoFOGHiqkae1a7irmTjtwWzQYv8izSkRat5ono3D8J
         0/+Iw6EJfErueAfHkefH+9dPuJI/WAJjk7KbvV8Q7qxVslycjHOvUD5uQvCAvOtkrlDE
         4dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841558; x=1794446358;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n3MtPBLV0to0nephb6ivBjQGJjsNOIYgMJYpV60oxUk=;
        b=0XIOPfbs+MGObA4WczSiLOFFAaLCHqFoYRbtRnzHGVZWM7PSeXZ7uI6e/UXbZzdujL
         tyS2A1+/aw2TvyGk15gmaMUaLeEasOrcez3oILzDAuYIgfQ0ztaMZgqBQWv2/ZZcyHS6
         YyS8uR07FWUhkMkBqLcn4Vhfvga1D+f/cXww0ftV+jMHqOK3QwKz4yfoi6k0Iu+8ZMGv
         bbA9p0o2gFbLNsP3KNHxoC/f6Y+CD2QPw228d2gtdrU7eMTXKGEqX0qLvM5bHRHhDLBR
         KmlgUIUTT1CPpo2wOeNR3Pdtg8yPInmK5o0btVZ3cLw88xtokRNCsmRD3WxctLy8kT8J
         +J5w==
X-Gm-Message-State: APuU4Z/Tolc6IP7gBkYX2O4fP4N9jfhTe/pEvtodmRUpqB0xm5KWC44+
	T+FDwX2gIY1nNZUoRa8SCgYNtg2yvvwl4XfKRrA6TpffquZRmIfQQGdtKtCyNQWo2S7PEw90Xtz
	gPW1SANikE3k3slV44FI6Oovsyv65TYpBCOMnJV31oeQH2iPwJFQx
X-Gm-Gg: AYBFou30bQ2pPNtSTeqlq7hycA5Wv36qbqr/iSwX1N/4nUnJnYfZA9VFPnze8/dL681
	NDxmkINhrpYBr0Kv1ADk9c6FrGQuGE2djntTZz8N/FbyzgatEwraQ7qkhr5ghOTBSahZ7PJ4mzI
	Ctqv8Iq8T15RR0fSCjV3hWm9Yv2Jdl/PE01J/9WCZlmFGFo29k86FeKMT+hKXsI3FNa9FLtrqF9
	pBjAyIj/1P5To4mvCmyW5f06/4bDwWLOgndavuVPAd724wRrR4CAp5lKDP8fW1mBWs4Y5lbhvcR
	Z7wTMk7qlLrgyQx9Z0sTJfQrAJ4d3YjjkStADHsrP5N546f9Ow7ngWnwcvUC2SLjJ2Ux+NGnCtY
	2cfdmAQwj+I9rZadfO7gqXAik7ZF/sIho5A==
X-Received: by 2002:a05:690c:a85c:20b0:8ab:436f:6e77 with SMTP id
 00721157ae682-8b2b67f582dmr86647387b3.55.1793841558477; Wed, 04 Nov 2026
 17:19:18 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 4 Nov 2026 17:19:17 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 4 Nov 2026 17:19:17 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Poulin, Louis" <poulin.louis@student.oaklandcc.edu>
Date: Wed, 4 Nov 2026 17:19:17 -0800
X-Gm-Features: AclHuK-MrxmerUWGNq5QZCrBahcXVOBfm1MmuD6TfWTfg0duY6JPb3wNkFmudSI
Message-ID: <CAGQButuh2zJ9dvNc4ioqaSh32EGChc9Z3HORr9DwnNd90=zgCg@mail.gmail.com>
Subject: [RFC PATCH] PCI/ASPM: Handle missing link state in sysfs reads
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, zhaojinming@uniontech.com
Content-Type: text/plain; charset="UTF-8"

From: Louis H. Poulin II <poulin.louis@student.oaklandcc.edu>

InputPlumber can hit a NULL pointer dereference at l0s_aspm_show()
while reading PCIe sysfs attributes on an ASUS TUF GAMING X870-PLUS
WIFI. The same fault was seen on downstream OGC kernels
7.2.9-ogc3.1.fc44 and 7.2.15-ogc1.1.fc45. The latter logged:

  BUG: kernel NULL pointer dereference, address: 0000000000000030
  RIP: 0010:l0s_aspm_show+0x47/0x80
    dev_attr_show+0x1f/0x50
    sysfs_kf_seq_show+0xa8/0x110
    seq_read_iter+0x132/0x4c0

The faulting instruction reads at offset 0x30 with a NULL base
register, consistent with accessing the ASPM state through a NULL
link.

The visibility callback already hides the ASPM attributes when there
is no link state, but the read callback looks up the link again. In
the affected boot path, the read reached the callback with no link.
A diagnostic build saw this on AMD xHCI [1022:15b7] and HD Audio
[1022:15e3], both downstream of internal GPP bridge [1022:14dd].

Return -ENODEV from aspm_attr_show_common() when the link lookup
returns NULL. On Helix, the equivalent guard with diagnostic logging
ran on the downstream kernel and the host reached Game Mode on
three repeat cold boots without the oops or an InputPlumber restart.

ZhaoJinming previously proposed NULL checks for the ASPM and clock
power-management sysfs callbacks.

Link: https://lkml.iu.edu/hypermail/linux/kernel/2607.3/04295.html
Signed-off-by: Louis H. Poulin II <poulin.louis@student.oaklandcc.edu>
---
The diagnostic build runs on the affected daily-use Helix system.
The hardware results above are from the downstream OGC build.

The RFC builds and boots in an isolated x86-64 QEMU VM on mainline.
A synthetic KUnit fixture passed for both missing and present links.
The same fixture without the guard faulted at address 0x30 in
aspm_attr_show_common(). This exercises the callback, while the
physical trigger and the cause of the visibility mismatch remain
unverified on mainline. The QEMU test called the callback directly
and did not exercise the real sysfs read path.

In the pinned mainline tree, pcie_aspm_exit_link_state() frees the
parent's link state only when removing link->downstream (function 0).
Could removing function 0 leave an ASPM attribute visible on a
surviving sibling function? The Helix traces do not establish that
this removal path ran.

The guard handles a NULL lookup. The show callback reads the link
without aspm_lock, so the guard alone does not establish safe link
lifetime during concurrent removal. clkpm_show() and the store
callbacks also dereference the link. Should the fix address group
visibility and lifetime, or should those callbacks get separate
guards if their paths can also be reached without a link?

 drivers/pci/pcie/aspm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b039b57..f78da8b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1716,6 +1716,9 @@ static ssize_t aspm_attr_show_common(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);

+	if (!link)
+		return -ENODEV;
+
 	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
 }


base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
