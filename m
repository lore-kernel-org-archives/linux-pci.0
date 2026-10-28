Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208673;
	b=w76UtRIu12tLiF57ppsMWdFM6kxQQMP++cEQ8rbfp3ovHKsXlihunLdh/ZQrpxWwHcg8
	 jro8LmqEPV8F/kQkY96vHwzyKaJWsb1XZGV3m+hi18C5QRfAoVZpGpM/THWVg3l5CibRu
	 3v4GmSuuG/TXsaXtGIcP5q6zK0d8qwCwkTJvJrUHo99aN0fA7axHqLlGVilgF++PDpG5O
	 eKAdO06Y0MtgGE9HgzEZLbA7zAYJPdklwKG1368F1XQT4jjkhK5pwdrsRie9TIdPLNPvs
	 B0mruTm1HHCqy00gpZJ1HyaxYr3M0VzRJUAveHHBaT+K19538Wv0DuU6RVueNODbkgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A+RGXs8/Ail6qHnGbLflY644jEJYQOYM38RZLvyetKE=;
	b=YxidSJ3ktcsuW7ramD8ldjmG2DnkfHWZ+feXo+FXPpUSTVDbhk+MDc55YrBbsCcLS+z1
	 97/YyVGgGCzN4zAAACqQF17hnHdW5qMdDyeDpymf3OnqMR5XxI0tyAqw2SXkLTKptLtX2
	 8mSsoMnT7qJb4q/zxIba8cx9Dvk0No2x4ooX8Yf3Mv64R4xaLVnYGpJR3xtJTvYwQYSso
	 k+wOnVHQoM0nCKu4dPKxPIPJZy9Bl/2pMFMBfVKG2gY56qn+guCnIqTjCchn/KGfUIeiR
	 Q66VmQJezj8lYWHKSWUu6IP9MzvPq+1dWtmHqMJZphz4kjoc9kfp2S1dyF8YZC6xlwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufleonBH;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18891606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 17:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18891606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufleonBH
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso955325f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793208671; x=1793813471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A+RGXs8/Ail6qHnGbLflY644jEJYQOYM38RZLvyetKE=;
        b=ufleonBH+H9d/tOno1mA/pxQ9SgKTe49I8fCqrQqRsv9NChzWGdaQBtCxPwlzBVOYp
         HEwR72xzxyezHU6WBAhtovrTrx3KqZMKdxC+/NdhAVnyda2XRk0XbVJSpDtsZYmQaSxW
         gryas7ImdzqPFK9J66feGiF0DibWyxN/9p/uhc4OBOGZySknSPXvWFlliQw9WfFmolXa
         6Ym4+ZsPc2TEFd0JvB+J0ZVQOmqnI7YI8y04jyEKQGD83c/vonoi/YbCtaJBhlBFuoX6
         Ms5PyHf+Vfc1ubEUq9EUBU3fXC6okM/Ic3olgmuBrF1Y/nvoxgkYAuT1pJ0Tt/AAoePE
         RoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208671; x=1793813471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A+RGXs8/Ail6qHnGbLflY644jEJYQOYM38RZLvyetKE=;
        b=zT2uLqIpYNfMNlKy21OMp4qeKDCVX1I1bJE9jAKXQxyK/gkpTukAZ3au7FgTNBfSq9
         dxFh8Y+PNJR9HU5p/quGwFSfXoPq30I/W+9TspJ5N1fCY6xe8Mo/YE0YXwZxRJqISA0X
         zrmiQ1I0q8Vqo4TmyZK6naNEX9noyEW94Q3ziRz8+yYjBMQl5eca80XuntX/fWIpiTF/
         7O/ukTx5DxYdEGLZjH2so5bv/INYJiBhRWA3E8rbhCjxGjCPJlyWW9dX3XUpu0tyfskD
         X1rTPWUOE+dm1NBicJIphcOOQFzrh9iyHl9cuA0QuyDuubF6bZYasT8ChRE/JM9eMp5N
         zt+g==
