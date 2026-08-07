Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D577392C4C
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136176; cv=none; b=XDfmO26TYg32xIy9f0d/uKd7tTloN5Bh8/xN7WhorMsGkNyRK47L0x8tt6Li7liRdS1Tu+kmrcSUPtgs6IYTIywd/jTnnWFXZRoMQVJeRH7nQjAA301bRp7mF29IHZ+IhOlH/MrO01ufoQ8ztdt4mEPQZa5ezPLdxzHU9U9bMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136176; c=relaxed/simple;
	bh=k0PwZWtgvJw2zRg67NUlQSeJ5rFLowk5RShX6+SR1JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=am8i36nnAS98QLK8hifMfzteKkyB4eEFU5msE4Cz96gb9dKErVWYydqOAYwfQ9+4nJyd45H+kg2DO+raEXsc07EWBBjgELmI/AlqCTle/ZCGbo9wGfRX6E0uWVSoixrNBIRM7PZY1KEor8wo1AeSZSuUveW2zow8M2EIkT03ubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4ie2926; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4ie2926"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3726290f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136173; x=1786740973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+97syVWqVx1hhBOA8cAB/VJ6eKbIprJ1K75ZSk567U=;
        b=C4ie2926aILvdPChabf4s++MIPTnM2pW2/rHngO7KcEEjJgUM+HeLM7U3RBEGgF+nD
         xQfFSoHa8Y7DO5wQXgLQcyiSDNllIwBB9KXOig+DwMPQzynxDJGzIok5Ak7/kyT68Z0K
         QWp8tFMQy4uxfn/pRJQrUjpzCPqj5Thi8EDQK3/DvJXLpt3v499NV7UO2jIrFmVqxMK7
         BVeS1bpLWksvtOi6zWwKLEpknm0gfjNtP2rvLTztpXVGjx1t92P3Ol2CUDiNcJGHs4NP
         PYD5QvHWw8Xl1GopTSpRpcT8tPHN/Tlq745UVLQMXWqEIBx1L01txooPg2wath+JmhX5
         GmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136173; x=1786740973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+97syVWqVx1hhBOA8cAB/VJ6eKbIprJ1K75ZSk567U=;
        b=LqmBlcNOTk8gFiv9nCYo6vQzeOqcYvtF64+fbAw404cI8P62cwU9o6HyPY+v/bOC1q
         0C/j12Uya6R1rIqUIBOfzIxlqReCZk4p7NsCfv/upF9JoGzWXnqeCUtKIgaVkEe33sz1
         G+uYmYsJJTLkdd2QW939b1S72EuX5yvrMXRByW6t38b2uVlFuPvG6EtlAE1Oj2Iq+OfV
         6clzBlj86vUkCsDViv6XpRJx0R9K39SFY9BK8FEv2rmBuzpn5HT8hu4oRzksi1SS6gQx
         vIUICbOJ/s4p0TTudH/q5SAVH5fXkWrUggMQ7V3xtiC3LuukZejvcQanI6/NokQUZior
         jHNg==
X-Gm-Message-State: AOJu0Yx3kysAxlt2xzNeoAZuEbVRK8+i9uFITm1Y51DGMd9XyDk+bM9V
	v6acm82NUlkcbd6ggWzf2ubVhsePvW+N5I6/+XTmMUdyIfKyh/QdT6xK
X-Gm-Gg: AR+sD12dRqsGQrpz/wVmC2uj1GTzjOprI7WBQvejf6MBS3PHCu62il6X7PIUNoDVFCv
	4tGkWs17k77Q5U2KPjhY5SKWqAuE3qbGPMcu8k7C9dvhmkq9n2Fb0zB1GiIvnosOR+wHxcB+2h/
	LTMwesKjtDwkR1JS570MQapR1BPhAJb5VJ0xhYDtxNrZVtxQ9rMO722qkEGknGoyoSsjfxco89f
	O7BrV4SIAKC6H2ig1iAt8RxYuuWQ98+mtDIz0ti/S7QdZnelC5aHmltl9J3K1XAUlBWlYe3Vzs4
	R0M3wjSPv31urWK/5JCKoLj6adh26IMEEjzn3dt5M8iHMsF9+RGibQSryr1saNtAeTKvB2PNcwk
	YkVOy3kD15CElPNGPkxyW+jRbuJIBfa09FhRa69SMKwsCqf//dglMaMjJ3KvAuWzVytM4x4dwj2
	nLa0IFX+qaz3FYAPAkA0+NJ8e5AUffyBOv7fnExRcqIZ2vsppDPSUFoFUnGdVMsgSwXtUY089yO
	RFalz6D6A==
X-Received: by 2002:a05:6000:29cc:b0:47f:9266:9bde with SMTP id ffacd0b85a97d-47ffd203edcmr15201425f8f.4.1786136173273;
        Fri, 07 Aug 2026 13:56:13 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:848a:c270:b637:504d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021501bcsm8897658f8f.9.2026.08.07.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:56:12 -0700 (PDT)
From: =?UTF-8?q?Christian=20Melendez=20Nu=C3=B1ez?= <chrismelnu@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] PCI: vgaarb: Remove stale "not implemented" notes from docs
Date: Fri,  7 Aug 2026 22:56:00 +0200
Message-Id: <20260807205600.198878-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807200639.172487-1-chrismelnu@gmail.com>
References: <20260807200639.172487-1-chrismelnu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: Medium]
> Is the "unlock all" command fully implemented and working as expected?
>
> If the user holds only one type of lock, wouldn't this fail with -EINVAL
> instead of unlocking the resources? Should the TODO disclaimer remain
> until this logic is fixed?

This is correct.  "unlock all" sets both VGA_RSRC_LEGACY_IO and
VGA_RSRC_LEGACY_MEM unconditionally:

    if (strncmp(curr_pos, "all", 3) == 0)
        io_state = VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;

but "lock" allows acquiring them independently via vga_str_to_iostate(),
so a caller holding only one of them hits

    if (io_state & VGA_RSRC_LEGACY_MEM && uc->mem_cnt == 0) {
        ret_val = -EINVAL;
        goto done;
    }

and returns -EINVAL without releasing the lock it does hold. So "release
all locks on target held by this user" is not accurate unless both are
held, and the caveat should stay.

I'll wait for further review before sending a v2.

Thanks,
Christian
