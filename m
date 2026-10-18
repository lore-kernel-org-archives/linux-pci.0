Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176F4BF93A
	for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330177; cv=none; b=jubP3DfSU9U0wAbxXXD4fwAd9YlFm8fpewKNZP5bOhTgCZHMJygd5E1kP3A1sUYrbLGL7miiBXDh5CFlGvYuLkbKTNlHfWHbRiXrZDt+dpGfEuIoj3YmU1gPR+1NwBJZJsKCZ3s2lLPho2Nu3mCJ8ItTr5gdmPEiVCvTOQJh8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330177; c=relaxed/simple;
	bh=aaZ/xfQMHY9Y0WooyFtWFJTJzmhk37MWsnb8cA317rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZxoj8IZCFPYN747GMjfcu5b4cZY/khB7hPc9S//pfCq33MGDSIXq59Fqdsqlm/hTgBoFhz8gFJ6Zkx+wfWgmNCU9KtKyW5ed+oCB6zhtGM3xonwemq13vgHHoVNjRT82KLOkjHy67yRgtxV0ChsKG0nyI+lu8kbxFM9pxnnhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6W5bODC; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6W5bODC"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3514b90bb89so3278145eec.1
        for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792330176; x=1792934976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbcIoitvuAfvu3Q7bq63av2aFlfOV01EbbwSM1UVRBA=;
        b=G6W5bODCnIh3chSl00IK9TmdisgEBNbbKZNxhWZrNjTLCtDdPglbTPPJ7CqUGhZw36
         MPg1vmAzUE5CnjxklMXIzKyGD12KZVVGlb23d5GdSDG9p1iw1MTvBUj8aPA+p8jbPbte
         kDMK7yPcKzOQSWbm8Wfc9Gr8rrA4qnYuDf3xZjNAC0wTKQmpOgiTUOsqBi9YvuqmRTS9
         CD6vVOmJfruJnVcIou95nDGnDRLJJzXlSkKPPlofl1euoKu8KzxlqsQWR+Gxx+Qg+fVg
         7UJvh0BsgjeZZ4CHopoQdZjYZFW66FMt6bYYuPiKqw02/eeQriPsTBP4J1RhhAsqXpNc
         7ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792330176; x=1792934976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbcIoitvuAfvu3Q7bq63av2aFlfOV01EbbwSM1UVRBA=;
        b=M3vGVziOm02Ee0acwzZ68gfuWOji8NXchjql4Phk2F99xEbO9m4nOwyP3txOWr13Sv
         37BVPP3uViJRIyAjF80GOiAL3hdX0Q11Bs0zDWAUw34E+tD+ZYYHIKKGN4fsbpUfCach
         o7ao0WNPtwCyaBzNfZ76zBztUopKXJY1TOvUGF82TEyqkPPU7FGZJ2uN4yyCWpPoWaxO
         F12VqHNNsm8YzPkcwLKVKRKSxzGHHxOng9aTRt4L27OLmD9FePKqOnbFg7AbgaLkI/aA
         KrmigeBD9ZayK+mFHIptvAasdfolsOkCbpPEWfjhhOFoK0kaiQzGiTEFhoYwtLVegVdd
         LF2g==
X-Forwarded-Encrypted: i=1; AKwUvBxfdl1/tnU08OViYPggz9HChOGF/nnawvFiva5Domfq9Hx5sHGRA0wHMFKXfk8xZCo9+XzYmmskkqA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdKr0d9BZFhy9tmRArNlgAt+QcJUJGRtaECa40YGHyYmT8oFNR
	SX6tbZY7KHTSZmi5bODh3+Pt5npix8wZavKIgLhWPmuDSByI/mX584fo
X-Gm-Gg: AYBFou19zPiqmWzeMpyfQ+0JsiV0T1YqGuROUJ0wOP6+b30SuHck17O/xB/3lT1pAmp
	iIhekdPk1XIgFNTGIy6Sd57+4wdLe7P8FLd/LJaHBVVK0vkTUSH/qErqDnP12LX6gk6HqM+er9r
	XvfXq6jT+VjKnLoPrgOLwaKyivpAMwH0l8XZ/XoHj2A6YYvqT+Mq9jzYbM/HB4Tkev+CUQm65mQ
	yKjAv+Xf88e47z0ZoxESgKa4O5LWK+Ha9NfEl9Q+cY1B0nw3rvkQi2url4tCOtkk/zyyGCcsDJ6
	LEBSZKeLmWZeAn7ZeXk8R8dqtVteEv85RsvG5NTJ9PbqS7Inp6bYdeImZ/PzM/v1ICMoQjVYtff
	i+00cfijV6v+ajAP+bBGxf86pBlzEFemTWvFAmoMWuZ8yM0rlsLoANAoaw01bwyscYbQzgNd/v6
	jEr4PiUToLWZ42kZlsl6mRNJQNGyNOAlAfxEG5MBfxOaOxbmmKXhbXupXyloeffqmted+X80oYu
	j+A67hA
X-Received: by 2002:a05:701b:424b:20b0:185:b157:f271 with SMTP id a92af1059eb24-185b157f2famr6583291c88.23.1792330175524;
        Sun, 18 Oct 2026 06:29:35 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18319d3b880sm20099539c88.10.2026.10.18.06.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:29:34 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: helgaas@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	lukas@wunner.de,
	linux-usb@vger.kernel.org,
	d@rrell.co
Subject: Re: [PATCH] PCI: Extend Apple Thunderbolt power quirk to Alpine Ridge
Date: Sun, 18 Oct 2026 10:29:20 -0300
Message-ID: <20261018132920.7407-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016052503.GT176164@black.igk.intel.com>
References: <20261016052503.GT176164@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mika,

On Fri, Oct 16, 2026 at 07:25:03AM +0200, Mika Westerberg wrote:
> Unfortunately I can't expose any of the non-public bits without going
> through an extensive paper work.

No problem.  I'll describe bit 26 in the patch only by what I measured:
with it set, SXFP() really powers the controller off and Linux does not
bring it back on resume; with it clear, the controller resumes fine.

> I can comment on the ACPI bits, though. I think they can be put into
> drivers/thunderbolt/acpi.c if they are strictly TB specific.

That makes sense to me.  I'll move both parts into drivers/thunderbolt:
calling SXFP() on suspend, and clearing bit 26 just before it.  I'll
test it the same way as the PCI version, with a USB disk attached
across suspend, and send it as a new patch when it works.

Bjorn, that new patch would replace this one, and nothing would be
left to change in drivers/pci for Alpine Ridge.  So please drop this
version.

Thanks,
Francisco