X-Forwarded-Encrypted: i=1; AKwUvBz9Ue+Mj9IkpBQURjBwbtQhovtc+uRggoJvl4W/pQjIXKMUo8z5rlLaFiECV6vHQ0JfaBag+L3wKxg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSDUoyrfywI47AngbslQJDJDyfaZTwKgRGcWOGfg1z3RkDWMiz
	MuxQZ5Ymoyeus9txVvNGHzISOKD5xVMpDSWALLmvvviYvmUQicH4q9G3
X-Gm-Gg: AYBFou3OAiLDXG9XAC1CE/zOU1tzXpUc14RYR1BcXvaZilku6lrk62Q2TQpp22nY0OZ
	69qBIAX4sYG0Wlj9jGVuxgatnnevlP58ZVIxvQahDNoSe+8cy8OQ5840e/Ghfz6BWHpLTePS/aA
	6EuMckI2/a7WRNMIZjgxDM77wyLsi6JCH1KInafN5W819w3eiMdDsPOCPy21jJuuJ6t0i+V/2lz
	5I8NsAIJ7Uph/IVjkCQLE73Dpx7To9nMz8SncDLhhMdM4Nku4BG4ddvDAfK2AaZ7B0dUd5MAW4+
	NIA4rsn/7o9QIUEUIzXkqhKfXhXmxaImUx234aZ2hExRl++Be+vRizrPX7D9nRCG2gsu5ngBGPp
	uIDnWoJPHLZ+pMJ3eQzsgvn1Hg1+MGo7jlGVNrNOd2CPXeRK468loOV0xS/reqx/uUh2phDxL+z
	kyqS+m6XppteqjCChkmg1Q87DKH7wYI2usywnlfhGWjbRfGl8zwM1e63FhtZ59YxluJs7J8+CTJ
	uhASWK8wnZTSc3ucOYsTsC8ZjCiZ7KzemcrLrRUkV7C2GT+05LnRyZPhoFLetpxjesfh1BNHfa7
	sRh6j/KLLX/xzMP2yhGtPwHeUXRiwqjoTFtKIBvwgl/u5GU1jOJq034cQUvp9ytdtaJbosjtQ6D
	8d0C1FTPil/X7Etl7x/rfqYmu9W2u/QBz7zzQB2rcdOCAuNDVyAAZmj+jR1fyk0KSB6k=
X-Received: by 2002:a5d:588a:0:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-48e5d58d590mr7802427f8f.3.1793208671431;
        Wed, 28 Oct 2026 10:31:11 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39a8sm30601206f8f.11.2026.10.28.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:31:10 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: iav@iav.lv
Cc: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com,
	robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is already valid
Date: Wed, 28 Oct 2026 17:31:08 +0000
Message-ID: <20261028173108.3457165-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028-h64-tpvperl-ab-skip@iav.lv>
References: <20260911211559.207990-1-ehbello@gmail.com> <179196286749.38040.5597453767131590054.b4-reply@b4> <20261016-h64-pcie-resume-tpvperl@iav.lv> <20261028005548.2399155-1-ehbello@gmail.com> <20261028-h64-tpvperl-ab-skip@iav.lv>
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

On Wed, 28 Oct 2026 05:10:00 +0000, Igor Velkov wrote:

> Since the next version keeps the full wait on resume, it no longer
> changes the resume path, so I'll skip the A/B and test that version
> on Helios64 instead: boots plus s2idle cycles, results in reply to it.

Thank you -- that coverage is worth a lot, but hold off a little, because the
shape is changing again.

Shawn Lin has asked for a DT property for the PERST# pulse rather than a
decision taken in the driver, matching rockchip,perst-inactive-ms and
rockchip,s2r-perst-inactive-ms in the vendor dwc driver, and I have agreed. So
the version to test is that one, not the probe-only patch I was about to send.

Whether the default changes or stays at PCIE_T_PVPERL_MS is still open, so I
will put the DT snippet to set on a Helios64 in the cover letter instead of
leaving it to guesswork.
