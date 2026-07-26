Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9C3750D5
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058333; cv=none; b=HbuEqSoTG/2Xyi/4fi1+VSMXrpX4con+TsKutYsSooSF1NlURrpIq3/LEGKQ8Sl5Kr2SFAxiJhJMYpj9PBWWFDeyDWmfyltJXaM0A0yeTlQ5LckCBkopYJTi4xBqM7pD2Ud7GCqJtvtMLtnt6MygZFfOICqxZNqUGHao1+ZeW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058333; c=relaxed/simple;
	bh=pOJCn6MRTwenHiqSlXreBDk8qCLUjPSdXPSwsTfuh6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gPiMd+iNr0ZRFY32596v/YaRf9yToyCkCC2AIkIhh+vcQ0hAsdIs4+uBwYMAAYjQawazFI6h4kSaAinupM6/9JujgAejNLZmdO1wzuhlM/2Y3+Z10B55cp7PCUzmPACNR1HJImWegudSgOmj4XMKFNjxxgzEr2Z1zNhUEsreg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTJhepnU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTJhepnU"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84874b52eabso2408122b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785058332; x=1785663132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vf2nGakrQe4m8ykr6H44BkI8tt373xXT6T7MK0fSYTQ=;
        b=eTJhepnUTFjvvI15VC+cII6cC78zsHV+M3ywm0NDth75NuLDzFiY7OunJ81oZG887f
         m3FMXfh4LGbRxcrNnCXeu3Dry91CYijg9R3UIOY18HiEHDUjAXDMbDXdWCU3HBg5/UvR
         7nvDEEpbl5JmS06u2xbPyTwF4dYFo2/k9jJtEE0RVw2ToFaX+h/OKSynB8iTJBcsTSxp
         s4sLdELAp9a2OAyAt1ZEh+HhaZt3G4ctDTimxdVok6Ce35ghp3gDwc4PHVNjEzrXoGPS
         XyISqwU3HfglG4o3JNBpjXh5xZnwMd2X9UhH7wVdUS2LeeI36XP6TSYdR/LBSMeM/sRf
         jIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058332; x=1785663132;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vf2nGakrQe4m8ykr6H44BkI8tt373xXT6T7MK0fSYTQ=;
        b=kT7CT25SO6aKRMRVo9aphF99ov2xcOyvNoJIjgQZEZ1zXnoZqR94ykdKpO+G9IEQFb
         tlr+ZyJ5+PKHzgqG9+Qk9ipKcEoGOgoxZGhJas4iCPd3dcfqpKBUhx+0o+IkZoEXU+Yp
         Z5r+EEqrcbfjWMqqdnvqNgLTPDhMR3YQSSXhkRAWRolKd/om60USxOMhTBqNnBnVegXl
         guhZKj/h0iX7SxgxFfDjfDpIc0n1zieUW2saM+6LLrKL8DSo7rZ8uPHvBan+kJA0NC0u
         PG7t5bnoA6a9FK1JNmD6wqyIFQM1wZxPd2IWRsT+NZuzCJdsPYSo7iLIek70hRHsxJKm
         0hKQ==
X-Gm-Message-State: AOJu0Yyo6BJ3B12riiLV+mQw+LWPKVsyIkf3VTnz4Ekcz49t+1teLipr
	PONmMnVUfcIvhJ9d3aqeTBxcrAoakrFNEE3ctp90AS5TLdZCgouVq4xP
X-Gm-Gg: AR+sD11V2V9z+hv1nqVpLtXvrkmdyVIS2652aUwMAAM7F2usDYGP769alh6LbpIibFt
	I2dtNIWSRS9Lo98xfLq2GPbz1MXLPszGvZSIwMUwcYji9NlLb4coNh+Q0GHaaoFtnENgG7WuMJf
	sUYfdYdtMgzM0cFwbeeKyYiFnh++s324r70zC6LnVneJaZp+CiCvvNiwbus0dZslBmjmdDUSjym
	SeU7xKHvWqQuLKFAKBI9tgd6xCfP8Vya6mUrTIlGvrOEpWAg5rP4CAnwuQL5OD8KkPIJ6xEiZe4
	cY7H9Ae/oemMGxBoCrm6iEk/kmz5VkDp8JkkRWyZm8LD/yEo8gCqhNso3gvTTXefqdwN/eF6O51
	bbea9Meo3X4jF/J0rqwn8J7QC5O3KDXwnELX0lm4bVCKyIuFKvhfA4nPzWPMUxSkUGbdgte1JN+
	ddiA==
X-Received: by 2002:a05:6a00:218f:b0:848:86cf:267b with SMTP id d2e1a72fcca58-84e5959cb48mr3897037b3a.61.1785058331864;
        Sun, 26 Jul 2026 02:32:11 -0700 (PDT)
Received: from ubuntu.. ([2001:2d8:72ac:5ae4:b4c0:11d6:e62a:f791])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1448sm1731781b3a.30.2026.07.26.02.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:32:09 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	tarunsahu@google.com,
	djeffery@redhat.com,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v2 0/2] PCI: Fix dev_set_name() error handling in pci_setup_device()
Date: Sun, 26 Jul 2026 18:31:58 +0900
Message-ID: <20260726093200.146111-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

pci_setup_device() calls dev_set_name() without checking it.  syzbot hits
this with fault injection, where it turns into a WARNING and then a NULL
pointer dereference.  Patch 1 checks the return value and propagates it.

Patch 2 is the neighboring leak on the "unknown header type" path, where
the name that dev_set_name() allocated is never freed.  It was reported by
Yang Yingliang in 2022, and Krzysztof suggested picking it up here.

I am not sure about the attribution on patch 2, since most of it is Yang
Yingliang's fix with the NULL assignment added.  If it should look
different, or if that patch would be better sent on its own, please let me
know and I will respin.

This is my first patch to the kernel, so please let me know if I got
anything wrong about the form.

v1: https://lore.kernel.org/linux-pci/20260725104747.226575-1-rihyeon8648@gmail.com/

v2:
 - 1/2: Fixes: points at 1fa5ae857bb1 rather than eebfcfb52ce7, since
   dev_set_name() could not fail before that commit (Krzysztof)
 - 1/2: update the kernel-doc for the new return value (Krzysztof)
 - 1/2: say kvasprintf_const() rather than kvasprintf() in the commit log
   (Krzysztof)
 - 1/2: pick up Reviewed-by
 - 2/2: new patch (Krzysztof)

Thanks,
Rihyeon

Rihyeon Kim (2):
  PCI: Handle dev_set_name() failure in pci_setup_device()
  PCI: Free the device name on the pci_setup_device() error path

 drivers/pci/probe.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)
