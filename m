Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92594C652B
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838686; cv=none; b=Rgi4/LQjd0pgT2Fvhxqgs2Akj9KAq9oemaHpQN3gN8ronUljYK1izaIGmnwbOGkqMAMhpgk6JFLKyARHGOIydl5j+J8oGOv6HgexfKg8jXZ0Yg3HoJMijvbtBnX4u+N1klHVMNhEpYlqqWD7ftSiFTd7juzJtvHOzARfibMv+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838686; c=relaxed/simple;
	bh=MMFMgWCczZHhmVE2F+jgXamjYo8yzRhDSVfG8+eQahI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiEK7WMQvgnrZGRE5xubVWy33ZTZNMu9yZu6iCmDZz9qTDsWBBjd65dWu8YLOIlGorPXhexqFv3qa2YXozq6TH4agIF7/ar+ikdLccUibAvHHt9MViiKhwRP7WEWNQpLY0sSySUOmo5oD5iK23BhJ13wLot6zE4pUqaPEUiF7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7EqXgnI; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7EqXgnI"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so4906392eec.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791838684; x=1792443484; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13W6q7i4O/eZzoQLPHcgv9LUkm1ZdongNNGyBgoboDE=;
        b=I7EqXgnInFQJyvAw4Z0EWw+CNgD1AI1qE8Yf3NUjyH0URORRGlqpwgUnq89FnpVcd1
         7uNAPenVk+2iRTQzVRv12v5rVcUYicYH04l+HeZx45s66ow3orTtiuaibfvRkxnMHGW8
         RfOLj+66fyiavdGkVxAJ26Saap3l4lzhviirBp9HOTJ7X26BtLRsRDq607f9qjoNiOF8
         LAVLr02aBGz1AJCd9TXlcEJCPOk/IVEUsKLyWy5dsGnkUypl5cF99Vt4LSAyHAcl5S0t
         kuMlsXMdou2z99kUPuiw1yfLqcshsMZO1Idt4ldicX825oCpSTuMkpQokk+RJ/2RfNug
         Sv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838684; x=1792443484;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13W6q7i4O/eZzoQLPHcgv9LUkm1ZdongNNGyBgoboDE=;
        b=r43ag8fiRivPiOBlYH92MpUshfuMFo+LKpBLinij1zwht6Yla712PycFQuGAXCZPKC
         720+2IBA2I7TyvwD8fw7c3GoqVGHp1uXP2rkXJi7LAf317aeLHfbrhq93bbI1g1Pa+fZ
         mLfRyv2xR2j7tBAI4WmEcYmFCgHI81MddifY89BSLWLI3bt9ZNKJV3oH0WMdEtKtQmVG
         P6wMQP31Nb9RGKaEDTWFYoVQBzIcf7JkK+Pf29C8n3XQcpuxPQ5D4fZevYD+/LFi8xQ8
         UMlOTK5qJEduDfZ/zcdk/OClNinR4gQLtL0Y1tu3prC6bPMcsOMF+lBWCU0GQYRW/JMU
         gnTA==
X-Forwarded-Encrypted: i=1; AKwUvBzdBYNoSJ1uijAg3uAj6emYcFyIcFdXLx224mMNJCMK5EjyUQhhrcf5RPzQJsAC8NYa41995OuDMyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4MmDsQbmn8UiPE1wo1uCgBcAOqXYNnbHeIT1bNEmjafDOUgK7
	SfAzaY9ihI/fMvhHgbaRrSC/Lj5maQUewISGyJTnktYxEgcyELxYKMjksQsEd0J1qyFOnshhcvN
	52nVzOYrPslKZvxjfuXZbbxz8E6quJ3Llgg==
X-Received: from dycam26.prod.google.com ([2002:a05:7300:fc1a:b0:351:7ff8:2656])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:c7c4:b0:353:7b29:54ec with SMTP id 5a478bee46e88-3537e2d8ec8mr15070766eec.40.1791838682637;
 Mon, 12 Oct 2026 13:58:02 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:53:37 -0700
In-Reply-To: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261012-fix-aer-mask-override-v1-2-49a0d7aeaea0@google.com>
Subject: [PATCH 2/2] Documentation: PCI: Document aer_inject's
 aer_mask_override parameter
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Prarit Bhargava <prarit@redhat.com>, Huang Ying <ying.huang@linux.alibaba.com>, 
	Terry Bowman <terry.bowman@amd.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, Jonathan Cameron <jic23@kernel.org>
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
index 90fdfddd3ae5..71a9c2377b3b 100644
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
+masked by default like Header Log Overflow or Poisoned TLP Egress
+Blocked, load the module with::
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
2.56.0.385.gd3acb90ef8-goog

