Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2092857F0
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788007055; cv=none; b=YluHENsFpI5K+OfhofujtafxoBvrmE33bYiFYYAVpv+6S0ppaJ12PNzLMK5RxoIMy9IlVMw16cPwwzXRvTPioRl0cjPhdjN7+6fcZiANIcvEXQK1ui9NAn16vA3Ikgd0zY0Trb0NkxZk5KQaZG6RpF8c39J8OMMca8JVqpY2ij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788007055; c=relaxed/simple;
	bh=jZ/lKIPH3msbV5HTdGIEOWuVbVvQFeF5aIS22QAKE1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKCmudRCtizL1TBzOVJwMWFAt0VXy9O57V8cQWCrkJs/HvS8td3MAvTTmpKaGROY/E6z2sqhSqUrpkCZYeTCcy29Y2+sJ7PN5bBGQjm+BiZmZnhLUXh24HUurkoFpjSbfedlsng/e64TkTOTfnDiRhwmo6tolrfltA1AIBn9l7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd/4LCly; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd/4LCly"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d8f2ed7bdcso554925ad.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788007053; x=1788611853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZ/lKIPH3msbV5HTdGIEOWuVbVvQFeF5aIS22QAKE1E=;
        b=Nd/4LClyODk27e6ZJMBxAQODmhe9JGZ/zkKakM7KucleOtUz1JPmzloeDtEsu6Vvvz
         9f4j5K/wDRIsXd20eh697wIExGsuQv27K2y1eU/zpT1a1zi3XyyxA3MWc8ifQguTO4LK
         qiLjRZIgZaoTNrJkHV+gz3M2IORvGsvZj3T7UDD24pyFUw4ioTn8keryhHiX7jnYnIzm
         7d9pCrTSZD5aJSf9AnYLX9+YZrN15diTiYJ09tGjifvFYg0hPdlWlmmSvMflqanznUDB
         2ox2K3cfuIqq6f6RcPxUw6C7wsz9INHThU1yrJQVuQ3lQXOFlL6o9RY+VkZs9+tahMxw
         haDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788007053; x=1788611853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZ/lKIPH3msbV5HTdGIEOWuVbVvQFeF5aIS22QAKE1E=;
        b=iOlZHJRzYbBcHI5XmreEod7VXXMubMEfGqYX2b/W7u87E99GwIpepJEqX2jNHTnIM9
         742PidB6H6S+wgHlo9CL7EsEaYyQ4kSA5kJ9DAP2dOxOsYz39aHwyFERx+8HacNxczov
         apBwsbKmvGvJPorDXCcYd63mtZvtWaL5kaKQpBb9W7FaiTf3t5jIwux8GzocAMoNqktV
         PGWTx1o01KGI+LtEOZgl7sXZHH61xsMs0VVhkwe63zJwqoMoZB42Biq62rQVp6u+jF9G
         N+7D0ISX4nvt8/X9we7w74xDD79xo0q892CzJYlrotu4GDvMko775VlnM6aBM7M2lgSM
         ScPA==
X-Forwarded-Encrypted: i=1; AKwUvBzK0FUpoNbxX7JVgF6xOw6LJYX6W1qBhhG462vtp4d9XoGL3j67uXW7eDl1NdaGOFpJAxiu2w5/kcw=@vger.kernel.org
X-Gm-Message-State: AFuF++kWhYuGX63g3bUiDc31mAfhGm5/xw6lKiav63Mt5QTsYrhGqUMF
	JqXYAeSnvgBR0/sAXEPU7NEkutC0TAlGAs7CDliGaer/GcYMpvcaKDbf7HNxVJ09mFI=
X-Gm-Gg: AYBFou1I3JR8yqx35kSFVo0XsXJom+eQXJFxrDH2cjWZxmqziA41aLUK4unmn5ITJ1J
	VbC46tY6addtkd6NiV0f9AB/J+WMABdcb4SbRaOxI+xL79KVs6Q0HKYLqkepm1M0XWOIl/vwjf0
	ML73Hq4R+dR+Jjv0C8zYuhnouN/96WkB7iXnEpkWBzIdp+wNwavhXbaw84hKa4Pq5In72iYOCRx
	KWowSZ1FIczmSnoY+jYhhejnFvlp/J3g6dKFpt4fNrmg5cXeUQeHt/Fd7qL/22sGnheb1WrffvZ
	QB/bTIcApVT2Bjr4eNGZt0JCnpFE9T9wdomuUdyKJ90HXescUyUzPFILKgOLHaJE997fSPh4RG1
	TfXwy+nS7p5B1OJrf+2uVJv46QS2tiBRKdUDZWhiCoqA0V5fUAhu7TJ+BGDeSYDg1r0ykxfoZ2b
	Y2Fehmy4c5My/eJzKfuzJGe7itIhNuRQRU2ltUUO/I0+uVKQqzBP3WFjYqFdP3Mgb4rGWFT7YY2
	GQTo34anVxqWth6ySzry0RWez7yxZPzz6FovsA=
X-Received: by 2002:a17:90b:17cd:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-398bad20e70mr1703035a91.6.1788007053352;
        Sat, 29 Aug 2026 05:37:33 -0700 (PDT)
Received: from cachyos-aura ([45.112.149.37])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d1b38esm14008113c88.3.2026.08.29.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 05:37:32 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com
Cc: nika@nikableh.moe,
	emmanuel.grumbach@intel.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless 1/2] wifi: iwlwifi: pcie: arm the product reset at probe
Date: Sat, 29 Aug 2026 18:07:25 +0530
Message-ID: <20260829123725.86014-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829100758.8E8491F000E9@smtp.kernel.org>
References: <20260829095437.44716-1-navonjohnlukose@gmail.com> <20260829100758.8E8491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both findings are correct. Please drop this series; a v2 is coming.

On the first: arming at probe does leave the mode selected for the
lifetime of the driver, and the disarm in iwl_trans_pcie_removal_wk()
cannot be relied on to undo it, because it fails in exactly the case
that matters - the DSM is gated on the platform reading the device's
PCI ID out of config space, so it is unavailable once the device is off
the bus, and set_product_reset() ignores that failure when disarming.
_RST is not gated the same way: it reads the mode variable directly, so
a stale selection does execute a full product reset, Bluetooth off/on
included, with no BT teardown and with the ME downgrade bypassed.

I also need to retract something. The cover letter argued for stable on
the grounds that "every _RST evaluation is already preceded by
set_product_reset() setting the mode that reset wants, so arming at
probe cannot alter the behaviour of any later reset". That is wrong. It
holds only when the disarm succeeds, and the disarm cannot succeed on a
device that is gone. The backport rationale as written does not stand.

On the second: yes, it logs IWL_ERR on every probe on any platform
without this DSM, and the commit message's claim that it is a no-op
there is wrong. The two neighbouring functions,
iwl_trans_pcie_check_product_reset_mode() and _status(), already return
silently in the same situation, so the asymmetry looks unintended - and
it is what hid the failed disarm above.

v2 will instead select the mode from the suspend callback and clear it
on resume, so it is only selected across the suspend window; guard the
_RST call with pci_device_is_present(), which reads the same config
register the platform's own gate does; and demote the log.

Unrelated, but found while checking this: iwl_pcie_recheck_me_status()
reads CSR_HW_IF_CONFIG_REG without a liveness check, so on a device that
is off the bus it sees 0xffffffff, concludes IAMT_UP is set, and marks
ME present on a machine that has none - which then downgrades every
later product reset. I will send that separately.

Patch 2/2 is substantively unchanged in v2.

Thanks for the review.

Navon
