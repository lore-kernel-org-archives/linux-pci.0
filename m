Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128983;
	b=o45LBJhJcDxfhUFnP/ExmHe20RivbxU/oQ30JVtHUuu/howvJt07jqy7vi9SrpCOexRo
	 22zFGxjrF/0U20gQ+6iLlyA/j3YafyxtAkEEu/dRhTSnkqiNmNvyvon3gwmsJaCwGNKr+
	 Rs3qtF0EXY33MzS7w7jCdjjkzV/gckV3SQfhtmD8uB7W4TRIzW8euYLVlDmAsI0OPQhDp
	 lIqWeschCMJDHb+6jrUrJRV8vEhGLdQ0/i7VYsYWalsktNzk3MbtY6n4/C5EDfB6mJMJ2
	 KbAJZlfeS2gq3dDmD8cGbdgYDAl0+7xLYOsr3wrp5Hr1FYmlVqYvw5x9Fq/8d70FeEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
	b=heZBAukOw1b9uK73OBYQbm3yuxoIZRKI/jVkjS+rldp4s9m2dSv+RVkElfABPiIUfTWW
	 zj+mRaBTiI+6OxkxUHZ7UqHS3pmgk5+4+Vg8jRPKRC1ci2XYefAmnq1E452qSAsFTqpdi
	 ia9gdKYN0CnzAdtirQVYYXpdtxt9iR3qJOLM6ZXn8csFBofeLpsTKqZBudPUi6/lhnD3a
	 RRpNkWjF6f4yGZIFcf1vDpvl2HPaIe2+9wbYTGFwzbmmY6MjS5e3n7cQ3vpGx7r/+qVEH
	 /LHvSCwZAIMrN6ZmCoVQDsdePFOTgvQIyBZbBXTMcaY6WlKeZK2kXe/aJS7P6N2KvYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FafqC6Zc;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725E606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5725E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FafqC6Zc
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37198ed3727so71734eec.0
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2026 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794128982; x=1794733782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=FafqC6ZctJCGMqrFCgytWOB2XTSjS2PSJrOGAtvyeB9QwIltvYXb2IvVOabhBTmN/V
         n5sh5YSpWZLzBJczayPp/8qMEoc4orIoOFcWHVNBG9tU5KJUeqsHMITiJgzWNV7BkTRn
         MKZdPyDFcey5KuVxg98Quod/wHgcvWHHon6xcv4p0WFiojUoHlkV6BPnN9srt6GXmd4L
         YphzYWyrHBSSwJfdKUNjslngo0CJVPBTE8a/4F1eWoFCTNnRsFqGBudWwprLgAaKIK6B
         rRbqDVqb0h6g8ZoVB0Uzt8DD1YGESTKuWV6plNUlgK96zQFPBAr9I8nzXPDo3QzV2eQH
         AyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794128982; x=1794733782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=uQELE/7tpeTBms0N3vEbqKs5Ohr5QtZv3JptQOOd6+iRM5LsPXh2iV/m9ZO/5EwTI6
         V3fnqG6EtxrRV7YqORqT9tmSoe0f/+lZ4+5WPCj5XVG5hhPlnBfCS0PeTtACX3yIY3wz
         2//u6McaJwsaazmo5h73biO5iYAdWGEw723dRShsmFBSuR0j5X0qiNfpUc4gaRBbn/7c
         qdYMYnfVsuwznQkZS5vIvJO0WOD6fDxLNaNZ9v+iHFtwQTEhSi0tAYcLvdq6Lzm21PRf
         RHf0B3iHVp16hHBhZmozRpTGuPVXvo5YdtmIVzt90bPSruT8kupT5LDnJ7Rf0S6L+NAR
         vO8g==
X-Forwarded-Encrypted: i=1; AL+hErH2yypXsBWHRIA1muDDR91mciDgUyzHEzwBfxD3nLNArrkPBHisvWAvx/ixkuYYxdncUdWpyoTqGis=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QLgfWaGsr2qvRF5AzFwO3qXAptIn0QELdPqUJLDirPdl+qSuJ
	oX2if8S217xCghzi5TRqsYJwo8uV9RE3CrMbQuw8SIxAYptzaolk4a8F
X-Gm-Gg: AYBFou0nicQ/yU/2ZxCi/kg3s80Bk1TeMPNZtWOlg5UYMGWKgCIYeEr1PFBripHfdjJ
	mtV6CjPe7CbR7EhylC3tNe9GrFaWXXFmrbVunAKIpdYlasBcxk64v0BznRGebJ2bWsZGeVlXkgR
	RY9vx9tf+cM+4D3jFH4DTAFch6OzI+iHq0q57KDz5HzSYzcXBi6+Wgx2QiVDKyBt0oAyqicV3Bi
	w096VfO+NTuEzud0pjoNUx7quCB0WiCONywfxVB8UEGx5qe5z1fZVZHxawbPCEKAhSg4uYNdWU5
	fQ1TulL0kaTStsBB/NPk+/ekH+yjwddClqGEKmG8fY+myhMP/r6kU6YJLpKj0dMjaV38Ea0V2pZ
	/T3vfbWFrtQpjQQi4aZBdLtgODAm5BCrBsZVs81K3adRkCEokdtHdVTfES7QJbO8WKFZtDQhvwo
	Y0BZuVRpK2rJT12/IwNsdVBSBCVTQS/sljk3gnGnnrkvuAD4zwzubifWFMu2xFOPGUuJwGf5r1W
	EKAoX4KSzBetdGGJci8wKVYsksNZ3BYRTndAORO26yWLeL2bf9FZzfLgedTm7myGj6Zb9Q+g3Bz
	SPvGP4H7+7XseRD4+exylQdAbQjncAyt8YUa0YI9xKZbUPErVuI=
X-Received: by 2002:a05:693c:881c:20b0:36c:a2cb:6ad0 with SMTP id 5a478bee46e88-370f620bf5cmr5775018eec.8.1794128982350;
        Sun, 08 Nov 2026 01:09:42 -0800 (PST)
Received: from localhost.localdomain ([103.177.253.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561852csm3725259eec.9.2026.11.08.01.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:09:41 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: mani@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	matthias.bgg@gmail.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	sergio.paracuellos@gmail.com,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH] PCI: mt7621: Fix reset control leak on PHY initialization failure
Date: Sun,  8 Nov 2026 09:09:04 +0000
Message-ID: <20261108090904.2409-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179407116392.87368.9250979022176600686.b4-ty@b4>
References: <179407116392.87368.9250979022176600686.b4-ty@b4>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for applying the patch!

Best regards,
Sreeraj
