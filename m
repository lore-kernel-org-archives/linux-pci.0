Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B437F312
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058296; cv=none; b=Fm76kIzvGZi+XzSioTNV5HjzjXrHYCkCMArCMrcbbLkS8msaspRcONzG3WiOVs30vGNPMwa5K6LG5HhTX33BHYOhxws75nFFdCRE6Fwf2bBsLDK8VqZpv+P4M1EpLV563htcku4NRcEawOh09/w7IQzb6OpwIsXyWlMo4cnyQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058296; c=relaxed/simple;
	bh=u7REdmmpuX4Q8U4G/vc9BgFz8IOFsGkTYQ2px+ZknCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILvqMkAIHvEzWjuWMUpWKrTI3QH8THCPmJenwoMizTw/I3/abiSWUL5Wxw6vvKHic6gbBJ/1C6bXjigy5Ap/SkymfGIE23vOmnppQKkThSbDDPgFbyqYhGO6ICO4scMzDZcWQO5SdAXWzRW0sPHlisoSSE0NjlN+LvH/bPSNR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoonPlg8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoonPlg8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccf2360620so16015945ad.3
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785058295; x=1785663095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lLDZViLAfINHg50NTNYlWjUmmq7rCNRpyVHV83r/TA=;
        b=AoonPlg8m/+dMnN3MLWGQFNNQ2zQ1AVB473XQvMXktDQX/CRzF0UOLqDorDZ9jLjLY
         aegmUrT44HtGrP1Rl75YbaisGUckFvxzqANBUN12qqp0Y7ZUa/SGSJ42QKdLohglgn5C
         +t17Qg2Akuqw6elBBp9vW0jXke1yH0E4BWgNP4/yOvP6itgWVgBRlb+Q6gO2T5Pe3KtH
         puoyiQlJjNjfFwegraq4QR3PdjzxTwkWb52QbUSYasrVpEBHnetb+/ArmFX/OiTvTgQZ
         tLOCyocd1cVdcMH98XlZ3bez/Qw4ZEeiOkMSQvCfa6aID+15bxNAswgvIpJs215evBYJ
         R0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058295; x=1785663095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lLDZViLAfINHg50NTNYlWjUmmq7rCNRpyVHV83r/TA=;
        b=b1QRjqMCnPs1hdrMsbWVaflBo5NudlswysSYyiOAGuRvKPoJpN3gXc/Qe5KonMPX1E
         m6HN1oRNOADQ8JU3WWItK6yV/noMGwzSunmVT19k+Pl9gjemauaO2yJdI/5rLeH2yloV
         cs/lqCZTT3C/ILmoy1zdnMpnGwc/ZhcIWcBN0J+LXMYTSo3KGu0zrbLTEpxRU6gyERcL
         FP+eukX0qKKHbbA9l3x9IRPYY6Sz3k2Lm8EhSyrn2XabWDD9kr+0ipozKkXXMaoIPjlT
         WBpA52txQcDDDbZvgzokQvIYU+VSsmonb/iSTRlRqEGF/zPQ1+8gt74n7DWKvpI3LXBH
         v89g==
X-Forwarded-Encrypted: i=1; AHgh+RpS87M+RMScXdS/a8GdkcHAqxZE+NgYw3gEHk8k/WVT768ixhz5jKfWcw7moKYr9iJ1F07ZBuNlyFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBZKW9sG5EoXvoH/sWtJwzg3Pl3Y5xtjRoOpFXaMXBsn5U5KZt
	RirTS/Ymew4K1x4sMLD6nLVDBkuclt5PBI1/DFXdUq1YdPldEQpBLpVY
X-Gm-Gg: AR+sD115mKBQYyElYd57OrAOzdRniKoUwYnqtnK7F4XXMma4zWNNNcakWY0ZicOHdTu
	J11HtSVIotgbNDvwHbEpiYn+vKhpNSuFJqQ71wKNQtzkdt3dB1eh6j6PWPbKhLq8qaW5CedXoZ2
	tvwe+K4vcj87BziW0dlyliyHSZo4oynhQwmaGfz+gEAA+eaD2c+UMvIPcvGcAj0Did7PYGFFElr
	K5yB7KDY/Ouu/0WkGR2N0i8OKanLIaP/9LXC2gxNNidAbLolIGe8Tsk3as8+tnFFxX5vA4FgYNF
	zGM5H0CefoKQoPG48jicglR9fD5x9RextIsBexmbCnajF/bYIc7oShsFS1y/S1BB3yb5dqy3/4P
	hYIK3QhH+ulejyIQVsSxWISlDDnf4kIPhn3ZBVmspWlW2OAvHMlagHY/dQbKH85uVtQ9r0lAhTf
	wGpA09tpxdZxrK
X-Received: by 2002:a17:902:cecc:b0:2c9:97a7:f544 with SMTP id d9443c01a7336-2cfde888049mr41374305ad.42.1785058294646;
        Sun, 26 Jul 2026 02:31:34 -0700 (PDT)
Received: from ubuntu.. ([2001:2d8:72ac:5ae4:b4c0:11d6:e62a:f791])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7ee3b1sm17860305ad.62.2026.07.26.02.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:31:33 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	tarunsahu@google.com,
	djeffery@redhat.com
Subject: Re: [PATCH] PCI: Handle dev_set_name() failure in pci_setup_device()
Date: Sun, 26 Jul 2026 18:31:27 +0900
Message-ID: <20260726093127.145865-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725180429.GA349362@rocinante>
References: <20260725180429.GA349362@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Thanks a lot for the review.

> The kernel-doc for pci_setup_device() will probably need to be updated to
> reflect changes in what the function returns on failure, since now you have
> the -EIO and also -ENOMEM, potentially.

Good point, I missed that.  Updated in v2.

> Probably:
>
>   Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
>
> The commit you have references a state of the code, a much older code base,
> where the implementation was fundamentally different, per:

You are right, thanks.  I had missed that dev_set_name() could not fail at
all back then, and that the commit I picked was only replacing an snprintf()
into the same fixed array.  Both patches in v2 use 1fa5ae857bb1 now, and the
commit log says kvasprintf_const().

> The fix there is valid and would be nice to also pick it up.  Might use
> a little...
>
>   dev->dev.kobj.name = NULL;
>
> After the kfree_const().
>
> Feel free to pick it up, and include here as a second patch, so a small
> series.  Don't forget to credit Yang Yingliang, if you do decide to
> follow-up.

Thanks for the suggestion.  It is patch 2/2 in v2, with the NULL assignment
as you described, and with Suggested-by: and a Link: to Yang Yingliang's
original posting.

> This one I am not sure.  The NULL-assignment move looks awkward there.

Agreed, I left pci_device_add() alone.  It also overlaps with the driver
core series that changes when device_add() frees dev->p [1], so I would
rather wait and see how that one settles before proposing anything there.
If it still looks worth doing afterwards, I can revisit it then.

[1] https://lore.kernel.org/all/20260716230411.2767394-2-tarunsahu@google.com/

Thanks again,
Rihyeon
