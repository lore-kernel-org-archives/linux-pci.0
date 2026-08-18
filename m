Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347D3E49C2
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033552; cv=none; b=M4EyhtphHIlUpiw45/D/j1rWq9+Nx0HOdAVNzV8j4EGZM5DGnQVLq5GHDNqXLnnBsQp0Vy/hzdV/fnc6Xs0PZXj8N6WqWe78K1/VFs+LB5Ku2z7w6kAbt+Cz5oOiiXNsp0idcLBC8RiOsdmYODkaNtJQ0rjNoKNneQSaOBYbWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033552; c=relaxed/simple;
	bh=T9ou81mQsHQI9DBrDv+ypWgofQ1fnReLCvDM7WD25O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shWiujnKqznu4+drpSGkYpq1O5DiXMt7ZaYsoinhmsQFyFLcL9grvOnGWM4Mo/1sBBe8T1zOBZDAbtY/5w8XxtXdusa3FthCPCMVUfahKHpncuXR+G8K4ToczyOoc86SyrLamFVg1sdn71g0XYfe3csHkl/xBdZ5CVzi6uQROJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6O/gamF; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6O/gamF"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbee846deecso4512617a12.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033551; x=1787638351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T9ou81mQsHQI9DBrDv+ypWgofQ1fnReLCvDM7WD25O0=;
        b=n6O/gamFeKDm/Me7/kbtrJte5c6ATYBtrZUEv8yeL3YKe8Wk4eU10bz7ZzmXS4MFIE
         l8gyDJsLEx8NolUgJeqzr5EKqu5fJt8If4jK9uDVokX4gDoe4alymHMZLA2WF39VElwd
         6RMgn5RFEHM5WGFK0uEUxTR5d81h0NIQ0y7lIHGuMPgs7/vpET2XOkyEJFc4QI25eJZ0
         i61zdQyjfmxiL9Z1u0D/7FoFg4/z53U3mr00g6SrTdA4NCFb1Ksk/rz8VIvHfiaaVWDq
         xkKqoO/Mxwx0Rbgq/Q6ftR++gXpezTDcqTcGzGW0jQXHzHgMP5pxMILX4+u6eiHVHAet
         C9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033551; x=1787638351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T9ou81mQsHQI9DBrDv+ypWgofQ1fnReLCvDM7WD25O0=;
        b=Xx7xMpXDAbOhQzFwo7hxuXOkpwmev43wHGzWC86vehGhMRCLRrPdxY5zKKK6dGuZC4
         mqPDxSLZm9PWBTBf8RU9GsIvWzPaFfE4JR35QitCQGjGDj0p7nRd81ammekBE4UkU8hQ
         CFk3jumFIFH5plTi8Rf5mLook4E+C2DE06CzBPD0po1TZmeCMec5+5Ca6C8zwJuxOD5k
         8q//E+uML4yhuPnZrBU7kGwdfMNdV9xusbl+h1C7YOtfetJE8Uqoa18olG2ocNx+rmxt
         zoCff56yz7mNtNvj1f4AQK4rptaMbczzafNbw63US80OkqvwlJeL5uNdbRekXeyrGO83
         Jtwg==
X-Gm-Message-State: AOJu0YyNGUNzWZUMK0jA1qZR5Yk1K8A7cs8ZxAzFmvXngpPLUoond8/P
	jXe+JnK7jslB5n51VduVctF1u8kkXe+CVSXyw2K/Luw+LNioLePv++A7
X-Gm-Gg: AR+sD12jrp5VZdDDDajFZI7T/X1Ocv4UswUcwC3247Iie+6npJ5lTP950ELxLHYcsNK
	PS+Bn2e5qwtp6DcmiLsMQfAguDIjHoGIBQHdtNqulBNoFhszUj/nqmVvScrUc3YWSx60XA2CJSq
	8pHF2XmTxKzdzu+SuJaCvfLJVk0K1tpAGcufwISDfGz8c7nFjEbKBDckZ2NG1smH7Rr6LQ73zZI
	aIq8wxEV5rzY9ivIM4omXFlPt/Wd/U0Ir//Ff4Qgm3xEseg8ZQZ1/sm91aSKdDv97ArgLcBqqgS
	6VeWXG6oaKqvgR0t1O72L9so8cY4E8UTtobW9ABed30CXvbtqDILRuGXcQh7H0YXUqHjrntyYIA
	m/xTOl0GKMdtAip26pzbul/WzlZ6UQjMrzY0Gdus+cfCWYoKqgprCktek4b+Pz7YZKlW/QbekMn
	QlX5A2q8IlpmGFKBJHxhzNlD64gPyriP0AluE/CUHzAo0/rpqmYHdTOiKI+NKZzYttK6urz3fd
X-Received: by 2002:a17:90a:e7cd:b0:380:fead:448d with SMTP id 98e67ed59e1d1-3933b87224cmr29930037a91.13.1787033550643;
        Mon, 17 Aug 2026 23:12:30 -0700 (PDT)
Received: from ubuntu.. ([2001:2d8:7009:fd05:22da:eb3b:b5f1:7968])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d3b3b91sm4827821a91.13.2026.08.17.23.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:12:29 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	tarunsahu@google.com,
	djeffery@redhat.com,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 0/2] PCI: Fix dev_set_name() error handling in pci_setup_device()
Date: Tue, 18 Aug 2026 15:12:23 +0900
Message-ID: <20260818061223.63247-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726093200.146111-1-rihyeon8648@gmail.com>
References: <20260726093200.146111-1-rihyeon8648@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping on this series.

Thanks,
Rihyeon
