Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3702D781B
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513680; cv=none; b=TQOxQwFT6iSi63VbYaZZoTJMwfadVhJNUDUwo/VCkTescFr93mhFoiHl4tJWFE8Y3E6qDUVWJ3eXuiNBR+43DkqLnpleamINIMxm0dVy8xMzMe9GjPJr2sU4xFcYmIFaRE5isEC+zkdgpzYmZvt+QpruJBM1NdntWRdazZKpbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513680; c=relaxed/simple;
	bh=3ubcLCcyt8+VvZfAFT0yrgNoMjVrniCRUSXMbUphHPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTvCMU0dwmxH1UMWmFk+G6HhBIXByivlDnWGMGewpQ0L19rM8IMLK9VJ/NxWkGCLO7e7f247zjmBra6OPu0822DNcG6u/8PSZmcFn78gh+qS5PIeRh5zMwVoWhz9faqppoVIiquFdBscIxbieM220goaWyCNWB8WRNsO5Wjw2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnJSGlYg; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnJSGlYg"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-351767ef18cso2134449eec.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791513678; x=1792118478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yTsktpTllALq6EwdHtFSoFwjaEzOVxy2nJk/AnvaP7c=;
        b=TnJSGlYgGvZ/r5OMmtbIsrqM9moQCvrPxarrTkch5lvSp03bRG2PW8n8YnkQiIFtok
         87El//GIeWkht1VYr+pvUMhPrpxw5+Js463AL6dHdZMuxUannXvg/1leLHN6IbrK8C4q
         mH1bi03XoIpzPwTCZ4zf/Ijo4u6hSRZiMDoqAtUMv+EHOmgaiJbd8YuT24khRPuRWGwq
         YxhumnotMAhpmOa/OE4A20uYK/H23nh0Diu0JkhAGSAZ8AasvWWhxdRMjosnr2VhOtxj
         QwiYm51XYHQ8g420Fn0qtRBVPOHeqRgVkVmPwp0ev6ekS/H5mmvSZVO2stA8jy7qVv7x
         um2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791513678; x=1792118478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yTsktpTllALq6EwdHtFSoFwjaEzOVxy2nJk/AnvaP7c=;
        b=Wy+a0SztM+m/im41HyBLISQM9ci1PQ0ZN06cWazZtZdkJoJBr0Bh7aw3mYppfFOLDC
         NjcHmZE6aP/KucGpF0JXNtxV8oAU8CiArF9juHXlrPukDqUrnpy7Zvr4k0GEtZfBnfJ9
         CDgQxzFjTFheayGNfkHGWnycGH4sEPMHRTFwUciTyA2M3CcXt+R4AueZVHAGtsLjviLF
         Y/WgXJmplRS0hITQSFTpp6vXNWWNbP8Qw485p5I2bmD+4i4NOFwdkqCUYB0VjY1MySBc
         JlO+2pc4lky5rkDHrKrZuoYuyBiHQmsRhDeqKCERPJ6fZWehPMsymhnLSGm0QJqlsBSy
         79PQ==
X-Forwarded-Encrypted: i=1; AKwUvByE3KOFsurVXuUKjtTXpy5rgXxq10/8vSedt5hsqbewez7d2UGS/FmP2egqA0Yj6P71i7mZ2uScYrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1gWgHx+FsyTB2bfQN+mA8tN6sRIzGlspU2jLR6TE9jURDhQVc
	sGLFvkLwtRm8rbEBHYDzPXyUe49yBarss1SsU07yVTwChtrTXFkLVtB8
X-Gm-Gg: AYBFou0WLTzSlclqpfIxUzqz60CX9dsf/tQBBVsAQUQjl+8EeET0qLghWZF03f7H2WT
	v2X+AP1voX1/hlld9G7lOFsV/NCXary+ySUWRDJ5HtzlOuIJKdPwYEvFous+59DUIDQIjnqrNtB
	Bd9VDwgVCwlVEmCgPuXCB313Nf4TryqwmS78Ay91Sc2r/L+q6zsd3kzNErwno03xTa2AuL+dOFS
	sfQ1TpUmzZRGlP4XlgdG53G0Jjvp1vJfzI/SMq3Cxf9GdMDhle81YYENLTexYfr+VSjFytJMzK6
	4I2VddYFx25Rs5/RqGLrZcCmLXbwU2TcWTE5nl9TMCqkzG90aWsPUBzXPowdTDD2ovuu74PMtt5
	3fofi8SYohLCkRi1Qx0QXDG+mNdEyT7e7NfWWShtFu4mEGn5uvd4HXjrmMYkuHCAuUXKN9YmAlJ
	FNCG5grUbXduQjxpzfWjhsXcNjVO7LpUHZZHZHfzeY2y/G1BntZiOtHJp3a2petI1Oc49HWXA80
	Md5Hewb
X-Received: by 2002:a05:7300:ce94:b0:351:6b27:d67d with SMTP id 5a478bee46e88-3537e04925fmr988070eec.30.1791513677882;
        Thu, 08 Oct 2026 19:41:17 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cad9e53sm2343328eec.22.2026.10.08.19.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:41:17 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	alifm@linux.ibm.com,
	andreas.noever@gmail.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com
Subject: Re: [PATCH v2 2/3] PCI/PM: Do not save the config space of an inaccessible device
Date: Thu,  8 Oct 2026 23:41:04 -0300
Message-ID: <20261009024104.14995-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008225825.GA936610@bhelgaas>
References: <20261008225825.GA936610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,

Thanks for the review, and for suggesting a simpler way to do this.

On Thu, Oct 08, 2026 at 05:58:25PM -0500, Bjorn Helgaas wrote:
> Apparently this is a reproducible issue on MacBookPro14,3.  That makes
> me a little hesitant because we're not actually dealing with the fact
> that the Thunderbolt controller isn't responsive during suspend.
>
> It seems worthwhile to me to skip pci_save_state() if the device isn't
> accessible, but I don't think it's a real solution to whatever is
> going on with Thunderbolt, and I don't think we should mention it here
> as though it is.

You're right that this patch doesn't fix the Thunderbolt problem
itself; that is what the Alpine Ridge quirk is for.  This patch only
makes sure that, when a device stops responding, the PCI core doesn't
save garbage and write it back later.  I'll rewrite the commit message
in v3 to say just that, and mention the MacBook only as the machine
where I found it.

> Maybe we should remove the check in pci_dev_save_and_disable() and
> make it check the return value of pci_save_state()?  I don't think
> checking twice adds anything.

Yes, I'll change it that way in v3.  While looking at it I found one
small corner case worth mentioning: pci_save_state() can also fail when
the kernel couldn't allocate memory for part of the saved state, back
when the device was first found.  The device itself works fine then,
but with this change the reset would no longer disable it first.  It is
very unlikely to happen, so I don't think it matters much, but if you
prefer, I can make the reset stop only when the device isn't
responding.

> I bet we get 99% of the usefulness here by just adding the first
> accessibility check above.
>
> This second check only helps if the device becomes inaccessible during
> the tiny window while we're saving its state, and I'm not sure that
> the extra complexity here and being able to restore a valid config
> header with junk in the capabilities is really a benefit.

I'll drop it in v3, so pci_save_state() goes back to what it was, plus
the one check at the start.

I also wanted to see how your version behaves before sending it, so I
built it and tested it on the MacBook today.  It went through four
suspend/resume cycles, three of them with a USB disk attached, with no
warnings, and it skipped the controller that wasn't responding, just
like v2 did.  I also reset a USB controller by hand to try the
pci_dev_save_and_disable() change, and that worked as before too.

Thanks again,
Francisco
