Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795585822;
	b=nKiFzWC4ktJliFHRMmknYWdmk8kj7VZZliZnOXUxD0z4Sq/fNo7YnMMguxseWvLufCMf
	 VA/D5NYTcoKkEgwoK66OMNn1zKakDMbU6k32FGv3QXbFvSjfkh2BlNgU7Xu2yDiQLwdYj
	 wIppdZyKhgHu3ik/rZpCdS9xTnrlWd61qJ98ps0ZsBhT+rATw/ShrddNqRMIcJez7sVGY
	 94Cd2RxrlJf5FqBOT6KBSI3naS+imwPc7YhwoANu+YP8hQwQgp7yrKyNrI07PdfWznTox
	 N7qAciIn5OWETUBeaCUyGhv33tWL/fON6SsLizy01EvVmzDDtaneJ6I2TdibqP9XHPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lwMWYldW2xiMuu7J2YEbh/F+RKn5zxewQscmpZkZiL8=;
	b=jAC/M8kg7aWqJHs/svmosgpOpSKelxpmA/4kSTtYs9vWBZvsLS6yMcIaxFcVFUXcbQyy
	 AAg3XiXYk3636QG8SpXYkd2FABYXdGnYb4EbsH9AZNuU7NGoo7MJi68n8sIoSvp/HeA4g
	 5mMYbiB10+sWZtlYV5Ymmf3cg2bL0h1K69gTbYtb6Q19I481QQm9h6pKMhjQDUojHpiBy
	 m/MnJMx90iI5H1mnlGzbQjtw71esC0mzs8REFXU+01iFTpMa8nbKrBp55Q4+B/How1GNV
	 UN2XzWMNhA+gmqmrGNDS2Hwwo+wEa975Glkl6ske/SE007Xisq4Id8/goDha2LAyv6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LgJcHJPf;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF4606A691
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 05:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88AF4606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LgJcHJPf
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f074b87307so29697895ad.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 21:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795585822; x=1796190622; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwMWYldW2xiMuu7J2YEbh/F+RKn5zxewQscmpZkZiL8=;
        b=LgJcHJPf8kPihW3NLuY7ldBrz09nRKVB+VuXffwFw1AFP7vRl23aymQjZAvD9R3JJx
         2bb3H7e/cxFARp6Epj2CRRF7R5kY92WMvq3XOjHkAqWNc7SjIksfR8Iu7ROMQTjcmJ/g
         NooOKKI+u2PBHuAfvDNd+4AXOiFiA5xb+eygl8CIYcvBSVt/dGcb1muGrhkT+in8rKBH
         oZJfEom0vuklUlvHXpVctU+qHBWtWg4xNsAqPIzCHy1Ulms7jVLLIp9UJRA7fdhDMDPj
         T7xRAzCFvGd2GcuZ0VSbDptVuXEOhQdPvrzlgGXMDp4hST0SldHadlyrFOxXyeW4x1Vi
         gB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585822; x=1796190622;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwMWYldW2xiMuu7J2YEbh/F+RKn5zxewQscmpZkZiL8=;
        b=FXkfrXGwgOSphtGfjfrAXdcfvh+JM40nW74DHTWAvBlj3Jmk6+D38adT8mtBcTWT2w
         R8Eex66Iqu87lYFUflU9xug+fq0pVWF3ztrjwZCCawc4BdFnlofpXTuI7aLJQKTDggZX
         cZ8Ud19vZVDYXPHxutMXjqQjkoQC+yra9R9OQSoevR+nRSKJo/Mz/QOcjIW/7vXuJRQO
         360CMlUGmp3KshVn/yS0TcANy5KvIAKQ48n8L39wtzJp6xaYVjYc6n9Kl9AbKFJulJPk
         0wvDzS0twbIy2QjyM9MFrHIInrRZPlU1x7FRgQF8+nulwT/GAWiKQZhsMMsGVj3/S2RX
         h+Yw==
X-Forwarded-Encrypted: i=1; AL+hErHrvWgxfCtgugxufFZ02oN+we/XwC6PxfqRnLVLBI6E9IGcvYCnk0kiyitCOjiz20GhJ8dUOK4Sggw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tw1nUpjdHn9bCK6q0Dxs8VK+4lqsDiMOEjoi6ErtwUxLm41wV
	ystci/lhsFXtnjTlRh3nrBgKLA/H+Hwwd08oOYAEVrzsGukL4RB28N3Nr/S+fgV/8Nub6s3ahh5
	GggSQt30B7kLiFpfDfA7Wj48PymGnOfsmoQ==
X-Received: from plrc4.prod.google.com ([2002:a17:902:aa44:b0:2f0:43fa:d088])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d54e:b0:2ef:ec63:320c with SMTP id d9443c01a7336-2f03f156128mr164458005ad.16.1795585821668;
 Tue, 24 Nov 2026 21:50:21 -0800 (PST)
Date: Wed, 25 Nov 2026 05:50:20 +0000
In-Reply-To: <20261125-fix-aer-mask-override-v2-0-fb5931dc9462@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125-fix-aer-mask-override-v2-0-fb5931dc9462@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261125-fix-aer-mask-override-v2-2-fb5931dc9462@google.com>
Subject: [PATCH v2 2/2] Documentation: PCI: Document aer_inject's
 aer_mask_override parameter
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Prarit Bhargava <prarit@redhat.com>, Huang Ying <ying.huang@linux.alibaba.com>, 
	Terry Bowman <terry.bowman@amd.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, Daniel Pereira <danielmaraboo@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"

aer_inject has had the aer_mask_override module parameter since commit
457d9d088b02 ("PCI: aer-inject: Override PCIe AER Mask Registers"), but
the AER HOWTO never mentioned it.  Describe what it is for (injecting
errors that the device masks, in particular those masked by default)
and how it behaves now that it works: the device's Mask registers are
left alone, the injected bits are only reported as unmasked while they
are pending, and the hidden Mask bits stay set in writes until the
module is unloaded.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 Documentation/PCI/pcieaer-howto.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 90fdfddd3ae5..8994cbf9611a 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -265,3 +265,26 @@ from:
 
 More information about aer-inject can be found in the document in
 its source code.
+
+Injecting masked errors
+-----------------------
+
+By default aer_inject refuses, with -EINVAL, to inject an error that the
+device masks in its Correctable or Uncorrectable Error Mask register,
+because the AER driver would ignore it just like a real masked error.
+To exercise the handling of such errors anyway, e.g., of those that are
+masked by default like Header Log Overflow or Internal Errors, load the
+module with::
+
+    modprobe aer_inject aer_mask_override=1
+
+or boot with aer_inject.aer_mask_override=1 if it is built in.
+
+The device's Mask registers are not modified.  Instead, as long as the
+injected error bits are pending in the emulated Status registers, reads
+of the Mask registers through the PCI core report them as unmasked, so
+the AER driver handles the injected error as if the device had it
+unmasked.  The Mask register bits hidden this way are kept set in
+writes to the Mask registers until aer_inject is unloaded, so that a
+value saved through the emulation (e.g., by pci_save_state()) cannot
+unmask them in the device.

-- 
2.56.1.831.g720f3f5937-goog

