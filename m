Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E905126F3B
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773203919; cv=none; b=KAm+ICLjLW6eRaaUVp5tWIX69/Y4ObvDPqUggzud7YCfrRU19aoSVoGOu9eupeUZvlK5ygp8R+2Aqhu4P0u99q/k9EBESzqrMO6KESgXFCHIyKt+BWc7jRODZTrFyRI56VlKtiKgRiP9zXwD30rjvkCD6IclDDu9WcgcgyFBk40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773203919; c=relaxed/simple;
	bh=b73m/0G4bp9qlKbyGpXs2BmQnhyq68YsG8re+bxd7zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOvSvTt7KxS7JJOQWVaU4Gg8YDc6MhkqL8B18YIXvZHjbG8ToaMrCXcNaz46vsHaU4a3yxSjZGVufULWQP1OaWB1xUZl6dgfeNNyqM3h2S2cehHqgaRqNtof+JIONlBQKejNlYCHJd/vY0WKsjqNnWHQ7mF+0o8doD4kTnTZw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtK1JOGN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtK1JOGN"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so8355664a91.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 21:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773203918; x=1773808718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOpJyc/uxw9YcZ5bYmcC7bF77XfwHzZK7dfWyiG9If0=;
        b=mtK1JOGNkUqANef7tcws9FG9uYdBx8rECyqe+z1NGsmn/MlG8YoLc42wGLz/f2Hnkx
         maoAr9hnvvC4zKx6qJL6x8QFH5tXsbCHt4X4GsY76XrAJeTCSxrjKlcydGzA7ZCavOVZ
         o9+aBhEwa8+tQS2gqSJrtg3adUCkLkmLp1Tr5h3fk6McCvVUnjKbb7u5uzqIaldZe6am
         8eUy/nbiM8O/r/raMQgVj21LKlbJDYA/ySlohnBhIeFRFh1tpOKvn0DTBPzgcsLK457r
         HX79GxnfpwQ3jHgGPGum1Lc/nLNPrqKQOqtD7Tqf2RXZ0bo8PPcl/BonHkzwYfGhU+9A
         PJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773203918; x=1773808718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOpJyc/uxw9YcZ5bYmcC7bF77XfwHzZK7dfWyiG9If0=;
        b=uegmO5C9Rf7V8mqzj9y7Pn+fdf89cE7UKivNpjMz3HbYPiPys0lJ6mK9XRjYULWH7t
         vdnQP+v+iDpAFpiWSf0DHvc8kofvoJCyxgFPn1ym99SMRn2KIlOUS/UXlK7S9f+RKHRR
         eu8IZ4QdR9CFZrXpMaZuwRCq0eIMncitafOmMlJ3e0mpqm538bDFgxFi3HknvKTaa4FM
         IDYokXDZOxTVdv47AALrbURNlDswMfhPc3XURU5Aaqpv+Ygq+06mU4AVtp2OsD1a/gNt
         Z/EAXY/fXGMDcSMF6Ee313F0KISK5i4VaqIBKwy8gFWBLR4ofoRyQz1P9yirDO/eUJax
         9X7w==
X-Forwarded-Encrypted: i=1; AJvYcCUr5Wg6YHGmsd+qtTDI3gkyO5tbebcWW8m67mX6xnzpGEL6vMEvd514vq+zr2JAs0OfsSwvKDiVhy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuKIyoDq13EGjqV0ki4aZeA0IPKRCf5RVunuLa/Lf8R1PxizY
	0VD2k+NkrOtaD73YGpG3OIexSpxDRPnYGqXIZzK2JUTiRnNimh6Aqu5h
X-Gm-Gg: ATEYQzzzcvrqKZfzXBTM24xA/BlsFhEgulSOKZZCTpsE+tyE2ZQ+66xaylUK5sJiexn
	wH8qfEH0g3gVEL3xEfm/KXSpWUqgXVfBbNMHB1hOrOoMOY61rStu0E4gzJXKMdD5+ee8k1J23j9
	bnlqrCvyB2W2Eae6n71XwFGRNQmTHy0kQIOegMAveRUaJhHc1XzuRO/SOvm/ZE93hfLkCXkjIKB
	bwlIB2OizQVh/Ztr2/7OzkOuFutm3qwFl/mJrhF8cBW5fS5WWXDuqH5C0FwTuPyglHYe/d3A14+
	HQEu38isI9qzvtXf2jVtHbEZL7IL3JhcOTeWgUh20JoW2pj+CD0qaWBxZCDBX+qS4SOmySzuapm
	0g+/HD7TguTgHzsUlJ8hfhqpi19CqVp/xp0oj8e5bHk9/dO1meniRecbyr50+nOSD8IAGKYgBdn
	UyuX2etsSVDtQx4arRi7V8lMnNKC98dhxcHq6tijRzpg49E+6Izt/BpKHG7av1Zphzu1UkkENuX
	1xCMw==
X-Received: by 2002:a17:90b:3c90:b0:354:c6f3:d365 with SMTP id 98e67ed59e1d1-35a012eacd0mr1283571a91.17.1773203917898;
        Tue, 10 Mar 2026 21:38:37 -0700 (PDT)
Received: from localhost.localdomain ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f06fa04esm4679484a91.6.2026.03.10.21.38.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 21:38:37 -0700 (PDT)
From: phucduc.bui@gmail.com
To: john.madieu.xa@bp.renesas.com
Cc: bhelgaas@google.com,
	biju.das.jz@bp.renesas.com,
	claudiu.beznea.uj@bp.renesas.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	geert+renesas@glider.be,
	john.madieu@gmail.com,
	krzk+dt@kernel.org,
	kwilczynski@kernel.org,
	linux-clk@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	lpieralisi@kernel.org,
	magnus.damm@gmail.com,
	mani@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v8 15/15] arm64: dts: renesas: r9a09g047e57-smarc: 
Date: Wed, 11 Mar 2026 11:38:31 +0700
Message-Id: <20260311043831.2576-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20260306143423.19562-16-john.madieu.xa@bp.renesas.com>
References: <20260306143423.19562-16-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed that for gpio-hog nodes, the kernel already uses the node name 
as the default label in /sys/kernel/debug/gpio if line-name is missing. 
Since the node name here is already pcie-clkreq-n, the line-name property 
seems redundant. Should we remove it to keep the DTS more concise?

Best regards, 
Phuc
