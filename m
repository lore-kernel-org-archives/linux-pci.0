Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3A4B95C0
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824512; cv=none; b=XgWHJAloz6uVnixq7StxYq6+xJce/QXx8BOisGz2jRVQ8DSuNJv4fS305Ilg0PWyeaBcaj++HnW9sYffYrO6WAhxf3MF+UigFqpw4RxyZkVpLgua61ztnesycyQJ9dhfd9Fg85vqBR2I/xQ4SSGhafJsPQFfuciYM2oI7qSSXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824512; c=relaxed/simple;
	bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad4pCoraGW218oA1OO6DPQxtlVsN81LORuuI/lZnIKHycNDrPNNWMtYuGye9jcKgVfGqL4Q17xbOd0nmhBtJl5ni7e+xawYRiF8/dAJKnjRDGtKT4ZyXCRYg8Hs2Ym2dkFEvHdSwV3YKSh6+Mh6iqwq6HgmHJc+sBfLqP203Zg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxnZ/1hr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxnZ/1hr"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso1613530a12.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791824505; x=1792429305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
        b=XxnZ/1hrslvw2d5+up2S+1Kgq7Ul+LVtCS5ifOO5lXEDhBOIDITrmmkYigNNSC0sDA
         SPZ+FYWiDa2u8FW9ptsZMZ+hduGBIsi1nN5XcvNQKx3N8xBZIHC2AQqcCgAk8FpWVPpe
         PbhVEfjtGPLB+hMOVSOCYN125JmvTzC99UDOUWB4yBdW7kT5c/VCAgUd+/BzvKg8XPJG
         rAL8TBv7EBF0a77YMQIOulgBKsOKt+clz8C92SkNK2FSFwWGMLcQFQ0lCpaRqDa843Qp
         b7vV7QvCaddmcVhquGtiMc99EsLQb8r63FyTy663udcBmZPFVbp8dcFWgYQEUWCYhHXE
         pE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824505; x=1792429305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
        b=tS9OQORFALowVCRnzfWRv5asqb4Re9+quarUINv8HgjfHfIT78WE5+TyD3I9EjBbWK
         uA1X0VoID5hG0m8iuFQ99uBKbVGRP4s17pjMbWoolZfVH1ueAbrTFOIGCcwwYIUz+yyj
         LjV9GapTqZYgjD5yjLf6f97pALSCjkhfA5o2Dxe64MVp7dg/jZxMFK7ZQfefzQ3quNZU
         uM/3k3rTqTNacySSkSobPzdbOqG2wkbDst+J9RlZnTKYY2BS0mrVS3FUDInNyKrot7d3
         roWOOZfjH2BDcKIHkU1AJIVuHmf+SNlNm/AbG5n3mdY58XO/uecXGbmuFVuEROlcUiR3
         n1SA==
X-Forwarded-Encrypted: i=1; AKwUvBxc3gTu8UsrGrAkB9TtnL4UH9i3vY+vI3VFArTQUsCpP91GJ6uLcUyTDhpUID+ZvTtn48yiFlfl40U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFeiaPbFkqyvQ4IpB0hcAX3raVLV1uART+JcZpQ3aYuC+aztlq
	SJ3Wzowqe4wwcu0bVu9CYdVdEz+S+mq41ynim9ICDwWI51omyEsVdO3s
X-Gm-Gg: AYBFou3fi50UcYxxBQJpBFKKrlOWjURsJRt0xsvzB2AonQtL4gsorfOoRSJjdUXbbhE
	ujT6KckM5JDkSSWyGL6tvyW5xN5KJPhpYUNGfbp+kKtN1+1kbN7q9MZckBfjzC49Jh/9lfEcfNS
	xzk/i9VtbScB6Zc++J5znkU0xc0kP0XIQJinJZ+rgZ8woODdkfA+mjlhyKQyHstBihon4LeZCMl
	nw3uWr9CLi+nqvJK8uDtUfbVKfduvzLL0gBiR1sNA/DLTw2RY45HxImjE5gctxqYFAMxFVGWKfz
	igklbFokgKcrxGg9n8Ou12CpY6G2ePHdrYpdmGDZPdirfQ6hsBSxlbr1VwNY1dma0FS7cMBCs8a
	T8OhSN5N7vpqlbA5n+MEDGphzLURQs3FJcjT5sFTw3f7P7lzzMuUYb4OkXrXbP4DYRLfLl66fYi
	OYW0jDXTYC+OvicZjdWlFUS4uTtPdjtMY4aE8PgBfhxcX8wcRjle8UIIpJ4RLbrvNfyiGcY2T8B
	4byh0v8UoFJyI95QqbT2/kTT7XjvrtIMMW+S1FB
X-Received: by 2002:a05:6402:218d:20b0:6b1:827c:af27 with SMTP id 4fb4d7f45d1cf-6b1827cb0ccmr6636473a12.14.1791824505098;
        Mon, 12 Oct 2026 10:01:45 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm5093730a12.34.2026.10.12.10.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:01:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: Imre Kaloz <kaloz@kernel.org>
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH] PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports
Date: Mon, 12 Oct 2026 19:00:57 +0200
Message-ID: <20261012170113.985649-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927105609.8813-1-kaloz@kernel.org>
References: <20260927105609.8813-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Imre,

Tested this on a Sun Ultra 45 with PLX PEX8532 downstream ports and an
LSI SAS1064 controller.

Without the patch, enabling CONFIG_PCIEPORTBUS reproducibly causes a
Cheetah bus-error panic when mptbase probes the controller. The kernel
boots with pcie_port_pm=off.

With this patch, the same kernel and config boot successfully without
pcie_port_pm=off or pcie_ports=compat. The quirk is applied to all five
PEX8532 downstream ports, the LSISAS1064 initializes, and the modular
mptsas/ext4 setup boots through the initramfs normally.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
