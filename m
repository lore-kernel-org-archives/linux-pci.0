Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1430428464
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874778; cv=none; b=FaTKr25o0BMw5Cp9KG8fpxihHwudC+GBO4htobSr/b5iWbfwhego+vfxkXtkT5PBtCAclr+SvSIxbg+7IMrJdwJcfXyJF2bfgXfNvNLbvep995YIpv9oWjGDo619sUp34gvFFIon3ChSp45yzI66CCvQAw/DUJ9ikJ6faTU61Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874778; c=relaxed/simple;
	bh=hBR0k3B+Ox56qcPWJ0TM79yte8w4B4AOdAQPCwDKKzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rE4gF7Kikpr4K5rJC9XTZ0Ru7yWZPyz9b+CNz3VQtZEZqnZtGnuIUFDTjvdBWew5Eb1BqUvMlb3rHjTtB1vcVljbMqLx8lyZPDcBYgx+omdJxmTdrraQY49pt6MR65K4+/i4pKLH2x9INi1MMteCXDatvMoI+Oen4WeHdX6dabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCjgZBLg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCjgZBLg"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a652535dcso163697b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785874777; x=1786479577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBR0k3B+Ox56qcPWJ0TM79yte8w4B4AOdAQPCwDKKzE=;
        b=kCjgZBLgglaGw7auAwpNp5PZ74A+X3STLVjNBPV/8cAQbl+z9fOmMKU03Gce1poHs4
         XM35WU0Xpwg2f+WSXah5Ttksi9w1EJ86RwbqEfKHYBsl7caqutU6Q17VnhVwFqejpOm5
         MefMPK4z1PFIOv0k8gxFqsy7xZIM7x9u1GmaDym2QPmdyX+gUfPfMAJUi2gYU/lZvKYc
         J1NsuEwbgYQuSTT3lX3ATbxAkvGQNanoTP/PGhw89hPixov5A1Aflq5zncH3aaZj95mz
         ZswPMB185+M3+nvfRVRQkDE/jIBs5FJQG+XlNxNwF2zYxVErSjXSo0e7XI9+wkxT0eXh
         6u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874777; x=1786479577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hBR0k3B+Ox56qcPWJ0TM79yte8w4B4AOdAQPCwDKKzE=;
        b=QgrLpyZOYkJUdPEpQa1OHe29ondLNg1G4pOeklk/MWs4AzxxO1RiXd92rKzfORfxH5
         3+VYvsA7sff+KJmQADbO5HbQEnUx6bG1S9vNlRIQI/H+szypdvfq3/Pvs1MsmGyl+NPU
         78DfIGiRCXWWXXVIy/aRRxlrr8lgNbZDryEt89QQ74r52XFF2gEKWbEsIJePf0bKllQF
         quV7rOZsaWB2CG9CT84450yOm07pqyL7aor7TXof3GNhpvsmA80weG5zJTs5Af0QqLNG
         gUKJ/QFTjY+yZyMOsneYTQFw1pshQoIsTDBjt2yt2FuKlVF7RQTW+mTz0vFAL7TNAoOg
         sBfg==
X-Forwarded-Encrypted: i=1; AHgh+RpxGVYR1ZbG62JWn0vu/+BZR083ZsyL2yNDchm0biT+/0fo5lcCEB2yTLg7+Q6yzuwvP3cZR0w0uc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLHElNWVEW8h8iQLUmbyJFYyPuIDTRaVQwo4qunpITiNKG82R
	EB0y34KkfXwXFi03eN76YKiEj12a9r3R9H9wGhzZ3SzcovH4Fh0WFmh3
X-Gm-Gg: AR+sD11m1Ntpb1z2FrI7j8Iajx833yWYhEO/SqqD273FRgrjjFeS/R5YDaSco5ge2KG
	bMBWVAaOBDNH0h0L2YU7qZ+2Jw0dsOffCUipFhGWb7qH4s+g26k0t/HTs0zdxhoyLY2KenkO5Ds
	IUGY6BZwXE0tyUyVkLrNrIswHADOg173gt72a8sTxetT2pR2fQNBLL6d58haXgdw1BcBWtKH/Tx
	y92B8JSVVS6ttcxg63OZuZJETg/PtEwfyD2qWXxw4IXGVNpk7dVQdo4jRMOaKW97OfPKYU5tTJW
	3oP1rhlb2ByXgbgqV0D4cvPnY6zjVOdZgdeZryuCIeXi6s3FH0DaqAEQMacNaw9ckhq4UJrQa2P
	wvWENsp8J4yNnLPbwIu34vrUU+yPfw34IZ52GQOtq9a4qyzMXOu9+Uyy8/JyNUjQbLwRjrftgeU
	/7R7gO/MmXIWqleXqhgWT7eAGEoQ7ZuajIxLvQLn3cWGLr07XI3X2dLgSwav5QhX7RhM82anJNl
	cO9TkE+30zO
X-Received: by 2002:a05:6a20:d529:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3cb85f4a5b8mr1402930637.33.1785874776947;
        Tue, 04 Aug 2026 13:19:36 -0700 (PDT)
Received: from localhost.localdomain ([103.179.230.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b761asm12466072eec.1.2026.08.04.13.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:19:36 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: ryder.lee@mediatek.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	oe-kbuild-all@lists.linux.dev,
	robh@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix 64-bit type truncation in mtk_pcie_set_trans_table()
Date: Tue,  4 Aug 2026 20:18:37 +0000
Message-ID: <20260804201837.2427-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <202608050123.GZC7hug7-lkp@intel.com>
References: <202608050123.GZC7hug7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the report. This build error was caused by an invalid function call in v1 and has been fixed in v3:
https://lore.kernel.org/all/20260728122810.3475-1-sreekuttan2156239@gmail.com/

Thanks,
Sreeraj
