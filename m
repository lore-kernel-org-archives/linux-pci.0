Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA330AAD8
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289010; cv=none; b=FMo5+RogQtpmQUTqeTxjAuLToPlvCyMgg+FCEDqmYqgVGpRpbc6ubc+jHRx2DCW12kHvHH14cmNUAmzyLdKxet3hZjY48Bzeq1YbMg6yfVh5o9J/UUk9MOXwoT0k0siyNGBj+0p/i4rw+GAhxS+baCAdQM8wHNA6tseyN1AQDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289010; c=relaxed/simple;
	bh=fexO/BW8s5XNYmcLvHdHv5XSJ5iuP8KBdmfVxzzWQas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4K+COb1J/HPVRuiYY+HqJ4tKKhJyb1q/h5aoi74iCTtvJje/vwC2YVeA4lhw29sLgM87ieIfPaY1iUEthk3xehg8FZ80ii3c93OwM2N5/iIWEQULpL7zi4ALECQMJKp7qOOmKTS21WxFk2xKNBS9KO/bVqmWC6zkj2zF5Zeyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajaQEzoh; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajaQEzoh"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so292459c88.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289008; x=1790893808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0sOEJYyO2a7X5+wDHXF372OnJ9gz01ToKiWC4Y4/oOM=;
        b=ajaQEzohVbXcunP6C5Qwnu3QFhwTkDDyFoLxWbpOcOJ2FI/vtXAfdnu3wHVjPIeXkc
         SHXghLws1J3kilKzaewZ7W/ewvvw9y3qohlA9PZAueVMiMprCXuv93mZNUF5PUPeL8Uq
         rQc3/kXUMFAlW7nh2yNp1in6uELncs4jsVTcjCkeIxX7H+W2HbLemxJYFK0Iuiud6jkg
         mrVyZtGuKduWcRbRdlhbhP6PiZHZBhLZkjVwDZSUNIreeZ1GD6QdCmezXjcqJZ2jp5yt
         Hp2os4d47tNMG3MHlz79D6pugHs/tF+2V7WwzCjOW8AvaH/bGviooXASO0gu72HaRbbx
         A++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289008; x=1790893808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0sOEJYyO2a7X5+wDHXF372OnJ9gz01ToKiWC4Y4/oOM=;
        b=CmIORjAFAP19BhLFAMYYbPkmmRO4u6mbQWvVHHvbPirkYgQTnALZaivBhhQ954LhXm
         7WkVxGGdldDZqPv/zwbeGp1lLteUnYL7pELqzwG6Ay80jbhgS8nB1uEcAE1cDSgalpX/
         72WhS/r2hBgt9h0BUgHXabMm3TqjM7QhBY9yHULOzQHKPSlbBlfVTtesV4/ncimnQh4M
         yogGf7PEzQ/MGcM7jkNi3of/A6Vh6mOpZRN76C+sWhkZlm8PRhbkbUsWiBufmmTMtbeS
         G917Rf7HTOkD7xFk0cYBqmKExs7AcTQ0Tb8pUQ93qY+DRmrJqDzwBVPAR8PXEwxJ5ERh
         b4Cw==
X-Forwarded-Encrypted: i=1; AKwUvBxyTI6BQ+3HSC/KYr7Zs3F28U1fCHxmuTc6MGzL28uyFPuHRhqutF60ejkmajS1ORZYr7hfHHIHaoU=@vger.kernel.org
X-Gm-Message-State: AFuF++m7FBqgQI1lfy2sqIqxHZN5RqSIlzfnkHKQDHLuX3ImxsAxddko
	FFPxb3ZUkWZJuJjU1GxAapI6dSiNEfc8R2ICRvcxVCgNRhe27VpPT4JK
X-Gm-Gg: AYBFou1TZmSowcmhdVBNujbqFE7Sj3539UAUiU9UN+MCpcx1Q9/nRBxnx7XZgYhbeaS
	04ylkx0GGEgjRtfzhRYj2WYDfymKu9IH8jDJudcpljWePTeu6ImR/KRlgRWDIYfYDNu+dUlQNxb
	EquTXU00AMsMgM08p1Jl8qtNW8PPpGbqgI61H+jDGQHdPrhU22WbwGrXB4GEj3ZKii4SD1nzorX
	xpqyOxh7hdaOAszmw4GIpuE0xYeNZRkkkzHx8bRgJ4yNIK2VXbQXnOVpg7Y0JhqCgUROOsBfRMe
	PNOfzLTveV4po7EppxTQj1K8ci8aqNqf2Xw0xCJ6aeuSxgm9d1EN19YoCul6V5a8ojnRt0uSYXS
	+/8grPAXx+eQ9szp8VIAB9RUXDfBKqIddpOpXQgkH9NRSlu7Tygt7X8YY44UM7oUVNwmE8Uj9Uo
	XiYSvj5MyLBKIQZ8SJY4FNARp5oA+nWVA2qP05i4ARQpyxQUKk739XtvKs8J5ocmn7Cc4rdTJKR
	oLJi25U
X-Received: by 2002:a05:7022:294:10b0:143:271a:8b82 with SMTP id a92af1059eb24-145040653ecmr2791717c88.44.1790289008088;
        Thu, 24 Sep 2026 15:30:08 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c3f8sm1388240c88.3.2026.09.24.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:30:07 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI/PM: Do not save or restore the config space of an inaccessible device
Date: Thu, 24 Sep 2026 19:29:53 -0300
Message-ID: <20260924222953.26697-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924124221.12374-1-fbeltranmillalen@gmail.com>
References: <20260924124221.12374-1-fbeltranmillalen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please don't apply patches 2/4 and 3/4 as they stand: they break SR-IOV
virtual functions.

Both treat an all-ones first dword (Vendor ID and Device ID) as "device
inaccessible", but a VF always reads 0xffff there; that is why
pci_device_is_present() checks the PF instead.  With 2/4,
pci_save_state() fails for every VF, from pci_bus_add_device() and from
pci_dev_save_and_disable() before a reset, so no snapshot is ever taken
and nothing valid is restored after the reset.  With 3/4 alone, a VF's
config space is never restored.  The machine I tested on has no SR-IOV
devices, so nothing there could show it.

I'll send a v2 that uses pci_device_is_present() in 2/4 and reworks 3/4
accordingly.  Two more things it will fix:

- The cover letter speaks of "v2 of this work", but the earlier version
  was only reviewed privately and never posted.  The next posting will
  be v2, with changes listed against this one.

- 1/4 says the device is left alone when pci_save_state() fails.  That
  holds on its own, but with 2/4 applied the save fails without setting
  state_saved, so pci_pm_suspend_noirq() calls pci_save_state() and
  pci_prepare_to_sleep() itself afterwards.  The code in 1/4 is not
  affected, but its description is incomplete.  Alan, I'm pointing this
  out since you acked it with that text.

The v2 will also carry the Assisted-by tag this posting was missing.

Francisco
