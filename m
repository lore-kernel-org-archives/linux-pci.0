Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2CF2D781B
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513655; cv=none; b=ShyEtxOUMwK/qT+fCCOYnCFazkSVhYsKAMTiAZYGukIYZz1uNnfu0S+XIe/6iy43wC41RolouCGTjQUnLLrKXi2riFRw80g+vlQs8gzYcJCIf9SWANQXDHmeM0Zd6htg68ypbpPHhCtqj/WNSNjWiVEcZs4ary4xxX+9DuUAtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513655; c=relaxed/simple;
	bh=t3YlafWr1SlDS/aVRT+Oh0oX9kedWLVnAi0UCAFiTB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A62y5vpabx4zKwbUdeWqfbVnmQHKTJPTDr9Sa8/QKclyqcmxvJAj7n6D6LLYZv2ynMso1q6VBJcf9gxV6F6hN/7dxv6wfy6CSWS/JB3o07JoaFnQma2MetaxUXBuIMgsoRVUtJi8dPyn2Li0IcLhxhNIa7RL6qNfZQVToenLS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l08jL6u/; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l08jL6u/"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso7593593eec.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791513653; x=1792118453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ys5AkoGHO+1zeYlBeqQfwpPRvZXflN1giC3pkuSBrsc=;
        b=l08jL6u/UB5CK6VAjEWts4uNebuxwgJIZX+0hbCBm+n0UHtfMgLxNFgMiZexmNpXSW
         oQrcVhvutIYSR3Ar1qV48y0NCWLQluCbyb5pvOWzeS18l93IgmI1rHFWqAv0FFO1fdCQ
         6Xp1xya7CBrE9KHx27FasPBHdys9Q874RnKc7gaMcxoHLrUFIIOZTn8CnvH6xAEt3pwx
         KYNqXSokCEDAs8mK8zV2a6HWDAF9WHmIpfC8L8k5SrZxV0ipFVbZPuzaQY00yzYvkat6
         v94i+3WaRAgG/yHNPI9YqFA68yGcjpvuKhJgOzhKKrFHnfo67s3l7FYJu47FpwgnCz53
         FGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791513653; x=1792118453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ys5AkoGHO+1zeYlBeqQfwpPRvZXflN1giC3pkuSBrsc=;
        b=BJ0tfOrBe342M3jmPQ0rgQCIlZPqr/zdqQatp/3HmGy9p7+AfklhKoIqEtms1WtG2m
         R9SfvSh7xQMgWZMmegQewT30YTCDWPBDOEheNLgc3t72XUCQAgpc6Fbj8VMJ13WNdVhQ
         dES+xZef2JKuDKLGgMredsSwo+EQ6YN7rbNaDqnJVnlAPoa34/RaUfSICrB3NeAFf48x
         vdwo7xUi/V8uNLaAdRQXgWT6GE/FHPWbcNNrlSaF2+IkDzayvifct0qEch7HQAQWF4B2
         wNfR8sCY26cm6CM0I3u+I8B/uHdOAKLud87/L1Sx2cOapgA7UkZ85PEGWYqu/e8ILMPD
         +m1A==
X-Forwarded-Encrypted: i=1; AKwUvBzI1Z4Zl7eN3kEYZc+A04FFRLKGhFa2J/9YnzY0RqcgGYRKNUOixt8tlLDjhWQ8ZZ1bsswbm/mF+50=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOgy1lUTIVrmkGa0sBv6+CvAqO3FPz9SwxWoo4By6qHi4cJwcm
	mi3NC+IL4/t9SHRFaRte9rzoIeRbz/VieyEYi+I5r6uAnoeu1k96fwVk
X-Gm-Gg: AYBFou1vZ6K8d2xhPqDjwuLqMZHNNFD5ETo8c+akTtiKJi+37ohiFRrdUFuM4oxCxzC
	6FKzt2aEYnHxrafoT/0Q8r1FNTgD2wL9Yo4skbicMh2vVcxKfJMAB96OVr6/y5wXbex+2U1PwYT
	or+uv4hCiVS3El61pXmiQr0rhp9nlgQ4vpHDW3JfD34mGBsIwxwT0unG6+odqjmQD0UL210tCBZ
	aZaCTEkCT0/NLAUd4HR6Ey43ZxXzYMNKhTHUK1Kg72JlHSvsrdCG8q/yOncDP9fozh789pTk7q9
	FuwQ/UbMxP9MPftrl3vkvE13vbhoeydttHkQx28+/uOeCTuJ3hgFTjv+xhvlh1d1h4FcELkGlGg
	CDCgxWTVAT6HLNvmmQHN/8PWn0gdHOeom3BoA6lX95oDB5H07OisM1aH3KcUsDJHbkdXCOQk5Bq
	JpbyW0R4BfYL1nKluWZDujXiK3CN4VIayfag6UkgAkohVP4tm7kpv4HL52pYeaXb5ZG8H/rM22A
	VQdT0EyKju+Bo4Fyk8=
X-Received: by 2002:a05:693c:415c:10b0:351:1133:8780 with SMTP id 5a478bee46e88-3537dfd18cfmr1128625eec.25.1791513653255;
        Thu, 08 Oct 2026 19:40:53 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm2228774eec.26.2026.10.08.19.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:40:52 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de
Subject: Re: [PATCH v2 0/3] PCI/PM: Do not save the config space of an inaccessible device
Date: Thu,  8 Oct 2026 23:40:38 -0300
Message-ID: <20261009024038.14888-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008223411.GA935963@bhelgaas>
References: <20261008223411.GA935963@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,

Thanks for reviewing the series.

On Thu, Oct 08, 2026 at 05:34:11PM -0500, Bjorn Helgaas wrote:
> If it would be safe to apply patches 2 and 3 without patch 1, I could
> go ahead and do that.
>
> Patch 2 returns errors from pci_save_state() in more cases, but
> hcd_pci_suspend_noirq() doesn't check for errors anyway, so I think
> it's would be no worse off it we applied patch 2 without patch 1.

I tested that combination on the MacBookPro14,3: patch 2 as you suggest
in your other reply, patch 1 disabled, the Alpine Ridge quirk applied,
and nothing plugged into one of the two Thunderbolt controllers.  The
system resumed normally.  The only difference was this warning, once
per boot:

  xhci_hcd 0000:07:00.0: Unable to change power state from D0 to D3hot, device inaccessible
  xhci_hcd 0000:07:00.0: PCI PM: State of device not saved by hcd_pci_suspend_noirq+0x0/0x1c0
  WARNING: CPU: 2 PID: 4344 at drivers/pci/pci-driver.c:888 pci_pm_suspend_noirq+0x2f4/0x300

hcd_pci_suspend_noirq() goes on to pci_prepare_to_sleep(), which fails
on the inaccessible controller and leaves it marked D3cold, and
pci_pm_suspend_noirq() then warns.  With patch 1 there is no warning.

So 2 and 3 can go in first, with patch 1 following through your tree
with an ack from Alan or Greg, or through the USB tree.  Patch 1 builds
on its own and has no effect in practice until patch 2 is in.

I'll send a v3 with your changes to patch 2.

Francisco
